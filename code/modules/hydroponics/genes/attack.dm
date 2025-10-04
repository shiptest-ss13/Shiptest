/// Traits that turn a plant into a weapon, giving them force and effects on attack.
/datum/plant_gene/trait/attack
	name = "On Attack Trait"
	description = "It is a very dangerous weapon."
	icon = "hand-fist"
	/// The multiplier we apply to the potency to calculate force. Set to 0 to not affect the force.
	var/force_multiplier = 0
	/// If TRUE, our plant will degrade in force every hit until diappearing.
	var/degrades_after_hit = FALSE
	/// When we fully degrade, what degraded off of us?
	var/degradation_noun = "leaves"

/datum/plant_gene/trait/attack/on_new_plant(obj/item/our_plant, newloc)
	. = ..()
	if(!.)
		return

	if(force_multiplier)
		var/obj/item/seeds/our_seed = our_plant.get_plant_seed()
		our_plant.force = round((5 + our_seed.potency * force_multiplier), 1)
	RegisterSignal(our_plant, COMSIG_ITEM_ATTACK, PROC_REF(on_plant_attack))
	RegisterSignal(our_plant, COMSIG_ITEM_AFTERATTACK, PROC_REF(after_plant_attack))

/// Signal proc for [COMSIG_ITEM_ATTACK] that allows for effects on attack
/datum/plant_gene/trait/attack/proc/on_plant_attack(obj/item/source, mob/living/target, mob/living/user)
	SIGNAL_HANDLER

	INVOKE_ASYNC(src, PROC_REF(attack_effect), source, target, user)

/*
 * Effects done when we hit people with our plant, ON attack.
 * Override on a per-plant basis.
 *
 * our_plant - our plant, that we're attacking with
 * user - the person who is attacking with the plant
 * target - the person who is attacked by the plant
 */
/datum/plant_gene/trait/attack/proc/attack_effect(obj/item/our_plant, mob/living/target, mob/living/user)
	return

/// Signal proc for [COMSIG_ITEM_AFTERATTACK] that allows for effects after an attack is done
/datum/plant_gene/trait/attack/proc/after_plant_attack(obj/item/source, atom/target, mob/user, proximity_flag, click_parameters)
	SIGNAL_HANDLER

	if(!proximity_flag)
		return

	if(!ismovable(target))
		return

	if(isobj(target))
		var/obj/object_target = target
		if(!(object_target.obj_flags & CAN_BE_HIT))
			return .

	INVOKE_ASYNC(src, PROC_REF(after_attack_effect), source, target, user)
	return .

/*
 * Effects done when we hit people with our plant, AFTER the attack is done.
 * Extend on a per-plant basis.
 *
 * our_plant - our plant, that we're attacking with
 * user - the person who is attacking with the plant
 * target - the atom which is attacked by the plant
 */
/datum/plant_gene/trait/attack/proc/after_attack_effect(obj/item/our_plant, atom/target, mob/living/user)
	SHOULD_CALL_PARENT(TRUE)

	if(!degrades_after_hit)
		return

	// We probably hit something or someone. Reduce our force
	if(our_plant.force > 0)
		our_plant.force -= rand(1, (our_plant.force / 3) + 1)
		return

	// When our force degrades to zero or below, we're all done
	to_chat(user, span_warning("All the [degradation_noun] have fallen off [our_plant] from violent whacking!"))
	qdel(our_plant)

/// Novaflower's attack effects (sets people on fire) + degradation on attack
/datum/plant_gene/trait/attack/novaflower_attack
	name = "Heated Petals"
	description = "Hitting with it may cause things to combust."
	force_multiplier = 0.2
	degrades_after_hit = TRUE
	degradation_noun = "petals"

/datum/plant_gene/trait/attack/novaflower_attack/attack_effect(obj/item/our_plant, mob/living/target, mob/living/user)
	if(!istype(target))
		return

	var/obj/item/seeds/our_seed = our_plant.get_plant_seed()
	to_chat(target, span_danger("You are lit on fire from the intense heat of [our_plant]!"))
	target.adjust_fire_stacks(round(our_seed.potency / 20))
	if(target.ignite_mob())
		message_admins("[ADMIN_LOOKUPFLW(user)] set [ADMIN_LOOKUPFLW(target)] on fire with [our_plant] at [AREACOORD(user)]")
		user.log_message("set [key_name(target)] on fire with [our_plant]", LOG_ATTACK)
		target.log_message("was set on fire by [key_name(user)] with [our_plant].", LOG_ATTACK)

	our_plant.investigate_log("was used by [key_name(user)] to burn [key_name(target)] at [AREACOORD(user)]", INVESTIGATE_BOTANY)

/// Sunflower's attack effect (shows cute text)
/datum/plant_gene/trait/attack/sunflower_attack
	name = "Bright Petals"
	description = "Makes others feel the power on hit."

/datum/plant_gene/trait/attack/sunflower_attack/after_attack_effect(obj/item/our_plant, atom/target, mob/user, proximity_flag, click_parameters)
	if(ismob(target))
		var/mob/target_mob = target
		user.visible_message("<font color='green'>[user] smacks [target_mob] with [user.p_their()] [our_plant.name]! <font color='orange'><b>FLOWER POWER!</b></font></font>", ignored_mobs = list(target_mob, user))
		if(target_mob != user)
			to_chat(target_mob, "<font color='green'>[user] smacks you with [our_plant]!<font color='orange'><b>FLOWER POWER!</b></font></font>")
		to_chat(user, "<font color='green'>Your [our_plant.name]'s <font color='orange'><b>FLOWER POWER</b></font> strikes [target_mob]!</font>")

	return ..()

/// Normal nettle's force + degradation on attack
/datum/plant_gene/trait/attack/nettle_attack
	name = "Sharpened Leaves"
	force_multiplier = 0.2
	degrades_after_hit = TRUE

/// Deathnettle force + degradation on attack
/datum/plant_gene/trait/attack/nettle_attack/death
	name = "Aggressive Sharpened Leaves"
	force_multiplier = 0.4
