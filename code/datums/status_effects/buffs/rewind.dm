/datum/status_effect/rewind
	id = "rewind"
	alert_type = /atom/movable/screen/alert/status_effect/accelerando
	tick_interval = 10
	duration = STATUS_EFFECT_AUTO_TICK
	status_type = STATUS_EFFECT_REPLACE
	remove_on_fullheal = FALSE
	processing_speed = STATUS_EFFECT_NORMAL_PROCESS
	///Where are we going to go
	var/turf/return_turf

	var/rewinds_left = 1

/datum/status_effect/rewind/fatal
	rewinds_left = -1

/datum/status_effect/rewind/fatal/on_apply()
	. = ..()
	to_chat(owner, custom_boxed_message("blue_box center", span_userdanger("You are going to die. \nThere is nothing you can about it.\nDo what needs to be done.\nPlay what needs to be played.\nYou have three minutes.")))

/datum/status_effect/rewind/on_creation(mob/living/new_owner, duration = 180 SECONDS)
	src.duration = duration
	return ..()

/datum/status_effect/rewind/on_apply()
	. = ..()

	owner.overlay_fullscreen("anomaly", /atom/movable/screen/fullscreen/chronograph)

	return_turf = get_turf(owner)
	do_sparks(6, FALSE, return_turf, /datum/effect_system/spark_spread/blue)

	RegisterSignal(owner, COMSIG_MOB_STATCHANGE, PROC_REF(check_owner_stat))

/datum/status_effect/rewind/on_remove()
	. = ..()
	owner.clear_fullscreen("anomaly")

/datum/status_effect/rewind/proc/check_owner_stat(mob/living/sender, new_stat, old_stat)
	if(new_stat != CONSCIOUS)
		var/valid_rewind = FALSE
		switch(new_stat)
			if(SOFT_CRIT)
				if(!HAS_TRAIT(owner, TRAIT_NOSOFTCRIT))
					valid_rewind = TRUE
			if(HARD_CRIT)
				if(!HAS_TRAIT(owner, TRAIT_NOHARDCRIT))
					valid_rewind = TRUE
			if(DEAD)
				if(!HAS_TRAIT(owner, TRAIT_NODEATH))
					valid_rewind = TRUE
		if(valid_rewind)
			rewind()

/datum/status_effect/rewind/proc/rewind()
	//we want a turf and don't fire if we're being destroyed.
	if(!return_turf || QDELING(src) || !owner)
		return

	//don't do it if we shouldn't be doing it
	if(!rewinds_left)
		qdel(src)
		return

	var/turf/where_are_we = get_turf(owner)
	if(!where_are_we)
		return

	var/mob/living/carbon/human/emergency_homunculus = new /mob/living/carbon/human(where_are_we)

	owner.forceMove(return_turf)
	var/quip = MAPTEXT(pick("No, that's not it.", "Lets try that again.", "That wasn't quite right.", "Was that how it went?", "No. That won't work."))
	owner.play_screen_text(quip, /atom/movable/screen/text/screen_text/short)
	owner.revive(TRUE, FALSE)

	log_combat(user, null, "was revived by Tempo")

	owner.Paralyze(5, TRUE)

	emergency_homunculus.dust()
	do_sparks(6, FALSE, where_are_we, /datum/effect_system/spark_spread/blue)
	do_sparks(6, FALSE, return_turf, /datum/effect_system/spark_spread/blue)

	rewinds_left--
	if(!rewinds_left)
		qdel(src)
