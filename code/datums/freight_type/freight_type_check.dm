// Used by the objective system to track the progress of a freight_type check
// Once the check is completed, check that group_status is still TRUE
// and make sure there are no untracked_contents left (unless you're okay with garbage in your amazon prime box :))

/datum/freight_type_check
	// At the start of a check, the raw container and its contents go here
	var/obj/container
	var/list/untracked_contents = list()

	// At the end of a check, untracked contents are filtered into approved contents and a global status is set in this datum
	var/list/approved_contents = list()
	var/list/groups_refused = list()

	// If one group doesn't like the results of the shipment, the whole check is cancelled and rejection kicks in
	var/group_status = TRUE

/datum/freight_type_check/New( var/obj/_container )
	container = _container
