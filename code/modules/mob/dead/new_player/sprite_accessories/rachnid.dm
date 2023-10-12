//Rachnid mutantparts

//Start legs

/datum/sprite_accessory/spider_legs
	icon = 'icons/mob/species/rachnid/spider_legs.dmi'
	color_src = USE_ONE_COLOR
	default_color = DEFAULT_PRIMARY
	key = "spider_legs"
	generic = "Spider Legs"
	relevent_layers = list(BODY_ADJ_LAYER)
	recommended_species = list(SPECIES_RACHNID) //not sure why you would use these on anything else

/datum/sprite_accessory/spider_legs/plain
	name = "Plain"
	icon_state = "plain"

/datum/sprite_accessory/spider_legs/fuzzy
	name = "Fuzzy"
	icon_state = "fuzzy"

/datum/sprite_accessory/spider_legs/spiky
	name = "Spiky"
	icon_state = "spiky"

//Start spinner

/datum/sprite_accessory/spider_spinneret
	icon = 'icons/mob/species/rachnid/spider_spinneret.dmi'
	color_src = USE_ONE_COLOR
	default_color = DEFAULT_PRIMARY

/datum/sprite_accessory/spider_spinneret/plain
	name = "Plain"
	icon_state = "plain"

/datum/sprite_accessory/spider_spinneret/fuzzy
	name = "Fuzzy"
	icon_state = "fuzzy"

/datum/sprite_accessory/spider_spinneret/black_widow
	name = "Black Widow"
	icon_state = "blackwidow"

//Start mandible

/datum/sprite_accessory/spider_mandibles //not for making out with
	icon = 'icons/mob/species/rachnid/spider_mandibles.dmi'
	color_src = USE_ONE_COLOR
	default_color = DEFAULT_PRIMARY
	key = "spider_mandibles"
	generic = "Mandibles"
	relevent_layers = list(BODY_ADJ_LAYER)
	recommended_species = list(SPECIES_RACHNID) //i ESPECIALLY dont know why one would use these on non-rachinids

/datum/sprite_accessory/spider_mandibles/plain
	name = "Plain"
	icon_state = "plain"

/datum/sprite_accessory/spider_mandibles/fuzzy
	name = "Fuzzy"
	icon_state = "fuzzy"

/datum/sprite_accessory/spider_mandibles/spiky
	name = "Spiky"
	icon_state = "spiky"
