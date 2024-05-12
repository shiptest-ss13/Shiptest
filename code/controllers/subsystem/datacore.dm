
///Dummy mob reserve slot for manifest
#define DUMMY_HUMAN_SLOT_MANIFEST "dummy_manifest_generation"

SUBSYSTEM_DEF(datacore)
	name = "Data Core"
	flags = SS_NO_FIRE
	init_order = INIT_ORDER_DATACORE

	/// A list of data libraries keyed by DATACORE_RECORDS_*
	var/list/datum/data_library/library = list(
		DATACORE_RECORDS_STATION,
		DATACORE_RECORDS_SECURITY,
		DATACORE_RECORDS_MEDICAL,
		DATACORE_RECORDS_LOCKED,
		DATACORE_RECORDS_DAEDALUS,
		DATACORE_RECORDS_AETHER,
		DATACORE_RECORDS_HERMES,
		DATACORE_RECORDS_MARS
	)

	var/securityPrintCount = 0
	var/securityCrimeCounter = 0
	var/medicalPrintCount = 0

	/// Set to TRUE when the initial roundstart manifest is complete
	var/finished_setup = FALSE

	var/list/datum/callback/datacore_ready_callbacks = list()

/datum/controller/subsystem/datacore/Initialize(start_timeofday)
	for(var/id in library)
		library[id] = new /datum/data_library
	return ..()

/datum/controller/subsystem/datacore/Recover()
	library = SSdatacore.library
	securityCrimeCounter = SSdatacore.securityCrimeCounter
	medicalPrintCount = SSdatacore.medicalPrintCount
	finished_setup = SSdatacore.finished_setup

/// Returns a data record or null.
/datum/controller/subsystem/datacore/proc/get_record_by_name(name, record_type = DATACORE_RECORDS_STATION)
	RETURN_TYPE(/datum/data/record)

	return library[record_type].get_record_by_name(name)

/// Returns a data library's records list
/datum/controller/subsystem/datacore/proc/get_records(record_type = DATACORE_RECORDS_STATION)
	RETURN_TYPE(/list)
	return library[record_type].records

/datum/controller/subsystem/datacore/proc/find_record(field, needle, haystack)
	RETURN_TYPE(/datum/data/record)
	for(var/datum/data/record/record_to_check in get_records(haystack))
		if(record_to_check.fields[field] == needle)
			return record_to_check

/// Empties out a library
/datum/controller/subsystem/datacore/proc/wipe_records(record_type)
	var/datum/data_library/to_wipe = library[record_type]
	if(!to_wipe)
		return

	QDEL_LIST(to_wipe.records)

/// Grab all PDA network IDs by department.
/datum/controller/subsystem/datacore/proc/get_pda_netids(record_type = DATACORE_RECORDS_STATION)
	RETURN_TYPE(/list)
	. = list()

	for(var/datum/data/record/R as anything in get_records(record_type))
		var/id = R.fields[DATACORE_PDA_ID]
		if(id)
			. += id

/// Removes a person from history. Except locked. That's permanent history.
/datum/controller/subsystem/datacore/proc/demanifest(name)
	for(var/id in library - DATACORE_RECORDS_LOCKED)
		var/datum/data/record/R = get_record_by_name(name, id)
		qdel(R)

/datum/controller/subsystem/datacore/proc/inject_record(datum/data/record/R, record_type)
	if(isnull(record_type))
		CRASH("inject_record() called with no record type")

	library[record_type].inject_record(R)

/// Create the roundstart manifest using the newplayer list.
/datum/controller/subsystem/datacore/proc/generate_manifest()
	for(var/mob/dead/new_player/N as anything in GLOB.new_player_list)
		if(N.new_character)
			log_manifest(N.ckey, N.new_character.mind, N.new_character)

		if(ishuman(N.new_character))
			manifest_inject(N.new_character, N.client)

		CHECK_TICK

	finished_setup = TRUE
	//SEND_GLOBAL_SIGNAL(COMSIG_GLOB_DATACORE_READY, src)
	invoke_datacore_callbacks()

