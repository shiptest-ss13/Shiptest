
/obj/effect/anomaly/pyro
	name = "plasmaball"
	icon_state = "pyroclastic"
	desc = "A floating orb of everburning gas, not unlike a sun. It radiates a dangerous amount of heat."
	effectrange = 4
	pulse_delay = 10 SECONDS
	core = /obj/item/assembly/signaler/anomaly/pyro

/obj/effect/anomaly/pyro/anomalyEffect(seconds_per_tick)
	..()

	for(var/mob/living/carbon/nearby in range(effectrange, src))
		nearby.adjust_bodytemperature(20)

	if(!COOLDOWN_FINISHED(src, pulse_cooldown))
		return
	COOLDOWN_START(src, pulse_cooldown, pulse_delay)

	for(var/mob/living/carbon/nearby in range(effectrange/2, src))
		nearby.fire_stacks += 3
		nearby.ignite_mob()
		visible_message("<span class='warning'>[src] lets out a flare, igniting [nearby]!")


/obj/effect/anomaly/pyro/Bumped(atom/movable/AM)
	if(isobj(AM))
		var/obj/firething = AM
		if(firething.resistance_flags & FIRE_PROOF)
			firething.resistance_flags &= ~FIRE_PROOF
		if(firething.armor.fire > 50) //*Me copies from lava code
			firething.armor = firething.armor.setRating(fire = 50)
		firething.fire_act(10000, 1000)
	if(iscarbon(AM))
		var/mob/living/carbon/onfire
		onfire.fire_stacks += 3
		onfire.ignite_mob()

/obj/effect/anomaly/pyro/detonate()
	INVOKE_ASYNC(src, PROC_REF(makepyroslime))
	. = ..()

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
	pulse_delay = 2
	effectrange = 6

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

/obj/effect/anomaly/pyro/storm
	drops_core = FALSE
