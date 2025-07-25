/*
		Core sampling missions
*/
/datum/mission/outpost/drill
	name = "Class 1 core sample mission"
	desc = "We require geological information from one of the neighboring planetoids. \
			Please anchor the drill in place and defend it until it has gathered enough samples. \
			Operation of the core sampling drill is extremely dangerous, caution is advised. "
	value = 2500
	duration = 90 MINUTES
	weight = 11

	var/datum/planet_type/selected_planet
	var/list/available_planets = list(
		/datum/planet_type/lava = /obj/structure/vein/lavaland,
		/datum/planet_type/ice = /obj/structure/vein/ice,
		/datum/planet_type/jungle = /obj/structure/vein/jungle,
		/datum/planet_type/sand = /obj/structure/vein/sand,
		/datum/planet_type/rock = /obj/structure/vein/rockplanet,
		/datum/planet_type/moon = /obj/structure/vein/moon,
		/datum/planet_type/asteroid = /obj/structure/vein/asteroid,
	)
	var/obj/machinery/drill/mission/sampler
	var/obj/item/overmap_punchcard_spawner/dynamic/mission/punchcard
	var/num_wanted = 5
	var/class_wanted = 1
	var/spawn_punchcard = TRUE
	var/bonus_text = TRUE

/datum/mission/outpost/drill/generate_mission_details()
	. = ..()
	selected_planet = pick(available_planets)
	num_wanted = rand(num_wanted-2,num_wanted+2)
	value += num_wanted*100
	name = "Class [class_wanted] [selected_planet.name] core sample mission"
	desc = "We require geological information from a neighboring [selected_planet.name]. \
			Please anchor the drill in place and defend it until it has gathered enough samples.\
			Operation of the core sampling drill is extremely dangerous, caution is advised. "
	if(bonus_text)
		desc += " \n\nA punchcard will be provided for ease of locating a [selected_planet.name]. \
					A 500 credit bonus will be applied for not using one."


/datum/mission/outpost/drill/accept(datum/overmap/ship/controlled/acceptor, turf/accept_loc)
	. = ..()
	sampler = spawn_bound(/obj/machinery/drill/mission, accept_loc, VARSET_CALLBACK(src, sampler, null))
	sampler.mission_class = class_wanted
	sampler.num_wanted = num_wanted
	sampler.orevein_wanted = available_planets[selected_planet]
	sampler.name += " (Class [class_wanted] [selected_planet.name])"

	if(spawn_punchcard)
		punchcard = spawn_bound(/obj/item/overmap_punchcard_spawner/dynamic/mission, accept_loc, VARSET_CALLBACK(src, punchcard, null), FALSE)
		punchcard.name += " ([selected_planet.name])"
		punchcard.planet_type = selected_planet
		if(bonus_text)
			punchcard.desc += span_notice("\nA [span_bold("500 credit")] bonus will be applied for keeping this until the end of your sample mission.")

/datum/mission/outpost/drill/can_complete()
	. = ..()
	if(!.)
		return
	var/obj/docking_port/mobile/scanner_port = SSshuttle.get_containing_shuttle(sampler)
	return . && (sampler.num_current >= num_wanted) && (scanner_port?.current_ship == servant)

/datum/mission/outpost/drill/get_progress_string()
	if(!sampler)
		return "0/[num_wanted]"
	else
		return "[sampler.num_current]/[num_wanted]"

/datum/mission/outpost/drill/Destroy()
	sampler = null
	return ..()

/datum/mission/outpost/drill/turn_in()
	//Gives players a little extra money for going past the mission goal
	value += (sampler.num_current - num_wanted)*50
	if(punchcard)
		//500 credit punchcard
		value += 500
		recall_bound(punchcard)

	recall_bound(sampler)
	return ..()

/datum/mission/outpost/drill/give_up()
	if(punchcard)
		recall_bound(punchcard)
	recall_bound(sampler)

	return ..()

/datum/mission/outpost/drill/classtwo
	name = "Class 2 core sample mission"
	value = 4500
	weight = 9
	class_wanted = 2
	num_wanted = 6

/datum/mission/outpost/drill/classthree
	name = "Class 3 core sample mission"
	value = 8000
	weight = 5
	duration = 120 MINUTES
	class_wanted = 3
	num_wanted = 8

/*
		Variant for rare planets
*/
/datum/mission/outpost/drill/rareplanet
	name = "Class 1 rare core sample mission"
	desc = "We have discovered a rare planetoid and wish to study it's geology. \
			Please anchor the drill in place and defend it until it has gathered enough samples. \
			Not much information on these planets are known, caution is advised. \
			A punchcard will be provided to locate the planet, as it is impossible to find otherwise. "
	value = 3000
	duration = 90 MINUTES
	weight = 4

	available_planets = list(
		/datum/planet_type/water = /obj/structure/vein/waterplanet,
		/datum/planet_type/desert = /obj/structure/vein/desert,
	)
	bonus_text = FALSE
	num_wanted = 6

/datum/mission/outpost/drill/rareplanet/generate_mission_details()
	. = ..()
	name = "Class [class_wanted] rare [selected_planet.name] core sample mission"
	desc = "We have discovered a rare [selected_planet.name] and wish to study it's geology. \
			Please anchor the drill in place and defend it until it has gathered enough samples. \
			Not much information on these planets are known, caution is advised. \
			A punchcard will be provided to locate the planet, as it is impossible to find otherwise. "
	if(selected_planet == /datum/planet_type/shrouded)
		name = "Special [selected_planet.name] Class [class_wanted] core sample mission"
		desc = "We have discovered a rare [selected_planet.name] and wish to require it's geology. \
				However, almost everyone we send there usually comes back screaming and refusing to do the job. \
				The electromagnetic absorbing atmosphere prevents thorough scans, but the surface appears to be completly barren. \
				Please for the love of the Huntsman gather the samples please. There will be a bonus as well. \
				A punchcard will be provided to locate the planet, as it is impossible to find otherwise. "
		value += 750

	if(bonus_text)
		desc += " \n\nA punchcard will be provided for ease of locating a [selected_planet.name].\
				A 500 credit bonus will be applied for not using one."

/datum/mission/outpost/drill/rareplanet/classtwo
	name = "Class 2 rare core sample mission"
	value = 5000
	weight = 3
	class_wanted = 2
	num_wanted = 8
	available_planets = list(
		/datum/planet_type/water = /obj/structure/vein/waterplanet,
		/datum/planet_type/desert = /obj/structure/vein/desert,
		/datum/planet_type/water = /obj/structure/vein/waterplanet,
		/datum/planet_type/desert = /obj/structure/vein/desert,
		/datum/planet_type/shrouded = /obj/structure/vein/shrouded,
	)

/datum/mission/outpost/drill/rareplanet/classthree
	name = "Class 3 rare core sample mission"
	value = 6500
	weight = 2
	duration = 120 MINUTES
	class_wanted = 3
	num_wanted = 10
	available_planets = list(
		/datum/planet_type/water = /obj/structure/vein/waterplanet,
		/datum/planet_type/desert = /obj/structure/vein/desert,
		/datum/planet_type/shrouded = /obj/structure/vein/shrouded,
	)
