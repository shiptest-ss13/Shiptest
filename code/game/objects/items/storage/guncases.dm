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

/obj/item/storage/guncase/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 10
	STR.max_w_class = WEIGHT_CLASS_BULKY
	STR.set_holdable(list(
		/obj/item/gun,
		/obj/item/ammo_box,
		/obj/item/stock_parts/cell/gun
		))

/obj/item/storage/guncase/winchester
/obj/item/storage/guncase/winchester/PopulateContents()
	new /obj/item/gun/ballistic/shotgun/flamingarrow/no_mag(src)

/obj/item/storage/guncase/conflagration
/obj/item/storage/guncase/conflagration/PopulateContents()
	new /obj/item/gun/ballistic/shotgun/flamingarrow/conflagration/no_mag(src)

/obj/item/storage/guncase/absolution
/obj/item/storage/guncase/absolution/PopulateContents()
	new /obj/item/gun/ballistic/shotgun/flamingarrow/absolution/no_mag(src)

/obj/item/storage/guncase/skm
/obj/item/storage/guncase/skm/PopulateContents()
	new /obj/item/gun/ballistic/automatic/assault/skm/no_mag(src)
	new /obj/item/ammo_box/magazine/skm_762_40/empty(src)
	new /obj/item/ammo_box/magazine/skm_762_40/empty(src)

/obj/item/storage/guncase/p16
/obj/item/storage/guncase/p16/PopulateContents()
	new /obj/item/gun/ballistic/automatic/assault/p16/no_mag(src)
	new /obj/item/ammo_box/magazine/p16/empty(src)
	new /obj/item/ammo_box/magazine/p16/empty(src)

/obj/item/storage/guncase/beacon
/obj/item/storage/guncase/beacon/PopulateContents()
	new /obj/item/gun/ballistic/shotgun/doublebarrel/beacon/no_mag(src)

/obj/item/storage/guncase/scout
/obj/item/storage/guncase/scout/PopulateContents()
	new /obj/item/gun/ballistic/rifle/scout/no_mag(src)
	new /obj/item/ammo_box/a300/empty(src)
	new /obj/item/ammo_box/a300/empty(src)

/obj/item/storage/guncase/boomslang
/obj/item/storage/guncase/boomslang/PopulateContents()
	new /obj/item/gun/ballistic/automatic/marksman/boomslang/indie/no_mag(src)
	new /obj/item/ammo_box/magazine/boomslang/short/empty(src)
	new /obj/item/ammo_box/magazine/boomslang/short/empty(src)

/obj/item/storage/guncase/cobra
/obj/item/storage/guncase/cobra/PopulateContents()
	new /obj/item/gun/ballistic/automatic/smg/cobra/indie/no_mag(src)
	new /obj/item/ammo_box/magazine/m45_cobra/empty(src)
	new /obj/item/ammo_box/magazine/m45_cobra/empty(src)

/obj/item/storage/guncase/hellfire
/obj/item/storage/guncase/hellfire/PopulateContents()
	new /obj/item/gun/ballistic/shotgun/hellfire/no_mag(src)

/obj/item/storage/guncase/doublebarrel
/obj/item/storage/guncase/doublebarrel/PopulateContents()
	new /obj/item/gun/ballistic/shotgun/doublebarrel/no_mag(src)

/obj/item/storage/guncase/brimstone
/obj/item/storage/guncase/brimstone/PopulateContents()
	new /obj/item/gun/ballistic/shotgun/brimstone/no_mag(src)

/obj/item/storage/guncase/illestren
/obj/item/storage/guncase/illestren/PopulateContents()
	new /obj/item/gun/ballistic/rifle/illestren/empty(src)
	new /obj/item/ammo_box/magazine/illestren_a850r/empty(src)
	new /obj/item/ammo_box/magazine/illestren_a850r/empty(src)

/obj/item/storage/guncase/wt550
/obj/item/storage/guncase/wt550/PopulateContents()
	new /obj/item/gun/ballistic/automatic/smg/wt550/no_mag(src)
	new /obj/item/ammo_box/magazine/wt550m9/empty(src)
	new /obj/item/ammo_box/magazine/wt550m9/empty(src)

/obj/item/storage/pistolcase
	name = "pistol case"
	desc = "A large box designed for holding pistols and magazines safely."
	icon = 'icons/obj/guncase.dmi'
	icon_state = "guncase"
	item_state = "infiltrator_case"
	force = 12
	throwforce = 12
	throw_speed = 2
	w_class = WEIGHT_CLASS_BULKY
	attack_verb = list("robusted")
	hitsound = 'sound/weapons/smash.ogg'
	drop_sound = 'sound/items/handling/toolbox_drop.ogg'
	pickup_sound = 'sound/items/handling/toolbox_pickup.ogg'

/obj/item/storage/pistolcase/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 8
	STR.max_w_class = WEIGHT_CLASS_NORMAL
	STR.set_holdable(list(
		/obj/item/gun,
		/obj/item/ammo_box/,
		/obj/item/stock_parts/cell/gun
		))

