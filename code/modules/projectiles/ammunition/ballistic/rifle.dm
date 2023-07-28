// 7.62 (Nagant Rifle)

/obj/item/ammo_casing/a762
	name = "7.62x54 bullet casing"
	desc = "A 7.62x54 bullet casing."
	icon_state = "rifle-brass"
	caliber = "a762"
	projectile_type = /obj/projectile/bullet/a762

/obj/item/ammo_casing/a762/enchanted
	bullet_skin = "rubber"
	projectile_type = /obj/projectile/bullet/a762_enchanted

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
	icon_state = "762-casing"
	caliber = "a300"
	projectile_type = /obj/projectile/bullet/a300

// 5.56mm (M-90gl Carbine & P-16)

/obj/item/ammo_casing/a556
	name = "5.56mm bullet casing"
	desc = "A 5.56mm bullet casing."
	icon_state = "rifle-brass"
	caliber = "a556"
	projectile_type = /obj/projectile/bullet/a556

/obj/item/ammo_casing/a545_39
	name = "5.45x39mm bullet casing"
	desc = "A 5.45x39mm bullet casing."
	icon_state = "rifle-steel"
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
	name = "7.62x39mm FMJ bullet casing"
	desc = "A 7.62x39mm FMJ bullet casing."
	icon_state = "rifle-steel"
	caliber = "7.62x39mm FMJ"
	variance = 2
	projectile_type = /obj/projectile/bullet/a762_39

/obj/item/ammo_casing/aac_300blk
	name = ".300BLK bullet casing"
	desc = "A .300 Blackout bullet casing."
	icon_state = "rifle-steel"
	caliber = ".300BLK"
	projectile_type = /obj/projectile/bullet/aac_300blk

/obj/item/ammo_casing/aac_300blk/recycled
	name = "recycled .300BLK bullet casing"
	desc = "A .300 Blackout bullet casing. It looks like it has been re-necked and reloaded several times."
	bullet_skin = "surplus"
	caliber = ".300BLK"
	projectile_type = /obj/projectile/bullet/aac_300blk

/obj/item/ammo_casing/a308
	name = ".308 bullet casing"
	desc = "A .308 bullet casing."
	icon_state = "rifle-steel"
	caliber = ".308"
	projectile_type = /obj/projectile/bullet/a308

// 40mm (Grenade Launcher)

/obj/item/ammo_casing/a40mm
	name = "40mm HE shell"
	desc = "A cased high explosive grenade that can only be activated once fired out of a grenade launcher."
	icon_state = "40mmHE"
	caliber = "40mm"
	projectile_type = /obj/projectile/bullet/a40mm
