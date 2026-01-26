/datum/sprite_accessory/body // Used for changing limb icons, doesn't need to hold the actual icon.
	icon = null
	icon_state = "who cares fuck you"
	/// Associated list of bodyparts by zone.
	var/list/replacement_bodyparts = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right,
	)
	/// Associated list of features granted by this chassis and their default values.
	var/list/body_features = list()
	///species whitelist
	var/list/allowed_species = list()


/* Test body for checking functionality
/datum/sprite_accessory/body/test_body
	name = "testificate"
	replacement_bodyparts = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/plasmaman,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/plasmaman,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/plasmaman,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/plasmaman,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/plasmaman,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/plasmaman,
	)
	allowed_species = list(/datum/species/moth)
*/
