// 5.56x42mm CLIP (CM82, Hydra variants)

/obj/projectile/bullet/a556_42
	name = "5.56x42mm CLIP bullet"
	damage = 25
	armour_penetration = 20

/obj/projectile/bullet/a556_42/hp
	name = "5.56x42mm CLIP bullet"
	damage = 35
	armour_penetration = 0
	speed = BULLET_HP_SPEED

/obj/projectile/bullet/a556_42/ap
	name = "5.56x42mm CLIP bullet"
	damage = 20
	armour_penetration = 40
	speed = BULLET_AP_SPEED

/obj/projectile/bullet/a556_42/rubber
	name = "5.56x42mm CLIP bullet"
	damage = 5
	stamina = 25
	armour_penetration = 0
	speed = BULLET_RUBBER_SPEED

// 8x50mmR (Illestren Rifle)

/obj/projectile/bullet/a8_50r
	name = "8x50mmR bullet"
	damage = 35
	armour_penetration = 40

/obj/projectile/bullet/a8_50r/hp
	damage = 49
	armour_penetration = 0
	speed = BULLET_HP_SPEED

/obj/projectile/bullet/a8_50r/match
	damage = 40
	armour_penetration = -10
	speed = BULLET_SNIPER_SPEED
	ricochets_max = 4
	ricochet_chance = 80
	ricochet_auto_aim_angle = 40
	ricochet_auto_aim_range = 5
	ricochet_incidence_leeway = 50
	ricochet_decay_chance = 1
	ricochet_decay_damage = 1

// .300 Magnum

/obj/projectile/bullet/a300
	name = ".300 Magnum bullet"
	damage = 45
	stamina = 10
	armour_penetration = 40

/obj/projectile/bullet/a300/hp
	name = ".300 Magnum bullet"
	speed = BULLET_HP_SPEED
	damage = 55
	armour_penetration = 0

/obj/projectile/bullet/a300/ap
	name = ".300 Magnum bullet"
	speed = BULLET_AP_SPEED
	damage = 40
	armour_penetration = 60

//5.45x39mm (SVG-76u)

/obj/projectile/bullet/a545_39
	name = "5.45x39mm bullet"
	damage = 25
	armour_penetration = 20

//7.62x40mm CLIP (SKM Rifles)

/obj/projectile/bullet/a762_40
	name = "7.62x40mm CLIP"
	damage = 30
	armour_penetration = 20

/obj/projectile/bullet/a762_40/hp
	damage = 40
	armour_penetration = 0
	speed = BULLET_HP_SPEED

/obj/projectile/bullet/a762_40/ap
	damage = 25
	armour_penetration = 40
	speed = BULLET_AP_SPEED

/obj/projectile/bullet/a762_40/rubber //"rubber"
	name = "7.62x40mm CLIP Rubber"
	damage = 15
	stamina = 40
	armour_penetration = 0
	speed = BULLET_RUBBER_SPEED

//.308 WIN (M514 & GAL DMRs)

/obj/projectile/bullet/a308
	name = ".308"
	speed = 0.3
	damage = 30
	armour_penetration = 40

/obj/projectile/bullet/a308/hp
	damage = 40
	armour_penetration = 10
	speed = BULLET_HP_SPEED

/obj/projectile/bullet/a308/ap
	damage = 25
	armour_penetration = 60
	speed = BULLET_AP_SPEED

/obj/projectile/bullet/a308/rubber //"rubber"
	name = ".308 Rubber"
	speed = 0.3
	damage = 25
	stamina = 50
	armour_penetration = 40
	speed = BULLET_RUBBER_SPEED

// 8x58mm caseless (SG-669)

/obj/projectile/bullet/a858
	name = "8x58mm caseless bullet"
	speed = BULLET_HV_SPEED
	damage = 35
	armour_penetration = 40

/obj/projectile/bullet/a858/trac
	name = "8x58mm tracker"
	speed = BULLET_HV_SPEED
	damage = 12
	armour_penetration = 0
	shrapnel_type =

// .299 Eoehoma Caseless (E-40)

/obj/projectile/bullet/c299
	name = ".299 Eoehoma caseless bullet"
	damage = 20
	armour_penetration = 10

//6.5x57mm CLIP (F90)

/obj/projectile/bullet/a65clip
	name = "6.5x57mm CLIP bullet"
	speed = 0.3
	stamina = 10
	damage = 40
	armour_penetration = 50

	icon_state = "redtrac"
	light_system = MOVABLE_LIGHT
	light_color = COLOR_SOFT_RED
	light_range = 2

/obj/projectile/bullet/a65clip/rubber //"rubber"
	name = "6.5x57mm CLIP rubber bullet"
	damage = 10
	stamina = 40
