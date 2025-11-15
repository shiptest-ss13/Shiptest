/obj/item/melee/baton
	name = "stun baton"
	desc = "A stun baton for incapacitating people with."
	icon = 'icons/obj/weapon/baton.dmi'
	icon_state = "stunbaton"
	item_state = "baton"
	lefthand_file = 'icons/mob/inhands/equipment/security_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/security_righthand.dmi'

	force = 10
	attack_verb = list("beaten")

	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_BELT
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 50, "bio" = 0, "rad" = 0, "fire" = 80, "acid" = 80)

	throwforce = 7
	var/throw_stun_chance = 35

	var/obj/item/stock_parts/cell/cell
	var/preload_cell_type //if not empty the baton starts with this type of cell
	var/cell_hit_cost = 1000
	var/can_remove_cell = TRUE

	var/turned_on = FALSE
	var/activate_sound = SFX_SPARKS

	var/attack_cooldown_check = 0 SECONDS
	var/baton_attack_cooldown = 2.5 SECONDS
	var/stun_sound = 'sound/weapons/egloves.ogg'

	var/confusion_amt = 10
	var/stamina_loss_amt = 60
	var/apply_stun_delay = 2 SECONDS
	var/stun_time = 5 SECONDS

	var/convertible = TRUE //if it can be converted with a conversion kit

/obj/item/melee/baton/get_cell()
	return cell

/obj/item/melee/baton/Initialize()
	. = ..()
	if(preload_cell_type)
		if(!ispath(preload_cell_type,/obj/item/stock_parts/cell))
			log_mapping("[src] at [AREACOORD(src)] had an invalid preload_cell_type: [preload_cell_type].")
		else
			cell = new preload_cell_type(src)
	update_appearance()
	RegisterSignal(src, COMSIG_ATOM_ATTACKBY, PROC_REF(convert))


/obj/item/melee/baton/Destroy()
	if(cell)
		QDEL_NULL(cell)
	UnregisterSignal(src, COMSIG_ATOM_ATTACKBY)
	return ..()

/obj/item/melee/baton/proc/convert(datum/source, obj/item/I, mob/user)
	SIGNAL_HANDLER

	if(istype(I,/obj/item/conversion_kit) && convertible)
		var/turf/T = get_turf(src)
		var/obj/item/melee/classic_baton/B = new /obj/item/melee/classic_baton (T)
		B.alpha = 20
		playsound(T, 'sound/items/drill_use.ogg', 80, TRUE, -1)
		animate(src, alpha = 0, time = 10)
		animate(B, alpha = 255, time = 10)
		qdel(I)
		qdel(src)

/obj/item/melee/baton/handle_atom_del(atom/A)
	if(A == cell)
		cell = null
		turned_on = FALSE
		update_appearance()
	return ..()

/obj/item/melee/baton/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	..()
	//Only mob/living types have stun handling
	if(turned_on && prob(throw_stun_chance) && iscarbon(hit_atom))
		baton_effect(hit_atom)

/obj/item/melee/baton/loaded //this one starts with a cell pre-installed.
	preload_cell_type = /obj/item/stock_parts/cell/high

/obj/item/melee/baton/proc/deductcharge(chrgdeductamt)
	if(cell)
		//Note this value returned is significant, as it will determine
		//if a stun is applied or not
		. = cell.use(chrgdeductamt)
		if(turned_on && cell.charge < cell_hit_cost)
			//we're below minimum, turn off
			turned_on = FALSE
			update_appearance()
			playsound(src, activate_sound, 75, TRUE, -1)


/obj/item/melee/baton/update_icon_state()
	if(turned_on)
		icon_state = "[initial(icon_state)]_on"
		return ..()
	if(!cell)
		icon_state = "[initial(icon_state)]_nocell"
		return ..()
	icon_state = "[initial(icon_state)]"
	return ..()

/obj/item/melee/baton/examine(mob/user)
	. = ..()
	if(cell)
		. += span_notice("\The [src] is [round(cell.percent())]% charged.")
	else
		. += span_warning("\The [src] does not have a power source installed.")

