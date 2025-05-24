/// Base class for preferences which consist of directly-serialized strings, which are found as options in a global list.
/datum/preference/choiced_string
	abstract_type = /datum/preference/choiced_string

	var/options_list

/datum/preference/choiced_string/New(...)
	. = ..()
	options_list = get_options_list()

// is_available left unimplemented

/// A helper proc to grab the list of choices. Only called once, when the datum initializes. The list is copied by reference, i.e.,
/// modifications to the returned list after this proc is called will be visible to the datum.
/// Should return a list of strings.
/datum/preference/choiced_string/proc/get_options_list()
	return

/datum/preference/choiced_string/_is_invalid(data, list/dependency_data)
	if(!(data in options_list))
		return "[data] is not a valid [name]!"
	return FALSE

// apply_to_human left unimplemented

/datum/preference/choiced_string/_serialize(data)
	return data

/datum/preference/choiced_string/deserialize(serialized_data)
	return serialized_data

/datum/preference/choiced_string/button_action(mob/user, old_data, list/dependency_data, list/href_list, list/hints)
	var/new_choice = input(user, "Choose your character's [name]:", "Character Preference", old_data) as null|anything in options_list
	if(new_choice)
		return new_choice
	return old_data

// Basic randomization behavior is just to pull from the list at random, but other behavior may be desired by derived subclasses.
/datum/preference/choiced_string/randomize(list/dependency_data, list/rand_dependency_data)
	return pick(options_list)



#warn would be nice if this had the color swatch.
/// Base class for preferences which are a color. Includes functionality for minimal allowed brightnesses and including or not including the leading # sign in the data.
/datum/preference/color
	abstract_type = /datum/preference/color

	/// Whether the preference's data includes the leading hash (#, also known as a "crunch" in certain parts of the code) symbol.
	/// If this is true, data might be, for example, "#FFFFFF" -- if it is false, data might be "FFFFFF".
	var/include_hash = FALSE

	/// If non-zero, only colors with an HSV value greater than this number will be accepted.
	/// Should range between 0 and 100, as the built-in COLORSPACE_HSV colorspace is used for calculations
	/// instead of the code/__HELPERS/icons.dm HSV procs.
	var/min_hsv_value = 0

/// The proc used to calculate whether a color is "bright enough", exposed to allow for simple use by subtypes.
/// Passed color value is assumed to be data-formatted, i.e., to either contain a hash or not contain a hash according to include_hash.
/// Returns TRUE if the passed color has a value (via HSV) equal to or above min_value, and FALSE otherwise.
/datum/preference/color/proc/color_has_min_value(color, min_value)
	if(!include_hash)
		color = "#" + color
	var/list/color_vals = rgb2num(color, COLORSPACE_HSV)
	if(color_vals[3] < min_value)
		return FALSE
	return TRUE

// is_available intentionally left unimplemented

/datum/preference/color/_is_invalid(data, list/dependency_data)
	if(!istext(data))
		return "[data] is not a color!"
	// we run the proc always (note that it comes first in the &&, meaning it always runs),
	// partially to check that the color string itself is valid (as rgb2num will throw an error if passed a malformed color string).
	// if min_hsv_value is 0, then the check will always pass anyway
	if(!color_has_min_value(data, min_hsv_value))
		return "[data] is not bright enough! Brightness (via HSV) should be at least [min_hsv_value]!"
	return FALSE

// apply_to_human intentionally left unimplemented

/datum/preference/color/_serialize(data)
	return data

/datum/preference/color/deserialize(serialized_data)
	return serialized_data

/datum/preference/color/button_data(dat, pref_data)
	dat += "<h3>[name]</h3>"
	dat += "<span style='border:1px solid #161616; background-color: #[pref_data];'>&nbsp;&nbsp;&nbsp;</span> <a href='byond://?_src_=prefs;preference=pref_datum;id=[savefile_key]'>[pref_data]</a><BR>"

