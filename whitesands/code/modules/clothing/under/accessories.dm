/obj/item/clothing/accessory/holster
	name = "shoulder holster"
	desc = "A holster to carry a handgun and ammo. WARNING: Badasses only."
	icon_state = "holster"
	item_state = "holster"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/holster

/obj/item/clothing/accessory/holster/detective
	name = "detective's shoulder holster"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/holster/detective

/obj/item/clothing/accessory/holster/detective/Initialize()
	. = ..()
	new /obj/item/gun/ballistic/revolver/detective(src)
	new /obj/item/ammo_box/c38(src)
	new /obj/item/ammo_box/c38(src)

/obj/item/clothing/accessory/holster/nukie
	name = "operative holster"
	desc = "A deep shoulder holster capable of holding almost any form of ballistic weaponry."
	icon_state = "syndicate_holster"
	item_state = "syndicate_holster"
	w_class = WEIGHT_CLASS_BULKY
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/holster/nukie

/obj/item/clothing/accessory/holster/chameleon
	name = "syndicate holster"
	desc = "A two pouched hip holster that uses chameleon technology to disguise itself and any guns in it."
	icon_state = "syndicate_holster"
	item_state = "syndicate_holster"
	var/datum/action/item_action/chameleon/change/chameleon_action
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/holster/chameleon

/obj/item/clothing/accessory/holster/chameleon/Initialize()
	. = ..()

	chameleon_action = new(src)
	chameleon_action.chameleon_type = /obj/item/clothing/accessory
	chameleon_action.chameleon_name = "Accessory"
	chameleon_action.initialize_disguises()

/obj/item/clothing/accessory/holster/chameleon/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	chameleon_action.emp_randomise()

/obj/item/clothing/accessory/holster/chameleon/broken/Initialize()
	. = ..()
	chameleon_action.emp_randomise(INFINITY)

/obj/item/clothing/accessory/waistcoat/solgov
	name = "solgov waistcoat"
	desc = "A standard issue waistcoat in solgov colors."
	icon_state = "solgov_waistcoat"
	icon = 'whitesands/icons/obj/clothing/accessories.dmi'
