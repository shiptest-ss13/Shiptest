///////////////////
// STATUS EFFECT //
///////////////////
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
	// Try to match normal reagent tick rate based on on_mob_life
	tick_interval = 20
	// Used to make icon for status_effect
	var/flask_icon_state
	var/flask_icon = 'icons/obj/drinks/drinks.dmi'
	// Used for mod outline
	var/reagent_color = "#FFFFFF"
	var/message_apply_others = "is affected by a wine!"
	var/message_apply_self = "You are affected by trickwine!"
	var/message_remove_others = "is no longer affected by a wine!"
	var/message_remove_self = "You are no longer affected by trickwine!"
	var/trickwine_examine_text
	var/alert_desc
	// Applied and removes with reagent
	var/trait

/datum/status_effect/trickwine/on_creation(mob/living/new_owner, datum/reagent/consumable/ethanol/trickwine/trickwine_reagent)
	flask_icon_state = trickwine_reagent.breakaway_flask_icon_state
	if(!trickwine_reagent)
		CRASH("A trickwine status effect was created without a attached reagent")
	reagent_color = trickwine_reagent.color
	. = ..()
	if(istype(linked_alert, /atom/movable/screen/alert/status_effect/trickwine))
		var/atom/movable/screen/alert/status_effect/trickwine/trickwine_alert = linked_alert
		trickwine_alert.setup(trickwine_reagent)
		trickwine_alert.desc = alert_desc

/datum/status_effect/trickwine/on_apply()
	owner.visible_message(span_notice("[owner] " + message_apply_others), span_notice(message_apply_self))
	owner.add_filter(id, 2, drop_shadow_filter(x = 0, y = -1, size = 2, color = reagent_color))
	if(trait)
		ADD_TRAIT(owner, trait, id)
	return ..()

/datum/status_effect/trickwine/on_remove()
	owner.visible_message(span_notice("[owner] " + message_remove_others), span_notice(message_remove_self))
	owner.remove_filter(id)
	if(trait)
		REMOVE_TRAIT(owner, trait, id)

//////////
// BUFF //
//////////
/datum/status_effect/trickwine/buff
	id = "trick_wine_buff"
	alert_desc = "Your empowered a trickwine!"

/datum/status_effect/trickwine/buff/on_creation(mob/living/new_owner, datum/reagent/consumable/ethanol/trickwine/trickwine_reagent)
	. = ..()
	if(trickwine_examine_text)
		examine_text = span_notice(trickwine_examine_text)
	else
		examine_text = span_notice("SUBJECTPRONOUN seems to be affected by [trickwine_reagent.name].")

////////////
// DEBUFF //
////////////
/datum/status_effect/trickwine/debuff
	id = "trick_wine_debuff"
	alert_desc = "Your weakened a trickwine!"

/datum/status_effect/trickwine/debuff/on_creation(mob/living/new_owner, datum/reagent/consumable/ethanol/trickwine/trickwine_reagent, set_duration = null)
	if(isnum(set_duration))
		duration = set_duration
	. = ..()
	if(trickwine_examine_text)
		examine_text = span_notice(trickwine_examine_text)
	else
		examine_text = span_notice("SUBJECTPRONOUN seems to be covered in [trickwine_reagent.name].")

//////////////
// REAGENTS //
//////////////

/datum/reagent/consumable/ethanol/trickwine
	name = "Trickwine"
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
			exposed_mob.apply_status_effect(debuff_effect, src, (reac_volume * ETHANOL_METABOLISM) * 2) //Goal is it have the same duration as when you drink it.
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
	buff_effect = /datum/status_effect/trickwine/buff/ash
	debuff_effect = /datum/status_effect/trickwine/debuff/ash

