// DEBUG FIX: i don't like that this merges spawn location-ness with a bank account
/datum/component/overmap/spawn_location
	/// Display name on the manifest readout
	var/manifest_name
	/// Assoc list of remaining open job slots (job = remaining slots)
	var/list/job_slots = list("Assistant" = 5, "Captain" = 1)
	/// Manifest list of people on the entity
	var/list/manifest = list()
	/// List of spawn points on the entity
	var/list/atom/spawn_points = list()
	/// Entity-wide bank account
	var/datum/bank_account/ship/account

/datum/component/overmap/spawn_location/Initialize(_manifest_name, _job_slots)
	. = ..()
	if(. == COMPONENT_INCOMPATIBLE)
		return
	// shut up linter
	var/datum/overmap_ent/e_parent = parent
	LAZYADD(SSovermap.spawn_comps, src)

	manifest_name = _manifest_name
	job_slots = _job_slots
	account = new(e_parent.name, 7500)

/datum/component/overmap/spawn_location/Destroy()
	. = ..()
	LAZYREMOVE(SSovermap.spawn_comps, src)
	QDEL_NULL(account)

/// Bastardized version of GLOB.manifest.manifest_inject, but used per ship
/datum/component/overmap/spawn_location/proc/manifest_inject(mob/living/carbon/human/H, client/C)
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
