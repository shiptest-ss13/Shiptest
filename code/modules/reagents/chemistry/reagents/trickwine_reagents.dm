/datum/reagent/consumable/ethanol/ash_wine
	name = "Ashwine"
	description = "A traditional sacrament for members of the Saint-Roumain Militia. Known to grant visions, and is used both for ritual and entertainment purposes aboard Saint-Roumain vessels."
	color = "#293D25"
	boozepwr = 80
	quality = DRINK_VERYGOOD
	taste_description = "devotional energy and a hint of high-potency hallucinogens"
	glass_name = "Ashwine"
	glass_desc = "A traditional sacrament for members of the Saint-Roumain Militia. Known to grant visions, and is used both for ritual and entertainment purposes aboard Saint-Roumain vessels."
	breakaway_flask_icon_state = "baflaskashwine"

/datum/reagent/consumable/ethanol/ash_wine/on_mob_life(mob/living/M)
	var/high_message = pick("you feel far more devoted to the cause", "you feel like you should go on a hunt")
	var/cleanse_message = pick("divine light purifies you", "you are purged of foul spirts")
	//needs to get updated anytime someone adds a srm job
	var/static/list/increased_toxin_loss = list("Hunter Montagne", "Hunter Doctor", "Hunter", "Shadow")
	if(prob(10))
		M.set_drugginess(10)
		to_chat(M, "<span class='notice'>[high_message]</span>")
	if(M.mind && (M.mind.assigned_role in increased_toxin_loss))
		M.adjustToxLoss(-2)
		if(prob(10))
			to_chat(M, "<span class='notice'>[cleanse_message]</span>")
	..()
	. = 1

/datum/reagent/consumable/ethanol/ash_wine/expose_mob(mob/living/M, method=TOUCH, reac_volume)
	if(method == TOUCH)
		if(!iscarbon(M))
			reac_volume = reac_volume * 2
		M.Jitter(3 * reac_volume)
		M.Dizzy(2 * reac_volume)
		M.set_drugginess(3 * reac_volume)
		M.emote(pick("twitch","giggle"))

/datum/reagent/consumable/ethanol/ice_wine
	name = "Icewine"
	description = "A specialized brew utilized by members of the Saint-Roumain Militia, designed to assist in temperature regulation while working in hot environments. Known to give one the cold shoulder when thrown."
	color = "#21EFEB"
	boozepwr = 70
	taste_description = "a cold night on the hunt"
	glass_name = "Icewine"
	glass_desc = "A specialized brew utilized by members of the Saint-Roumain Militia, designed to assist in temperature regulation while working in hot environments. Known to give one the cold shoulder when thrown."
	breakaway_flask_icon_state = "baflaskicewine"

/datum/reagent/consumable/ethanol/ice_wine/on_mob_life(mob/living/M)
	M.adjust_bodytemperature(-10 * TEMPERATURE_DAMAGE_COEFFICIENT, M.get_body_temp_normal())
	M.adjustFireLoss(-1)
	..()
	. = 1

/datum/reagent/consumable/ethanol/ice_wine/expose_mob(mob/living/M, method=TOUCH, reac_volume)
	if(method == TOUCH)
		if(!iscarbon(M))
			reac_volume = reac_volume * 2
		M.adjust_bodytemperature((-20*reac_volume) * TEMPERATURE_DAMAGE_COEFFICIENT)
		M.Paralyze(reac_volume)
		walk(M, 0) //stops them mid pathing even if they're stunimmunee
		M.apply_status_effect(/datum/status_effect/ice_block_talisman, (0.1 * reac_volume) SECONDS)

