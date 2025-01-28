/datum/wires/photocopier
	holder_type = /obj/machinery/photocopier
	proper_name = "Photocopier"
	var/faction_iterator = 1
	var/list/faction_paths = list(
		'strings/blanks/clip_blanks.json',
		'strings/blanks/indie_blanks.json',
		'strings/blanks/inteq_blanks.json',
		'strings/blanks/nt_blanks.json',
		'strings/blanks/pgf_blanks.json',
		'strings/blanks/solcon_blanks.json',
		'strings/blanks/syndicate_blanks.json',
	)

/datum/wires/photocopier/New(atom/holder)
	var/obj/machinery/photocopier/machine = holder
	wires = list(WIRE_SHOCK, WIRE_FORMS)
	add_duds(1)

	// sync iterator and machine's faction
	for(var/i in faction_paths)
		if(machine.blanks_path == faction_paths[i])
			faction_iterator = i
			break
	..()

/datum/wires/photocopier/interactable(mob/user)
	. = ..()
	if(!.)
		return FALSE
	var/obj/machinery/photocopier/machine = holder
	if(!issilicon(user) && machine.seconds_electrified && machine.shock(user, 100))
		return FALSE
	if(machine.panel_open)
		return TRUE

/datum/wires/photocopier/get_status()
	var/obj/machinery/photocopier/machine = holder
	var/list/status = list()
	status += "A red light is [machine.seconds_electrified ? "blinking" : "off"]."
	status += "A blue light is [machine.blanks_path ? "on" : "off"]."
	status += "The toner indicator is [machine.toner_cartridge.charges ? "green" : "flashing red"]."
	return status

/datum/wires/photocopier/on_pulse(wire)
	var/obj/machinery/photocopier/machine = holder
	switch(wire)
		if(WIRE_SHOCK)
			machine.seconds_electrified = MACHINE_DEFAULT_ELECTRIFY_TIME
		if(WIRE_FORMS)
			faction_iterator %= length(faction_paths)
			faction_iterator++
			machine.blanks_path = faction_paths[faction_iterator]

/datum/wires/photocopier/on_cut(wire, mend)
	var/obj/machinery/photocopier/machine = holder
	switch(wire)
		if(WIRE_SHOCK)
			machine.seconds_electrified = (mend) ? MACHINE_NOT_ELECTRIFIED : MACHINE_ELECTRIFIED_PERMANENT
		if(WIRE_FORMS)
			machine.blanks_path = (mend) ? faction_paths[faction_iterator] : null
