/obj/item/clothing/shoes
	var/is_digitigrade = 0

/obj/item/clothing/shoes/Initialize()
	. = ..()

	if(is_digitigrade == 1)
		obj_flags |= DIGITIGRADE_COMPATIBLE
	else if(is_digitigrade == 2)
		obj_flags |= DIGITIGRADE_SHOE

/obj/item/clothing/shoes/proc/digi_alt(mob/living/carbon/human/user, set_icon_to)
	if(set_icon_to)
		mob_overlay_icon = 'waspstation/icons/mob/clothing/digialt.dmi'
	else
		mob_overlay_icon = 'waspstation/icons/mob/clothing/feet.dmi'
	user.update_inv_shoes()
	return
