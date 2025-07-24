/obj/item/gun/energy/sharplite
	name = "sharplite laser gun"
	desc = "The newest from sharplite! The 'adminhelp if you see this!' Wow! A bit of a disapointment you feel, though."
	icon = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/onmob.dmi'

	ammo_type = list(/obj/item/ammo_casing/energy/disabler/sharplite, /obj/item/ammo_casing/energy/laser/sharplite)


	default_ammo_type = /obj/item/stock_parts/cell/gun/sharplite

	allowed_ammo_types = list(
		/obj/item/stock_parts/cell/gun/sharplite,
		/obj/item/stock_parts/cell/gun/sharplite/plus,
		/obj/item/stock_parts/cell/gun/sharplite/empty,
		/obj/item/stock_parts/cell/gun/sharplite/plus/empty,
	)

	muzzleflash_iconstate = "muzzle_flash_nt"

	modifystate = TRUE
	ammo_x_offset = 2
	dual_wield_spread = 60
	wield_slowdown = LASER_RIFLE_SLOWDOWN
	manufacturer = MANUFACTURER_SHARPLITE_NEW
	w_class = WEIGHT_CLASS_NORMAL

// /obj/item/gun/energy/sharplite/x26
/obj/item/gun/energy/e_gun/mini
	name = "SL X26 Variable Energy Pistol"
	desc = "Needs description. 2 fire mode pistol"

	icon = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/onmob.dmi'

	icon_state = "x26"
	item_state = "x26"

	w_class = WEIGHT_CLASS_NORMAL
	default_ammo_type = /obj/item/stock_parts/cell/gun/sharplite/mini
	allowed_ammo_types = list(
		/obj/item/stock_parts/cell/gun/sharplite/mini,
	)
	ammo_type = list(/obj/item/ammo_casing/energy/disabler/sharplite, /obj/item/ammo_casing/energy/laser/sharplite/efficent)

	shaded_charge = TRUE
	modifystate = TRUE

	throwforce = 11 //This is funny, trust me.

	wield_delay = 0.2 SECONDS
	wield_slowdown = LASER_PISTOL_SLOWDOWN

	spread = 4
	spread_unwielded = 8

	muzzleflash_iconstate = "muzzle_flash_nt"

// /obj/item/gun/energy/sharplite/x01
/obj/item/gun/energy/e_gun/hos
	name = "SL X01 Heavy Variable Pistol"
	desc = "Needs desc. Heavy laser pistol"


	icon = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/onmob.dmi'

	w_class = WEIGHT_CLASS_NORMAL
	icon_state = "x01"
	item_state = "x26"

	default_ammo_type = /obj/item/stock_parts/cell/gun/upgraded
	force = 10
	ammo_type = list(/obj/item/ammo_casing/energy/disabler/sharplite/hos, /obj/item/ammo_casing/energy/laser/sharplite/hos, /obj/item/ammo_casing/energy/ion/hos, /obj/item/ammo_casing/energy/electrode/hos)
	shaded_charge = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	manufacturer = MANUFACTURER_SHARPLITE_NEW

/obj/item/gun/energy/e_gun/hos/brazil
	name = "modified antique laser gun"
	desc = "It's somehow modified to have more firemodes."
	icon_state = "capgun_brazil_hos"
	item_state = "hoslaserkill0"
	manufacturer = MANUFACTURER_SHARPLITE

/obj/item/gun/energy/e_gun/hos/brazil/true
	desc = "This genuine antique laser gun, modified with an experimental suite of alternative firing modes based on the X-01 MultiPhase Energy Gun, is now truly one of the finest weapons in the frontier."
	icon_state = "capgun_hos"
	item_state = "hoslaserkill0"
	selfcharge = 1
	manufacturer = MANUFACTURER_SHARPLITE

// /obj/item/gun/energy/sharplite/l305
/obj/item/gun/energy/e_gun/smg
	name = "\improper L305 Tactical Plasma Gun"
	desc = "Needs Desc. laser SMG. Are these names too wordy?"

	icon = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/onmob.dmi'

	icon_state = "l305"
	item_state = "l305"

	ammo_type = list(/obj/item/ammo_casing/energy/laser/sharplite/smg)

	default_ammo_type = /obj/item/stock_parts/cell/gun/sharplite

	allowed_ammo_types = list(
		/obj/item/stock_parts/cell/gun/sharplite,
		/obj/item/stock_parts/cell/gun/sharplite/plus,
		/obj/item/stock_parts/cell/gun/sharplite/empty,
		/obj/item/stock_parts/cell/gun/sharplite/plus/empty,
	)

	shaded_charge = TRUE
	modifystate = FALSE
	weapon_weight = WEAPON_LIGHT

	fire_delay = 0.13 SECONDS
	wield_slowdown = LASER_SMG_SLOWDOWN

	gun_firemodes = list(FIREMODE_SEMIAUTO, FIREMODE_FULLAUTO)
	default_firemode = FIREMODE_SEMIAUTO


