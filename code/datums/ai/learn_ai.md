# Learn AI

In ye olde days, we designed mob AI, and we built it into simple animals as they were the "non player controlled" mobs. Made sense at the time. But by coding AI directly into the mob, there was so little ability to make unique or complicated AI, and even when it was pulled off the code was hacky and non-reusable. The datum AI system was made to rectify these problems, and expand AI beyond just mobs.

This guide walks through building with it. For how the parts work under the hood, see [README.md](README.md).

## The pieces

- **The mob** says which controller it uses, and carries vars mappers can tweak.
- **The controller** holds the blackboard (what this mob knows) and lists its sensors and subtrees in order.
- **Sensors** update the blackboard before each plan: who to fight, can we see them.
- **Subtrees** decide what to do, by queueing behaviors. They run top to bottom, and any of them can stop the rest.
- **Behaviors** do something, like walk somewhere, shoot, reload.

Subtrees, behaviors and sensors are each a single shared instance for every mob that uses them, so anything that's about one mob goes on that mob's blackboard.

## The blackboard

Each controller has a `blackboard`, a list of keys (`BB_*` defines) to values. They record who it's fighting, where it last saw them, when to reload, and so on. Anything can read it, and subtrees, behaviors and sensors all write to it with `set_blackboard_key()` and `clear_blackboard_key()`. Because a behavior is told which keys to use rather than given values, one behavior can serve many subtrees, like `travel_towards` going wherever the key it was passed points. Keys a controller lists in its own `blackboard` are set from the start, and any others appear once something sets them. See [README.md](README.md) for more.

## A minimal mob

Let's start with the viscerator, as it's about as simple as a fighting mob gets.

The mob's `ai_controller` var is set to a controller type, in this case `/datum/ai_controller/basic_controller/viscerator`, and a new controller of that type is made for it when the mob spawns. Basic mobs have no AI of their own, unlike simple animals, so everything they decide comes from the AI controller.

This AI controller itself contains everything we need to define how the mob behaves. It contains the initial blackboard, interrupt keys, movement method, idle behavior, sensors and planning subtrees.

```dm
/mob/living/basic/viscerator
	// ...the usual mob vars...
	ai_controller = /datum/ai_controller/basic_controller/viscerator

/mob/living/basic/viscerator/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_MOVE_FLYING, ROUNDSTART_TRAIT)
	AddComponent(/datum/component/swarming)
	AddElement(/datum/element/ai_reacts_to_harm)
	AddElement(/datum/element/ai_hears_gunfire)
	setup_ai()

/datum/ai_controller/basic_controller/viscerator
	blackboard = list(
		BB_TARGETTING_DATUM = new /datum/targetting_datum/basic,
	)
	interrupt_keys = list(
		BB_BASIC_MOB_CURRENT_TARGET,
		BB_BASIC_MOB_TARGET_IN_SIGHT,
		BB_BASIC_MOB_LAST_SHOT_TIME,
	)
	ai_movement = /datum/ai_movement/jps
	idle_behavior = /datum/idle_behavior/idle_random_walk
	sensors = list(
		/datum/ai_sensor/update_combat_targets,
		/datum/ai_sensor/track_target,
	)
	planning_subtrees = list(
		/datum/ai_planning_subtree/return_home,
		/datum/ai_planning_subtree/search_lost_target,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
	)
```

Going through the above example:

- `BB_TARGETTING_DATUM` decides who is an enemy. `update_combat_targets` uses it to pick a target, and `track_target` keeps note of whether we can see them and where we last did.
- `interrupt_keys` make it plan again straight away when its target changes, comes into or out of sight, or it gets shot at, instead of waiting up to half a second.
- `ai_movement/jps` finds paths around walls and through doors, and avoids hazards. `ai_movement/basic_avoidance` and `ai_movement/dumb` are cheaper, for mobs that don't need it.
- `idle_behavior` is what it does when nothing's planned, here wandering about.
- `ai_traits` (not used here) are flags that tweak the controller, like `STOP_MOVING_WHEN_PULLED`.
- The subtrees, in order: get back home if it's strayed too far, go looking where it last saw its target, and attack it.
- The two elements let it react to being hurt or shot at from out of sight, and to hearing gunfire.
- `setup_ai()` copies the mob's AI vars (`vision_range`, `leash_distance` and so on, see `code/modules/mob/living/basic/basic_ai_vars.dm`) onto the blackboard. Without it, those vars do nothing.

## Giving it a gun

Say we want a viscerator that shoots instead, and reloads its magazine between fights. Nothing new is needed, just two components and two more subtrees:

