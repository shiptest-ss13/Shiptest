/obj/item/ammo_box/magazine/m45
	name = "pistol magazine (.45)"
	desc = "An 8-round single-stack magazine for the Candor pistol. These rounds do moderate damage, but struggle against armor."
	icon_state = "candor_mag-8"
	base_icon_state = "candor_mag"
	ammo_type = /obj/item/ammo_casing/c45
	caliber = ".45"
	max_ammo = 8

/obj/item/ammo_box/magazine/m45/empty
	start_empty = TRUE


/obj/item/ammo_box/magazine/m45/hp
	name = "pistol magazine (.45 HP)"
	desc= "An 8-round single-stack magazine for the Candor pistol. These hollow point rounds do incredible damage against soft targets, but are nearly ineffective against armored ones."
	ammo_type = /obj/item/ammo_casing/c45/hp

/obj/item/ammo_box/magazine/m45/ap
	name = "pistol magazine (.45 AP)"
	desc= "An 8-round single-stack magazine for the Candor pistol. These armor-piercing rounds are okay at piercing protective equipment, but lose some stopping power."
	ammo_type = /obj/item/ammo_casing/c45/ap

/obj/item/ammo_box/magazine/m45/rubber
	name = "pistol magazine (.45 rubber)"
	desc = "An 8-round single-stack magazine for the Candor pistol. These rubber rounds trade lethality for a heavy impact which can incapacitate targets. Performs even worse against armor."
	ammo_type = /obj/item/ammo_casing/c45/rubber

/obj/item/ammo_box/magazine/m45/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[min(ammo_count(), 8)]"

/obj/item/ammo_box/magazine/pistol556mm
	name = "Pistole C magazine (5.56mm HITP caseless)"
	desc = "A 12-round, double-stack magazine for the Pistole C pistol. These rounds do okay damage with average performance against armor."
	icon_state = "pistolec_mag-12" //ok i did it
	base_icon_state = "pistolec_mag"
	ammo_type = /obj/item/ammo_casing/caseless/c556mm
	caliber = "5.56mm caseless"
	max_ammo = 12

/obj/item/ammo_box/magazine/pistol556mm/update_icon_state()
	. = ..()
	if(ammo_count() == 12)
		icon_state = "[base_icon_state]-12"
	else if(ammo_count() >= 10)
		icon_state = "[base_icon_state]-10"
	else if(ammo_count() >= 5)
		icon_state = "[base_icon_state]-5"
	else if(ammo_count() >= 1)
		icon_state = "[base_icon_state]-1"
	else
		icon_state = "[base_icon_state]-0"


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

/obj/item/ammo_box/magazine/m50
	name = "handgun magazine (.50 AE)"
	desc = "An oversized, 7-round handgun magazine for the Desert Eagle handgun. These rounds do significant damage with average performance against armor."
	icon_state = "deagle_mag-7"
	base_icon_state = "deagle_mag"
	ammo_type = /obj/item/ammo_casing/a50AE
	caliber = ".50 AE"
	max_ammo = 7
	multiple_sprites = AMMO_BOX_PER_BULLET

/obj/item/ammo_box/magazine/disposable
	name = "part of a disposable gun"
	desc = "You ripped out part of the gun, somehow, rendering it unusuable. I hope you're happy."
	icon_state = "himehabu_mag-10"
	base_icon_state = "himehabu_mag"
	ammo_type = /obj/item/ammo_casing/c22lr
	caliber = ".22lr"
	max_ammo = 10
	w_class = WEIGHT_CLASS_TINY

/obj/item/ammo_box/magazine/zip_ammo_9mm
	name = "budget pistol magazine (9mm)"
	desc = "A cheaply-made, 4-round surplus magazine that fits standard-issue 9mm pistols. These rounds do okay damage, but struggle against armor."
	icon_state = "ZipAmmo9mm"
	ammo_type = /obj/item/ammo_casing/c9mm/surplus
	caliber = "9mm"
	max_ammo = 4
	custom_materials = list(/datum/material/iron = 20000)
