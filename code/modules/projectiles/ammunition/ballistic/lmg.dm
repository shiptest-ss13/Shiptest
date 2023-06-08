// 7.12x82mm (SAW)

/obj/item/ammo_casing/mm712x82
	name = "7.12x82mm bullet casing"
	desc = "A 7.12x82mm bullet casing."
	icon_state = "rifle-steel"
	caliber = "mm71282"
	projectile_type = /obj/projectile/bullet/mm712x82

/obj/item/ammo_casing/mm712x82/ap
	name = "7.12x82mm armor-piercing bullet casing"
	desc = "A 7.12x82mm bullet casing designed with a hardened-tipped core to help penetrate armored targets."
	bullet_skin = "ap"
	projectile_type = /obj/projectile/bullet/mm712x82_ap

/obj/item/ammo_casing/mm712x82/hollow
	name = "7.12x82mm hollow-point bullet casing"
	desc = "A 7.12x82mm bullet casing designed to cause more damage to unarmored targets."
	bullet_skin = "hollow"
	projectile_type = /obj/projectile/bullet/mm712x82_hp

/obj/item/ammo_casing/mm712x82/incen
	name = "7.12x82mm incendiary bullet casing"
	desc = "A 7.12x82mm bullet casing designed with a chemical-filled capsule on the tip that when bursted, reacts with the atmosphere to produce a fireball, engulfing the target in flames."
	bullet_skin = "incen"
	projectile_type = /obj/projectile/bullet/incendiary/mm712x82

/obj/item/ammo_casing/mm712x82/match
	name = "7.12x82mm match bullet casing"
	desc = "A 7.12x82mm bullet casing manufactured to unfailingly high standards, you could pull off some cool trickshots with this."
	projectile_type = /obj/projectile/bullet/mm712x82_match
