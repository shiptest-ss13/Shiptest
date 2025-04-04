// C3D (Borgs)

/obj/projectile/bullet/c3d
	damage = 20

/obj/projectile/bullet/ctac
	damage = 40
	armour_penetration = 35
	speed = 0.4

/obj/projectile/bullet/csour
	damage = 0
	stamina = 60
	jitter = 30
	stutter = 10
	slur = 10
	knockdown = 5
	armour_penetration = 30

/obj/projectile/bullet/csweet
	damage = 5
	irradiate = 250
	speed = 1.2

/obj/projectile/bullet/csweet/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		M.adjust_fire_stacks(8)
		M.IgniteMob()

// Mech LMG

/obj/projectile/bullet/lmg
	damage = 25
	armour_penetration = 40

// Mech FNX-99

/obj/projectile/bullet/incendiary/fnx99
	damage = 25

// Mech Railgun

/obj/projectile/bullet/p50/penetrator/sabot
	name = "Iron-tungsten rod"
	icon_state = "redtrac"
	projectile_piercing = ALL // Intended to deal damage to EVERYTHING it pierces through, doesn't seem to pierce properly through specific objects
	projectile_phasing = NONE// Might need adjusting to allow it to pierce things such as computers and what not, uncertain though
	var/anti_armour_damage = 50
	ricochet_chance = 0 // Superheated tungsten rod - I'd like to imagine it's impossible for it to ricochet
	speed = 0.4 // Railgun, go fast
/obj/projectile/bullet/p50/penetrator/sabot/on_hit(atom/target, blocked = FALSE)
	..()
	if(pierces >= 3)
		qdel_self
	if(ismecha(target))
		var/obj/mecha/M = target
		M.take_damage(anti_armour_damage)
	if(issilicon(target))
		var/mob/living/silicon/S = target
		S.take_overall_damage(anti_armour_damage*0.5, anti_armour_damage*0.5)
	return BULLET_ACT_HIT

// Turrets

/obj/projectile/bullet/manned_turret
	damage = 30
	armour_penetration = 40

/obj/projectile/bullet/manned_turret/hmg
	icon_state = "redtrac"
	armour_penetration = 40

/obj/projectile/bullet/syndicate_turret
	damage = 20
	armour_penetration = 20

// 7.12x82mm (L6 SAW)

/obj/projectile/bullet/mm712x82
	name = "7.12x82mm bullet"
	damage = 25
	armour_penetration = 40
	speed = BULLET_SPEED_RIFLE
	bullet_identifier = "large bullet"

/obj/projectile/bullet/mm712x82/ap
	name = "7.12x82mm armor-piercing bullet"
	armour_penetration = 75
	speed_mod = BULLET_SPEED_AP_MOD

/obj/projectile/bullet/mm712x82/hp
	name = "7.12x82mm hollow point bullet"
	damage = 40
	armour_penetration = -20
	speed_mod = BULLET_SPEED_HP_MOD

/obj/projectile/bullet/mm712x82/match
	name = "7.12x82mm match bullet"
	armour_penetration = 50
	ricochets_max = 2
	ricochet_chance = 60
	ricochet_auto_aim_range = 4
	ricochet_incidence_leeway = 35
	speed_mod = BULLET_SPEED_HP_MOD