```dm
/mob/living/basic/viscerator/gunner
	ai_controller = /datum/ai_controller/basic_controller/viscerator/gunner

/mob/living/basic/viscerator/gunner/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/ranged_attacks, /obj/item/ammo_casing/c9mm)
	AddComponent(/datum/component/ai_magazine, magazine_size = 12)

/datum/ai_controller/basic_controller/viscerator/gunner
	planning_subtrees = list(
		/datum/ai_planning_subtree/return_home,
		/datum/ai_planning_subtree/search_lost_target,
		/datum/ai_planning_subtree/tactical_reload,
		/datum/ai_planning_subtree/basic_ranged_attack_subtree,
	)
```

- `ranged_attacks` lets it shoot, and `ai_magazine` counts its shots so it has to reload.
- The controller inherits the viscerator's blackboard, sensors and interrupts, and only swaps its subtrees.
- `tactical_reload` goes above the attack, so when there's nobody in sight it gets the chance to reload first.

The next sections open up `tactical_reload` to show how a subtree and its behavior are written.

## Writing a subtree

A subtree is the decision that leads to actions. The gunner's `tactical_reload` decides when to swap a part-empty magazine, once it's out of active combat:

```dm
// for partial reloads during quiet periods
/datum/ai_planning_subtree/tactical_reload
	blocking_conditions = AI_CONDITION_TARGET_SEEN // in the middle of a fight
	// only do this after no enemy in sight for this long
	var/minimum_delay = 2 SECONDS
	// so multiple mobs dont reload at the same time
	var/random_delay = 3.5 SECONDS

/datum/ai_planning_subtree/tactical_reload/on_skipped(datum/ai_controller/controller)
	controller.clear_blackboard_key(BB_BASIC_MOB_TACTICAL_RELOAD_AT)

/datum/ai_planning_subtree/tactical_reload/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	. = ..()
	var/datum/component/ai_magazine/magazine = controller.pawn.GetComponent(/datum/component/ai_magazine)
	if(!magazine?.needs_reload())
		controller.clear_blackboard_key(BB_BASIC_MOB_TACTICAL_RELOAD_AT)
		return
	var/reload_at = controller.blackboard[BB_BASIC_MOB_TACTICAL_RELOAD_AT]
	if(isnull(reload_at))
		controller.set_blackboard_key(BB_BASIC_MOB_TACTICAL_RELOAD_AT, world.time + minimum_delay + rand(0, random_delay))
		return
	if(world.time < reload_at)
		return
	controller.clear_blackboard_key(BB_BASIC_MOB_TACTICAL_RELOAD_AT)
	controller.queue_behavior(/datum/ai_behavior/tactical_reload)
```

- **The guard.** `blocking_conditions` keeps it out of fights without any code of its own. The moment a target comes into view, the subtree is skipped and `on_skipped()` throws away its timer. Guards are cheap, so use them for the "should I even be thinking about this" check.
- **Blackboard timers** are how most subtrees wait. The first plan that finds a reload needed stores a `world.time` in `BB_BASIC_MOB_TACTICAL_RELOAD_AT`, 2 to 5.5 seconds off (`minimum_delay` plus up to `random_delay`). Each plan after that does nothing until that time passes, then clears the key and queues the reload. The random part stops mobs from all reloading at once.
- **It doesn't stop planning.** It returns nothing, so the gunner's `basic_ranged_attack_subtree` below still plans, and if an enemy turns up while it's waiting to reload, the attack picks them up straight away. Returning `SUBTREE_RETURN_FINISH_PLANNING` would shut the attack out until the reload was done. That's only right when nothing below should get a say, like `put_out_fire`: when the mob's burning, putting it out comes first.

Where it goes in the controller's list matters: higher plans first, and can stop everything below.

## Writing a behavior

A behavior acts on what the subtree decided. Below is an example of a simple behavior:

```dm
/datum/ai_behavior/tactical_reload

/datum/ai_behavior/tactical_reload/perform(seconds_per_tick, datum/ai_controller/controller)
	var/datum/component/ai_magazine/magazine = controller.pawn.GetComponent(/datum/component/ai_magazine)
	if(!magazine?.start_reload(tactical = TRUE))
		return AI_BEHAVIOR_INSTANT | AI_BEHAVIOR_FAILED
	return AI_BEHAVIOR_INSTANT | AI_BEHAVIOR_SUCCEEDED
```

`perform()` returns flags: `AI_BEHAVIOR_SUCCEEDED` or `AI_BEHAVIOR_FAILED` to finish, `AI_BEHAVIOR_DELAY` to go again after `action_cooldown`, or `AI_BEHAVIOR_INSTANT` to go again next tick.

