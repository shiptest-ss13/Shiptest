/obj/item/bodypart/head/ethereal
	icon = 'icons/mob/species/ethereal/bodyparts.dmi'
	icon_state = "elzuose_head"
	limb_id = SPECIES_ELZUOSE
	is_dimorphic = FALSE
	uses_mutcolor = TRUE
	draw_sclera = FALSE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ORGANIC | BODYTYPE_SNOUT_SMALL

/obj/item/bodypart/chest/ethereal
	icon = 'icons/mob/species/ethereal/bodyparts.dmi'
	icon_state = "elzuose_chest"
	limb_id = SPECIES_ELZUOSE
	is_dimorphic = FALSE
	uses_mutcolor = TRUE

/obj/item/bodypart/l_arm/ethereal
	icon = 'icons/mob/species/ethereal/bodyparts.dmi'
	icon_state = "elzuose_l_arm"
	limb_id = SPECIES_ELZUOSE
	uses_mutcolor = TRUE

/obj/item/bodypart/r_arm/ethereal
	icon = 'icons/mob/species/ethereal/bodyparts.dmi'
	icon_state = "elzuose_r_arm"
	limb_id = SPECIES_ELZUOSE
	uses_mutcolor = TRUE

/obj/item/bodypart/leg/left/ethereal
	icon = 'icons/mob/species/ethereal/bodyparts.dmi'
	icon_state = "elzuose_l_leg"
	limb_id = SPECIES_ELZUOSE
	uses_mutcolor = TRUE

/obj/item/bodypart/leg/right/ethereal
	icon = 'icons/mob/species/ethereal/bodyparts.dmi'
	icon_state = "elzuose_r_leg"
	limb_id = SPECIES_ELZUOSE
	uses_mutcolor = TRUE

/obj/item/bodypart/tail/elzu
	icon = 'icons/mob/species/ethereal/bodyparts.dmi'
	name = "elzuose tail"
	desc = "A detached Elzuose's tail. You probably shouldn't plant this."
	icon_state = "elzuose_tail"
	limb_id = SPECIES_ELZUOSE
	uses_mutcolor = TRUE
	body_weight = 8
	can_thump = TRUE

/obj/item/bodypart/tail/elzu/bifurcated
	name = "bifurcated elzuose tail"
	icon_state = "bifurcated_elzuose_tail"
	limb_id = "bifurcated_" + SPECIES_ELZUOSE
	can_thump = FALSE

/obj/item/bodypart/tail/elzu/stubby
	name = "stubby elzuose tail"
	icon_state = "stubby_elzuose_tail"
	limb_id = "stubby_" + SPECIES_ELZUOSE
	body_weight = 4
	can_thump = FALSE
