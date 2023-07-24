/obj/effect/anomaly/tvstatic
	name = "static"
	icon_state = "static"
	desc = "A mysterious anomaly. A hole in the world, endless buzzing emitting from it."
	density = TRUE
	aSignal = /obj/item/assembly/signaler/anomaly/tvstatic
	effectrange = 4
	pulse_delay = 4 SECONDS
	var/mob/living/carbon/stored_mob = null

/obj/effect/anomaly/tvstatic/examine(mob/user)
	. = ..()
	if(!iscarbon(user))
		return
	if(iscarbon(user) && !user.research_scanner) //this'll probably cause some weirdness when I start using research scanner in more places / on more items. Oh well.
		var/mob/living/carbon/bah = user
		to_chat(bah, span_userdanger("Your head aches as you stare into the [src]!"))
		bah.adjustOrganLoss(ORGAN_SLOT_BRAIN, 5, 100)

/obj/effect/anomaly/tvstatic/anomalyEffect()
	..()

	var/turf/spot = locate(rand(src.x-effectrange, src.x+effectrange), rand(src.y-effectrange, src.y+effectrange), src.z)
	new /obj/effect/particle_effect/staticball(spot)


	if(!COOLDOWN_FINISHED(src, pulse_cooldown))
		return

	COOLDOWN_START(src, pulse_cooldown, pulse_delay)

	for(var/mob/living/carbon/looking in range(effectrange, src))
		playsound(src, 'sound/effects/walkietalkie.ogg', 100)
		if (!HAS_TRAIT(looking, TRAIT_MINDSHIELD) && looking.stat != DEAD || !looking.research_scanner && looking.stat != DEAD)
			looking.adjustOrganLoss(ORGAN_SLOT_BRAIN, 10, 200)
			playsound(src, 'sound/effects/stall.ogg', 100)
			if(looking.getOrganLoss(ORGAN_SLOT_BRAIN) >= 150 && looking.stat != DEAD)
				if(prob(20))
					var/mob/living/carbon/victim = looking
					var/obj/effect/anomaly/tvstatic/planetary/expansion
					expansion = new(get_turf(victim))
					visible_message("<span class='warning'> The static overtakes [victim], [expansion] taking their place!</span>")
					victim.death()
					expansion.stored_mob = victim
					victim.forceMove(expansion)
	return


/obj/effect/anomaly/tvstatic/Bumped(atom/movable/AM)
	anomalyEffect()

/obj/effect/anomaly/tvstatic/detonate()
	for(var/mob/living/carbon/looking in range(effectrange, src))
		visible_message("<span class='boldwarning'> The static lashes out, agony filling your mind as its tendrils scrape your thoughts!</span>")
		if (!HAS_TRAIT(looking, TRAIT_MINDSHIELD) && looking.stat != DEAD)
			looking.adjustOrganLoss(ORGAN_SLOT_BRAIN, 100, 200)
			playsound(src, 'sound/effects/stall.ogg', 100)
		anomalyEffect()
	. = ..()


/obj/effect/anomaly/tvstatic/anomalyNeutralize()
	var/turf/T = get_turf(src)
	if(T)
		if(stored_mob)
			visible_message("<span class='warning'>The static spits out [stored_mob], their body coming out in a burst!</span>")
			stored_mob.forceMove(get_turf(src))
			stored_mob = null
	. = ..()


/obj/effect/anomaly/tvstatic/planetary
	immortal = TRUE
	immobile = TRUE

/obj/effect/particle_effect/staticball
	name = "static blob"
	desc = "An unsettling mass of free floating static"
	icon = 'icons/effects/anomalies.dmi'
	icon_state = "static"

/obj/effect/particle_effect/staticball/Initialize()
	..()
	return INITIALIZE_HINT_LATELOAD

/obj/effect/particle_effect/staticball/LateInitialize()
	flick(icon_state, src)
	playsound(src, "walkietalkie", 100, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
	QDEL_IN(src, 20)

