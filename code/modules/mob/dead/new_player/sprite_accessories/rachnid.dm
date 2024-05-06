//Rachnid mutantparts

//Start legs

/datum/sprite_accessory/mutant_part/spider_legs
	mutant_string = "spider_legs"
	abstract_type = /datum/sprite_accessory/mutant_part/spider_legs
	randomizable = TRUE

	icon = 'icons/mob/species/rachnid/spider_legs.dmi'
	color_src = MUTCOLORS

/datum/sprite_accessory/mutant_part/spider_legs/plain
	name = "Plain"
	icon_state = "plain"

/datum/sprite_accessory/mutant_part/spider_legs/fuzzy
	name = "Fuzzy"
	icon_state = "fuzzy"

/datum/sprite_accessory/mutant_part/spider_legs/spiky
	name = "Spiky"
	icon_state = "spiky"

//Start spinner

/datum/sprite_accessory/mutant_part/spider_spinneret
	mutant_string = "spider_spinneret"
	abstract_type = /datum/sprite_accessory/mutant_part/spider_spinneret
	randomizable = TRUE

	icon = 'icons/mob/species/rachnid/spider_spinneret.dmi'
	color_src = MUTCOLORS

/datum/sprite_accessory/mutant_part/spider_spinneret/plain
	name = "Plain"
	icon_state = "plain"

/datum/sprite_accessory/mutant_part/spider_spinneret/fuzzy
	name = "Fuzzy"
	icon_state = "fuzzy"

/datum/sprite_accessory/mutant_part/spider_spinneret/black_widow
	name = "Black Widow"
	icon_state = "blackwidow"

//Start mandible

/datum/sprite_accessory/mutant_part/spider_mandibles
	mutant_string = "spider_mandibles"
	abstract_type = /datum/sprite_accessory/mutant_part/spider_mandibles
	randomizable = TRUE

	body_zone = BODY_ZONE_HEAD
	clothes_flags_inv_hide = HIDEFACE

	icon = 'icons/mob/species/rachnid/spider_mandibles.dmi'
	color_src = MUTCOLORS

/datum/sprite_accessory/mutant_part/spider_mandibles/plain
	name = "Plain"
	icon_state = "plain"

/datum/sprite_accessory/mutant_part/spider_mandibles/fuzzy
	name = "Fuzzy"
	icon_state = "fuzzy"

/datum/sprite_accessory/mutant_part/spider_mandibles/spiky
	name = "Spiky"
	icon_state = "spiky"
