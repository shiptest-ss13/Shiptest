/obj/projectile/plasma
	name = "plasma blast"
	icon_state = "plasmacutter"
	damage_type = BURN
	damage = 15
	range = 4
	dismemberment = 10
	/// chance that the plasmablast ruins the ore
	var/slag_chance = 33
	impact_effect_type = /obj/effect/temp_visual/impact_effect/purple_laser
	tracer_type = /obj/effect/projectile/tracer/plasma_cutter
	muzzle_type = /obj/effect/projectile/muzzle/plasma_cutter
	impact_type = /obj/effect/projectile/impact/plasma_cutter

/obj/projectile/plasma/adv
	damage = 7
	range = 5
	slag_chance = 20

/obj/projectile/plasma/adv/mech
	damage = 10
	range = 9

/obj/projectile/plasma/turret
	//Between normal and advanced for damage, made a beam so not the turret does not destroy glass
	name = "plasma beam"
	damage = 24
	range = 7
	pass_flags = PASSTABLE | PASSGLASS | PASSGRILLE
