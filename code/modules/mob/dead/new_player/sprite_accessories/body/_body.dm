/datum/sprite_accessory/body // Used for changing limb icons, doesn't need to hold the actual icon.
	icon = null
	icon_state = "who cares fuck you"
	/// When selected, clicking the [?] button will provide a description of this body.
	var/desc
	/// Associated list of bodyparts by zone.
	var/list/replacement_bodyparts = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right,
	)
	/// Organs to override
	var/list/replacement_organs = list()
	/// Associated list of features granted by this chassis and their default values.
	var/list/body_features = list()
	///	Whitelist of species allowed to apply this.
	var/list/allowed_species
	/// Bodytype to apply to the species.
	var/bodytype = BODYTYPE_HUMANOID

/// Handles applying any special features from having the entire body replaced at once.
/datum/sprite_accessory/body/proc/apply_to_species(mob/living/carbon/mob_applied, datum/species/species_applied)
	species_applied.bodytype = bodytype
	for(var/feature in body_features)
		species_applied.mutant_bodyparts |= feature
		species_applied.default_features[feature] = body_features[feature]
