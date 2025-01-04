/mob/living/carbon/alien/humanoid/doUnEquip(obj/item/I, force, newloc, no_move, invdrop = TRUE, silent = FALSE, use_unequip_delay = FALSE)
	. = ..()
	if(!. || !I)
		return

