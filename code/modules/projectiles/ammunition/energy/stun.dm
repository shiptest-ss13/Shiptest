/obj/item/ammo_casing/energy/electrode
	projectile_type = /obj/projectile/energy/electrode
	select_name = "stun"
	fire_sound = 'sound/weapons/taser.ogg'
	e_cost = 2000
	harmful = FALSE

/obj/item/ammo_casing/energy/disabler
	projectile_type = /obj/projectile/beam/disabler
	select_name  = "disable"
	e_cost = 500
	fire_sound = 'sound/weapons/taser2.ogg'
	harmful = FALSE

/obj/item/ammo_casing/energy/disabler/sharplite
	projectile_type = /obj/projectile/beam/disabler/sharplite
	select_name  = "disable"
	e_cost = 500
	fire_sound = 'sound/weapons/taser2.ogg'
	harmful = FALSE

/obj/item/ammo_casing/energy/disabler/underbarrel
	e_cost = 625

/obj/item/ammo_casing/energy/disabler/sharplite/hos
	e_cost = 1000

/obj/item/ammo_casing/energy/disabler/scatter
	pellets = 3
	variance = 15
	select_name = "scatter"
	fire_sound = 'sound/weapons/taser.ogg'

/obj/item/ammo_casing/energy/disabler/scatter/shotgun
	projectile_type = /obj/projectile/beam/disabler/weak/negative_ap
	pellets = 4
	variance = 25
	select_name = "disable"
	e_cost = 1000

/obj/item/ammo_casing/energy/disabler/scatter/shotgun/sharplite
	projectile_type = /obj/projectile/beam/disabler/weak/negative_ap/sharplite
	select_name = "disable"

/obj/item/ammo_casing/energy/disabler/smg
	projectile_type = /obj/projectile/beam/disabler/weak/negative_ap
	e_cost = 330
	delay = 0.13 SECONDS

/obj/item/ammo_casing/energy/disabler/sharplite/smg
	projectile_type = /obj/projectile/beam/disabler/weak/negative_ap/sharplite
	e_cost = 330
	delay = 0.13 SECONDS
