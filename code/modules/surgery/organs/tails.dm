// Note: tails only work in humans. They use human-specific parameters and rely on human code for displaying.

#warn i am going to fucking kill myself. this needs to be reworked for simplified mutant bodypart handling

/obj/item/organ/tail
	name = "tail"
	desc = "A severed tail. What did you cut this off of?"
	icon_state = "severedtail"
	zone = BODY_ZONE_PRECISE_GROIN
	slot = ORGAN_SLOT_TAIL

/obj/item/organ/tail/Remove(mob/living/carbon/human/H,  special = 0)
	..()
	if(H && H.dna && H.dna.species)
		// REALLY FUCKING IMPORTANT.
		// without this, the removal / insertion logic would break and a wagging tail would remain on the sprite even after the organ was removed
		H.dna.species.stop_wagging_tail(H)

/*
	Lizard and elzu tails.
	Note that due to variable_feature_data = TRUE they may inherit the tail appearance from a mob they are inserted into should the mob have a setting already.
*/

/obj/item/organ/tail/lizard
	name = "\improper Sarathi tail"
	desc = "A severed Sarathi's tail. Can't they regrow these...?"
	icon_state = "severedlizard"
	color = "#116611"

	linked_features = list(
		/datum/sprite_accessory/mutant_part/tails/lizard::mutant_string = /datum/sprite_accessory/mutant_part/tails/lizard/smooth::name,
		/datum/sprite_accessory/mutant_part/spines::mutant_string = /datum/sprite_accessory/mutant_part/spines/none::name
	)
	variable_feature_data = TRUE
	auto_color_src = FEATURE_MUTANT_COLOR

/obj/item/organ/tail/lizard/Initialize()
	. = ..()
	color = "#"+ random_color()

/obj/item/organ/tail/lizard/fake
	name = "fabricated lizard tail"
	desc = "A fabricated severed lizard tail. This one's made of synthflesh."

/obj/item/organ/tail/elzu
	name = "\improper Elzuose tail"
	desc = "A detached Elzuose's tail. You probably shouldn't plant this."
	color = "#d3e8e9"

	linked_features = list(
		/datum/sprite_accessory/mutant_part/tails/elzu::mutant_string = /datum/sprite_accessory/mutant_part/tails/elzu/long::name
	)
	variable_feature_data = TRUE
	auto_color_src = FEATURE_MUTANT_COLOR

/*
	Mutant human tails. Unlike the lizard and elzu tails, which use one type for all variants, these have distinct types for each.
*/

/obj/item/organ/tail/cat
	name = "cat tail"
	desc = "A severed cat tail. Who's wagging now?"

	linked_features = list(
		/datum/sprite_accessory/mutant_part/tails/human::mutant_string = /datum/sprite_accessory/mutant_part/tails/human/cat::name
	)
	auto_color_src = COLOR_SRC_HAIR_COLOR

/obj/item/organ/tail/fox
	name = "fox tail"
	desc = "A severed fox tail. Sad."
	icon_state = "severedfox"

	linked_features = list(
		/datum/sprite_accessory/mutant_part/tails/human::mutant_string = /datum/sprite_accessory/mutant_part/tails/human/fox::name
	)
	auto_color_src = COLOR_SRC_HAIR_COLOR

/obj/item/organ/tail/fox/alt
	linked_features = list(
		/datum/sprite_accessory/mutant_part/tails/human::mutant_string = /datum/sprite_accessory/mutant_part/tails/human/fox/alt::name
	)
