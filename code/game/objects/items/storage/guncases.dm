/obj/item/storage/guncase
	name = "gun case"
	desc = "A large box designed for holding firearms and magazines safely."
	icon = 'icons/obj/guncase.dmi'
	icon_state = "guncase"
	lefthand_file = 'icons/mob/inhands/equipment/toolbox_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/toolbox_righthand.dmi'
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
	custom_materials = list(/datum/material/iron = 500)
	var/max_items = 10
	var/max_w_class = WEIGHT_CLASS_BULKY
	var/gun_type
	var/mag_type
	var/mag_count = 2
	var/ammoless = TRUE
	var/grab_loc = FALSE
	var/holdable_items = list(
		/obj/item/gun,
		/obj/item/ammo_box,
		/obj/item/stock_parts/cell/gun
	)

/obj/item/storage/guncase/Initialize(mapload)
	. = ..()
	if(mapload && grab_loc)
		var/items_eaten = 0
		for(var/obj/item/I in loc)
			if(I.w_class > max_w_class)
				continue
			if(is_type_in_list(I, holdable_items))
				I.forceMove(src)
				items_eaten++
			if(items_eaten >= mag_count + 1)
				break

/obj/item/storage/guncase/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = max_items
	STR.max_w_class = max_w_class
	STR.set_holdable(holdable_items)

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
/obj/item/storage/guncase/inherit
	grab_loc = TRUE

/obj/item/storage/guncase/pistol
	name = "pistol case"
	desc = "A large box designed for holding pistols and magazines safely."
	max_items = 8
	max_w_class = WEIGHT_CLASS_NORMAL

/// Need to double check this in a seperate pr that adds this to a few ships
/// Eats the items on its tile
/obj/item/storage/guncase/pistol/inherit
	grab_loc = TRUE