/datum/reagent/consumable/ethanol/shock_wine
	name = "Shock Wine"
	description = "A stimulating brew utilized by members of the Saint-Roumain Militia, created to allow trackers to keep up with highly mobile prey. Known to have a shocking effect when thrown"
	color = "#00008b"
	boozepwr = 70
	taste_description = "the adrenaline of the chase"
	glass_name = "Shock Wine"
	glass_desc = "A stimulating brew utilized by members of the Saint-Roumain Militia, created to allow trackers to keep up with highly mobile prey. Known to have a shocking effect when thrown"
	breakaway_flask_icon_state = "baflaskshockwine"

/datum/reagent/consumable/ethanol/shock_wine/on_mob_metabolize(mob/living/M)
	..()
	M.add_movespeed_modifier(/datum/movespeed_modifier/reagent/shock_wine)

/datum/reagent/consumable/ethanol/shock_wine/on_mob_end_metabolize(mob/living/M)
	M.remove_movespeed_modifier(/datum/movespeed_modifier/reagent/shock_wine)
	..()

/datum/reagent/consumable/ethanol/shock_wine/expose_mob(mob/living/M, method=TOUCH, reac_volume)
	if(method == TOUCH)
		//simple mobs are so tanky and i want this to be useful on them
		if(iscarbon(M))
			reac_volume = reac_volume / 4
		M.electrocute_act(reac_volume, src, siemens_coeff = 1, flags = SHOCK_NOSTUN|SHOCK_TESLA)
		do_sparks(5, FALSE, M)
		playsound(M, 'sound/machines/defib_zap.ogg', 100, TRUE)

/datum/reagent/consumable/ethanol/hearth_wine
	name = "Hearth Wine"
	description = "A fiery brew utilized by members of the Saint-Roumain Militia, engineered to cauterize wounds in the field. Goes out in a blaze of glory when thrown."
	color = "#ff8c00"
	boozepwr = 70
	taste_description = "the heat of battle"
	glass_name = "Hearth Wine"
	glass_desc = "Fiery brew utilized by members of the Saint-Roumain Militia, engineered to cauterize wounds in the field. Goes out in a blaze of glory when thrown."

/datum/reagent/consumable/ethanol/hearth_wine/on_mob_life(mob/living/M)
	M.adjust_bodytemperature(-10 * TEMPERATURE_DAMAGE_COEFFICIENT, M.get_body_temp_normal())
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		H.bleed_rate = max(H.bleed_rate - 0.25, 0)
	..()
	. = 1

/datum/reagent/consumable/ethanol/hearth_wine/expose_mob(mob/living/M, method=TOUCH, reac_volume)
	if(!iscarbon(M))
		reac_volume = reac_volume * 2
	M.fire_act()
	var/turf/T = get_turf(M)
	T.IgniteTurf(reac_volume)
	new /obj/effect/hotspot(T)
	T.hotspot_expose((reac_volume*20),(reac_volume*2))

/datum/reagent/consumable/ethanol/force_wine
	name = "Force Wine"
	description = "A fortifying brew utilized by members of the Saint-Roumain Militia, created to protect against the esoteric. Known to act defensively when thrown."
	color = "#8b008b"
	boozepwr = 70
	taste_description = "the strength of your convictions"
	glass_name = "Force Wine"
	glass_desc = "A fortifying brew utilized by members of the Saint-Roumain Militia, created to protect against the esoteric. Known to act defensively when thrown."

/datum/reagent/consumable/ethanol/force_wine/on_mob_metabolize(mob/living/M)
	..()
	ADD_TRAIT(M, TRAIT_ANTIMAGIC, type)

/datum/reagent/consumable/ethanol/force_wine/on_mob_end_metabolize(mob/living/M)
	REMOVE_TRAIT(M, TRAIT_ANTIMAGIC, type)
	..()

/datum/reagent/consumable/ethanol/force_wine/expose_turf(turf/T, reac_volume)
	var/turf/otherT
	for(var/direction in GLOB.cardinals)
		if(reac_volume < 10)
			break
		reac_volume -= 10
		otherT = get_step(T, direction)
		new /obj/effect/forcefield(otherT)
