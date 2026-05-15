#warn demodularize before merge

// Disease symptoms
/datum/symptom/headache/Activate(datum/disease/advance/A)
	. = ..()
	if(!.)
		return
	switch(A.stage)
		if(4)
			A.affected_mob.sharp_pain(BODY_ZONE_HEAD, 3 * power)
			A.affected_mob.flash_pain_overlay(1)
		if(5)
			A.affected_mob.sharp_pain(BODY_ZONE_HEAD, 5 * power)
			A.affected_mob.flash_pain_overlay(2)

/datum/symptom/flesh_eating/Activate(datum/disease/advance/A)
	. = ..()
	if(!.)
		return
	switch(A.stage)
		if(2, 3)
			A.affected_mob.cause_pain(BODY_ZONES_ALL, 3 * (pain ? 2 : 1))
			A.affected_mob.flash_pain_overlay(1, 2 SECONDS)
		if(4, 5)
			A.affected_mob.cause_pain(BODY_ZONES_ALL, 12 * (pain ? 2 : 1))
			A.affected_mob.flash_pain_overlay(2, 2 SECONDS)

/datum/symptom/fire/Activate(datum/disease/advance/A)
	. = ..()
	if(!.)
		return
	switch(A.stage)
		if(4)
			A.affected_mob.cause_typed_pain(BODY_ZONES_ALL, 5, BURN)
			A.affected_mob.flash_pain_overlay(1)
		if(5)
			A.affected_mob.cause_typed_pain(BODY_ZONES_ALL, 10, BURN)
			A.affected_mob.flash_pain_overlay(2)

// Shocks
/mob/living/carbon/human/electrocute_act(shock_damage, source, siemens_coeff = 1, flags = NONE)
	. = ..()
	if(!.)
		return

	sharp_pain(BODY_ZONES_ALL, min((. / 2), 25), BURN)
	set_timed_pain_mod(PAIN_MOD_RECENT_SHOCK, 0.5, 30 SECONDS)

// Fleshmend of course heals pain.
/datum/status_effect/fleshmend/tick()
	. = ..()
	if(iscarbon(owner) && !owner.on_fire)
		var/mob/living/carbon/carbon_owner = owner
		carbon_owner.cause_pain(BODY_ZONES_ALL, -1.5)

// Regen cores.
/datum/status_effect/regenerative_core/on_apply()
	. = ..()
	var/mob/living/carbon/human/human_owner = owner
	if(istype(human_owner) && human_owner.pain_controller)
		human_owner.cause_pain(BODY_ZONES_LIMBS, -15)
		human_owner.cause_pain(BODY_ZONE_CHEST, -20)
		human_owner.cause_pain(BODY_ZONE_HEAD, -10) // heals 90 pain total

// Falling? Hurts!
/mob/living/carbon/human/ZImpactDamage(turf/T, levels)
	var/is_freerunner = HAS_TRAIT(src, TRAIT_FREERUNNING)
	// This proc is coded so wonky...
	if(is_freerunner && levels <= 1)
		return ..()

	// 12 brute for 1 level, 32 brute for 2 levels
	var/brute_amount = (levels * 5) ** 1.5
	var/limb_pain_amount = brute_amount // 1:1 ratio of brute to pain, baby
	adjustBruteLoss(brute_amount)
	if(is_freerunner)
		limb_pain_amount /= 2
	if(usable_legs >= 2 && prob(80))
		visible_message(
			span_danger("[src] crashes into [T] with a sickening noise, landing on their legs [is_freerunner ? "shakily" : "hard"]!"),
			span_userdanger("You crash into [T] with a sickening noise, landing [is_freerunner ? "shakily" : "hard"] on your legs! Ouch!"),
			span_hear("You hear a sickening crunch."))
		sharp_pain(list(BODY_ZONE_L_LEG, BODY_ZONE_R_LEG), limb_pain_amount)
	else if(usable_hands >= 2)
		visible_message(
			span_danger("[src] attempts to stop their fall with their arms, crashing into [T] with a sickening noise!"),
			span_userdanger("You attempt to stop your fall with your arms, and crash into [T] with a sickening noise! Ouch!"),
			span_hear("You hear a sickening crunch."))
		sharp_pain(list(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM), limb_pain_amount)
	else
		visible_message(
			span_danger("[src] crash into [T] with a sickening noise!"),
			span_userdanger("You crash into [T] with a sickening noise! Ouch!"),
			span_hear("You hear a sickening thud."))
		sharp_pain(BODY_ZONE_HEAD, (levels * 10)) // bonk

	cause_pain(BODY_ZONE_CHEST, (levels * 8)) // always less pain than what the legs receive
	Knockdown(levels * 50)

// Flight potion's flavor says "it hurts a shit ton bro", so it should cause decent pain
/datum/reagent/flightpotion/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume, show_message = TRUE)
	. = ..()
	if(iscarbon(exposed_mob) && exposed_mob.stat != DEAD)
		var/mob/living/carbon/exposed_carbon = exposed_mob
		if(reac_volume < 5 || !(ishumanbasic(exposed_carbon) || islizard(exposed_carbon) || ismoth(exposed_carbon)))
			return
		if(exposed_carbon.dna.species.has_innate_wings)
			exposed_carbon.cause_pain(BODY_ZONE_HEAD, 10)
			exposed_carbon.cause_pain(BODY_ZONE_CHEST, 45)
			exposed_carbon.cause_pain(list(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM), 18)
		else
			exposed_carbon.cause_pain(BODY_ZONE_HEAD, 16)
			exposed_carbon.cause_pain(BODY_ZONE_CHEST, 75)
			exposed_carbon.cause_pain(list(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM), 30)
