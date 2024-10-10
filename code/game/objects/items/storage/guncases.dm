/obj/item/storage/guncase
	name = "gun case"
	desc = "A large box designed for holding firearms and magazines safely."
	icon = 'icons/obj/guncase.dmi'
	icon_state = "guncase"
	item_state = "infiltrator_case"
	force = 12
	throwforce = 12
	throw_speed = 2
	throw_range = 7
	w_class = WEIGHT_CLASS_BULKY
	attack_verb = list("robusted")
	hitsound = 'sound/weapons/smash.ogg'
	drop_sound = 'sound/items/handling/toolbox_drop.ogg'
	pickup_sound = 'sound/items/handling/toolbox_pickup.ogg'
	var/max_items = 10
	var/max_w_class = WEIGHT_CLASS_BULKY
	var/gun_type
	var/mag_type
	var/mag_count = 2
	var/ammoless = TRUE
	var/grab_loc = FALSE

/obj/item/storage/guncase/Initialize(mapload)
	. = ..()
	if(mapload && grab_loc)
		var/items_eaten = 0
		for(var/obj/item/I in loc)
			if(I.w_class <= max_w_class)
				I.forceMove(src)
				items_eaten++
			if(items_eaten >= mag_count + 1)
				break

/obj/item/storage/guncase/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = max_items
	STR.max_w_class = max_w_class
	STR.set_holdable(list(
		/obj/item/gun,
		/obj/item/ammo_box,
		/obj/item/stock_parts/cell/gun
		))

/obj/item/storage/guncase/PopulateContents()
	if(grab_loc)
		return
	if(gun_type)
		new gun_type(src, ammoless)
	if(mag_type)
		for(var/i in 1 to mag_count)
			if(ispath(mag_type, /obj/item/ammo_box) | ispath(mag_type, /obj/item/stock_parts/cell))
				new mag_type(src, ammoless)

/// Need to double check this in a seperate pr that adds this to a few ships
/// Eats the items on its tile
/obj/item/storage/guncase/mapper
	grab_loc = TRUE

/obj/item/storage/guncase/winchester
	gun_type = /obj/item/gun/ballistic/shotgun/flamingarrow

/obj/item/storage/guncase/conflagration
	gun_type = /obj/item/gun/ballistic/shotgun/flamingarrow/conflagration

/obj/item/storage/guncase/absolution
	gun_type = /obj/item/gun/ballistic/shotgun/flamingarrow/absolution

/obj/item/storage/guncase/skm
	gun_type = /obj/item/gun/ballistic/automatic/assault/skm
	mag_type = /obj/item/ammo_box/magazine/skm_762_40

/obj/item/storage/guncase/p16
	gun_type = /obj/item/gun/ballistic/automatic/assault/p16
	mag_type = /obj/item/ammo_box/magazine/p16

/obj/item/storage/guncase/beacon
	gun_type = /obj/item/gun/ballistic/shotgun/doublebarrel/beacon

/obj/item/storage/guncase/scout
	gun_type = /obj/item/gun/ballistic/rifle/scout
	mag_type = /obj/item/ammo_box/a300

/obj/item/storage/guncase/boomslang
	gun_type = /obj/item/gun/ballistic/automatic/marksman/boomslang/indie
	mag_type = /obj/item/ammo_box/magazine/boomslang/short

/obj/item/storage/guncase/cobra
	gun_type = /obj/item/gun/ballistic/automatic/smg/cobra/indie
	mag_type = /obj/item/ammo_box/magazine/m45_cobra

/obj/item/storage/guncase/hellfire
	gun_type = /obj/item/gun/ballistic/shotgun/hellfire

/obj/item/storage/guncase/doublebarrel
	gun_type = /obj/item/gun/ballistic/shotgun/doublebarrel

/obj/item/storage/guncase/brimstone
	gun_type = /obj/item/gun/ballistic/shotgun/brimstone

