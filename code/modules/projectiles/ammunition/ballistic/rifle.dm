// 7.62 (Nagant Rifle)

/obj/item/ammo_casing/a762
	name = "7.62x54 bullet casing"
	desc = "A 7.62x54 bullet casing."
	icon_state = "762-casing"
	caliber = "a762"
	projectile_type = /obj/projectile/bullet/a762

/obj/item/ammo_casing/a762/enchanted
	projectile_type = /obj/projectile/bullet/a762_enchanted

// 5.56mm (M-90gl Carbine & P-16)

/obj/item/ammo_casing/a556
	name = "5.56mm bullet casing"
	desc = "A 5.56mm bullet casing."
	caliber = "a556"
	projectile_type = /obj/projectile/bullet/a556

// 40mm (Grenade Launcher)

/obj/item/ammo_casing/a40mm
	name = "40mm HE shell"
	desc = "A cased high explosive grenade that can only be activated once fired out of a grenade launcher."
	caliber = "40mm"
	icon_state = "40mmHE"
	projectile_type = /obj/projectile/bullet/a40mm

/obj/item/ammo_casing/a545_39
	name = "5.45x39mm bullet casing"
	desc = "A 5.45x39mm bullet casing."
	caliber = "5.45x39mm"
	randomspread = TRUE
	variance = 2
	projectile_type = /obj/projectile/bullet/a545_39

/obj/item/ammo_casing/a545_39/recycled
	name = "recycled 5.45x39mm bullet casing"
	desc = "A recycled 5.45x39mm bullet casing. Likely has been spent and reloaded dozens of times."
	caliber = "5.45x39mm"
	variance = 3.5
	projectile_type = /obj/projectile/bullet/a545_39

/obj/item/ammo_casing/a762_39
	name = "7.62x39mm FMJ bullet casing"
	desc = "A 7.62x39mm FMJ bullet casing."
	caliber = "7.62x39mm FMJ"
	variance = 2
	projectile_type = /obj/projectile/bullet/a762_39

/obj/item/ammo_casing/aac_300blk
	name = ".300BLK bullet casing"
	desc = "A .300 Blackout bullet casing."
	caliber = ".300BLK"
	projectile_type = /obj/projectile/bullet/aac_300blk

/obj/item/ammo_casing/aac_300blk/recycled
	name = "recycled .300BLK bullet casing"
	desc = "A .300 Blackout bullet casing. It looks like it has been re-necked and reloaded several times."
	caliber = ".300BLK"
	projectile_type = /obj/projectile/bullet/aac_300blk

/obj/item/ammo_casing/win308
	name = ".308 Winchester FMJ bullet casing"
	desc = "A .308 Winchester FMJ bullet casing."
	caliber = ".308 Winchester FMJ"
	projectile_type = /obj/projectile/bullet/win308