/obj/item/melee/baton/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/stock_parts/cell))
		var/obj/item/stock_parts/cell/C = W
		if(cell)
			to_chat(user, span_notice("[src] already has a cell!"))
		else
			if(C.maxcharge < cell_hit_cost)
				to_chat(user, span_notice("[src] requires a higher capacity cell."))
				return
			if(!user.transferItemToLoc(W, src))
				return
			cell = W
			to_chat(user, span_notice("You install a cell in [src]."))
			update_appearance()

	else if(W.tool_behaviour == TOOL_SCREWDRIVER)
		tryremovecell(user)
	else
		return ..()

/obj/item/melee/baton/proc/tryremovecell(mob/user)
	if(cell && can_remove_cell)
		cell.update_appearance()
		cell.forceMove(get_turf(src))
		cell = null
		to_chat(user, span_notice("You remove the cell from [src]."))
		turned_on = FALSE
		update_appearance()

/obj/item/melee/baton/attack_self(mob/user)
	toggle_on(user)

/obj/item/melee/baton/proc/toggle_on(mob/user)
	if(cell && cell.charge > cell_hit_cost)
		turned_on = !turned_on
		to_chat(user, span_notice("[src] is now [turned_on ? "on" : "off"]."))
		playsound(src, activate_sound, 75, TRUE, -1)
	else
		turned_on = FALSE
		if(!cell)
			to_chat(user, span_warning("[src] does not have a power source!"))
		else
			to_chat(user, span_warning("[src] is out of charge."))
	update_appearance()
	add_fingerprint(user)

/obj/item/melee/baton/proc/clumsy_check(mob/living/carbon/human/user)
	if(turned_on && HAS_TRAIT(user, TRAIT_CLUMSY) && prob(50))
		playsound(src, stun_sound, 75, TRUE, -1)
		user.visible_message(span_danger("[user] accidentally hits [user.p_them()]self with [src]!"), \
							span_userdanger("You accidentally hit yourself with [src]!"))
		user.Knockdown(stun_time*3) //should really be an equivalent to attack(user,user)
		deductcharge(cell_hit_cost)
		return TRUE
	return FALSE

/obj/item/melee/baton/attack(mob/M, mob/living/carbon/human/user)
	if(clumsy_check(user))
		return FALSE

	if(iscyborg(M))
		..()
		return


	if(ishuman(M))
		var/mob/living/carbon/human/L = M
		if(check_martial_counter(L, user))
			return

	if(user.a_intent != INTENT_HARM)
		if(turned_on)
			if(attack_cooldown_check <= world.time)
				if(baton_effect(M, user))
					user.do_attack_animation(M)
					return
			else
				to_chat(user, span_danger("The [src] is still charging!"))
		else
			M.visible_message(span_warning("[user] prods [M] with [src]. Luckily it was off."), \
							span_warning("[user] prods you with [src]. Luckily it was off."))
	else
		if(turned_on)
			if(attack_cooldown_check <= world.time)
				baton_effect(M, user)
		..()


/obj/item/melee/baton/proc/baton_effect(mob/living/L, mob/user)
	if(shields_blocked(L, user))
		return FALSE
	if(HAS_TRAIT_FROM(L, TRAIT_IWASBATONED, user)) //no doublebaton abuse anon!
		to_chat(user, span_danger("[L] manages to avoid the attack!"))
		return FALSE
	if(iscyborg(loc))
		var/mob/living/silicon/robot/R = loc
		if(!R || !R.cell || !R.cell.use(cell_hit_cost))
			return FALSE
	else
		if(!deductcharge(cell_hit_cost))
			return FALSE
	/// After a target is hit, we do a chunk of stamina damage, along with other effects.
	/// After a period of time, we then check to see what stun duration we give.
	L.set_timed_status_effect(40 SECONDS, /datum/status_effect/jitter, only_if_higher = TRUE)
	L.confused = max(confusion_amt, L.confused)
	L.stuttering = max(8, L.stuttering)
	L.apply_damage(stamina_loss_amt, STAMINA, BODY_ZONE_CHEST)

	SEND_SIGNAL(L, COMSIG_LIVING_MINOR_SHOCK)
	addtimer(CALLBACK(src, PROC_REF(apply_stun_effect_end), L), apply_stun_delay)

	if(user)
		L.lastattacker = user.real_name
		L.lastattackerckey = user.ckey
		L.visible_message(span_danger("[user] stuns [L] with [src]!"), \
								span_userdanger("[user] stuns you with [src]!"))
		log_combat(user, L, "stunned")

	playsound(src, stun_sound, 50, TRUE, -1)

	attack_cooldown_check = world.time + baton_attack_cooldown

	ADD_TRAIT(L, TRAIT_IWASBATONED, user)
	addtimer(TRAIT_CALLBACK_REMOVE(L, TRAIT_IWASBATONED, user), baton_attack_cooldown)

	return 1

