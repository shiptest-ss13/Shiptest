/*
/obj/item/attachment/bipod
	name = "bipod"
	desc = "A bipod that can be attached to a weapon to improve stability."
	icon_state = "laserpointer"
	attach_features_flags = ATTACH_REMOVABLE|ATTACH_TOGGLE

/obj/item/attachment/bipod/Attach(obj/item/gun/gun, mob/user)
	gun.has_bipod = TRUE

/obj/item/attachment/bipod/Detach(obj/item/gun/gun, mob/user)
	gun.has_bipod = FALSE

/obj/item/attachment/foldable_stock
	name = "foldable stock"
	desc = "A foldable stock that can be attached to a weapon to improve stability."
	icon_state = "laserpointer"
	attach_features_flags = ATTACH_REMOVABLE|ATTACH_TOGGLE

/obj/item/attachment/foldable_stock/Attach(obj/item/gun/gun, mob/user)
	gun.w_class = WEIGHT_CLASS_NORMAL
	gun.wield_delay = gun.unfolded_wield_delay
	gun.wield_slowdown = gun.unfolded_slowdown

/obj/item/attachment/foldable_stock/Toggle(obj/item/gun/gun, mob/user)
	. = ..()
	if(toggled)
		to_chat(user, "<span class='notice'>You unfold the stock on the [src].</span>")
		gun.w_class = WEIGHT_CLASS_BULKY
		gun.wield_delay = gun.folded_wield_delay
		gun.wield_slowdown = gun.folded_slowdown
	else
		to_chat(user, "<span class='notice'>You fold the stock on the [src].</span>")
		gun.w_class = WEIGHT_CLASS_NORMAL
		gun.wield_delay = gun.unfolded_wield_delay
		gun.wield_slowdown = gun.unfolded_slowdown

	if(wielded)
		user.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/gun, multiplicative_slowdown = wield_slowdown)

	toggled = !toggled
	playsound(src, 'sound/weapons/empty.ogg', 100, 1)

/obj/item/attachment/foldable_stock/Detach(obj/item/gun/gun, mob/user)
	. = ..()
	gun.w_class = initial(gun.w_class)
	gun.wield_delay = initial(gun.unfolded_wield_delay)
	gun.wield_slowdown = initial(gun.unfolded_slowdown)

/obj/item/attachment/scope
	name = "scope"
	icon_state = "scope"
	slot = ATTACHMENT_SLOT_SCOPE
	var/zoom_amt = 10 //Long range, enough to see in front of you, but no tiles behind you.
	var/zoom_out_amt = 5

/obj/item/attachment/scope/Attach(obj/item/gun/gun, mob/user)
	. = ..()
	gun.zoomable = TRUE
	gun.zoom_amt = zoom_amt
	gun.zoom_out_amt = zoom_out_amt
	gun.build_zooming()

/obj/item/attachment/scope/Detach(obj/item/gun/gun, mob/user)
	. = ..()
	gun.zoomable = FALSE
	gun.zoom_amt = initial(gun.zoom_amt)
	gun.zoom_out_amt = initial(gun.zoom_out_amt)
	gun.actions -= gun.azoom
	qdel(gun.azoom)
	return TRUE
*/

/*
/obj/item/attachment/e_bayonet
	name = "bayonet"
	desc = "Stabby-Stabby"
	icon_state = "ebayonet"
	force = 2

	attach_features_flags = ATTACH_REMOVABLE|ATTACH_TOGGLE
	var/force_on = 20
	var/extended = FALSE
	var/reach_extended = 2
	var/force_extended = 10

/obj/item/attachment/e_bayonet/Toggle(obj/item/gun/gun, mob/user)
	. = ..()

	reach = toggled ? reach : initial(reach)
	force = toggled ? force : initial(force)

	playsound(gun, 'sound/weapons/batonextend.ogg', 30)
	user.visible_message("[user] [toggled ? "expands" : "retracts"] [user.p_their()] [src].", "You [toggled ? "expand" : "retract"] \the [src].")

/obj/item/attachment/e_bayonet/PreAttack(obj/item/gun/gun, atom/target, mob/living/user, list/params)
	// Call our melee chain if they are are trying to melee attack something they can reach
	if(user.a_intent == INTENT_HARM && user.CanReach(target, src, TRUE))
		if(target == user && toggled)
			extended = !extended
			reach = extended ? reach_extended : initial(reach)
			gun.reach = reach // Even if your gun has a longer reach you default to the bayonets because STAB STAB STAB
			force = extended ? force_extended : force_on
			// Hey, I just met you
			if(extended) // And this is crazy
				icon_state += "-long" // But heres my number
			else // Call me never
				icon_state = replacetext(icon_state, "-long", "") // Because why is this so ugly
			user.visible_message("[user] [extended ? "increased" : "decreased"] the length of [src].")
			return COMPONENT_NO_ATTACK
		melee_attack_chain(user, target, params)
		return COMPONENT_NO_ATTACK
*/