/datum/reagent/consumable/ethanol/trickwine/ash_wine/on_mob_life(mob/living/M)
	var/high_message = pick("You feel far more devoted to the cause", "You feel like you should go on a hunt")
	var/cleanse_message = pick("Divine light purifies you.", "You are purged of foul spirts.")
	if(prob(10))
		M.adjust_drugginess(5)
		to_chat(M, "<span class='notice'>[high_message]</span>")
	if(M.faction && ("roumain" in M.faction))
		M.adjustToxLoss(-2)
		if(prob(10))
			to_chat(M, "<span class='notice'>[cleanse_message]</span>")
	return ..()

/datum/reagent/consumable/ethanol/trickwine/ash_wine/expose_mob(mob/living/M, method=TOUCH, reac_volume)
	if(method == TOUCH)
		if(!iscarbon(M))

			// This all needs to be refactored
			var/mob/living/simple_animal/hostile/hostile_target = M
			var/hostile_ai_status = hostile_target.AIStatus
			hostile_target.toggle_ai(AI_OFF)
			addtimer(VARSET_CALLBACK(hostile_target, AIStatus, hostile_ai_status),reac_volume)
	return ..()

/datum/status_effect/trickwine/buff/ash
	id = "ash_wine_buff"
	trickwine_examine_text = "SUBJECTPRONOUN seems to be filled with energy and devotion. There eyes are dialated and they seem to be twitching."

/datum/status_effect/trickwine/debuff/ash
	id = "ash_wine_debuff"
	trickwine_examine_text = "SUBJECTPRONOUN seems to be covered in a thin layer of ash. They seem to be twitching and jittery."

/datum/status_effect/trickwine/debuff/ash/tick()
	//	I probally cant do this but im on my laptop
	pick(owner.Jitter(3), owner.Dizzy(2), owner.adjust_drugginess(3))

	switch(pick(list("jitter", "dizzy", "drug")))
		if("jitter")
			owner.Jitter(3)
		if("dizzy")
			owner.Dizzy(2)
		if("drug")
			owner.adjust_drugginess(3)

/datum/reagent/consumable/ethanol/trickwine/ice_wine
	name = "Icewine"
	description = "A specialized brew utilized by members of the Saint-Roumain Militia, designed to assist in temperature regulation while working in hot environments. Known to give one the cold shoulder when thrown."
	color = "#C0F1EE"
	boozepwr = 70
	taste_description = "a cold night on the hunt"
	glass_name = "Icewine"
	glass_desc = "A specialized brew utilized by members of the Saint-Roumain Militia, designed to assist in temperature regulation while working in hot environments. Known to give one the cold shoulder when thrown."
	breakaway_flask_icon_state = "baflaskicewine"
	buff_effect = /datum/status_effect/trickwine/buff/ice
	debuff_effect = /datum/status_effect/trickwine/debuff/ice

/datum/reagent/consumable/ethanol/trickwine/ice_wine/on_mob_life(mob/living/M)
	M.adjust_bodytemperature(-5 * TEMPERATURE_DAMAGE_COEFFICIENT, M.get_body_temp_normal())
	M.adjustFireLoss(-1)
	return ..()

/datum/status_effect/trickwine/buff/ice
	id = "ice_wine_buff"
	trait = TRAIT_NOFIRE

/datum/status_effect/trickwine/debuff/ice
	id = "ice_wine_debuff"
	var/icon/cube

/datum/status_effect/trickwine/debuff/ice/on_apply()
	walk(owner, 0) //stops them mid pathing even if they're stunimmunee
	RegisterSignal(owner, COMSIG_MOVABLE_PRE_MOVE, PROC_REF(owner_moved))
	owner.Paralyze(duration)
	to_chat(owner, span_userdanger("You become frozen in a cube!"))
	cube = icon('icons/effects/freeze.dmi', "ice_cube")
	var/icon/size_check = icon(owner.icon, owner.icon_state)
	cube.Scale(size_check.Width(), size_check.Height())
	owner.add_overlay(cube)
	return ..()

