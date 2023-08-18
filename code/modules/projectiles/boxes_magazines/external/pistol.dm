/obj/item/ammo_box/magazine/m10mm
	name = "pistol magazine (10mm)"
	desc = "A single-stack handgun magazine designed to chamber 10mm."
	icon_state = "9x19p"
	ammo_type = /obj/item/ammo_casing/c10mm
	caliber = "10mm"
	max_ammo = 8
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/m10mm/fire
	name = "pistol magazine (10mm incendiary)"
	icon_state = "9x19pI"
	desc = "A single-stack handgun magazine designed to chamber 10mm. Loaded with rounds which ignite the target."
	ammo_type = /obj/item/ammo_casing/c10mm/fire

/obj/item/ammo_box/magazine/m10mm/hp
	name = "pistol magazine (10mm HP)"
	icon_state = "9x19pH"
	desc= "A single-stack handgun magazine designed to chamber 10mm. Loaded with rounds which deal more damage, but are completely ineffective against armor."
	ammo_type = /obj/item/ammo_casing/c10mm/hp

/obj/item/ammo_box/magazine/m10mm/ap
	name = "pistol magazine (10mm AP)"
	icon_state = "9x19pA"
	desc= "A single-stack handgun magazine designed to chamber 10mm. Loaded with rounds which penetrate armour, but are less effective against normal targets."
	ammo_type = /obj/item/ammo_casing/c10mm/ap

/obj/item/ammo_box/magazine/m10mm/rubbershot
	name = "pistol magazine (10mm rubbershot)"
	icon_state = "9x19pR"
	desc = "A single-stack handgun magazine designed to chamber 10mm. Loaded with less-lethal rubber rounds which disable targets without causing serious damage."
	ammo_type = /obj/item/ammo_casing/c10mm/rubbershot

/obj/item/ammo_box/magazine/m45
	name = "pistol magazine (.45)"
	desc = "A single stack M1911 reproduction magazine, faithfully designed to chamber .45."
	icon_state = "45-8"
	base_icon_state = "45"
	ammo_type = /obj/item/ammo_casing/c45
	caliber = ".45"
	max_ammo = 8

/obj/item/ammo_box/magazine/m45/fire
	name = "pistol magazine (.45 incendiary)"
	desc = "A single stack M1911 reproduction magazine, faithfully designed to chamber .45. Loaded with rounds which ignite the target."
	ammo_type = /obj/item/ammo_casing/c45/fire

/obj/item/ammo_box/magazine/m45/hp
	name = "pistol magazine (.45 HP)"
	desc= "A single stack M1911 reproduction magazine, faithfully designed to chamber .45. Loaded with rounds which deal more damage, but are completely ineffective against armor."
	ammo_type = /obj/item/ammo_casing/c45/hp

/obj/item/ammo_box/magazine/m45/ap
	name = "pistol magazine (.45 AP)"
	desc= "A single stack M1911 reproduction magazine, faithfully designed to chamber .45. Loaded with rounds which penetrate armour, but are less effective against normal targets."
	ammo_type = /obj/item/ammo_casing/c45/ap

/obj/item/ammo_box/magazine/m45/rubbershot
	name = "pistol magazine (.45 rubbershot)"
	desc = "A single stack M1911 reproduction magazine, faithfully designed to chamber .45. Loaded with less-lethal rubber rounds which disable targets without causing serious damage."
	ammo_type = /obj/item/ammo_casing/c45/rubbershot

/obj/item/ammo_box/magazine/m45/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[min(ammo_count(), 8)]"

/obj/item/ammo_box/magazine/co9mm
	name = "pistol magazine (9mm)"
	desc = "A single stack M1911 reproduction magazine, modified to chamber 9mm."
	icon_state = "co9mm-10"
	base_icon_state = "co9mm"
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = "9mm"
	max_ammo = 10

/obj/item/ammo_box/magazine/co9mm/fire
	name = "pistol magazine (9mm incendiary)"
	desc = "A single stack M1911 reproduction magazine, modified to chamber 9mm. Loaded with rounds which ignite the target."
	ammo_type = /obj/item/ammo_casing/c9mm/inc

/obj/item/ammo_box/magazine/co9mm/hp
	name = "pistol magazine (9mm HP)"
	desc= "A single stack M1911 reproduction magazine, modified to chamber 9mm. Loaded with rounds which deal more damage, but are completely ineffective against armor."
	ammo_type = /obj/item/ammo_casing/c9mm/hp

/obj/item/ammo_box/magazine/co9mm/ap
	name = "pistol magazine (9mm AP)"
	desc= "A single stack M1911 reproduction magazine, modified to chamber 9mm. Loaded with rounds which penetrate armour, but are less effective against normal targets."
	ammo_type = /obj/item/ammo_casing/c9mm/ap

/obj/item/ammo_box/magazine/co9mm/rubbershot
	name = "pistol magazine (9mm rubbershot)"
	desc = "A single stack M1911 reproduction magazine, modified to chamber 9mm. Loaded with less-lethal rubber rounds which disable targets without causing serious damage."
	ammo_type = /obj/item/ammo_casing/c9mm/rubbershot

/obj/item/ammo_box/magazine/co9mm/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[ammo_count() == 1 ? 1 : round(ammo_count(),2)]"

/obj/item/ammo_box/magazine/pistolm9mm
	name = "large pistol magazine (9mm)"
	desc = "A double stack pistol magazine, designed to chamber 9mm."
	icon_state = "9x19p-8"
	base_icon_state = "9x19p"
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = "9mm"
	max_ammo = 15

/obj/item/ammo_box/magazine/pistolm9mm/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[ammo_count() ? "8" : "0"]"

/obj/item/ammo_box/magazine/m50
	name = "handgun magazine (.50ae)"
	desc = "An oversized handgun magazine designed to chamber .50 AE."
	icon_state = "50ae"
	ammo_type = /obj/item/ammo_casing/a50AE
	caliber = ".50"
	max_ammo = 7
	multiple_sprites = AMMO_BOX_PER_BULLET

/obj/item/ammo_box/magazine/disposable
	name = "part of a disposable gun"
	desc = "You ripped out part of the gun, somehow, rendering it unusuable. I hope you're happy."
	icon_state = "45-8"
	ammo_type = /obj/item/ammo_casing/c38
	caliber = ".38"
	max_ammo = 3
