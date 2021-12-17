// This file contains code for the same path as simulated.dm has, but this is focused on more data-specific variables
// such as job slots, bank accounts, and manifest data.

/obj/structure/overmap/ship/simulated
	///Assoc list of remaining open job slots (job = remaining slots)
	var/list/job_slots = list("Captain" = 1, "Assistant" = 5)
	///Manifest list of people on the ship
	var/list/manifest = list()
	///Shipwide bank account
	var/datum/bank_account/ship/ship_account
	///Whether or not new players are allowed to join the ship
	var/join_allowed = TRUE
	///Short memo of the ship shown to new joins
	var/memo = ""
	///Time that next job slot change can occur
	var/job_slot_adjustment_cooldown = 0

/obj/structure/overmap/ship/simulated/Initialize(mapload, obj/docking_port/mobile/_shuttle)
	. = ..()
	job_slots = shuttle.source_template.job_slots.Copy()
	ship_account = new(name, 7500)

/**
  * Bastardized version of GLOB.manifest.manifest_inject, but used per ship
  *
  */
/obj/structure/overmap/ship/simulated/proc/manifest_inject(mob/living/carbon/human/H, client/C)
	set waitfor = FALSE
	if(H.mind && (H.mind.assigned_role != H.mind.special_role))
		LAZYINITLIST(manifest)
		var/assignment
		if(H.mind.assigned_role)
			assignment = H.mind.assigned_role
		else if(H.job)
			assignment = H.job
		else
			assignment = "Unassigned"

		if(C && C.prefs && C.prefs.alt_titles_preferences[assignment])
			assignment = C.prefs.alt_titles_preferences[assignment]

		manifest[H.real_name] = assignment
