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
	light_color = COLOR_PALE_BLUE_GRAY

	modifystate = TRUE
	ammo_x_offset = 2
	dual_wield_spread = 60
	wield_slowdown = LASER_RIFLE_SLOWDOWN
	manufacturer = MANUFACTURER_SHARPLITE_NEW
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/gun/energy/sharplite/x26
	name = "SL X26 “Ohm” Variable Energy Pistol"
	desc = "A compact energy pistol that can fire lethal electroplasma bolts or stamina-draining disabler bolts."

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

/obj/item/gun/energy/sharplite/x01
	name = "SL X01 “Yari” Heavy Variable Pistol"
	desc = "A bulky pistol that can fire devastating electroplasma bolts and disabler shots. An early Sharplite product notable for unusually strong power output."


	icon = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/onmob.dmi'

	w_class = WEIGHT_CLASS_NORMAL
	icon_state = "x01"
	item_state = "x26"

	default_ammo_type = /obj/item/stock_parts/cell/gun/sharplite/plus
	allowed_ammo_types = list(
		/obj/item/stock_parts/cell/gun/sharplite,
		/obj/item/stock_parts/cell/gun/sharplite/plus,
	)
	force = 10
	ammo_type = list(/obj/item/ammo_casing/energy/disabler/sharplite/hos, /obj/item/ammo_casing/energy/laser/sharplite/hos, /obj/item/ammo_casing/energy/ion/hos)
	shaded_charge = FALSE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	manufacturer = MANUFACTURER_SHARPLITE_NEW

/obj/item/gun/energy/sharplite/x01/brazil
	name = "modified antique laser gun"
	desc = "It's somehow modified to have more firemodes."
	icon_state = "capgun_brazil_hos"
	item_state = "hoslaserkill0"
	manufacturer = MANUFACTURER_SHARPLITE

/obj/item/gun/energy/sharplite/x01/brazil/true
	desc = "This genuine antique laser gun, modified with an experimental suite of alternative firing modes based on the X-01 MultiPhase Energy Gun, is now truly one of the finest weapons in the frontier."
	icon_state = "capgun_hos"
	item_state = "hoslaserkill0"
	selfcharge = 1
	manufacturer = MANUFACTURER_SHARPLITE

/obj/item/gun/energy/sharplite/l305
	name = "\improper L305 “Rush” Tactical Plasma Gun"
	desc = "A radical development on the X26 frame, fitted with a rapid-cycle plasma chamber and designed to produce sustained bursts of low-power electroplasma bolts."

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
	w_class = WEIGHT_CLASS_BULKY

	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_SUITSTORE

	fire_delay = 0.13 SECONDS
	wield_slowdown = LASER_SMG_SLOWDOWN

	gun_firemodes = list(FIREMODE_SEMIAUTO, FIREMODE_FULLAUTO)
	default_firemode = FIREMODE_SEMIAUTO


/obj/item/gun/energy/sharplite/l201
	name = "SL L201 “Surge” Marksman Plasma Rifle"
	desc = "A long rifle-sized electroplasma gun. Specialized for long-range shooting, with an extended focusing assembly that produces much higher projectile velocities and more powerful bolts at the cost of power usage."

	icon_state = "l201"
	item_state = "l201"
	w_class = WEIGHT_CLASS_BULKY
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

	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_SUITSTORE

	spread = 0
	spread_unwielded = 12

/obj/item/gun/energy/sharplite/l201/l204
	name = "SL L204 “Resistor” Plasma Rifle"
	desc = "A rifle-sized, semi-automatic electroplasma gun known for its low price and surprisingly low energy usage."
	icon_state = "l204"
	item_state = "l204"

	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_SUITSTORE

	ammo_type = list(/obj/item/ammo_casing/energy/lasergun/sharplite)

	zoomable = FALSE
	zoom_amt = PISTOL_ZOOM
	wield_slowdown = SMG_SLOWDOWN
	aimed_wield_slowdown = LONG_RIFLE_AIM_SLOWDOWN
	wield_delay = 0.4 SECONDS

	spread = 2
	spread_unwielded = 10

/obj/item/gun/energy/sharplite/l201/l204/empty_cell
	spawn_no_ammo = TRUE

/obj/item/gun/energy/sharplite/x26/empty_cell
	spawn_no_ammo = TRUE

/obj/item/gun/energy/sharplite/x12
	name = "SL X12 “Volt” Variable Energy Carbine"
	desc = "A short, somewhat hefty carbine that can fire electroplasma or disabler bolts. Popular with security details with low-threat assignments."

	icon_state = "x12"
	item_state = "x12"
	w_class = WEIGHT_CLASS_BULKY
	custom_materials = list(/datum/material/iron=2000)
	ammo_type = list(/obj/item/ammo_casing/energy/disabler/sharplite, /obj/item/ammo_casing/energy/laser/sharplite)
	ammo_x_offset = 1
	shaded_charge = TRUE
	modifystate = TRUE
	manufacturer = MANUFACTURER_SHARPLITE_NEW

	wield_slowdown = SMG_SLOWDOWN
	aimed_wield_slowdown = LONG_RIFLE_AIM_SLOWDOWN
	wield_delay = 0.4 SECONDS

	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_SUITSTORE

	spread = 2
	spread_unwielded = 10

/obj/item/gun/energy/sharplite/x12/empty_cell
	spawn_no_ammo = TRUE