Behaviors that need to get somewhere first set a movement target in `setup()`, and the controller walks there before calling `perform()`. `travel_towards` is the simplest, and it's what `peek` below uses to step out of cover:

```dm
/datum/ai_behavior/travel_towards
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT | AI_BEHAVIOR_CAN_PLAN_DURING_EXECUTION
	required_distance = 0 // right onto it
	action_cooldown = 0

/datum/ai_behavior/travel_towards/setup(datum/ai_controller/controller, target_key)
	. = ..()
	if(!move_to_key(controller, target_key))
		return FALSE

/datum/ai_behavior/travel_towards/perform(seconds_per_tick, datum/ai_controller/controller, target_key)
	return AI_BEHAVIOR_INSTANT | AI_BEHAVIOR_SUCCEEDED // only performed once we're within required_distance

/datum/ai_behavior/travel_towards/finish_action(datum/ai_controller/controller, succeeded, target_key)
	. = ..()
	stop_our_movement(controller)
```

- `setup()` returning FALSE refuses to start the behavior, like having nowhere to go. The subtree that queued it with `controller.queue_behavior()` gets FALSE back, so it can try something else.
- `AI_BEHAVIOR_REQUIRE_MOVEMENT` waits until within `required_distance` before performing. Add `AI_BEHAVIOR_MOVE_AND_PERFORM` to perform while still on the way, like shooting on the move.
- `AI_BEHAVIOR_CAN_PLAN_DURING_EXECUTION` lets the controller keep planning while it runs. Without it, the mob is committed until it finishes. Anything still running that a new plan doesn't queue again gets cancelled.
- Arguments after the behavior type in `queue_behavior()` are passed on to `setup()`, `perform()` and `finish_action()`. In `controller.queue_behavior(/datum/ai_behavior/travel_towards, BB_BASIC_MOB_HOME_TURF)`, the key `BB_BASIC_MOB_HOME_TURF` becomes `target_key` above, and the behavior looks up the turf it holds. Pass keys rather than values, so one behavior can serve many subtrees.
- Subtrees queue their behavior again every plan. If it's already running with the same arguments, it just carries on. With different arguments, or a movement behavior whose target key now holds something else, it's set up again from scratch.

A subtree can check how a behavior last ended with `controller.get_behavior_outcome(type)`, like trying somewhere else when a move found no path. Movement giving up counts as the behavior failing, but a behavior cancelled because the plan stopped queueing it records nothing.

## Writing a sensor

When several subtrees all need the same fact worked out, like "can we see our target", work it out once in a sensor rather than in each of them:

```dm
/datum/ai_sensor/my_sensor/sense(datum/ai_controller/controller, seconds_per_tick)
	controller.set_blackboard_key(BB_SOME_KEY, work_it_out(controller.pawn))
```

Sensors run in the order the controller lists them, before any subtree, so later sensors can use what earlier ones found. Keep them cheap, as they run every plan for every awake mob.

## Groups

When a few subtrees only make sense together, we can bundle them in a `/datum/ai_planning_subtree/group` under one guard, rather than repeating the same conditions on each:

```dm
/datum/ai_planning_subtree/group/positioning
	required_conditions = AI_CONDITION_HAS_TARGET
	// in cover from being shot at, or fighting from behind it
	blocking_conditions = AI_CONDITION_TAKING_COVER | AI_CONDITION_FIGHTING_FROM_COVER
	subtrees = list(
		/datum/ai_planning_subtree/reposition,
		/datum/ai_planning_subtree/maintain_distance,
	)
```

- The group's guard sits on top of each subtree's own. When it stops holding, every subtree in it is skipped and gets its `on_skipped()`.
- The subtrees plan in order, like the normal controller subtree list, and if one finishes planning, so does the group.
- Groups can hold groups. A controller lists a group like any other subtree.
- The shared ones are in `code/datums/ai/basic_mobs/basic_subtrees/groups.dm`: `survival`, `positioning` and `cover`.

## Sequences

For when we want to tell a mob to "do this, then that, then the other", we can subclass `/datum/ai_planning_subtree/sequence`.

