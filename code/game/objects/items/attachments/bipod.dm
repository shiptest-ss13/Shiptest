/*
/obj/item/attachment/bipod
	name = "bipod"
	desc = "A bipod that can be attached to a weapon to improve stability."
	icon_state = "laserpointer"
	has_toggle = TRUE

/obj/item/attachment/bipod/Attach(obj/item/gun/gun, mob/user)
	gun.has_bipod = TRUE

/obj/item/attachment/bipod/Detach(obj/item/gun/gun, mob/user)
	gun.has_bipod = FALSE

/obj/item/attachment/foldable_stock
	name = "foldable stock"
	desc = "A foldable stock that can be attached to a weapon to improve stability."
	icon_state = "laserpointer"
	has_toggle = TRUE

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
*/
