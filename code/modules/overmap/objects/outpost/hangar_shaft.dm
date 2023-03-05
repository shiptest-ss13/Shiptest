// DEBUG: document
/datum/hangar_shaft
	var/name

	var/datum/elevator_master/shaft_elevator
	var/list/datum/hangar/hangars = list()

/datum/hangar_shaft/New(_name, datum/elevator_master/_elevator)
	// DEBUG: do something with the name
	if(_name)
		name = _name

	if(_elevator)
		shaft_elevator = _elevator
	else
		// DEBUG: implement hangar shafts that start without an anchor

/datum/hangar
	var/obj/docking_port/stationary/dock

/datum/hangar/New(obj/docking_port/stationary/_dock)
	dock = _dock
