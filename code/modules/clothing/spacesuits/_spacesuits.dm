//Note: Everything in modules/clothing/spacesuits should have the entire suit grouped together.
//      Meaning the the suit is defined directly after the corrisponding helmet. Just like below!
/obj/item/clothing/head/helmet/space
	name = "space helmet"
	icon = 'icons/obj/clothing/head/spacesuits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/head/spacesuits.dmi'
	icon_state = "spaceold"
	desc = "A special helmet with solar UV shielding to protect your eyes from harmful rays."
	clothing_flags = STOPSPRESSUREDAMAGE | THICKMATERIAL | SNUG_FIT | BLOCK_GAS_SMOKE_EFFECT | ALLOWINTERNALS
	item_state = "spaceold"
	permeability_coefficient = 0.01
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 100, "rad" = 50, "fire" = 80, "acid" = 70, "wound" = 10)
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	cold_protection = HEAD
	min_cold_protection_temperature = SPACE_HELM_MIN_TEMP_PROTECT
	heat_protection = HEAD
	max_heat_protection_temperature = SPACE_HELM_MAX_TEMP_PROTECT
	flash_protect = FLASH_PROTECTION_WELDER
	strip_delay = 50
	equip_delay_other = 50
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH | PEPPERPROOF | SEALS_EYES
	resistance_flags = NONE
	dog_fashion = null
	content_overlays = FALSE
	pocket_storage_component_path = null
	equip_self_flags = null

/obj/item/clothing/suit/space
	name = "space suit"
	desc = "A suit that protects against low pressure environments. Has a big 13 on the back."
	icon = 'icons/obj/clothing/suits/spacesuits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/suits/spacesuits.dmi'
	icon_state = "spaceold"
	item_state = "s_suit"
	w_class = WEIGHT_CLASS_BULKY
	gas_transfer_coefficient = 0.01
	permeability_coefficient = 0.02
	clothing_flags = STOPSPRESSUREDAMAGE | THICKMATERIAL
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals)
	slowdown = 1
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 100, "rad" = 50, "fire" = 80, "acid" = 70, "wound" = 10)
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT
	cold_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	min_cold_protection_temperature = SPACE_SUIT_MIN_TEMP_PROTECT
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	max_heat_protection_temperature = SPACE_SUIT_MAX_TEMP_PROTECT
	strip_delay = 80
	equip_delay_other = 80
	resistance_flags = NONE
	greyscale_colors = list(list(17, 16), list(9, 17), list(13, 13))
	greyscale_icon_state = "spacesuit"
	equip_self_flags = null