/obj/item/gun/energy/sharplite/l201
	name = "SL L201 Marksman Plasma Rifle"
	desc = "Needs Desc. Laser DMR"

	icon_state = "l201"
	item_state = "l201"
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	custom_materials = list(/datum/material/iron=2000)
	ammo_type = list(/obj/item/ammo_casing/energy/lasergun/sharplite/dmr)
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

/obj/item/gun/energy/sharplite/l201/l204
	name = "SL L204 Plasma Rifle"
	desc = "Needs Desc. Laser Carbine"
	icon_state = "l204"
	item_state = "l204"

	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_BACK
	ammo_type = list(/obj/item/ammo_casing/energy/lasergun/sharplite)

	zoomable = FALSE
	wield_slowdown = SMG_SLOWDOWN
	aimed_wield_slowdown = LONG_RIFLE_AIM_SLOWDOWN
	wield_delay = 0.4 SECONDS

	spread = 2
	spread_unwielded = 10


/obj/item/gun/energy/e_gun/mini/empty_cell
	spawn_no_ammo = TRUE

//repath /obj/item/gun/energy/e_gun to
/obj/item/gun/energy/sharplite/x12
	name = "SL X12 Variable Energy Carbine"
	desc = "Needs Desc. 2 fire mode Carbine"

	icon_state = "x12"
	item_state = "x12"
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_BELT
	custom_materials = list(/datum/material/iron=2000)
	ammo_type = list(/obj/item/ammo_casing/energy/disabler/sharplite, /obj/item/ammo_casing/energy/laser/sharplite)
	ammo_x_offset = 1
	shaded_charge = TRUE
	modifystate = TRUE
	manufacturer = MANUFACTURER_SHARPLITE_NEW

	wield_slowdown = SMG_SLOWDOWN
	aimed_wield_slowdown = LONG_RIFLE_AIM_SLOWDOWN
	wield_delay = 0.4 SECONDS

	spread = 2
	spread_unwielded = 10

/obj/item/gun/energy/sharplite/x12/inteq
	name = "PP10 “Cadejo” Energy Carbine"
	desc = "TODO"

	icon = 'icons/obj/guns/manufacturer/inteq/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/inteq/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/inteq/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/inteq/onmob.dmi'

	icon_state = "x12_inteq"
	item_state = "x12_inteq"


// /obj/item/gun/energy/sharplite/x46
/obj/item/gun/energy/e_gun/iot
	name = "\improper SL X46 Variable Energy Blaster"
	desc = "Needs Desc. 2 fire mode shotgun."

	icon_state = "x46"
	item_state = "x46"
	shaded_charge = TRUE
	modifystate = TRUE
	ammo_type = list(/obj/item/ammo_casing/energy/disabler/scatter/shotgun/sharplite, /obj/item/ammo_casing/energy/laser/shotgun/sharplite)

	default_ammo_type = /obj/item/stock_parts/cell/gun/sharplite

	allowed_ammo_types = list(
		/obj/item/stock_parts/cell/gun/sharplite,
		/obj/item/stock_parts/cell/gun/sharplite/plus,
		/obj/item/stock_parts/cell/gun/sharplite/empty,
		/obj/item/stock_parts/cell/gun/sharplite/plus/empty,
	)

	w_class = WEIGHT_CLASS_BULKY
	fire_delay = 0.6 SECONDS
	shaded_charge = TRUE

	wield_slowdown = SHOTGUN_SLOWDOWN
	aimed_wield_slowdown = SHOTGUN_AIM_SLOWDOWN
	wield_delay = 0.8 SECONDS

	zoom_amt = SHOTGUN_ZOOM

//repath /obj/item/gun/energy/laser/iot to this
//repath /obj/item/gun/energy/laser/iot/lethal to this
/obj/item/gun/energy/e_gun/iot/zeta
	name = "\improper SL X-46 Rev. 1"
	desc = "Needs Desc. A very old looking X-46, it has no stock or much decoration, and it is from before Sharplite cut the disable mode... Hey! What's this screen next to the mode select button?"

	icon_state = "x46_zeta"
	item_state = "x46_zeta"
	shaded_charge = TRUE
	manufacturer = MANUFACTURER_SHARPLITE

	w_class = WEIGHT_CLASS_BULKY
	var/obj/item/modular_computer/integratedNTOS
	var/NTOS_type = /obj/item/modular_computer/internal

