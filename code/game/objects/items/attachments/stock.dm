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

/obj/item/attachment/foldable_stock/toggle_attachment(obj/item/gun/gun, mob/user)
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

	playsound(src, SOUND_EMPTY_MAG, 100, 1)

/obj/item/attachment/foldable_stock/inteq
	icon_state = "skm-inteqsmg-stock"

/obj/item/attachment/foldable_stock/spitter
	icon = 'icons/obj/guns/manufacturer/frontier_import/48x32.dmi'
	icon_state = "spitter_stock"

/obj/item/attachment/foldable_stock/sidewinder
	icon = 'icons/obj/guns/manufacturer/scarborough/48x32.dmi'
	icon_state = "sidewinder_stock"

/obj/item/attachment/foldable_stock/resolution
	icon = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/48x32.dmi'
	icon_state = "resolution_stock"

/obj/item/attachment/foldable_stock/resolution_inteq
	icon = 'icons/obj/guns/manufacturer/inteq/48x32.dmi'
	icon_state = "resolution_inteq_stock"

/obj/item/attachment/foldable_stock/wasp
	icon = 'icons/obj/guns/manufacturer/frontier_import/48x32.dmi'
	icon_state = "wasp_stock"
	pixel_shift_x = 16
	pixel_shift_y = 0

/obj/item/attachment/foldable_stock/wasp/toggle_attachment(obj/item/gun/gun, mob/user)
	. = ..()
	if(toggled)
		pixel_shift_x = 32
	else
		pixel_shift_x = 16
