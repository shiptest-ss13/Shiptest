/obj/effect/landmark/mission_poi/nt_files

/datum/dynamic_mission/simple/guarded/nt_files
	name = "NT asset recovery"
	desc = "We lost some really important files and we cant send the real guys in can you handle it?"
	setpiece_poi = /obj/effect/landmark/mission_poi/nt_files
	setpiece_item = /obj/item/documents/nanotrasen
	guard_type = /mob/living/simple_animal/hostile/human/syndicate/melee

/datum/dynamic_mission/simple/guarded/spawn_guard(obj/effect/landmark/mission_poi/guard_poi)
	guard_type = pick(/mob/living/simple_animal/hostile/human/syndicate/melee, /mob/living/simple_animal/hostile/human/syndicate/ranged)
	var/guard = new guard_type(guard_poi.loc)
	qdel(guard_poi)
	return guard
