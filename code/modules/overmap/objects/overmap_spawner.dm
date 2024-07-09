/obj/item/overmap_encounter_spawner
	name = "helm console punchcard"
	desc = "A piece of paper with carfully organized holes through it."
	gender = NEUTER
	icon = 'icons/obj/bureaucracy.dmi'
	icon_state = "punchcard"

	/// What should we name the planet on the overmap?
	var/encounter_name = "scrungled planetoid"
	///What should the planet be called when it's landed on?
	var/planet_name = "Mappeious Goofius Upper"
	/// What planet type do we spawn? By default its reebe just so you know you fucked up
	var/planet_type = DYNAMIC_WORLD_REEBE
	/// Do we want ruins? If true and ruin_force is not set, we spawn a random ruin. NOTE: If FALSE up to four ships can dock to the encounter
	var/spawn_ruins = FALSE
	/// What ruin do we want to spawn? If none, we randomize unless above was set to random
	var/datum/map_template/ruin_force
	/// What coords do we want to spawn this encounter in? if null we spawn it randomly
	var/position
	/// Do we want to keep the panet after all sentient players have left? If set to false it DESTROYS the planet when every sentient player has left!
	var/preserve_level = TRUE

/obj/item/overmap_encounter_spawner/examine(mob/user)
	. = ..()
	. += span_notice("You could probably scan this with a helm console to locate a hidden overmap object.")

/obj/item/overmap_encounter_spawner/proc/create_encounter()
	// if position is none we get a random square
	if(!position)
		position = SSovermap.get_unused_overmap_square()

	// we then create the actual overmap datum
	var/datum/overmap/dynamic/encounter = new(position, FALSE)

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
		encounter.ruin_list = null

	//... But if we DO want ruins to spawn, AND if there is a forced ruin, we set the template to spawn to that
	else if(ruin_force)
		encounter.template = ruin_force

	// we then set our preserve_level to the datum's
	encounter.preserve_level = preserve_level

	//... We DON'T load level until the player docks there as theres no gurantee they will land there, and that would cause unessary lag.
	//encounter.load_level()

	// If all went well we return the encounter
	return encounter

/obj/machinery/computer/helm/attackby(obj/item/key, mob/living/user, params)
	. = ..()
	var/obj/item/overmap_encounter_spawner/punchcard

	// Is this thing a punchcard?
	if(istype(key, /obj/item/overmap_encounter_spawner))
		punchcard = key
		//flavor
		say("Scanning punchcard, please wait...")
		if(do_after(user, 10 SECONDS))
			//We then run the create encounter on the punchcard, and copy that over to the helm console
			var/datum/overmap/dynamic/spawned_encounter = punchcard.create_encounter()
			// if we for some reason failed to, we tell the player so.
			if(!spawned_encounter)
				say("Failed to scan punchcard. Please try again later.")
				return
			// if we did, we tell the player the coordinate, hope they remember, and then ddelete the punchcard to prevent spam
			say("Located hidden location. Location is X[spawned_encounter.x], Y[spawned_encounter.y].")
			qdel(punchcard)
		// They moved after the do_after...
		else
			say("Failed to scan punchcard. Please do not move while scanning a punchcard.")
