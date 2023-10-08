/datum/sprite_accessory/underwear
	icon = 'icons/mob/clothing/underwear/underwear_legs.dmi'
	//freedom
	gender = NEUTER
	//Whether the underwear uses a special sprite for digitigrade style (i.e. briefs, not panties). Adds a "_d" suffix to the icon state
	var/has_digitigrade = FALSE

//Male undergarment bottoms

/datum/sprite_accessory/underwear/nude
	name = "Nude"
	icon_state = null

/datum/sprite_accessory/underwear/briefs
	name = "Briefs"
	icon_state = "briefs"
	has_digitigrade = TRUE

/datum/sprite_accessory/underwear/boxers
	name = "Boxer"
	icon_state = "boxers"
	has_digitigrade = TRUE

/datum/sprite_accessory/underwear/stripe
	name = "Striped Boxers"
	icon_state = "stripe"
	has_digitigrade = TRUE

/datum/sprite_accessory/underwear/midway
	name = "Midway Boxers"
	icon_state = "midway"
	has_digitigrade = TRUE

/datum/sprite_accessory/underwear/longjohns
	name = "Long Johns"
	icon_state = "longjohns"
	has_digitigrade = TRUE

/datum/sprite_accessory/underwear/mankini
	name = "Mankini"
	icon_state = "mankini"

/datum/sprite_accessory/underwear/hearts
	name = "Heart Boxers"
	icon_state = "heart"
	use_static = TRUE
	has_digitigrade = TRUE

//Female undergarment bottoms

/datum/sprite_accessory/underwear/panties
	name = "Panties (Greyscale)"
	icon_state = "panties"

/datum/sprite_accessory/underwear/pantiesalt
	name = "Alt Panties (Greyscale)"
	icon_state = "panties_alt"

/datum/sprite_accessory/underwear/swimming
	name = "Swimming Panties (Greyscale)"
	icon_state = "swimming"

/datum/sprite_accessory/underwear/thong
	name = "Thong (Greyscale)"
	icon_state = "thong"

/datum/sprite_accessory/underwear/boyshorts
	name = "Boyshorts (Greyscale)"
	icon_state = "boyshorts"
	has_digitigrade = TRUE

/datum/sprite_accessory/underwear/catgirl
	name = "Catgirl Panties (Greyscale)"
	icon_state = "panties_cat"

/datum/sprite_accessory/underwear/beekini
	name = "Bee-Kini Bottoms"
	icon_state = "beekini"
	use_static = TRUE