/datum/preference/color/button_action(mob/user, old_data, list/dependency_data, list/href_list, list/hints)
	// adds a hash sign to the old data if necessary
	var/fixed_old_data = include_hash ? old_data : "#" + old_data
	var/new_color = input(user, "Choose your [name]:", "Character Preference", fixed_old_data) as color|null

	if(new_color)
		if(min_hsv_value)
			var/list/hsv_color_values = rgb2num(new_color, COLORSPACE_HSV)
			// rectify the color if it's too dim
			if(hsv_color_values[3] < min_hsv_value)
				hsv_color_values[3] = min_hsv_value
			new_color = rgb(hue = hsv_color_values[1], saturation = hsv_color_values[2], value = hsv_color_values[3], space = COLORSPACE_HSV)
		// gotta account for the #. not sure this step is necessary, but there's not much harm in it
		return sanitize_hexcolor(new_color, include_crunch = include_hash)

	return old_data

/datum/preference/color/randomize(list/dependency_data, list/rand_dependency_data)
	if(min_hsv_value)
		// generally speaking, random colors in the HSV space are darker than random colors in the RGB space,
		// so we shy away from it unless it makes things more convenient.
		// there are possibly also "inaccessible" colors, as rand() only generates whole-number values.
		return rgb(hue = rand(0, 360), saturation = rand(0, 100), value = rand(min_hsv_value, 100), space = COLORSPACE_HSV)
	// just a normal, easy random color.
	return rgb(rand(0, 255), rand(0, 255), rand(0, 255))



/datum/preference/toggle
	abstract_type = /datum/preference/toggle

// is_available left unimplemented

/datum/preference/toggle/_is_invalid(data, list/dependency_data)
	if(data != TRUE && data != FALSE)
		return "[data] is not a boolean (1 or 0)!"
	return FALSE

// apply_to_human left unimplemented, obviously

/datum/preference/toggle/_serialize(data)
	return data

/datum/preference/toggle/deserialize(serialized_data)
	return serialized_data

/datum/preference/toggle/button_action(mob/user, old_data, list/dependency_data, list/href_list, list/hints)
	return !old_data

// no randomization either, because it's pretty fucking simple

/*
/// A numeric preference with a minimum and maximum value
/datum/preference/numeric
	/// The minimum value
	var/minimum

	/// The maximum value
	var/maximum

	/// The step of the number, such as 1 for integers or 0.5 for half-steps.
	var/step = 1

	abstract_type = /datum/preference/numeric

/*
/datum/preference/numeric/deserialize(input, datum/preferences/preferences)
	if(istext(input)) // Sometimes TGUI will return a string instead of a number, so we take that into account.
		input = text2num(input) // Worst case, it's null, it'll just use create_default_value()
	return sanitize_float(input, minimum, maximum, step, create_default_value())
*/

/datum/preference/numeric/serialize(input)
	return sanitize_float(input, minimum, maximum, step, create_default_value())

/datum/preference/numeric/create_default_value()
	return rand(minimum, maximum)

/datum/preference/numeric/_is_invalid(value)
	if(isnum(value) && value >= round(minimum, step) && value <= round(maximum, step))
		return FALSE
*/

/*
/// A string-based preference accepting arbitrary string values entered by the user, with a maximum length.
/datum/preference/text
	abstract_type = /datum/preference/text

	/// What is the maximum length of the value allowed in this field?
	var/maximum_value_length = 256

	/// Should we strip HTML the input or simply restrict it to the maximum_value_length?
	var/should_strip_html = TRUE

/*
/datum/preference/text/deserialize(input, datum/preferences/preferences)
	return should_strip_html ? STRIP_HTML_SIMPLE(input, maximum_value_length) : copytext(input, 1, maximum_value_length)
*/

/datum/preference/text/create_default_value()
	return ""

/datum/preference/text/_is_invalid(value)
	return !istext(value) || length(value) >= maximum_value_length

/datum/preference/text/compile_constant_data()
	return list("maximum_length" = maximum_value_length)
*/
