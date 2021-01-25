/obj/item/ammo_box/magazine/rifle47x33mm
	name = "SolGov AR magazine (4.73×33mm caseless)"
	icon = 'whitesands/icons/obj/ammo.dmi'
	icon_state = "47x33mm-50"
	ammo_type = /obj/item/ammo_casing/caseless/c47x33mm
	caliber = "4.73×33mm caseless"
	max_ammo = 50 //brrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr

/obj/item/ammo_box/magazine/rifle47x33mm/update_icon()
	..()
	icon_state = "47x33mm-[round(ammo_count(),5)]"

/obj/item/ammo_box/magazine/aks74u
	name = "AKS-74U (5.45x39mm cartridge)"
	icon = 'whitesands/icons/obj/ammo.dmi'
	icon_state = "aks74u_mag"
	ammo_type = /obj/item/ammo_casing/ballistic/a545_39
	caliber = "5.45x39mm"
	max_ammo = 30
