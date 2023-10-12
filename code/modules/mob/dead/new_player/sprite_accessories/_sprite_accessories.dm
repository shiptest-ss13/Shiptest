GLOBAL_LIST_EMPTY(cached_mutant_icon_files)

/*
	Hello and welcome to sprite_accessories: For sprite accessories, such as hair,
	facial hair, and possibly tattoos and stuff somewhere along the line. This file is
	intended to be friendly for people with little to no actual coding experience.
	The process of adding in new hairstyles has been made pain-free and easy to do.
	Enjoy! - Doohl

	Notice: This all gets automatically compiled in a list in dna.dm, so you do not
	have to define any UI values for sprite accessories manually for hair and facial
	hair. Just add in new hair types and the game will naturally adapt.

	!!WARNING!!: changing existing hair information can be VERY hazardous to savefiles,
	to the point where you may completely corrupt a server's savefiles. Please refrain
	from doing this unless you absolutely know what you are doing, and have defined a
	conversion in savefile.dm
*/

//Roundstart argument builds a specific list for roundstart parts where some parts may be locked
/proc/init_sprite_accessory_subtypes(prototype, list/L, list/male, list/female, roundstart = FALSE)
	if(!istype(L))
		L = list()
	if(!istype(male))
		male = list()
	if(!istype(female))
		female = list()

	for(var/path in subtypesof(prototype))
		if(roundstart)
			var/datum/sprite_accessory/P = path
			if(initial(P.locked))
				continue
		var/datum/sprite_accessory/D = new path()

		if(D.icon_state)
			L[D.name] = D
		else
			L += D.name

		switch(D.gender)
			if(MALE)
				male += D.name
			if(FEMALE)
				female += D.name
			else
				male += D.name
				female += D.name
	return L

/datum/sprite_accessory
	var/icon					//the icon file the accessory is located in
	var/icon_state				//the icon_state of the accessory
	var/name					//the preview name of the accessory
	var/gender = NEUTER			//Determines if the accessory will be skipped or included in random hair generations
	var/gender_specific			//Something that can be worn by either gender, but looks different on each
	var/use_static				//determines if the accessory will be skipped by color preferences
	var/color_src = USE_ONE_COLOR//Currently only used by mutantparts so don't worry about hair and stuff. This is the source that this accessory will get its color from. Default is MUTCOLOR, but can also be HAIR, FACEHAIR, EYECOLOR and 0 if none.
	var/hasinner				//Decides if this sprite has an "inner" part, such as the fleshy parts on ears.
	var/locked = FALSE			//Is this part locked from roundstart selection? Used for parts that apply effects
	var/center = FALSE			//Should we center the sprite?
	var/limbs_id				//The limbs id supplied for full-body replacing features.
	var/image_alpha = 255		//The alpha for the accessory to use.
	var/dimension_x = 32
	var/dimension_y = 32
	var/body_zone = BODY_ZONE_CHEST	//!The body zone this accessory affects
	var/synthetic_icon_state	//!The icon_state to use when the bodypart it's attached to is synthetic
	var/synthetic_color_src		//!The color src to use instead of the normal src when synthetic, leave blank to use the normal src
	///Unique key of an accessroy. All tails should have "tail", ears "ears" etc.
	var/key = null
	///If an accessory is special, it wont get included in the normal accessory lists
	var/special = FALSE
	var/list/recommended_species
	///Which color we default to on acquisition of the accessory (such as switching species, default color for character customization etc)
	///You can also put down a a HEX color, to be used instead as the default
	var/default_color = DEFAULT_PRIMARY
	///Set this to a name, then the accessory will be shown in preferences, if a species can have it. Most accessories have this
	///Notable things that have it set to FALSE are things that need special setup, such as genitals
	var/generic

	color_src = USE_ONE_COLOR

	///Which layers does this accessory affect (BODY_BEHIND_LAYER, BODY_ADJ_LAYER, BODY_FRONT_LAYER)
	var/relevent_layers = list(BODY_BEHIND_LAYER, BODY_ADJ_LAYER, BODY_FRONT_LAYER)

	///This is used to determine whether an accessory gets added to someone. This is important for accessories that are "None", which should have this set to false
	var/factual = TRUE

	///Use this as a type path to an organ that this sprite_accessory will be associated. Make sure the organ has 'mutantpart_info' set properly.
	var/organ_type

	///Set this to true to make an accessory appear as color customizable in preferences despite advanced color settings being off, will also prevent the accessory from being reset
	var/always_color_customizable
	///Whether the accessory can have a special icon_state to render, i.e. wagging tails
	var/special_render_case
	///Special case of whether the accessory should be shifted in the X dimension, check taur genitals for example
	var/special_x_dimension
	///Special case of whether the accessory should have a different icon, check taur genitals for example
	var/special_icon_case
	///Special case of applying a different color, like hardsuit tails
	var/special_colorize
	///Whether it has any extras to render, and their appropriate color sources
	var/extra = FALSE
	var/extra_color_src
	var/extra2 = FALSE
	var/extra2_color_src
	///If defined, the accessory will be only available to ckeys inside the list. ITS ASSOCIATIVE, ie. ("ckey" = TRUE). For speed
	var/list/ckey_whitelist
	/// Bodytypes which can access this accessory. (This can be bypassed by mismatched parts anyway)
	var/bodytypes = GENERIC_BODYTYPES

	/// Should this sprite block emissives?
	var/em_block = TRUE
	var/color_layer_names


