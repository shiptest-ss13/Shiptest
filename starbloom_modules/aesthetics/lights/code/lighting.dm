/obj/machinery/light
	icon = 'starbloom_modules/aesthetics/lights/icons/lighting.dmi'
	overlay_icon = 'starbloom_modules/aesthetics/lights/icons/lighting_overlay.dmi'
	var/maploaded = FALSE //So we don't have a lot of stress on startup.
	var/turning_on = FALSE //More stress stuff.
	var/constant_flickering = FALSE // Are we always flickering?
	var/flicker_timer = null
	var/roundstart_flicker = FALSE
	var/firealarm = FALSE

/obj/machinery/light/proc/turn_on(trigger, play_sound = TRUE)
	if(QDELETED(src))
		return
	turning_on = FALSE
	if(!on)
		return
	var/BR = brightness
	var/PO = bulb_power
	var/CO = bulb_colour
	if(color)
		CO = color
	if (firealarm)
		CO = bulb_emergency_colour
	else if (nightshift_enabled)
		BR = nightshift_brightness
		PO = nightshift_light_power
		if(!color)
			CO = nightshift_light_color
	var/matching = light && BR == light.light_range && PO == light.light_power && CO == light.light_color
	if(!matching)
		switchcount++
		if(rigged)
			if(status == LIGHT_OK && trigger)
				explode()
		else if( prob( min(60, (switchcount**2)*0.01) ) )
			if(trigger)
				burn_out()
		else
			use_power = ACTIVE_POWER_USE
			set_light(BR, PO, CO)
			if(play_sound)
				playsound(src.loc, 'starbloom_modules/aesthetics/lights/sound/light_on.ogg', 65, 1)

/obj/machinery/light/proc/start_flickering()
	on = FALSE
	update(FALSE, TRUE, FALSE)

	constant_flickering = TRUE

	flicker_timer = addtimer(CALLBACK(src, .proc/flicker_on), rand(5, 10))

/obj/machinery/light/proc/stop_flickering()
	constant_flickering = FALSE

	if(flicker_timer)
		deltimer(flicker_timer)
		flicker_timer = null

	set_on(has_power())

/obj/machinery/light/proc/alter_flicker(enable = TRUE)
	if(!constant_flickering)
		return
	if(has_power())
		on = enable
		update(FALSE, TRUE, FALSE)

/obj/machinery/light/proc/flicker_on()
	alter_flicker(TRUE)
	flicker_timer = addtimer(CALLBACK(src, .proc/flicker_off), rand(5, 10))

/obj/machinery/light/proc/flicker_off()
	alter_flicker(FALSE)
	flicker_timer = addtimer(CALLBACK(src, .proc/flicker_on), rand(5, 50))

/obj/machinery/light/proc/firealarm_on()
	SIGNAL_HANDLER

	firealarm = TRUE
	update()

/obj/machinery/light/proc/firealarm_off()
	SIGNAL_HANDLER

	firealarm = FALSE
	update()

/obj/machinery/light/Initialize(mapload = TRUE)
	. = ..()
	if(on)
		maploaded = TRUE

	if(roundstart_flicker)
		start_flickering()

/obj/item/light/tube
	icon = 'starbloom_modules/aesthetics/lights/icons/lighting.dmi'

