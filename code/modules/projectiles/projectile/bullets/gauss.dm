// Ferromagnetic Pellet (Prototype Gauss Rifle & Claris)

/obj/projectile/bullet/gauss
	name = "ferromagnetic pellet"
	icon_state = "gauss-pellet"
	damage = 25
	range = 35
	light_system = 2
	light_color = MOVABLE_LIGHT
	light_range = 3

// Ferromagnetic Lance (GAR AR)

/obj/projectile/bullet/gauss/lance
	name = "ferromagnetic lance"
	icon_state = "redtrac"
	damage = 30
	armour_penetration = 20

// Ferromagnetic Slug (Model H)

/obj/projectile/bullet/gauss/slug
	name = "ferromagnetic slug"
	icon_state = "gauss-slug"
	damage = 50
	armour_penetration = -60
	speed = 0.8
