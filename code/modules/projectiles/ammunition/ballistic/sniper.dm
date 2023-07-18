// .50 (Sniper)

/obj/item/ammo_casing/p50
	name = ".50 bullet casing"
	desc = "A .50 bullet casing."
	icon_state = "big-steel"
	caliber = ".50 BMG"
	projectile_type = /obj/projectile/bullet/p50

/obj/item/ammo_casing/p50/soporific
	name = ".50 soporific bullet casing"
	desc = "A .50 bullet casing, specialised in sending the target to sleep, instead of hell."
	bullet_skin = "rubber"
	projectile_type = /obj/projectile/bullet/p50/soporific
	harmful = FALSE

/obj/item/ammo_casing/p50/penetrator
	name = ".50 penetrator round bullet casing"
	desc = "A .50 caliber penetrator round casing."
	bullet_skin = "ap"
	projectile_type = /obj/projectile/bullet/p50/penetrator
