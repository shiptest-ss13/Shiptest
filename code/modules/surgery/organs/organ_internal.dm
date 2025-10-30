/obj/item/organ
	name = "organ"
	icon = 'icons/obj/surgery.dmi'
	var/mob/living/carbon/owner = null
	var/status = ORGAN_ORGANIC
	w_class = WEIGHT_CLASS_SMALL
	throwforce = 0
	var/zone = BODY_ZONE_CHEST
	var/slot
	// DO NOT add slots with matching names to different zones - it will break internal_organs_slot list!
	var/organ_flags = ORGAN_EDIBLE
	var/maxHealth = STANDARD_ORGAN_THRESHOLD
	var/damage = 0		//total damage this organ has sustained
	///Healing factor and decay factor function on % of maxhealth, and do not work by applying a static number per tick
	var/healing_factor 	= 0										//fraction of maxhealth healed per on_life(), set to 0 for generic organs
	var/decay_factor 	= 0										//same as above but when without a living owner, set to 0 for generic organs
	var/high_threshold	= STANDARD_ORGAN_THRESHOLD * 0.45		//when severe organ damage occurs
	var/low_threshold	= STANDARD_ORGAN_THRESHOLD * 0.1		//when minor organ damage occurs
	var/severe_cooldown	//cooldown for severe effects, used for synthetic organ emp effects.
	///Organ variables for determining what we alert the owner with when they pass/clear the damage thresholds
	var/prev_damage = 0
	var/low_threshold_passed
	var/high_threshold_passed
	var/now_failing
	var/now_fixed
	var/high_threshold_cleared
	var/low_threshold_cleared

	var/useable = TRUE
	var/list/food_reagents = list(/datum/reagent/consumable/nutriment = 5)
	var/vital = 0
	//Was this organ implanted/inserted/etc, if true will not be removed during species change.
	var/external = FALSE
	//whether to call Remove() when qdeling the organ.
	var/remove_on_qdel = TRUE
	var/synthetic = FALSE // To distinguish between organic and synthetic organs

/obj/item/organ/Initialize()
	. = ..()
	if(organ_flags & ORGAN_EDIBLE)
		AddComponent(/datum/component/edible,\
		initial_reagents = food_reagents,\
		foodtypes = RAW | MEAT | GORE,\
		volume = 10,\
		filling_color = COLOR_PINK,\
		pre_eat = CALLBACK(src, PROC_REF(pre_eat)),\
		on_compost = CALLBACK(src, PROC_REF(pre_compost)),\
		after_eat = CALLBACK(src, PROC_REF(on_eat_from)))

	///When you take a bite you cant jam it in for surgery anymore.
/obj/item/organ/proc/Insert(mob/living/carbon/M, special = 0, drop_if_replaced = TRUE)
	if(!iscarbon(M) || owner == M)
		return

	var/obj/item/organ/replaced = M.getorganslot(slot)
	if(replaced)
		replaced.Remove(M, special = 1)
		if(drop_if_replaced)
			var/dest = get_turf(M)
			if(dest)
				replaced.forceMove(get_turf(M))
			else
				qdel(replaced)
		else
			qdel(replaced)

	SEND_SIGNAL(M, COMSIG_CARBON_GAIN_ORGAN, src)

	owner = M
	M.internal_organs |= src
	M.internal_organs_slot[slot] = src
	moveToNullspace()
	for(var/X in actions)
		var/datum/action/A = X
		A.Grant(M)
	on_mob_insert(M, special, drop_if_replaced)
	STOP_PROCESSING(SSobj, src)

/// Called after the organ is inserted into a mob.
/// Adds Traits, Actions, and Status Effects on the mob in which the organ is impanted.
/// Override this proc to create unique side-effects for inserting your organ. Must be called by overrides.
/obj/item/organ/proc/on_mob_insert(mob/living/carbon/organ_owner, special = FALSE, drop_if_replaced)
	SHOULD_CALL_PARENT(TRUE)

	if(!special)
		organ_owner.hud_used?.update_locked_slots()
	SEND_SIGNAL(organ_owner, COMSIG_CARBON_GAIN_ORGAN, src, special)

	STOP_PROCESSING(SSobj, src)