/// Add a callback to execute when the datacore has loaded
/datum/controller/subsystem/datacore/proc/OnReady(datum/callback/CB)
	if(finished_setup)
		CB.InvokeAsync()
	else
		datacore_ready_callbacks += CB

/datum/controller/subsystem/datacore/proc/invoke_datacore_callbacks()
	for(var/datum/callback/CB as anything in datacore_ready_callbacks)
		CB.InvokeAsync()

	datacore_ready_callbacks.Cut()

/datum/controller/subsystem/datacore/proc/manifest_modify(name, assignment, trim)
	var/datum/data/record/foundrecord = library[DATACORE_RECORDS_STATION].get_record_by_name(name)
	if(foundrecord)
		foundrecord.fields[DATACORE_RANK] = assignment
		foundrecord.fields[DATACORE_TRIM] = trim

/datum/controller/subsystem/datacore/proc/get_manifest(record_type = DATACORE_RECORDS_STATION)
	// First we build up the order in which we want the departments to appear in.
	var/list/manifest_out = list()
	for(var/datum/job_department/department as anything in SSjob.departments)
		if(department.exclude_from_latejoin)
			continue
		manifest_out[department.department_name] = list()

	manifest_out[DEPARTMENT_UNASSIGNED] = list()

	var/list/departments_by_type = SSjob.departments_by_type

	for(var/datum/data/record/record as anything in SSdatacore.get_records(record_type))
		var/name = record.fields[DATACORE_NAME]
		var/rank = record.fields[DATACORE_RANK] // user-visible job
		var/trim = record.fields[DATACORE_TRIM] // internal jobs by trim type
		var/datum/job/job = SSjob.GetJob(trim)

		// Filter out jobs that aren't on the manifest, move them to "unassigned"
		if(!job || !(job.job_flags & JOB_CREW_MANIFEST) || !LAZYLEN(job.departments_list))
			var/list/misc_list = manifest_out[DEPARTMENT_UNASSIGNED]
			misc_list[++misc_list.len] = list(
				"name" = name,
				"rank" = rank,
				"trim" = trim,
				)
			continue

		for(var/department_type as anything in job.departments_list)
			var/datum/job_department/department = departments_by_type[department_type]

			if(!department)
				stack_trace("get_manifest() failed to get job department for [department_type] of [job.type]")
				continue

			if(department.is_not_real_department)
				continue

			var/list/entry = list(
				"name" = name,
				"rank" = rank,
				"trim" = trim,
				)

			var/list/department_list = manifest_out[department.department_name]
			if(istype(job, department.department_head))
				department_list.Insert(1, null)
				department_list[1] = entry
			else
				department_list[++department_list.len] = entry

	// Trim the empty categories.
	for (var/department in manifest_out)
		if(!length(manifest_out[department]))
			manifest_out -= department

	return manifest_out

