
/datum/component/storage/concrete/pockets/holster
	max_items = 3
	max_w_class = WEIGHT_CLASS_NORMAL
	var/atom/original_parent

/datum/component/storage/concrete/pockets/holster/Initialize()
	original_parent = parent
	. = ..()
	can_hold = typecacheof(list(
		/obj/item/gun/ballistic/automatic/pistol,
		/obj/item/gun/ballistic/revolver,
		/obj/item/ammo_box))

/datum/component/storage/concrete/pockets/holster/real_location()
	// if the component is reparented to a jumpsuit, the items still go in the protector
	return original_parent

/datum/component/storage/concrete/pockets/holster/detective/Initialize()
	original_parent = parent
	. = ..()
	can_hold = typecacheof(list(
		/obj/item/gun/ballistic/revolver/detective,
		/obj/item/ammo_box/c38))

/datum/component/storage/concrete/pockets/holster/nukie
	max_items = 2
	max_w_class = WEIGHT_CLASS_BULKY

/datum/component/storage/concrete/pockets/holster/lt/Initialize()
	original_parent = parent
	. = ..()
	can_hold = typecacheof(list(
		/obj/item/gun/energy/e_gun/adv_stopping,
		/obj/item/gun/energy/e_gun/mini,
		/obj/item/gun/energy/disabler,
		/obj/item/stock_parts/cell/gun
	))

/datum/component/storage/concrete/pockets/holster/nukie/Initialize()
	original_parent = parent
	. = ..()
	can_hold = typecacheof(list(
		/obj/item/gun/ballistic/automatic,
		/obj/item/gun/ballistic/revolver,
		/obj/item/gun/energy/e_gun/mini,
		/obj/item/gun/energy/disabler,
		/obj/item/gun/energy/pulse/carbine,
		/obj/item/gun/energy/dueling,
		/obj/item/gun/ballistic/shotgun,
		/obj/item/gun/ballistic/rocketlauncher))

/datum/component/storage/concrete/pockets/holster/chameleon
	max_items = 1

/datum/component/storage/concrete/pockets/holster/chameleon/Initialize()
	original_parent = parent
	. = ..()
	can_hold = typecacheof(list(
		/obj/item/gun/ballistic/automatic/pistol,
		/obj/item/gun/ballistic/revolver,
		/obj/item/gun/energy/e_gun/mini,
		/obj/item/gun/energy/disabler,
		/obj/item/gun/energy/pulse/carbine,
		/obj/item/gun/energy/dueling))
