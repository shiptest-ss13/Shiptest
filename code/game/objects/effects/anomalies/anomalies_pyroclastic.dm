
/obj/effect/anomaly/pyro
	name = "pyroclastic anomaly"
	icon_state = "pyroclastic"
	effectrange = 4
	var/ticks = 0
	/// How many seconds between each gas release
	pulse_delay = 10
	aSignal = /obj/item/assembly/signaler/anomaly/pyro

/obj/effect/anomaly/pyro/anomalyEffect(seconds_per_tick)
	..()

	for(var/mob/living/carbon/nearby in range(effectrange, src))
		nearby.adjust_bodytemperature(20)
		visible_message("[src] pulses!")

	if(!COOLDOWN_FINISHED(src, pulse_cooldown))
		return
	COOLDOWN_START(src, pulse_cooldown, pulse_delay)

	for(var/mob/living/carbon/nearby in range(effectrange/2, src))
		nearby.fire_stacks += 3
		nearby.IgniteMob()
		visible_message("<span_class:warning>[src] ignites [nearby]!")

	ticks += seconds_per_tick
	if(ticks < pulse_cooldown)
		return FALSE
	else
		ticks -= pulse_cooldown
	var/turf/open/tile = get_turf(src)
	if(istype(tile))
		tile.atmos_spawn_air("o2=5;plasma=10;TEMP=500")
	return TRUE

/obj/effect/anomaly/pyro/detonate()
	INVOKE_ASYNC(src, PROC_REF(makepyroslime))

/obj/effect/anomaly/pyro/proc/makepyroslime()
	var/turf/open/tile = get_turf(src)
	if(istype(tile))
		tile.atmos_spawn_air("o2=250;plasma=750;TEMP=1000") //Make it hot and burny for the new slime

	var/new_colour = pick("red", "orange")
	var/mob/living/simple_animal/slime/pyro = new(tile, new_colour)
	pyro.rabid = TRUE
	pyro.amount_grown = SLIME_EVOLUTION_THRESHOLD
	pyro.Evolve()
	var/datum/action/innate/slime/reproduce/repro_action = new
	repro_action.Grant(pyro)


/obj/effect/anomaly/pyro/big
	immortal = TRUE
	aSignal = null
	pulse_delay = 2
	effectrange = 6
	move_force = MOVE_FORCE_OVERPOWERING

/obj/effect/anomaly/pyro/big/Initialize(mapload, new_lifespan, drops_core)
	. = ..()

	transform *= 2


/obj/effect/anomaly/pyro/big/anomalyEffect(seconds_per_tick)
	. = ..()

	if(!.)
		return

	var/turf/turf = get_turf(src)
	if(!isgroundlessturf(turf))
		turf.TerraformTurf(/turf/open/lava/smooth, flags = CHANGETURF_INHERIT_AIR)


/obj/effect/anomaly/pyro/planetary
	immortal = TRUE
	immobile = TRUE

/obj/effect/anomaly/pyro/big/planetary
	immortal = TRUE
	immobile = TRUE
