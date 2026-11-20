# AI controllers

## Introduction

Our AI controller system is an attempt at making it possible to create modularized AI that stores its behavior in datums, while keeping state and decision making in a controller. This allows a more versatile way of creating AI that doesn't rely on OOP as much, and doesn't clutter up the Life() code in Mobs.

This file is the reference for how the system works. For a walkthrough of building something with it, see [learn_ai.md](learn_ai.md).

## AI Controllers

A datum that can be added to any atom in the game. Similarly to components, they might only support a given subtype (e.g. /mob/living), but the idea is that theoretically, you could apply a specific AI controller to as many different types as possible and it would still work.

These datums handle both the normal movement of mobs, but also their decision making, deciding which actions they will take based on the checks you put into their SelectBehaviors proc.

If behaviors are selected, and the AI is in range, it will try to perform them. It runs all the behaviors it currently has in parallel; allowing for it to for example screech at someone while trying to attack them. By default it won't plan again while behaviors are running. A behavior with `AI_BEHAVIOR_CAN_PLAN_DURING_EXECUTION` lets planning carry on while it runs, and any running behavior the new plan doesn't queue again is cancelled.

They also hold what their actions need to know, like cooldowns and who they're fighting. This lives on the blackboard, below.

### Blackboard
The blackboard is an associative list of string keys to values of whatever you want. Think of it as the AI controller's memory and settings: what it has found out, like who it's attacking and where it last saw them, alongside how it's set up, like how far it can see. Because all of this lives on the blackboard, behaviors hold no data of their own, and a behavior can work for many controllers by being told which key to use rather than having it hardcoded.

## AI Behavior
AI behaviors are the actions an AI can take. These can range from "Do an emote" to "Attack this target until it is dead". They are singletons and should contain nothing but static data. Any dynamic data should be stored in the blackboard, to allow different controllers to use the same behaviors.

## How a plan runs

Controllers plan every 0.5 seconds, or every second when no living player is on their virtual z-level. Each plan:

