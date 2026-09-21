
///Electromagnetic - explodes your IPCs
/datum/overmap/event/emp
	name = "electromagnetic storm (moderate)"
	desc = "A heavily ionized area of space, prone to causing electromagnetic pulses in ships"
	base_icon_state = "emp_medium_"
	default_color = "#4066ff"
	spread_chance = 20
	chance_to_affect = 30
	interference_power = 100

	spread_types = list(
		/datum/overmap/event/emp = 40,
		/datum/overmap/event/emp/minor = 20,
		/datum/overmap/event/emp/major = 20
	)

	var/strength = 4

/datum/overmap/event/emp/alter_token_appearance()
	icon_suffix = "[rand(1, 4)]"
	..()
	if(current_overmap.override_object_colors)
		token.color = current_overmap.hazard_primary_color
	current_overmap.post_edit_token_state(src)

/datum/overmap/event/emp/affect_ship(datum/overmap/ship/controlled/ship)
	if(!(COOLDOWN_FINISHED(ship, event_cooldown)))
		return
	priority_announce("WARNING: Brace for inbound magnetic pulse.", "[src]", 'sound/effects/overmap/telegraph.ogg', sender_override = name, zlevel = ship.shuttle_port.virtual_z())

	addtimer(CALLBACK(src, PROC_REF(affect_ship_2), ship), 2 SECONDS)
	COOLDOWN_START(ship, event_cooldown, 5 SECONDS)

/datum/overmap/event/emp/proc/affect_ship_2(datum/overmap/ship/controlled/ship)
	if(!(locate(ship) in get_nearby_overmap_objects()))
		return

	var/area/source_area = pick(ship.shuttle_port.shuttle_areas)

	var/source_object = pick(source_area.contents)

	empulse(get_turf(source_object), round(rand(strength / 4, strength)), rand(strength, strength * 2))

	for(var/mob/living/carbon/affected_mob as anything in range(round(strength * 2), get_turf(source_object)))
		if(!istype(affected_mob))
			continue
		affected_mob.flash_act(1, 1)

	for(var/mob/affected_mob as anything in GLOB.player_list)
		if(ship.shuttle_port.is_in_shuttle_bounds(affected_mob))
			affected_mob.playsound_local(affected_mob, 'sound/effects/overmap/neutron_pulse.ogg', 100)

/datum/overmap/event/emp/modify_emptyspace_mapgen(datum/overmap/dynamic/our_planet)
	our_planet.weather_controller_type = /datum/weather_controller/shrouded
	return ..()

/datum/overmap/event/emp/minor
	name = "electromagnetic storm (minor)"
	base_icon_state = "emp_minor_"
	strength = 2
	chance_to_affect = 20
	interference_power = 80

	spread_types = list(
		/datum/overmap/event/emp = 20,
		/datum/overmap/event/emp/minor = 40,
		/datum/overmap/event/emp/major = 10
	)


/datum/overmap/event/emp/major
	name = "electromagnetic storm (major)"
	base_icon_state = "emp_major_"
	chance_to_affect = 40
	strength = 8
	interference_power = 200

	spread_types = list(
		/datum/overmap/event/emp = 20,
		/datum/overmap/event/emp/minor = 10,
		/datum/overmap/event/emp/major = 40
	)

