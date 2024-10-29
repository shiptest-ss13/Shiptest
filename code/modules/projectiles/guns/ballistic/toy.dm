/obj/item/gun/ballistic/automatic/toy
	name = "foam force SMG"
	desc = "A prototype three-round burst toy submachine gun. Ages 8 and up."

	icon = 'icons/obj/guns/manufacturer/toys/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/toys/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/toys/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/toys/onmob.dmi'

	icon_state = "toysmg"
	item_state = "toysmg"
	default_ammo_type = /obj/item/ammo_box/magazine/toy/smg
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/toy/smg,
	)
	fire_sound = 'sound/items/syringeproj.ogg'
	force = 0
	throwforce = 0
	burst_size = 3
	item_flags = NONE
	casing_ejector = FALSE
	manufacturer = MANUFACTURER_NANOTRASEN
	recoil = -10 //its a toy...
	recoil_unwielded = -10


/obj/item/gun/ballistic/automatic/toy/pistol
	name = "foam force pistol"
	desc = "A small, easily concealable toy handgun. Ages 8 and up."

	icon_state = "toypistol"
	item_state = "toypistol"
	bolt_type = BOLT_TYPE_LOCKING
	w_class = WEIGHT_CLASS_SMALL
	default_ammo_type = /obj/item/ammo_box/magazine/toy/pistol
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/toy/pistol,
	)
	fire_sound = 'sound/items/syringeproj.ogg'
	burst_size = 1
	fire_delay = 0.2 SECONDS
	actions_types = list()
	recoil = -10 //its a toy...
	recoil_unwielded = -10

/obj/item/gun/ballistic/automatic/toy/pistol/riot
	default_ammo_type = /obj/item/ammo_box/magazine/toy/pistol/riot
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/toy/pistol/riot,
	)

/obj/item/gun/ballistic/automatic/toy/pistol/riot/Initialize()
	magazine = new /obj/item/ammo_box/magazine/toy/pistol/riot(src)
	return ..()

/obj/item/gun/ballistic/shotgun/toy
	name = "foam force shotgun"
	desc = "A toy shotgun with wood furniture and a four-shell capacity underneath. Ages 8 and up."

	icon = 'icons/obj/guns/manufacturer/toys/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/toys/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/toys/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/toys/onmob.dmi'

	icon_state = "toyshotgun"
	item_state = "toyshotgun"

	force = 0
	throwforce = 0
	default_ammo_type = /obj/item/ammo_box/magazine/internal/shot/toy
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/internal/shot/toy,
	)
	fire_sound = 'sound/items/syringeproj.ogg'
	item_flags = NONE
	casing_ejector = FALSE
	pb_knockback = 0
	recoil = -10 //its a toy...
	recoil_unwielded = -10

/obj/item/gun/ballistic/shotgun/toy/process_chamber(empty_chamber = 0, from_firing = TRUE, chamber_next_round = TRUE, atom/shooter)
	. = ..()
	if(chambered && !chambered.BB)
		qdel(chambered)

/obj/item/gun/ballistic/shotgun/toy/crossbow
	name = "foam force crossbow"
	desc = "A weapon favored by many overactive children. Ages 8 and up."
	icon_state = "foamcrossbow"
	item_state = "crossbow"
	default_ammo_type = /obj/item/ammo_box/magazine/internal/shot/toy/crossbow
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/internal/shot/toy/crossbow,
	)
	fire_sound = 'sound/items/syringeproj.ogg'
	slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_SMALL
	manufacturer = MANUFACTURER_DONKCO
	recoil = -10 //its a toy...
	recoil_unwielded = -10
