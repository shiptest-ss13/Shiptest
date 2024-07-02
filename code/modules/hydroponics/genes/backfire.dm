/// Traits for plants with backfire effects. These are negative effects that occur when a plant is handled without gloves/unsafely.
/datum/plant_gene/trait/backfire
	name = "Backfire Trait"
	icon = "mitten"
	description = "Be careful when holding it without protection."
	/// Whether our actions are cancelled when the backfire triggers.
	var/cancel_action_on_backfire = FALSE
	/// A list of extra traits to check to be considered safe.
	var/list/traits_to_check
	/// A list of extra genes to check to be considered safe.
	var/list/genes_to_check

/datum/plant_gene/trait/backfire/on_new_plant(obj/item/our_plant, newloc)
	. = ..()
	if(!.)
		return
	if(genes_to_check)
		genes_to_check = string_list(genes_to_check)
	if(traits_to_check)
		traits_to_check = string_list(traits_to_check)
	our_plant.AddElement(/datum/element/plant_backfire, cancel_action_on_backfire, traits_to_check, genes_to_check)
	RegisterSignal(our_plant, COMSIG_PLANT_ON_BACKFIRE, PROC_REF(on_backfire))

/// Signal proc for [COMSIG_PLANT_ON_BACKFIRE] that causes the backfire effect.
/datum/plant_gene/trait/backfire/proc/on_backfire(obj/item/source, mob/living/carbon/user)
	SIGNAL_HANDLER

	INVOKE_ASYNC(src, PROC_REF(backfire_effect), source, user)

/**
 * The actual backfire effect on the user.
 * Override with plant-specific effects.
 */
/datum/plant_gene/trait/backfire/proc/backfire_effect(obj/item/our_plant, mob/living/carbon/user)
	return

/// Rose's prick on backfire
/datum/plant_gene/trait/backfire/rose_thorns
	name = "Rose Thorns"
	description = "The stem has a lot of thorns."
	traits_to_check = list(TRAIT_PIERCEIMMUNE)

/datum/plant_gene/trait/backfire/rose_thorns/backfire_effect(obj/item/our_plant, mob/living/carbon/user)
	var/obj/item/seeds/our_seed = our_plant.get_plant_seed()
	if(!our_seed.get_gene(/datum/plant_gene/trait/sticky) && prob(66))
		to_chat(user, span_danger("[our_plant]'s thorns nearly prick your hand. Best be careful."))
		return

	to_chat(user, span_danger("[our_plant]'s thorns prick your hand. Ouch."))
	our_plant.investigate_log("rose-pricked [key_name(user)] at [AREACOORD(user)]", INVESTIGATE_BOTANY)
	var/obj/item/bodypart/affecting = user.get_active_hand()
	affecting?.receive_damage(2)

/// Novaflower's hand burn on backfire
/datum/plant_gene/trait/backfire/novaflower_heat
	name = "Burning Stem"
	description = "The stem may burn your hand."
	cancel_action_on_backfire = TRUE

/datum/plant_gene/trait/backfire/novaflower_heat/backfire_effect(obj/item/our_plant, mob/living/carbon/user)
	to_chat(user, span_danger("[our_plant] singes your bare hand!"))
	our_plant.investigate_log("self-burned [key_name(user)] for [our_plant.force] at [AREACOORD(user)]", INVESTIGATE_BOTANY)
	var/obj/item/bodypart/affecting = user.get_active_hand()
	return affecting?.receive_damage(0, our_plant.force)

/// Normal Nettle hannd burn on backfire
/datum/plant_gene/trait/backfire/nettle_burn
	name = "Stinging Stem"
	description = "The stem may sting your hand."

/datum/plant_gene/trait/backfire/nettle_burn/backfire_effect(obj/item/our_plant, mob/living/carbon/user)
	to_chat(user, span_danger("[our_plant] burns your bare hand!"))
	our_plant.investigate_log("self-burned [key_name(user)] for [our_plant.force] at [AREACOORD(user)]", INVESTIGATE_BOTANY)
	var/obj/item/bodypart/affecting = user.get_active_hand()
	return affecting?.receive_damage(0, our_plant.force)

