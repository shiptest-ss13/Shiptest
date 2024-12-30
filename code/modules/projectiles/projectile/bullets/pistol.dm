//.22lr (Himehabu, Micro Target, Pounder (uwu))

/obj/projectile/bullet/c22lr
	name = ".22LR bullet"
	damage = 18
	armour_penetration = -45
	ricochet_incidence_leeway = 20
	ricochet_chance = 65
	speed = BULLET_SPEED_HANDGUN

/obj/projectile/bullet/c22lr/hp
	name = ".22LR bullet"
	damage = 24
	armour_penetration = -65
	ricochet_chance = 0
	speed_mod = BULLET_SPEED_HP_MOD

/obj/projectile/bullet/c22lr/ap
	name = ".22LR armor piercing bullet"
	damage = 14
	armour_penetration = -25
	ricochet_incidence_leeway = 20
	ricochet_chance = 30
	speed_mod = BULLET_SPEED_AP_MOD

/obj/projectile/bullet/c22lr/rubber
	name = ".22LR rubber bullet"
	damage = 4
	stamina = 15
	armour_penetration = -70
	speed_mod = BULLET_SPEED_HV_MOD //do not do this for other rubber bullets. If you do I will come out of the woodwork and bludgeon you to death with this stick i found.
	ricochets_max = 8 //ding ding ding ding
	ricochet_incidence_leeway = 70
	ricochet_chance = 130
	ricochet_decay_damage = 0.8

// 9mm (Commander, SABR)

/obj/projectile/bullet/c9mm
	name = "9mm bullet"
	damage = 20
	armour_penetration = -20
	speed = BULLET_SPEED_HANDGUN

/obj/projectile/bullet/c9mm/surplus
	name = "9mm surplus bullet"
	damage = 15
	speed_mod = BULLET_SPEED_SURPLUS_MOD

/obj/projectile/bullet/c9mm/ap
	name = "9mm armor-piercing bullet"
	damage = 15
	armour_penetration = 20
	speed_mod = BULLET_SPEED_AP_MOD

/obj/projectile/bullet/c9mm/hp
	name = "9mm hollow point bullet"
	damage = 35
	armour_penetration = -50
	speed_mod = BULLET_SPEED_HP_MOD

/obj/projectile/bullet/c9mm/rubber
	name = "9mm rubber bullet"
	damage = 5
	armour_penetration = -40
	stamina = 30
	speed_mod = BULLET_SPEED_RUBBER_MOD

// 10mm (Ringneck)

/obj/projectile/bullet/c10mm
	name = "10mm bullet"
	damage = 25
	armour_penetration = -20
	speed = BULLET_SPEED_HANDGUN

/obj/projectile/bullet/c10mm/surplus
	name = "10mm surplus bullet"
	damage = 20
	speed_mod = BULLET_SPEED_SURPLUS_MOD

/obj/projectile/bullet/c10mm/ap
	name = "10mm armor-piercing bullet"
	damage = 20
	armour_penetration = 20
	speed_mod = BULLET_SPEED_AP_MOD

/obj/projectile/bullet/c10mm/hp
	name = "10mm hollow point bullet"
	damage = 40
	armour_penetration = -50
	speed_mod = BULLET_SPEED_HP_MOD

/obj/projectile/bullet/c10mm/rubber
	name = "10mm rubber bullet"
	damage = 7
	stamina = 38
	armour_penetration = -40
	speed_mod = BULLET_SPEED_RUBBER_MOD

// .45 (Candor, C20r)

/obj/projectile/bullet/c45
	name = ".45 bullet"
	damage = 25
	armour_penetration = -20
	speed = BULLET_SPEED_HANDGUN

/obj/projectile/bullet/c45/surplus
	name = ".45 surplus bullet"
	damage = 20
	speed_mod = BULLET_SPEED_SURPLUS_MOD

/obj/projectile/bullet/c45/ap
	name = ".45 armor-piercing bullet"
	damage = 20
	armour_penetration = 20
	speed_mod = BULLET_SPEED_AP_MOD

/obj/projectile/bullet/c45/hp
	name = ".45 hollow point bullet"
	damage = 40
	armour_penetration = -50
	speed_mod = BULLET_SPEED_HP_MOD

/obj/projectile/bullet/c45/rubber
	name = ".45 rubber bullet"
	damage = 7
	stamina = 38
	armour_penetration = -40
	speed_mod = BULLET_SPEED_RUBBER_MOD

// .50 AE (Desert Eagle)

/obj/projectile/bullet/a50AE
	name = ".50 AE bullet"
	damage = 40
	speed = BULLET_SPEED_HANDGUN

/obj/projectile/bullet/a50AE/hp
	name = ".50 AE hollow point bullet"
	damage = 55
	armour_penetration = -20
	speed_mod = BULLET_SPEED_HP_MOD