/// After the initial stun period, we check to see if the target needs to have the stun applied.
/obj/item/melee/baton/proc/apply_stun_effect_end(mob/living/target)
	var/trait_check = HAS_TRAIT(target, TRAIT_STUNRESISTANCE) //var since we check it in out to_chat as well as determine stun duration
	if(!target.IsKnockdown())
		to_chat(target, span_warning("Your muscles seize, making you collapse[trait_check ? ", but your body quickly recovers..." : "!"]"))

	if(trait_check)
		target.Knockdown(stun_time * 0.1)
	else
		target.Knockdown(stun_time)

/obj/item/melee/baton/emp_act(severity)
	. = ..()
	if (!(. & EMP_PROTECT_SELF))
		deductcharge(1000 / severity)

/obj/item/melee/baton/proc/shields_blocked(mob/living/L, mob/user)
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		if(H.check_shields(src, 0, "[user]'s [name]", MELEE_ATTACK)) //No message; check_shields() handles that
			playsound(H, 'sound/weapons/genhit.ogg', 50, TRUE)
			return TRUE
	return FALSE

//Makeshift stun baton. Replacement for stun gloves.
/obj/item/melee/baton/cattleprod
	name = "stunprod"
	desc = "An improvised stun baton."
	icon_state = "stunprod"
	item_state = "prod"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	w_class = WEIGHT_CLASS_BULKY
	force = 3
	throwforce = 5
	stun_time = 5 SECONDS
	cell_hit_cost = 2000
	throw_stun_chance = 10
	slot_flags = ITEM_SLOT_BACK
	convertible = FALSE
	var/obj/item/assembly/igniter/sparkler = 0

/obj/item/melee/baton/cattleprod/Initialize()
	. = ..()
	sparkler = new (src)

/obj/item/melee/baton/cattleprod/baton_effect()
	if(sparkler.activate())
		..()

/obj/item/melee/baton/cattleprod/Destroy()
	if(sparkler)
		QDEL_NULL(sparkler)
	return ..()

/obj/item/melee/baton/cattleprod/loaded
	preload_cell_type = /obj/item/stock_parts/cell/high

/obj/item/melee/baton/boomerang
	name = "\improper baton boomerang"
	desc = "Apparently, someone thought that attaching the stunning part of a baton to a boomerang was a good idea. Just be careful to catch it when thrown!"
	throw_speed = 1
	icon_state = "boomerang"
	item_state = "boomerang"
	force = 5
	throwforce = 5
	throw_range = 5
	cell_hit_cost = 2000
	throw_stun_chance = 99  //Have you prayed today?
	convertible = FALSE
	custom_materials = list(/datum/material/iron = 10000, /datum/material/glass = 4000, /datum/material/silver = 10000, /datum/material/gold = 2000)

/obj/item/melee/baton/boomerang/throw_at(atom/target, range, speed, mob/thrower, spin=1, diagonals_first = 0, datum/callback/callback, force, gentle = FALSE, quickstart = TRUE)
	if(turned_on)
		if(ishuman(thrower))
			var/mob/living/carbon/human/H = thrower
			H.throw_mode_off(THROW_MODE_TOGGLE) //so they can catch it on the return.
	return ..()

/obj/item/melee/baton/boomerang/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	if(turned_on)
		var/caught = hit_atom.hitby(src, FALSE, FALSE, throwingdatum=throwingdatum)
		if(ishuman(hit_atom) && !caught && prob(throw_stun_chance))//if they are a carbon and they didn't catch it
			baton_effect(hit_atom)
		var/mob/thrown_by = thrownby?.resolve()
		if(thrown_by && !caught)
			addtimer(CALLBACK(src, TYPE_PROC_REF(/atom/movable, throw_at), thrown_by, throw_range+2, throw_speed, null, TRUE), 1)
	else
		return ..()

