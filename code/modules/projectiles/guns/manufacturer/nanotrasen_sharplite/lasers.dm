/obj/item/gun/energy/e_gun/mini
	name = "SL X-26"
	desc = "Needs description."

	icon = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/onmob.dmi'

	icon_state = "x26"
	item_state = "x26"

	w_class = WEIGHT_CLASS_SMALL
	default_ammo_type = /obj/item/stock_parts/cell/gun/mini
	allowed_ammo_types = list(
		/obj/item/stock_parts/cell/gun/mini,
	)
	throwforce = 11 //This is funny, trust me.
	shaded_charge = TRUE
	wield_delay = 0.2 SECONDS
	wield_slowdown = LASER_PISTOL_SLOWDOWN

	spread = 2
	spread_unwielded = 5

/obj/item/gun/energy/e_gun/mini/empty_cell
	spawn_no_ammo = TRUE