//Special is for instant replacement like autosurgeons
/obj/item/organ/proc/Remove(mob/living/carbon/M, special = FALSE)
	owner = null
	if(M)
		M.internal_organs -= src
		if(M.internal_organs_slot[slot] == src)
			M.internal_organs_slot.Remove(slot)
		if((organ_flags & ORGAN_VITAL) && !special && !(M.status_flags & GODMODE))
			M.death()
	for(var/X in actions)
		var/datum/action/A = X
		A.Remove(M)

	SEND_SIGNAL(M, COMSIG_CARBON_LOSE_ORGAN, src)
	on_mob_remove(M, special)
	START_PROCESSING(SSobj, src)

/// Called after the organ is removed from a mob.
/// Removes Traits, Actions, and Status Effects on the mob in which the organ was impanted.
/// Override this proc to create unique side-effects for removing your organ. Must be called by overrides.
/obj/item/organ/proc/on_mob_remove(mob/living/carbon/organ_owner, special = FALSE)
	SHOULD_CALL_PARENT(TRUE)

	if(!iscarbon(organ_owner))
		stack_trace("Organ removal should not be happening on non carbon mobs: [organ_owner]")

	for(var/datum/action/action as anything in actions)
		action.Remove(organ_owner)

	SEND_SIGNAL(src, COMSIG_ORGAN_REMOVED, organ_owner)
	SEND_SIGNAL(organ_owner, COMSIG_CARBON_LOSE_ORGAN, src, special)
	if(!special)
		organ_owner.hud_used?.update_locked_slots()

	if((organ_flags & ORGAN_VITAL) && !special)
		organ_owner.death()

	START_PROCESSING(SSobj, src)

	var/list/diseases = organ_owner.get_static_viruses()
	if(!LAZYLEN(diseases))
		return

	var/list/datum/disease/diseases_to_add = list()
	for(var/datum/disease/disease as anything in diseases)
		// robotic organs are immune to disease unless 'inorganic biology' symptom is present
		if(IS_ROBOTIC_ORGAN(src) && !(disease.infectable_biotypes & MOB_ROBOTIC))
			continue

		// admin or special viruses that should not be reproduced
		if(disease.spread_flags & (DISEASE_SPREAD_SPECIAL | DISEASE_SPREAD_NON_CONTAGIOUS))
			continue

		diseases_to_add += disease

	if(LAZYLEN(diseases_to_add))
		AddComponent(/datum/component/infective, diseases_to_add)

/obj/item/organ/proc/on_find(mob/living/finder)
	return

/obj/item/organ/process(seconds_per_tick)
	on_death(seconds_per_tick) //Kinda hate doing it like this, but I really don't want to call process directly.

/obj/item/organ/proc/on_death(seconds_per_tick = 2)	//runs decay when outside of a person
	if(organ_flags & (ORGAN_SYNTHETIC | ORGAN_FROZEN))
		return
	applyOrganDamage(maxHealth * decay_factor * 0.5 * seconds_per_tick)

/obj/item/organ/proc/on_life()	//repair organ damage if the organ is not failing
	if(organ_flags & ORGAN_FAILING)
		return
	if(organ_flags & ORGAN_SYNTHETIC_EMP) //Synthetic organ has been emped, is now failing.
		applyOrganDamage(maxHealth * decay_factor)
		return
	///Damage decrements by a percent of its maxhealth
	var/healing_amount = -(maxHealth * healing_factor)
	///Damage decrements again by a percent of its maxhealth, up to a total of 4 extra times depending on the owner's health
	healing_amount -= owner.satiety > 0 ? 4 * healing_factor * owner.satiety / MAX_SATIETY : 0
	applyOrganDamage(healing_amount)

/obj/item/organ/examine(mob/user)
	. = ..()
	if(organ_flags & ORGAN_FAILING)
		if(status == ORGAN_ROBOTIC)
			. += span_warning("[src] seems to be broken.")
			return
		. += span_warning("[src] has decayed for too long, and has turned a sickly color. It probably won't work without repairs.")
		return
	if(damage > high_threshold)
		. += span_warning("[src] is starting to look discolored.")

