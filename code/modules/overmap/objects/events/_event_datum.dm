/**
 * # Overmap Events
 *
 * These are events that have some sort of effect on overmap ships that are on the same tile.
 */
/datum/overmap/event
	name = "generic overmap event"
	///determines the icon of the event
	var/base_icon_state
	///suffix of base_icon_state generated on init, usually 1-4
	var/icon_suffix
	///If prob(this), call affect_ship when processed
	var/chance_to_affect = 0
	///Chance to spread to nearby tiles if spawned
	var/spread_chance = 0
	///weighted list of event types that should be spawned during spread
	var/list/spread_types = list()
	///The mapgen we set ourself to when a ship docks to empty space over us
	var/datum/map_generator/empty_space_mapgen
	/// Override the mountain value of the mapgen to this value.
	var/mountain_height_override

/datum/overmap/event/Initialize(position, datum/overmap_star_system/system_spawned_in, set_lifespan,...)
	. = ..()
	SSovermap.events += src
	current_overmap.events += src
	alter_token_appearance()

	if(lifespan || set_lifespan)
		if(set_lifespan)
			lifespan = set_lifespan
		death_time = world.time + lifespan
		token.countdown = new /obj/effect/countdown/overmap_event(token)
		token.countdown.color = current_overmap.hazard_secondary_color

		token.countdown.start()
		START_PROCESSING(SSfastprocess, src)

/datum/overmap/event/Destroy()
	. = ..()
	SSovermap.events -= src
	current_overmap.events -= src
	if(lifespan)
		STOP_PROCESSING(SSfastprocess, src)

/datum/overmap/event/alter_token_appearance()
	token_icon_state = "[base_icon_state][icon_suffix]"
	return ..()

/datum/overmap/event/process()
	if(death_time < world.time && lifespan)
		qdel(src)

/**
 * The main proc for calling other procs. Called by SSovermap.
 */
/datum/overmap/event/proc/apply_effect()
	for(var/datum/overmap/ship/controlled/Ship in get_nearby_overmap_objects())
		if(prob(chance_to_affect))
			affect_ship(Ship)
	if(death_time < world.time && lifespan)
		qdel(src)

/**
 * The proc called on all ships that are currently being affected.
 */
/datum/overmap/event/proc/affect_ship(datum/overmap/ship/controlled/Ship)
	return

/**
 * The proc called to modify the empty space generation when it is spawned.
 */
/datum/overmap/event/proc/modify_emptyspace_mapgen(datum/overmap/dynamic/our_planet)
	if(!empty_space_mapgen)
		return
	our_planet.mapgen = empty_space_mapgen
