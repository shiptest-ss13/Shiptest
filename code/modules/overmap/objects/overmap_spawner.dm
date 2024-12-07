/obj/item/overmap_punchcard_spawner
	name = "helm console punchcard"
	desc = "A piece of paper with carfully organized holes through it."
	gender = NEUTER
	icon = 'icons/obj/bureaucracy.dmi'
	icon_state = "punchcard"

	/// What should we name the planet on the overmap?
	var/encounter_name = "scrungled planetoid"
	/// What coords do we want to spawn this encounter in? if null we spawn it randomly
	var/position
	///What object do we spawn?
	var/datum/overmap/object_to_spawn

/obj/item/overmap_punchcard_spawner/examine(mob/user)
	. = ..()
	. += span_notice("You could probably scan this with a helm console to locate a hidden overmap object.")

/obj/machinery/computer/helm/attackby(obj/item/key, mob/living/user, params)
	. = ..()
	var/obj/item/overmap_punchcard_spawner/punchcard

	// Is this thing a punchcard?
	if(istype(key, /obj/item/overmap_punchcard_spawner))
		punchcard = key
		//flavor
		say("Scanning punchcard, please wait...")
		if(do_after(user, 10 SECONDS))
			//We then run the create encounter on the punchcard, and copy that over to the helm console
			var/datum/overmap/dynamic/spawned_encounter = punchcard.create_encounter(current_ship.current_overmap)
			// if we for some reason failed to, we tell the player so.
			if(!spawned_encounter)
				say("Failed to scan punchcard. Please try again later or contact your nearest computer technician.")
				return
			// if we did, we tell the player the coordinate, hope they remember, and then delete the punchcard to prevent spam
			say("Located hidden location. Location is X[spawned_encounter.x], Y[spawned_encounter.y].")
			qdel(punchcard)
		// They moved after the do_after...
		else
			say("Failed to scan punchcard. Please do not move while scanning a punchcard.")

/obj/item/overmap_punchcard_spawner/proc/create_encounter(datum/overmap_star_system/current_overmap)
	//if no or an invalid overmap is passed onto the proc, nope the hell out
	if(!istype(current_overmap))
		CRASH("Invalid Overmap passed to punchcard generation! Aborting!")
	// if position is none we get a random square
	if(!position)
		position = current_overmap.get_unused_overmap_square()

	// we then create the actual overmap datum
	var/datum/overmap/encounter = new object_to_spawn(position, current_overmap)

	// If all went well we return the encounter
	return encounter

// ** DYNAMIC OBJECTS **//

/obj/item/overmap_punchcard_spawner/dynamic
	name = "dynamic helm console punchcard"

	/// What should we name the planet on the overmap?
	encounter_name = "scrungled planetoid"
	///What should the planet be called when it's landed on?
	var/planet_name = "Mappeious Goofius Upper"
	/// What planet type do we spawn? By default its reebe just so it's obvious when something's gone wrong
	var/planet_type = /datum/planet_type/reebe
	/// Do we want ruins? If true and ruin_force is not set, we spawn a random ruin. NOTE: If FALSE up to four ships can dock to the encounter
	var/spawn_ruins = FALSE
	/// What ruin do we want to spawn? If none, we randomize unless above was set to random
	var/datum/map_template/ruin_force
	/// What coords do we want to spawn this encounter in? if null we spawn it randomly
	position
	/// Do we want to keep the planet after all sentient players have left? If set to false it DESTROYS the planet when every sentient player has left!
	var/preserve_level = TRUE

	///What object do we spawn? In case of subtypes.
	object_to_spawn = /datum/overmap/dynamic

