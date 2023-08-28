// 7.12x82mm (SAW)

/obj/item/ammo_casing/mm712x82
	name = "7.12x82mm bullet casing"
	desc = "A 7.12x82mm bullet casing."
	icon_state = "rifle-steel"
	caliber = "7.12x82mm"
	projectile_type = /obj/projectile/bullet/mm712x82

/obj/item/ammo_casing/mm712x82/ap
	name = "7.12x82mm armor-piercing bullet casing"
	desc = "A 7.12x82mm bullet casing with a tungsten core to enhance armor penetration."
	projectile_type = /obj/projectile/bullet/mm712x82_ap
	bullet_skin = "ap"

/obj/item/ammo_casing/mm712x82/hollow
	name = "7.12x82mm hollow-point bullet casing"
	desc = "A 7.12x82mm bullet casing designed to fragment on impact, improving damage against soft targets."
	projectile_type = /obj/projectile/bullet/mm712x82_hp
	bullet_skin = "hollow"

/obj/item/ammo_casing/mm712x82/incen
	name = "7.12x82mm incendiary bullet casing"
	desc = "A 7.12x82mm bullet casing with an incendiary payload."
	projectile_type = /obj/projectile/bullet/incendiary/mm712x82
	bullet_skin = "incen"

/obj/item/ammo_casing/mm712x82/match
	name = "7.12x82mm match bullet casing"
	desc = "A 7.12x82mm bullet casing of exceptionally high grade. A skilled marksman could pull off deadly richochet shots with this."
	projectile_type = /obj/projectile/bullet/mm712x82_match
	bullet_skin = "rubber"
