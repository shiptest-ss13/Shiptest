/obj/effect/anomaly/tvstatic
	name = "static"
	icon_state = "static"
	desc = "A mysterious anomaly. A hole in the world, endless buzzing emitting from it."
	density = TRUE
	aSignal = /obj/item/assembly/signaler/anomaly/tvstatic
	effectrange = 6
	pulse_delay = 6
	var/mob/living/carbon/stored_mob = null

/obj/effect/anomaly/tvstatic/examine(mob/user)
	. = ..()
	if(!iscarbon(user))
		return
	if(iscarbon(user))
		var/mob/living/carbon/bah = user
		to_chat(bah, span_userdanger("Your head aches as you stare into the [src]!"))
		bah.adjustOrganLoss(ORGAN_SLOT_BRAIN, 10, 100)

/obj/effect/anomaly/tvstatic/anomalyEffect()
	..()

	if(!COOLDOWN_FINISHED(src, pulse_cooldown))
		return

	COOLDOWN_START(src, pulse_cooldown, pulse_delay)

	for(var/mob/living/carbon/looking in range(effectrange, src))
		if (!HAS_TRAIT(looking, TRAIT_MINDSHIELD) && looking.stat != DEAD)
			looking.adjustOrganLoss(ORGAN_SLOT_BRAIN, 10, 200)
			playsound(looking, 'sound/effects/walkietalkie.ogg')
		if(looking.getOrganLoss(ORGAN_SLOT_BRAIN) >= 150 && looking.stat != DEAD)
			var/mob/living/carbon/victim = looking
			var/obj/effect/anomaly/tvstatic/planetary/expansion
			expansion = new(get_turf(victim))
			visible_message("<span class='warning'> The static overtakes [victim], [expansion] taking their place!</span>")
			victim.death()
			stored_mob = victim
			victim.forceMove(expansion)
	return


/obj/effect/anomaly/tvstatic/Bumped(atom/movable/AM)
	anomalyEffect()

/obj/effect/anomaly/tvstatic/detonate()
	for(var/mob/living/carbon/looking in range(effectrange, src))
		visible_message("<span class='boldwarning'> The static lashes out!</span>")
		if (!HAS_TRAIT(looking, TRAIT_MINDSHIELD) && looking.stat != DEAD)
			looking.adjustOrganLoss(ORGAN_SLOT_BRAIN, 100, 200)
			playsound(looking, 'sound/effects/walkietalkie.ogg')
		anomalyEffect()
	. = ..()


/obj/effect/anomaly/tvstatic/anomalyNeutralize()
	if(stored_mob)
		stored_mob.forceMove(get_turf(src))
		stored_mob = null
	. = ..()


/obj/effect/anomaly/tvstatic/planetary
	immortal = TRUE
	immobile = TRUE
