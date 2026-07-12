//Carp "meteors" - throws carp at the ship
//one day they'll be cooler
/datum/overmap/event/meteor/carp
	name = "carp migration (moderate)"
	desc = "A migratory school of space carp. They travel at high speeds, and flying through them may cause them to impact your ship"
	base_icon_state = "carp_medium_"
	default_color = "#7b1ca8"
	chance_to_affect = 15
	spread_chance = 50
	safe_speed = 5
	interference_power = 0
	meteor_types = list(
		/obj/effect/meteor/carp=16,
		/obj/effect/meteor/carp/big=1, //numbers I pulled out of my ass
	)
	primary_ores = null

	spread_types = list(
		/datum/overmap/event/meteor/carp = 40,
		/datum/overmap/event/meteor/carp/minor = 20,
		/datum/overmap/event/meteor/carp/major = 20
	)


/datum/overmap/event/meteor/carp/alter_token_appearance()
	icon_suffix = "[rand(1, 4)]"
	..()
	if(current_overmap.override_object_colors)
		token.color = current_overmap.hazard_primary_color
	current_overmap.post_edit_token_state(src)

/datum/overmap/event/meteor/carp/minor
	name = "carp migration (minor)"
	base_icon_state = "carp_minor_"
	chance_to_affect = 5
	spread_chance = 25
	meteor_types = list(
		/obj/effect/meteor/carp=8
	)

	spread_types = list(
		/datum/overmap/event/meteor/carp = 20,
		/datum/overmap/event/meteor/carp/minor = 40,
		/datum/overmap/event/meteor/carp/major = 10
	)


/datum/overmap/event/meteor/carp/major
	name = "carp migration (major)"
	base_icon_state = "carp_major_"
	chance_to_affect = 25
	spread_chance = 25
	meteor_types = list(
		/obj/effect/meteor/carp=7,
		/obj/effect/meteor/carp/big=1,
	)

	spread_types = list(
		/datum/overmap/event/meteor/carp = 30,
		/datum/overmap/event/meteor/carp/minor = 10,
		/datum/overmap/event/meteor/carp/major = 40
	)

