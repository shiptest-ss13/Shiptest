// 9mm (Stechkin APS)

/obj/projectile/bullet/c9mm
	name = "9mm bullet"
	damage = 20
	embedding = list(embed_chance=15, fall_chance=3, jostle_chance=4, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.4, pain_mult=5, jostle_pain_mult=6, rip_time=10)

/obj/projectile/bullet/c9mm_ap
	name = "9mm armor-piercing bullet"
	damage = 15
	armour_penetration = 40
	embedding = null

/obj/projectile/bullet/incendiary/c9mm
	name = "9mm incendiary bullet"
	damage = 10
	fire_stacks = 1

/obj/projectile/bullet/c9mm/rubbershot
	name = "9mm rubber bullet"
	damage = 5
	stamina = 20

// 10mm (Stechkin)

/obj/projectile/bullet/c10mm
	name = "10mm bullet"
	damage = 30

/obj/projectile/bullet/c10mm_ap
	name = "10mm armor-piercing bullet"
	damage = 27
	armour_penetration = 40

/obj/projectile/bullet/c10mm_hp
	name = "10mm hollow-point bullet"
	damage = 40
	armour_penetration = -50

/obj/projectile/bullet/incendiary/c10mm
	name = "10mm incendiary bullet"
	damage = 15
	fire_stacks = 2
