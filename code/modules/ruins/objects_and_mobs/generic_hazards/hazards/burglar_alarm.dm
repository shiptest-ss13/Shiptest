/obj/structure/hazard/floor/burglar_alarm
	name = "burglar alarm"
	desc = "Triggers an alarm when stepped upon."
	icon_state = "b-alarm"
	contact_damage = TRUE //required for triggering it seems
	dealt_damage = 0
	light_color = "#D74722"
	can_be_disabled = TRUE
	disable_text = "unscrewing the panel and cutting the wires"
	var/intruder_message = "INTRUDER DETECTED!"
	var/hatch_open = FALSE

/obj/structure/hazard/floor/burglar_alarm/contact(src)
	var/area/alarmed = get_area(src)
	alarmed.burglaralert(src)
	playsound(src, 'sound/machines/click.ogg', 60, TRUE)
	playsound(src, 'sound/effects/alert.ogg', 50, TRUE)
	say(intruder_message)
	for(var/obj/structure/hazard/floor/burglar_alarm/alarms in alarmed)
		alarms.disable()

/obj/structure/hazard/floor/burglar_alarm/update_appearance()
	. = ..()
	if(!on || disabled)
		light_range = 0
		if(!hatch_open)
			icon_state = "b-alarm"
		else
			icon_state = "b-alarm-o"
	else
		light_range = 1
		if(!hatch_open)
			icon_state = "b-alarm-armed"
		else
			icon_state = "b-alarm-armed-o"

/obj/structure/hazard/floor/burglar_alarm/attackby(obj/item/I, mob/user)
	if(!can_be_disabled)
		return
	if(I.tool_behaviour == TOOL_SCREWDRIVER)
		hatch_open = !hatch_open
		to_chat(user, span_notice("You [hatch_open ? "open" : "close"] \the [src]'s panel."))
		I.play_tool_sound(src, 50)
		update_appearance()
		return
	if(I.tool_behaviour == TOOL_WIRECUTTER && hatch_open)
		if(!disabled)
			if(I.use_tool(src, user, time_to_disable, volume=100))
				to_chat(user, span_notice("You snip the wires in the [src]."))
				disable()
		else
			to_chat(user, span_notice("The [src] has already been disabled!"))