// /obj/item/gun/energy/sharplite/al655
/obj/item/gun/energy/e_gun/hades
	name = "SL AL655 Assault Plasma Rifle"
	desc = "Needs desc. laser assault rifle. Add something like; Affectionately nicnamed the 'Hades' by ICW security forces due to the terrible burns it would cause, only possible from 'fire from hades itself.'"
	icon_state = "al655"
	item_state = "al655"

	ammo_type = list(/obj/item/ammo_casing/energy/laser/assault/sharplite)
	default_ammo_type = /obj/item/stock_parts/cell/gun/sharplite/plus

	allowed_ammo_types = list(
		/obj/item/stock_parts/cell/gun/sharplite/plus,
		/obj/item/stock_parts/cell/gun/sharplite/plus/empty,
	)

	weapon_weight = WEAPON_MEDIUM
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK

	gun_firemodes = list(FIREMODE_SEMIAUTO, FIREMODE_FULLAUTO)
	default_firemode = FIREMODE_SEMIAUTO

	shaded_charge = TRUE
	modifystate = FALSE

	fire_delay = 0.2 SECONDS

	wield_delay = 0.7 SECONDS
	wield_slowdown = HEAVY_LASER_RIFLE_SLOWDOWN
	spread_unwielded = 20

/obj/item/gun/energy/e_gun/hades/inteq
	name = "PP20 “Barghest” APR"
	desc = "TODO"

	icon = 'icons/obj/guns/manufacturer/inteq/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/inteq/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/inteq/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/inteq/onmob.dmi'

	icon_state = "al655_inteq"
	item_state = "al655_inteq"


//REMEMBER TO REMOVE /obj/item/gun/energy/e_gun/nuclear FROM rockplanet_mining_installation.dmm

/obj/item/gun/energy/sharplite/al607
	name = "SL AL607 Plasma Accelerator"
	desc = "A heavy electroplasma rifle with an extensive accelerator assembly, with an overall length almost comparable to the average Kepori height. Produces singular electroplasma bolts of impressive power and velocity that strike with enough force and precision to overwhelm most infantry defenses. Rarely used, even by Vigilitas paramilitary units"
	icon_state = "al607"
	item_state = "al607"

	ammo_type = list(/obj/item/ammo_casing/energy/lasergun/sharplite/sniper)
	default_ammo_type = /obj/item/stock_parts/cell/gun/sharplite/plus

	allowed_ammo_types = list(
		/obj/item/stock_parts/cell/gun/sharplite/plus,
		/obj/item/stock_parts/cell/gun/sharplite/plus/empty,
	)

	weapon_weight = WEAPON_MEDIUM
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK

	gun_firemodes = list(FIREMODE_SEMIAUTO)
	default_firemode = FIREMODE_SEMIAUTO

	shaded_charge = TRUE
	modifystate = FALSE

	slot_flags = ITEM_SLOT_BACK

	spread_unwielded = 40

	wield_slowdown = SNIPER_SLOWDOWN
	wield_delay = 1.3 SECONDS

	zoom_amt = 10 //Long range, enough to see in front of you, but no tiles behind you.
	zoom_out_amt = 5


// /obj/item/gun/energy/laser/hitscanpistol TO THIS
/obj/item/gun/energy/sharplite/x11
	name = "X11 Advanced Stopping Pistol"
	desc = "An advanced energy revolver with the capacity to shoot both disabler and lethal lasers, as well as futuristic safari nets."
	icon_state = "bsgun"
	item_state = "gun"
	force = 7
	ammo_type = list(/obj/item/ammo_casing/energy/disabler/sharplite/hos, /obj/item/ammo_casing/energy/laser/sharplite/hos, /obj/item/ammo_casing/energy/trap)
	ammo_x_offset = 1
	shaded_charge = TRUE

/obj/item/gun/energy/laser/retro
	name ="SL L104"
	desc = "An antiquated model of the L204, no longer used or sold by Sharplite. Nevertheless, the sheer popularity of this model makes it a somewhat common sight to this day."

	icon = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/onmob.dmi'

	icon_state = "laser"
	item_state = "laser"

	manufacturer = MANUFACTURER_SHARPLITE
	default_ammo_type = /obj/item/stock_parts/cell/gun/sharplite

	allowed_ammo_types = list(
		/obj/item/stock_parts/cell/gun/sharplite,
		/obj/item/stock_parts/cell/gun/sharplite/plus,
		/obj/item/stock_parts/cell/gun/sharplite/empty,
		/obj/item/stock_parts/cell/gun/sharplite/plus/empty,
	)

/obj/item/gun/energy/laser/captain
	name = "antique laser gun"
	icon = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/onmob.dmi'
	icon_state = "caplaser"
	item_state = "caplaser"
	desc = "This is the SL X-00, an antique laser gun, out of production for decades and well beyond anyone's capacity to recreate. All craftsmanship is of the highest quality. It is decorated with ashdrake leather and chrome. The gun menaces with spikes of energy. On the item is an image of a space station. The station is exploding."
	force = 10
	ammo_x_offset = 3
	selfcharge = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	manufacturer = MANUFACTURER_SHARPLITE

/obj/item/gun/energy/laser/captain/brazil
	icon_state = "capgun_brazil"
	item_state = "caplaser"
	desc = "This is the SL X-00, an antique laser gun, out of production for decades and well beyond anyone's capacity to recreate. It seems all the high quality materials it was once made of are now scratched up and torn. The nuclear power cell has been removed, and the gun will no longer automatically recharge."
	selfcharge = FALSE
