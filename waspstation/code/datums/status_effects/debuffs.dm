// Overall healing intentionally low to make omnizine/donk pockets preferred alternative
/datum/status_effect/incapacitating/sleeping/Destroy()
	if(owner.maxHealth)
		var/health_ratio = owner.health / owner.maxHealth
		var/healing = -5
		if((locate(/obj/structure/bed) in owner.loc))
			healing -= 4
		else if((locate(/obj/structure/table) in owner.loc))
			healing -= 2
		for(var/obj/item/bedsheet/bedsheet in range(owner.loc,0))
			if(bedsheet.loc != owner.loc)//bedsheets in your backpack/neck don't give you comfort
				continue
			healing -= 1
			break //Only count the first bedsheet

		var/datum/component/mood/mood = owner.GetComponent(/datum/component/mood)
		if(mood.sanity >= SANITY_GREAT)
			healing -= 2
		else if(mood.sanity <= SANITY_DISTURBED)
			healing += 1

		if(owner.metabolism_efficiency == 1.25)     // Have been eating healthy
			healing -= 3
		else if (owner.metabolism_efficiency == 0.8)
			healing += 2

		if(health_ratio > 0 && heal == TRUE)
			owner.adjustBruteLoss(healing)
			owner.adjustFireLoss(healing)
			owner.adjustToxLoss(healing * 0.5, TRUE, TRUE)
		owner.adjustStaminaLoss(healing)
	carbon_owner = null
	human_owner = null
	return ..()

/datum/status_effect/incapacitating/sleeping/tick()
	if(human_owner && human_owner.drunkenness)
		human_owner.drunkenness *= 0.997 //reduce drunkenness by 0.3% per tick, 6% per 2 seconds
	if(prob(20))
		if(carbon_owner)
			carbon_owner.handle_dreams()
		if(prob(10) && owner.health > owner.crit_threshold)
			owner.emote("snore")
