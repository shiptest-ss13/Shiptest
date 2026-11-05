# Human NPCs

Human NPCs are basic mobs on the AI controller framework. For how the framework works, see [code/datums/ai/README.md](../../../../../datums/ai/README.md), and for writing new subtrees and behaviors, [learn_ai.md](../../../../../datums/ai/learn_ai.md). This file covers setting up human NPCs themselves.

## Where things are

- `_human.dm`: the mob, with every var mappers and admins can set at the top, each with a comment saying what it does.
- `human_ai.dm`: the base controllers and the subtree groups every human plan shares.
- `human_archetypes.dm`: the archetypes built on those.
- `factions/`: the faction mobs, which are what gets placed on maps.
- `code/datums/ai/basic_mobs/basic_subtrees/groups.dm`: groups that aren't human-specific, like `cover`.

## Mapping

Most of the time you just place the mob you want, and it picks an archetype to suit its weapon. For more control, everything is a var edit on the placed mob:

- `holds_post` and `post_radius` keep a mob at its spot, fighting from cover within `post_radius` tiles of it. A mob with `wander = FALSE` and a marksman's rifle holds its post on its own. Set `holds_post = FALSE` to stop that. Some factions also have `/sentry` subtypes.
- `ai_controller` forces an archetype, by setting it to one of the paths in `human_archetypes.dm`.
- `grenade_type` and `grenade_count` make any mob a grenadier.
- `is_commander` makes a mob hang back and give orders, with nearby allies protecting it.
- `executes_downed` makes a mob finish off downed targets up close. It needs `stat_attack` past `CONSCIOUS`.
- `aim_zone_weights`, `settled_aim_zone_weights` and `aim_accuracy_mod` change where its shots land.
- `friendly_fire_tolerance` is the highest chance of hitting an ally a mob will still shoot at, worked out from its spread.
- `leash_distance`, `vision_range`, `engage_distance`, `retreat_distance`, `mobility`, `melee_reckless`, `stun_multiplier`, `morale_breaks`, `callout_set`, `on_aggro_say` and more, see the top of `_human.dm`.

`/obj/effect/mapping_helpers/ai_path_blocker` stops AI pathing through its tile, to keep them out of somewhere.

## A new mob

Subtype a faction mob and set its gear and vars. The Frontiersman demolitionist is an SKM trooper with dynamite:

```dm
/mob/living/basic/human/frontier/ranged/trooper/skm/demolitionist
	name = "Frontiersman Demolitionist"
	grenade_type = /obj/item/grenade/firecracker/dynamite
	grenade_count = 2
```

## A new archetype

An archetype is a controller with a few defaults on its blackboard and an ordered list of subtrees, with higher ones in the list planning first. Most of the list is shared groups, with the archetype's own subtrees in between. The marksman archetype is shown below as an example:

```dm
/datum/ai_controller/basic_controller/human/ranged/marksman
	blackboard = list(
		BB_TARGETTING_DATUM = new /datum/targetting_datum/basic,
		BB_BASIC_MOB_RETREAT_DISTANCE = 5,
		BB_BASIC_MOB_ENGAGE_DISTANCE = 8,
		BB_BASIC_MOB_HOLDS_POSITION = TRUE,
		BB_BASIC_MOB_FLANK_PRIORITY = 1,
	)
	planning_subtrees = list(
		/datum/ai_planning_subtree/group/human_opening,
		/datum/ai_planning_subtree/group/cover,
		/datum/ai_planning_subtree/flank/marksman,
		/datum/ai_planning_subtree/fighting_cover/when_outmatched,
		/datum/ai_planning_subtree/search_lost_target/marksman,
		/datum/ai_planning_subtree/group/human_ranged_closing,
	)
```

- `human_opening` goes first, and covers what comes before the fight: getting out of hazards and fires, investigating noises, heading home, calling allies, falling back and grenades.
- `human_ranged_closing` (or `human_melee_closing`) goes last, and covers the fight itself: reloading, positioning and the attack.
- Archetypes that hold a post use `human_post_opening` and `human_post_closing` instead, which never leave the post.
- In between is what makes the archetype different. When one only needs a small change to a shared subtree, subtype it, like `flank/marksman` going round only when someone else is keeping the target busy.

Mob vars like `engage_distance` override the archetype's blackboard defaults, so a mapper can still tune one mob without a new archetype.
