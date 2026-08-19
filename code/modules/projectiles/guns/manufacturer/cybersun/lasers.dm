//THEY ARENT LASERS

/obj/item/gun/energy/cybersun
	name = "cybersun gun master type"
	desc = ""
	icon = 'icons/obj/guns/manufacturer/cybersun/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/cybersun/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/cybersun/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/cybersun/onmob.dmi'

	ammo_type = list()


	default_ammo_type = /obj/item/stock_parts/cell/gun/cybersun

	allowed_ammo_types = list(
		/obj/item/stock_parts/cell/gun/cybersun,
		/obj/item/stock_parts/cell/gun/cybersun/heavy,
		/obj/item/stock_parts/cell/gun/cybersun/mini,
		/obj/item/stock_parts/cell/gun/cybersun/empty,
		/obj/item/stock_parts/cell/gun/cybersun/heavy/empty,
		/obj/item/stock_parts/cell/gun/cybersun/mini/empty,
	)

	muzzleflash_iconstate = ""
	light_color = COLOR_PALE_BLUE_GRAY

	modifystate = FALSE
	ammo_x_offset = 2
	dual_wield_spread = 60
	wield_slowdown = LASER_RIFLE_SLOWDOWN
	manufacturer = MANUFACTURER_CYBERSUN
	w_class = WEIGHT_CLASS_NORMAL


//ionization pistol
/obj/item/gun/energy/cybersun/trouble
	name = "YT22 Troubleshooter"
	//rewrite
	desc = "A compact energy pistol functioning off ionization principles. A low-powered laser provides a path of least resistance for a plasma bolt to travel through. Typically issued to Virtual Solutions support staff."

	icon_state = "troubleshooter"
	item_state = "troubleshooter"

	w_class = WEIGHT_CLASS_SMALL
	weapon_weight = WEAPON_LIGHT

	default_ammo_type = /obj/item/stock_parts/cell/gun/cybersun/mini
	allowed_ammo_types = list(
		/obj/item/stock_parts/cell/gun/cybersun/mini,
	)
	ammo_type = list(/obj/item/ammo_casing/energy/ionization)

	shaded_charge = FALSE
	modifystate = FALSE

	wield_delay = 0.2 SECONDS
	wield_slowdown = LASER_PISTOL_SLOWDOWN

	spread = -2
	spread_unwielded = 2

	muzzleflash_iconstate = ""

/obj/item/gun/energy/cybersun/trouble/empty_cell
	spawn_no_ammo = TRUE

//flare pistol
/obj/item/gun/energy/cybersun/opportunist
	name = "VS-434 Opportunist"
	//rewrite
	desc = "A bulky brute of revolver intended to neutralize any threat in close range. Lorentz mode rapidly ionizes air and fills it with plasma to melt through targets, while plasma flare dumps the entire plasma cell into one ferocious shot."

	w_class = WEIGHT_CLASS_NORMAL
	icon_state = "opportunist"
	item_state = "opportunist"

	default_ammo_type = /obj/item/stock_parts/cell/gun/cybersun
	allowed_ammo_types = list(
		/obj/item/stock_parts/cell/gun/cybersun,
		/obj/item/stock_parts/cell/gun/cybersun/empty,
		/obj/item/stock_parts/cell/gun/cybersun/mini,
		/obj/item/stock_parts/cell/gun/cybersun/mini/empty,
	)

	ammo_type = list(/obj/item/ammo_casing/energy/lorentz, /obj/item/ammo_casing/energy/flare)

/obj/item/gun/energy/cybersun/opportunist/empty_cell
	spawn_no_ammo = TRUE

/obj/item/gun/energy/cybersun/impactor
	name = "\improper VS-126 Impactor"
	desc = ""

	icon_state = "impactor"
	item_state = "impactor"

	ammo_type = list(/obj/item/ammo_casing/energy/lorentz/scatter)

	default_ammo_type = /obj/item/stock_parts/cell/gun/cybersun

	allowed_ammo_types = list(
		/obj/item/stock_parts/cell/gun/cybersun
		/obj/item/stock_parts/cell/gun/cybersun/empty,
	)


	weapon_weight = WEAPON_LIGHT
	w_class = WEIGHT_CLASS_BULKY

	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_SUITSTORE

	fire_delay = 0.13 SECONDS
	wield_slowdown = LASER_RIFLE_SLOWDOWN

	default_firemode = FIREMODE_SEMIAUTO

	slot_available = list(
		ATTACHMENT_SLOT_RAIL = 1,
	)

	slot_offsets = list(
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 36,
			"y" = 16,
		),
	)

/obj/item/gun/energy/cybersun/impactor/empty_cell
	spawn_no_ammo = TRUE

/obj/item/gun/energy/cybersun/galvanizer
	name = "VS-304 Galvanizer"
	desc = ""

	icon_state = "galvanizer"
	item_state = "galvanizer"
	w_class = WEIGHT_CLASS_BULKY
	ammo_type = list(/obj/item/ammo_casing/energy/ionization/sniper)
	ammo_x_offset = 1
	shaded_charge = TRUE
	modifystate = FALSE

	zoomable = TRUE
	wield_slowdown = HEAVY_LASER_RIFLE_SLOWDOWN
	aimed_wield_slowdown = LONG_RIFLE_AIM_SLOWDOWN
	zoom_amt = DMR_ZOOM
	wield_delay = 1 SECONDS
	fire_delay = 0.4 SECONDS

	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_SUITSTORE

	spread = 0
	spread_unwielded = 12

	slot_available = list(
		ATTACHMENT_SLOT_RAIL = 1,
	)

	slot_offsets = list(
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 39,
			"y" = 13,
		),
	)

