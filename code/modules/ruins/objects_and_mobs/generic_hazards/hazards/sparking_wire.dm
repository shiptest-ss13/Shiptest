/obj/structure/hazard/fire/wires
	name = "sparking wires"
	desc = "A couple of sparking wires. There doesn't seem to be much voltage in them, but hopefully they don't catch on anything."
	icon_state = "wiremess"

/obj/structure/hazard/fire/wires/alarm
	alarm_sensitive = TRUE
	on = FALSE

/obj/structure/hazard/fire/wires/alarm/alarm_act()
	do_random_effect()
	return