/datum/sprite_accessory/New()
	if(!default_color)
		switch(color_src)
			if(USE_ONE_COLOR)
				default_color = DEFAULT_PRIMARY
			if(USE_MATRIXED_COLORS)
				default_color = DEFAULT_MATRIXED
			else
				default_color = "FFF"
	if(name == "None")
		factual = FALSE
	if(color_src == USE_MATRIXED_COLORS && default_color != DEFAULT_MATRIXED)
		default_color = DEFAULT_MATRIXED
	if(color_src == USE_MATRIXED_COLORS)
		color_layer_names = list()
		if (!GLOB.cached_mutant_icon_files[icon])
			GLOB.cached_mutant_icon_files[icon] = icon_states(new /icon(icon))
		for (var/layer in relevent_layers)
			var/layertext = layer == BODY_BEHIND_LAYER ? "BEHIND" : (layer == BODY_ADJ_LAYER ? "ADJ" : "FRONT")
			if ("m_[key]_[icon_state]_[layertext]_primary" in GLOB.cached_mutant_icon_files[icon])
				color_layer_names["1"] = "primary"
				var/valid_icon_state = icon_exists(icon, "m_[key]_[icon_state]_[layertext]_primary")
				message_admins("DEBUG: m_[key]_[icon_state]_[layertext]_primary, and does[valid_icon_state ? "NOT exist" : "exist"].")
			else
				var/valid_icon_state = icon_exists(icon, "m_[key]_[icon_state]_[layertext]_primary")
				message_admins("DEBUG: m_[key]_[icon_state]_[layertext]_primary, and does[valid_icon_state ? "NOT exist" : "exist"].")
			if ("m_[key]_[icon_state]_[layertext]_secondary" in GLOB.cached_mutant_icon_files[icon])
				color_layer_names["2"] = "secondary"
				var/valid_icon_state = icon_exists(icon, "m_[key]_[icon_state]_[layertext]_secondary")
				message_admins("DEBUG: m_[key]_[icon_state]_[layertext]_secondary, and does[valid_icon_state ? "NOT exist" : "exist"].")
			else
				var/valid_icon_state = icon_exists(icon, "m_[key]_[icon_state]_[layertext]_secondary")
				message_admins("DEBUG: m_[key]_[icon_state]_[layertext]_secondary, and does[valid_icon_state ? "NOT exist" : "exist"].")
			if ("m_[key]_[icon_state]_[layertext]_tertiary" in GLOB.cached_mutant_icon_files[icon])
				color_layer_names["3"] = "tertiary"
				var/valid_icon_state = icon_exists(icon, "m_[key]_[icon_state]_[layertext]_tertiary")
				message_admins("DEBUG: m_[key]_[icon_state]_[layertext]_tertiary, and does[valid_icon_state ? "NOT exist" : "exist"].")
			else
				var/valid_icon_state = icon_exists(icon, "m_[key]_[icon_state]_[layertext]_tertiary")
				message_admins("DEBUG: m_[key]_[icon_state]_[layertext]_tertiary, and does[valid_icon_state ? "NOT exist" : "exist"].")

/datum/sprite_accessory/proc/is_hidden(mob/living/carbon/human/H, obj/item/bodypart/BP)
	return FALSE

/datum/sprite_accessory/proc/get_special_render_state(mob/living/carbon/human/H)
	return null

/datum/sprite_accessory/proc/get_special_render_colour(mob/living/carbon/human/H, passed_state)
	return null

/datum/sprite_accessory/proc/get_special_icon(mob/living/carbon/human/H, passed_state)
	return null

/datum/sprite_accessory/proc/get_special_x_dimension(mob/living/carbon/human/H, passed_state)
	return 0

/datum/sprite_accessory/proc/get_default_color(list/features, datum/species/pref_species) //Needs features for the color information
	var/list/colors
	switch(default_color)
		if(DEFAULT_PRIMARY)
			colors = list(features["mcolor"])
		if(DEFAULT_SECONDARY)
			colors = list(features["mcolor2"])
		if(DEFAULT_TERTIARY)
			colors = list(features["mcolor3"])
		if(DEFAULT_MATRIXED)
			colors = list(features["mcolor"], features["mcolor2"], features["mcolor3"])
		if(DEFAULT_SKIN_OR_PRIMARY)
			if(pref_species && pref_species.use_skintones)
				colors = list(features["skin_color"])
			else
				colors = list(features["mcolor"])
		else
			colors = list(default_color)
	return colors

//Squids AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA whyyyy
/datum/sprite_accessory/squid_face
	icon = 'icons/mob/mutant_bodyparts.dmi'

/datum/sprite_accessory/squid_face/squidward
	name = "Squidward"
	icon_state = "squidward"

/datum/sprite_accessory/squid_face/illithid
	name = "Illithid"
	icon_state = "illithid"

/datum/sprite_accessory/squid_face/freaky
	name = "Freaky"
	icon_state = "freaky"

/datum/sprite_accessory/squid_face/grabbers
	name = "Grabbers"
	icon_state = "grabbers"
