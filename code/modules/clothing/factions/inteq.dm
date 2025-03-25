/obj/item/clothing/under/syndicate/inteq
	name = "inteq turtleneck"
	desc = "A rich brown turtleneck with black pants, it has a small 'IRMG' embroidered onto the shoulder."
	icon_state = "inteq"
	item_state = "bl_suit"
	has_sensor = HAS_SENSORS
	armor = list("melee" = 10, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 40)
	supports_variations = DIGITIGRADE_VARIATION | VOX_VARIATION | KEPORI_VARIATION
	alt_covers_chest = TRUE
	icon = 'icons/obj/clothing/under/syndicate.dmi'
	mob_overlay_icon = 'icons/mob/clothing/under/syndicate.dmi'

/obj/item/clothing/under/syndicate/inteq/skirt
	name = "inteq skirtleneck"
	desc = "A rich brown turtleneck with a free flowing black skirt, it has a small 'IRMG' embroidered onto the shoulder."
	icon_state = "inteq_skirt"
	item_state = "bl_suit"
	has_sensor = HAS_SENSORS
	armor = list("melee" = 10, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 40)
	body_parts_covered = CHEST|GROIN|ARMS
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON | VOX_VARIATION | KEPORI_VARIATION
	alt_covers_chest = TRUE

/obj/item/clothing/under/syndicate/inteq/artificer
	name = "inteq artificer overalls"
	desc = "A black set of overalls atop a standard issue turtleneck, for the IRMG's support division Artificers."
	icon_state = "inteqeng"
	supports_variations = KEPORI_VARIATION | VOX_VARIATION | DIGITIGRADE_VARIATION

/obj/item/clothing/under/syndicate/inteq/artificer/skirt
	name = "inteq artificer overall skirt"
	desc = "A black set of overalls in the likeness of a skirt atop a standard issue turtleneck, for the IRMG's support division Artificers."
	icon_state = "inteqeng_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	supports_variations = KEPORI_VARIATION | DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/syndicate/inteq/corpsman
	name = "inteq corpsman turtleneck"
	desc = "A sterile white turtleneck with tactical cargo pants, it is emblazoned with the lettering 'IRMG' on the shoulder. For the IRMG's support division Corpsmen."
	icon_state = "inteqmed"
	supports_variations = KEPORI_VARIATION | VOX_VARIATION | DIGITIGRADE_VARIATION

/obj/item/clothing/under/syndicate/inteq/corpsman/skirt
	name = "inteq corpsman skirtleneck"
	desc = "A sterile white turtleneck with a free flowing black skirt, it is emblazoned with the lettering 'IRMG' on the shoulder. For the IRMG's support division Corpsmen."
	icon_state = "inteqmed_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	supports_variations = KEPORI_VARIATION | VOX_VARIATION | DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/syndicate/inteq/honorable
	name = "honorable vanguard turtleneck"
	desc = "A midnight black turtleneck worn by honorable Vanguards of the IRMG."
	icon_state = "inteq_honorable"
	item_state = "inteq_honorable"
	supports_variations = KEPORI_VARIATION | DIGITIGRADE_VARIATION
