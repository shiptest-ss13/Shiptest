/obj/effect/radiation
	name = "background radiation"
	desc = "Pulses radition every so often. Only observers can see this."
	icon = 'icons/effects/effects.dmi'
	icon_state = "radiation"
	invisibility = INVISIBILITY_OBSERVER
	layer = MID_LANDMARK_LAYER
	anchored = TRUE
	///Radiation pulse intensity
	var/rad_power = 33
	/// !Range mod = rad dropoff speed
	var/rad_range = 1
	/// Range of nearby atoms to radiate
	var/rad_spread = 6
	/// Probability per open turf in view to make a rad pulse there
	var/rad_prob = 10
	COOLDOWN_DECLARE(pulse_cooldown)
	/// Delay between radiation pulses
	var/rad_delay = 2 SECONDS

/obj/effect/radiation/Initialize()
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/effect/radiation/process()
	if(!COOLDOWN_FINISHED(src, pulse_cooldown))
		return

	var/player_in_range = FALSE
	for(var/mob/living/living in range(rad_spread, loc))
		if(living.client)
			player_in_range = TRUE
			break
	if(!player_in_range)
		return
	COOLDOWN_START(src, pulse_cooldown, rad_delay)
	for(var/turf/open/open_turf in view(rad_spread, src))
		if(!prob(rad_prob))
			continue
		radiation_pulse(rad_impact_loc(open_turf), rad_power, rad_range)

/// Cast a line to target and if blocked, returns the turf before the blocking turf. Otherwise returns target turf
/obj/effect/radiation/proc/rad_impact_loc(turf/target)
	var/list/turfs = get_line(loc, target)
	for(var/i=1 to length(turfs))
		var/turf/turf = turfs[i]
		if(!turf.is_blocked_turf(exclude_mobs = TRUE, source_atom = src))
			continue
		return turfs[max(i-1, 1)] // Prevents trying to access index 0
	return target

/obj/effect/radiation/waste
	rad_power = 33
	rad_delay = 4 SECONDS
	rad_prob = 20
	rad_spread = 3

/obj/effect/radiation/waste/intense //3.6 roetgen. Not bad. Not good.
	rad_power = 120
	rad_delay = 8 SECONDS
	rad_prob = 10
