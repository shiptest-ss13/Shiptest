/atom/movable/screen/alert/status_effect/accelerando
	name = "Accelerando"
	desc = "Out of sync. Out of time. Yet you're still here?"
	icon_state = "accelerando"

/datum/status_effect/accelerando
	id = "accelerando"
	alert_type = /atom/movable/screen/alert/status_effect/accelerando
	tick_interval = 5
	duration = STATUS_EFFECT_AUTO_TICK
	status_type = STATUS_EFFECT_UNIQUE
	///how.. bad is it?
	var/intensity = null
	///do we die at the end
	var/fatal = FALSE

/datum/status_effect/accelerando/on_creation(mob/living/new_owner, _duration = 10 SECONDS)
	duration = _duration
	return ..()

/datum/status_effect/accelerando/on_apply()
	. = ..()
	owner.add_filter("chronoblur", 1, motion_blur_filter(0, 0))
	owner.overlay_fullscreen("anomaly", /atom/movable/screen/fullscreen/chronograph)
	owner.add_movespeed_modifier(/datum/movespeed_modifier/chronograph, FALSE, 0)
	owner.visible_message(span_notice("[owner] is moving outside of local space/time!"), span_warning("The pondering nature of reality becomes obvious as you desynchronize from time!"))
	//once i get actionspeed modifiers in this'll need to be converted. It works for now
	if(ishuman(owner))
		var/mob/living/carbon/human/distortion = owner
		distortion.physiology.do_after_speed -= 0.6


/datum/status_effect/accelerando/tick(seconds_between_ticks)
	//the max duration is 1800, so max power is 18, that means someone stood inside the chronograph for a bit.

	var/time_left_in_seconds = (duration - world.time) / 10

	var/power = time_left_in_seconds / 10
	if(power > 4)
		animate(owner.get_filter("chronoblur"), 5, x = rand(-2, 2), y = rand(-2, 2))
		intensity = 0

	//don't run the est for nonhumans
	if(!ishuman(owner))
		return
	var/mob/living/carbon/human/beached = owner

	if(power > 8 || fatal)
		if(SPT_PROB(10, seconds_between_ticks))
			to_chat(beached, span_warning("Your flesh reknits and heals over the wounds of yesterday!"))
		intensity = 2
		owner.adjustBruteLoss(-2)
		owner.adjustFireLoss(-2)
		owner.adjustOxyLoss(-1)
		owner.adjustToxLoss(-1)

	//warn them of the intensity with greying
	if(power > 12)
		beached.hair_color = "#B2B2B2"
		beached.facial_hair_color = "#B2B2B2"
		beached.update_hair()
		intensity = 3

	//age them if they stand in the fucking field what the fuck are you doing
	if(power > 17 || fatal)
		if(SPT_PROB(5, seconds_between_ticks))
			to_chat(owner, span_userdanger("A year slips away from you."))
			beached.age += 1
		for(var/i in beached.all_wounds)
			var/datum/wound/iter_wound = i
			iter_wound.remove_wound()
		beached.hair_color = "#FFFFFF"
		beached.facial_hair_color = "#FFFFFF"
		beached.update_hair()
		intensity = 4

/datum/status_effect/accelerando/on_remove()
	if(..())
		return
	addtimer(CALLBACK(owner, PROC_REF(remove_filter), "chronoblur"), 20)
	owner.remove_movespeed_modifier(/datum/movespeed_modifier/chronograph)
	owner.clear_fullscreen("anomaly")
	if(ishuman(owner))
		var/mob/living/carbon/human/distortion = owner
		distortion.physiology.do_after_speed += 0.6

	owner.visible_message(span_notice("[owner] has re-integrated with local time!"), span_warning("You feel a lurching as your body suddenly re-integrates with local time!"))
	if(fatal)
		to_chat(owner, span_userdanger("This is as far as you'll ever go. Wasn't it sweet?"))
		owner.seizure()
		owner.overlay_fullscreen("death", /atom/movable/screen/fullscreen/chronograph_death)
		addtimer(CALLBACK(owner, TYPE_PROC_REF(/mob, clear_fullscreen), "death", 10 SECONDS), 3 SECONDS)
		addtimer(CALLBACK(owner, TYPE_PROC_REF(/mob, dust)), 3 SECONDS)
		do_sparks(12, FALSE, owner, /datum/effect_system/spark_spread/blue)
		return

	if(intensity >= 2)
		owner.adjust_disgust(75) //WHY IS EVERYTHING SO SLOW
		owner.confused += 20

	if(intensity >= 4)
		owner.adjust_disgust(150)
		owner.confused += 20
		owner.Paralyze(10)

/datum/status_effect/accelerando/get_examine_text()
	if(fatal)
		return span_boldwarning("[owner.p_they(TRUE)] [owner.p_are()] moving faster and faster in every instant!")
	switch(duration - world.time)
		if(2 MINUTES to INFINITY)
			return span_boldwarning("[owner.p_they(TRUE)] [owner.p_are()] keeping an unnatural pace on the edge of time!")
		if(1 MINUTES to 2 MINUTES)
			return span_warning("[owner.p_they(TRUE)] [owner.p_are()] darting back and forth between the edges of a moment.")
		if(0 to 1 MINUTES)
			return span_warning("[owner.p_they(TRUE)] [owner.p_are()] out of alignment with the world.")

	return null

/datum/status_effect/accelerando/fatal
	fatal = TRUE
	remove_on_fullheal = FALSE
