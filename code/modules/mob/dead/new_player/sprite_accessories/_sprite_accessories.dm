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
	var/color_src = MUTCOLORS	//Currently only used by mutantparts so don't worry about hair and stuff. This is the source that this accessory will get its color from. Default is MUTCOLOR, but can also be HAIR, FACEHAIR, EYECOLOR and 0 if none.
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