/obj/item/storage/pistolcase/modelh
/obj/item/storage/pistolcase/modelh/PopulateContents()
	new /obj/item/gun/ballistic/automatic/powered/gauss/modelh/no_mag(src)
	new /obj/item/ammo_box/magazine/modelh/empty(src)
	new /obj/item/ammo_box/magazine/modelh/empty(src)

/obj/item/storage/pistolcase/ringneck
/obj/item/storage/pistolcase/ringneck/PopulateContents()
	new /obj/item/gun/ballistic/automatic/pistol/ringneck/indie/no_mag(src)
	new /obj/item/ammo_box/magazine/m10mm_ringneck/empty(src)
	new /obj/item/ammo_box/magazine/m10mm_ringneck/empty(src)

/obj/item/storage/pistolcase/candor
/obj/item/storage/pistolcase/candor/PopulateContents()
	new /obj/item/gun/ballistic/automatic/pistol/candor/no_mag(src)
	new /obj/item/ammo_box/magazine/m45/empty(src)
	new /obj/item/ammo_box/magazine/m45/empty(src)

/obj/item/storage/pistolcase/detective
/obj/item/storage/pistolcase/detective/PopulateContents()
	new /obj/item/gun/ballistic/revolver/detective/no_mag(src)
	new /obj/item/ammo_box/c38/empty(src)
	new /obj/item/ammo_box/c38/empty(src)

/obj/item/storage/pistolcase/shadow
/obj/item/storage/pistolcase/shadow/PopulateContents()
	new /obj/item/gun/ballistic/revolver/shadow/no_mag(src)

/obj/item/storage/pistolcase/viper
/obj/item/storage/pistolcase/viper/PopulateContents()
	new /obj/item/gun/ballistic/revolver/viper/indie/no_mag(src)

/obj/item/storage/pistolcase/commander
/obj/item/storage/pistolcase/commander/PopulateContents()
	new /obj/item/gun/ballistic/automatic/pistol/commander/no_mag(src)
	new /obj/item/ammo_box/magazine/co9mm/empty(src)
	new /obj/item/ammo_box/magazine/co9mm/empty(src)

/obj/item/storage/pistolcase/firebrand
/obj/item/storage/pistolcase/firebrand/PopulateContents()
	new /obj/item/gun/ballistic/revolver/firebrand/no_mag(src)

/obj/item/storage/pistolcase/derringer
/obj/item/storage/pistolcase/derringer/PopulateContents()
	new /obj/item/gun/ballistic/derringer/no_mag(src)

/obj/item/storage/pistolcase/a357
/obj/item/storage/pistolcase/a357/PopulateContents()
	new /obj/item/gun/ballistic/revolver/viper/no_mag(src)
	new /obj/item/ammo_box/a357/empty(src)
	new /obj/item/ammo_box/a357/empty(src)

/obj/item/storage/pistolcase/montagne
/obj/item/storage/pistolcase/montagne/PopulateContents()
	new /obj/item/gun/ballistic/revolver/montagne/no_mag(src)
	new /obj/item/ammo_box/a44roum_speedloader/empty(src)
	new /obj/item/ammo_box/a44roum_speedloader/empty(src)

/obj/item/storage/pistolcase/disposable
/obj/item/storage/pistolcase/disposable/PopulateContents()
	new /obj/item/gun/ballistic/automatic/pistol/disposable(src)
	new /obj/item/gun/ballistic/automatic/pistol/disposable(src)

/obj/item/storage/pistolcase/laser
/obj/item/storage/pistolcase/laser/PopulateContents()
	new /obj/item/gun/energy/laser/empty_cell(src)
	new /obj/item/stock_parts/cell/gun(src)

/obj/item/storage/pistolcase/egun
/obj/item/storage/pistolcase/egun/PopulateContents()
	new /obj/item/gun/energy/e_gun/empty_cell(src)
	new /obj/item/stock_parts/cell/gun(src)

/obj/item/storage/pistolcase/kalixpistol
/obj/item/storage/pistolcase/kalixpistol/PopulateContents()
	new /obj/item/gun/energy/kalix/pistol/empty_cell(src)
	new /obj/item/stock_parts/cell/gun/kalix(src)

/obj/item/storage/guncase/kalixrifle
/obj/item/storage/guncase/kalixrifle/PopulateContents()
	new /obj/item/gun/energy/kalix/empty_cell(src)
	new /obj/item/stock_parts/cell/gun/kalix(src)

/obj/item/storage/pistolcase/miniegun
/obj/item/storage/pistolcase/miniegun/PopulateContents()
	new /obj/item/gun/energy/e_gun/mini/empty_cell(src)
	new /obj/item/stock_parts/cell/gun/mini(src)

/obj/item/storage/pistolcase/iongun
/obj/item/storage/pistolcase/iongun/PopulateContents()
	new /obj/item/gun/energy/ionrifle/empty_cell(src)
	new /obj/item/stock_parts/cell/gun(src)
