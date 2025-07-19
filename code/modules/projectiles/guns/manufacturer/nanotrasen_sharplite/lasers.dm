/obj/item/gun/energy/sharplite
	name = "sharplite laser gun"
	desc = "The newest from sharplite! The 'adminhelp if you see this!' Wow! A bit of a disapointment you feel, though."
	icon = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/onmob.dmi'

	ammo_type = list(/obj/item/ammo_casing/energy/disabler/sharplite, /obj/item/ammo_casing/energy/laser/sharplite)

	muzzleflash_iconstate = "muzzle_flash_pulse"

	modifystate = TRUE
	ammo_x_offset = 2
	dual_wield_spread = 60
	wield_slowdown = LASER_RIFLE_SLOWDOWN
	manufacturer = MANUFACTURER_SHARPLITE_NEW
	w_class = WEIGHT_CLASS_NORMAL

// /obj/item/gun/energy/sharplite/x26
/obj/item/gun/energy/e_gun/mini
	name = "SL X-26"
	desc = "Needs description. 2 fire mode pistol"

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
	ammo_type = list(/obj/item/ammo_casing/energy/disabler/sharplite, /obj/item/ammo_casing/energy/laser/sharplite)

	shaded_charge = TRUE
	modifystate = TRUE

	throwforce = 11 //This is funny, trust me.

	wield_delay = 0.2 SECONDS
	wield_slowdown = LASER_PISTOL_SLOWDOWN

	spread = 4
	spread_unwielded = 8

/obj/item/gun/energy/sharplite/l201
	name = "SL L-201"
	desc = "Needs Desc. Laser DMR"

	icon_state = "l201"
	item_state = "l201"
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	custom_materials = list(/datum/material/iron=2000)
	ammo_type = list(/obj/item/ammo_casing/energy/lasergun/sharplite)
	ammo_x_offset = 1
	shaded_charge = TRUE
	modifystate = FALSE
	//supports_variations = VOX_VARIATION
	manufacturer = MANUFACTURER_SHARPLITE_NEW

	zoomable = TRUE //this var as true without setting anything else produces a 2x zoom
	wield_slowdown = DMR_SLOWDOWN
	aimed_wield_slowdown = LONG_RIFLE_AIM_SLOWDOWN
	zoom_amt = DMR_ZOOM
	wield_delay = 1 SECONDS

	spread = 0
	spread_unwielded = 12

/obj/item/gun/energy/sharplite/l201/carbine
	name = "SL L-204"
	desc = "Needs Desc. Laser Carbine"
	icon_state = "l204"
	item_state = "l204"

	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_BACK

	zoomable = FALSE
	wield_slowdown = SMG_SLOWDOWN
	aimed_wield_slowdown = LONG_RIFLE_AIM_SLOWDOWN
	wield_delay = 0.4 SECONDS

	spread = 2
	spread_unwielded = 10


/obj/item/gun/energy/e_gun/mini/empty_cell
	spawn_no_ammo = TRUE

/obj/item/gun/energy/sharplite/x12
	name = "SL X-12"
	desc = "Needs Desc. 2 fire mode Carbine"

	icon_state = "x12"
	item_state = "x12"
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_BELT
	custom_materials = list(/datum/material/iron=2000)
	ammo_type = list(/obj/item/ammo_casing/energy/disabler/sharplite, /obj/item/ammo_casing/energy/laser/sharplite)
	ammo_x_offset = 1
	shaded_charge = TRUE
	modifystate = FALSE
	manufacturer = MANUFACTURER_SHARPLITE_NEW

	zoomable = FALSE
	wield_slowdown = SMG_SLOWDOWN
	aimed_wield_slowdown = LONG_RIFLE_AIM_SLOWDOWN
	wield_delay = 0.4 SECONDS

	spread = 2
	spread_unwielded = 10

// /obj/item/gun/energy/sharplite/l305
/obj/item/gun/energy/e_gun/smg
	name = "\improper L-305"
	desc = "Needs Desc. 2 fire mode SMG."

	icon = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/onmob.dmi'

	icon_state = "l305"
	item_state = "l305"

	ammo_type = list(/obj/item/ammo_casing/energy/laser/sharplite/smg)
	//ammo_type = list(/obj/item/ammo_casing/energy/disabler/sharplite/smg, /obj/item/ammo_casing/energy/laser/sharplite/smg)
	shaded_charge = TRUE
	modifystate = FALSE
	weapon_weight = WEAPON_LIGHT

	fire_delay = 0.13 SECONDS
	wield_slowdown = LASER_SMG_SLOWDOWN

	gun_firemodes = list(FIREMODE_SEMIAUTO, FIREMODE_FULLAUTO)
	default_firemode = FIREMODE_SEMIAUTO

// /obj/item/gun/energy/sharplite/x46
/obj/item/gun/energy/e_gun/iot
	name = "\improper SL X-46"
	desc = "Needs Desc. 2 fire mode shotgun."

	icon_state = "x46"
	item_state = "x46"
	shaded_charge = TRUE
	modifystate = FALSE
	ammo_type = list(/obj/item/ammo_casing/energy/laser/ultima)
	//ammo_type = list(/obj/item/ammo_casing/energy/disabler/scatter/ultima, /obj/item/ammo_casing/energy/laser/ultima)
	w_class = WEIGHT_CLASS_BULKY

	wield_slowdown = SHOTGUN_SLOWDOWN
	aimed_wield_slowdown = SHOTGUN_AIM_SLOWDOWN
	wield_delay = 0.8 SECONDS

	zoom_amt = SHOTGUN_ZOOM

/obj/item/gun/energy/e_gun/iot/zeta
	name = "\improper SL X-46 Rev. 1"
	desc = "Needs Desc. A very old looking X-46, it has no stock or much decoration, and it is from before Sharplite cut the disable mode... Hey! What's this screen next to the mode select button?"

	icon_state = "x46_zeta"
	item_state = "x46_zeta"
	shaded_charge = TRUE
	manufacturer = MANUFACTURER_SHARPLITE
	ammo_type = list(/obj/item/ammo_casing/energy/disabler/scatter/ultima, /obj/item/ammo_casing/energy/laser/ultima)
	w_class = WEIGHT_CLASS_BULKY
	var/obj/item/modular_computer/integratedNTOS
	var/NTOS_type = /obj/item/modular_computer/internal
