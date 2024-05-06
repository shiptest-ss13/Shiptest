//Sarathi Mutantparts

//Start markings

/datum/sprite_accessory/mutant_part/body_markings
	mutant_string = "body_markings"
	abstract_type = /datum/sprite_accessory/mutant_part/body_markings
	randomizable = TRUE

	body_zone = BODY_ZONE_CHEST

	icon = 'icons/mob/species/lizard/markings.dmi'
	color_src = MUTCOLORS_SECONDARY
	synthetic_icon_state = "none"

/datum/sprite_accessory/mutant_part/body_markings/none
	name = "None"
	icon_state = "none"

/datum/sprite_accessory/mutant_part/body_markings/ltiger
	name = "Tiger"
	icon_state = "tiger"

/datum/sprite_accessory/mutant_part/body_markings/lbelly
	name = "Light Belly"
	icon_state = "lbelly"

//Start tails

// base tails, used for humans + lizards + elzu
/datum/sprite_accessory/mutant_part/tails
	// we don't add a mutant_string just yet, since the species-based subtypes all have different values
	// keeping the abstract_type is fine, though
	abstract_type = /datum/sprite_accessory/mutant_part/tails
	randomizable = TRUE // randomizable, though human tails get an exemption

	// shared by all tails
	state_prefix_override = "tail"

	icon = 'icons/mob/species/lizard/tails.dmi'
	synthetic_icon_state = "synth"

/datum/sprite_accessory/mutant_part/tails_animated
	abstract_type = /datum/sprite_accessory/mutant_part/tails_animated
	// not randomizable; due to use of feature_lookup_override_string on subtypes, randomizing these wouldn't even do anything,
	// as mutant bodypart code would never look at the data stored under the corresponding mutant_string to render the part

	state_prefix_override = "waggingtail"

	icon = 'icons/mob/species/lizard/tails.dmi'

// lizard tails
/datum/sprite_accessory/mutant_part/tails/lizard
	mutant_string = "tail_lizard"
	abstract_type = /datum/sprite_accessory/mutant_part/tails/lizard

/datum/sprite_accessory/mutant_part/tails_animated/lizard
	mutant_string = "waggingtail_lizard"
	abstract_type = /datum/sprite_accessory/mutant_part/tails_animated/lizard
	// you might think "wow, this fucking sucks"
	// and you're right! it does
	feature_lookup_override_string = "tail_lizard"

/datum/sprite_accessory/mutant_part/tails/lizard/smooth
	name = "Smooth"
	icon_state = "smooth"

/datum/sprite_accessory/mutant_part/tails_animated/lizard/smooth
	name = "Smooth"
	icon_state = "smooth"

/datum/sprite_accessory/mutant_part/tails/lizard/dtiger
	name = "Dark Tiger"
	icon_state = "dtiger"

/datum/sprite_accessory/mutant_part/tails_animated/lizard/dtiger
	name = "Dark Tiger"
	icon_state = "dtiger"

/datum/sprite_accessory/mutant_part/tails/lizard/ltiger
	name = "Light Tiger"
	icon_state = "ltiger"

/datum/sprite_accessory/mutant_part/tails_animated/lizard/ltiger
	name = "Light Tiger"
	icon_state = "ltiger"

/datum/sprite_accessory/mutant_part/tails/lizard/spikes
	name = "Spikes"
	icon_state = "spikes"

/datum/sprite_accessory/mutant_part/tails_animated/lizard/spikes
	name = "Spikes"
	icon_state = "spikes"

/datum/sprite_accessory/mutant_part/tails/lizard/large
	name = "Large"
	icon_state = "large"
	synthetic_icon_state = "large" //fight me

/datum/sprite_accessory/mutant_part/tails_animated/lizard/large
	name = "Large"
	icon_state = "large"
	synthetic_icon_state = "large"

/datum/sprite_accessory/mutant_part/tails/lizard/small
	name = "Small"
	icon_state = "small"
	synthetic_icon_state = "none"

/datum/sprite_accessory/mutant_part/tails_animated/lizard/small
	name = "Small"
	icon_state = "small"
	synthetic_icon_state = "none"

//Start Face markings

/datum/sprite_accessory/mutant_part/face_markings
	mutant_string = "face_markings"
	abstract_type = /datum/sprite_accessory/mutant_part/face_markings
	randomizable = TRUE

	body_zone = BODY_ZONE_HEAD
	clothes_flags_inv_hide = HIDEFACE

	icon = 'icons/mob/species/lizard/markings.dmi'
	color_src = MUTCOLORS_SECONDARY
	synthetic_icon_state = "none"

/datum/sprite_accessory/mutant_part/face_markings/none
	name = "None"
	icon_state = "none"

/datum/sprite_accessory/mutant_part/face_markings/jaw
	name = "Jaw"
	icon_state = "jaw"

/datum/sprite_accessory/mutant_part/face_markings/top
	name = "Top Stripe"
	icon_state = "top"

/datum/sprite_accessory/mutant_part/face_markings/eye
	name = "Alligator Skink"
	icon_state = "eye"

//Start Horns

