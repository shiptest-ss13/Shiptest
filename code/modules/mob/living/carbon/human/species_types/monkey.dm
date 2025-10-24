///DO NOT USE set_species(/datum/species/monkey)
///USE monkeyize() INSTEAD
/datum/species/monkey
	name = "\improper Monkey"
	id = SPECIES_MONKEY
	skinned_type = /obj/item/stack/sheet/animalhide/
	changesource_flags = MIRROR_BADMIN
	use_damage_color = FALSE

	species_limbs = list(
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/monkey,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/monkey,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/monkey,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/monkey,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/monkey,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/monkey,
	)
