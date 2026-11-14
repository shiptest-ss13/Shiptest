
/datum/overmap/event/nebula
	name = "nebula"
	desc = "Beware of modular code."
	base_icon_state = "nebula"
	default_color = "#c053f3"
	spread_chance = 75
	chance_to_affect = 85

	interference_power = 50

	spread_types = list(
		/datum/overmap/event/nebula = 100
	)

	//list of ships we are currently affecting so we can stop flicking the lights when they leave
	var/list/affected_ships = list()

/datum/overmap/event/nebula/alter_token_appearance()
	. = ..()
	if(current_overmap.override_object_colors)
		token.color = current_overmap.hazard_secondary_color
	token.opacity = TRUE
	current_overmap.post_edit_token_state(src)

/datum/overmap/event/nebula/process()
	. = ..()
	var/list/nearby_objects = get_nearby_overmap_objects(include_docked = TRUE)
	var/datum/virtual_level/ship_vlevel

	for(var/datum/overmap/ship/controlled/ship as anything in affected_ships)
		if(!(ship in nearby_objects))

			ship_vlevel = ship.shuttle_port.get_virtual_level()
			affected_ships -= ship
			REMOVE_TRAIT(ship, TRAIT_CLOAKED, REF(src))

			for(var/obj/machinery/light/light_to_mess in GLOB.machines)
				if(light_to_mess.virtual_z() != ship_vlevel.id)
					continue
				light_to_mess.stop_flickering()

	if(affected_ships.len == 0)
		STOP_PROCESSING(SSfastprocess, src)

/datum/overmap/event/nebula/affect_ship(datum/overmap/ship/controlled/ship)
	var/datum/virtual_level/ship_vlevel = ship.shuttle_port.get_virtual_level()

	if(ship in affected_ships)
		return

	if(affected_ships.len == 0)
		START_PROCESSING(SSfastprocess, src)
	affected_ships += ship
	ADD_TRAIT(ship, TRAIT_CLOAKED, REF(src))


	for(var/obj/machinery/light/light_to_mess in GLOB.machines)
		if(light_to_mess.virtual_z() != ship_vlevel.id)
			continue
		light_to_mess.start_flickering()
