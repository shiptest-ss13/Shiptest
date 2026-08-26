/* Contains ionization, lorentz, and plasma flare projectiles */

/obj/projectile/beam/ionization
	name = "ionization beam"
	icon_state = ""
	pass_flags = PASSTABLE | PASSGRILLE

	/* to set */
	damage = 20
	armour_penetration = -10
	damage_type = BURN

	hitscan = TRUE

	tracer_type = /obj/effect/projectile/tracer/ionization
	muzzle_type = /obj/effect/projectile/muzzle/ionization
	impact_type = /obj/effect/projectile/impact/ionization

	bullet_identifier = "plasma beam"

	range = 10

	flag = "laser"

	impact_effect_type = null

	ricochets_max = 0
	reflectable = 0

/obj/projectile/beam/ionization/sniper
	name = "far-reach ionization beam"

	damage = 35
	armour_penetration = 20

	range = 20

	tracer_type = /obj/effect/projectile/tracer/ionization/sniper
	muzzle_type = /obj/effect/projectile/muzzle/ionization/sniper
	impact_type = /obj/effect/projectile/impact/ionization/sniper

/obj/projectile/beam/lorentz
	name = "lorentz bolt"
	icon_state = ""
	pass_flags = PASSTABLE | PASSGRILLE

	/* to set */
	damage = 35
	armour_penetration = 0
	damage_type = BURN

	range = 8

	hitscan = TRUE

	tracer_type = /obj/effect/projectile/tracer/lorentz
	muzzle_type = /obj/effect/projectile/muzzle/lorentz
	impact_type = /obj/effect/projectile/impact/lorentz

	bullet_identifier = "bolt"

	flag = "laser"
	eyeblur = 2
	impact_effect_type = null
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
	damage = 10
	armour_penetration = -5
	damage_type = BURN
	wound_bonus = -20
	bare_wound_bonus = 10

	range = 5

	flag = "laser"

	var/tile_dropoff = 1

	var/ap_dropoff = 5
	var/ap_dropoff_cutoff = -20

/obj/projectile/beam/lorentz/shotgun/Range()
	..()
	if(damage > 0)
		damage -= tile_dropoff
	if(armour_penetration > ap_dropoff_cutoff)
		armour_penetration -= ap_dropoff
	if(accuracy_mod < 3)
		accuracy_mod += 0.3
	if(damage < 0)
		qdel(src)

/obj/projectile/beam/lorentz/mg
	range = 12

/obj/projectile/beam/flare
	name = "plasma flare"
	icon_state = ""
	pass_flags = PASSTABLE | PASSGRILLE

	hitsound = 'sound/weapons/gun/cybersun/plasmaflareimpact.ogg'
	hitsound_non_living = 'sound/weapons/gun/cybersun/plasmaflareimpact.ogg'
	hitsound_glass = 'sound/weapons/gun/cybersun/plasmaflareimpact.ogg'
	hitsound_stone = 'sound/weapons/gun/cybersun/plasmaflareimpact.ogg'
	hitsound_metal = 'sound/weapons/gun/cybersun/plasmaflareimpact.ogg'
	hitsound_wood = 'sound/weapons/gun/cybersun/plasmaflareimpact.ogg'
	hitsound_snow = 'sound/weapons/gun/cybersun/plasmaflareimpact.ogg'

	damage = 100
	armour_penetration = 0
	damage_type = BURN

	range = 6

	hitscan = TRUE

	tracer_type = /obj/effect/projectile/tracer/flare
	muzzle_type = /obj/effect/projectile/muzzle/flare
	impact_type = /obj/effect/projectile/impact/flare

	hitscan_light_intensity = 1.5
	hitscan_light_range = 0.75
	hitscan_light_color_override = COLOR_MAROON
	muzzle_flash_intensity = 3
	muzzle_flash_range = 1.5
	muzzle_flash_color_override = COLOR_MAROON
	impact_light_intensity = 3
	impact_light_range = 2
	impact_light_color_override = COLOR_MAROON

	bullet_identifier = "flare"

	flag = "laser"
	eyeblur = 2
	impact_effect_type = null
	ricochets_max = 0
	reflectable = 0
