/obj/item/ammo_box/magazine/m10mm
	name = "pistol magazine (10mm)"
	desc = "An 8-round single-stack magazine for the stechkin pistol. These rounds do moderate damage, but struggle against armor."
	icon_state = "9x19p"
	ammo_type = /obj/item/ammo_casing/c10mm
	caliber = "10mm"
	max_ammo = 8
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/m10mm/inc
	name = "pistol magazine (10mm incendiary)"
	desc = "An 8-round single-stack magazine for the stechkin pistol. These incendiary rounds deal mediocre damage, but leave flaming trails which set targets ablaze."
	icon_state = "9x19pI"
	ammo_type = /obj/item/ammo_casing/c10mm/inc

/obj/item/ammo_box/magazine/m10mm/hp
	name = "pistol magazine (10mm HP)"
	desc = "An 8-round single-stack magazine for the stechkin pistol. These hollow point rounds do incredible damage against soft targets, but are nearly ineffective against armored ones."
	icon_state = "9x19pH"
	ammo_type = /obj/item/ammo_casing/c10mm/hp

/obj/item/ammo_box/magazine/m10mm/ap
	name = "pistol magazine (10mm AP)"
	desc = "An 8-round single-stack magazine for the stechkin pistol. These armor-piercing rounds are okay at piercing protective equipment, but lose some stopping power."
	icon_state = "9x19pA"
	ammo_type = /obj/item/ammo_casing/c10mm/ap

/obj/item/ammo_box/magazine/m10mm/rubber
	name = "pistol magazine (10mm rubber)"
	desc = "An 8-round handgun magazine for the stechkin pistol. These rubber rounds trade lethality for a heavy impact which can incapacitate targets. Performs even worse against armor."
	icon_state = "9x19pR"
	ammo_type = /obj/item/ammo_casing/c10mm/rubber

/obj/item/ammo_box/magazine/m45
	name = "pistol magazine (.45)"
	desc = "An 8-round single-stack magazine for the M1911 pistol. These rounds do moderate damage, but struggle against armor."
	icon_state = "45-8"
	base_icon_state = "45"
	ammo_type = /obj/item/ammo_casing/c45
	caliber = ".45"
	max_ammo = 8

/obj/item/ammo_box/magazine/m45/inc
	name = "pistol magazine (.45 incendiary)"
	desc = "An 8-round single-stack magazine for the M1911 pistol. These incendiary rounds deal mediocre damage, but leave flaming trails which set targets ablaze."
	ammo_type = /obj/item/ammo_casing/c45/inc

/obj/item/ammo_box/magazine/m45/hp
	name = "pistol magazine (.45 HP)"
	desc= "An 8-round single-stack magazine for the M1911 pistol. These hollow point rounds do incredible damage against soft targets, but are nearly ineffective against armored ones."
	ammo_type = /obj/item/ammo_casing/c45/hp

/obj/item/ammo_box/magazine/m45/ap
	name = "pistol magazine (.45 AP)"
	desc= "An 8-round single-stack magazine for the M1911 pistol. These armor-piercing rounds are okay at piercing protective equipment, but lose some stopping power."
	ammo_type = /obj/item/ammo_casing/c45/ap

/obj/item/ammo_box/magazine/m45/rubber
	name = "pistol magazine (.45 rubber)"
	desc = "An 8-round single-stack magazine for the M1911 pistol. These rubber rounds trade lethality for a heavy impact which can incapacitate targets. Performs even worse against armor."
	ammo_type = /obj/item/ammo_casing/c45/rubber

/obj/item/ammo_box/magazine/m45/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[min(ammo_count(), 8)]"

/obj/item/ammo_box/magazine/co9mm
	name = "pistol magazine (9mm)"
	desc = "A 10-round double-stack magazine for standard-issue 9mm pistols. These rounds do okay damage, but struggle against armor."
	icon_state = "co9mm-8"
	base_icon_state = "co9mm"
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = "9mm"
	max_ammo = 10

/obj/item/ammo_box/magazine/co9mm/inc
	name = "pistol magazine (9mm incendiary)"
	desc = "A 10-round double-stack magazine for standard-issue 9mm pistols. These incendiary rounds deal pitiful damage, but leave flaming trails which set targets ablaze."
	ammo_type = /obj/item/ammo_casing/c9mm/inc

/obj/item/ammo_box/magazine/co9mm/hp
	name = "pistol magazine (9mm HP)"
	desc= "A 10-round double-stack magazine for standard-issue 9mm pistols. These hollow point rounds do significant damage against soft targets, but are nearly ineffective against armored ones."
	ammo_type = /obj/item/ammo_casing/c9mm/hp

/obj/item/ammo_box/magazine/co9mm/ap
	name = "pistol magazine (9mm AP)"
	desc= "A 10-round double-stack magazine for standard-issue 9mm pistols. These armor-piercing rounds are okay at piercing protective equipment, but lose some stopping power."
	ammo_type = /obj/item/ammo_casing/c9mm/ap

/obj/item/ammo_box/magazine/co9mm/rubber
	name = "pistol magazine (9mm rubber)"
	desc = "A 10-round double-stack magazine for standard-issue 9mm pistols. These rubber rounds trade lethality for a heavy impact which can incapacitate targets. Performs even worse against armor."
	ammo_type = /obj/item/ammo_casing/c9mm/rubber

/obj/item/ammo_box/magazine/co9mm/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[ammo_count() == 1 ? 1 : round(ammo_count(),2)]"

/obj/item/ammo_box/magazine/pistolm9mm
	name = "large pistol magazine (9mm)"
	desc = "A long, 15-round double-stack magazine designed for the stechkin APS pistol. These rounds do okay damage, but struggle against armor."
	icon_state = "9x19p-8"
	base_icon_state = "9x19p"
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = "9mm"
	max_ammo = 15

/obj/item/ammo_box/magazine/pistolm9mm/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[ammo_count() ? "8" : "0"]"

/obj/item/ammo_box/magazine/m50
	name = "handgun magazine (.50 AE)"
	desc = "An oversized, 7-round handgun magazine for the Desert Eagle handgun. These rounds do significant damage with average performance against armor."
	icon_state = "50ae"
	ammo_type = /obj/item/ammo_casing/a50AE
	caliber = ".50 AE"
	max_ammo = 7
	multiple_sprites = AMMO_BOX_PER_BULLET

/obj/item/ammo_box/magazine/disposable
	name = "part of a disposable gun"
	desc = "You ripped out part of the gun, somehow, rendering it unusuable. I hope you're happy."
	icon_state = "45-8"
	ammo_type = /obj/item/ammo_casing/c38
	caliber = ".38"
	max_ammo = 3
	w_class = WEIGHT_CLASS_TINY

/obj/item/ammo_box/magazine/zip_ammo_9mm
	name = "budget pistol magazine (9mm)"
	desc = "A cheaply-made, 4-round surplus magazine that fits standard-issue 9mm pistols. These rounds do okay damage, but struggle against armor."
	icon_state = "ZipAmmo9mm"
	ammo_type = /obj/item/ammo_casing/c9mm/surplus
	caliber = "9mm"
	max_ammo = 4
	custom_materials = list(/datum/material/iron = 20000)
