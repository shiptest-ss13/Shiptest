/datum/species/human
	name = "\improper Human"
	id = SPECIES_HUMAN
	species_traits = list(EYECOLOR,HAIR,FACEHAIR,LIPS,SCLERA,EMOTE_OVERLAY,SKINCOLORS)
	default_features = list(FEATURE_MUTANT_COLOR = "FFF", "tail_human" = "None", "ears" = "None", "wings" = "None", FEATURE_BODY_SIZE = BODY_SIZE_NORMAL)
	mutant_bodyparts = list("ears", "tail_human")
	skinned_type = /obj/item/stack/sheet/animalhide/human
	disliked_food = GROSS | RAW | CLOTH
	liked_food = JUNKFOOD | FRIED | SUGAR
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	loreblurb = "Mostly hairless mammalians. Their home system, Sol, lies in a sort of \"bluespace dead-zone\" that blocks anything from entering or exiting Sol's dead-zone through bluespace without a relay. While it leaves Sol extremely well-defended, it meant that they went unnoticed and uncontacted until they were themselves able to breach it."

#warn just push this up
/datum/species/human/spec_death(gibbed, mob/living/carbon/human/H)
	if(H)
		stop_wagging_tail(H)

/datum/species/human/spec_stun(mob/living/carbon/human/H,amount)
	if(H)
		stop_wagging_tail(H)
	. = ..()
