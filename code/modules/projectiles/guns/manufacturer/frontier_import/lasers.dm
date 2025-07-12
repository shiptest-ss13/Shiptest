/obj/item/gun/energy/laser/wasp
	name = "Wasp"
	desc = "While the E-40 was the finest laser rifle of it's day, many have failed over the years to time. This is the New Frontiersmen solution to that problem. Removing the ballistic parts while keeping the internal electronics. They also take modern NT power cells in exchange for a weaker lens."
	icon_state = "wasp"
	item_state = "wasp"

	icon = 'icons/obj/guns/manufacturer/frontier_import/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/frontier_import/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/frontier_import/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/frontier_import/onmob.dmi'

	fire_sound = 'sound/weapons/laser4.ogg'
	w_class = WEIGHT_CLASS_NORMAL
	ammo_type = list(/obj/item/ammo_casing/energy/lasergun/eoehoma/wasp)
	fire_delay = 0.1 SECONDS

	spread = 12
	spread_unwielded = 25
	wield_slowdown = SMG_SLOWDOWN
	manufacturer = MANUFACTURER_IMPORT

	gun_firemodes = list(FIREMODE_FULLAUTO)
	default_firemode = FIREMODE_FULLAUTO
	latch_toggle_delay = 0.8 SECONDS
	valid_attachments = list(
		/obj/item/attachment/foldable_stock/wasp
	)
	slot_available = list(
		ATTACHMENT_SLOT_MUZZLE = 1,
		ATTACHMENT_SLOT_STOCK = 1
	)

	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 33,
			"y" = 18,
		),
		ATTACHMENT_SLOT_STOCK = list(
			"x" = 0,
			"y" = 0,
		)
	)

	default_attachments = list(/obj/item/attachment/foldable_stock/wasp)
