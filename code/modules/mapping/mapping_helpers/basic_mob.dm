///Basic mob flag helpers for things like deleting on death.
/obj/effect/mapping_helpers/basic_mob_flags
	name = "Basic mob flags helper"
	desc = "Used to apply basic_mob_flags to basic mobs on the same turf."
	late = TRUE

	///The basic mob flag that we're adding to all basic mobs on the turf.
	var/flag_to_give

/obj/effect/mapping_helpers/basic_mob_flags/Initialize(mapload)
	. = ..()
	if(!mapload)
		log_mapping("[src] spawned outside of mapload!")
		return INITIALIZE_HINT_QDEL

/obj/effect/mapping_helpers/basic_mob_flags/LateInitialize()
	var/had_any_mobs = FALSE
	for(var/mob/living/basic/basic_mobs in loc)
		had_any_mobs = TRUE
		basic_mobs.basic_mob_flags |= flag_to_give
	if(!had_any_mobs)
		CRASH("[src] called on a turf without any basic mobs.")
	qdel(src)

/obj/effect/mapping_helpers/basic_mob_flags/del_on_death
	name = "Basic mob del on death flag helper"
	icon_state = "basic_mob_del_on_death"
	flag_to_give = DEL_ON_DEATH

/*
/obj/effect/mapping_helpers/basic_mob_flags/flip_on_death
	name = "Basic mob flip on death flag helper"
	icon_state = "basic_mob_flip_on_death"
	flag_to_give = FLIP_ON_DEATH

/obj/effect/mapping_helpers/basic_mob_flags/remain_dense_while_dead
	name = "Basic mob remain dense while dead flag helper"
	icon_state = "basic_mob_remain_dense_while_dead"
	flag_to_give = REMAIN_DENSE_WHILE_DEAD

/obj/effect/mapping_helpers/basic_mob_flags/flammable_mob
	name = "Basic mob flammable flag helper"
	icon_state = "basic_mob_flammable"
	flag_to_give = FLAMMABLE_MOB

/obj/effect/mapping_helpers/basic_mob_flags/immune_to_fists
	name = "Basic mob immune to fists flag helper"
	icon_state = "basic_mob_immune_to_fists"
	flag_to_give = IMMUNE_TO_FISTS

/obj/effect/mapping_helpers/basic_mob_flags/immune_to_getting_wet
	name = "Basic mob immune to getting wet flag helper"
	icon_state = "basic_mob_immune_to_getting_wet"
	flag_to_give = IMMUNE_TO_GETTING_WET
*/