/obj/item/organ/Initialize()
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/item/organ/Destroy()
	if(owner && remove_on_qdel)
		// The special flag is important, because otherwise mobs can die
		// while undergoing transformation into different mobs.
		Remove(owner, special=TRUE)
	else
		STOP_PROCESSING(SSobj, src)
	return ..()

// Put any "can we eat this" checks for edible organs here
/obj/item/organ/proc/pre_eat(eater, feeder)
	if(iscarbon(eater))
		var/mob/living/carbon/target = eater
		for(var/S in target.surgeries)
			var/datum/surgery/surgery = S
			if(surgery.location == zone)
				return FALSE
	return TRUE

/obj/item/organ/proc/pre_compost(user)
	return TRUE

/obj/item/organ/proc/on_eat_from(eater, feeder)
	useable = FALSE //You bit it, no more using it

/obj/item/organ/item_action_slot_check(slot,mob/user)
	return //so we don't grant the organ's action to mobs who pick up the organ.

///Adjusts an organ's damage by the amount "d", up to a maximum amount, which is by default max damage
/obj/item/organ/proc/applyOrganDamage(d, maximum = maxHealth)	//use for damaging effects
	if(!d) //Micro-optimization.
		return
	if(maximum < damage)
		return
	damage = clamp(damage + d, 0, maximum)
	var/mess = check_damage_thresholds(owner)
	prev_damage = damage
	if(mess && owner)
		to_chat(owner, mess)

///SETS an organ's damage to the amount "d", and in doing so clears or sets the failing flag, good for when you have an effect that should fix an organ if broken
/obj/item/organ/proc/setOrganDamage(d)	//use mostly for admin heals
	applyOrganDamage(d - damage)

/** check_damage_thresholds
 * input: M (a mob, the owner of the organ we call the proc on)
 * output: returns a message should get displayed.
 * description: By checking our current damage against our previous damage, we can decide whether we've passed an organ threshold.
 *				 If we have, send the corresponding threshold message to the owner, if such a message exists.
 */
/obj/item/organ/proc/check_damage_thresholds(M)
	if(damage == prev_damage)
		return
	var/delta = damage - prev_damage
	if(delta > 0)
		if(damage >= maxHealth)
			organ_flags |= ORGAN_FAILING
			return now_failing
		if(damage > high_threshold && prev_damage <= high_threshold)
			return high_threshold_passed
		if(damage > low_threshold && prev_damage <= low_threshold)
			return low_threshold_passed
	else
		organ_flags &= ~ORGAN_FAILING
		if(prev_damage > low_threshold && damage <= low_threshold)
			return low_threshold_cleared
		if(prev_damage > high_threshold && damage <= high_threshold)
			return high_threshold_cleared
		if(prev_damage == maxHealth)
			return now_fixed

//Looking for brains?
//Try code/modules/mob/living/carbon/brain/brain_item.dm

/mob/living/proc/regenerate_organs()
	return 0

/mob/living/carbon/regenerate_organs()
	if(!getorganslot(ORGAN_SLOT_LUNGS))
		var/obj/item/organ/lungs/L = new()
		L.Insert(src)

	if(!getorganslot(ORGAN_SLOT_HEART))
		var/obj/item/organ/heart/H = new()
		H.Insert(src)

	if(!getorganslot(ORGAN_SLOT_TONGUE))
		var/obj/item/organ/tongue/T = new()
		T.Insert(src)

	if(!getorganslot(ORGAN_SLOT_EYES))
		var/obj/item/organ/eyes/E = new()
		E.Insert(src)

	if(!getorganslot(ORGAN_SLOT_EARS))
		var/obj/item/organ/ears/ears = new()
		ears.Insert(src)

/mob/living/carbon/human/regenerate_organs()
	dna.species.regenerate_organs(src, robotic = fbp)

/** get_availability
 * returns whether the species should innately have this organ.
 *
 * regenerate organs works with generic organs, so we need to get whether it can accept certain organs just by what this returns.
 * This is set to return true or false, depending on if a species has a specific organless trait. stomach for example checks if the species has NOSTOMACH and return based on that.
 * Arguments:
 * S - species, needed to return whether the species has an organ specific trait
 */
/obj/item/organ/proc/get_availability(datum/species/S)
	return TRUE
