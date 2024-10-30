/datum/reagent/consumable/ethanol/trickwine
	name = "Trickwine"
	description = "How is this even possible"

/datum/reagent/consumable/ethanol/trickwine/ash_wine
	name = "Ashwine"
	description = "A traditional sacrament for members of the Saint-Roumain Militia. Known to grant visions, and is used both for ritual and entertainment purposes aboard Saint-Roumain vessels."
	color = "#6CC66C"
	boozepwr = 80
	quality = DRINK_VERYGOOD
	taste_description = "devotional energy and a hint of high-potency hallucinogens"
	glass_name = "Ashwine"
	glass_desc = "A traditional sacrament for members of the Saint-Roumain Militia. Known to grant visions, and is used both for ritual and entertainment purposes aboard Saint-Roumain vessels."
	breakaway_flask_icon_state = "baflaskashwine"

/datum/reagent/consumable/ethanol/trickwine/ash_wine/on_mob_life(mob/living/M)
	var/high_message = pick("You feel far more devoted to the cause", "You feel like you should go on a hunt")
	var/cleanse_message = pick("Divine light purifies you.", "You are purged of foul spirts.")
	if(prob(10))
		M.set_drugginess(10)
		to_chat(M, "<span class='notice'>[high_message]</span>")
	if(M.faction && ("roumain" in M.faction))
		M.adjustToxLoss(-2)
		if(prob(10))
			to_chat(M, "<span class='notice'>[cleanse_message]</span>")
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
	name = "Icewine"
	description = "A specialized brew utilized by members of the Saint-Roumain Militia, designed to assist in temperature regulation while working in hot environments. Known to give one the cold shoulder when thrown."
	color = "#C0F1EE"
	boozepwr = 70
	taste_description = "a cold night on the hunt"
	glass_name = "Icewine"
	glass_desc = "A specialized brew utilized by members of the Saint-Roumain Militia, designed to assist in temperature regulation while working in hot environments. Known to give one the cold shoulder when thrown."
	breakaway_flask_icon_state = "baflaskicewine"

/datum/reagent/consumable/ethanol/trickwine/ice_wine/on_mob_life(mob/living/M)
	M.adjust_bodytemperature(-5 * TEMPERATURE_DAMAGE_COEFFICIENT, M.get_body_temp_normal())
	M.adjustFireLoss(-1)
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
	name = "Shockwine"
	description = "A stimulating brew utilized by members of the Saint-Roumain Militia, created to allow trackers to keep up with highly mobile prey. Known to have a shocking effect when thrown"
	color = "#FEFEB8"
	boozepwr = 70
	taste_description = "the adrenaline of the chase"
	glass_name = "Shockwine"
	glass_desc = "A stimulating brew utilized by members of the Saint-Roumain Militia, created to allow trackers to keep up with highly mobile prey. Known to have a shocking effect when thrown"
	breakaway_flask_icon_state = "baflaskshockwine"

/datum/reagent/consumable/ethanol/trickwine/shock_wine/on_mob_metabolize(mob/living/M)
	..()
	M.add_movespeed_modifier(/datum/movespeed_modifier/reagent/shock_wine)
	to_chat(M, "<span class='notice'>You feel faster the lightning!</span>")

/datum/reagent/consumable/ethanol/trickwine/shock_wine/on_mob_end_metabolize(mob/living/M)
	M.remove_movespeed_modifier(/datum/movespeed_modifier/reagent/shock_wine)
	to_chat(M, "<span class='notice'>You slow to a crawl...</span>")
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
	name = "Hearthwine"
	description = "A fiery brew utilized by members of the Saint-Roumain Militia, engineered to cauterize wounds in the field. Goes out in a blaze of glory when thrown."
	color = "#FEE185"
	boozepwr = 70
	taste_description = "the heat of battle"
	glass_name = "Hearthwine"
	glass_desc = "Fiery brew utilized by members of the Saint-Roumain Militia, engineered to cauterize wounds in the field. Goes out in a blaze of glory when thrown."
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

