/obj/projectile/energy/tesla
	name = "tesla bolt"
	icon_state = "tesla_projectile"
	impact_effect_type = /obj/effect/temp_visual/impact_effect/blue_laser
	damage = 10 //A worse lasergun
	var/zap_flags = ZAP_MOB_DAMAGE | ZAP_OBJ_DAMAGE
	var/zap_range = 3
	var/power = 10000
	var/constant_zaps = TRUE

/obj/projectile/energy/tesla/on_hit(atom/target)
	. = ..()
	tesla_zap(src, zap_range, power, zap_flags)
	qdel(src)

/obj/projectile/energy/tesla/process(seconds_per_tick)
	. = ..()
	//Many coders have given their blood for this speed
	if(constant_zaps)
		tesla_zap(src, zap_range, power, zap_flags)

/obj/projectile/energy/tesla/revolver
	name = "energy orb"

/obj/projectile/energy/tesla/cannon
	name = "tesla orb"
	power = 20000
	damage = 15 //Mech man big

/obj/projectile/energy/tesla/explosive
	constant_zaps = FALSE
	power = 5000

/obj/projectile/energy/tesla/explosive/on_hit(atom/target)
	explosion(get_turf(loc),0,0,0,flame_range = 3)
	. = ..()

/obj/projectile/energy/tesla_cannon
	name = "tesla orb"
	icon_state = "ice_1"
	damage = 0
	speed = 1.5
	var/shock_damage = 5

/obj/projectile/energy/tesla_cannon/on_hit(atom/target)
	. = ..()
	if(isliving(target))
		var/mob/living/victim = target
		victim.electrocute_act(shock_damage, src, siemens_coeff = 1, flags = SHOCK_NOSTUN|SHOCK_TESLA)

