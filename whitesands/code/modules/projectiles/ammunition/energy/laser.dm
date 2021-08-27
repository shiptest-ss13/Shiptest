/obj/projectile/beam/laser/hitscan/Range()
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
	projectile_type = /obj/projectile/beam/laser/hitscan
	select_name = "kill"
	e_cost = 830

/obj/projectile/beam/laser/hitscan
	name = "hitscan laser"
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
