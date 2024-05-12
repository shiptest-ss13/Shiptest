
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
		DATACORE_RECORDS_LOCKED
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
	SEND_GLOBAL_SIGNAL(COMSIG_GLOB_DATACORE_READY, src)
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

/datum/controller/subsystem/datacore/proc/manifest_modify(name, assignment)
	var/datum/data/record/foundrecord = library[DATACORE_RECORDS_STATION].get_record_by_name(name)
	if(foundrecord)
		foundrecord.fields[DATACORE_RANK] = assignment

/datum/controller/subsystem/datacore/proc/get_manifest(record_type = DATACORE_RECORDS_STATION)
	var/list/manifest_out = list()
	var/list/departments = list(
		"Command" = GLOB.command_positions,
		"Security" = GLOB.security_positions,
		"Engineering" = GLOB.engineering_positions,
		"Medical" = GLOB.medical_positions,
		"Science" = GLOB.science_positions,
		"Supply" = GLOB.supply_positions,
		"Service" = GLOB.service_positions,
		"Silicon" = GLOB.nonhuman_positions
	)
	for(var/datum/data/record/record as anything in SSdatacore.get_records(record_type))
		var/name = record.fields[DATACORE_NAME]
		var/rank = record.fields[DATACORE_RANK] // user-visible job
		var/has_department = FALSE
		for(var/department in departments)
			var/list/jobs = departments[department]
			if((rank in jobs))
				if(!manifest_out[department])
					manifest_out[department] = list()
				// Append to beginning of list if captain or department head
				if (rank == "Captain" || (department != "Command" && (rank in GLOB.command_positions)))
					manifest_out[department] = list(list(
						"name" = name,
						"rank" = rank
					)) + manifest_out[department]
				else
					manifest_out[department] += list(list(
						"name" = name,
						"rank" = rank
					))
				has_department = TRUE
		if(!has_department)
			if(!manifest_out["Misc"])
				manifest_out["Misc"] = list()
			manifest_out["Misc"] += list(list(
				"name" = name,
				"rank" = rank
			))

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
			dat += "<tr[even ? " class='alt'" : ""]><td>[entry_list["name"]]</td><td>[entry_list["rank"]]</td></tr>"
			even = !even

	dat += "</table>"
	dat = replacetext(dat, "\n", "")
	dat = replacetext(dat, "\t", "")
	return dat

/datum/controller/subsystem/datacore/proc/manifest_inject(mob/living/carbon/human/H, client/C)
	SHOULD_NOT_SLEEP(TRUE)
	var/static/list/show_directions = list(SOUTH, WEST)
	if(!(H.mind && (H.mind.assigned_role != H.mind.special_role)))
		return

	var/assignment
	if(H.mind.assigned_role)
		assignment = H.mind.assigned_role
	else if(H.job)
		assignment = H.job
	else
		assignment = "Unassigned"

	var/static/record_id_num = 1001
	var/id = num2hex(record_id_num++,6)
	if(!C)
		C = H.client

	var/image = get_id_photo(H, C, show_directions)
	var/datum/picture/pf = new
	var/datum/picture/ps = new
	pf.picture_name = "[H]"
	ps.picture_name = "[H]"
	pf.picture_desc = "This is [H]."
	ps.picture_desc = "This is [H]."
	pf.picture_image = icon(image, dir = SOUTH)
	ps.picture_image = icon(image, dir = WEST)
	var/obj/item/photo/photo_front = new(null, pf)
	var/obj/item/photo/photo_side = new(null, ps)

	//General Record
	var/datum/data/record/general/G = new()
	G.fields[DATACORE_ID] = id

	G.fields[DATACORE_NAME] = H.real_name
	G.fields[DATACORE_RANK] = assignment
	G.fields[DATACORE_INITIAL_RANK] = assignment
	G.fields[DATACORE_AGE] = H.age
	G.fields[DATACORE_SPECIES] = H.dna.species.name
	G.fields[DATACORE_FINGERPRINT] = md5(H.dna.uni_identity)
	G.fields[DATACORE_PHYSICAL_HEALTH] = "Active"
	G.fields[DATACORE_MENTAL_HEALTH] = "Stable"
	G.fields[DATACORE_GENDER] = H.gender
	if(H.gender == "male")
		G.fields[DATACORE_GENDER] = "Male"
	else if(H.gender == "female")
		G.fields[DATACORE_GENDER] = "Female"
	else
		G.fields[DATACORE_GENDER] = "Other"
	//G.fields[DATACORE_APPEARANCE] = character_appearance
	G.fields[DATACORE_PHOTO] = photo_front
	G.fields[DATACORE_PHOTO_SIDE] = photo_side

	library[DATACORE_RECORDS_STATION].inject_record(G)

/*
	// Add to company-specific manifests
	var/datum/job_department/department = SSjob.departments_by_type[job.departments_list?[1]]
	if(department?.manifest_key)
		library[department.manifest_key].inject_record(G)
*/

	//Medical Record
	var/datum/data/record/medical/M = new()
	M.fields[DATACORE_ID] = id
	M.fields[DATACORE_NAME] = H.real_name
	M.fields[DATACORE_BLOOD_TYPE] = H.dna.blood_type.name
	M.fields[DATACORE_BLOOD_DNA] = H.dna.unique_enzymes
	M.fields[DATACORE_DISABILITIES] = "None"
	M.fields[DATACORE_DISABILITIES_DETAILS] = "No minor disabilities have been declared."
	M.fields[DATACORE_DISEASES] = "None"
	M.fields[DATACORE_DISEASES_DETAILS] = "No diseases have been diagnosed at the moment."
	M.fields[DATACORE_NOTES] = H.get_trait_string()
	library[DATACORE_RECORDS_MEDICAL].inject_record(M)

	//Security Record
	var/datum/data/record/security/S = new()
	S.fields[DATACORE_ID] = id
	S.fields[DATACORE_NAME] = H.real_name
	S.fields[DATACORE_CRIMINAL_STATUS] = "None"
	//S.fields[DATACORE_CITATIONS] = list()
	S.fields[DATACORE_CRIMES] = list()
	S.fields[DATACORE_NOTES] = "No notes."
	library[DATACORE_RECORDS_SECURITY].inject_record(S)

	//Locked Record
	var/datum/data/record/locked/L = new()
	L.fields[DATACORE_ID] = id
	L.fields[DATACORE_NAME] = H.real_name
	L.fields[DATACORE_RANK] = assignment
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
	L.fields[DATACORE_DNA_IDENTITY] = H.dna.uni_identity
	L.fields[DATACORE_SPECIES] = H.dna.species.type
	L.fields[DATACORE_DNA_FEATURES] = H.dna.features
	//L.fields[DATACORE_APPEARANCE] = character_appearance
	L.fields[DATACORE_IMAGE] = image
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

/datum/controller/subsystem/datacore/proc/get_id_photo(mob/living/carbon/human/H, client/C, show_directions = list(SOUTH), datum/job/J)
	var/datum/preferences/P
	if(!C)
		C = H.client
	if(C)
		P = C.prefs
	return get_flat_human_icon(null, J, P, DUMMY_HUMAN_SLOT_MANIFEST, show_directions)

#undef DUMMY_HUMAN_SLOT_MANIFEST