/obj/item/gun/energy/sharplite/x12/inteq
	name = "PP10 “Cadejo” Energy Carbine"
	desc = "A Sharplite X12 VEC refinished in Inteq Risk Management Group colors. Like the base model, it fires lethal electroplasma or nonlethal disabler bolts. The modifications appear to be largely cosmetic."

	icon = 'icons/obj/guns/manufacturer/inteq/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/inteq/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/inteq/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/inteq/onmob.dmi'

	icon_state = "x12_inteq"
	item_state = "x12_inteq"


/obj/item/gun/energy/sharplite/x46
	name = "\improper SL X46 “Amperage” Variable Energy Blaster"
	desc = "A heavy, bulky weapon designed to fire multiple electroplasma or disabler bolts, not unlike a ballistic shotgun. Electroplasma speed tends to lessen the spread and increase effective range over conventional ballistic shotguns."

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

	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_SUITSTORE

	zoom_amt = SHOTGUN_ZOOM

/obj/item/gun/energy/sharplite/x46/zeta
	name = "\improper SL X-45"
	desc = "A very old looking X-46, it has no stock or much decoration, and it is from before... Hey! What's this screen next to the mode select button?"

	icon_state = "x46_zeta"
	item_state = "x46_zeta"
	shaded_charge = TRUE
	manufacturer = MANUFACTURER_SHARPLITE

	w_class = WEIGHT_CLASS_BULKY
	var/obj/item/modular_computer/integratedNTOS
	var/NTOS_type = /obj/item/modular_computer/internal

/obj/item/gun/energy/sharplite/x46/zeta/Initialize()
	. = ..()
	if(NTOS_type)
		integratedNTOS = new NTOS_type(src)
		integratedNTOS.physical = src

/obj/item/gun/energy/sharplite/x46/zeta/attack_self(mob/user)
	. = ..()
	if(!integratedNTOS)
		return
	integratedNTOS.interact(user)

/obj/item/gun/energy/sharplite/al655
	name = "SL AL655 “Hades” Assault Plasma Rifle"
	desc = "A powerful electroplasma gun with a rapid repeater assembly and many capacitors. The APR rapidly fires heavy electroplasma bolts."
	icon_state = "al655"
	item_state = "al655"

	ammo_type = list(/obj/item/ammo_casing/energy/laser/assault/sharplite)
	default_ammo_type = /obj/item/stock_parts/cell/gun/sharplite/plus

	allowed_ammo_types = list(
		/obj/item/stock_parts/cell/gun/sharplite,
		/obj/item/stock_parts/cell/gun/sharplite/plus,
		/obj/item/stock_parts/cell/gun/sharplite/empty,
		/obj/item/stock_parts/cell/gun/sharplite/plus/empty,
	)

	weapon_weight = WEAPON_MEDIUM
	w_class = WEIGHT_CLASS_BULKY

	gun_firemodes = list(FIREMODE_SEMIAUTO, FIREMODE_FULLAUTO)
	default_firemode = FIREMODE_SEMIAUTO

	shaded_charge = TRUE
	modifystate = FALSE

	fire_delay = 0.2 SECONDS

	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_SUITSTORE

	wield_delay = 0.7 SECONDS
	wield_slowdown = HEAVY_LASER_RIFLE_SLOWDOWN
	spread_unwielded = 20

/obj/item/gun/energy/sharplite/al655/inteq
	name = "PP20 “Barghest” APR"
	desc = "A Sharplite Assault Plasma Rifle refinished in Inteq Risk Management Group colors. A powerful weapon that can deliver rapid-fire, armor-penetrating electroplasma bolts."
	icon = 'icons/obj/guns/manufacturer/inteq/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/inteq/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/inteq/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/inteq/onmob.dmi'

	icon_state = "al655_inteq"
	item_state = "al655_inteq"


/obj/item/gun/energy/sharplite/al607
	name = "SL AL607 “Sarissa” Plasma Accelerator"
	desc = "A heavy electroplasma rifle with an extensive accelerator assembly, with an overall length almost comparable to the average Kepori height. Produces singular electroplasma bolts of impressive power and velocity that strike with enough force and precision to overwhelm most infantry defenses."
	icon_state = "al607"
	item_state = "al607"

	ammo_type = list(/obj/item/ammo_casing/energy/lasergun/sharplite/sniper)
	default_ammo_type = /obj/item/stock_parts/cell/gun/sharplite/plus

	allowed_ammo_types = list(
		/obj/item/stock_parts/cell/gun/sharplite,
		/obj/item/stock_parts/cell/gun/sharplite/plus,
		/obj/item/stock_parts/cell/gun/sharplite/empty,
		/obj/item/stock_parts/cell/gun/sharplite/plus/empty,
	)

	weapon_weight = WEAPON_MEDIUM
	w_class = WEIGHT_CLASS_BULKY

	gun_firemodes = list(FIREMODE_SEMIAUTO)
	default_firemode = FIREMODE_SEMIAUTO

	shaded_charge = TRUE
	modifystate = FALSE

	spread = -4
	spread_unwielded = 40

	wield_slowdown = SNIPER_SLOWDOWN
	wield_delay = 1.3 SECONDS

	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_SUITSTORE

	zoom_amt = 10 //Long range, enough to see in front of you, but no tiles behind you.
	zoom_out_amt = 5


/obj/item/gun/energy/sharplite/x11
	name = "X11 Advanced Stopping Pistol" //wayland is better
	desc = "An advanced energy revolver with the capacity to shoot both disabler and lethal lasers, as well as futuristic safari nets."
	icon_state = "x11"
	item_state = "nt_generic"
	force = 7
	default_ammo_type = /obj/item/stock_parts/cell/gun/sharplite/mini
	allowed_ammo_types = list(
		/obj/item/stock_parts/cell/gun/sharplite/mini,
	)
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
