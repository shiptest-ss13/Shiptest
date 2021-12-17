/obj/projectile/beam/hitscan
	name = "hitscan beam"
	tracer_type = /obj/effect/projectile/tracer/laser
	muzzle_type = /obj/effect/projectile/muzzle/laser
	impact_type = /obj/effect/projectile/impact/laser
	hitscan_light_intensity = 2
	hitscan_light_range = 0.50
	hitscan_light_color_override = COLOR_SOFT_RED
	muzzle_flash_intensity = 4
	muzzle_flash_range = 1
	muzzle_flash_color_override = COLOR_SOFT_RED
	impact_light_intensity = 5
	impact_light_range = 1.25
	impact_light_color_override = COLOR_SOFT_RED
	range = 15
	var/damage_constant = 0.8
	hitscan = TRUE

/obj/projectile/beam/hitscan/Range()
	if(hitscan != TRUE)
		return ..()
	var/turf/location = get_turf(src)
	if(!location)
		return ..()
	var/datum/gas_mixture/environment = location.return_air()
	var/environment_pressure = environment.return_pressure()
	if(environment_pressure >= 50)
		if((decayedRange - range) >= 4)
			damage *= damage_constant
	. = ..()

/obj/item/ammo_casing/energy/lasergun/hitscan
	projectile_type = /obj/projectile/beam/hitscan/laser
	select_name = "kill"
	e_cost = 830

/obj/projectile/beam/hitscan/laser
	name = "hitscan laser"

/obj/item/ammo_casing/energy/disabler/hitscan
	projectile_type = /obj/projectile/beam/hitscan/disabler
	e_cost = 833

/obj/projectile/beam/hitscan/disabler
	name = "disabler beam"
	icon_state = "omnilaser"
	hitscan = TRUE
	damage = 20
	damage_type = STAMINA
	flag = "energy"
	hitsound = 'sound/weapons/tap.ogg'
	eyeblur = 0
	impact_effect_type = /obj/effect/temp_visual/impact_effect/blue_laser
	tracer_type = /obj/effect/projectile/tracer/disabler
	muzzle_type = /obj/effect/projectile/muzzle/disabler
	impact_type = /obj/effect/projectile/impact/disabler

	light_color = LIGHT_COLOR_BLUE

	hitscan_light_intensity = 2
	hitscan_light_range = 0.75
	hitscan_light_color_override = COLOR_CYAN
	muzzle_flash_intensity = 4
	muzzle_flash_range = 2
	muzzle_flash_color_override = COLOR_CYAN
	impact_light_intensity = 6
	impact_light_range = 2.5
	impact_light_color_override = COLOR_CYAN
