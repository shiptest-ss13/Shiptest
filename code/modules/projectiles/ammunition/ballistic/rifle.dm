// 7.62 (Nagant Rifle)

/obj/item/ammo_casing/a762
	name = "7.62x54mmR bullet casing"
	desc = "A 7.62x54mmR bullet casing."
	icon_state = "rifle-brass"
	caliber = "7.62x54mmR"
	projectile_type = /obj/projectile/bullet/a762

// 8x58mm Caseless (SSG-669C)

/obj/item/ammo_casing/caseless/a858
	name = "8x58mm caseless round"
	desc = "a 8x58mm caseless round."
	icon_state = "caseless"
	caliber = "a858"
	projectile_type = /obj/projectile/bullet/a858

// .300 Magnum (Smile Rifle)

/obj/item/ammo_casing/a300
	name = ".300 Magnum bullet casing"
	desc = "A .300 Magnum bullet casing."
	icon_state = "rifle-brass"
	caliber = "a300"
	projectile_type = /obj/projectile/bullet/a300

// 5.56mm (M-90gl Carbine & P-16)

/obj/item/ammo_casing/a556
	name = "5.56mm bullet casing"
	desc = "A 5.56mm bullet casing."
	icon_state = "rifle-brass"
	caliber = "5.56x45mm"
	projectile_type = /obj/projectile/bullet/a556

/obj/item/ammo_casing/a545_39
	name = "5.45x39mm bullet casing"
	desc = "A 5.45x39mm bullet casing."
	icon_state = "rifle-brass"
	caliber = "5.45x39mm"
	randomspread = TRUE
	variance = 2
	projectile_type = /obj/projectile/bullet/a545_39

/obj/item/ammo_casing/a545_39/recycled
	name = "recycled 5.45x39mm bullet casing"
	desc = "A recycled 5.45x39mm bullet casing. Likely has been spent and reloaded dozens of times."
	bullet_skin = "surplus"
	caliber = "5.45x39mm"
	variance = 3.5
	projectile_type = /obj/projectile/bullet/a545_39

/obj/item/ammo_casing/a762_39
	name = "7.62x39mm bullet casing"
	desc = "A 7.62x39mm bullet casing."
	icon_state = "rifle-brass"
	caliber = "7.62x39mm"
	variance = 2
	projectile_type = /obj/projectile/bullet/a762_39

/obj/item/ammo_casing/aac_300blk
	name = ".300 BLK bullet casing"
	desc = "A .300 Blackout bullet casing."
	icon_state = "rifle-steel"
	caliber = ".300 BLK"
	projectile_type = /obj/projectile/bullet/aac_300blk

/obj/item/ammo_casing/aac_300blk/recycled
	name = "recycled .300 BLK bullet casing"
	desc = "A .300 Blackout bullet casing. It looks like it has been re-necked and reloaded several times."
	caliber = ".300 BLK"
	projectile_type = /obj/projectile/bullet/aac_300blk

/obj/item/ammo_casing/win308
	name = ".308 Winchester bullet casing"
	desc = "A .308 Winchester bullet casing."
	icon_state = "rifle-steel"
	caliber = ".308 Winchester"
	projectile_type = /obj/projectile/bullet/win308
