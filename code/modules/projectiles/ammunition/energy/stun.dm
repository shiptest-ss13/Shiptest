/obj/item/ammo_casing/energy/electrode
	projectile_type = /obj/projectile/energy/electrode
	select_name = "stun"
	fire_sound = 'sound/weapons/taser.ogg'
	rounds_per_shot = 2000
	harmful = FALSE

/obj/item/ammo_casing/energy/electrode/spec
	rounds_per_shot = 1000

/obj/item/ammo_casing/energy/electrode/gun
	fire_sound = 'sound/weapons/gun/pistol/shot.ogg'
	rounds_per_shot = 1000

/obj/item/ammo_casing/energy/electrode/old
	rounds_per_shot = 10000

/obj/item/ammo_casing/energy/electrode/hos
	rounds_per_shot = 4000

/obj/item/ammo_casing/energy/disabler
	projectile_type = /obj/projectile/beam/disabler
	select_name  = "disable"
	rounds_per_shot = 500
	fire_sound = 'sound/weapons/taser2.ogg'
	harmful = FALSE

/obj/item/ammo_casing/energy/disabler/hos
	rounds_per_shot = 600

/obj/item/ammo_casing/energy/disabler/scatter	//WS edit, scatter repathing
	pellets = 3
	variance = 15
	select_name = "scatter"
	fire_sound = 'sound/weapons/taser.ogg'

/obj/item/ammo_casing/energy/disabler/scatter/ultima
	projectile_type = /obj/projectile/beam/disabler/weak/negative_ap/low_range
	pellets = 4
	variance = 35
	rounds_per_shot = 2000

/obj/item/ammo_casing/energy/disabler/scatter/ultima/alt
	select_name = "blast"

/obj/item/ammo_casing/energy/disabler/smg
	projectile_type = /obj/projectile/beam/disabler/weak/negative_ap
	rounds_per_shot = 330
	delay = 0.13 SECONDS
