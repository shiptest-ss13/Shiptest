/datum/data_library
	var/list/datum/data/record/records = list()
	var/list/datum/data/record/records_by_name = list()

/// Returns a data record or null.
/datum/data_library/proc/get_record_by_name(name)
	RETURN_TYPE(/datum/data/record)

	return records_by_name[name]

/// Inject a record into this library.
/datum/data_library/proc/inject_record(datum/data/record/new_record)
	if(!istype(new_record))
		CRASH("You fucked it this time!!!")

	if(!new_record.fields["name"])
		CRASH("Cannot inject a record with no name!")

	records += new_record
	records_by_name[new_record.fields["name"]] = new_record
	new_record.library = src
