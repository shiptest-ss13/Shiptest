/* Contains ionization, lorentz, and plasma flare projectiles */

/obj/projectile/beam/ionization
	name = "ionization beam"
	icon_state = ""
	pass_flags = PASSTABLE | PASSGRILLE

	/* to set */
	damage = 25
	armour_penetration = -5
	damage_type = BURN
	wound_bonus = -20
	bare_wound_bonus = 10

	hitscan = TRUE

	tracer_type = /obj/effect/projectile/tracer/ionization
	muzzle_type = /obj/effect/projectile/muzzle/ionization
	impact_type = /obj/effect/projectile/impact/ionization

	bullet_identifier = "beam"

	flag = "laser"
	eyeblur = 2
	impact_effect_type = /obj/effect/temp_visual/impact_effect/red_laser
	light_system = MOVABLE_LIGHT
	light_range = 1.5
	light_power = 1
	light_color = COLOR_SOFT_RED
	ricochets_max = 0
	reflectable = 0

/obj/projectile/beam/lorentz
	name = "lorentz bolt"
	icon_state = ""
	pass_flags = PASSTABLE | PASSGRILLE

	/* to set */
	damage = 25
	armour_penetration = -5
	damage_type = BURN
	wound_bonus = -20
	bare_wound_bonus = 10

	hitscan = TRUE

	tracer_type = /obj/effect/projectile/tracer/lorentz
	muzzle_type = /obj/effect/projectile/muzzle/lorentz
	impact_type = /obj/effect/projectile/impact/lorentz

	bullet_identifier = "bolt"

	flag = "laser"
	eyeblur = 2
	impact_effect_type = /obj/effect/temp_visual/impact_effect/red_laser
	light_system = MOVABLE_LIGHT
	light_range = 1.5
	light_power = 1
	light_color = COLOR_SOFT_RED
	ricochets_max = 0
	reflectable = 0

/obj/projectile/beam/lorentz/shotgun
	name = "lorentz bolt"
	icon_state = ""

	/* to set */
	damage = 25
	armour_penetration = -5
	damage_type = BURN
	wound_bonus = -20
	bare_wound_bonus = 10

	flag = "laser"
	eyeblur = 2

/obj/projectile/beam/flare
	name = "plasma flare"
	icon_state = ""
	pass_flags = PASSTABLE | PASSGRILLE

	/* to set */
	damage = 25
	armour_penetration = -5
	damage_type = BURN
	wound_bonus = -20
	bare_wound_bonus = 10

	hitscan = TRUE

	tracer_type = /obj/effect/projectile/tracer/flare
	muzzle_type = /obj/effect/projectile/muzzle/flare
	impact_type = /obj/effect/projectile/impact/flare

	bullet_identifier = "flare"

	flag = "laser"
	eyeblur = 2
	impact_effect_type = /obj/effect/temp_visual/impact_effect/red_laser
	light_system = MOVABLE_LIGHT
	light_range = 1.5
	light_power = 1
	light_color = COLOR_SOFT_RED
	ricochets_max = 0
	reflectable = 0
