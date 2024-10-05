/obj/projectile/bullet/slug
	name = "12g shotgun slug"
	damage = 40
	armour_penetration = -10
	speed = 0.5

/obj/projectile/bullet/slug/beanbag
	name = "beanbag slug"
	damage = 10
	stamina = 60
	armour_penetration = -45

/obj/projectile/bullet/incendiary/shotgun
	name = "incendiary slug"
	damage = 25
	armour_penetration = -10
	speed = 0.5

/obj/projectile/bullet/incendiary/shotgun/dragonsbreath
	name = "dragonsbreath pellet"
	damage = 8
	armour_penetration = -35

/obj/projectile/bullet/slug/stun
	name = "stunslug"
	damage = 5
	paralyze = 100
	stutter = 5
	jitter = 20
	range = 7
	icon_state = "spark"
	color = "#FFFF00"

/obj/projectile/bullet/slug/meteor
	name = "meteorslug"
	icon = 'icons/obj/meteor.dmi'
	icon_state = "dust"
	damage = 30
	paralyze = 15
	knockdown = 80
	hitsound = 'sound/effects/meteorimpact.ogg'

/obj/projectile/bullet/slug/meteor/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(ismovable(target))
		var/atom/movable/M = target
		var/atom/throw_target = get_edge_target_turf(M, get_dir(src, get_step_away(M, src)))
		M.safe_throw_at(throw_target, 3, 2)

/obj/projectile/bullet/slug/meteor/Initialize()
	. = ..()
	SpinAnimation()

/obj/projectile/bullet/slug/frag12
	name = "frag12 slug"
	damage = 25
	paralyze = 50

/obj/projectile/bullet/slug/frag12/on_hit(atom/target, blocked = FALSE)
	..()
	explosion(target, -1, 0, 1)
	return BULLET_ACT_HIT

/obj/projectile/bullet/pellet
	///How much damage is subtracted per tile?
	var/tile_dropoff = 1 //Standard of 10% per tile
	///How much stamina damage is subtracted per tile?
	var/tile_dropoff_stamina = 1.5 //As above

	icon_state = "pellet"
	armour_penetration = -35
	speed = 0.5

/obj/projectile/bullet/pellet/buckshot
	name = "buckshot pellet"
	damage = 13

/obj/projectile/bullet/pellet/rubbershot
	name = "rubbershot pellet"
	damage = 2.5
	tile_dropoff = 0.15
	stamina = 15
	armour_penetration = -70

/obj/projectile/bullet/pellet/rubbershot/incapacitate
	name = "incapacitating pellet"
	damage = 1
	tile_dropoff = 0.1
	stamina = 6
	tile_dropoff_stamina = 0.6

/obj/projectile/bullet/pellet/Range() //10% loss per tile = max range of 10, generally
	..()
	if(damage > 0)
		damage -= tile_dropoff
	if(stamina > 0)
		stamina -= tile_dropoff_stamina
	if(damage < 0 && stamina < 0)
		qdel(src)

/obj/projectile/bullet/pellet/improvised
	damage = 6
	armour_penetration = -35
	tile_dropoff = 0.6

// Mech Scattershot

/obj/projectile/bullet/scattershot
	damage = 24
	armour_penetration = -20

/obj/projectile/bullet/pellet/buckshot/twobore
	name = "two-bore pellet"
	damage = 30
	armour_penetration = -25
	tile_dropoff = 3

/obj/projectile/bullet/pellet/blank
	name = "blank"
	damage = 30
	range = 2
	armour_penetration = -70
