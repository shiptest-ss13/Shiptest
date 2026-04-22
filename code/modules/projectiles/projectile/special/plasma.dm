/obj/projectile/plasma
	name = "plasma blast"
	icon_state = "plasmacutter"
	damage_type = BURN
	damage = 25
	armour_penetration = -20
	range = 4
	dismemberment = 10
	wall_damage_flags = PROJECTILE_BONUS_DAMAGE_MINERALS | PROJECTILE_BONUS_DAMAGE_WALLS | PROJECTILE_BONUS_DAMAGE_RWALLS
	wall_damage_override = 150
	impact_effect_type = /obj/effect/temp_visual/impact_effect/purple_laser
	tracer_type = /obj/effect/projectile/tracer/plasma_cutter
	muzzle_type = /obj/effect/projectile/muzzle/plasma_cutter
	impact_type = /obj/effect/projectile/impact/plasma_cutter
	hitscan = TRUE

/obj/projectile/plasma/on_hit(atom/target, blocked = 0)
	if(isobj(target) && (blocked != 100))
		var/obj/O = target
		O.take_damage(80, BRUTE, "bullet", FALSE)
	return ..()

/obj/projectile/plasma/adv
	damage = 30
	range = 5

/obj/projectile/plasma/adv/mech
	damage = 10
	range = 9
