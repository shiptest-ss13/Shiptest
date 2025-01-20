// Ferromagnetic Pellet (Prototype Gauss Rifle & Claris)

/obj/projectile/bullet/gauss
	name = "ferromagnetic pellet"
	icon_state = "gauss-pellet"
	damage = 25
	range = 35
	light_system = 2
	light_color = MOVABLE_LIGHT
	light_range = 3

/obj/projectile/bullet/gauss/hc
	name = "ferromagnetic pellet"
	damage = 10
	armour_penetration = 60
	range = 35
	hitscan = TRUE
	muzzle_type = /obj/effect/projectile/muzzle/gauss
	tracer_type = /obj/effect/projectile/tracer/gauss
	impact_type = /obj/effect/projectile/impact/gauss

// Ferromagnetic Lance (GAR AR)

/obj/projectile/bullet/gauss/lance
	name = "ferromagnetic lance"
	icon_state = "redtrac"
	damage = 30
	armour_penetration = 20

/obj/projectile/bullet/gauss/lance/hc
	name = "ferromagnetic lance"
	damage = 15
	armour_penetration = 80
	range = 35
	hitscan = TRUE
	muzzle_type = /obj/effect/projectile/muzzle/gauss
	tracer_type = /obj/effect/projectile/tracer/gauss
	impact_type = /obj/effect/projectile/impact/gauss

// Ferromagnetic Slug (Model H)

/obj/projectile/bullet/gauss/slug
	name = "ferromagnetic slug"
	icon_state = "gauss-slug"
	damage = 50
	armour_penetration = -60
	speed = 0.8

/obj/projectile/bullet/gauss/slug/hc
	name = "ferromagnetic lance"
	damage = 25
	armour_penetration = 0
	range = 35
	hitscan = TRUE
	muzzle_type = /obj/effect/projectile/muzzle/gauss
	tracer_type = /obj/effect/projectile/tracer/gauss
	impact_type = /obj/effect/projectile/impact/gauss
