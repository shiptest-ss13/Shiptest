/datum/wires/shieldwallgen
	holder_type = /obj/machinery/power/shieldwallgen
	proper_name = "Shield Generator"

/datum/wires/shieldwallgen/New(atom/holder)
	wires = list(
		WIRE_ACTIVATE,
		WIRE_DISABLE,
		WIRE_SHOCK
	)
	add_duds(2)
	..()

/datum/wires/shieldwallgen/interactable(mob/user)
	var/obj/machinery/shieldwallgen/G = holder
	if(R.panel_open)
		return TRUE

/datum/wires/shieldwallgen/get_status()
	var/obj/machinery/shieldwallgen/G = holder
	var/list/status = list()
	status += "The interface light is [G.locked ? "green" : "red"]."
	status += "The activity light is [G.active ? "blinking steadily" : "off"]."
	return status

/datum/wires/shieldwallgen/on_pulse(wire)
	var/obj/machinery/shieldwallgen/G = holder
	switch(wire)
		if(WIRE_SHOCK)
			G.shocked = !G.shocked
			addtimer(CALLBACK(G, /obj/machinery/autolathe.proc/reset, wire), 60)
		if(WIRE_ACTIVATE)
			G.toggle()
		if(WIRE_DISABLE)
			G.locked = !G.locked

/datum/wires/shieldwallgen/on_cut(wire, mend)
	var/obj/machinery/shieldwallgen/G = holder
	switch(wire)
		if(WIRE_SHOCK)
			G.shocked = !mend
		if(WIRE_ACTIVATE)
			if(!mend)
				G.active = FALSE
		if(WIRE_DISABLE)
			G.locked = !mend
