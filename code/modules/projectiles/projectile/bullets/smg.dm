// 5.7x39mm (Asp and Sidewinder)

/obj/projectile/bullet/c57x39mm
	name = "5.7x39mm bullet"
	damage = 20
	speed = BULLET_SPEED_PDW
	armour_penetration = 10
	bullet_identifier = "small bullet"

/obj/projectile/bullet/c57x39mm/hp
	name = "5.7x39mm hollow point bullet"
	damage = 30
	armour_penetration = -10
	speed_mod = BULLET_SPEED_HP_MOD

/obj/projectile/bullet/c57x39mm/ap
	name = "5.7x39mm armor piercing bullet"
	damage = 19
	armour_penetration = 30
	speed_mod = BULLET_SPEED_AP_MOD

/obj/projectile/bullet/c57x39mm/rubber
	name = "5.7x39mm rubber bullet"
	damage = 5
	stamina = 20
	speed_mod = BULLET_SPEED_RUBBER_MOD
	bullet_identifier = "small rubber bullet"

// 4.6x30mm (WT-550 Automatic Rifle & NT-SVG)

/obj/projectile/bullet/c46x30mm
	name = "4.6x30mm bullet"
	damage = 20
	speed = BULLET_SPEED_PDW
	armour_penetration = 10
	wound_bonus = -5
	bare_wound_bonus = 5
	embed_falloff_tile = -4
	bullet_identifier = "small bullet"

/obj/projectile/bullet/c46x30mm/recycled
	damage = 15
	speed_mod = BULLET_SPEED_SURPLUS_MOD

/obj/projectile/bullet/c46x30mm/ap
	name = "4.6x30mm armor-piercing bullet"
	damage = 18
	armour_penetration = 40
	speed_mod = BULLET_SPEED_AP_MOD

/obj/projectile/bullet/c46x30mm/hp
	name = "4.6x30mm HP bullet"
	damage = 30
	armour_penetration = -10
	speed_mod = BULLET_SPEED_HP_MOD

/obj/projectile/bullet/c46x30mm/rubber
	name = "4.6x30mm bullet"
	damage = 4
	stamina = 20
	armour_penetration = -10
	speed_mod = BULLET_SPEED_RUBBER_MOD
	bullet_identifier = "small rubber bullet"

// 4.73x33mm caseless (Solar)

/obj/projectile/bullet/c47x33mm
	name = "4.73x33mm bullet"
	damage = 25
	armour_penetration = 20
	bullet_identifier = "small bullet"

// 5.56 HITP caseless (Solare C)

/obj/projectile/bullet/c556mm
	name = "5.56mm HITP bullet"
	damage = 20
	bullet_identifier = "small bullet"

/obj/projectile/bullet/c556mm/surplus
	name = "5.56mm HITP surplus bullet"
	speed_mod = BULLET_SPEED_SURPLUS_MOD

/obj/projectile/bullet/c556mm/ap
	name = "5.56mm HITP AP bullet"
	damage = 19
	armour_penetration = 20
	speed_mod = BULLET_SPEED_AP_MOD

/obj/projectile/bullet/c556mm/hp
	name = "5.56mm HITP hollow point bullet"
	damage = 30
	armour_penetration = -10
	speed_mod = BULLET_SPEED_HP_MOD

/obj/projectile/bullet/c556mm/rubber
	name = "5.56mm HITP rubber bullet"
	damage = 5
	stamina = 30
	armour_penetration = -10
	speed_mod = BULLET_SPEED_RUBBER_MOD
	bullet_identifier = "small rubber bullet"
