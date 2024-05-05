/datum/reagent/consumable/ethanol/trickwine
	name = "Trickwine"
	description = "How is this even possible"
	var/datum/status_effect/trickwine/debuff_effect = null
	var/datum/status_effect/trickwine/buff_effect = null

/datum/reagent/consumable/ethanol/trickwine/on_mob_metabolize(mob/living/consumer)
	if(buff_effect)
		consumer.apply_status_effect(buff_effect, src)
	..()

/datum/reagent/consumable/ethanol/trickwine/on_mob_end_metabolize(mob/living/consumer)
	if(buff_effect && consumer.has_status_effect(buff_effect))
		consumer.remove_status_effect((buff_effect))
	..()

/datum/reagent/consumable/ethanol/trickwine/expose_mob(mob/living/exposed_mob, method = TOUCH, reac_volume)
	if(method == TOUCH)
		if(debuff_effect)
			exposed_mob.apply_status_effect(debuff_effect, src, reac_volume SECONDS)
	return ..()

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
			hostile_target.AIStatus = AI_OFF
			addtimer(VARSET_CALLBACK(hostile_target, AIStatus, hostile_ai_status),reac_volume)
		M.Jitter(3 * reac_volume)
		M.Dizzy(2 * reac_volume)
		M.set_drugginess(3 * reac_volume)
		M.emote(pick("twitch","giggle"))
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
		H.bleed_rate = max(H.bleed_rate - 0.25, 0)
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
		for(var/direction in GLOB.cardinals)
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
	buff_effect = /datum/status_effect/trickwine/buff/force

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
	debuff_effect = /datum/status_effect/trickwine/debuff/prism

/datum/reagent/consumable/ethanol/trickwine/prism_wine/on_mob_metabolize(mob/living/carbon/human/M)
	..()
	ADD_TRAIT(M, TRAIT_REFLECTIVE, "trickwine")
	if(M.physiology.burn_mod <= initial(M.physiology.burn_mod))
		M.physiology.burn_mod *= 0.5
	M.add_filter("prism-wine", 2, list("type"="outline", "color"="#8FD7DF", "size"=1))
	M.visible_message("<span class='warning'>[M] seems to shimmer with power!</span>")

/datum/reagent/consumable/ethanol/trickwine/prism_wine/on_mob_end_metabolize(mob/living/carbon/human/M)
	REMOVE_TRAIT(M, TRAIT_REFLECTIVE, "trickwine")
	if(M.physiology.burn_mod > initial(M.physiology.burn_mod))
		M.physiology.burn_mod *= 2
	M.remove_filter("prism-wine")
	M.visible_message("<span class='warning'>[M] has returned to normal!</span>")
	..()

////////////////////
// STATUS EFFECTS //
////////////////////
/atom/movable/screen/alert/status_effect/trickwine
	name = "Trickwine"
	desc = "Your empowered or weakened by a trickwine!"
	icon_state = "breakaway_flask"

/atom/movable/screen/alert/status_effect/trickwine/proc/setup(datum/reagent/consumable/ethanol/trickwine/trickwine_reagent)
	name = trickwine_reagent.name
	icon_state = "template"
	cut_overlays()
	var/icon/flask_icon = icon('icons/obj/drinks/drinks.dmi', trickwine_reagent.breakaway_flask_icon_state)
	add_overlay(flask_icon)

/datum/status_effect/trickwine
	id = "trick_wine"
	examine_text = span_notice("They seem to be affected by a trickwine.")
	alert_type = /atom/movable/screen/alert/status_effect/trickwine
	var/flask_icon_state
	var/flask_icon = 'icons/obj/drinks/drinks.dmi'

/datum/status_effect/trickwine/on_creation(mob/living/new_owner, datum/reagent/consumable/ethanol/trickwine/trickwine_reagent)
	flask_icon_state = trickwine_reagent.breakaway_flask_icon_state
	. = ..()
	if(!trickwine_reagent)
		CRASH("A trickwine status effect was created without a attached reagent")
	if(istype(linked_alert, /atom/movable/screen/alert/status_effect/trickwine))
		var/atom/movable/screen/alert/status_effect/trickwine/trickwine_alert = linked_alert
		trickwine_alert.setup(trickwine_reagent)

/datum/status_effect/trickwine/on_apply()
	owner.visible_message(span_notice("[owner] is affected by a wine!"), span_notice("You are affected by trickwine!"))
	owner.add_filter(id, 2, list("type"="outline", "color"="#8FD7DF", "size"=1))
	return ..()

/datum/status_effect/trickwine/on_remove()
	owner.visible_message(span_notice("[owner] is no longer affected by a wine!"), span_notice("You are no longer affected by trickwine!"))
	owner.remove_filter(id)
///////////
// BUFFS //
///////////
/datum/status_effect/trickwine/buff
	id = "trick_wine_buff"
	examine_text = span_notice("IDK what to make this yet")

/datum/status_effect/trickwine/buff/on_creation(mob/living/new_owner, datum/reagent/consumable/ethanol/trickwine/trickwine_reagent)
	. = ..()
	examine_text = span_notice("They seem to be affected by [trickwine_reagent.name].")

/datum/status_effect/trickwine/buff/force
	id = "force_wine_buff"

/datum/status_effect/trickwine/buff/force/on_apply()
	ADD_TRAIT(owner, TRAIT_ANTIMAGIC, "trickwine")
	ADD_TRAIT(owner, TRAIT_MINDSHIELD, "trickwine")
	owner.visible_message(span_warning("[owner] glows a dim grey aura"))
	return ..()

/datum/status_effect/trickwine/buff/force/on_remove()
	REMOVE_TRAIT(owner, TRAIT_ANTIMAGIC, "trickwine")
	REMOVE_TRAIT(owner, TRAIT_MINDSHIELD, "trickwine")
	owner.visible_message(span_warning("[owner]'s aura fades away"))

/////////////
// DEBUFFS //
/////////////
/datum/status_effect/trickwine/debuff
	id = "trick_wine_debuff"
	examine_text = span_notice("They seem to be covered in a trickwine.")

/datum/status_effect/trickwine/debuff/on_creation(mob/living/new_owner, datum/reagent/consumable/ethanol/trickwine/trickwine_reagent, set_duration = null)
	if(isnum(set_duration))
		duration = set_duration
	. = ..()
	examine_text = span_notice("They seem to be covered in [trickwine_reagent.name].")

/datum/status_effect/trickwine/debuff/prism
	id = "prism_wine_debuff"

/datum/status_effect/trickwine/debuff/prism/on_apply()
	if(istype(owner, /mob/living/simple_animal/hostile/asteroid))
		var/mob/living/simple_animal/hostile/asteroid/the_animal = owner
		the_animal.armor.modifyRating(energy = -50)
	if(ishuman(owner))
		var/mob/living/carbon/human/the_human = owner
		if(the_human.physiology.burn_mod < 2)
			the_human.physiology.burn_mod *= 2
			the_human.visible_message(span_warning("[the_human] seems weakened!"))
	return ..()

/datum/status_effect/trickwine/debuff/prism/on_remove()
	if(istype(owner, /mob/living/simple_animal/hostile/asteroid))
		var/mob/living/simple_animal/hostile/asteroid/the_animal = owner
		the_animal.armor.modifyRating(energy = 50)
	if(ishuman(owner))
		var/mob/living/carbon/human/the_human = owner
		the_human.physiology.burn_mod *= 0.5
		the_human.visible_message(span_warning("[the_human] has returned to normal!"))
