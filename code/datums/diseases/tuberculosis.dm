/datum/disease/tuberculosis
	form = "Disease"
	name = "Fungal tuberculosis"
	max_stages = 5
	spread_text = "Airborne"
	cure_text = "Spaceacillin & Perfluorodecalin"
	cures = list(/datum/reagent/medicine/spaceacillin, /datum/reagent/medicine/perfluorodecalin)
	agent = "Fungal Tubercle bacillus Cosmosis"
	viable_mobtypes = list(/mob/living/carbon/human)
	cure_chance = 5//like hell are you getting out of hell
	desc = "A rare highly transmissible virulent virus. Few samples exist, rumoured to be carefully grown and cultured by clandestine bio-weapon specialists. Causes fever, blood vomiting, lung damage, weight loss, and fatigue."
	required_organs = list(/obj/item/organ/lungs)
	severity = DISEASE_SEVERITY_BIOHAZARD
	bypasses_immunity = TRUE // TB primarily impacts the lungs; it's also bacterial or fungal in nature; viral immunity should do nothing.

/datum/disease/tuberculosis/stage_act() //it begins
	..()
	switch(stage)
		if(2)
			if(prob(2))
				affected_mob.emote("cough")
				to_chat(affected_mob, span_danger("Your chest hurts."))
			if(prob(2))
				to_chat(affected_mob, span_danger("Your stomach violently rumbles!"))
			if(prob(5))
				to_chat(affected_mob, span_danger("You feel a cold sweat form."))
		if(4)
			if(prob(2))
				to_chat(affected_mob, span_userdanger("You see four of everything!"))
				affected_mob.set_timed_status_effect(10 SECONDS, /datum/status_effect/dizziness, only_if_higher = TRUE)
			if(prob(2))
				to_chat(affected_mob, span_danger("You feel a sharp pain from your lower chest!"))
				affected_mob.adjustOxyLoss(5)
				affected_mob.emote("gasp")
			if(prob(10))
				to_chat(affected_mob, span_danger("You feel air escape from your lungs painfully."))
				affected_mob.adjustOxyLoss(25)
				affected_mob.emote("gasp")
		if(5)
			if(prob(2))
				to_chat(affected_mob, span_userdanger("[pick("You feel your heart slowing...", "You relax and slow your heartbeat.")]"))
				affected_mob.adjustStaminaLoss(70)
			if(prob(10))
				affected_mob.adjustStaminaLoss(100)
				affected_mob.visible_message(span_warning("[affected_mob] faints!"), span_userdanger("You surrender yourself and feel at peace..."))
				affected_mob.AdjustSleeping(100)
			if(prob(2))
				to_chat(affected_mob, span_userdanger("You feel your mind relax and your thoughts drift!"))
				affected_mob.confused = min(100, affected_mob.confused + 8)
			if(prob(10))
				affected_mob.vomit(20)
			if(prob(3))
				to_chat(affected_mob, span_warning("<i>[pick("Your stomach silently rumbles...", "Your stomach seizes up and falls limp, muscles dead and lifeless.", "You could eat a crayon")]</i>"))
				affected_mob.overeatduration = max(affected_mob.overeatduration - 100, 0)
				affected_mob.adjust_nutrition(-100)
			if(prob(15))
				to_chat(affected_mob, span_danger("[pick("You feel uncomfortably hot...", "You feel like unzipping your jumpsuit", "You feel like taking off some clothes...")]"))
				affected_mob.adjust_bodytemperature(40)
	return
