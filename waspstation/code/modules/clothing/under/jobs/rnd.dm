//Alt job uniforms

/obj/item/clothing/under/rank/rnd/scientist/junior
	name = "junior scientist jumpsuit"
	desc = "It's made of a special fiber that provides minor protection against explosives. It has markings that denote the wearer as a junior scientist."
	icon = 'waspstation/icons/obj/clothing/under/rnd.dmi'
	mob_overlay_icon = 'waspstation/icons/mob/clothing/under/rnd.dmi'
	icon_state = "junior"
	fitted = NO_FEMALE_UNIFORM

/obj/item/clothing/under/rank/rnd/scientist/junior/skirt
	name = "junior scientist jumpskirt"
	icon_state = "junior_skirt"

	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE

/obj/item/clothing/under/rank/rnd/scientist/xenobiologist
	name = "xenobiologist jumpsuit"
	desc = "It's made of a special fiber that provides minor protection against biohzards. Worn by xenobiologist who have no qualms in creating abominations against nature."
	icon = 'waspstation/icons/obj/clothing/under/rnd.dmi'
	mob_overlay_icon = 'waspstation/icons/mob/clothing/under/rnd.dmi'
	icon_state = "xenobiologist"

	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 10, "rad" = 0, "fire" = 0, "acid" = 0)
	fitted = NO_FEMALE_UNIFORM

/obj/item/clothing/under/rank/rnd/scientist/xenobiologist/skirt
	name = "xenobiologist jumpskirt"
	icon_state = "xenobiologist_skirt"

	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE

/obj/item/clothing/under/rank/rnd/scientist/nanite
	name = "nanite researcher jumpsuit"
	desc = "Worn researchers that study and applies the usage of nanites, now more microscopic things to worry about."
	icon = 'waspstation/icons/obj/clothing/under/rnd.dmi'
	mob_overlay_icon = 'waspstation/icons/mob/clothing/under/rnd.dmi'
	icon_state = "nanite"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	resistance_flags = NONE
	fitted = NO_FEMALE_UNIFORM

/obj/item/clothing/under/rank/rnd/scientist/nanite/skirt
	name = "nanite research jumpskirt"
	icon_state = "nanite_skirt"

	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE

/obj/item/clothing/under/rank/rnd/roboticist/biomech_engineer
	name = "biomechanical engineer jumpsuit"
	icon = 'waspstation/icons/obj/clothing/under/rnd.dmi'
	mob_overlay_icon = 'waspstation/icons/mob/clothing/under/rnd.dmi'
	icon_state = "biomech_engineer"
	fitted = NO_FEMALE_UNIFORM

/obj/item/clothing/under/rank/rnd/roboticist/biomech_engineer/skirt
	name = "biomechanical engineer jumpskirt"
	icon_state = "biomech_engineer_skirt"

	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE

/obj/item/clothing/under/rank/rnd/roboticist/mech_engineer
	name = "mechatronic engineer jumpsuit"
	icon = 'waspstation/icons/obj/clothing/under/rnd.dmi'
	mob_overlay_icon = 'waspstation/icons/mob/clothing/under/rnd.dmi'
	icon_state = "mech_engineer"
	fitted = NO_FEMALE_UNIFORM

/obj/item/clothing/under/rank/rnd/roboticist/mech_engineer/skirt
	name = "mechatronic engineer jumpskirt"
	icon_state = "mech_engineer_skirt"

	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE

/obj/item/clothing/under/suit/senior_scientist
	name = "senior scientist suit"
	desc = "A suit with science colors, meant to be worn by senior staff."
	icon = 'waspstation/icons/obj/clothing/under/rnd.dmi'
	mob_overlay_icon = 'waspstation/icons/mob/clothing/under/rnd.dmi'
	icon_state = "senior_science"

	permeability_coefficient = 0.5
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 10, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	fitted = NO_FEMALE_UNIFORM

/obj/item/clothing/under/suit/senior_scientist/skirt
	name = "senior scientist skirtsuit"
	desc = "A skirtsuit with science colors, meant to be worn by senior staff."
	icon_state = "senior_science_skirt"

	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE

/obj/item/clothing/under/suit/senior_roboticist
	name = "senior roboticist suit"
	desc = "A suit with robotics colors, meant to be worn by senior staff."
	icon = 'waspstation/icons/obj/clothing/under/rnd.dmi'
	mob_overlay_icon = 'waspstation/icons/mob/clothing/under/rnd.dmi'
	icon_state = "senior_roboticist"

	resistance_flags = NONE
	fitted = NO_FEMALE_UNIFORM

/obj/item/clothing/under/suit/senior_roboticist/skirt
	name = "senior roboticist skirtsuit"
	desc = "A skirtsuit with robotics colors, meant to be worn by senior staff."
	icon_state = "senior_roboticist_skirt"

	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
