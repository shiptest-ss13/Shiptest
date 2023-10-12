// Note: tails only work in humans. They use human-specific parameters and rely on human code for displaying.

/obj/item/organ/tail
	name = "tail"
	desc = "A severed tail. What did you cut this off of?"
	icon_state = "severedtail"
	zone = BODY_ZONE_PRECISE_GROIN
	slot = ORGAN_SLOT_TAIL
	var/tail_type = "None"
	mutantpart_key = "tail"
	mutantpart_info = list(MUTANT_INDEX_NAME = "Smooth", MUTANT_INDEX_COLOR_LIST = list("FFF"))
	var/can_wag = TRUE
	var/wagging = FALSE

/obj/item/organ/tail/cat
	name = "cat tail"
	desc = "A severed cat tail. Who's wagging now?"
	tail_type = "Cat"
	mutantpart_info = list(MUTANT_INDEX_NAME = "Cat", MUTANT_INDEX_COLOR_LIST = list("FA0"))

/obj/item/organ/tail/cat/slime
	name = "slimy cat tail"
	desc = "A slimy looking severed cat tail."
	tail_type = "Slimecat"
	alpha = 150
	mutantpart_info = list(MUTANT_INDEX_NAME = "Slime", MUTANT_INDEX_COLOR_LIST = list("FA0"))

/obj/item/organ/tail/lizard
	name = "\improper Sarathi tail"
	desc = "A severed Sarathi's tail. Can't they regrow these...?"
	icon_state = "severedlizard"
	color = "#116611"
	tail_type = "Smooth"
	mutantpart_info = list(MUTANT_INDEX_NAME = "Monkey", MUTANT_INDEX_COLOR_LIST = list("FFF"))

/obj/item/organ/tail/lizard/fake
	name = "fabricated lizard tail"
	desc = "A fabricated severed lizard tail. This one's made of synthflesh. Probably not usable for lizard wine."

/obj/item/organ/tail/elzu
	name = "\improper Elzuose tail"
	desc = "A detached Elzuose's tail. You probably shouldn't plant this."
	color = "#d3e8e9"
	tail_type = "Long"
	mutantpart_info = list(MUTANT_INDEX_NAME = "Short", MUTANT_INDEX_COLOR_LIST = list("DFD"))

/obj/item/organ/tail/fox
	name = "fox tail"
	desc = "A severed fox tail. Sad."
	icon_state = "severedfox"
	tail_type = "Fox"

/obj/item/organ/tail/fox/alt
	name = "fox tail"
	desc = "A severed fox tail. Sad."
	tail_type = "Fox 2"

/obj/item/organ/tail/fluffy
	name = "fluffy tail"

/obj/item/organ/tail/fluffy/no_wag
	name = "fluffy tail"
	can_wag = FALSE
