/datum/disease/transformation/legionvirus //Diseases are a quick way to exposit a bunch of information onto players, most of the effects here are handled by the legion skull organ from /mob/living/simple_animal/hostile/mining_mobs/hivelord.dm
	name = "Legion Infection"
	max_stages = 5
	spread_flags = DISEASE_SPREAD_NON_CONTAGIOUS
	cure_text = "Surgically removing the skull from the patient's chest; applications of spaceacillin or synaptizine can delay onset of the infection."
	agent = "Legion skull"
	viable_mobtypes = list(/mob/living/carbon/human)
	visibility_flags = 0
	stage_prob = 0 // WOOOOOO SNOWFLAKE!!!!!!! WOOOOOO!!!!
	desc = "If left untreated, the skull will slowly overtake its host's body, eventually growing into a legion."
	severity = DISEASE_SEVERITY_HARMFUL
	disease_flags = NONE
	visibility_flags = HIDDEN_PANDEMIC
	bypasses_immunity = TRUE

	var/stage1 = list(span_notice("You feel a dull pain in your chest."))
	var/stage2 = list(span_notice("Your head begins to ache."))
	var/stage3 = list(span_notice("Something moves underneath your skin."))
	var/stage4 = list(span_warning("You feel something pressing against your skin!"))
	var/stage5 = list(span_warning("Your skin begins to tear apart-!"))
	COOLDOWN_DECLARE(warning_timer)
	var/cooldown_time = 1 MINUTES

/datum/disease/transformation/legionvirus/infect(mob/living/infectee, make_copy = TRUE)
	. = ..()
	COOLDOWN_START(src, warning_timer, cooldown_time) //theos why don't you make this NOT A DISEASE if you don't plan on using ANY disease stuff??? good question:

/datum/disease/transformation/legionvirus/stage_act()
	..()
	if(!COOLDOWN_FINISHED(src, warning_timer))
		return
	COOLDOWN_START(src, warning_timer, cooldown_time)
	switch(stage)
		if(1)
			to_chat(affected_mob, pick(stage1))
		if(2)
			to_chat(affected_mob, pick(stage2))
		if(3)
			to_chat(affected_mob, pick(stage3))
		if(4)
			to_chat(affected_mob, pick(stage4))
		if(5)
			do_disease_transformation(affected_mob)

/datum/disease/transformation/legionvirus/proc/do_disease_transformation(mob/living/H)
	if(stage5)
		to_chat(affected_mob, pick(stage5))
	H.visible_message(span_warning("[H] suddenly collapses, a pallid grey mass bursting from their body!"))
	var/mob/living/simple_animal/hostile/asteroid/hivelord/legion/L
	if(HAS_TRAIT(H, TRAIT_DWARF)) //dwarf legions aren't just fluff!
		L = new /mob/living/simple_animal/hostile/asteroid/hivelord/legion/dwarf(H.loc)
	else
		L = new(H.loc)
	H.death()
	H.adjustBruteLoss(1000)
	L.stored_mob = H
	H.forceMove(L)