/// Blocks movement from the status effect owner
/datum/status_effect/trickwine/debuff/ice/proc/owner_moved()
	return COMPONENT_MOVABLE_BLOCK_PRE_MOVE

/datum/status_effect/trickwine/debuff/ice/on_remove()
	to_chat(owner, span_notice("The cube melts!"))
	owner.cut_overlay(cube)
	UnregisterSignal(owner, COMSIG_MOVABLE_PRE_MOVE)

/datum/reagent/consumable/ethanol/trickwine/shock_wine
	name = "Shockwine"
	description = "A stimulating brew utilized by members of the Saint-Roumain Militia, created to allow trackers to keep up with highly mobile prey. Known to have a shocking effect when thrown"
	color = "#FEFEB8"
	boozepwr = 70
	taste_description = "the adrenaline of the chase"
	glass_name = "Shockwine"
	glass_desc = "A stimulating brew utilized by members of the Saint-Roumain Militia, created to allow trackers to keep up with highly mobile prey. Known to have a shocking effect when thrown"
	breakaway_flask_icon_state = "baflaskshockwine"
	buff_effect = /datum/status_effect/trickwine/buff/shock
	debuff_effect = /datum/status_effect/trickwine/debuff/shock

/datum/reagent/consumable/ethanol/trickwine/shock_wine/expose_mob(mob/living/M, method=TOUCH, reac_volume)
	if(method == TOUCH)
		M.electrocute_act(reac_volume, src, siemens_coeff = 1, flags = SHOCK_NOSTUN|SHOCK_TESLA)
		do_sparks(5, FALSE, M)
		playsound(M, 'sound/machines/defib_zap.ogg', 100, TRUE)
	return ..()

/datum/status_effect/trickwine/buff/shock
	id = "shock_wine_buff"
	trickwine_examine_text = "SUBJECTPRONOUN seems to be crackling with energy."
	message_apply_others =  "seems to be crackling with energy!"
	message_apply_self = "You feel faster than lightning!"
	message_remove_others = "has lost their statis energy."
	message_remove_self = "You feel sluggish."
	alert_desc = "You feel faster then lightning and cracking with energy! Your immune to shock damage and move faster!"
	trait = TRAIT_SHOCKIMMUNE

/datum/status_effect/trickwine/buff/shock/on_apply()
	owner.add_movespeed_modifier(/datum/movespeed_modifier/reagent/shock_wine)
	return ..()

/datum/status_effect/trickwine/buff/shock/on_remove()
	owner.remove_movespeed_modifier(/datum/movespeed_modifier/reagent/shock_wine)
	..()

/datum/status_effect/trickwine/debuff/shock
	id = "shock_wine_debuff"

/datum/status_effect/trickwine/debuff/shock/tick()
	if(rand(25))
		do_sparks(5, FALSE, owner)

/datum/reagent/consumable/ethanol/trickwine/hearth_wine
	name = "Hearthwine"
	description = "A fiery brew utilized by members of the Saint-Roumain Militia, engineered to cauterize wounds in the field. Goes out in a blaze of glory when thrown."
	color = "#FEE185"
	boozepwr = 70
	taste_description = "the heat of battle"
	glass_name = "Hearthwine"
	glass_desc = "Fiery brew utilized by members of the Saint-Roumain Militia, engineered to cauterize wounds in the field. Goes out in a blaze of glory when thrown."
	breakaway_flask_icon_state = "baflaskhearthwine"
	buff_effect = /datum/status_effect/trickwine/buff/hearth
	debuff_effect = /datum/status_effect/trickwine/debuff/hearth

//This needs a buff
/datum/reagent/consumable/ethanol/trickwine/hearth_wine/on_mob_life(mob/living/M)
	M.adjust_bodytemperature(5 * TEMPERATURE_DAMAGE_COEFFICIENT, M.get_body_temp_normal())
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		H.heal_bleeding(0.25)
	return ..()

