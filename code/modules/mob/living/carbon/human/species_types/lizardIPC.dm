/datum/species/ipc/lizard // SYNTHS MY BELOVED
	name = "\improper Integrated Positronic Sarathi" //not final
	id = SPECIES_LIZIPC
	sexes = FALSE //no sex?
	species_traits = list(AGENDER,NOTRANSSTING,NOEYESPRITES,NO_DNA_COPY,NOBLOOD,TRAIT_EASYDISMEMBER,NOZOMBIE,MUTCOLORS,REVIVESBYHEALING,NOHUSK,NOMOUTH,NO_BONES, MUTCOLORS) //all of these + whatever we inherit from the real species
	inherent_traits = list(TRAIT_RESISTCOLD,TRAIT_VIRUSIMMUNE,TRAIT_NOBREATH,TRAIT_RADIMMUNE,TRAIT_GENELESS,TRAIT_LIMBATTACHMENT)
	inherent_biotypes = MOB_ROBOTIC|MOB_HUMANOID|MOB_REPTILE
	mutantbrain = /obj/item/organ/brain/mmi_holder/posibrain
	mutanteyes = /obj/item/organ/eyes/robotic
	mutanttongue = /obj/item/organ/tongue/robot
	mutantliver = /obj/item/organ/liver/cybernetic/upgraded/ipc
	mutantstomach = /obj/item/organ/stomach/cell
	mutantears = /obj/item/organ/ears/robot
	mutant_organs = list(/obj/item/organ/cyberimp/arm/power_cord, /obj/item/organ/tail/lizard) //replace lizard tail with synthliz tail obj when done
	mutant_bodyparts = list("ipc_screen", "ipc_antenna", "ipc_chassis", "ipc_brain")
	default_features = list("mcolor" = "#7D7D7D", "ipc_screen" = "Static", "ipc_antenna" = "None", "ipc_chassis" = "Morpheus Cyberkinetics (Custom)", "ipc_brain" = "Posibrain", "body_size" = "Normal")
	species_language_holder = /datum/language_holder/ipc/lizard
	digitigrade_customization = DIGITIGRADE_OPTIONAL
	loreblurb = "A different line of IPC, Integrated Positronic Sarathi (IPS) are digitigrade, tailed versions developed as \
	full body prosthetics for those with a taste for scales and tails instead of a boring humanoid shape. They are \
	similarly fragile and weak to EMPs, with the only difference being their body features resembling that of a sarathi instead of a human. Blep Boop." //also not final
	ass_image = 'icons/ass/assmachine.png'

	species_chest = /obj/item/bodypart/chest/ipc
	species_head = /obj/item/bodypart/head/ipc
	species_l_arm = /obj/item/bodypart/l_arm/ipc
	species_r_arm = /obj/item/bodypart/r_arm/ipc
	species_l_leg = /obj/item/bodypart/l_leg/ipc
	species_r_leg = /obj/item/bodypart/r_leg/ipc // REPLACE WITH SYNTHLIZ PLACEHOLDERS

/datum/species/ipc/lizard/New() //note to self change later to match sprites
	. = ..()
	offset_clothing = list(
		"[GLASSES_LAYER]" = list("[NORTH]" = list("x" = 0, "y" = 0), "[EAST]" = list("x" = 2, "y" = 0), "[SOUTH]" = list("x" = 0, "y" = 0), "[WEST]" = list("x" = -2, "y" = 0)),
	)
