// .38 (Colt Detective Special & Winchester)

/obj/projectile/bullet/c38
	name = ".38 bullet"
	damage = 20
	armour_penetration = -20
	speed = BULLET_SPEED_REVOLVER
	bullet_identifier = "small bullet"

/obj/projectile/bullet/c38/surplus
	speed_mod = BULLET_SPEED_SURPLUS_MOD

/obj/projectile/bullet/c38/match
	name = ".38 match bullet"
	armour_penetration = -10
	speed_mod = BULLET_SPEED_AP_MOD

	wound_bonus = -20
	bare_wound_bonus = 10
	embedding = list(embed_chance=15, fall_chance=2, jostle_chance=2, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.4, pain_mult=3, jostle_pain_mult=5, rip_time=10)

	ricochets_max = 4
	ricochet_chance = 100
	ricochet_auto_aim_angle = 40
	ricochet_auto_aim_range = 5
	ricochet_incidence_leeway = 50
	ricochet_decay_chance = 1
	ricochet_decay_damage = 1

/obj/projectile/bullet/c38/bouncy
	name = ".38 rubber bullet"
	damage = 7
	stamina = 28
	armour_penetration = -60
	speed_mod = BULLET_SPEED_RUBBER_MOD
	ricochets_max = 6
	ricochet_incidence_leeway = 70
	ricochet_chance = 130
	ricochet_decay_damage = 0.8
	bullet_identifier = "small rubber bullet"

/obj/projectile/bullet/c38/dumdum
	name = ".38 prism bullet"
	damage = 20
	armour_penetration = -30
	ricochets_max = 0
	shrapnel_type = /obj/item/shrapnel/bullet/c38/dumdum

/obj/projectile/bullet/c38/trac
	name = ".38 tracker"
	damage = 10
	ricochets_max = 0
	shrapnel_type = /obj/item/shrapnel/bullet/tracker/c38

/obj/projectile/bullet/c38/hotshot //similar to incendiary bullets, but do not leave a flaming trail
	name = ".38 hearth bullet"
	ricochets_max = 0

/obj/projectile/bullet/c38/hotshot/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		M.adjust_fire_stacks(3)
		M.ignite_mob()

/obj/projectile/bullet/c38/iceblox //see /obj/projectile/temp for the original code
	name = ".38 chilled bullet"
	var/temperature = 100
	ricochets_max = 0

/obj/projectile/bullet/c38/iceblox/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(isliving(target))
		var/mob/living/M = target
		M.adjust_bodytemperature(((100-blocked)/100)*(temperature - M.bodytemperature))

/obj/projectile/bullet/c38/ashwine
	name = ".38 hallucinogenic bullet"
	ricochets_max = 0

/obj/projectile/bullet/c38/ashwine/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(isliving(target))
		var/mob/living/M = target
		M.set_timed_status_effect(10 SECONDS, /datum/status_effect/jitter)
		M.set_timed_status_effect(10 SECONDS, /datum/status_effect/dizziness, only_if_higher = TRUE)
		M.adjust_drugginess(10)

/obj/projectile/bullet/c38/shock
	name = ".38 shock bullet"
	ricochets_max = 0
	var/zap_flags = ZAP_MOB_DAMAGE

/obj/projectile/bullet/c38/shock/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(isliving(target))
		var/mob/living/M = target
		do_sparks(5, FALSE, M)
		M.electrocute_act(5, src, siemens_coeff = 1, flags = SHOCK_NOSTUN|SHOCK_TESLA)
	else
		tesla_zap(target, 5, 2000, zap_flags)

/obj/projectile/bullet/c38/force
	name = ".38 force bullet"
	armour_penetration = 10
	ricochets_max = 0

/obj/projectile/bullet/c38/force/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(ismovable(target) && isliving(target))
		var/atom/movable/M = target
		var/atom/throw_target = get_edge_target_turf(M, get_dir(src, get_step_away(M, src)))
		M.safe_throw_at(throw_target, 2, 2)

// .357 (Syndicate Revolver)

/obj/projectile/bullet/a357
	name = ".357 bullet"
	damage = 35

	speed = BULLET_SPEED_REVOLVER
	bullet_identifier = "medium bullet"

/obj/projectile/bullet/a357/match
	name = ".357 match bullet"
	armour_penetration = 10
	speed_mod = BULLET_SPEED_AP_MOD
	ricochets_max = 5
	ricochet_chance = 140
	ricochet_auto_aim_angle = 50
	ricochet_auto_aim_range = 6
	ricochet_incidence_leeway = 80
	ricochet_decay_chance = 1

/obj/projectile/bullet/a357/hp
	name = ".357 hollow point bullet"
	damage = 50
	armour_penetration = -20
	speed_mod = BULLET_SPEED_HP_MOD
	ricochet_chance = 0

// .45-70 Gov't (Hunting Revolver)

/obj/projectile/bullet/a4570
	name = ".45-70 bullet"
	damage = 45 //crits in 3-4 taps depending on armor
	speed = BULLET_SPEED_REVOLVER
	bullet_identifier = "large bullet"

/obj/projectile/bullet/a4570/match
	name = ".45-70 match bullet"
	armour_penetration = 10
	speed_mod = BULLET_SPEED_AP_MOD
	ricochets_max = 5
	ricochet_chance = 140
	ricochet_auto_aim_angle = 50
	ricochet_auto_aim_range = 6
	ricochet_incidence_leeway = 80
	ricochet_decay_chance = 1

/obj/projectile/bullet/a4570/hp
	name = ".45-70 hollow point bullet"
	damage = 55
	armour_penetration = -10
	speed_mod = BULLET_SPEED_HP_MOD

/obj/projectile/bullet/a4570/explosive //for extra oof
	name = ".45-70 explosive bullet"
	dismemberment = 50 //literally blow limbs off

/obj/projectile/bullet/a4570/explosive/on_hit(atom/target, blocked = FALSE)
	..()
	explosion(target, -1, 0, 1)
	return BULLET_ACT_HIT

// 44 Short (Roumain & Shadow)

/obj/projectile/bullet/a44roum
	name = ".44 roumain bullet"
	damage =  30
	speed = BULLET_SPEED_REVOLVER
	bullet_identifier = "small bullet"

/obj/projectile/bullet/a44roum/rubber
	name = ".44 roumain rubber bullet"
	damage =  10
	stamina = 40
	armour_penetration = -10
	speed_mod = BULLET_SPEED_RUBBER_MOD
	bullet_identifier = "small rubber bullet"

/obj/projectile/bullet/a44roum/hp
	name = ".44 roumain hollow point bullet"
	damage =  45
	armour_penetration = -10
	ricochet_chance = 0
	speed_mod = BULLET_SPEED_HP_MOD
