/datum/data
	var/name = "data"

/datum/data/record
	name = "record"
	/// A ref to the library we're contained in.
	var/datum/data_library/library
	/// The data
	var/list/fields = list()

/datum/data/record/Destroy(force, ...)
	if(library)
		library.records -= src
		library.records_by_name -= fields["name"]
	return ..()

/// Creates a copy of the record, without it's library.
/datum/data/record/proc/Copy()
	var/datum/data/record/new_record = new type()
	new_record.fields = fields.Copy()
	return new_record


/// A helper proc to get the front photo of a character from the record.
/// Handles calling `get_photo()`, read its documentation for more information.
/datum/data/record/proc/get_front_photo()
	return get_photo("photo_front", SOUTH)

/// A helper proc to get the side photo of a character from the record.
/// Handles calling `get_photo()`, read its documentation for more information.
/datum/data/record/proc/get_side_photo()
	return get_photo("photo_side", WEST)


/**
 * You shouldn't be calling this directly, use `get_front_photo()` or `get_side_photo()`
 * instead.
 *
 * This is the proc that handles either fetching (if it was already generated before) or
 * generating (if it wasn't) the specified photo from the specified record. This is only
 * intended to be used by records that used to try to access `fields["photo_front"]` or
 * `fields["photo_side"]`, and will return an empty icon if there isn't any of the necessary
 * fields.
 *
 * Arguments:
 * * field_name - The name of the key in the `fields` list, of the record itself.
 * * orientation - The direction in which you want the character appearance to be rotated
 * in the outputed photo.
 *
 * Returns an empty `/icon` if there was no `character_appearance` entry in the `fields` list,
 * returns the generated/cached photo otherwise.
 */
/datum/data/record/proc/get_photo(field_name, orientation)
	if(!field_name)
		return

	if(!fields[DATACORE_APPEARANCE])
		return new /icon()

	var/mutable_appearance/character_appearance = fields[DATACORE_APPEARANCE]

	var/icon/picture_image
	if(!isicon(character_appearance))
		var/mutable_appearance/appearance = character_appearance
		appearance.setDir(orientation)
		picture_image = getFlatIcon(appearance)
	else
		picture_image = character_appearance

	var/datum/picture/picture = new
	picture.picture_name = "[fields[DATACORE_NAME]]"
	picture.picture_desc = "This is [fields[DATACORE_NAME]]."
	picture.picture_image = picture_image

	var/obj/item/photo/photo = new(null, picture)
	fields[field_name] = photo
	return photo

/// Set the criminal status of a crew member in the security records.
/datum/data/record/proc/set_criminal_status(new_status)
	var/old_status = DATACORE_CRIMINAL_STATUS
	if(old_status == new_status)
		return FALSE

	fields[DATACORE_CRIMINAL_STATUS] = new_status
	return TRUE

/datum/data/record/proc/add_crime(datum/data/crime/crime)
	fields[DATACORE_CRIMES] |= crime

/datum/data/record/proc/remove_crime(cDataId)
	if(istext(cDataId))
		cDataId = text2num(cDataId)

	for(var/datum/data/crime/crime in fields[DATACORE_CRIMES])
		if(crime.dataId == cDataId)
			fields[DATACORE_CRIMES] -= crime
			return

/datum/data/record/proc/add_crime_details(cDataId, details)
	if(istext(cDataId))
		cDataId = text2num(cDataId)

	for(var/datum/data/crime/crime in fields[DATACORE_CRIMES])
		if(crime.dataId == cDataId)
			crime.crimeDetails = details
			return
