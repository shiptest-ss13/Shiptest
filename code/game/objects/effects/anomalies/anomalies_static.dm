GLOBAL_LIST_INIT(tvstatic_sayings, list(
	"... Help me...",
	"... I need to get out ...",
	"...No hope....",
	"...Let me loose...",
	"...stay with me...",
	"...Not like this...",
	"...please don't go...",
	"...don't forget me...",
	"...Are you there...?",
	"...it hurts...",
	"...the eyes...",
	"...need to run...",
	"...is anyone there..."
))

/obj/effect/anomaly/tvstatic
	name = "static"
	icon_state = "static"
	desc = "A hole in the world emitting an endless buzzing. It hides something precious."
	density = TRUE
	core = /obj/item/assembly/signaler/anomaly/tvstatic
	effectrange = 4
	pulse_delay = 4 SECONDS
	verb_say = "pleads"
	verb_ask = "begs"
	verb_exclaim = "screams"
	verb_whisper = "whimpers"
	verb_yell = "screams"
	speech_span = SPAN_ITALICS
	var/mob/living/carbon/stored_mob = null

/obj/effect/anomaly/tvstatic/examine(mob/user)
	. = ..()
	if(!iscarbon(user))
		return
	if(iscarbon(user) && !user.research_scanner) //this'll probably cause some weirdness when I start using research scanner in more places / on more items. Oh well.
		var/mob/living/carbon/victim = user
		to_chat(victim, span_userdanger("Your head aches as you stare into [src]!"))
		victim.adjustOrganLoss(ORGAN_SLOT_BRAIN, 5, 100)

/obj/effect/anomaly/tvstatic/anomalyEffect()
	..()

	var/turf/spot = locate(rand(src.x-effectrange, src.x+effectrange), rand(src.y-effectrange, src.y+effectrange), src.z)
	new /obj/effect/particle_effect/staticball(spot)


	if(!COOLDOWN_FINISHED(src, pulse_cooldown))
		return

	COOLDOWN_START(src, pulse_cooldown, pulse_delay)

	for(var/mob/living/carbon/human/looking in range(effectrange, src))
		playsound(src, 'sound/effects/walkietalkie.ogg', 75)
		if(stored_mob && looking.stat != DEAD && prob(25))
			say_fucky_things()
		if(HAS_TRAIT(looking, TRAIT_MINDSHIELD) || looking.stat == DEAD || looking.research_scanner || HAS_TRAIT(looking, TRAIT_DEAF))
			continue
		looking.adjustOrganLoss(ORGAN_SLOT_BRAIN, 10, 200)
		playsound(src, 'sound/effects/stall.ogg', 50)
		if(looking.getOrganLoss(ORGAN_SLOT_BRAIN) >= 150 && looking.stat != DEAD)
			if(prob(20))
				var/mob/living/carbon/victim = looking
				var/obj/effect/anomaly/tvstatic/planetary/expansion
				expansion = new(get_turf(victim))
				visible_message(span_warning("[src] overtakes [victim], [expansion] taking their place!"))
				victim.death()
				expansion.stored_mob = victim
				victim.forceMove(expansion)


/obj/effect/anomaly/tvstatic/Bumped(atom/movable/AM)
	anomalyEffect()

/obj/effect/anomaly/tvstatic/proc/say_fucky_things()
	say(pick(GLOB.tvstatic_sayings))
	return

/obj/effect/anomaly/tvstatic/detonate()
	for(var/mob/living/carbon/human/looking in range(effectrange, src))
		visible_message(span_boldwarning("[src] lashes out, agony filling your mind as its tendrils scrape your thoughts!"))
		if (!HAS_TRAIT(looking, TRAIT_MINDSHIELD) && looking.stat != DEAD)
			looking.adjustOrganLoss(ORGAN_SLOT_BRAIN, 100, 200)
			playsound(src, 'sound/effects/stall.ogg', 100)
		if(stored_mob)
			mangle_corpse()
			visible_message(span_warning("[src] sputters out [stored_mob], their body coming out in a burst of blood and gore!"))
			new /obj/effect/gibspawner/human(loc)
			stored_mob.forceMove(get_turf(src))
			stored_mob = null
		anomalyEffect()
	. = ..()

/obj/effect/anomaly/tvstatic/proc/mangle_corpse()
	if(!stored_mob)
		return
	stored_mob.adjustBruteLoss(400)

/obj/effect/anomaly/tvstatic/anomalyNeutralize()
	var/turf/T = get_turf(src)
	if(T)
		if(stored_mob)
			visible_message(span_warning("[src] spits out [stored_mob], their body coming out in a burst!"))
			stored_mob.forceMove(get_turf(src))
			stored_mob = null
	. = ..()


/obj/effect/anomaly/tvstatic/planetary
	immortal = TRUE
	immobile = TRUE

/obj/effect/anomaly/tvstatic/planetary/Initialize(mapload)
	if(prob(25) & !stored_mob)
		var/obj/effect/mob_spawn/human/corpse/damaged/legioninfested/vicspawner = new (src)
		var/mob/living/carbon/victim = (vicspawner.spawned_mob_ref)?.resolve()
		src.stored_mob = victim
		victim.forceMove(src)
	. = ..()

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

