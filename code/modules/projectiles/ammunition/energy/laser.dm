/obj/item/ammo_casing/energy/laser
	projectile_type = /obj/projectile/beam/laser
	select_name = "kill"

/obj/item/ammo_casing/energy/laser/sharplite
	projectile_type = /obj/projectile/beam/laser/sharplite
	select_name = "kill"
	e_cost = 555

/obj/item/ammo_casing/energy/laser/sharplite/efficent
	e_cost = 700  //9 per NT mini cell

/obj/item/ammo_casing/energy/laser/underbarrel
	projectile_type = /obj/projectile/beam/laser
	e_cost =  1250

/obj/item/ammo_casing/energy/laser/slug
	projectile_type = /obj/projectile/beam/laser/slug
	select_name = "slug"
	delay = 0.9 SECONDS
	fire_sound = 'sound/weapons/gun/laser/cs-fire.ogg'

/obj/item/ammo_casing/energy/laser/eoehoma
	projectile_type = /obj/projectile/beam/laser/eoehoma
	fire_sound = 'sound/weapons/gun/laser/e-fire.ogg'

/obj/projectile/beam/laser/eoehoma/hermit // Used for the Hermits with E-11 because apparently you can only set it on projectile for simple mobs? That's fun!
	spread = 30

/obj/item/ammo_casing/energy/laser/assault
	projectile_type = /obj/projectile/beam/laser/assault
	fire_sound = 'sound/weapons/gun/laser/e40_las.ogg'
	delay = 2
	e_cost = 666 //30 per upgraded cell, 14 per regular

/obj/item/ammo_casing/energy/laser/assault/sharplite
	projectile_type = /obj/projectile/beam/laser/assault/sharplite
	fire_sound = 'sound/weapons/gun/laser/e40_las.ogg'
	delay = 2

/obj/item/ammo_casing/energy/laser/eoehoma/e50
	projectile_type = /obj/projectile/beam/emitter/hitscan
	fire_sound = 'sound/weapons/gun/laser/heavy_laser.ogg'
	e_cost = 12500
	delay = 1 SECONDS

/obj/item/ammo_casing/energy/lasergun
	projectile_type = /obj/projectile/beam/laser
	e_cost = 555
	select_name = "kill"

/obj/item/ammo_casing/energy/lasergun/sharplite
	projectile_type = /obj/projectile/beam/laser/sharplite
	e_cost = 555
	select_name = "kill"

/obj/item/ammo_casing/energy/lasergun/sharplite/dmr
	projectile_type = /obj/projectile/beam/laser/sharplite/dmr
	e_cost = 1000 // 10 per regular cell  20 per upgraded cell
	select_name = "kill"

/obj/item/ammo_casing/energy/lasergun/sharplite/sniper
	projectile_type = /obj/projectile/beam/laser/sharplite/sniper
	fire_sound = 'sound/weapons/gun/laser/heavy_laser.ogg'
	delay = 1.3 SECONDS
	e_cost = 2000 // 5 per regular cell 10 per upgraded cell
	select_name = "kill"

/obj/item/ammo_casing/energy/lasergun/eoehoma
	projectile_type = /obj/projectile/beam/laser/eoehoma
	fire_sound = 'sound/weapons/gun/laser/e40_las.ogg'
	e_cost = 1428
	delay = 0.3 SECONDS

/obj/item/ammo_casing/energy/lasergun/eoehoma/wasp
	projectile_type = /obj/projectile/beam/laser/eoehoma/wasp
	fire_sound = 'sound/weapons/laser4.ogg'
	e_cost = 799
	delay = 0.1 SECONDS

/obj/item/ammo_casing/energy/lasergun/eoehoma/heavy
	projectile_type = /obj/projectile/beam/laser/eoehoma/heavy
	fire_sound = 'sound/weapons/gun/laser/heavy_laser.ogg'
	e_cost = 10000
	select_name = "overcharge"
	delay = 1 SECONDS

/obj/item/ammo_casing/energy/laser/smg
	projectile_type = /obj/projectile/beam/laser/weak
	e_cost = 799 //12 shots with a normal power cell, 25 with an upgraded
	select_name = "kill"
	delay = 0.13 SECONDS

/obj/item/ammo_casing/energy/laser/sharplite/smg
	projectile_type = /obj/projectile/beam/weak/sharplite
	e_cost = 500 //20 shots with a normal power cell, 40 with an upgraded
	select_name = "kill"
	delay = 0.13 SECONDS
	fire_sound = 'sound/weapons/gun/laser/nt-fire_light.ogg'

/obj/item/ammo_casing/energy/lasergun/old
	projectile_type = /obj/projectile/beam/laser
	e_cost = 2000
	select_name = "kill"

/obj/item/ammo_casing/energy/laser/sharplite/hos
	e_cost = 500

/obj/item/ammo_casing/energy/laser/practice
	projectile_type = /obj/projectile/beam/practice
	select_name = "practice"
	harmful = FALSE

/obj/item/ammo_casing/energy/laser/practice/sharplite
	projectile_type = /obj/projectile/beam/practice/sharplite
	select_name = "practice"
	harmful = FALSE

/obj/item/ammo_casing/energy/laser/scatter
	projectile_type = /obj/projectile/beam/scatter
	pellets = 10
	variance = 40
	e_cost = 1598 //12 shots upgraded cell, 6 with normal cell
	select_name = "scatter"

/obj/item/ammo_casing/energy/laser/shotgun
	projectile_type = /obj/projectile/beam/weak/shotgun
	pellets = 3
	variance = 25
	e_cost = 1000
	select_name = "kill"

/obj/item/ammo_casing/energy/laser/shotgun/sharplite
	projectile_type = /obj/projectile/beam/weak/shotgun/sharplite

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
	e_cost = 666

/obj/projectile/beam/hitscan/disabler
	name = "disabler beam"
	icon_state = "omnilaser"
	hitscan = TRUE
	range = 12
	damage = 20
	armour_penetration = -20
	damage_type = STAMINA
	flag = "energy"
	bullet_identifier = "disabler"
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

/obj/item/ammo_casing/energy/disabler/hitscan/heavy
	projectile_type = /obj/projectile/beam/hitscan/disabler/heavy
	e_cost = 1000

/obj/projectile/beam/hitscan/disabler/heavy
	range = 15
	damage = 30
	armour_penetration = -10


/obj/item/ammo_casing/energy/laser/minigun
	select_name = "kill"
	projectile_type = /obj/projectile/beam/weak/penetrator
	variance = 0.8
	delay = 0.5
	fire_sound = 'sound/weapons/laser4.ogg'
