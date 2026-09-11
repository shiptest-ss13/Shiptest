///////////////////
// STATUS EFFECT //
///////////////////
/datum/status_effect/trickwine
	id = "trick_wine"
	// Try to match normal reagent tick rate based on on_mob_life
	tick_interval = 20
	alert_type = null
	var/obj/effect/abstract/particle_holder/particle_generator
	// Used to make icon for status_effect
	var/flask_icon_state
	var/flask_icon = 'icons/obj/drinks/trickwine.dmi'
	// Used for mod outline
	var/reagent_color = "#FFFFFF"
	// Applied and removes with reagent
	var/trait

/datum/status_effect/trickwine/on_creation(mob/living/new_owner, datum/reagent/consumable/ethanol/trickwine/trickwine_reagent)
	flask_icon_state = trickwine_reagent.breakaway_flask_icon_state
	if(!trickwine_reagent)
		CRASH("A trickwine status effect was created without a attached reagent")
	reagent_color = trickwine_reagent.color
	. = ..()

/datum/status_effect/trickwine/on_apply()
	if(trait)
		ADD_TRAIT(owner, trait, id)
	if(!particle_generator)
		particle_generator = new(owner, /particles/trickwine_drunk, PARTICLE_ATTACH_MOB)
		particle_generator.particles.color = reagent_color
	return ..()

/datum/status_effect/trickwine/on_remove()
	if(trait)
		REMOVE_TRAIT(owner, trait, id)
	if(particle_generator)
		QDEL_NULL(particle_generator)

/datum/status_effect/trickwine/get_examine_text()

//////////
// BUFF //
//////////
/datum/status_effect/trickwine/buff
	id = "trick_wine_buff"

//////////////
// REAGENTS //
//////////////

/datum/reagent/consumable/ethanol/trickwine
	name = "Trickwine"
	var/datum/status_effect/trickwine/debuff_effect = null
	var/datum/status_effect/trickwine/buff_effect = null
	//the kind of ammo you get from dipping 38 in this
	bad_type = /datum/reagent/consumable/ethanol/trickwine

/datum/reagent/consumable/ethanol/trickwine/on_mob_metabolize(mob/living/consumer)
	if(buff_effect)
		consumer.apply_status_effect(buff_effect, src)
	..()

/datum/reagent/consumable/ethanol/trickwine/on_mob_end_metabolize(mob/living/consumer)
	if(buff_effect && consumer.has_status_effect(buff_effect))
		consumer.remove_status_effect((buff_effect))
	..()

/datum/reagent/consumable/ethanol/trickwine/ash_wine
	name = "Wine of Ash"
	description = "A traditional sacrament for members of the Saint-Roumain Militia. Believed to grant visions, seeing use both in ritual and entertainment within the Militia."
	color = "#6CC66C"
	boozepwr = 80
	quality = DRINK_VERYGOOD
	taste_description = "a rustic fruit, with hints of sweet yet tangy ash."
	glass_name = "Wine of Ash"
	glass_desc = "A traditional sacrament for members of the Saint-Roumain Militia. Believed to grant visions, seeing use both in ritual and entertainment within the Militia."
	breakaway_flask_icon_state = "baflaskashwine"
	buff_effect = /datum/status_effect/trickwine/buff/ash

/datum/reagent/consumable/ethanol/trickwine/ash_wine/on_mob_life(mob/living/M, seconds_per_tick, times_fired)
	var/high_message = pick("You feel far more devoted to the cause.", "You feel like you should go on a hunt.")
	var/cleanse_message = pick("Divine light purifies you.", "You are purged of foul spirts.")
	M.adjustToxLoss(-0.5 * seconds_per_tick)
	if(SPT_PROB(5, seconds_per_tick))
		to_chat(M, span_notice("[high_message]"))
	if(M.faction && ("roumain" in M.faction))
		if(SPT_PROB(5, seconds_per_tick))
			to_chat(M, span_notice("[cleanse_message]"))
	return ..()

/datum/status_effect/trickwine/buff/ash
	id = "ash_wine_buff"
	//message_apply_others =  ""
	//message_apply_self = ""
	//message_remove_others = ""
	//message_remove_self = ""
	//alert_desc = ""

/datum/status_effect/trickwine/buff/ash/get_examine_text()
	return span_notice("[owner.p_they(TRUE)] [owner.p_are()] filled with energy and devotion! [owner.p_their(TRUE)] eyes are dilated and [owner.p_they()] [owner.p_are()] twitching.")