/obj/item/gun/energy/cybersun/catalyzer
	name = "Catalyzer"
	desc = ""
	icon_state = "catalyzer"
	item_state = "catalyzer"

	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_SUITSTORE

	ammo_type = list(/obj/item/ammo_casing/energy/laser/assault/sharplite)

	zoom_amt = RIFLE_ZOOM
	wield_slowdown = SMG_SLOWDOWN
	aimed_wield_slowdown = LONG_RIFLE_AIM_SLOWDOWN
	wield_delay = 0.4 SECONDS
	fire_delay = 0.5 SECONDS

	spread = 2
	spread_unwielded = 10

	slot_available = list(
		ATTACHMENT_SLOT_RAIL = 1,
	)

	slot_offsets = list(
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 34,
			"y" = 15,
		),
	)

/obj/item/gun/energy/sharplite/surge/resistor/empty_cell
	spawn_no_ammo = TRUE

/obj/item/gun/energy/sharplite/ohm/empty_cell
	spawn_no_ammo = TRUE

/obj/item/gun/energy/sharplite/volt
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

	slot_available = list(
		ATTACHMENT_SLOT_RAIL = 1,
	)

	slot_offsets = list(
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 33,
			"y" = 16,
		),
	)

/obj/item/gun/energy/sharplite/volt/empty_cell
	spawn_no_ammo = TRUE

/obj/item/gun/energy/sharplite/amperage
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
	fire_delay = 0.4 SECONDS
	shaded_charge = TRUE

	wield_slowdown = SHOTGUN_SLOWDOWN
	aimed_wield_slowdown = SHOTGUN_AIM_SLOWDOWN
	wield_delay = 0.8 SECONDS

	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_SUITSTORE

	zoom_amt = SHOTGUN_ZOOM

	slot_available = list(
		ATTACHMENT_SLOT_RAIL = 1,
	)

	slot_offsets = list(
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 37,
			"y" = 10,
		),
	)

/obj/item/gun/energy/sharplite/amperage/empty_cell
	spawn_no_ammo = TRUE

/obj/item/gun/energy/sharplite/amperage/zeta
	name = "\improper SL X-45"
	desc = "A very old looking X-46, it has no stock or much decoration, and it is from before... Hey! What's this screen next to the mode select button?"

	icon_state = "x46_zeta"
	item_state = "x46_zeta"
	shaded_charge = TRUE
	manufacturer = MANUFACTURER_SHARPLITE

	w_class = WEIGHT_CLASS_BULKY
	var/obj/item/modular_computer/integratedNTOS
	var/NTOS_type = /obj/item/modular_computer/internal

/obj/item/gun/energy/sharplite/amperage/zeta/Initialize()
	. = ..()
	if(NTOS_type)
		integratedNTOS = new NTOS_type(src)
		integratedNTOS.physical = src

/obj/item/gun/energy/sharplite/amperage/zeta/attack_self(mob/user)
	. = ..()
	if(!integratedNTOS)
		return
	integratedNTOS.interact(user)

	slot_available = list(
		ATTACHMENT_SLOT_RAIL = 1,
	)

	slot_offsets = list(
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 24,
			"y" = 12,
		),
	)

/obj/item/gun/energy/sharplite/hades
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

	slot_available = list(
		ATTACHMENT_SLOT_RAIL = 1,
	)

	slot_offsets = list(
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 36,
			"y" = 11,
		),
	)

/obj/item/gun/energy/sharplite/hades/inteq
	name = "PP20 “Barghest” APR"
	desc = "A Sharplite Assault Plasma Rifle refinished in Inteq Risk Management Group colors. A powerful weapon that can deliver rapid-fire, armor-penetrating electroplasma bolts."
	icon = 'icons/obj/guns/manufacturer/inteq/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/inteq/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/inteq/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/inteq/onmob.dmi'

	icon_state = "al655_inteq"
	item_state = "al655_inteq"


/obj/item/gun/energy/sharplite/sarissa
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
	fire_delay = 1 SECONDS

	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_SUITSTORE

	zoom_amt = 10 //Long range, enough to see in front of you, but no tiles behind you.
	zoom_out_amt = 5

	slot_available = list(
		ATTACHMENT_SLOT_RAIL = 1,
	)

	slot_offsets = list(
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 35,
			"y" = 15,
		),
	)

/obj/item/gun/energy/sharplite/revolver
	name = "X11 Advanced Stopping Pistol" //wayland is better
	desc = "An advanced energy revolver with the capacity to shoot both disabler and lethal lasers, as well as futuristic safari nets."
	icon_state = "x11"
	item_state = "warra_generic"
	force = 7
	default_ammo_type = /obj/item/stock_parts/cell/gun/sharplite/mini
	allowed_ammo_types = list(
		/obj/item/stock_parts/cell/gun/sharplite/mini,
	)
	ammo_type = list(/obj/item/ammo_casing/energy/disabler/sharplite/hos, /obj/item/ammo_casing/energy/laser/sharplite/hos, /obj/item/ammo_casing/energy/trap)
	ammo_x_offset = 1
	shaded_charge = TRUE
	slot_available = list(
		ATTACHMENT_SLOT_RAIL = 1,
	)

	slot_offsets = list(
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 26,
			"y" = 15,
		),
	)

/obj/item/gun/energy/laser/retro
	name ="SL L104"
	desc = "An antiquated model of the L204, no longer used or sold by Sharplite. Nevertheless, the sheer popularity of this model makes it a somewhat common sight to this day."

	icon = 'icons/obj/guns/manufacturer/warra_sharplite/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/warra_sharplite/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/warra_sharplite/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/warra_sharplite/onmob.dmi'

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
	icon = 'icons/obj/guns/manufacturer/warra_sharplite/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/warra_sharplite/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/warra_sharplite/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/warra_sharplite/onmob.dmi'
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
