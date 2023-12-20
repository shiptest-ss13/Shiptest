/obj/item/assembly/timer
	name = "timer"
	desc = "Used to time things. Works well with contraptions which has to count down. Tick tock."
	icon_state = "timer"
	custom_materials = list(/datum/material/iron=500, /datum/material/glass=50)
	attachable = TRUE
	drop_sound = 'sound/items/handling/component_drop.ogg'
	pickup_sound =  'sound/items/handling/component_pickup.ogg'

	var/timing = FALSE
	var/time = 5
	var/saved_time = 5
	var/loop = FALSE
	var/hearing_range = 3

/obj/item/assembly/timer/Initialize()
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/item/assembly/timer/Destroy()
	STOP_PROCESSING(SSobj, src)
	. = ..()

/obj/item/assembly/timer/examine(mob/user)
	. = ..()
	. += "<span class='notice'>The timer is [timing ? "counting down from [time]":"set for [time] seconds"].</span>"

/obj/item/assembly/timer/activate()
	if(!..())
		return FALSE//Cooldown check
	timing = !timing
	update_appearance()
	return TRUE

/obj/item/assembly/timer/toggle_secure()
	secured = !secured
	if(secured)
		START_PROCESSING(SSobj, src)
	else
		timing = FALSE
		STOP_PROCESSING(SSobj, src)
	update_appearance()
	return secured

/obj/item/assembly/timer/proc/timer_end()
	if(!secured || next_activate > world.time)
		return FALSE
	pulse(FALSE)
	audible_message("[icon2html(src, hearers(src))] *beep* *beep* *beep*", null, hearing_range)
	for(var/mob/hearing_mob in get_hearers_in_view(hearing_range, src))
		hearing_mob.playsound_local(get_turf(src), 'sound/machines/triple_beep.ogg', ASSEMBLY_BEEP_VOLUME, TRUE)
	if(loop)
		timing = TRUE
	update_appearance()

/obj/item/assembly/timer/process()
	if(!timing)
		return
	time--
	if(time <= 0)
		timing = FALSE
		timer_end()
		time = saved_time

/obj/item/assembly/timer/update_appearance()
	. = ..()
	holder?.update_appearance()

/obj/item/assembly/timer/update_overlays()
	. = ..()
	attached_overlays = list()
	if(timing)
		. += "timer_timing"
		attached_overlays += "timer_timing"

/obj/item/assembly/timer/ui_status(mob/user)
	if(is_secured(user))
		return ..()
	return UI_CLOSE

/obj/item/assembly/timer/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Timer", name)
		ui.open()

/obj/item/assembly/timer/ui_data(mob/user)
	var/list/data = list()
	data["seconds"] = round(time % 60)
	data["minutes"] = round((time - data["seconds"]) / 60)
	data["timing"] = timing
	data["loop"] = loop
	return data

/obj/item/assembly/timer/ui_act(action, params)
	. = ..()
	if(.)
		return

	switch(action)
		if("time")
			timing = !timing
			if(timing && istype(holder, /obj/item/transfer_valve))
				log_bomber(usr, "activated a", src, "attachment on [holder]")
			update_appearance()
			. = TRUE
		if("repeat")
			loop = !loop
			. = TRUE
		if("input")
			var/value = text2num(params["adjust"])
			if(value)
				value = round(time + value)
				time = clamp(value, 1, 600)
				saved_time = time
				. = TRUE