/datum/reagent/consumable/ethanol/trickwine/ice_wine
	name = "Wine of Ice"
	description = "A specialized brew utilized by members of the Saint-Roumain Militia, mixed with a set of medicinal herbs that help treat burns."
	color = "#C0F1EE"
	boozepwr = 70
	taste_description = "a weighty meat, undercut by a mild pepper."
	glass_name = "Wine of Ice"
	glass_desc = "A specialized brew utilized by members of the Saint-Roumain Militia, mixed with a set of medicinal herbs that help treat burns."
	breakaway_flask_icon_state = "baflaskicewine"
	buff_effect = /datum/status_effect/trickwine/buff/ice

/datum/reagent/consumable/ethanol/trickwine/ice_wine/on_mob_life(mob/living/M, seconds_per_tick, times_fired)
	M.adjust_bodytemperature(-5 * TEMPERATURE_DAMAGE_COEFFICIENT, M.get_body_temp_normal(), FALSE)
	M.adjustFireLoss(-0.5)
	return ..()

/datum/status_effect/trickwine/buff/ice
	id = "ice_wine_buff"
	//trickwine_examine_text = ""
	//message_apply_others =  ""
	//message_apply_self = ""
	//message_remove_others = ""
	//message_remove_self = ""
	//alert_desc = ""

/datum/reagent/consumable/ethanol/trickwine/shock_wine
	name = "Lightning's Blessing"
	description = "A stimulating brew utilized by members of the Saint-Roumain Militia, created to allow trackers to keep up with highly mobile prey."
	color = "#FEFEB8"
	boozepwr = 50
	taste_description = "a sharp and unrelenting citrus"
	glass_name = "Lightning's Blessing"
	glass_desc = "A stimulating brew utilized by members of the Saint-Roumain Militia, created to allow trackers to keep up with highly mobile prey."
	breakaway_flask_icon_state = "baflaskshockwine"
	buff_effect = /datum/status_effect/trickwine/buff/shock

/datum/status_effect/trickwine/buff/shock
	id = "shock_wine_buff"

/datum/status_effect/trickwine/buff/shock/on_apply()
	owner.add_movespeed_modifier(/datum/movespeed_modifier/reagent/shock_wine)
	return ..()

/datum/status_effect/trickwine/buff/shock/on_remove()
	owner.remove_movespeed_modifier(/datum/movespeed_modifier/reagent/shock_wine)
	..()

/datum/reagent/consumable/ethanol/trickwine/hearth_wine
	name = "Hearthflame"
	description = "A fiery brew utilized by members of the Saint-Roumain Militia, engineered to heat the body and staunch wounds."
	color = "#FEE185"
	boozepwr = 70
	taste_description = "apple cut apart by tangy pricks"
	glass_name = "Hearthflame"
	glass_desc = "A fiery brew utilized by members of the Saint-Roumain Militia, engineered to heat the body and staunch wounds."
	breakaway_flask_icon_state = "baflaskhearthwine"
	buff_effect = /datum/status_effect/trickwine/buff/hearth
	/// While this reagent is in our bloodstream, we reduce all bleeding by this factor
	var/passive_bleed_modifier = 0.4
	/// For tracking when we tell the person we're no longer bleeding
	var/was_working

/datum/reagent/consumable/ethanol/trickwine/hearth_wine/on_mob_metabolize(mob/living/M)
	ADD_TRAIT(M, TRAIT_COAGULATING, /datum/reagent/consumable/ethanol/trickwine/hearth_wine)
	if(!ishuman(M))
		return

	var/mob/living/carbon/human/blood_boy = M
	blood_boy.physiology?.bleed_mod *= passive_bleed_modifier
	return ..()

/datum/reagent/consumable/ethanol/trickwine/hearth_wine/on_mob_end_metabolize(mob/living/M)
	REMOVE_TRAIT(M, TRAIT_COAGULATING, /datum/reagent/consumable/ethanol/trickwine/hearth_wine)
	//should probably generic proc this at a later point. I'm probably gonna use it a bit
	if(was_working)
		to_chat(M, span_warning("The alcohol thickening your blood loses its effect!"))
	if(!ishuman(M))
		return

	var/mob/living/carbon/human/blood_boy = M
	blood_boy.physiology?.bleed_mod /= passive_bleed_modifier

	return ..()

