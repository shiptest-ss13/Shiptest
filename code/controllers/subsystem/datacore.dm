
///Dummy mob reserve slot for manifest
#define DUMMY_HUMAN_SLOT_MANIFEST "dummy_manifest_generation"

SUBSYSTEM_DEF(datacore)
	name = "Data Core"
	flags = SS_NO_FIRE
	init_order = INIT_ORDER_DATACORE

	/// A list of data libraries keyed by DATACORE_RECORDS_*
	var/list/datum/data_library/library = list(
		DATACORE_RECORDS_OUTPOST,
		DATACORE_RECORDS_SECURITY,
		DATACORE_RECORDS_MEDICAL,
		//DATACORE_RECORDS_LOCKED
	)

	var/securityPrintCount = 0
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
	medicalPrintCount = SSdatacore.medicalPrintCount
	finished_setup = SSdatacore.finished_setup

/datum/controller/subsystem/datacore/proc/create_library(library_key)
	var/datum/data_library/new_library = new /datum/data_library
	library[library_key] = new_library
	return new_library

/// Returns a data record or null.
/datum/controller/subsystem/datacore/proc/get_record_by_name(name, record_type)
	RETURN_TYPE(/datum/data/record)

	return library[record_type].get_record_by_name(name)

/// Returns a data library's records list
/datum/controller/subsystem/datacore/proc/get_records(record_type)
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
	//for(var/id in library - DATACORE_RECORDS_LOCKED)
	for(var/id in library)
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
			inject_library(N.new_character, N.client, DATACORE_RECORDS_OUTPOST)

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
	var/datum/data/record/foundrecord = library[DATACORE_RECORDS_OUTPOST].get_record_by_name(name)
	if(foundrecord)
		foundrecord.fields[DATACORE_RANK] = assignment

/datum/controller/subsystem/datacore/proc/get_manifest(record_type = DATACORE_RECORDS_OUTPOST)
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

//For ship records
/datum/controller/subsystem/datacore/proc/inject_library(mob/living/carbon/human/H, client/C, datum/data_library/custom_library)
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

	var/person_gender = "Other"
	if(H.gender == "male")
		person_gender = "Male"
	if(H.gender == "female")
		person_gender = "Female"

	var/mutable_appearance/character_appearance = new(H.appearance)

	//General Record
	var/datum/data/record/G = new()
	G.fields[DATACORE_ID] = id
	G.fields[DATACORE_RANK] = assignment
	G.fields[DATACORE_INITIAL_RANK] = assignment
	G.fields[DATACORE_NAME] = H.real_name
	G.fields[DATACORE_AGE] = H.age
	G.fields[DATACORE_GENDER] = person_gender
	G.fields[DATACORE_SPECIES] = H.dna.species.name

	G.fields[DATACORE_APPEARANCE] = character_appearance
	G.fields[DATACORE_NOTES] = "No notes."

	G.fields[DATACORE_PHYSICAL_HEALTH] = PHYSICAL_ACTIVE
	G.fields[DATACORE_MENTAL_HEALTH] = MENTAL_STABLE

	G.fields[DATACORE_BLOOD_TYPE] = H.dna.blood_type.name
	G.fields[DATACORE_BLOOD_DNA] = H.dna.unique_enzymes
	G.fields[DATACORE_DISABILITIES] = "None"
	G.fields[DATACORE_DISABILITIES_DETAILS] = "No minor disabilities have been declared."
	G.fields[DATACORE_DISEASES] = "None"
	G.fields[DATACORE_DISEASES_DETAILS] = "No diseases have been diagnosed at the moment."
	G.fields[DATACORE_NOTES_MEDICAL] = list()

	G.fields[DATACORE_FINGERPRINT] = md5(H.dna.uni_identity)
	G.fields[DATACORE_CRIMINAL_STATUS] = "None"
	G.fields[DATACORE_CRIMES] = list()
	G.fields[DATACORE_NOTES_SECURITY] = "No security notes."

	if(istype(custom_library, /datum/data_library))
		custom_library.inject_record(G)
	else
		library[custom_library].inject_record(G)

/datum/controller/subsystem/datacore/proc/create_record(library_target, name)
	var/datum/data/record/new_record = new /datum/data/record
	new_record.fields[DATACORE_NAME] = name
	library[library_target].inject_record(new_record)
	return new_record

/**
 * Supporing proc for getting general records
 * and using them as pAI ui data. This gets
 * medical information - or what I would deem
 * medical information - and sends it as a list.
 *
 * @return - list(general_records_out)
 */
/datum/controller/subsystem/datacore/proc/get_general_records(record_key = DATACORE_RECORDS_OUTPOST)
	if(!get_records(record_key))
		return list()

	/// The array of records
	var/list/general_records_out = list()
	for(var/datum/data/record/gen_record as anything in get_records(record_key))
		/// The object containing the crew info
		var/list/crew_record = list()
		crew_record["ref"] = REF(gen_record)
		crew_record[DATACORE_NAME] = gen_record.fields[DATACORE_NAME]
		crew_record[DATACORE_PHYSICAL_HEALTH] = gen_record.fields[DATACORE_PHYSICAL_HEALTH]
		crew_record[DATACORE_MENTAL_HEALTH] = gen_record.fields[DATACORE_MENTAL_HEALTH]
		general_records_out += list(crew_record)
	return general_records_out

/**
 * Supporing proc for getting secrurity records
 * and using them as pAI ui data. Sends it as a
 * list.
 *
 * @return - list(security_records_out)
 */
/datum/controller/subsystem/datacore/proc/get_security_records(record_key = DATACORE_RECORDS_SECURITY)
	if(!get_records(record_key))
		return list()

	/// The array of records
	var/list/security_records_out = list()
	for(var/datum/data/record/sec_record as anything in get_records(record_key))
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
	return c

#undef DUMMY_HUMAN_SLOT_MANIFEST
