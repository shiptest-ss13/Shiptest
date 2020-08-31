/obj/item/ammo_box/magazine/rifle47x33mm
	name = "SolGov AR magazine (4.73×33mm caseless)"
	icon = 'waspstation/icons/obj/ammo.dmi'
	icon_state = "47x33mm-50"
	ammo_type = /obj/item/ammo_casing/caseless/c47x33mm
	caliber = "4.73×33mm caseless"
	max_ammo = 50 //brrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr

/obj/item/ammo_box/magazine/rifle47x33mm/update_icon()
	..()
	icon_state = "47x33mm-[round(ammo_count(),5)]"

/obj/item/ammo_box/magazine/pistol556mm
	name = "handgun magazine (5.56mm HITP caseless)"
	icon = 'waspstation/icons/obj/ammo.dmi'
	icon_state = "5.56mmHITP-12" //ok i did it
	ammo_type = /obj/item/ammo_casing/caseless/c556mmHITP
	caliber = "5.56mm HITP caseless"
	max_ammo = 12

/obj/item/ammo_box/magazine/pistol556mm/update_icon()
	..()
	icon_state = "5.56mmHITP-[round(ammo_count(),2)]"