/datum/reagent/consumable/ethanol/trickwine/hearth_wine/on_mob_life(mob/living/M, seconds_per_tick, times_fired)
	M.adjust_bodytemperature(5 * TEMPERATURE_DAMAGE_COEFFICIENT, M.get_body_temp_normal(), FALSE)
	if(!ishuman(M))
		return ..()
	var/mob/living/carbon/guy_who_probably_got_shot = M
	if(SPT_PROB(10, seconds_per_tick) && length(guy_who_probably_got_shot.all_wounds))
		to_chat(M, span_warning("Your cuts and punctures sear for a second, before ceasing their bloody flow!"))
		for(var/datum/wound/slash/flesh/cut in guy_who_probably_got_shot.all_wounds)
			cut.remove_wound()
		for(var/datum/wound/pierce/bleed/hole in guy_who_probably_got_shot.all_wounds)
			hole.remove_wound()

	if(SPT_PROB(5, seconds_per_tick) && length(guy_who_probably_got_shot.all_wounds))
		to_chat(M, span_warning("Warmth blossoms across your body!"))
		for(var/datum/wound/muscle/muscle_ouchie in guy_who_probably_got_shot.all_wounds)
			muscle_ouchie.remove_wound()
		for(var/obj/item/organ/O in guy_who_probably_got_shot.internal_organs)
			O.damage = 0
	return ..()

/datum/status_effect/trickwine/buff/hearth
	id = "hearth_wine_buff"
	//trickwine_examine_text = ""
	//message_apply_others =  ""
	//message_apply_self = ""
	//message_remove_others = ""
	//message_remove_self = ""
	//alert_desc = ""
	trait = TRAIT_RESISTCOLD

/datum/reagent/consumable/ethanol/trickwine/force_wine
	name = "Knifepoint liquor"
	description = "Immensely alcoholic Roumian beverage, occasionally used as a disinfectant and painkiller when proper medicine is not available. Hunter doctors do not reccomend any more than a thimbleful"
	color = "#709AAF"
	boozepwr = 170
	taste_description = "chemical numbness"
	glass_name = "Knifepoint"
	glass_desc = "Immensely alcoholic Roumian beverage, occasionally used as a disinfectant and painkiller when proper medicine is not available. Hunter doctors do not reccomend any more than a thimbleful"
	breakaway_flask_icon_state = "baflaskforcewine"
	buff_effect = /datum/status_effect/trickwine/buff/force

/datum/reagent/consumable/ethanol/trickwine/force_wine/on_mob_metabolize(mob/living/consumer)
	//should make it so it doesn't blast your liver to bits, though the regular drunkenness can still be fatal
	var/obj/item/organ/liver/liverinquestion = consumer.getorganslot(ORGAN_SLOT_LIVER)
	//you would think higher alcohol_tolerance would mean less liver damage. Wrong!
	liverinquestion.alcohol_tolerance /= 6
	. = ..()

/datum/reagent/consumable/ethanol/trickwine/force_wine/on_mob_end_metabolize(mob/living/consumer)
	var/obj/item/organ/liver/liverinquestion = consumer.getorganslot(ORGAN_SLOT_LIVER)
	//re enable liver blasting
	liverinquestion.alcohol_tolerance *= 6
	. = ..()

/datum/status_effect/trickwine/buff/force
	id = "force_wine_buff"
	//you ever heard how they'd give soldiers in the US civil war a bunch of whiskey before amputation. This lets you do that!
	trait = TRAIT_ANALGESIA


/datum/reagent/consumable/ethanol/trickwine/prism_wine
	name = "Prismwine"
	description = "A glittering liquid that seems to always refract light passing through it into a rainbow."
	color = "#F0F0F0"
	boozepwr = 50
	quality = FOOD_AMAZING
	taste_description = "the reflective quality of meditation"
	glass_name = "Prismwine"
	glass_desc = "A glittering liquid that seems to always refract light passing through it into a rainbow."
	breakaway_flask_icon_state = "baflaskprismwine"
	buff_effect = /datum/status_effect/trickwine/buff/prism

/datum/status_effect/trickwine/buff/prism
	id = "prism_wine_buff"
	//trickwine_examine_text = ""
	//message_apply_others =  ""
	//message_apply_self = ""
	//message_remove_others = ""
	//message_remove_self = ""
	//alert_desc = ""





