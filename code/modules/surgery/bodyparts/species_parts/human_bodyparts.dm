/obj/item/bodypart/tail/human
	icon = 'icons/mob/species/human/bodyparts.dmi'
	sturdy = FALSE

/obj/item/bodypart/tail/human/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_EASYDISMEMBER, INNATE_TRAIT) // none of these are particularly sturdy

/obj/item/bodypart/tail/human/cat
	name = "cat tail"
	desc = "A severed cat tail. Who's wagging now?"
	icon_state = "cat_tail"
	limb_id = "cat"

/obj/item/bodypart/tail/human/dog
	name = "dog tail"
	desc = "A severed dog tail."
	icon_state = "dog_tail"
	limb_id = "dog"

/obj/item/bodypart/tail/human/fox
	name = "fox tail"
	desc = "A severed fox tail. Sad."
	icon_state = "fox_tail"
	limb_id = "fox"

/obj/item/bodypart/tail/human/fox/alt
	name = "fox tail (alt)"
	desc = "A severed fox tail. Sad."
	icon_state = "fox2_tail"
	limb_id = "fox2"

/obj/item/bodypart/tail/human/horse
	name = "horse tail"
	desc = "A severed horse tail, not of the flora variety."
	icon_state = "horse_tail"
	limb_id = "horse"
	can_wag = FALSE

/obj/item/bodypart/tail/human/rabbit
	name = "rabbit tail"
	desc = "A severed rabbit tail."
	icon_state = "rabbit_tail"
	limb_id = "rabbit"
	body_weight = 2 // MUCH too small
