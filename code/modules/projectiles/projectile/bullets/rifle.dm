// 5.56x42mm CLIP (CM82, Hydra variants)

/obj/projectile/bullet/a556_42
	name = "5.56x42mm CLIP bullet"
	damage = 25
	armour_penetration = 20
	speed = BULLET_SPEED_RIFLE

/obj/projectile/bullet/a556_42/hp
	name = "5.56x42mm CLIP hollow point bullet"
	damage = 35
	armour_penetration = 0
	speed_mod = BULLET_SPEED_HP_MOD

/obj/projectile/bullet/a556_42/ap
	name = "5.56x42mm CLIP bullet"
	damage = 20
	armour_penetration = 40
	speed_mod = BULLET_SPEED_AP_MOD

/obj/projectile/bullet/a556_42/rubber
	name = "5.56x42mm CLIP bullet"
	damage = 5
	stamina = 25
	armour_penetration = 0
	speed_mod = BULLET_SPEED_RUBBER_MOD

// 8x50mmR (Illestren Rifle)

/obj/projectile/bullet/a8_50r
	name = "8x50mmR bullet"
	damage = 35
	armour_penetration = 40
	speed = BULLET_SPEED_RIFLE

/obj/projectile/bullet/a8_50r/hp
	name = "8x50mmR hollow point bullet"
	damage = 49
	armour_penetration = 0
	speed_mod = BULLET_SPEED_HP_MOD

/obj/projectile/bullet/a8_50r/match
	name = "8x50mmR match bullet"
	damage = 40
	armour_penetration = -10
	speed_mod = BULLET_SPEED_AP_MOD
	ricochets_max = 4
	ricochet_chance = 80
	ricochet_auto_aim_angle = 40
	ricochet_auto_aim_range = 5
	ricochet_incidence_leeway = 50
	ricochet_decay_chance = 1
	ricochet_decay_damage = 1

/obj/projectile/bullet/a8_50r/trac
	damage = 10
	armour_penetration = 0
	shrapnel_type = /obj/item/shrapnel/bullet/tracker/a8_50r

//7.62x40mm CLIP (SKM Rifles)

/obj/projectile/bullet/a762_40
	name = "7.62x40mm CLIP bullet"
	damage = 30
	armour_penetration = 20
	speed = BULLET_SPEED_RIFLE

/obj/projectile/bullet/a762_40/hp
	name = "7.62x40mm CLIP hollow point bullet"
	damage = 40
	armour_penetration = 0
	speed_mod = BULLET_SPEED_HP_MOD

/obj/projectile/bullet/a762_40/ap
	name = "7.62x40mm CLIP armor piercing bullet"
	damage = 25
	armour_penetration = 40
	speed_mod = BULLET_SPEED_AP_MOD

/obj/projectile/bullet/a762_40/rubber //"rubber"
	name = "7.62x40mm CLIP rubber bullet"
	damage = 15
	stamina = 40
	armour_penetration = 0
	speed_mod = BULLET_SPEED_RUBBER_MOD

//.308 WIN (M514 & GAL DMRs)

/obj/projectile/bullet/a308
	name = ".308 bullet"
	speed = 0.3
	damage = 30
	armour_penetration = 40
	speed = BULLET_SPEED_RIFLE

/obj/projectile/bullet/a308/hp
	name = ".308 hollow point bullet"
	damage = 40
	armour_penetration = 10
	speed_mod = BULLET_SPEED_HP_MOD

/obj/projectile/bullet/a308/ap
	name = ".308 armor piercing bullet"
	damage = 25
	armour_penetration = 60
	speed_mod = BULLET_SPEED_AP_MOD

/obj/projectile/bullet/a308/rubber //"rubber"
	name = ".308 rubber bullet"
	speed = 0.3
	damage = 25
	stamina = 50
	armour_penetration = 40
	speed_mod = BULLET_SPEED_RUBBER_MOD

// .299 Eoehoma Caseless (E-40)

/obj/projectile/bullet/c299
	name = ".299 Eoehoma caseless bullet"
	damage = 20
	armour_penetration = 10
	speed = BULLET_SPEED_RIFLE
