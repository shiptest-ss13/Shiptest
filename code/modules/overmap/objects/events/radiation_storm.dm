///RADIATION STORM - explodes your organics
/datum/overmap/event/rad
	name = "radiation storm (moderate)"
	desc = "An area with a high concentration of gamma rays. Better not take long here."
	base_icon_state = "gamma_medium_"
	default_color = "#d651c2"
	spread_chance = 20
	chance_to_affect = 60
	interference_power = 40

	spread_types = list(
		/datum/overmap/event/rad = 40,
		/datum/overmap/event/rad/minor = 20,
		/datum/overmap/event/rad/major = 20
	)


	var/strength = 20

/datum/overmap/event/rad/alter_token_appearance()
	icon_suffix = "[rand(1, 4)]"
	..()
	if(current_overmap.override_object_colors)
		token.color = current_overmap.hazard_primary_color
	current_overmap.post_edit_token_state(src)

/datum/overmap/event/rad/affect_ship(datum/overmap/ship/controlled/ship)
	for(var/mob/affected_mob as anything in GLOB.player_list)
		if(!isliving(affected_mob))
			return
		if(ship.shuttle_port.is_in_shuttle_bounds(affected_mob))
			affected_mob.rad_act(strength)
			to_chat(affected_mob, span_notice("You taste metal."))


/datum/overmap/event/rad/modify_emptyspace_mapgen(datum/overmap/dynamic/our_planet)
	our_planet.weather_controller_type = /datum/weather_controller/fallout
	return ..()

/datum/overmap/event/rad/minor
	name = "radiation storm (minor)"
	base_icon_state = "gamma_minor_"
	strength = 5
	interference_power = 20
	chance_to_affect = 40

	spread_types = list(
		/datum/overmap/event/rad = 20,
		/datum/overmap/event/rad/minor = 40,
		/datum/overmap/event/rad/major = 10
	)

/datum/overmap/event/rad/major
	name = "radiation storm (major)"
	base_icon_state = "gamma_major_"
	chance_to_affect = 80
	interference_power = 60
	strength = 60

	spread_types = list(
		/datum/overmap/event/rad = 20,
		/datum/overmap/event/rad/minor = 10,
		/datum/overmap/event/rad/major = 40
	)
