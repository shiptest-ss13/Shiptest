/obj/item/ammo_casing/energy/laser
	projectile_type = /obj/projectile/beam/laser
	select_name = "kill"

/obj/item/ammo_casing/energy/laser/eoehoma
	projectile_type = /obj/projectile/beam/laser/eoehoma
	fire_sound = 'sound/weapons/gun/laser/e-fire.ogg'

/obj/item/ammo_casing/energy/laser/assault
	projectile_type = /obj/projectile/beam/laser/assault
	fire_sound = 'sound/weapons/gun/laser/e40_las.ogg'
	delay = 2
	e_cost = 666 //30 per upgraded cell

/obj/item/ammo_casing/energy/laser/eoehoma/e50
	projectile_type = /obj/projectile/beam/emitter/hitscan
	fire_sound = 'sound/weapons/gun/laser/heavy_laser.ogg'
	e_cost = 12500
	delay = 1 SECONDS

/obj/item/ammo_casing/energy/lasergun
	projectile_type = /obj/projectile/beam/laser
	e_cost = 830
	select_name = "kill"

/obj/item/ammo_casing/energy/lasergun/eoehoma
	projectile_type = /obj/projectile/beam/laser/eoehoma
	fire_sound = 'sound/weapons/gun/laser/e-fire.ogg'

/obj/item/ammo_casing/energy/laser/smg
	projectile_type = /obj/projectile/beam/laser/weak/negative_ap
	e_cost = 799 //12 shots with a normal power cell, 25 with an upgraded
	select_name = "kill"
	delay = 0.13 SECONDS

/obj/item/ammo_casing/energy/lasergun/old
	projectile_type = /obj/projectile/beam/laser
	e_cost = 2000
	select_name = "kill"

/obj/item/ammo_casing/energy/laser/hos
	e_cost = 1200

/obj/item/ammo_casing/energy/laser/practice
	projectile_type = /obj/projectile/beam/practice
	select_name = "practice"
	harmful = FALSE

/obj/item/ammo_casing/energy/laser/scatter
	projectile_type = /obj/projectile/beam/scatter
	pellets = 5
	variance = 25
	select_name = "scatter"

/obj/item/ammo_casing/energy/laser/ultima
	projectile_type = /obj/projectile/beam/laser/weak/negative_ap/low_range
	pellets = 3
	variance = 35
	e_cost = 2000
	select_name = "kill"

/obj/item/ammo_casing/energy/laser/ultima/alt
	select_name = "scatter"

/obj/item/ammo_casing/energy/laser/heavy
	projectile_type = /obj/projectile/beam/laser/heavylaser
	select_name = "anti-vehicle"
	fire_sound = 'sound/weapons/lasercannonfire.ogg'

/obj/item/ammo_casing/energy/laser/pulse
	projectile_type = /obj/projectile/beam/pulse
	e_cost = 2000
	select_name = "DESTROY"
	fire_sound = 'sound/weapons/gun/laser/heavy_laser.ogg'

/obj/item/ammo_casing/energy/laser/bluetag
	projectile_type = /obj/projectile/beam/lasertag/bluetag
	select_name = "bluetag"
	harmful = FALSE

/obj/item/ammo_casing/energy/laser/bluetag/hitscan
	projectile_type = /obj/projectile/beam/lasertag/bluetag/hitscan

/obj/item/ammo_casing/energy/laser/redtag
	projectile_type = /obj/projectile/beam/lasertag/redtag
	select_name = "redtag"
	harmful = FALSE

/obj/item/ammo_casing/energy/laser/redtag/hitscan
	projectile_type = /obj/projectile/beam/lasertag/redtag/hitscan

/obj/item/ammo_casing/energy/xray
	projectile_type = /obj/projectile/beam/xray
	e_cost = 500
	fire_sound = 'sound/weapons/laser3.ogg'

/obj/item/ammo_casing/energy/mindflayer
	projectile_type = /obj/projectile/beam/mindflayer
	select_name = "MINDFUCK"
	fire_sound = 'sound/weapons/laser.ogg'

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
	armour_penetration = -20
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

/obj/projectile/beam/hitscan/disabler/heavy
	damage = 30
	armour_penetration = -10


/obj/item/ammo_casing/energy/laser/minigun
	select_name = "kill"
	projectile_type = /obj/projectile/beam/weak/penetrator
	variance = 0.8
	delay = 0.5
	fire_sound = 'sound/weapons/laser4.ogg'
