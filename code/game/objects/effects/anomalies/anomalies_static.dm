/obj/effect/anomaly/tvstatic
	name = "static"
	icon_state = "static"
	desc = "A mysterious anomaly. A hole in the world, endless buzzing emitting from it."
	density = TRUE
	aSignal = /obj/item/assembly/signaler/anomaly/tvstatic
	effectrange = 6
	pulse_delay = 6
	var/mob/living/carbon/victim

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
		if (HAS_TRAIT(looking, SEE_TURFS) || (looking.mind && HAS_TRAIT(looking.mind, SEE_TURFS)))
			looking.adjustOrganLoss(ORGAN_SLOT_BRAIN, 10, 200)
			playsound(looking, 'sound/effects/walkietalkie.ogg')


		if(looking.getOrganLoss(ORGAN_SLOT_BRAIN) >= 150)
			var/obj/effect/anomaly/tvstatic/expansion
			expansion = new(looking.loc)
			visible_message("<span class='warning'> The static overtakes [looking], [expansion] taking their place!</span>")
			//looking.death() may be cool to have someone screaming while the Static overtakes them
			expansion.victim = looking
			looking.forceMove(expansion)
	return


/obj/effect/anomaly/tvstatic/Bumped(atom/movable/AM)
	anomalyEffect()

/obj/effect/anomaly/tvstatic/detonate()
	for(var/mob/living/carbon/looking in range(effectrange, src))
		visible_message("<span class='boldwarning'> The static lashes out!</span>")
		sleep(5 SECONDS)
		if (HAS_TRAIT(looking, SEE_TURFS) || (looking.mind && HAS_TRAIT(looking.mind, SEE_TURFS)))
			looking.adjustOrganLoss(ORGAN_SLOT_BRAIN, 100, 200)
			playsound(looking, 'sound/effects/walkietalkie.ogg')
		anomalyEffect()
	. = ..()

/obj/effect/anomaly/tvstatic/anomalyNeutralize()
	if(var/mob/living/carbon/victim)
		victim.forceMove(drop_location())
	. = ..()


/obj/effect/anomaly/tvstatic/planetary
	immortal = TRUE
	immobile = TRUE
