//.22lr (Himehabu, Micro Target, Pounder (uwu))

/obj/projectile/bullet/c22lr
	name = ".22LR bullet"
	damage = 20
	armour_penetration = -45
	ricochet_incidence_leeway = 20
	ricochet_chance = 65

/obj/projectile/bullet/c22lr/hp
	name = ".22LR bullet"
	damage = 30
	armour_penetration = -65
	ricochet_chance = 0
	speed = BULLET_HP_SPEED

/obj/projectile/bullet/c22lr/ap
	name = ".22LR bullet"
	damage = 15
	armour_penetration = -25
	ricochet_incidence_leeway = 20
	ricochet_chance = 30
	speed = BULLET_AP_SPEED

/obj/projectile/bullet/c22lr/rubber
	name = ".22LR rubber bullet"
	damage = 4
	stamina = 15
	armour_penetration = -70
	speed = BULLET_HV_SPEED
	ricochets_max = 8 //ding ding ding ding
	ricochet_incidence_leeway = 70
	ricochet_chance = 130
	ricochet_decay_damage = 0.8

// 9mm (Commander, SABR)

/obj/projectile/bullet/c9mm
	name = "9mm bullet"
	damage = 20
	armour_penetration = -20

/obj/projectile/bullet/c9mm/surplus
	name = "9mm surplus bullet"
	damage = 15
	speed = BULLET_SURPLUS_SPEED

/obj/projectile/bullet/c9mm/ap
	name = "9mm armor-piercing bullet"
	damage = 15
	armour_penetration = 20
	speed = BULLET_AP_SPEED

/obj/projectile/bullet/c9mm/hp
	name = "9mm hollow point bullet"
	damage = 35
	armour_penetration = -50
	speed = BULLET_HP_SPEED

/obj/projectile/bullet/c9mm/rubber
	name = "9mm rubber bullet"
	damage = 5
	armour_penetration = -40
	stamina = 30
	speed = BULLET_RUBBER_SPEED

// 10mm (Ringneck)

/obj/projectile/bullet/c10mm
	name = "10mm bullet"
	damage = 25
	armour_penetration = -20

/obj/projectile/bullet/c10mm/surplus
	name = "10mm surplus bullet"
	damage = 20
	speed = BULLET_SURPLUS_SPEED

/obj/projectile/bullet/c10mm/ap
	name = "10mm armor-piercing bullet"
	damage = 20
	armour_penetration = 20
	speed = BULLET_AP_SPEED

/obj/projectile/bullet/c10mm/hp
	name = "10mm hollow point bullet"
	damage = 40
	armour_penetration = -50
	speed = BULLET_HP_SPEED

/obj/projectile/bullet/c10mm/rubber
	name = "10mm rubber bullet"
	damage = 7
	stamina = 38
	armour_penetration = -40
	speed = BULLET_RUBBER_SPEED

// .45 (Candor, C20r)

/obj/projectile/bullet/c45
	name = ".45 bullet"
	damage = 25
	armour_penetration = -20

/obj/projectile/bullet/c45/surplus
	name = ".45 surplus bullet"
	damage = 20
	speed = BULLET_SURPLUS_SPEED

/obj/projectile/bullet/c45/ap
	name = ".45 armor-piercing bullet"
	damage = 20
	armour_penetration = 20
	speed = BULLET_AP_SPEED

/obj/projectile/bullet/c45/hp
	name = ".45 hollow point bullet"
	damage = 40
	armour_penetration = -50
	speed = BULLET_HP_SPEED

/obj/projectile/bullet/c45/rubber
	name = ".45 rubber bullet"
	damage = 7
	stamina = 38
	armour_penetration = -40
	speed = BULLET_RUBBER_SPEED
