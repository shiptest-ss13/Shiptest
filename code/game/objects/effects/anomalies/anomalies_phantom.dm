/obj/effect/anomaly/phantom
	name = "phantom"
	icon_state = "phantom"
	desc = "A familiar outline, it calls out for companionship. It screams for you."
	density = FALSE
	core = /obj/item/assembly/signaler/anomaly/phantom
	effectrange = 3
	pulse_delay = 2 SECONDS


/obj/effect/anomaly/phantom/anomalyEffect()
	..()
	if(!COOLDOWN_FINISHED(src, pulse_cooldown))
		return

	COOLDOWN_START(src, pulse_cooldown, pulse_delay)

// /tg/'s helgrasp spawn_hands proc, modified to work as an anomaly effect
	for(var/mob/living/carbon/handsy in range(effectrange, src))
		if(handsy.stat != DEAD)
			var/grab_dir = turn(handsy.dir, pick(-90, 90, 180, 180))
			var/turf/spawn_turf = get_ranged_target_turf(handsy, grab_dir, 8)
			if(!spawn_turf)
				return
			new /obj/effect/temp_visual/dir_setting/curse/grasp_portal(spawn_turf, handsy.dir)
			playsound(spawn_turf, 'sound/effects/curse2.ogg', 80, TRUE, -1)
			var/obj/projectile/curse_hand/phantom/hand = new (spawn_turf)
			hand.preparePixelProjectile(handsy, spawn_turf)
			if(QDELETED(hand))
				return
			hand.fire()
	return


/obj/effect/anomaly/phantom/Bumped(atom/movable/AM)
	anomalyEffect()
	new /obj/effect/gibspawner/human(loc)

/obj/effect/anomaly/phantom/detonate()
	anomalyEffect()
	new /obj/effect/mob_spawn/human/corpse/damaged/legioninfested(loc)
	. = ..()

/obj/effect/anomaly/phantom/planetary
	immortal = TRUE
	immobile = TRUE
