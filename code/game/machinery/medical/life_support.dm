/obj/machinery/medical/life_support
	name = "life support unit"
	desc = "A bulky table with a lot of blinking lights installed and a small monitor that checks the users health."
	icon = 'icons/obj/machines/medical/life_support.dmi'
	icon_state = "basic"
	circuit = /obj/item/circuitboard/machine/life_support
	idle_power_usage = 100
	active_power_usage = 1000
	///Maximum damage someone can have and still live while hooked up
	var/health_treshold = -200
	///Determines if this is active or not.
	var/active = TRUE
	///Sound that plays at stable health levels
	var/datum/looping_sound/ekg/soundloop_ekg
	///Sound that plays at dangerous health levels
	var/datum/looping_sound/ekg_fast/soundloop_ekg_fast
	///Sound that plays at lethal health levels
	var/datum/looping_sound/ekg_slow/soundloop_ekg_slow
	///Sound that plays when the user is dead
	var/datum/looping_sound/flatline/soundloop_flatline

/obj/machinery/medical/life_support/Initialize()
	. = ..()
	soundloop_ekg = new(list(src), FALSE)
	soundloop_ekg_slow = new(list(src), FALSE)
	soundloop_ekg_fast = new(list(src), FALSE)
	soundloop_flatline = new(list(src), FALSE)

/obj/machinery/medical/life_support/Destroy()
	QDEL_NULL(soundloop_ekg)
	QDEL_NULL(soundloop_ekg_fast)
	QDEL_NULL(soundloop_ekg_slow)
	QDEL_NULL(soundloop_flatline)
	return ..()

/obj/machinery/medical/life_support/update_overlays()
	. = ..()
	var/mutable_appearance/monitor_overlay
	if(machine_stat && (NOPOWER|BROKEN))
		monitor_overlay = mutable_appearance(icon, "nopower")
		. += monitor_overlay
		return

	if(!attached || !active)
		monitor_overlay =  mutable_appearance(icon,"noone")
		. += monitor_overlay
		return

	if(attached.stat == DEAD)
		monitor_overlay = mutable_appearance(icon, "death")
		. += monitor_overlay
		return

	switch(attached.health)
		if(-INFINITY to HEALTH_THRESHOLD_DEAD)
			monitor_overlay = mutable_appearance(icon, "death")
		if(HEALTH_THRESHOLD_DEAD + 1 to HEALTH_THRESHOLD_FULLCRIT)
			monitor_overlay = mutable_appearance(icon, "hardcrit")
		if(HEALTH_THRESHOLD_FULLCRIT + 1 to HEALTH_THRESHOLD_CRIT)
			monitor_overlay = mutable_appearance(icon, "softcrit")
		if(1 to INFINITY)
			monitor_overlay = mutable_appearance(icon, "alive")
	. += monitor_overlay

/obj/machinery/medical/life_support/wrench_act(mob/living/user, obj/item/I)
	. = ..()
	active = anchored
	return

/obj/machinery/medical/life_support/clear_status()
	. = ..()
	attached.remove_status_effect(STATUS_EFFECT_LIFE_SUPPORT, STASIS_MACHINE_EFFECT)
	attached.update_stat()

/obj/machinery/medical/life_support/process()
	. = ..()
	update_sound()
	if(!active || !attached)
		return

	if(attached.health < health_treshold)
		clear_status()
		return

	attached.apply_status_effect(STATUS_EFFECT_LIFE_SUPPORT, STASIS_MACHINE_EFFECT)
	attached.update_stat()
	return

/obj/machinery/medical/life_support/proc/update_sound()
	if(!active || !attached)
		soundloop_ekg.stop()
		soundloop_ekg_slow.stop()
		soundloop_ekg_fast.stop()
		soundloop_flatline.stop()

	if(attached.stat == DEAD)
		soundloop_flatline.start()
		soundloop_ekg.stop()
		soundloop_ekg_slow.stop()
		soundloop_ekg_fast.stop()
		return

	switch(attached.health)
		if(-INFINITY to HEALTH_THRESHOLD_DEAD)
			soundloop_flatline.start()
			soundloop_ekg_slow.stop()
		if(HEALTH_THRESHOLD_DEAD+1 to HEALTH_THRESHOLD_FULLCRIT)
			soundloop_flatline.stop()
			soundloop_ekg_slow.start()
			soundloop_ekg_fast.stop()
		if(HEALTH_THRESHOLD_FULLCRIT+1 to HEALTH_THRESHOLD_CRIT)
			soundloop_flatline.stop()
			soundloop_ekg_fast.start()
			soundloop_ekg.stop()
		if(1 to INFINITY)
			soundloop_flatline.stop()
			soundloop_ekg.start()
/* 
 * TODO: Make this use a cell
/obj/machinery/medical/life_support/mobile
	name = "portable life support unit"
	desc = "A miracle of modern engineering, allows you to suspend someone in a coma-like state, wherever you go!"
	icon_state = "mobile"
	circuit = /obj/item/circuitboard/machine/life_support/mobile
	idle_power_usage = 100
	active_power_usage = 1000
	anchored = FALSE

/obj/machinery/medical/life_support/mobile/wrench_act(mob/living/user, obj/item/I) //unewrenchable
	return
*/
