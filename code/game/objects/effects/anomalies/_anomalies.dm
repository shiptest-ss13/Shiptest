//Anomalies, used for anomaly events. Anomalies cause adverse effects on their surroundings and can be mitigated by signalling their respective frequency.
/obj/effect/anomaly
	name = "anomaly"
	desc = "A mysterious anomaly, seen commonly in the Frontier"
	icon = 'icons/effects/anomalies.dmi'
	icon_state = "vortex"
	density = FALSE
	anchored = TRUE
	light_range = 3

	//aSignal drops as the core, bSignal allows people to signal to detonate
	var/obj/item/assembly/signaler/anomaly/aSignal = /obj/item/assembly/signaler/anomaly
	var/obj/item/assembly/signaler/anomaly/bSignal = /obj/item/assembly/signaler/anomaly/det_signal
	var/area/impact_area

	var/lifespan = 990
	var/death_time
	var/research_value

	//for anomaly effects, range is how far the effects can reach, the cooldown lets us wire in effects that happen every pulse delay seconds
	var/effectrange = 6

	COOLDOWN_DECLARE(pulse_cooldown)
	COOLDOWN_DECLARE(pulse_secondary_cooldown)
	var/pulse_delay = 15 SECONDS

	var/countdown_colour
	var/obj/effect/countdown/anomaly/countdown

	/// Do we drop a core when we're neutralized?
	var/drops_core = TRUE
	///Do we keep on living forever?
	var/immortal = FALSE
	///Do we stay in one place?
	var/immobile = FALSE

/obj/effect/anomaly/Initialize(mapload, new_lifespan, drops_core = TRUE)
	. = ..()
	START_PROCESSING(SSobj, src)
	impact_area = get_area(src)

	if (!impact_area)
		return INITIALIZE_HINT_QDEL

	research_value = rand(500,4000)
	pulse_delay = rand(pulse_delay*0.5, pulse_delay*1.5)

	src.drops_core = drops_core
	if(aSignal)
		aSignal = new aSignal(src)
		aSignal.code = rand(1,100)
		aSignal.anomaly_type = type
		aSignal.research = rand(500,4000)

		var/frequency = rand(MIN_FREE_FREQ, MAX_FREE_FREQ)
		if(ISMULTIPLE(frequency, 2))//signaller frequencies are always uneven!
			frequency++
		aSignal.set_frequency(frequency)

	if(bSignal)
		bSignal = new bSignal(src)
		bSignal.code = rand(1,100)
		bSignal.anomaly_type = type
		var/frequency = rand(MIN_FREE_FREQ, MAX_FREE_FREQ)
		if(ISMULTIPLE(frequency, 2))//signaller frequencies are always uneven!
			frequency++
		bSignal.set_frequency(frequency)



	if(lifespan)
		if(new_lifespan)
			lifespan = new_lifespan
		death_time = world.time + lifespan
		countdown = new(src)
		if(countdown_colour)
			countdown.color = countdown_colour
		if(immortal)
			return
		countdown.start()

/obj/effect/anomaly/vv_edit_var(vname, vval)
	. = ..()
	if(vname == NAMEOF(src, immortal))
		if(vval)
			countdown.stop()
		else
			countdown.start()

/obj/effect/anomaly/process(seconds_per_tick)
	anomalyEffect(seconds_per_tick)
	if(death_time < world.time && !immortal)
		if(loc)
			detonate()
		qdel(src)

/obj/effect/anomaly/Destroy()
	STOP_PROCESSING(SSobj, src)
	QDEL_NULL(countdown)
	QDEL_NULL(aSignal)
	return ..()

/obj/effect/anomaly/proc/anomalyEffect(seconds_per_tick)
	if(!immobile && SPT_PROB(ANOMALY_MOVECHANCE, seconds_per_tick))
		step(src,pick(GLOB.alldirs))

/obj/effect/anomaly/proc/detonate()
	new /obj/effect/particle_effect/smoke/bad(loc)
	qdel(src)
	return

/obj/effect/anomaly/ex_act(severity, target)
	if(severity >= EXPLODE_DEVASTATE)
		qdel(src)
		return TRUE

	return FALSE

/obj/effect/anomaly/proc/anomalyNeutralize()
	new /obj/effect/particle_effect/smoke/bad(loc)

	if(drops_core)
		if(isnull(aSignal))
			stack_trace("An anomaly ([src]) exists that drops a core, yet has no core!")
		else
			aSignal.forceMove(drop_location())
			aSignal = null
	// else, anomaly core gets deleted by qdel(src).

	qdel(src)


/obj/effect/anomaly/attackby(obj/item/weapon, mob/user, params)
	if(weapon.tool_behaviour == TOOL_ANALYZER && aSignal)
		to_chat(user, span_notice("You start analyzing [src]."))
		if(do_after(user, 20, TRUE, src))
			to_chat(user, span_notice("[src]'s primary field is fluctuating along frequency [format_frequency(aSignal.frequency)], code [aSignal.code]."))
			if(bSignal)
				to_chat(user, span_notice("A second field is fluctuating along [format_frequency(bSignal.frequency)], code [bSignal.code]. It is highly unstable." ))
		return TRUE

	return ..()


/obj/effect/anomaly/examine(mob/user)
	. = ..()
	if(user.research_scanner == TRUE)
		to_chat(user, span_notice("If harvested, this anomaly would be worth [research_value] research points."))

/obj/effect/anomaly/throw_atom_into_space()
	qdel(src)