/datum/sprite_accessory/mutant_part/horns
	mutant_string = "horns"
	abstract_type = /datum/sprite_accessory/mutant_part/horns
	randomizable = TRUE

	body_zone = BODY_ZONE_HEAD
	clothes_flags_inv_hide = HIDEHAIR

	icon = 'icons/mob/species/lizard/horns.dmi'
	color_src = HAIR
	synthetic_color_src = MUTCOLORS_SECONDARY

/datum/sprite_accessory/mutant_part/horns/none
	name = "None"
	icon_state = "none"

//new horns
/datum/sprite_accessory/mutant_part/horns/broken
	name = "Broken"
	icon_state = "broken"
	synthetic_icon_state = "none"

/datum/sprite_accessory/mutant_part/horns/lightning
	name = "Lightning"
	icon_state = "lightning"
	synthetic_icon_state = "none"

/datum/sprite_accessory/mutant_part/horns/brimstone
	name = "Brimstone"
	icon_state = "brimstone"
	synthetic_icon_state = "none"

//old horns
/datum/sprite_accessory/mutant_part/horns/simple
	name = "Simple"
	icon_state = "simple"
	synthetic_icon_state = "simple_synth"

/datum/sprite_accessory/mutant_part/horns/short
	name = "Short"
	icon_state = "short"
	synthetic_icon_state = "short_synth"

/datum/sprite_accessory/mutant_part/horns/curled
	name = "Curled"
	icon_state = "curled"
	synthetic_icon_state = "curled_synth"

/datum/sprite_accessory/mutant_part/horns/ram //remade
	name = "Ram"
	icon_state = "ram"
	synthetic_icon_state = "ram_synth"

/datum/sprite_accessory/mutant_part/horns/angler
	name = "Angeler"
	icon_state = "angler"

//Start Frills

/datum/sprite_accessory/mutant_part/frills
	mutant_string = "frills"
	abstract_type = /datum/sprite_accessory/mutant_part/frills
	randomizable = TRUE

	body_zone = BODY_ZONE_HEAD
	clothes_flags_inv_hide = HIDEEARS

	icon = 'icons/mob/species/lizard/frills.dmi'

/datum/sprite_accessory/mutant_part/frills/none
	name = "None"
	icon_state = "none"

/datum/sprite_accessory/mutant_part/frills/simple
	name = "Simple"
	icon_state = "simple"

/datum/sprite_accessory/mutant_part/frills/short
	name = "Short"
	icon_state = "short"

/datum/sprite_accessory/mutant_part/frills/aquatic
	name = "Aquatic"
	icon_state = "aqua"

/datum/sprite_accessory/mutant_part/frills/frillhawk
	name = "Frillhawk"
	icon_state = "frillhawk"

/datum/sprite_accessory/mutant_part/frills/droopy
	name = "Droopy"
	icon_state = "droopy"

/datum/sprite_accessory/mutant_part/frills/neck
	name = "Neck"
	icon_state = "neck"

/datum/sprite_accessory/mutant_part/frills/neckbig
	name = "Frilled Dragon"
	icon_state = "neckbig"

//Start Spines

/datum/sprite_accessory/mutant_part/spines
	mutant_string = "spines"
	abstract_type = /datum/sprite_accessory/mutant_part/spines
	randomizable = TRUE

	clothes_flags_inv_hide = HIDEJUMPSUIT

	icon = 'icons/mob/species/lizard/tails.dmi'

/datum/sprite_accessory/mutant_part/spines_animated
	mutant_string = "waggingspines"
	abstract_type = /datum/sprite_accessory/mutant_part/spines_animated
	// not randomizable, as it is state-based

	feature_lookup_override_string = "spines"
	clothes_flags_inv_hide = HIDEJUMPSUIT

	icon = 'icons/mob/species/lizard/tails.dmi'

/datum/sprite_accessory/mutant_part/spines/none
	name = "None"
	icon_state = "none"

/datum/sprite_accessory/mutant_part/spines_animated/none
	name = "None"
	icon_state = "none"

/datum/sprite_accessory/mutant_part/spines/short
	name = "Short"
	icon_state = "short"

/datum/sprite_accessory/mutant_part/spines_animated/short
	name = "Short"
	icon_state = "short"

/datum/sprite_accessory/mutant_part/spines/shortmeme
	name = "Short + Membrane"
	icon_state = "shortmeme"

/datum/sprite_accessory/mutant_part/spines_animated/shortmeme
	name = "Short + Membrane"
	icon_state = "shortmeme"

/datum/sprite_accessory/mutant_part/spines/long
	name = "Long"
	icon_state = "long"

/datum/sprite_accessory/mutant_part/spines_animated/long
	name = "Long"
	icon_state = "long"

/datum/sprite_accessory/mutant_part/spines/longmeme
	name = "Long + Membrane"
	icon_state = "longmeme"

/datum/sprite_accessory/mutant_part/spines_animated/longmeme
	name = "Long + Membrane"
	icon_state = "longmeme"

/datum/sprite_accessory/mutant_part/spines/aquatic
	name = "Aquatic"
	icon_state = "aqua"

/datum/sprite_accessory/mutant_part/spines_animated/aquatic
	name = "Aquatic"
	icon_state = "aqua"