/obj/item/melee/baton/boomerang/loaded //Same as above, comes with a cell.
	preload_cell_type = /obj/item/stock_parts/cell/high

/obj/item/melee/classic_baton
	name = "police baton"
	desc = "A wooden truncheon for beating criminal scum."
	icon = 'icons/obj/weapon/baton.dmi'
	icon_state = "classic_baton"
	item_state = "classic_baton"
	lefthand_file = 'icons/mob/inhands/equipment/security_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/security_righthand.dmi'
	slot_flags = ITEM_SLOT_BELT
	force = 12 //9 hit crit
	wound_bonus = 15
	w_class = WEIGHT_CLASS_NORMAL

	var/cooldown_check = 0 // Used interally, you don't want to modify

	var/cooldown = 40 // Default wait time until can stun again.
	var/knockdown_time_carbon = (1.5 SECONDS) // Knockdown length for carbons.
	var/stun_time_silicon = (5 SECONDS) // If enabled, how long do we stun silicons.
	var/stamina_damage = 55 // Do we deal stamina damage.
	var/affect_silicon = FALSE // Does it stun silicons.
	var/on_sound // "On" sound, played when switching between able to stun or not.
	var/on_stun_sound = 'sound/effects/woodhit.ogg' // Default path to sound for when we stun.
	var/stun_animation = TRUE // Do we animate the "hit" when stunning.
	var/on = TRUE // Are we on or off.

	var/on_icon_state // What is our sprite when turned on
	var/off_icon_state // What is our sprite when turned off
	var/on_item_state // What is our in-hand sprite when turned on
	var/active_force // Damage when on - not stunning
	var/force_off // Damage when off - not stunning
	var/weight_class_on // What is the new size class when turned on


// Description for trying to stun when still on cooldown.
/obj/item/melee/classic_baton/proc/get_wait_description()
	return

// Description for when turning their baton "on"
/obj/item/melee/classic_baton/proc/get_on_description()
	. = list()

	.["local_on"] = span_warning("You extend the baton.")
	.["local_off"] = span_notice("You collapse the baton.")

	return .

// Default message for stunning mob.
/obj/item/melee/classic_baton/proc/get_stun_description(mob/living/target, mob/living/user)
	. = list()

	.["visible"] =  span_danger("[user] knocks [target] down with [src]!")
	.["local"] = span_userdanger("[user] knocks you down with [src]!")

	return .

// Default message for stunning a silicon.
/obj/item/melee/classic_baton/proc/get_silicon_stun_description(mob/living/target, mob/living/user)
	. = list()

	.["visible"] = span_danger("[user] pulses [target]'s sensors with the baton!")
	.["local"] = span_danger("You pulse [target]'s sensors with the baton!")

	return .

// Are we applying any special effects when we stun to carbon
/obj/item/melee/classic_baton/proc/additional_effects_carbon(mob/living/target, mob/living/user)
	return

// Are we applying any special effects when we stun to silicon
/obj/item/melee/classic_baton/proc/additional_effects_silicon(mob/living/target, mob/living/user)
	return

