//.22lr (Himehabu, Micro Target, Pounder (uwu))

/obj/projectile/bullet/c22lr
	name = ".22LR bullet"
	damage = 20
	armour_penetration = -40
	ricochet_incidence_leeway = 20
	ricochet_chance = 65
	speed = BULLET_SPEED_HANDGUN
	bullet_identifier = "tiny bullet"

/obj/projectile/bullet/c22lr/hp
	name = ".22LR HP bullet"
	damage = 24
	armour_penetration = -50
	ricochet_chance = 0
	speed_mod = BULLET_SPEED_HP_MOD

/obj/projectile/bullet/c22lr/ap
	name = ".22LR armor piercing bullet"
	damage = 18
	armour_penetration = -20
	ricochet_incidence_leeway = 20
	ricochet_chance = 30
	speed_mod = BULLET_SPEED_AP_MOD

/obj/projectile/bullet/c22lr/rubber
	name = ".22LR rubber bullet"
	damage = 4
	stamina = 15
	armour_penetration = -50
	speed_mod = BULLET_SPEED_HV_MOD //do not do this for other rubber bullets. If you do I will come out of the woodwork and bludgeon you to death with this stick i found.
	ricochets_max = 8 //ding ding ding ding
	ricochet_incidence_leeway = 70
	ricochet_chance = 130
	ricochet_decay_damage = 0.8
	bullet_identifier = "tiny rubber bullet"

// 9x18mm (Commander, SABR)

/obj/projectile/bullet/c9mm
	name = "9x18mm bullet"
	damage = 20
	armour_penetration = -20
	embedding = list(embed_chance=15, fall_chance=3, jostle_chance=4, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.4, pain_mult=5, jostle_pain_mult=6, rip_time=10)
	speed = BULLET_SPEED_HANDGUN
	bullet_identifier = "small bullet"

/obj/projectile/bullet/c9mm/surplus
	name = "9x18mm surplus bullet"
	speed_mod = BULLET_SPEED_SURPLUS_MOD

/obj/projectile/bullet/c9mm/ap
	name = "9x18mm armor-piercing bullet"
	damage = 18
	armour_penetration = 10
	speed_mod = BULLET_SPEED_AP_MOD

/obj/projectile/bullet/c9mm/hp
	name = "9x18mm hollow point bullet"
	damage = 30
	armour_penetration = -30
	speed_mod = BULLET_SPEED_HP_MOD

/obj/projectile/bullet/c9mm/rubber
	name = "9x18mm rubber bullet"
	damage = 5
	armour_penetration = -40
	stamina = 30
	speed_mod = BULLET_SPEED_RUBBER_MOD
	bullet_identifier = "small rubber bullet"

// 10x22mm (Ringneck)

/obj/projectile/bullet/c10mm
	name = "10x22mm bullet"
	damage = 25
	armour_penetration = -20
	speed = BULLET_SPEED_HANDGUN
	bullet_identifier = "small bullet"

/obj/projectile/bullet/c10mm/surplus
	name = "10x22mm surplus bullet"
	speed_mod = BULLET_SPEED_SURPLUS_MOD

/obj/projectile/bullet/c10mm/ap
	name = "10x22mm armor-piercing bullet"
	damage = 23
	armour_penetration = 10
	speed_mod = BULLET_SPEED_AP_MOD

/obj/projectile/bullet/c10mm/hp
	name = "10x22mm hollow point bullet"
	damage = 35
	armour_penetration = -30
	speed_mod = BULLET_SPEED_HP_MOD

/obj/projectile/bullet/c10mm/rubber
	name = "10x22mm rubber bullet"
	damage = 7
	stamina = 35
	armour_penetration = -30
	speed_mod = BULLET_SPEED_RUBBER_MOD
	bullet_identifier = "small rubber bullet"

// .45 (Candor, C20r)

/obj/projectile/bullet/c45
	name = ".45 bullet"
	damage = 25
	armour_penetration = -20
	speed = BULLET_SPEED_HANDGUN
	bullet_identifier = "small bullet"

/obj/projectile/bullet/c45/surplus
	name = ".45 surplus bullet"
	speed_mod = BULLET_SPEED_SURPLUS_MOD

/obj/projectile/bullet/c45/ap
	name = ".45 armor-piercing bullet"
	damage = 22
	armour_penetration = 10
	speed_mod = BULLET_SPEED_AP_MOD

/obj/projectile/bullet/c45/hp
	name = ".45 hollow point bullet"
	damage = 37
	armour_penetration = -30
	speed_mod = BULLET_SPEED_HP_MOD

/obj/projectile/bullet/c45/rubber
	name = ".45 rubber bullet"
	damage = 7
	stamina = 37
	armour_penetration = -30
	speed_mod = BULLET_SPEED_RUBBER_MOD
	bullet_identifier = "small rubber bullet"
