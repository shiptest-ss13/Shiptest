/datum/reagent/consumable/ethanol/spriters_bane
	name = "Spriter's Bane"
	description = "A drink to fill your very SOUL."
	color = "#800080"
	boozepwr = 30
	quality = DRINK_GOOD
	taste_description = "microsoft paints"
	glass_icon_state = "uglydrink"
	glass_name = "Spriter's Bane"
	glass_desc = "Tastes better than it looks."

/datum/reagent/consumable/ethanol/spriters_bane/on_mob_life(mob/living/carbon/C)
	switch(current_cycle)
		if(5 to 40)
			C.jitteriness += 3
			if(prob(10) && !C.eye_blurry)
				C.blur_eyes(6)
				to_chat(C, "<span class='warning'>That outline is so distracting, it's hard to look at anything else!</span>")
		if(40 to 100)
			C.Dizzy(10)
			if(prob(15))
				new /datum/hallucination/hudscrew(C)
		if(100 to INFINITY)
			if(prob(10) && !C.eye_blind)
				C.blind_eyes(6)
				to_chat(C, "<span class='userdanger'>Your vision fades as your eyes are outlined in black!</span>")
			else
				C.Dizzy(20)
	..()

/datum/reagent/consumable/ethanol/spriters_bane/expose_atom(atom/A, volume)
	A.AddComponent(/datum/component/outline)
	..()

/datum/reagent/consumable/ethanol/cogchamp
	name = "CogChamp"
	description = "Now you can fill yourself with the power of Ratvar!"
	color = rgb(255, 201, 49)
	boozepwr = 10
	quality = DRINK_FANTASTIC
	taste_description = "a brass taste with a hint of oil"
	glass_icon_state = "cogchamp"
	glass_name = "CogChamp"
	glass_desc = "Not one of Ratvar's Four Generals could withstand this!  Qevax Jryy!"
	value = 8.13

/datum/reagent/consumable/ethanol/cogchamp/on_mob_life(mob/living/carbon/M)
	M.clockcultslurring = min(M.clockcultslurring + 3, 3)
	M.stuttering = min(M.stuttering + 3, 3)
	..()