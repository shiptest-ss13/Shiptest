/// This divisor controls how fast body temperature changes to match the environment
#define BODYTEMP_DIVISOR 8

/mob/living/proc/Life(seconds_per_tick = SSMOBS_DT, times_fired)
	set waitfor = FALSE
	set invisibility = 0

	SEND_SIGNAL(src, COMSIG_LIVING_LIFE, seconds_per_tick, times_fired)

	if (client)
		var/turf/T = get_turf(src)
		if(!T)
			move_to_error_room()
			var/msg = "[ADMIN_LOOKUPFLW(src)] was found to have no .loc with an attached client, if the cause is unknown it would be wise to ask how this was accomplished."
			message_admins(msg)
			send2tgs_adminless_only("Mob", msg, R_ADMIN)
			log_game("[key_name(src)] was found to have no .loc with an attached client.")

	if (notransform)
		return

	if(!loc)
		return

	if(!IS_IN_STASIS(src))

		if(stat != DEAD)
			//Mutations and radiation
			handle_mutations_and_radiation()

		if(stat != DEAD)
			//Breathing, if applicable
			handle_breathing(seconds_per_tick, times_fired)

		handle_diseases(seconds_per_tick, times_fired)// DEAD check is in the proc itself; we want it to spread even if the mob is dead, but to handle its disease-y properties only if you're not.

		if (QDELETED(src)) // diseases can qdel the mob via transformations
			return

		SEND_SIGNAL(src, COMSIG_MOB_LIFE)

		if(stat != DEAD)
			//Random events (vomiting etc)
			handle_random_events()

		//Handle temperature/pressure differences between body and environment
		var/datum/gas_mixture/environment = loc.return_air()
		if(environment)
			handle_environment(environment)

		handle_gravity()

		if(stat != DEAD)
			handle_traits() // eye, ear, brain damages
			handle_status_effects() //all special effects, stun, knockdown, jitteryness, hallucination, sleeping, etc

	handle_wounds(seconds_per_tick, times_fired)

	if(machine)
		machine.check_eye(src)

	if(stat != DEAD)
		return 1

/mob/living/proc/handle_breathing(seconds_per_tick = SSMOBS_DT, times_fired)
	SEND_SIGNAL(src, COMSIG_LIVING_HANDLE_BREATHING, seconds_per_tick, times_fired)
	return

/mob/living/proc/handle_mutations_and_radiation()
	radiation = 0 //so radiation don't accumulate in simple animals
	return

/mob/living/proc/handle_diseases(seconds_per_tick, times_fired)
	return

/mob/living/proc/handle_wounds()
	return

/mob/living/proc/handle_random_events()
	return

// Base mob environment handler for body temperature
/mob/living/proc/handle_environment(datum/gas_mixture/environment)
	var/loc_temp = get_temperature(environment)

	if(loc_temp < bodytemperature) // it is cold here
		if(!on_fire) // do not reduce body temp when on fire
			adjust_bodytemperature(max((loc_temp - bodytemperature) / BODYTEMP_DIVISOR, HUMAN_BODYTEMP_COOLING_MAX))
	else // this is a hot place
		adjust_bodytemperature(min((loc_temp - bodytemperature) / BODYTEMP_DIVISOR, HUMAN_BODYTEMP_HEATING_MAX))

//this updates all special effects: knockdown, druggy, stuttering, etc..
/mob/living/proc/handle_status_effects()
	if(confused)
		confused = max(0, confused - 1)

/mob/living/proc/handle_traits()
	//Eyes
	if(eye_blind)	//blindness, heals slowly over time
		if(HAS_TRAIT_FROM(src, TRAIT_BLIND, EYES_COVERED)) //covering your eyes heals blurry eyes faster
			adjust_blindness(-3)
		else if(!stat && !(HAS_TRAIT(src, TRAIT_BLIND)))
			adjust_blindness(-1)
	else if(eye_blurry)			//blurry eyes heal slowly
		adjust_blurriness(-1)

/mob/living/proc/update_damage_hud()
	return

/mob/living/proc/handle_gravity()
	var/gravity = has_gravity()
	update_gravity(gravity)

	if(gravity > STANDARD_GRAVITY)
		gravity_animate()
		handle_high_gravity(gravity)

/mob/living/proc/gravity_animate()
	if(!get_filter("gravity"))
		add_filter("gravity",1,list("type"="motion_blur", "x"=0, "y"=0))
	INVOKE_ASYNC(src, PROC_REF(gravity_pulse_animation))

/mob/living/proc/gravity_pulse_animation()
	animate(get_filter("gravity"), y = 1, time = 10)
	sleep(10)
	animate(get_filter("gravity"), y = 0, time = 10)

/mob/living/proc/handle_high_gravity(gravity)
	if(gravity >= GRAVITY_DAMAGE_TRESHOLD) //Aka gravity values of 3 or more
		var/grav_stregth = gravity - GRAVITY_DAMAGE_TRESHOLD
		adjustBruteLoss(min(grav_stregth,3))

#undef BODYTEMP_DIVISOR
