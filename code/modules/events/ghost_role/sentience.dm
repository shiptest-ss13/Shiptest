GLOBAL_LIST_INIT(high_priority_sentience, typecacheof(list(
	/mob/living/simple_animal/pet,
	/mob/living/simple_animal/parrot,
	/mob/living/simple_animal/hostile/lizard,
	/mob/living/simple_animal/sloth,
	/mob/living/basic/mouse/brown/tom,
	/mob/living/simple_animal/hostile/retaliate/goat,
	/mob/living/simple_animal/chicken,
	/mob/living/simple_animal/cow,
	/mob/living/simple_animal/hostile/retaliate/bat,
	/mob/living/simple_animal/hostile/carp/cayenne,
	/mob/living/simple_animal/butterfly,
	/mob/living/simple_animal/hostile/retaliate/poison/snake,
	/mob/living/simple_animal/hostile/retaliate/goose/vomit,
	/mob/living/simple_animal/bot/mulebot,
	/mob/living/simple_animal/bot/secbot/beepsky
)))

/datum/round_event_control/sentience
	name = "Random Human-level Intelligence"
	typepath = /datum/round_event/ghost_role/sentience
	weight = 0
	earliest_start = 10 MINUTES
	max_occurrences = 1

/datum/round_event/ghost_role/sentience
	minimum_required = 1
	role_name = "random animal"
	var/animals = 1
	var/one = "one"

// find our chosen mob to breathe life into
// Mobs have to be simple animals, mindless, on station, and NOT holograms.
// prioritize starter animals that people will recognise
/datum/round_event/ghost_role/sentience/spawn_role()
	var/list/mob/dead/observer/candidates
	candidates = get_candidates(null, null, null)

	var/list/potential = list()

	var/list/hi_pri = list()
	var/list/low_pri = list()

	for(var/mob/living/simple_animal/L in GLOB.alive_mob_list)
		if((L in GLOB.player_list))
			continue
		if(is_type_in_typecache(L, GLOB.high_priority_sentience))
			hi_pri += L
		else
			low_pri += L

	shuffle_inplace(hi_pri)
	shuffle_inplace(low_pri)

	potential = hi_pri + low_pri

	if(!potential.len)
		return WAITING_FOR_SOMETHING
	if(!candidates.len)
		return NOT_ENOUGH_PLAYERS

	var/spawned_animals = 0
	while(spawned_animals < animals && candidates.len && potential.len)
		var/mob/living/simple_animal/SA = popleft(potential)
		var/mob/dead/observer/SG = pick_n_take(candidates)

		spawned_animals++

		SA.key = SG.key

		SA.sentience_act()

		SA.maxHealth = max(SA.maxHealth, 200)
		SA.health = SA.maxHealth

		spawned_mobs += SA

		to_chat(SA, span_userdanger("Hello world!"))
		to_chat(SA, "<span class='warning'>Due to freak radiation and/or chemicals \
			and/or lucky chance, you have gained human level intelligence!</span>")

	return SUCCESSFUL_SPAWN

/datum/round_event_control/sentience/all
	name ="Sector-wide Human-level Intelligence"
	typepath = /datum/round_event/ghost_role/sentience/all
	weight = 0

/datum/round_event/ghost_role/sentience/all
	one = "all"
	animals = INFINITY // as many as there are ghosts and animals
	// cockroach pride, station wide
