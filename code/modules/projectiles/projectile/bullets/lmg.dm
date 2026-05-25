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
	jitter = 30 SECONDS
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
		M.ignite_mob()

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
	icon_state = "sabot"
	projectile_piercing = NONE // Piercing was requested to be disabled
	projectile_phasing = NONE
	var/anti_armour_damage = 50
	ricochet_chance = 0 // Superheated tungsten rod - I'd like to imagine it's impossible for it to ricochet
	speed = 0.1 // Railgun, go ludicrously fast to make up for lost piercing

/obj/projectile/bullet/p50/penetrator/sabot/on_hit(atom/target, blocked = FALSE)
	..()
	if(ismecha(target))
		var/obj/mecha/M = target
		M.take_damage(anti_armour_damage)
		// Mechs take extra damage
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
