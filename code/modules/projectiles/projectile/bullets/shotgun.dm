/obj/projectile/bullet/shotgun_slug
	name = "12g shotgun slug"
	damage = 45					// Wasp Edit - Shotgun Nerf

/obj/projectile/bullet/shotgun_beanbag
	name = "beanbag slug"
	damage = 5
	stamina = 45					// Wasp Edit - Shotgun Nerf
	armour_penetration = -10		// Wasp Edit - Shotgun Nerf

/obj/projectile/bullet/incendiary/shotgun
	name = "incendiary slug"
	damage = 20

/obj/projectile/bullet/incendiary/shotgun/dragonsbreath
	name = "dragonsbreath pellet"
	damage = 5

/obj/projectile/bullet/shotgun_stunslug
	name = "stunslug"
	damage = 5
	paralyze = 100
	stutter = 5
	jitter = 20
	range = 7
	icon_state = "spark"
	color = "#FFFF00"

/obj/projectile/bullet/shotgun_meteorslug
	name = "meteorslug"
	icon = 'icons/obj/meteor.dmi'
	icon_state = "dust"
	damage = 30
	paralyze = 15
	knockdown = 80
	hitsound = 'sound/effects/meteorimpact.ogg'

/obj/projectile/bullet/shotgun_meteorslug/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(ismovable(target))
		var/atom/movable/M = target
		var/atom/throw_target = get_edge_target_turf(M, get_dir(src, get_step_away(M, src)))
		M.safe_throw_at(throw_target, 3, 2)

/obj/projectile/bullet/shotgun_meteorslug/Initialize()
	. = ..()
	SpinAnimation()

/obj/projectile/bullet/shotgun_frag12
	name ="frag12 slug"
	damage = 25
	paralyze = 50

/obj/projectile/bullet/shotgun_frag12/on_hit(atom/target, blocked = FALSE)
	..()
	explosion(target, -1, 0, 1)
	return BULLET_ACT_HIT

/obj/projectile/bullet/pellet
	var/tile_dropoff = 1		// Wasp Edit - Shotgun Nerf
	var/tile_dropoff_s = 0.8		// Wasp Edit - Shotgun Nerf

/obj/projectile/bullet/pellet/shotgun_buckshot
	name = "buckshot pellet"
	damage = 10						// Wasp Edit - Shotgun Nerf
	armour_penetration = -20		// Wasp Edit - Shotgun Nerf

/obj/projectile/bullet/pellet/shotgun_rubbershot
	name = "rubbershot pellet"
	damage = 2						// Wasp Edit Begin - Shotgun Nerf
	stamina = 8
	armour_penetration = -20
	tile_dropoff = 0.2			// Keep it at 10% per tile	// Wasp Edit End

/obj/projectile/bullet/pellet/shotgun_incapacitate
	name = "incapacitating pellet"
	damage = 1
	stamina = 6

/obj/projectile/bullet/pellet/Range()
	..()
	if(damage > 0)
		damage -= tile_dropoff
	if(stamina > 0)
		stamina -= tile_dropoff_s
	if(damage < 0 && stamina < 0)
		qdel(src)

/obj/projectile/bullet/pellet/shotgun_improvised
	tile_dropoff = 0.45		//Come on it does 4.5 damage don't be like that.		// Wasp Edit - Shotgun nerf
	damage = 4.5			// Wasp Edit - Shotgun nerf
	armour_penetration = -20		// Wasp Edit - Shotgun nerf

/obj/projectile/bullet/pellet/shotgun_improvised/Initialize()
	. = ..()
	range = rand(1, 8)

/obj/projectile/bullet/pellet/shotgun_improvised/on_range()
	do_sparks(1, TRUE, src)
	..()

// Mech Scattershot

/obj/projectile/bullet/scattershot
	damage = 24