/datum/controller/subsystem/datacore/proc/get_manifest_html(record_key = DATACORE_RECORDS_STATION, monochrome = FALSE)
	var/list/manifest = get_manifest(record_key)
	var/dat = {"
	<head><style>
		.manifest {border-collapse:collapse;}
		.manifest td, th {border:1px solid [monochrome?"black":"#DEF; background-color:white; color:black"]; padding:.25em}
		.manifest th {height: 2em; [monochrome?"border-top-width: 3px":"background-color: #48C; color:white"]}
		.manifest tr.head th { [monochrome?"border-top-width: 1px":"background-color: #488;"] }
		.manifest tr.alt td {[monochrome?"border-top-width: 2px":"background-color: #DEF"]}
	</style></head>
	<table class="manifest" width='350px'>
	<tr class='head'><th>Name</th><th>Rank</th></tr>
	"}
	for(var/department in manifest)
		var/list/entries = manifest[department]
		dat += "<tr><th colspan=3>[department]</th></tr>"
		//JUST
		var/even = FALSE
		for(var/entry in entries)
			var/list/entry_list = entry
			dat += "<tr[even ? " class='alt'" : ""]><td>[entry_list["name"]]</td><td>[entry_list["rank"] == entry_list["trim"] ? entry_list["rank"] : "[entry_list["rank"]] ([entry_list["trim"]])"]</td></tr>"
			even = !even

	dat += "</table>"
	dat = replacetext(dat, "\n", "")
	dat = replacetext(dat, "\t", "")
	return dat

/datum/controller/subsystem/datacore/proc/manifest_inject(mob/living/carbon/human/H, client/C)
	SHOULD_NOT_SLEEP(TRUE)
	var/static/list/show_directions = list(SOUTH, WEST)
	if(!(H.mind?.assigned_role.job_flags & JOB_CREW_MANIFEST))
		return

	var/datum/job/job = H.mind.assigned_role
	var/assignment = H.mind.assigned_role.title

	//PARIAH EDIT ADDITION
	// The alt job title, if user picked one, or the default
	var/chosen_assignment = C?.prefs.alt_job_titles[assignment] || assignment
	//PARIAH EDIT END

	var/static/record_id_num = 1001
	var/id = num2hex(record_id_num++,6)
	if(!C)
		C = H.client

	var/mutable_appearance/character_appearance = new(H.appearance)
	remove_non_canon_overlays(character_appearance)

	//General Record
	var/datum/data/record/general/G = new()
	G.fields[DATACORE_ID] = id

	G.fields[DATACORE_NAME] = H.real_name
	G.fields[DATACORE_RANK] = chosen_assignment //PARIAH EDIT
	G.fields[DATACORE_TRIM] = assignment
	G.fields[DATACORE_INITIAL_RANK] = assignment
	G.fields[DATACORE_AGE] = H.age
	G.fields[DATACORE_SPECIES] = H.dna.species.name
	G.fields[DATACORE_FINGERPRINT] = H.get_fingerprints(TRUE)
	G.fields[DATACORE_PHYSICAL_HEALTH] = "Active"
	G.fields[DATACORE_MENTAL_HEALTH] = "Stable"
	G.fields[DATACORE_GENDER] = H.gender
	if(H.gender == "male")
		G.fields[DATACORE_GENDER] = "Male"
	else if(H.gender == "female")
		G.fields[DATACORE_GENDER] = "Female"
	else
		G.fields[DATACORE_GENDER] = "Other"
	G.fields[DATACORE_APPEARANCE] = character_appearance
	var/obj/item/modular_computer/tablet/pda/pda = locate() in H
	if(pda)
		var/obj/item/computer_hardware/network_card/packetnet/rfcard = pda.all_components[MC_NET]
		if(istype(rfcard))
			G.fields[DATACORE_PDA_ID] = rfcard.hardware_id

	library[DATACORE_RECORDS_STATION].inject_record(G)

	// Add to company-specific manifests
	var/datum/job_department/department = SSjob.departments_by_type[job.departments_list?[1]]
	if(department?.manifest_key)
		library[department.manifest_key].inject_record(G)

	//Medical Record
	var/datum/data/record/medical/M = new()
	M.fields[DATACORE_ID] = id
	M.fields[DATACORE_NAME] = H.real_name
	M.fields[DATACORE_BLOOD_TYPE] = H.dna.blood_type.name
	M.fields[DATACORE_BLOOD_DNA] = H.dna.unique_enzymes
	M.fields[DATACORE_DISABILITIES] = H.get_quirk_string(FALSE, CAT_QUIRK_DISABILITIES)
	M.fields[DATACORE_DISABILITIES_DETAILS] = H.get_quirk_string(TRUE, CAT_QUIRK_DISABILITIES)
	M.fields[DATACORE_DISEASES] = "None"
	M.fields[DATACORE_DISEASES_DETAILS] = "No diseases have been diagnosed at the moment."
	M.fields[DATACORE_NOTES] = H.get_quirk_string(FALSE, CAT_QUIRK_NOTES)
	M.fields[DATACORE_NOTES_DETAILS] = H.get_quirk_string(TRUE, CAT_QUIRK_NOTES)
	library[DATACORE_RECORDS_MEDICAL].inject_record(M)

	//Security Record
	var/datum/data/record/security/S = new()
	S.fields[DATACORE_ID] = id
	S.fields[DATACORE_NAME] = H.real_name
	S.fields[DATACORE_CRIMINAL_STATUS] = CRIMINAL_NONE
	S.fields[DATACORE_CITATIONS] = list()
	S.fields[DATACORE_CRIMES] = list()
	S.fields[DATACORE_NOTES] = "No notes."
	library[DATACORE_RECORDS_SECURITY].inject_record(S)

	//Locked Record
	var/datum/data/record/locked/L = new()
	L.fields[DATACORE_ID] = id
	L.fields[DATACORE_NAME] = H.real_name
	// L.fields[DATACORE_RANK] = assignment //ORIGINAL
	L.fields[DATACORE_RANK] = chosen_assignment  //PARIAH EDIT
	L.fields[DATACORE_TRIM] = assignment
	G.fields[DATACORE_INITIAL_RANK] = assignment
	L.fields[DATACORE_AGE] = H.age
	L.fields[DATACORE_GENDER] = H.gender
	if(H.gender == "male")
		G.fields[DATACORE_GENDER] = "Male"
	else if(H.gender == "female")
		G.fields[DATACORE_GENDER] = "Female"
	else
		G.fields[DATACORE_GENDER] = "Other"
	L.fields[DATACORE_BLOOD_TYPE] = H.dna.blood_type
	L.fields[DATACORE_BLOOD_DNA] = H.dna.unique_enzymes
	L.fields[DATACORE_DNA_IDENTITY] = H.dna.unique_identity
	L.fields[DATACORE_SPECIES] = H.dna.species.type
	L.fields[DATACORE_DNA_FEATURES] = H.dna.features
	L.fields[DATACORE_APPEARANCE] = character_appearance
	L.fields[DATACORE_MINDREF] = H.mind
	library[DATACORE_RECORDS_LOCKED].inject_record(L)

	SEND_GLOBAL_SIGNAL(COMSIG_GLOB_MANIFEST_INJECT, G, M, S, L)
	return

/**
 * Supporing proc for getting general records
 * and using them as pAI ui data. This gets
 * medical information - or what I would deem
 * medical information - and sends it as a list.
 *
 * @return - list(general_records_out)
 */
/datum/controller/subsystem/datacore/proc/get_general_records()
	if(!get_records(DATACORE_RECORDS_STATION))
		return list()

	/// The array of records
	var/list/general_records_out = list()
	for(var/datum/data/record/gen_record as anything in get_records(DATACORE_RECORDS_STATION))
		/// The object containing the crew info
		var/list/crew_record = list()
		crew_record["ref"] = REF(gen_record)
		crew_record["name"] = gen_record.fields[DATACORE_NAME]
		crew_record["physical_health"] = gen_record.fields[DATACORE_PHYSICAL_HEALTH]
		crew_record["mental_health"] = gen_record.fields[DATACORE_MENTAL_HEALTH]
		general_records_out += list(crew_record)
	return general_records_out

/**
 * Supporing proc for getting secrurity records
 * and using them as pAI ui data. Sends it as a
 * list.
 *
 * @return - list(security_records_out)
 */
/datum/controller/subsystem/datacore/proc/get_security_records()
	if(!get_records(DATACORE_RECORDS_SECURITY))
		return list()

	/// The array of records
	var/list/security_records_out = list()
	for(var/datum/data/record/sec_record as anything in get_records(DATACORE_RECORDS_SECURITY))
		/// The object containing the crew info
		var/list/crew_record = list()
		crew_record["ref"] = REF(sec_record)
		crew_record["name"] = sec_record.fields[DATACORE_NAME]
		crew_record["status"] = sec_record.fields[DATACORE_CRIMINAL_STATUS] // wanted status
		crew_record["crimes"] = length(sec_record.fields[DATACORE_CRIMES])
		security_records_out += list(crew_record)
	return security_records_out

/// Creates a new crime entry and hands it back.
/datum/controller/subsystem/datacore/proc/new_crime_entry(cname = "", cdetails = "", author = "", time = "", fine = 0)
	var/datum/data/crime/c = new /datum/data/crime
	c.crimeName = cname
	c.crimeDetails = cdetails
	c.author = author
	c.time = time
	c.fine = fine
	c.paid = 0
	c.dataId = ++securityCrimeCounter
	return c

#undef DUMMY_HUMAN_SLOT_MANIFEST
