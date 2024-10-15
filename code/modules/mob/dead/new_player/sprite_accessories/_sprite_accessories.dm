/*
	!!WARNING!!: changing existing hair information can be VERY hazardous to savefiles,
	to the point where you may completely corrupt a server's savefiles. Please refrain
	from doing this unless you absolutely know what you are doing, and have defined a
	conversion in savefile.dm
*/

//Roundstart argument builds a specific list for roundstart parts where some parts may be locked
/proc/init_sprite_accessory_subtypes(prototype, list/L)
	if(!istype(L))
		L = list()

	for(var/path in subtypesof(prototype))
		var/datum/sprite_accessory/D = new path()

		// results in a null value in the lookup list, which is generally correctly handled
		if(D.icon_state)
			L[D.name] = D
		else
			L += D.name
	return L

/proc/init_mutant_bodypart_lookup_lists()
	for(var/datum/sprite_accessory/mutant_part/path as anything in subtypesof(/datum/sprite_accessory/mutant_part))
		if(!initial(path.mutant_string))
			// can't do anything with it if it doesn't have a mutant_string
			continue

		if(path == initial(path.abstract_type))
			// the type is "abstract"; we'll enter it in the string-to-abstract type lookup;
			// that list is needed for "feature_lookup_override_string" resolution.
			GLOB.mut_part_str_type_lookup[initial(path.mutant_string)] = path
		else
			var/datum/sprite_accessory/mutant_part/part = new path()
			if(!GLOB.mut_part_name_datum_lookup[part.abstract_type])
				GLOB.mut_part_name_datum_lookup[part.abstract_type] = list()

			if(part.icon_state)
				// add it to the lookup list so that the mutant part rendering code on /datum/species can actually find the instanced singletons
				GLOB.mut_part_name_datum_lookup[part.abstract_type][part.name] = part
			else
				// it will have a null entry when addressed. this is... weird... but it matches older behavior
				GLOB.mut_part_name_datum_lookup[part.abstract_type][part.name] = null

/datum/sprite_accessory
	/// the icon file the accessory is located in
	var/icon
	/// the icon_state of the accessory, or the "base" around which the full icon state is built.
	/// /datum/sprite_accessory/mutant_part subtypes with icon_state equal to "none" are NEVER rendered.
	var/icon_state
	/// The preview name of the accessory, also used for differentiation between variants of the same accessory, i.e. horn types / etc..
	/// /datum/sprite_accessory/mutant_part subtypes with name equal to "None" are NEVER rendered;
	/// additionally, for mutant parts, the name MUST be wholly unique among the variants.
	var/name

	/// determines if the accessory will be skipped by color preferences; used by underwear/undershirts/socks.
	var/use_static

/datum/sprite_accessory/mutant_part
	/// A string representing a variety of bodypart, used for lookups to the mutant_bodyparts list (on the species)
	/// and the features list (on the mob, if feature_lookup_override_string is not set); should be the same across variants of the "same" part.
	/// Also used in the icon_state of the actual overlays added to the mob sprite, unless state_prefix_override is set.
	var/mutant_string

	/// Override for the string used to find the data for this bodypart in the mob's "features" list; by default, mutant_string is used.
	/// Used for alternate forms of state-based accessories, like wagging tails and open wings, which are still so much of a fucking headache. Sorry.
	var/feature_lookup_override_string
	/// Override for part of the icon state string; when set, takes the place of mutant_string when calculating the overlay's icon state.
	var/state_prefix_override

	/// If this variable is not equal to the datum's type, the datum will be instanced and placed in the mutant bodypart list corresponding to its mutant_string.
	/// Essentially, if the bodypart is a "template" part that other mutant bodypart options are derived from, but which should not itself appear as an "option",
	/// set this variable to the bodypart's own type; this is also important even if the feature cannot be directly selected from character creation,
	/// such as for wagging states.
	var/abstract_type = /datum/sprite_accessory/mutant_part

	/// If TRUE, the gender prefix for this part's icon states will change between "m" and "f" depending on the gender of the mob.
	var/gender_specific
	/// This is the source that this accessory will get its color from. Default is COLOR_SRC_MUT_COLOR.
	var/color_src = COLOR_SRC_MUT_COLOR

	/// The alpha for the accessory to use.
	var/image_alpha = 255
	/// Decides if this sprite has an extra overlay, such as the fleshy parts on ears or a secondary tail color. These sprites always use the secondary mutant color.
	var/secondary_color

	/// The body zone to which this limb is attached. Should be one of the "base" zones (head, chest, l/r leg, l/r arm).
	/// If this limb is missing, the accessory is not rendered; also used to determine synthetic sprites.
	var/body_zone = BODY_ZONE_CHEST
	/// The clothing-based flags_inv "HIDE" flags (such as HIDEJUMPSUIT, HIDESHOES, etc.) which, if present on the outer suit, head, or mask, will obscure the part.
	var/clothes_flags_inv_hide = NONE

	/// The icon_state to use when the bodypart it's attached to is synthetic. If null, the state will not change.
	var/synthetic_icon_state
	/// The color src to use instead of the normal src when synthetic. If null, the color src will not change.
	var/synthetic_color_src

	/// Should the sprite be recentered? Only important for unusually-sized parts.
	var/center = FALSE
	/// The horizontal size of the sprite, used to center it.
	var/dimension_x = 32
	/// The vertical size of the sprite, used to center it.
	var/dimension_y = 32

	/// used by randomization procs to determine if a given mutant bodypart should be randomized.
	var/randomizable = FALSE

// these are not full icon states, as they are missing the layer suffix!
/datum/sprite_accessory/mutant_part/proc/get_basic_icon_state(m_gender, limb_synthetic, secondary)
	var/gender_prefix = "m"
	if(gender_specific && m_gender == FEMALE)
		gender_prefix = "f"

	var/state_prefix = mutant_string
	if(state_prefix_override)
		state_prefix = state_prefix_override

	var/state_name = icon_state
	if(synthetic_icon_state && limb_synthetic)
		state_name = synthetic_icon_state

	if(secondary)
		return "[gender_prefix]_[state_prefix]_secondary_[state_name]"
	else
		return "[gender_prefix]_[state_prefix]_[state_name]"

#warn remove these
/datum/sprite_accessory/mutant_part/squid_face
	mutant_string = "squid_face"
	abstract_type = /datum/sprite_accessory/mutant_part/squid_face
	randomizable = TRUE

	body_zone = BODY_ZONE_HEAD
	clothes_flags_inv_hide = HIDEFACE

	icon = 'icons/mob/mutant_bodyparts.dmi'

/datum/sprite_accessory/mutant_part/squid_face/squidward
	name = "Squidward"
	icon_state = "squidward"

/datum/sprite_accessory/mutant_part/squid_face/illithid
	name = "Illithid"
	icon_state = "illithid"

/datum/sprite_accessory/mutant_part/squid_face/freaky
	name = "Freaky"
	icon_state = "freaky"

/datum/sprite_accessory/mutant_part/squid_face/grabbers
	name = "Grabbers"
	icon_state = "grabbers"
