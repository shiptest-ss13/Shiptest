/datum/sprite_accessory/body/prosthetic
	name = "Basic Prosthetic"
	replacement_bodyparts = list(
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/robot,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/robot,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/robot/surplus,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/robot/surplus,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/robot/surplus,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/robot/surplus,
	)
	replacement_organs = list(
		ORGAN_SLOT_HEART = /obj/item/organ/heart/cybernetic,
		ORGAN_SLOT_LUNGS = /obj/item/organ/lungs/cybernetic,
		ORGAN_SLOT_EYES = /obj/item/organ/eyes/robotic,
		ORGAN_SLOT_EARS = /obj/item/organ/ears/cybernetic,
		ORGAN_SLOT_TONGUE = /obj/item/organ/tongue/robot,
		ORGAN_SLOT_LIVER = /obj/item/organ/liver/cybernetic,
		ORGAN_SLOT_STOMACH = /obj/item/organ/stomach/cybernetic,
	)

/datum/sprite_accessory/body/prosthetic/human
	name = "Prosthetic Human"
	replacement_bodyparts = list(
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/robot/human,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/robot/human,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/robot/surplus/human,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/robot/surplus/human,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/robot/surplus/human,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/robot/surplus/human,
	)
	allowed_species = list(/datum/species/human, /datum/species/moth)

/datum/sprite_accessory/body/prosthetic/sarathi
	name = "Prosthetic Sarathi"
	replacement_bodyparts = list(
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/robot/lizard,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/robot/lizard,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/robot/surplus/lizard,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/robot/surplus/lizard,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/robot/surplus/lizard/digitigrade,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/robot/surplus/lizard/digitigrade,
	)
	replacement_organs = list(
		ORGAN_SLOT_HEART = /obj/item/organ/heart/cybernetic,
		ORGAN_SLOT_LUNGS = /obj/item/organ/lungs/cybernetic,
		ORGAN_SLOT_EYES = /obj/item/organ/eyes/robotic/lizard,
		ORGAN_SLOT_EARS = /obj/item/organ/ears/cybernetic,
		ORGAN_SLOT_TONGUE = /obj/item/organ/tongue/robot,
		ORGAN_SLOT_LIVER = /obj/item/organ/liver/cybernetic,
		ORGAN_SLOT_STOMACH = /obj/item/organ/stomach/cybernetic,
	)
	allowed_species = list(/datum/species/lizard)

/datum/sprite_accessory/body/prosthetic/kepori
	name = "Prosthetic Kepori"
	replacement_bodyparts = list(
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/robot/kepori,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/robot/kepori,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/robot/surplus/kepori,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/robot/surplus/kepori,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/robot/surplus/kepori,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/robot/surplus/kepori,
	)
	replacement_organs = list(
		ORGAN_SLOT_HEART = /obj/item/organ/heart/cybernetic,
		ORGAN_SLOT_LUNGS = /obj/item/organ/lungs/cybernetic,
		ORGAN_SLOT_EYES = /obj/item/organ/eyes/robotic/kepori,
		ORGAN_SLOT_EARS = /obj/item/organ/ears/cybernetic,
		ORGAN_SLOT_TONGUE = /obj/item/organ/tongue/robot,
		ORGAN_SLOT_LIVER = /obj/item/organ/liver/cybernetic,
		ORGAN_SLOT_STOMACH = /obj/item/organ/stomach/cybernetic,
	)
	allowed_species = list(/datum/species/kepori)
	bodytype = BODYTYPE_KEPORI

/datum/sprite_accessory/body/prosthetic/vox
	name = "Prosthetic Vox"
	replacement_bodyparts = list(
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/robot/vox,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/robot/vox,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/robot/surplus/vox,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/robot/surplus/vox,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/robot/surplus/vox,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/robot/surplus/vox,
	)
	allowed_species = list(/datum/species/vox)
	bodytype = BODYTYPE_VOX
