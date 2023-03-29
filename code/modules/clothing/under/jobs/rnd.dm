/obj/item/clothing/under/rank/rnd
	icon = 'icons/obj/clothing/under/rnd.dmi'
	mob_overlay_icon = 'icons/mob/clothing/under/rnd.dmi'

/obj/item/clothing/under/rank/rnd/research_director
	desc = "It's a suit worn by those with the know-how to achieve the position of \"Research Director\". Its fabric provides minor protection from biological contaminants."
	name = "research director's vest suit"
	icon_state = "director"
	item_state = "lb_suit"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 10, "bio" = 10, "rad" = 0, "fire" = 0, "acid" = 35)
	can_adjust = FALSE

/obj/item/clothing/under/rank/rnd/research_director/skirt
	name = "research director's vest suitskirt"
	desc = "It's a suitskirt worn by those with the know-how to achieve the position of \"Research Director\". Its fabric provides minor protection from biological contaminants."
	icon_state = "director_skirt"
	item_state = "lb_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON | VOX_VARIATION

/obj/item/clothing/under/rank/rnd/research_director/alt
	desc = "Maybe you'll engineer your own half-man, half-pig creature some day. Its fabric provides minor protection from biological contaminants."
	name = "research director's tan suit"
	icon_state = "rdwhimsy"
	item_state = "rdwhimsy"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 10, "bio" = 10, "rad" = 0, "fire" = 0, "acid" = 0)
	can_adjust = TRUE
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/rnd/research_director/alt/skirt
	name = "research director's tan suitskirt"
	desc = "Maybe you'll engineer your own half-man, half-pig creature some day. Its fabric provides minor protection from biological contaminants."
	icon_state = "rdwhimsy_skirt"
	item_state = "rdwhimsy"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON | VOX_VARIATION

/obj/item/clothing/under/rank/rnd/research_director/turtleneck
	desc = "A dark purple turtleneck and tan khakis, for a director with a superior sense of style."
	name = "research director's turtleneck"
	icon_state = "rdturtle"
	item_state = "p_suit"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 10, "bio" = 10, "rad" = 0, "fire" = 0, "acid" = 0)
	can_adjust = TRUE
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/rnd/research_director/turtleneck/skirt
	name = "research director's turtleneck skirt"
	desc = "A dark purple turtleneck and tan khaki skirt, for a director with a superior sense of style."
	icon_state = "rdturtle_skirt"
	item_state = "p_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON | VOX_VARIATION

/obj/item/clothing/under/rank/rnd/scientist
	desc = "It's made of a special fiber that provides minor protection against explosives. It has markings that denote the wearer as a scientist."
	name = "scientist's jumpsuit"
	icon_state = "toxins"
	item_state = "w_suit"
	permeability_coefficient = 0.5
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 10, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)

/obj/item/clothing/under/rank/rnd/scientist/skirt
	name = "scientist's jumpskirt"
	desc = "It's made of a special fiber that provides minor protection against explosives. It has markings that denote the wearer as a scientist."
	icon_state = "toxinswhite_skirt"
	item_state = "w_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON | VOX_VARIATION

/obj/item/clothing/under/rank/rnd/roboticist
	desc = "It's a slimming black with reinforced seams; great for industrial work."
	name = "roboticist's jumpsuit"
	icon_state = "robotics"
	item_state = "robotics"
	resistance_flags = NONE

/obj/item/clothing/under/rank/rnd/roboticist/skirt
	name = "roboticist's jumpskirt"
	desc = "It's a slimming black with reinforced seams; great for industrial work."
	icon_state = "robotics_skirt"
	item_state = "robotics"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON | VOX_VARIATION

//Alt job uniforms

/obj/item/clothing/under/rank/rnd/scientist/junior
	name = "junior scientist jumpsuit"
	desc = "It's made of a special fiber that provides minor protection against explosives. It has markings that denote the wearer as a junior scientist."
	icon_state = "junior"

/obj/item/clothing/under/rank/rnd/scientist/junior/skirt
	name = "junior scientist jumpskirt"
	icon_state = "junior_skirt"

	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON | VOX_VARIATION

/obj/item/clothing/under/rank/rnd/scientist/xenobiologist
	name = "xenobiologist jumpsuit"
	desc = "It's made of a special fiber that provides minor protection against biohzards. Worn by xenobiologist who have no qualms in creating abominations against nature."
	icon_state = "xenobiologist"

	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 10, "rad" = 0, "fire" = 0, "acid" = 0)

/obj/item/clothing/under/rank/rnd/scientist/xenobiologist/skirt
	name = "xenobiologist jumpskirt"
	icon_state = "xenobiologist_skirt"

	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON | VOX_VARIATION

/obj/item/clothing/under/rank/rnd/scientist/nanite
	name = "nanite researcher jumpsuit"
	desc = "Worn researchers that study and applies the usage of nanites, now more microscopic things to worry about."
	icon_state = "nanite"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	resistance_flags = NONE

/obj/item/clothing/under/rank/rnd/scientist/nanite/skirt
	name = "nanite research jumpskirt"
	icon_state = "nanite_skirt"

	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON | VOX_VARIATION

/obj/item/clothing/under/rank/rnd/roboticist/biomech_engineer
	name = "biomechanical engineer jumpsuit"
	icon_state = "biomech_engineer"

/obj/item/clothing/under/rank/rnd/roboticist/biomech_engineer/skirt
	name = "biomechanical engineer jumpskirt"
	icon_state = "biomech_engineer_skirt"

	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON | VOX_VARIATION

/obj/item/clothing/under/rank/rnd/roboticist/mech_engineer
	name = "mechatronic engineer jumpsuit"
	icon_state = "mech_engineer"

/obj/item/clothing/under/rank/rnd/roboticist/mech_engineer/skirt
	name = "mechatronic engineer jumpskirt"
	icon_state = "mech_engineer_skirt"

	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON | VOX_VARIATION

/obj/item/clothing/under/suit/senior_scientist
	name = "senior scientist suit"
	desc = "A suit with science colors, meant to be worn by senior staff."
	icon_state = "senior_science"
	permeability_coefficient = 0.5
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 10, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	icon = 'icons/obj/clothing/under/rnd.dmi'
	mob_overlay_icon = 'icons/mob/clothing/under/rnd.dmi'

/obj/item/clothing/under/suit/senior_scientist/skirt
	name = "senior scientist skirtsuit"
	desc = "A skirtsuit with science colors, meant to be worn by senior staff."
	icon_state = "senior_science_skirt"

	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON | VOX_VARIATION

/obj/item/clothing/under/suit/senior_roboticist
	name = "senior roboticist suit"
	desc = "A suit with robotics colors, meant to be worn by senior staff."
	icon_state = "senior_roboticist"
	resistance_flags = NONE
	icon = 'icons/obj/clothing/under/rnd.dmi'
	mob_overlay_icon = 'icons/mob/clothing/under/rnd.dmi'

/obj/item/clothing/under/suit/senior_roboticist/skirt
	name = "senior roboticist skirtsuit"
	desc = "A skirtsuit with robotics colors, meant to be worn by senior staff."
	icon_state = "senior_roboticist_skirt"

	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON | VOX_VARIATION
