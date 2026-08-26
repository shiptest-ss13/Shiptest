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
	damage = 15
	armour_penetration = 60
	range = 50
	hitscan = TRUE
	light_system = 0
	light_range = 0
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
	damage = 20
	armour_penetration = 80
	range = 50
	hitscan = TRUE
	light_system = 0
	light_range = 0
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
	range = 50
	hitscan = TRUE
	light_system = 0
	light_range = 0
	muzzle_type = /obj/effect/projectile/muzzle/gauss
	tracer_type = /obj/effect/projectile/tracer/gauss
	impact_type = /obj/effect/projectile/impact/gauss

// Ferromagnetic rod (Gauss cannon)

/obj/projectile/bullet/gauss/rod
	name = "ferrogmagnetic rod"
	icon_state = "sabot"
	damage = 60
	armour_penetration = 50
	knockdown = 30
	demolition_mod = 4
	wall_damage_override = 250

/obj/projectile/bullet/gauss/rod/on_hit(atom/target, blocked)
	. = ..()
	if(ismovable(target) && isliving(target))
		var/atom/movable/M = target
		var/atom/throw_target = get_edge_target_turf(M, dir)
		M.throw_at(throw_target, 4, 2)

/obj/projectile/bullet/gauss/tavsha
	name = "tav'sha dart"
	icon_state = "gauss-pellet"
	bullet_identifier = "dart"

	damage = 5
	armour_penetration = 10

	homing_turn_speed = 7
	homing_inaccuracy_min = 0
	homing_inaccuracy_max = 16

	ricochets_max = 0
	range = 20
	light_system = 0
	speed = BULLET_SPEED_HANDGUN

	transform = matrix(0.7, 0, 0, 0, 0.7, 0)

/obj/projectile/bullet/gauss/deusha
	name = "deu'sha dart"
	icon_state = "gauss-pellet"
	bullet_identifier = "dart"

	damage = 8
	armour_penetration = 10

	homing_turn_speed = 4
	homing_inaccuracy_min = 0
	homing_inaccuracy_max = 16

	ricochets_max = 0
	range = 20
	light_system = 0
	speed = BULLET_SPEED_HANDGUN
