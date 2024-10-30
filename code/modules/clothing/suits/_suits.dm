/obj/item/clothing/suit
	icon = 'icons/obj/clothing/suits.dmi'
	lefthand_file = 'icons/mob/inhands/clothing/suits_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/clothing/suits_righthand.dmi'
	name = "suit"
	var/fire_resist = T0C+100
	allowed = list(/obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman)
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	drop_sound = 'sound/items/handling/cloth_drop.ogg'
	pickup_sound =  'sound/items/handling/cloth_pickup.ogg'
	slot_flags = ITEM_SLOT_OCLOTHING
	blood_overlay_type = "suit"
	var/togglename = null
	var/suittoggled = FALSE
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/exo //WS Edit - Exowear Pockets
	greyscale_colors = list(list(13, 16), list(10, 18), list(13, 21))
	greyscale_icon_state = "coat"
	supports_variations = VOX_VARIATION
	mob_overlay_icon = 'icons/mob/clothing/suit.dmi'

/obj/item/clothing/suit/worn_overlays(isinhands = FALSE)
	. = ..()
	if(!isinhands)
		if(damaged_clothes)
			. += mutable_appearance('icons/effects/item_damage.dmi', "damageduniform")
		if(HAS_BLOOD_DNA(src))
			. += setup_blood_overlay()

		var/mob/living/carbon/human/M = loc
		if(ishuman(M) && M.w_uniform)
			var/obj/item/clothing/under/U = M.w_uniform
			if(istype(U) && U.attached_accessory)
				var/obj/item/clothing/accessory/A = U.attached_accessory
				if(A.above_suit)
					. += U.accessory_overlay

/obj/item/clothing/suit/update_clothes_damaged_state(damaging = TRUE)
	..()
	if(ismob(loc))
		var/mob/M = loc
		M.update_inv_wear_suit()
