//Anomalies, used for anomaly events. Anomalies cause adverse effects on their surroundings and can be mitigated by signalling their respective frequency.
/obj/effect/anomaly
	name = "anomaly"
	desc = "A mysterious anomaly, seen commonly in the Frontier"
	icon = 'icons/effects/anomalies.dmi'
	icon_state = "vortex"
	density = FALSE
	anchored = TRUE
	light_range = 3

	var/obj/item/assembly/signaler/anomaly/core = /obj/item/assembly/signaler/anomaly
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
	//have we been scanned for a mission yet?
	var/mission_scanned = FALSE

/obj/effect/anomaly/Initialize(mapload, new_lifespan, drops_core = TRUE)
	. = ..()
	START_PROCESSING(SSobj, src)
	impact_area = get_area(src)

	if (!impact_area)
		return INITIALIZE_HINT_QDEL

	research_value = rand(500,4000)
	pulse_delay = rand(pulse_delay*0.5, pulse_delay*1.5)

	src.drops_core = drops_core
	if(core)
		core = new core(src)
		core.code = rand(1,100)
		core.code_b = rand(1,100)
		core.anomaly_type = type
		core.research = research_value

		var/frequency = rand(MIN_FREE_FREQ, MAX_FREE_FREQ)
		if(ISMULTIPLE(frequency, 2))//signaller frequencies are always uneven!
			frequency++
		core.set_frequency(frequency)

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
	if(countdown)
		QDEL_NULL(countdown)
	QDEL_NULL(core)
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
		if(isnull(core))
			stack_trace("An anomaly ([src]) exists that drops a core, yet has no core!")
		else
			core.forceMove(drop_location())
			core = null
	// else, anomaly core gets deleted by qdel(src).

	qdel(src)


/obj/effect/anomaly/attackby(obj/item/weapon, mob/user, params)
	if(weapon.tool_behaviour == TOOL_ANALYZER && core)
		to_chat(user, span_notice("You start analyzing [src]."))
		if(do_after(user, 20, src, hidden = TRUE))
			to_chat(user, span_notice("[src]'s primary field is fluctuating along frequency [format_frequency(core.frequency)], code [core.code]."))

		return TRUE
	return ..()

/obj/effect/anomaly/examine(mob/user)
	. = ..()
	if(user.research_scanner == TRUE)
		to_chat(user, span_notice("If harvested, this anomaly would be worth [research_value] research points."))

/obj/effect/anomaly/throw_atom_into_space()
	qdel(src)
