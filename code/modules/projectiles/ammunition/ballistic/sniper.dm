// .50 BMG (Sniper)

/obj/item/ammo_casing/p50
	name = ".50 BMG bullet casing"
	desc = "A .50 BMG bullet casing."
	icon_state = "big-steel"
	caliber = ".50 BMG"
	projectile_type = /obj/projectile/bullet/p50

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

// .300 Magnum (Smile Rifle)

/obj/item/ammo_casing/a300
	name = ".300 Magnum bullet casing"
	desc = "A .300 Magnum bullet casing."
	icon_state = "rifle-steel"
	caliber = "a300"
	projectile_type = /obj/projectile/bullet/a300
	stack_size = 15

/obj/item/ammo_casing/a300/trac
	name = ".300 Magnum Trac bullet casing"
	desc = "A .300 Magnum Tracker casing."
	projectile_type = /obj/projectile/bullet/a300/trac
	bullet_skin = "trac"

//7.5x64mm CLIP

/obj/item/ammo_casing/a75clip
	name = "7.5x64mm CLIP bullet casing"
	desc = "A 7.5x64mm CLIP bullet casing."
	icon_state = "big-brass"
	caliber = "7.5x64mm CLIP"
	projectile_type = /obj/projectile/bullet/a75clip
	stack_size = 5

/obj/item/ammo_casing/a75clip/trac
	name = "7.5x64mm CLIP tracker"
	desc = "A 7.5x64mm CLIP tracker."
	projectile_type = /obj/projectile/bullet/a75clip/trac
	bullet_skin = "trac"
