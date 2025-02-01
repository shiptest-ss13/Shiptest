/datum/docking_ticket
	/// The docking port reserved for the ticket target
	var/obj/docking_port/stationary/target_port
	/// The overmap object that issued this ticket and owns the target port
	var/datum/overmap/issuer
	/// The overmap object that should recieve this ticket and will dock at the target port
	var/datum/overmap/target
	/// An error that should be shown to players, if there's an issue. Should be null if no error.
	var/docking_error

/datum/docking_ticket/New(_target_port, _issuer, _target, _docking_error)
	docking_error = _docking_error
	if(docking_error)
		return

	if(!_target_port)
		docking_error = "No target port specified!"
		return
	target_port = _target_port
	if(target_port.current_docking_ticket)
		docking_error = "[target_port] is already being docked to!"
		return
	target_port.current_docking_ticket = src

	if(!_issuer)
		docking_error = "No issuer overmap datum specified!"
		return
	issuer = _issuer

	if(!_target)
		docking_error = "No target overmap datum specified!"
		return
	target = _target
	if(target.current_docking_ticket)
		docking_error = "[target] is already docking!"
		return
	target.current_docking_ticket = src


/datum/docking_ticket/Destroy(force)
	if(target)
		target.current_docking_ticket = null
		target = null
	if(target_port)
		target_port.current_docking_ticket = null
		target_port = null

	return ..()
