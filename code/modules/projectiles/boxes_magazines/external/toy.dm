/obj/item/ammo_box/magazine/toy
	name = "foam force META magazine"
	ammo_type = /obj/item/ammo_casing/caseless/foam_dart
	caliber = "foam_force"

/obj/item/ammo_box/magazine/toy/smg
	name = "foam force SMG magazine"
	desc = "A toy submachine gun magazine designed to fit harmless foam darts."
	icon_state = "smg9mm-42"
	base_icon_state = "smg9mm"
	ammo_type = /obj/item/ammo_casing/caseless/foam_dart
	max_ammo = 20

/obj/item/ammo_box/magazine/toy/smg/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[ammo_count() ? 42 : 0]"

/obj/item/ammo_box/magazine/toy/smg/riot
	ammo_type = /obj/item/ammo_casing/caseless/foam_dart/riot

/obj/item/ammo_box/magazine/toy/pistol
	name = "foam force pistol magazine"
	desc = "A toy pistol magazine designed to fit harmless foam darts."
	icon_state = "9x19p"
	max_ammo = 8
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/toy/pistol/riot
	ammo_type = /obj/item/ammo_casing/caseless/foam_dart/riot

/obj/item/ammo_box/magazine/toy/smgm45
	name = "donksoft SMG magazine"
	desc = "A toy submachine gun magazine designed to fit harmless foam darts."
	icon_state = "c20r45-toy"
	base_icon_state = "c20r45"
	caliber = "foam_force"
	ammo_type = /obj/item/ammo_casing/caseless/foam_dart
	max_ammo = 20

/obj/item/ammo_box/magazine/toy/smgm45/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[round(ammo_count(), 2)]"

/obj/item/ammo_box/magazine/toy/smgm45/riot
	icon_state = "c20r45-riot"
	desc = "A toy submachine gun magazine designed to fit legally-harmless riot control darts."
	ammo_type = /obj/item/ammo_casing/caseless/foam_dart/riot

/obj/item/ammo_box/magazine/toy/m762
	name = "donksoft box magazine"
	desc = "A huge toy LMG magazine designed to fit vast quantities of harmless foam darts."
	icon_state = "a762-toy"
	base_icon_state = "a762"
	caliber = "foam_force"
	ammo_type = /obj/item/ammo_casing/caseless/foam_dart
	max_ammo = 50
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/ammo_box/magazine/toy/m762/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[round(ammo_count(), 10)]"

/obj/item/ammo_box/magazine/toy/m762/riot
	desc = "A huge toy LMG magazine designed to fit vast quantities of legally-harmless riot control darts."
	icon_state = "a762-riot"
	ammo_type = /obj/item/ammo_casing/caseless/foam_dart/riot
