
///ELECTRICAL STORM - explodes your computer and IPCs
/datum/overmap/event/electric
	name = "electrical storm (moderate)"
	desc = "A buildup of static electrity, an unfortunately common sight on the frontier. Disturbing it tends to lead to intense electrical discharges"
	base_icon_state = "electrical_medium_"
	default_color = "#e8e85c"
	chance_to_affect = 15
	spread_chance = 30
	interference_power = 15

	spread_types = list(
		/datum/overmap/event/electric = 40,
		/datum/overmap/event/electric/minor = 20,
		/datum/overmap/event/electric/major = 20
	)



	var/zap_flag = ZAP_STORM_FLAGS
	var/max_damage = 5000
	var/min_damage = 2500

/datum/overmap/event/electric/alter_token_appearance()
	icon_suffix = "[rand(1, 4)]"
	..()
	if(current_overmap.override_object_colors)
		token.color = current_overmap.hazard_primary_color
	current_overmap.post_edit_token_state(src)

/datum/overmap/event/electric/affect_ship(datum/overmap/ship/controlled/target_ship)
	var/datum/virtual_level/ship_vlevel = target_ship.shuttle_port.get_virtual_level()
	var/turf/source = ship_vlevel.get_side_turf(pick(GLOB.cardinals))
	tesla_zap(source, 32, rand(min_damage, max_damage), zap_flag)

	for(var/mob/poor_crew as anything in GLOB.player_list)
		if(target_ship.shuttle_port.is_in_shuttle_bounds(poor_crew))
			poor_crew.playsound_local(poor_crew, THUNDER_SOUND, rand(min_damage, max_damage))

	var/obj/machinery/power/cloak/cloaking_system = target_ship.ship_modules[SHIPMODULE_CLOAKING]
	if(cloaking_system?.cloak_active)
		cloaking_system.set_cloak(FALSE)
		cloaking_system.visible_message("[src] is overloaded by the electrical storm and shuts off!")

/datum/overmap/event/electric/modify_emptyspace_mapgen(datum/overmap/dynamic/our_planet)
	our_planet.weather_controller_type = /datum/weather_controller/shrouded
	return ..()

/datum/overmap/event/electric/minor
	name = "electrical storm (minor)"
	base_icon_state = "electrical_minor_"
	interference_power = 5
	spread_chance = 40
	max_damage = 2500
	min_damage = 1000
	spread_types = list(
		/datum/overmap/event/electric = 20,
		/datum/overmap/event/electric/minor = 40,
		/datum/overmap/event/electric/major = 10
	)


/datum/overmap/event/electric/major
	name = "electrical storm (major)"
	base_icon_state = "electrical_major_"
	interference_power = 30
	spread_chance = 15
	max_damage = 10000
	min_damage = 5000
	spread_types = list(
		/datum/overmap/event/electric = 20,
		/datum/overmap/event/electric/minor = 10,
		/datum/overmap/event/electric/major = 40
	)