/obj/item/melee/classic_baton/attack(mob/living/target, mob/living/user)
	if(!on)
		return ..()

	add_fingerprint(user)
	if((HAS_TRAIT(user, TRAIT_CLUMSY)) && prob(50))
		to_chat(user, span_userdanger("You hit yourself over the head!"))

		user.Paralyze(knockdown_time_carbon * force)
		user.apply_damage(stamina_damage, STAMINA, BODY_ZONE_HEAD)

		additional_effects_carbon(user) // user is the target here
		if(ishuman(user))
			var/mob/living/carbon/human/H = user
			H.apply_damage(2*force, BRUTE, BODY_ZONE_HEAD)
		else
			user.take_bodypart_damage(2*force)
		return
	if(iscyborg(target))
		// We don't stun if we're on harm.
		if (user.a_intent != INTENT_HARM)
			if (affect_silicon)
				var/list/desc = get_silicon_stun_description(target, user)

				target.flash_act(affect_silicon = TRUE)
				target.Paralyze(stun_time_silicon)
				additional_effects_silicon(target, user)

				user.visible_message(desc["visible"], desc["local"])
				playsound(get_turf(src), on_stun_sound, 100, TRUE, -1)

				if (stun_animation)
					user.do_attack_animation(target)
			else
				..()
		else
			..()
		return
	if(!isliving(target))
		return
	if (user.a_intent == INTENT_HARM)
		if(!..())
			return
		if(!iscyborg(target))
			return
	else
		if(cooldown_check <= world.time)
			if(ishuman(target))
				var/mob/living/carbon/human/H = target
				if (H.check_shields(src, 0, "[user]'s [name]", MELEE_ATTACK))
					return
				if(check_martial_counter(H, user))
					return

			var/list/desc = get_stun_description(target, user)

			if (stun_animation)
				user.do_attack_animation(target)

			playsound(get_turf(src), on_stun_sound, 75, TRUE, -1)
			target.Knockdown(knockdown_time_carbon)
			target.apply_damage(stamina_damage, STAMINA, BODY_ZONE_CHEST)
			additional_effects_carbon(target, user)

			log_combat(user, target, "stunned", src)
			add_fingerprint(user)

			target.visible_message(desc["visible"], desc["local"])

			if(!iscarbon(user))
				target.LAssailant = null
			else
				target.LAssailant = WEAKREF(user)
			cooldown_check = world.time + cooldown
		else
			var/wait_desc = get_wait_description()
			if (wait_desc)
				to_chat(user, wait_desc)

/obj/item/conversion_kit
	name = "conversion kit"
	desc = "A strange box containing wood working tools and an instruction paper to turn stun batons into something else."
	icon = 'icons/obj/storage.dmi'
	icon_state = "uk"
	custom_price = 450

/obj/item/melee/classic_baton/telescopic
	name = "telescopic baton"
	desc = "A compact yet robust personal defense weapon. Can be concealed when folded."
	icon_state = "telebaton"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	item_state = null
	slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_SMALL
	item_flags = NONE
	force = 0
	on = FALSE
	on_sound = 'sound/weapons/batonextend.ogg'

	on_icon_state = "telebaton_on"
	off_icon_state = "telebaton"
	on_item_state = "nullrod"
	active_force = 10
	force_off = 0
	weight_class_on = WEIGHT_CLASS_BULKY

/obj/item/melee/classic_baton/telescopic/attack_self(mob/user)
	on = !on
	var/list/desc = get_on_description()

	if(on)
		to_chat(user, desc["local_on"])
		icon_state = on_icon_state
		item_state = on_item_state
		w_class = weight_class_on
		force = active_force
		attack_verb = list("smacked", "struck", "cracked", "beaten")
	else
		to_chat(user, desc["local_off"])
		icon_state = off_icon_state
		item_state = null //no sprite for concealment even when in hand
		slot_flags = ITEM_SLOT_BELT
		w_class = WEIGHT_CLASS_SMALL
		force = force_off
		attack_verb = list("hit", "poked")

	playsound(src.loc, on_sound, 50, TRUE)
	add_fingerprint(user)

/obj/item/melee/classic_baton/telescopic/contractor_baton
	name = "contractor baton"
	desc = "A compact, specialised baton assigned to Syndicate contractors. Applies light electrical shocks to targets."
	icon_state = "contractor_baton"
	item_state = null
	slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_SMALL
	item_flags = NONE
	force = 5

	cooldown = 25
	stamina_damage = 85
	affect_silicon = TRUE
	on_sound = 'sound/weapons/contractorbatonextend.ogg'
	on_stun_sound = 'sound/effects/contractorbatonhit.ogg'

	on_icon_state = "contractor_baton_on"
	off_icon_state = "contractor_baton"
	on_item_state = "contractor_baton"
	active_force = 16
	force_off = 5
	weight_class_on = WEIGHT_CLASS_NORMAL

/obj/item/melee/classic_baton/telescopic/contractor_baton/get_wait_description()
	return span_danger("The baton is still charging!")

/obj/item/melee/classic_baton/telescopic/contractor_baton/additional_effects_carbon(mob/living/target, mob/living/user)
	target.set_timed_status_effect(40 SECONDS, /datum/status_effect/jitter, only_if_higher = TRUE)
	target.stuttering += 20
