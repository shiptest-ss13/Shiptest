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
