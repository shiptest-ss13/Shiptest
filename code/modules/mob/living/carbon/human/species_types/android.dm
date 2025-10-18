/datum/species/android
	name = "Android"
	id = SPECIES_ANDROID
	species_traits = list(NOTRANSSTING,NOREAGENTS,NO_DNA_COPY,NOBLOOD,NOFLASH)
	inherent_traits = list(TRAIT_NOMETABOLISM,TRAIT_TOXIMMUNE,TRAIT_RESISTHEAT,TRAIT_NOBREATH,TRAIT_RESISTCOLD,TRAIT_RESISTHIGHPRESSURE,TRAIT_RESISTLOWPRESSURE,TRAIT_RADIMMUNE,TRAIT_GENELESS,TRAIT_NOFIRE,TRAIT_PIERCEIMMUNE,TRAIT_NOHUNGER,TRAIT_LIMBATTACHMENT,TRAIT_NOCLONELOSS)
	inherent_biotypes = MOB_ROBOTIC|MOB_HUMANOID
	meat = null
	damage_overlay_type = "synth"
	mutanttongue = /obj/item/organ/tongue/robot
	species_language_holder = /datum/language_holder/synthetic
	reagent_tag = PROCESS_SYNTHETIC
	species_gibs = "robotic"
	attack_sound = 'sound/items/trayhit1.ogg'

	species_limbs = list(
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/robot,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/robot,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/robot,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/robot,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/robot,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/robot,
	)

	species_robotic_limbs = list(
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/robot,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/robot,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/robot/surplus,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/robot/surplus,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/robot/surplus,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/robot/surplus,
	)

	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_PRIDE | MIRROR_MAGIC | RACE_SWAP | ERT_SPAWN
