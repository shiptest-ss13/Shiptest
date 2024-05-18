/obj/item/storage/guncase
	name = "gun case"
	desc = "A large box designed for holding firearms and magazines safely."
	icon = 'icons/obj/guncase_48x32.dmi'
	icon_state = "riflecase"
	item_state = "riflecase"
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

/obj/item/storage/pistolcase
	name = "pistol case"
	desc = "A large box designed for holding pistols and magazines safely."
	icon = 'icons/obj/guncase.dmi'
	icon_state = "pistolcase"
	item_state = "pistolcase"
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
	STR.max_w_class = WEIGHT_CLASS_BULKY
	STR.set_holdable(list(
		/obj/item/gun,
		/obj/item/ammo_box/,
		/obj/item/stock_parts/cell/gun
		))
/obj/item/storage/pistolcase/stechkin
/obj/item/storage/pistolcase/stechkin/PopulateContents()
	new /obj/item/gun/ballistic/automatic/pistol/no_mag(src)
	new /obj/item/ammo_box/magazine/m10mm/empty(src)
	new /obj/item/ammo_box/magazine/m10mm/empty(src)

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
	new /obj/item/ammo_box/c45_speedloader/empty(src)
	new /obj/item/ammo_box/c45_speedloader/empty(src)

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
	new /obj/item/gun/ballistic/derringer/no_mag(src)

/obj/item/storage/pistolcase/a357
/obj/item/storage/pistolcase/derringer/PopulateContents()
	new /obj/item/gun/ballistic/revolver/no_mag(src)
	new /obj/item/ammo_box/a357/empty(src)
	new /obj/item/ammo_box/a357/empty(src)

/obj/item/storage/pistolcase/montagne
/obj/item/storage/pistolcase/derringer/PopulateContents()
	new /obj/item/gun/ballistic/revolver/montagne/no_mag(src)
	new /obj/item/ammo_box/c45_speedloader/empty(src)
	new /obj/item/ammo_box/c45_speedloader/empty(src)


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
	new /obj/item/gun/energy/laser/empty_cell(src)
	new /obj/item/stock_parts/cell/gun(src)

/obj/item/storage/pistolcase/kalixpistol
/obj/item/storage/pistolcase/kalixpistol/PopulateContents()
	new /obj/item/gun/energy/kalix/pistol/empty_cell(src)
	new /obj/item/stock_parts/cell/gun/kalix(src)

/obj/item/storage/pistolcase/kalixrifle
/obj/item/storage/pistolcase/kalixrifle/PopulateContents()
	new /obj/item/gun/energy/kalix/empty_cell(src)
	new /obj/item/stock_parts/cell/gun/kalix(src)

/obj/item/storage/pistolcase/miniegun
/obj/item/storage/pistolcase/miniegun/PopulateContents()
	new /obj/item/gun/energy/e_gun/empty_cell(src)
	new /obj/item/stock_parts/cell/gun/mini(src)

/obj/item/storage/pistolcase/iongun
/obj/item/storage/pistolcase/iongun/PopulateContents()
	new /obj/item/gun/energy/ionrifle/empty_cell(src)
	new /obj/item/stock_parts/cell/gun(src)
