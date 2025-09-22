/datum/round_event_control/ship/random_pet
	name = "Random Pet"
	typepath = /datum/round_event/ship/random_pet
	weight = 5
	max_occurrences = 2
	min_players = 1
	earliest_start = 5 MINUTES

/datum/round_event/ship/random_pet
	var/mob/living/simple_animal/random_pet

/datum/round_event/ship/random_pet/setup()
	if(!..())
		return FALSE
	random_pet = pick(list(
		/mob/living/simple_animal/pet/dog/corgi,
		/mob/living/simple_animal/pet/dog/corgi/exoticcorgi,
		/mob/living/simple_animal/pet/dog/corgi/capybara,
		/mob/living/simple_animal/pet/dog/pug,
		/mob/living/simple_animal/pet/cat,
		/mob/living/simple_animal/pet/mothroach,
		/mob/living/simple_animal/pet/fox,
	))

/datum/round_event/ship/random_pet/start()
	var/list/crates = list()
	if(!length(target_ship.shuttle_port.shuttle_areas))
		return FALSE

	for(var/area/ship_area in target_ship.shuttle_port.shuttle_areas)
		for(var/obj/structure/closet/temp_crate in ship_area)
			if(QDELETED(temp_crate))
				continue
			if(!temp_crate.can_open())
				continue
			crates += temp_crate

	if(crates.len)
		var/obj/structure/closet/crate = pick(crates)
		crate.open()
		announce_to_ghosts(spawn_atom_to_turf(random_pet, crate, 1, FALSE))
