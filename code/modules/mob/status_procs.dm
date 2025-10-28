
//Here are the procs used to modify status effects of a mob.
//The effects include: stun, knockdown, unconscious, sleeping, resting, jitteriness, dizziness, ear damage,
// eye damage, eye_blind, eye_blurry, druggy, TRAIT_BLIND trait, and TRAIT_NEARSIGHT trait.

///Blind a mobs eyes by amount
/mob/proc/blind_eyes(amount)
	adjust_blindness(amount)

/**
 * Adjust a mobs blindness by an amount
 *
 * Will apply the blind alerts if needed
 */
/mob/proc/adjust_blindness(amount)
	var/old_eye_blind = eye_blind
	eye_blind = max(0, eye_blind + amount)
	if(!old_eye_blind || !eye_blind && !HAS_TRAIT(src, TRAIT_BLIND))
		update_blindness()
/**
 * Force set the blindness of a mob to some level
 */
/mob/proc/set_blindness(amount)
	var/old_eye_blind = eye_blind
	eye_blind = max(amount, 0)
	if(!old_eye_blind || !eye_blind && !HAS_TRAIT(src, TRAIT_BLIND))
		update_blindness()


/// proc that adds and removes blindness overlays when necessary
/mob/proc/update_blindness()
	switch(stat)
		if(CONSCIOUS, SOFT_CRIT)
			if(HAS_TRAIT(src, TRAIT_BLIND) || eye_blind)
				throw_alert("blind", /atom/movable/screen/alert/blind)
				do_set_blindness(TRUE)
			else
				do_set_blindness(FALSE)
		if(UNCONSCIOUS, HARD_CRIT)
			do_set_blindness(TRUE)
		if(DEAD)
			do_set_blindness(FALSE)


///Proc that handles adding and removing the blindness overlays.
/mob/proc/do_set_blindness(now_blind)
	if(now_blind)
		overlay_fullscreen("blind", /atom/movable/screen/fullscreen/blind)
		// You are blind why should you be able to make out details like color, only shapes near you
		add_client_colour(/datum/client_colour/monochrome/blind)
		update_body()
	else
		clear_alert("blind")
		clear_fullscreen("blind")
		remove_client_colour(/datum/client_colour/monochrome/blind)
		update_body()


/**
 * Make the mobs vision blurry
 */
/mob/proc/blur_eyes(amount)
	if(amount>0)
		eye_blurry = max(amount, eye_blurry)
	update_eye_blur()

/**
 * Adjust the current blurriness of the mobs vision by amount
 */
/mob/proc/adjust_blurriness(amount)
	eye_blurry = max(eye_blurry+amount, 0)
	update_eye_blur()

///Set the mobs blurriness of vision to an amount
/mob/proc/set_blurriness(amount)
	eye_blurry = max(amount, 0)
	update_eye_blur()

///Apply the blurry overlays to a mobs clients screen
/mob/proc/update_eye_blur()
	if(!client)
		return
	var/atom/movable/screen/plane_master/floor/OT = locate(/atom/movable/screen/plane_master/floor) in client.screen
	var/atom/movable/screen/plane_master/game_world/GW = locate(/atom/movable/screen/plane_master/game_world) in client.screen
	GW.backdrop(src)
	OT.backdrop(src)

///Adjust the drugginess of a mob
/mob/proc/adjust_drugginess(amount)
	return

///Set the drugginess of a mob
/mob/proc/set_drugginess(amount)
	return

///Adjust the disgust level of a mob
/mob/proc/adjust_disgust(amount)
	return

///Set the disgust level of a mob
/mob/proc/set_disgust(amount)
	return

///Adjust the body temperature of a mob, with min/max settings
/mob/proc/adjust_bodytemperature(amount,min_temp=0,max_temp=INFINITY)
	if(bodytemperature >= min_temp && bodytemperature <= max_temp)
		bodytemperature = clamp(bodytemperature + amount,min_temp,max_temp)