/obj/item/storage/guncase/illestren
	gun_type = /obj/item/gun/ballistic/rifle/illestren
	mag_type = /obj/item/ammo_box/magazine/illestren_a850r

/obj/item/storage/guncase/wt550
	gun_type = /obj/item/gun/ballistic/automatic/smg/wt550
	mag_type = /obj/item/ammo_box/magazine/wt550m9

/obj/item/storage/guncase/pistol
	name = "pistol case"
	desc = "A large box designed for holding pistols and magazines safely."
	max_items = 8
	max_w_class = WEIGHT_CLASS_NORMAL

/// Need to double check this in a seperate pr that adds this to a few ships
/// Eats the items on its tile
/obj/item/storage/guncase/pistol/mapper
	grab_loc = TRUE

/obj/item/storage/guncase/pistol/modelh
	gun_type = /obj/item/gun/ballistic/automatic/powered/gauss/modelh
	mag_type = /obj/item/ammo_box/magazine/modelh

/obj/item/storage/guncase/pistol/ringneck
	gun_type = /obj/item/gun/ballistic/automatic/pistol/ringneck/indie
	mag_type = /obj/item/ammo_box/magazine/m10mm_ringneck

/obj/item/storage/guncase/pistol/candor
	gun_type = /obj/item/gun/ballistic/automatic/pistol/candor
	mag_type = /obj/item/ammo_box/magazine/m45

/obj/item/storage/guncase/pistol/detective
	gun_type = /obj/item/gun/ballistic/revolver/detective
	mag_type = /obj/item/ammo_box/c38

/obj/item/storage/guncase/pistol/shadow
	gun_type = /obj/item/gun/ballistic/revolver/shadow

/obj/item/storage/guncase/pistol/viper
	gun_type = /obj/item/gun/ballistic/revolver/viper/indie

/obj/item/storage/guncase/pistol/commander
	gun_type = /obj/item/gun/ballistic/automatic/pistol/commander
	mag_type = /obj/item/ammo_box/magazine/co9mm

/obj/item/storage/guncase/pistol/firebrand
	gun_type = /obj/item/gun/ballistic/revolver/firebrand

/obj/item/storage/guncase/pistol/derringer
	gun_type = /obj/item/gun/ballistic/derringer

/obj/item/storage/guncase/pistol/a357
	gun_type = /obj/item/gun/ballistic/revolver/viper
	mag_type = /obj/item/ammo_box/a357/empty

/obj/item/storage/guncase/pistol/montagne
	gun_type = /obj/item/gun/ballistic/revolver/montagne
	mag_type = /obj/item/ammo_box/a44roum_speedloader

/obj/item/storage/guncase/pistol/disposable
/obj/item/storage/guncase/pistol/disposable/PopulateContents()
	new /obj/item/gun/ballistic/automatic/pistol/disposable(src)
	new /obj/item/gun/ballistic/automatic/pistol/disposable(src)

/obj/item/storage/guncase/pistol/kalixpistol
	gun_type = /obj/item/gun/energy/kalix/pistol
	mag_type = /obj/item/stock_parts/cell/gun/kalix

/obj/item/storage/guncase/pistol/miniegun
	gun_type = /obj/item/gun/energy/e_gun/mini
	mag_type = /obj/item/stock_parts/cell/gun/mini

/obj/item/storage/guncase/energy
	mag_type = /obj/item/stock_parts/cell/gun

/obj/item/storage/guncase/energy/laser
	gun_type = /obj/item/gun/energy/laser

/obj/item/storage/guncase/energy/egun
	gun_type = /obj/item/gun/energy/e_gun

/obj/item/storage/guncase/energy/kalixrifle
	gun_type = /obj/item/gun/energy/kalix
	mag_type = /obj/item/stock_parts/cell/gun/kalix

/obj/item/storage/guncase/energy/iongun
	gun_type = /obj/item/gun/energy/ionrifle