/datum/reagent/consumable/ethanol/trickwine/force_wine
	name = "Forcewine"
	description = "A fortifying brew utilized by members of the Saint-Roumain Militia, created to protect against the esoteric. Known to act defensively when thrown."
	color = "#709AAF"
	boozepwr = 70
	taste_description = "the strength of your convictions"
	glass_name = "Forcewine"
	glass_desc = "A fortifying brew utilized by members of the Saint-Roumain Militia, created to protect against the esoteric. Known to act defensively when thrown."
	breakaway_flask_icon_state = "baflaskforcewine"

/datum/reagent/consumable/ethanol/trickwine/force_wine/on_mob_metabolize(mob/living/M)
	..()
	ADD_TRAIT(M, TRAIT_ANTIMAGIC, "trickwine")
	ADD_TRAIT(M, TRAIT_MINDSHIELD, "trickwine")
	M.visible_message("<span class='warning'>[M] glows a dim grey aura</span>")

/datum/reagent/consumable/ethanol/trickwine/force_wine/on_mob_end_metabolize(mob/living/M)
	M.visible_message("<span class='warning'>[M]'s aura fades away </span>")
	REMOVE_TRAIT(M, TRAIT_ANTIMAGIC, "trickwine")
	REMOVE_TRAIT(M, TRAIT_MINDSHIELD, "trickwine")
	..()

/datum/reagent/consumable/ethanol/trickwine/force_wine/expose_mob(mob/living/M, method=TOUCH, reac_volume)
	if(method == TOUCH)
		if(!iscarbon(M))
			reac_volume = reac_volume * 2
		var/turf/T = get_turf(M)
		var/turf/otherT
		new /obj/effect/forcefield/resin(T, reac_volume * 4)
		for(var/direction in GLOB.cardinals)
			otherT = get_step(T, direction)
			new /obj/effect/forcefield/resin(otherT, reac_volume * 4)
	return ..()

/datum/reagent/consumable/ethanol/trickwine/prism_wine
	name = "Prismwine"
	description = "A glittering brew utilized by members of the Saint-Roumain Militia, mixed to provide defense against the blasts and burns of foes and fauna alike. Softens targets against your own burns when thrown."
	color = "#F0F0F0"
	boozepwr = 70
	taste_description = "the reflective quality of meditation"
	glass_name = "Prismwine"
	glass_desc = "A glittering brew utilized by members of the Saint-Roumain Militia, mixed to provide defense against the blasts and burns of foes and fauna alike. Softens targets against your own burns when thrown."
	breakaway_flask_icon_state = "baflaskprismwine"

/datum/reagent/consumable/ethanol/trickwine/prism_wine/on_mob_metabolize(mob/living/carbon/human/M)
	..()
	ADD_TRAIT(M, TRAIT_REFLECTIVE, "trickwine")
	M.physiology.burn_mod *= 0.5
	M.add_filter("prism-wine", 2, list("type"="outline", "color"="#8FD7DF", "size"=1))
	M.visible_message("<span class='warning'>[M] seems to shimmer with power!</span>")

/datum/reagent/consumable/ethanol/trickwine/prism_wine/on_mob_end_metabolize(mob/living/carbon/human/M)
	REMOVE_TRAIT(M, TRAIT_REFLECTIVE, "trickwine")
	M.physiology.burn_mod *= 2
	M.remove_filter("prism-wine")
	M.visible_message("<span class='warning'>[M] has returned to normal!</span>")
	..()

/datum/reagent/consumable/ethanol/trickwine/prism_wine/expose_mob(mob/living/M, method=TOUCH, reac_volume)
	if(method == TOUCH)
		if(istype(M, /mob/living/simple_animal/hostile/asteroid))
			var/mob/living/simple_animal/hostile/asteroid/the_animal = M
			the_animal.armor.modifyRating(energy = -50)
			spawn(reac_volume SECONDS)
				the_animal.armor.modifyRating(energy = 50)
		if(ishuman(M))
			var/mob/living/carbon/human/the_human = M
			if(the_human.physiology.burn_mod < 2)
				the_human.physiology.burn_mod *= 2
				the_human.visible_message("<span class='warning'>[the_human] seemed weakend!</span>")
				spawn(reac_volume SECONDS)
					the_human.physiology.burn_mod *= 0.5
					the_human.visible_message("<span class='warning'>[the_human] has returned to normal!</span>")
	return ..()
