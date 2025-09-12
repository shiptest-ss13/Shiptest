//In this file: Summon Magic/Summon Guns/Summon Events

// 1 in 50 chance of getting something really special.
#define SPECIALIST_MAGIC_PROB 2

// If true, it's the probability of triggering "survivor" antag.
GLOBAL_VAR_INIT(summon_guns_triggered, FALSE)

/proc/give_guns(mob/living/carbon/human/H)
	if(H.stat == DEAD || !(H.client))
		return
	if(H.mind)
		if(iswizard(H))
			return

	var/turf/human_turf = get_turf(H)
	new /obj/effect/spawner/random/weapon/full_gun(human_turf)
	var/obj/item/gun/spawned_gun = locate(/obj/item/gun, human_turf)

	playsound(human_turf,'sound/magic/summon_guns.ogg', 50, TRUE)

	if(spawned_gun)
		var/in_hand = H.put_in_hands(spawned_gun) // not always successful
		to_chat(H, span_warning("\A [spawned_gun] appears [in_hand ? "in your hand" : "at your feet"]!"))


/proc/rightandwrong(mob/user, survivor_probability)
	if(user) //in this case someone is a badmin
		to_chat(user, span_warning("You summoned guns!"))
		message_admins("[ADMIN_LOOKUPFLW(user)] summoned guns!")
		log_game("[key_name(user)] summoned guns!")

	GLOB.summon_guns_triggered = survivor_probability

	for(var/mob/living/carbon/human/H in GLOB.player_list)
		var/turf/T = get_turf(H)
		if(T && is_away_level(T))
			continue
		give_guns(H)

/proc/summonevents()
	if(!SSevents.wizardmode)
		SSevents.frequency_lower = 600									//1 minute lower bound
		SSevents.frequency_upper = 3000									//5 minutes upper bound
		SSevents.toggleWizardmode()
		SSevents.reschedule()

	else 																//Speed it up
		SSevents.frequency_upper -= 600	//The upper bound falls a minute each time, making the AVERAGE time between events lessen
		if(SSevents.frequency_upper < SSevents.frequency_lower) //Sanity
			SSevents.frequency_upper = SSevents.frequency_lower

		SSevents.reschedule()
		message_admins("Summon Events intensifies, events will now occur every [SSevents.frequency_lower / 600] to [SSevents.frequency_upper / 600] minutes.")
		log_game("Summon Events was increased!")

#undef SPECIALIST_MAGIC_PROB
