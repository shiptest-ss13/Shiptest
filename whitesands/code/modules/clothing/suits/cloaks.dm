/obj/item/clothing/suit/hooded/cloak/bone
	name = "Heavy bone armor"
	icon = 'whitesands/icons/obj/clothing/suits.dmi'
	mob_overlay_icon = 'whitesands/icons/mob/clothing/suits.dmi'
	icon_state = "hbonearmor"
	desc = "A tribal armor plate, crafted from animal bone. A heavier variation of standard bone armor."
	armor = list("melee" = 40, "bullet" = 25, "laser" = 30, "energy" = 30, "bomb" = 30, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)
	hoodtype = /obj/item/clothing/head/hooded/cloakhood/bone
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS
	max_heat_protection_temperature = ARMOR_MAX_TEMP_PROTECT
	resistance_flags = NONE
	transparent_protection = HIDEGLOVES|HIDESUITSTORAGE|HIDEJUMPSUIT|HIDESHOES

/obj/item/clothing/head/hooded/cloakhood/bone
	name = "bone helmet"
	icon = 'whitesands/icons/obj/clothing/hats.dmi'
	mob_overlay_icon = 'whitesands/icons/mob/clothing/head.dmi'
	icon_state = "hskull"
	desc = "An intimidating tribal helmet, it doesn't look very comfortable."
	armor = list("melee" = 35, "bullet" = 25, "laser" = 25, "energy" = 10, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)
	heat_protection = HEAD
	max_heat_protection_temperature = HELMET_MAX_TEMP_PROTECT
	resistance_flags = NONE
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE
	flags_cover = HEADCOVERSEYES