/obj/item/overmap_punchcard_spawner/dynamic/create_encounter(datum/overmap_star_system/current_overmap)
	//if no or an invalid overmap is passed onto the proc, nope the hell out
	if(!istype(current_overmap))
		CRASH("Invalid Overmap passed to punchcard generation! Aborting!")
	// if position is none we get a random square
	if(!position)
		position = current_overmap.get_unused_overmap_square()

	// we then create the actual overmap datum
	var/datum/overmap/dynamic/encounter = new object_to_spawn(position, current_overmap, FALSE)

	//... which we  then set the force encounter var to the planet type we want
	encounter.force_encounter = planet_type

	//... Then we make the datum copy the planet info from the planet_type
	encounter.choose_level_type(FALSE)

	//if we put a custom overmap encounter name we set it here
	if(encounter_name)
		encounter.name = encounter_name

	// similarly, the name that shows up when you landed on said planet
	if(planet_name)
		encounter.planet_name = planet_name

	// we then handle ruins. If spawn ruins is set to false then we clear the ruin list, preventing any ruins from spawning
	if(!spawn_ruins)
		encounter.ruin_type = null

	//... But if we DO want ruins to spawn, AND if there is a forced ruin, we set the template to spawn to that
	else if(ruin_force)
		encounter.template = ruin_force

	// we then set our preserve_level to the datum's
	encounter.preserve_level = preserve_level

	//... We DON'T load level until the player docks there as theres no gurantee they will land there, and that would cause unessary lag.
	//encounter.load_level()

	//we then update the sprite so our custom stuff shows up
	encounter.alter_token_appearance()

	// If all went well we return the encounter
	return encounter

//basetype for mission punchcards, this has the tells for an improperly set punchcard removed for use by missions
/obj/item/overmap_punchcard_spawner/dynamic/mission
	encounter_name = null
	planet_name = null
	planet_type = /datum/planet_type/lava
	preserve_level = FALSE

// ** STATIC OBJECTS **//

/obj/item/overmap_punchcard_spawner/static_overmap
	name = "static helm console punchcard"

	/// What should we name the object on the overmap?
	encounter_name = "scrungled planetoid"
	/// What coords do we want to spawn this encounter in? if null we spawn it randomly
	position
	///What should the object be called when it's landed on?
	var/planet_name = "Mappeious Goofius Upper"
	/// What mapgen type do we use before loading the map on top? Not recomnended, but you have the option to
	var/mapgen

	///Do we want this object to have gravity?
	var/gravity = TRUE
	///The border size to use. It's recommended to set this to 0 if you  use up the entirety of the allocated space (eg. 255x255 map where theres no bordering map levels)
	var/border_size = QUADRANT_SIZE_BORDER
	///What map does this load? If none expect pain
	var/datum/map_template/map_to_load
	///The weather this object will have.
	var/datum/weather_controller/weather_controller_type

	///If true, we will load a new z level instead of using reserve mapzone. DO THIS IF YOUR MAP IS OVER 255x255 LARGE
	var/load_seperate_z

	/// Do we want to keep the planet after all sentient players have left? If set to false it DESTROYS the planet when every sentient player has left!
	var/preserve_level = TRUE

	///What object do we spawn? In case of subtypes.
	object_to_spawn = /datum/overmap/static_object

/obj/item/overmap_punchcard_spawner/static_overmap/create_encounter(datum/overmap_star_system/current_overmap)
	//if no or an invalid overmap is passed onto the proc, nope the hell out
	if(!istype(current_overmap))
		CRASH("Invalid Overmap passed to punchcard generation! Aborting!")
	// if position is none we get a random square
	if(!position)
		position = current_overmap.get_unused_overmap_square()

	// we then create the actual overmap datum
	var/datum/overmap/static_object/encounter = new object_to_spawn(position, current_overmap, FALSE)

	//if we put a custom overmap encounter name we set it here
	if(encounter_name)
		encounter.name = encounter_name

	// similarly, the name that shows up when you landed on said planet
	if(planet_name)
		encounter.planet_name = planet_name

	// Copying over our vars...
	encounter.map_to_load = map_to_load
	encounter.preserve_level = preserve_level
	encounter.load_seperate_z = load_seperate_z
	encounter.weather_controller_type = weather_controller_type
	encounter.gravity = gravity
	encounter.border_size = border_size
	encounter.mapgen = mapgen

	//... We DON'T load level until the player docks there as theres no gurantee they will land there, and that would cause unessary lag.
	//encounter.load_level()

	//we then update the sprite so our custom stuff shows up
	encounter.alter_token_appearance()

	// If all went well we return the encounter
	return encounter
