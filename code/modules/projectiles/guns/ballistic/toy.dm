/obj/item/gun/ballistic/automatic/toy
	name = "foam force SMG"
	desc = "A prototype three-round burst toy submachine gun. Ages 8 and up."
	icon_state = "saber"
	item_state = "gun"
	mag_type = /obj/item/ammo_box/magazine/toy/smg
	fire_sound = 'sound/items/syringeproj.ogg'
	force = 0
	throwforce = 0
	burst_size = 3
	item_flags = NONE
	casing_ejector = FALSE
	manufacturer = MANUFACTURER_NANOTRASEN
	recoil = -10 //its a toy...
	recoil_unwielded = -10

/obj/item/gun/ballistic/automatic/toy/update_overlays()
	. = ..()
	. += "[icon_state]_toy"

/obj/item/gun/ballistic/automatic/toy/pistol
	name = "foam force pistol"
	desc = "A small, easily concealable toy handgun. Ages 8 and up."
	icon = 'icons/obj/guns/manufacturer/scarborough/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/scarborough/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/scarborough/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/scarborough/onmob.dmi'
	icon_state = "pistol" // WS edit - Fix various startup runtimes
	bolt_type = BOLT_TYPE_LOCKING
	w_class = WEIGHT_CLASS_SMALL
	mag_type = /obj/item/ammo_box/magazine/toy/pistol
	fire_sound = 'sound/items/syringeproj.ogg'
	burst_size = 1
	fire_delay = 0.2 SECONDS
	actions_types = list()
	recoil = -10 //its a toy...
	recoil_unwielded = -10

/obj/item/gun/ballistic/automatic/toy/pistol/riot
	mag_type = /obj/item/ammo_box/magazine/toy/pistol/riot

/obj/item/gun/ballistic/automatic/toy/pistol/riot/Initialize()
	magazine = new /obj/item/ammo_box/magazine/toy/pistol/riot(src)
	return ..()

/obj/item/gun/ballistic/shotgun/toy
	name = "foam force shotgun"
	desc = "A toy shotgun with wood furniture and a four-shell capacity underneath. Ages 8 and up."
	icon_state = "shotgun"
	force = 0
	throwforce = 0
	mag_type = /obj/item/ammo_box/magazine/internal/shot/toy
	fire_sound = 'sound/items/syringeproj.ogg'
	item_flags = NONE
	casing_ejector = FALSE
	pb_knockback = 0
	recoil = -10 //its a toy...
	recoil_unwielded = -10

/obj/item/gun/ballistic/shotgun/toy/update_overlays()
	. = ..()
	. += "[icon_state]_toy"

/obj/item/gun/ballistic/shotgun/toy/process_chamber(empty_chamber = 0, from_firing = TRUE, chamber_next_round = TRUE, atom/shooter)
	. = ..()
	if(chambered && !chambered.BB)
		qdel(chambered)

/obj/item/gun/ballistic/shotgun/toy/crossbow
	name = "foam force crossbow"
	desc = "A weapon favored by many overactive children. Ages 8 and up."
	icon = 'icons/obj/toy.dmi'
	icon_state = "foamcrossbow"
	item_state = "crossbow"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/toy/crossbow
	fire_sound = 'sound/items/syringeproj.ogg'
	slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_SMALL
	manufacturer = MANUFACTURER_DONKCO
	recoil = -10 //its a toy...
	recoil_unwielded = -10

/obj/item/gun/ballistic/automatic/smg/c20r/toy
	name = "donksoft SMG"
	desc = "A bullpup two-round burst toy SMG, designated 'C-20r'. Ages 8 and up."
	item_flags = NONE
	mag_type = /obj/item/ammo_box/magazine/toy/smgm45
	fire_sound = 'sound/items/syringeproj.ogg'
	casing_ejector = FALSE
	manufacturer = MANUFACTURER_DONKCO
	recoil = -10 //its a toy...
	recoil_unwielded = -10

/obj/item/gun/ballistic/automatic/smg/c20r/toy/riot
	mag_type = /obj/item/ammo_box/magazine/toy/smgm45/riot

/obj/item/gun/ballistic/automatic/smg/c20r/toy/update_overlays()
	. = ..()
	. += "[icon_state]_toy"

/obj/item/gun/ballistic/automatic/hmg/l6_saw/toy
	name = "donksoft LMG"
	desc = "A heavily modified toy light machine gun, designated 'L6 SAW'. Ages 8 and up."
	fire_sound = 'sound/items/syringeproj.ogg'
	item_flags = NONE
	mag_type = /obj/item/ammo_box/magazine/toy/m762
	casing_ejector = FALSE
	manufacturer = MANUFACTURER_DONKCO
	recoil = -10 //its a toy...
	recoil_unwielded = -10

/obj/item/gun/ballistic/automatic/hmg/l6_saw/toy/riot
	mag_type = /obj/item/ammo_box/magazine/toy/m762/riot

/obj/item/gun/ballistic/automatic/hmg/l6_saw/toy/update_overlays()
	. = ..()
	. += "[icon_state]_toy"
