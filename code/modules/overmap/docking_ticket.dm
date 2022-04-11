/datum/docking_ticket
	/// The docking port reserved for the ticket target
	var/obj/docking_port/stationary/target_port
	/// The overmap object that issued this ticket and owns the target port
	var/datum/overmap/issuer
	/// The overmap object that should recieve this ticket and will dock at the target port
	var/datum/overmap/target

/datum/docking_ticket/New(_target_port, _issuer, _target)
	target_port = _target_port
	issuer = _issuer
	target = _target
