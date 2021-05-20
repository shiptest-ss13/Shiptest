/obj/structure/overmap/dynamic
	name = "weak energy signature"
	desc = "A very weak energy signal. It may not still be here if you leave it."
	icon_state = "strange_event"
	///The active turf reservation, if there is one
	var/datum/turf_reservation/reserve
	///The preset ruin template to load, if/when it is loaded.
	var/datum/map_template/template
	///The docking port in the reserve
	var/obj/docking_port/stationary/reserve_dock
	///The docking port in the reserve
	var/obj/docking_port/stationary/reserve_dock_secondary
	///If the level should be preserved. Useful for if you want to build an autismfort or something.
	var/preserve_level = FALSE
	///What kind of planet the level is, if it's a planet at all.
	var/planet
	///The virtual z-level the level occupies
	var/virtual_z_level

/obj/structure/overmap/dynamic/Initialize(mapload, _id)
	. = ..()
	choose_level_type()

/obj/structure/overmap/dynamic/Destroy()
	. = ..()
	QDEL_NULL(reserve)

/obj/structure/overmap/dynamic/ship_act(mob/user, obj/structure/overmap/ship/simulated/acting)
	var/prev_state = acting.state
	acting.state = OVERMAP_SHIP_DOCKING //This is so the controls are locked while loading the level to give both a sense of confirmation and to prevent people from moving the ship
	. = load_level(acting.shuttle)
	if(.)
		acting.state = prev_state
	else
		return acting.dock(src) //If a value is returned from load_level(), say that, otherwise, commence docking

/**
  * Chooses a type of level for the dynamic level to use.
  */
/obj/structure/overmap/dynamic/proc/choose_level_type()
	var/chosen = rand(0, 6)
	mass = rand(50, 100) * 1000000 //50 to 100 million tonnes
	switch(chosen)
		if(0)
			name = "weak energy signal"
			desc = "A very weak energy signal emenating from space."
			planet = FALSE
			icon_state = "strange_event"
			color = null
			mass = 0 //Space doesn't weigh anything
		if(1)
			name = "strange lava planet"
			desc = "A very weak energy signal originating from a planet with lots of seismic and volcanic activity."
			planet = DYNAMIC_WORLD_LAVA
			icon_state = "globe"
			color = COLOR_ORANGE
		if(2)
			name = "strange ice planet"
			desc = "A very weak energy signal originating from a planet with traces of water and extremely low temperatures."
			planet = DYNAMIC_WORLD_ICE
			icon_state = "globe"
			color = COLOR_BLUE_LIGHT
		if(3)
			name = "strange jungle planet"
			desc = "A very weak energy signal originating from a planet teeming with life."
			planet = DYNAMIC_WORLD_JUNGLE
			icon_state = "globe"
			color = COLOR_LIME
		if(4)
			name = "strange sand planet"
			desc = "A very weak energy signal originating from a planet with many traces of silica."
			planet = DYNAMIC_WORLD_SAND
			icon_state = "globe"
			color = COLOR_GRAY
		if(5 to 6)
			name = "large asteroid"
			desc = "A large asteroid with significant traces of minerals."
			planet = DYNAMIC_WORLD_ASTEROID
			icon_state = "asteroid"
			mass = rand(1, 1000) * 100
	desc += !preserve_level && "It may not still be here if you leave it."

/**
  * Load a level for a ship that's visiting the level.
  * * visiting shuttle - The docking port of the shuttle visiting the level.
  */
/obj/structure/overmap/dynamic/proc/load_level(obj/docking_port/mobile/visiting_shuttle)
	if(reserve)
		return
	if(!COOLDOWN_FINISHED(SSovermap, encounter_cooldown))
		return "WARNING! Stellar interference is restricting flight in this area. Interference should pass in [COOLDOWN_TIMELEFT(SSovermap, encounter_cooldown) / 10] seconds."
	var/datum/turf_reservation/new_reserve = SSovermap.spawn_dynamic_encounter(planet, TRUE, id, visiting_shuttle = visiting_shuttle, ruin_type = template)
	if(!new_reserve)
		return "FATAL NAVIGATION ERROR, PLEASE TRY AGAIN LATER!"
	reserve = new_reserve
	reserve_dock = SSshuttle.getDock("[PRIMARY_OVERMAP_DOCK_PREFIX]_[id]")
	reserve_dock_secondary = SSshuttle.getDock("[SECONDARY_OVERMAP_DOCK_PREFIX]_[id]")
	virtual_z_level = reserve.virtual_z_level

/**
  * Unloads the reserve, deletes the linked docking port, and moves to a random location if there's no client-having, alive mobs.
  */
/obj/structure/overmap/dynamic/proc/unload_level()
	if(preserve_level)
		return

	for(var/mob/living/L in GLOB.mob_living_list)
		if(!L.mind)
			continue
		if(SSmapping.get_turf_reservation_at_coords(L.x, L.y, L.z) == reserve)
			return //Don't fuck over stranded people

	if(reserve)
		if(SSovermap.generator_type == OVERMAP_GENERATOR_SOLAR)
			forceMove(SSovermap.get_unused_overmap_square_in_radius())
		else
			forceMove(SSovermap.get_unused_overmap_square())
		choose_level_type()
		QDEL_NULL(reserve)

/area/overmap_encounter
	name = "\improper Overmap Encounter"
	icon_state = "away"
	area_flags = HIDDEN_AREA | UNIQUE_AREA | CAVES_ALLOWED | FLORA_ALLOWED | MOB_SPAWN_ALLOWED | NOTELEPORT
	flags_1 = CAN_BE_DIRTY_1
	dynamic_lighting = DYNAMIC_LIGHTING_FORCED
	sound_environment = SOUND_ENVIRONMENT_STONEROOM
	ambientsounds = RUINS
	outdoors = TRUE

/area/overmap_encounter/planetoid
	name = "\improper Unknown Planetoid"
	sound_environment = SOUND_ENVIRONMENT_MOUNTAINS
	has_gravity = STANDARD_GRAVITY

/area/overmap_encounter/planetoid/lava
	name = "\improper Volcanic Planetoid"

/area/overmap_encounter/planetoid/ice
	name = "\improper Frozen Planetoid"
	sound_environment = SOUND_ENVIRONMENT_CAVE

/area/overmap_encounter/planetoid/sand
	name = "\improper Sandy Planetoid"
	sound_environment = SOUND_ENVIRONMENT_CARPETED_HALLWAY

/area/overmap_encounter/planetoid/jungle
	name = "\improper Jungle Planetoid"
	sound_environment = SOUND_ENVIRONMENT_FOREST
