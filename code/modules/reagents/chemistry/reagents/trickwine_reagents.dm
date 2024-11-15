/datum/reagent/consumable/ethanol/trickwine
	name = "Trickwine"
	description = "How is this even possible"

/datum/reagent/consumable/ethanol/trickwine/ash_wine
	name = "Wine Of Ash"
	description = "A traditional sacrament for members of the Saint-Roumain Militia. Believed to grant visions, seeing use both in ritual and entertainment within the Militia."
	color = "#6CC66C"
	boozepwr = 80
	quality = DRINK_VERYGOOD
	taste_description = "a rustic fruit, with hints of sweet yet tangy ash."
	glass_name = "Wine Of Ash"
	glass_desc = "A traditional sacrament for members of the Saint-Roumain Militia. Believed to grant visions, seeing use both in ritual and entertainment within the Militia."
	breakaway_flask_icon_state = "baflaskashwine"

/datum/reagent/consumable/ethanol/trickwine/ash_wine/on_mob_life(mob/living/M)
	if(prob(15))
		M.adjustToxLoss(-1)
		M.adjust_drugginess(5)
		var/high_message = pick("Devotion runs wild within your soul", "A lust for hunting leaps from within your psyche", "The inner beauty of nature courses within your minds' eye.", "Calm warmth spreads within your body.")
		to_chat(M, span_notice("[high_message]"))
	return ..()

/datum/reagent/consumable/ethanol/trickwine/ash_wine/expose_mob(mob/living/M, method=TOUCH, reac_volume)
	if(method == TOUCH)
		if(!iscarbon(M))
			var/mob/living/simple_animal/hostile/hostile_target = M
			var/hostile_ai_status = hostile_target.AIStatus
			hostile_target.toggle_ai(AI_OFF)
			addtimer(VARSET_CALLBACK(hostile_target, AIStatus, hostile_ai_status),reac_volume)
		M.Jitter(3 * reac_volume)
		M.Dizzy(2 * reac_volume)
		M.set_drugginess(3 * reac_volume)
	return ..()

/datum/reagent/consumable/ethanol/trickwine/ice_wine
	name = "Wine Of Ice"
	description = "A specialized brew utilized by members of the Saint-Roumain Militia, designed to assist in temperature regulation while working in hot environments. Known to give one the cold shoulder when thrown."
	color = "#C0F1EE"
	boozepwr = 70
	taste_description = "a weighty meat, undercut by a mild pepper."
	glass_name = "Wine Of Ice"
	glass_desc = "A specialized brew utilized by members of the Saint-Roumain Militia, designed to assist in temperature regulation while working in hot environments. Known to give one the cold shoulder when thrown."
	breakaway_flask_icon_state = "baflaskicewine"

/datum/reagent/consumable/ethanol/trickwine/ice_wine/on_mob_life(mob/living/M)
	M.adjust_bodytemperature(-5 * TEMPERATURE_DAMAGE_COEFFICIENT, M.get_body_temp_normal())
	M.adjustFireLoss(-0.25)
	if(prob(10))
		to_chat(M, span_notice("Sweat runs down your body."))
	return ..()


/datum/reagent/consumable/ethanol/trickwine/ice_wine/expose_mob(mob/living/M, method=TOUCH, reac_volume)
	if(method == TOUCH)
		var/paralyze_dur
		if(!iscarbon(M))
			reac_volume = reac_volume * 2
			paralyze_dur = reac_volume
		else
			if(reac_volume <= 50)
				paralyze_dur = reac_volume
			else
				paralyze_dur = 50 + ((reac_volume - 50) / 4)
		M.adjust_bodytemperature((-20*reac_volume) * TEMPERATURE_DAMAGE_COEFFICIENT, 50)
		M.Paralyze(paralyze_dur)
		walk(M, 0) //stops them mid pathing even if they're stunimmunee
		M.apply_status_effect(/datum/status_effect/ice_block_talisman, paralyze_dur)
	return ..()

/datum/reagent/consumable/ethanol/trickwine/shock_wine
	name = "Lightning's Blessing"
	description = "A stimulating brew utilized by members of the Saint-Roumain Militia, created to allow trackers to keep up with highly mobile prey. Known to have a shocking effect when thrown"
	color = "#FEFEB8"
	boozepwr = 50
	taste_description = "a sharp and unrelenting citrus"
	glass_name = "Lightning's Blessing"
	glass_desc = "A stimulating brew utilized by members of the Saint-Roumain Militia, created to allow trackers to keep up with highly mobile prey. Known to have a shocking effect when thrown"
	breakaway_flask_icon_state = "baflaskshockwine"

/datum/reagent/consumable/ethanol/trickwine/shock_wine/on_mob_metabolize(mob/living/M)
	..()
	M.add_movespeed_modifier(/datum/movespeed_modifier/reagent/shock_wine)
	to_chat(M, span_notice("You feel like a bolt of lightning!"))

/datum/reagent/consumable/ethanol/trickwine/shock_wine/on_mob_end_metabolize(mob/living/M)
	M.remove_movespeed_modifier(/datum/movespeed_modifier/reagent/shock_wine)
	to_chat(M, span_notice("Inertia leaves your body!"))
	..()

/datum/reagent/consumable/ethanol/trickwine/shock_wine/expose_mob(mob/living/M, method=TOUCH, reac_volume)
	if(method == TOUCH)
		//simple mobs are so tanky and i want this to be useful on them
		if(iscarbon(M))
			reac_volume = reac_volume / 4
		M.electrocute_act(reac_volume, src, siemens_coeff = 1, flags = SHOCK_NOSTUN|SHOCK_TESLA)
		do_sparks(5, FALSE, M)
		playsound(M, 'sound/machines/defib_zap.ogg', 100, TRUE)
	return ..()

/datum/reagent/consumable/ethanol/trickwine/hearth_wine
	name = "Hearthflame"
	description = "A fiery brew utilized by members of the Saint-Roumain Militia, engineered to heat the body and cauterize wounds. Goes out in a blaze of glory when thrown."
	color = "#FEE185"
	boozepwr = 70
	taste_description = "apple cut apart by tangy pricks"
	glass_name = "Hearthflame"
	glass_desc = "Fiery brew utilized by members of the Saint-Roumain Militia, engineered to heat the body and cauterize wounds. Goes out in a blaze of glory when thrown."
	breakaway_flask_icon_state = "baflaskhearthwine"

/datum/reagent/consumable/ethanol/trickwine/hearth_wine/on_mob_life(mob/living/M)
	M.adjust_bodytemperature(5 * TEMPERATURE_DAMAGE_COEFFICIENT, M.get_body_temp_normal())
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		H.heal_bleeding(0.25)
	return ..()

/datum/reagent/consumable/ethanol/trickwine/hearth_wine/expose_mob(mob/living/M, method=TOUCH, reac_volume)
	if(method == TOUCH)
		if(!iscarbon(M))
			reac_volume = reac_volume * 2
		M.fire_act()
		var/turf/T = get_turf(M)
		T.IgniteTurf(reac_volume)
		new /obj/effect/hotspot(T, reac_volume * 1, FIRE_MINIMUM_TEMPERATURE_TO_EXIST + reac_volume * 10)
		var/turf/otherT
		for(var/direction in GLOB.alldirs)
			otherT = get_step(T, direction)
			otherT.IgniteTurf(reac_volume)
			new /obj/effect/hotspot(otherT, reac_volume * 1, FIRE_MINIMUM_TEMPERATURE_TO_EXIST + reac_volume * 10)
	return ..()
