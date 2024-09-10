// .50 BMG (Sniper)

/obj/item/ammo_casing/p50
	name = ".50 BMG bullet casing"
	desc = "A .50 BMG bullet casing."
	icon_state = "big-steel"
	caliber = ".50 BMG"
	projectile_type = /obj/projectile/bullet/p50
	bullet_per_box = 20

/obj/item/ammo_casing/p50/soporific
	name = ".50 BMG soporific bullet casing"
	desc = "A .50 BMG soporific bullet casing."
	bullet_skin = "rubber"
	projectile_type = /obj/projectile/bullet/p50/soporific
	harmful = FALSE

/obj/item/ammo_casing/p50/penetrator
	name = ".50 BMG penetrator bullet casing"
	desc = "A .50 BMG penetrator bullet casing."
	bullet_skin = "ap"
	projectile_type = /obj/projectile/bullet/p50/penetrator

//14.5mm Crunch Gun
/obj/item/ammo_casing/p145
	name = "14.5mm Ball casing"
	desc = "A 14.5mm bullet casing."
	icon_state = "big-steel"
	caliber = "14.5x146.7mm"
	projectile_type = /obj/projectile/bullet/p145
	bullet_per_box = 20
