/obj/item/gun/energy/laser/e10
	name = "E-10 laser pistol"
	desc = "A very old laser weapon. Despite the extreme age of some of these weapons, they are sometimes preferred to newer, mass-produced Nanotrasen laser weapons."
	icon = 'icons/obj/guns/manufacturer/eoehoma/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/eoehoma/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/eoehoma/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/eoehoma/onmob.dmi'
	icon_state = "e10"
	item_state = "e_generickill4"
	w_class = WEIGHT_CLASS_SMALL

	wield_delay = 0.2 SECONDS
	wield_slowdown = LASER_PISTOL_SLOWDOWN

	spread = 6
	spread_unwielded = 10

	ammo_type = list(/obj/item/ammo_casing/energy/lasergun/eoehoma, /obj/item/ammo_casing/energy/lasergun/eoehoma/heavy)
	manufacturer = MANUFACTURER_EOEHOMA


/obj/item/gun/energy/e_gun/e11
	name = "E-11 hybrid energy rifle"
	desc = "A hybrid energy gun fondly remembered as one of the worst weapons ever made. It hurts, but that's only if it manages to hit its target."
	icon = 'icons/obj/guns/manufacturer/eoehoma/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/eoehoma/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/eoehoma/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/eoehoma/onmob.dmi'
	icon_state = "e11"
	item_state = "e_generickill4"

	ammo_type = list(/obj/item/ammo_casing/energy/disabler, /obj/item/ammo_casing/energy/laser/eoehoma)
	ammo_x_offset = 0
	spread = 30
	spread_unwielded = 40
	dual_wield_spread = 40
	shaded_charge = TRUE
	manufacturer = MANUFACTURER_EOEHOMA

/obj/item/gun/energy/e_gun/e11/empty_cell
	spawn_no_ammo = TRUE


/obj/item/gun/energy/laser/e50
	name = "E-50 energy emitter"
	desc = "A heavy and extremely powerful laser. Sets targets on fire and kicks ass, but it uses a massive amount of energy per shot and is generally awkward to handle."

	icon = 'icons/obj/guns/manufacturer/eoehoma/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/eoehoma/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/eoehoma/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/eoehoma/onmob.dmi'
	icon_state = "e50"
	item_state = "e50"

	default_ammo_type = /obj/item/stock_parts/cell/gun/large
	allowed_ammo_types = list(
		/obj/item/stock_parts/cell/gun/large,
	)
	ammo_type = list(/obj/item/ammo_casing/energy/laser/eoehoma/e50)
	weapon_weight = WEAPON_HEAVY
	w_class = WEIGHT_CLASS_BULKY
	manufacturer = MANUFACTURER_EOEHOMA

	wield_delay = 0.7 SECONDS
	wield_slowdown = LASER_SNIPER_SLOWDOWN
	spread_unwielded = 20

	shaded_charge = FALSE
	ammo_x_offset = 4
	charge_sections = 2
	slot_flags = 0

	unique_attachments = list(
		/obj/item/attachment/scope,
		/obj/item/attachment/long_scope,
	)

	slot_available = list(
		ATTACHMENT_SLOT_MUZZLE = 1,
		ATTACHMENT_SLOT_RAIL = 1,
		ATTACHMENT_SLOT_SCOPE = 1
	)

/obj/item/gun/energy/disabler/e60
	name = "E-60 personal defense disabler"
	desc = "A self-defense weapon that exhausts organic targets, weakening them until they collapse."
	icon = 'icons/obj/guns/manufacturer/eoehoma/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/eoehoma/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/eoehoma/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/eoehoma/onmob.dmi'
	icon_state = "e60"
	item_state = "e_genericdisable4"

	shaded_charge = TRUE
	manufacturer = MANUFACTURER_EOEHOMA
