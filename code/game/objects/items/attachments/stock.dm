/obj/item/attachment/foldable_stock
	name = "folding stock"
	desc = "A folding stock that can be attached to certain weapons to improve stability and decreases recoil."
	icon_state = "skm-carbine-stock"
	slot = ATTACHMENT_SLOT_STOCK
	attach_features_flags = ATTACH_TOGGLE

	pixel_shift_x = 17
	pixel_shift_y = 18

	var/toggled_slowdown = 0.10
	var/toggled_wield_delay = -0.4 SECONDS
	var/toggled_recoil_bonus = -2
	var/toggled_spread_bonus = -5

/obj/item/attachment/foldable_stock/Toggle(obj/item/gun/gun, mob/user)
	. = ..()

	if(toggled)
		to_chat(user, span_notice("You unfold the stock on the [src]."))
		gun.w_class += 1
		gun.wield_delay += toggled_wield_delay
		gun.wield_slowdown += toggled_slowdown
		gun.recoil += toggled_recoil_bonus
		gun.spread += toggled_spread_bonus
	else
		to_chat(user, span_notice("You fold the stock on the [src]."))
		gun.w_class -= 1
		gun.wield_delay -= toggled_wield_delay
		gun.wield_slowdown -= toggled_slowdown
		gun.recoil -= toggled_recoil_bonus
		gun.spread -= toggled_spread_bonus

	if(gun.wielded)
		user.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/gun, multiplicative_slowdown = gun.wield_slowdown)

	playsound(src, 'sound/weapons/empty.ogg', 100, 1)

/obj/item/attachment/foldable_stock/inteq
	icon_state = "skm-inteqsmg-stock"