/datum/status_effect/trickwine/buff/hearth
	id = "hearth_wine_buff"
	trait = TRAIT_RESISTCOLD

/datum/status_effect/trickwine/debuff/hearth
	id = "hearth_wine_debuff"

/datum/status_effect/trickwine/debuff/hearth/tick()
	owner.fire_act()
	var/turf/owner_turf = get_turf(owner)
	owner_turf.IgniteTurf(duration)
	new /obj/effect/hotspot(owner_turf, duration, FIRE_MINIMUM_TEMPERATURE_TO_EXIST + duration * 10)

/datum/reagent/consumable/ethanol/trickwine/force_wine
	name = "Forcewine"
	description = "Creates a barrier on the skin that catches sharpnel and when reversed locks threats down with a barrier"
	color = "#709AAF"
	boozepwr = 70
	taste_description = "the strength of your convictions"
	glass_name = "Forcewine"
	glass_desc = "Creates a barrier on the skin that catches sharpnel and when reversed locks threats down with a barrier"
	breakaway_flask_icon_state = "baflaskforcewine"
	buff_effect = /datum/status_effect/trickwine/buff/force
	debuff_effect = /datum/status_effect/trickwine/debuff/force

//Completenly useless rn.
/datum/status_effect/trickwine/buff/force
	id = "force_wine_buff"
	message_apply_others =  "glows a dim grey aura."
	message_apply_self = "You feel faster than lightning!"
	message_remove_others = "'s aura fades away."
	message_remove_self = "You feel sluggish."
	// No shrapnel seems useful
	trait = TRAIT_PIERCEIMMUNE

/datum/status_effect/trickwine/debuff/force
	id = "force_wine_debuff"

/datum/status_effect/trickwine/debuff/force/on_apply()
	var/turf/turf = get_turf(owner)
	var/turf/other_turf
	new /obj/effect/forcefield/resin(turf, duration)
	for(var/direction in GLOB.cardinals)
		other_turf = get_step(turf, direction)
		new /obj/effect/forcefield/resin(other_turf, duration)
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
	buff_effect = /datum/status_effect/trickwine/buff/prism
	debuff_effect = /datum/status_effect/trickwine/debuff/prism

/datum/status_effect/trickwine/buff/prism
	id = "prism_wine_buff"
	trait = TRAIT_REFLECTIVE

/datum/status_effect/trickwine/buff/prism/on_apply()
	if(ishuman(owner))
		var/mob/living/carbon/human/the_human = owner
		the_human.physiology.burn_mod *= 0.5
	owner.visible_message(span_warning("[owner] seems to shimmer with power!"))
	return ..()

/datum/status_effect/trickwine/buff/prism/on_remove()
	if(ishuman(owner))
		var/mob/living/carbon/human/the_human = owner
		the_human.physiology.burn_mod *= 2
	owner.visible_message(span_warning("[owner] has returned to normal!"))
	..()

/datum/status_effect/trickwine/debuff/prism
	id = "prism_wine_debuff"

/datum/status_effect/trickwine/debuff/prism/on_apply()
	/*
	if(istype(owner, /mob/living/simple_animal))
		var/mob/living/simple_animal/the_animal = owner
		the_animal.armor.modifyRating(energy = -50)
	*/
	if(ishuman(owner))
		var/mob/living/carbon/human/the_human = owner
		the_human.physiology.burn_mod *= 2
		the_human.visible_message(span_warning("[the_human] seems weakened!"))
	return ..()

/datum/status_effect/trickwine/debuff/prism/on_remove()
	/*
	if(istype(owner, /mob/living/simple_animal))
		var/mob/living/simple_animal/the_animal = owner
		the_animal.armor.modifyRating(energy = 50)
	*/
	if(ishuman(owner))
		var/mob/living/carbon/human/the_human = owner
		the_human.physiology.burn_mod *= 0.5
		the_human.visible_message(span_warning("[the_human] has returned to normal!"))
	..()