1. **Sensors** run, in order, updating the blackboard (who we're fighting, whether we can see them).
2. **Conditions** are worked out: `AI_CONDITION_*` flags for the pawn itself (standing somewhere unsafe, reloading) and from the blackboard (has a target, target seen or lost, taking cover). They're cached until the blackboard changes.
3. **Planning subtrees** run top to bottom. A subtree whose guard fails is skipped, and gets `on_skipped()` instead. One that returns `SUBTREE_RETURN_FINISH_PLANNING` stops the rest planning, unless nothing it queued would start, in which case the next subtree gets a go.
4. Every queued **behavior** that's ready runs that tick, so a mob can shoot while it moves.

## Sensors

`/datum/ai_sensor`, listed in a controller's `sensors`. They keep the blackboard up to date before anything plans, so every subtree works from the same picture instead of each one working it out again. Like subtrees and behaviors, they're shared between controllers, so keep per-mob state on the blackboard.

The two most mobs that fight want are `/datum/ai_sensor/update_combat_targets` (picks who to fight) and `/datum/ai_sensor/track_target` (whether we can see them, and where we last did).

## Guards

A subtree's guard is its `required_conditions` and `blocking_conditions`. All of the required flags must be true and none of the blocking ones, or the subtree doesn't plan at all. Put the cheap "should I even be thinking about this" check here instead of at the top of `SelectBehaviors()`. Use `on_skipped()` to clear any timers or keys the subtree was keeping while it ran.

The flags are defined in `code/__DEFINES/ai/ai.dm`, and worked out by `/datum/ai_controller/proc/get_conditions()`.

## Groups

`/datum/ai_planning_subtree/group` bundles subtrees that only make sense together under one guard, and plans them in order like the controller's own list. If one of them finishes planning, so does the group. Groups can hold groups. The shared ones are in `code/datums/ai/basic_mobs/basic_subtrees/groups.dm`.

## Sequences

`/datum/ai_planning_subtree/sequence` runs a list of `/datum/ai_sequence_step` one after another, like "step out of cover, fire for 1.5 seconds, step back" (`/datum/ai_planning_subtree/sequence/peek`). Each step queues one behavior and is done when that behavior succeeds, or after `duration` if set. A step gives up if its behavior fails, it passes `timeout`, or its own guard stops holding. Any of those ends the whole sequence, as does the sequence's own guard no longer holding.

- `can_start()` decides whether to go. `on_start()` puts what the steps need on the blackboard, or returns FALSE if it can't, like having nowhere to peek from. `on_end()` clears it up, whether the sequence finished or gave up.
- `start_delay`/`start_delay_max` stagger it, so mobs fighting together don't all go at once.
- `cooldown` spaces out repeats.
- While it runs, nothing below it plans. `finishes_planning = FALSE` lets subtrees below keep planning alongside it.
- If something higher priority takes over, the sequence gives up straight away rather than resuming later. When a subtree finishes planning, every subtree below it gets `on_preempted()`, which is where a sequence gives up. Groups pass it on to their own subtrees.

Unlike a group, whose subtrees all plan in order every time with nothing remembered, a sequence remembers its step on the blackboard and goes through them in order.

## Interrupts

Blackboard keys listed in a controller's `interrupt_keys` make it plan again straight away when they change, instead of waiting for the next tick. Human mobs interrupt on their target changing, coming into or out of sight, being shot at, and morale changes. An interrupt is just an early plan, so a running sequence continues, unless something higher priority takes over or its guard no longer holds.

## Behavior outcomes

The controller remembers how each behavior last ended on its own. `get_behavior_outcome()` returns TRUE if it succeeded, FALSE if it failed, or null if it hasn't ended, so a subtree can react to a move that couldn't find a path. `forget_behavior_outcome()` clears it before trying again.

A behavior fails when its `perform()` returns `AI_BEHAVIOR_FAILED`, or when the controller gives up on it, like when movement can't find a way there. Either way it records FALSE. A behavior that ends because the plan stopped queueing it hasn't failed, so it records nothing.

## Sleeping

A controller with nothing to do and no player on its virtual z-level goes to sleep and isn't processed at all. A player arriving on that level wakes it.

## Mob vars

Basic mobs have vars mappers and admins can set to tune their AI without touching the controller, like `vision_range`, `leash_distance` and `engage_distance` (see `code/modules/mob/living/basic/basic_ai_vars.dm`). They're copied onto the blackboard by `setup_ai()`, which a mob type has to call once its controller is made. Setting one back to null restores the controller's own value.

On a live mob, only the vars in `get_live_ai_vars()` take effect as soon as they're edited. The rest are only read during setup, so after editing one, pick **Rebuild AI** from the mob's VV dropdown. Setting `ai_controller` to an archetype's path rebuilds it by itself. When adding a var, list it in `get_live_ai_vars()` if it should work when edited live.

## Debugging

The VV dropdown on a mob or its controller has:

- **Show AI State**: current behaviors, conditions and blackboard.
- **Show AI Tree**: each subtree and whether it ran, was skipped and why, or took over.
- **Toggle AI Decision Logging**: prints what it decides as it plans.

Log from your own code with `AI_LOG_DECISION(controller, "text")`, which costs nothing unless logging is on. A mob's dropdown also has **Rebuild AI**, which throws the controller away and makes a fresh one, keeping the mob's home, and **Set AI Home**, which moves its home and asks whether it walks there and whether it keeps wandering.

## Rules of thumb

- Decide in the subtree, act in the behavior.
- Cheap checks before expensive ones. Every subtree runs for every awake mob twice a second, so most should do nothing most of the time.
- Subtrees, behaviors and sensors are shared, so per-mob state goes on the blackboard.
- Handle a behavior failing partway, not just finishing.

## Human NPCs

See [code/modules/mob/living/basic/human/README.md](../../modules/mob/living/basic/human/README.md) for mapping them, making new ones, and their archetypes.
