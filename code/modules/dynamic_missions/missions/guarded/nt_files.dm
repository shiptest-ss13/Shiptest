/obj/effect/landmark/mission_poi/nt_files
	icon_state = "main_docs"

/datum/mission/dynamic/simple/guarded/nt_files
	name = "NT asset recovery"
	faction = /datum/faction/nt
	setpiece_poi = /obj/effect/landmark/mission_poi/nt_files
	setpiece_item = /obj/item/documents/nanotrasen
	guard_type = /mob/living/simple_animal/hostile/human/syndicate/melee

/datum/mission/dynamic/simple/guarded/nt_files/generate_mission_details()
	name = pick("NT asset recovery", "Asset recovery requested ASAP")
	author = "Captain [random_species_name()]"
	desc = pick("Look- long story short, I need this folder retrieved. You don't ask why, I make sure you get paid.")

/datum/mission/dynamic/simple/guarded/nt_files/spawn_guard(obj/effect/landmark/mission_poi/guard_poi)
	guard_type = pick(/mob/living/simple_animal/hostile/human/syndicate/melee, /mob/living/simple_animal/hostile/human/syndicate/ranged)
	var/guard = guard_poi.use_poi(guard_type)
	return guard