```dm
/datum/ai_planning_subtree/sequence/peek
	required_conditions = AI_CONDITION_TAKING_COVER | AI_CONDITION_HAS_RANGED_ATTACK
	blocking_conditions = AI_CONDITION_RELOADING
	finishes_planning = FALSE
	// how long we sit in cover between peeks, random so a group doesn't all pop out at once
	start_delay = 3 SECONDS
	start_delay_max = 5 SECONDS
	steps = list(
		/datum/ai_sequence_step/peek_out,
		/datum/ai_sequence_step/peek_fire,
		/datum/ai_sequence_step/peek_return,
	)

/datum/ai_sequence_step/peek_out
	behavior_type = /datum/ai_behavior/travel_towards
	behavior_arguments = list(BB_BASIC_MOB_PEEK_TURF)
	timeout = 3 SECONDS

/datum/ai_sequence_step/peek_fire
	behavior_type = /datum/ai_behavior/fire_at_position
	behavior_arguments = list(BB_BASIC_MOB_SHOT_FROM)
	duration = 1.5 SECONDS
```

- `on_start()` finds the spot to peek from and puts it on the blackboard as `BB_BASIC_MOB_PEEK_TURF`. `on_end()` clears it, whether the sequence finished or gave up.
- A step is done when its behavior succeeds, or after `duration` if it has one. It gives up if the behavior fails (which includes movement giving up on getting there), it runs past `timeout`, or its own `required_conditions`/`blocking_conditions` stop holding.
- If the sequence's own guard stops holding partway, it ends there, so a mob that loses its cover doesn't carry on peeking.
- While it runs, nothing below it in the plan gets to plan, so it has the mob to itself. `peek` sets `finishes_planning = FALSE` so the subtrees below can keep shooting and reloading around it.
- It can't stop anything above it. If a subtree higher up finishes planning, like fleeing a grenade, the sequence's behavior is cancelled and it gets `on_preempted()`, so it gives up there and then, running `on_end()`, rather than picking up a now stale step. It can start again fresh once its `cooldown` and `start_delay` allow.

### Group or sequence?

- A group remembers nothing. Every plan, its subtrees run in order and each does whatever fits right now, so what it does can change from one plan to the next.
- A sequence remembers which step it's on, and works through them in order across plans, one behavior at a time, until it finishes, gives up, or something above it takes over.
- When a group's guard stops holding, its subtrees are skipped and tidy up. When a sequence's guard stops holding, the sequence ends and its `on_end()` runs.

Use a group for "these belong together, under one guard, each doing whatever fits right now", and a sequence for "this, then that".

## What you can reuse

Most of the subtrees, components and elements made for human NPCs don't care what the mob is. They read the blackboard and the mob's components.

Work on any basic mob:

- `seek_cover`, `sequence/peek`, `fighting_cover`, `flank`, `reposition`, `maintain_distance`, `suppress_dug_in`. The shooting ones need `/datum/component/ranged_attacks`.
- `search_lost_target`, `return_home`, `investigate_noise`, `call_allies`, `wait_out_unreachable`, `smash_towards_target`, `smash_when_stuck`.
- `flee_explosives`, `seek_safe_environment`. Pressure and tear gas checks only count for humans, as other mobs go by `habitable_atmos`.
- `tactical_reload`, with `/datum/component/ai_magazine`.
- `throw_grenade`. On non-humans the grenade may float next to them.
- `ai_morale`, `ai_dodging`, `ai_magazine`, `ai_flashlight`.
- `ai_callouts`. Last words over the corpse are human-only.
- `ai_reacts_to_harm`, `ai_hears_gunfire`, `ai_door_opener`.

Human only:

- `put_out_fire` does nothing for non-humans.
- `execute_downed` needs a human with a gun and a carbon victim.

Before reusing a subtree, check which blackboard keys it reads, and make sure something (a sensor, a mob var, or the controller's starting `blackboard`) sets them.

## Debugging

VV the mob, and from the dropdown:

- **Show AI Tree** shows every subtree in its plan, and whether each ran, was skipped and why, or took over. Start here when a mob isn't doing something.
- **Show AI State** shows what it's doing, its conditions and its blackboard.
- **Toggle AI Decision Logging** prints what it decides as it plans. Add your own with `AI_LOG_DECISION(controller, "text")`, which costs nothing while logging's off.
- **Rebuild AI** throws the controller away and makes a fresh one, for after editing vars only read at setup, or when it's got itself into a state.
- **Set AI Home** moves where it heads back to and leashes from: where you're standing, where it stands, or coordinates on its level. It asks whether the mob walks there or is moved now, and whether it keeps wandering when idle.

## Rules of thumb

- Decide in the subtree, act in the behavior.
- Cheap checks before expensive ones. Every subtree runs for every awake mob twice a second, so most should do nothing most of the time.
- Subtrees, behaviors and sensors are shared, so per-mob state goes on the blackboard.
- Handle a behavior failing partway, not just finishing.
- Clear what you set. Anything a subtree puts on the blackboard while it runs should come off in `on_skipped()` or when it's done, or the next time it runs will start from stale state.