/// Deathnettle hand burn + stun on backfire
/datum/plant_gene/trait/backfire/nettle_burn/death
	name = "Aggressive Stinging Stem"
	cancel_action_on_backfire = TRUE

/datum/plant_gene/trait/backfire/nettle_burn/death/backfire_effect(obj/item/our_plant, mob/living/carbon/user)
	. = ..()
	if(!. || prob(50))
		return

	user.Paralyze(10 SECONDS)
	to_chat(user, span_userdanger("You are stunned by the powerful acids of [our_plant]!"))

/*
/// Ghost-Chili heating up on backfire
/datum/plant_gene/trait/backfire/chili_heat
	name = "Active Capsicum Glands"
	description = "You may survive a cold winter with this in hand."
	genes_to_check = list(/datum/plant_gene/trait/chem_heating)
	/// The mob currently holding the chili.
	var/datum/weakref/held_mob
	/// The chili this gene is tied to, to track it for processing.
	var/datum/weakref/our_chili

/datum/plant_gene/trait/backfire/chili_heat/on_new_plant(obj/item/our_plant, newloc)
	. = ..()
	if(!.)
		return

	our_chili = WEAKREF(our_plant)
	RegisterSignals(our_plant, list(COMSIG_QDELETING, COMSIG_ITEM_DROPPED), PROC_REF(stop_backfire_effect))

/*
 * Begin processing the trait on backfire.
 *
 * our_plant - our source plant, which is backfiring
 * user - the mob holding our plant
 */
/datum/plant_gene/trait/backfire/chili_heat/backfire_effect(obj/item/our_plant, mob/living/carbon/user)
	held_mob = WEAKREF(user)
	START_PROCESSING(SSobj, src)

/*
 * Stop processing the trait when we're dropped or deleted.
 *
 * our_plant - our source plant
 */
/datum/plant_gene/trait/backfire/chili_heat/proc/stop_backfire_effect(datum/source)
	SIGNAL_HANDLER

	held_mob = null
	STOP_PROCESSING(SSobj, src)

/*
 * The processing of our trait. Heats up the mob ([held_mob]) currently holding the source plant ([our_chili]).
 * Stops processing if we're no longer being held by [held mob].
 */
/datum/plant_gene/trait/backfire/chili_heat/process(seconds_per_tick)
	var/mob/living/carbon/our_mob = held_mob?.resolve()
	var/obj/item/our_plant = our_chili?.resolve()

	// If our weakrefs don't resolve, or if our mob is not holding our plant, stop processing.
	if(!our_mob || !our_plant || !our_mob.is_holding(our_plant))
		stop_backfire_effect()
		return

	our_mob.adjust_bodytemperature(7.5 * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick)
	if(SPT_PROB(5, seconds_per_tick))
		to_chat(our_mob, span_warning("Your hand holding [our_plant] burns!"))

/// Bluespace Tomato squashing on the user on backfire
/datum/plant_gene/trait/backfire/bluespace
	name = "Bluespace Volatility"
	description = "You may be spaced out if you hold this unprotected."
	cancel_action_on_backfire = TRUE
	genes_to_check = list(/datum/plant_gene/trait/squash)

/datum/plant_gene/trait/backfire/bluespace/backfire_effect(obj/item/our_plant, mob/living/carbon/user)
	if(prob(50))
		return

	to_chat(user, span_danger("[our_plant] slips out of your hand!"))

	var/obj/item/seeds/our_seed = our_plant.get_plant_seed()
	var/datum/plant_gene/trait/squash/squash_gene = our_seed.get_gene(/datum/plant_gene/trait/squash)
	squash_gene.squash_plant(our_plant, user)
*/
