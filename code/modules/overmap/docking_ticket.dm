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
	target_port = _target_port
	if(target_port?.current_docking_ticket)
		docking_error = "[target_port] is already being docked to!"
		return
	if(target_port)
		target_port.current_docking_ticket = src

	issuer = _issuer
	target = _target
	if(target.current_docking_ticket)
		docking_error = "[target] is already docking!"
		return
	target.current_docking_ticket = src

	docking_error = _docking_error

/datum/docking_ticket/Destroy(force, ...)
	if(target)
		target.current_docking_ticket = null
	if(target_port)
		target_port.current_docking_ticket = null

	return ..()
