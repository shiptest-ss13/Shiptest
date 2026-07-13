
///SOLAR FLARE - Explodes your organics and IPCs
/datum/overmap/event/flare
	name = "solar flare (moderate)"
	desc = "A area with very high level of the local ejected mass from the sun, causing fires in ships"
	base_icon_state = "flare_medium_"
	default_color = "#f65f00"
	spread_chance = 20
	chance_to_affect = 20
	interference_power = 20

	spread_types = list(
		/datum/overmap/event/flare = 40,
		/datum/overmap/event/flare/minor = 20,
		/datum/overmap/event/flare/major = 20
	)

	var/strength = 4

/datum/overmap/event/flare/alter_token_appearance()
	icon_suffix = "[rand(1, 4)]"
	..()
	if(current_overmap.override_object_colors)
		token.color = current_overmap.hazard_primary_color
	current_overmap.post_edit_token_state(src)

/datum/overmap/event/flare/affect_ship(datum/overmap/ship/controlled/ship)
	if(!(COOLDOWN_FINISHED(ship, event_cooldown)))
		return
	priority_announce("WARNING: Brace for inbound solar flare.", "[src]", 'sound/effects/overmap/telegraph.ogg', sender_override = name, zlevel = ship.shuttle_port.virtual_z())

	addtimer(CALLBACK(src, PROC_REF(affect_ship_2), ship), 2 SECONDS)
	COOLDOWN_START(ship, event_cooldown, 5 SECONDS)

/datum/overmap/event/flare/proc/affect_ship_2(datum/overmap/ship/controlled/ship)
	if(!(locate(ship) in get_nearby_overmap_objects()))
		return

	var/area/source_area = pick(ship.shuttle_port.shuttle_areas)

	var/source_object = pick(source_area.contents)

	flame_radius(get_turf(source_object), round(rand(strength / 2, strength)), rand(strength, strength * 2))

	for(var/mob/living/carbon/affected_mob as anything in range(round(strength * 2), get_turf(source_object)))
		if(!istype(affected_mob))
			continue
		affected_mob.flash_act(1, 1)

	for(var/mob/affected_mob as anything in GLOB.player_list)
		if(ship.shuttle_port.is_in_shuttle_bounds(affected_mob))
			affected_mob.playsound_local(affected_mob, 'sound/effects/overmap/solar_flare.ogg', 100)

/datum/overmap/event/flare/modify_emptyspace_mapgen(datum/overmap/dynamic/our_planet)
	our_planet.weather_controller_type = /datum/weather_controller/lavaland
	return ..()

/datum/overmap/event/flare/minor
	name = "solar flare (minor)"
	base_icon_state = "flare_minor_"
	strength = 2
	chance_to_affect = 15
	interference_power = 15

	spread_types = list(
		/datum/overmap/event/flare = 20,
		/datum/overmap/event/flare/minor = 40,
		/datum/overmap/event/flare/major = 10
	)

/datum/overmap/event/flare/major
	name = "solar flare (major)"
	base_icon_state = "flare_major_"
	chance_to_affect = 60
	interference_power = 60
	strength = 8

	spread_types = list(
		/datum/overmap/event/flare = 20,
		/datum/overmap/event/flare/minor = 10,
		/datum/overmap/event/flare/major = 40
	)
