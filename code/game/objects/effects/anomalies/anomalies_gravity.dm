
/atom/movable/warp_effect
	appearance_flags = PIXEL_SCALE|LONG_GLIDE // no tile bound so you can see it around corners and so
	icon = 'icons/effects/light_overlays/light_352.dmi'
	icon_state = "light"
	pixel_x = -176
	pixel_y = -176

/obj/effect/anomaly/grav
	name = "throngler"
	icon_state = "gravity"
	desc = "A miniature gravity well, constantly pulling the world around it into a 'throngling'."
	density = FALSE
	core = /obj/item/assembly/signaler/anomaly/grav
	effectrange = 4
	var/boing = 0
	///Warp effect holder for displacement filter to "pulse" the anomaly
	var/atom/movable/warp_effect/warp

/obj/effect/anomaly/grav/Initialize(mapload, new_lifespan, drops_core)
	. = ..()
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(on_entered),
	)
	AddElement(/datum/element/connect_loc, loc_connections)

/obj/effect/anomaly/grav/anomalyEffect()
	..()
	boing = 1
	for(var/obj/O in orange(effectrange, src))
		if(!O.anchored)
			step_towards(O,src)
	for(var/mob/living/Mob in range(0, src))
		gravShock(Mob)
	for(var/mob/living/Mob in orange(effectrange, src))
		if(!Mob.mob_negates_gravity())
			step_towards(Mob,src)
	for(var/obj/O in range(0,src))
		if(!O.anchored)
			if(isturf(O.loc))
				var/turf/T = O.loc
				if(T.intact && HAS_TRAIT(O, TRAIT_T_RAY_VISIBLE))
					continue
			var/mob/living/target = locate() in view(effectrange,src)
			if(target && !target.stat)
				O.throw_at(target, 5, 10)

	if(!COOLDOWN_FINISHED(src, pulse_cooldown))
		return

	COOLDOWN_START(src, pulse_cooldown, pulse_delay)
	for(var/mob/living/carbon/carbon in orange(effectrange/2, src))
		if(carbon.run_armor_check(attack_flag = "melee") >= 40)
			carbon.break_random_bone()
		if(carbon.run_armor_check(attack_flag = "melee") >= 60)
			carbon.break_all_bones() //crunch
		carbon.apply_damage(10, BRUTE)

/obj/effect/anomaly/grav/proc/on_entered(datum/source, atom/movable/AM)
	SIGNAL_HANDLER

	gravShock(AM)

/obj/effect/anomaly/grav/Bump(atom/A)
	gravShock(A)

/obj/effect/anomaly/grav/Bumped(atom/movable/AM)
	gravShock(AM)

/obj/effect/anomaly/grav/proc/gravShock(mob/living/Guy)
	if(boing && isliving(Guy) && !Guy.stat)
		Guy.Paralyze(40)
		var/atom/target = get_edge_target_turf(Guy, get_dir(src, get_step_away(Guy, src)))
		Guy.throw_at(target, 5, 1)
		boing = 0
		if(iscarbon(Guy))
			for(var/mob/living/carbon/carbon in range(0,src))
				if(carbon.run_armor_check(attack_flag = "melee") >= 20)
					carbon.break_random_bone()
				else if(carbon.run_armor_check(attack_flag = "melee") >= 40)
					carbon.break_all_bones() //crunch
				carbon.apply_damage(10, BRUTE)

/obj/effect/anomaly/grav/high
	effectrange = 5
	var/datum/proximity_monitor/advanced/gravity/grav_field

/obj/effect/anomaly/grav/high/Initialize(mapload, new_lifespan)
	. = ..()
	INVOKE_ASYNC(src, PROC_REF(setup_grav_field))

/obj/effect/anomaly/grav/high/proc/setup_grav_field()
	grav_field = new(src, effectrange, TRUE, 2)

/obj/effect/anomaly/grav/high/Destroy()
	QDEL_NULL(grav_field)
	. = ..()

///Bigger, meaner, immortal gravity anomaly. although this is just the super grav anomaly but bigger and shattering move force
/obj/effect/anomaly/grav/high/big
	immortal = TRUE
	effectrange = 7
	move_force = MOVE_FORCE_OVERPOWERING

/obj/effect/anomaly/grav/high/big/Initialize(mapload, new_lifespan, drops_core)
	. = ..()

	transform *= 1.5


/obj/effect/anomaly/grav/planetary
	immortal = TRUE
	immobile = TRUE

/obj/effect/anomaly/grav/high/planetary
	immortal = TRUE
	immobile = TRUE

/obj/effect/anomaly/grav/high/big/planetary
	immortal = TRUE
	immobile = TRUE
