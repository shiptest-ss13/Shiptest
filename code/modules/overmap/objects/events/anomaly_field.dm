/datum/overmap/event/anomaly
	name = "anomaly field"
	desc = "A highly anomalous area of space, disturbing it leads to the manifestation of odd spatial phenomena"
	base_icon_state = "anomaly"
	default_color = "#d6c633"
	chance_to_affect = 10
	spread_chance = 35

	spread_types = list(/datum/overmap/event/anomaly = 100)

/datum/overmap/event/anomaly/Initialize(position, datum/overmap_star_system/system_spawned_in, set_lifespan, ...)
	. = ..()
	if(prob(50)) //only 50% chance of having interference
		interference_power = rand(20,60)

/datum/overmap/event/anomaly/alter_token_appearance()
	icon_suffix = "[rand(1, 4)]"
	..()
	if(current_overmap.override_object_colors)
		token.color = current_overmap.hazard_secondary_color
	current_overmap.post_edit_token_state(src)

/datum/overmap/event/anomaly/affect_ship(datum/overmap/ship/controlled/target_ship)
	var/area/source_area = pick(target_ship.shuttle_port.shuttle_areas)
	var/source_object = pick(source_area.contents)
	new /obj/effect/spawner/random/anomaly/storm(get_turf(source_object))
	for(var/mob/M as anything in GLOB.player_list)
		if(target_ship.shuttle_port.is_in_shuttle_bounds(M))
			M.playsound_local(M, 'sound/effects/bamf.ogg', 100)
