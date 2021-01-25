/obj/item/ammo_box/magazine/pistol556mm
	name = "handgun magazine (5.56mm HITP caseless)"
	icon = 'whitesands/icons/obj/ammo.dmi'
	icon_state = "5.56mmHITP-12" //ok i did it
	ammo_type = /obj/item/ammo_casing/caseless/c556mmHITP
	caliber = "5.56mm HITP caseless"
	max_ammo = 12

/obj/item/ammo_box/magazine/pistol556mm/update_icon()
	..()
	icon_state = "5.56mmHITP-[round(ammo_count(),2)]"
