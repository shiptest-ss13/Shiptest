///inteq underclothes file
/obj/item/clothing/under/inteq
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

/obj/item/clothing/under/inteq/skirt
	name = "inteq skirtleneck"
	desc = "A rich brown turtleneck with a free flowing black skirt, it has a small 'IRMG' embroidered onto the shoulder."
	icon_state = "inteq_skirt"
	item_state = "bl_suit"
	has_sensor = HAS_SENSORS
	armor = list("melee" = 10, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 40)
	body_parts_covered = CHEST|GROIN|ARMS
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON | VOX_VARIATION | KEPORI_VARIATION
	alt_covers_chest = TRUE

/obj/item/clothing/under/inteq/artificer
	name = "inteq artificer overalls"
	desc = "A black set of overalls atop a standard issue turtleneck, for the IRMG's support division Artificers."
	icon_state = "inteqeng"
	supports_variations = KEPORI_VARIATION | VOX_VARIATION | DIGITIGRADE_VARIATION

/obj/item/clothing/under/inteq/skirt/artificer
	name = "inteq artificer overall skirt"
	desc = "A black set of overalls in the likeness of a skirt atop a standard issue turtleneck, for the IRMG's support division Artificers."
	icon_state = "inteqeng_skirt"
	supports_variations = KEPORI_VARIATION | DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/inteq/corpsman
	name = "inteq corpsman turtleneck"
	desc = "A sterile white turtleneck with tactical cargo pants, it is emblazoned with the lettering 'IRMG' on the shoulder. For the IRMG's support division Corpsmen."
	icon_state = "inteqmed"
	supports_variations = KEPORI_VARIATION | VOX_VARIATION | DIGITIGRADE_VARIATION

/obj/item/clothing/under/inteq/skirt/corpsman
	name = "inteq corpsman skirtleneck"
	desc = "A sterile white turtleneck with a free flowing black skirt, it is emblazoned with the lettering 'IRMG' on the shoulder. For the IRMG's support division Corpsmen."
	icon_state = "inteqmed_skirt"
	supports_variations = KEPORI_VARIATION | DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/inteq/skirt/maid
	name = "inteq tactical maid outfit"
	desc = "A 'tactical' turtleneck fashioned to the likeness of a maid outfit. This one is lovingly knitted in the colors of the IRMG."
	icon_state = "inteqmaid"
	item_state = "inteqmaid"
	can_adjust = FALSE
	supports_variations = KEPORI_VARIATION | VOX_VARIATION | DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/inteq/skirt/maid/Initialize()
	. = ..()
	var/obj/item/clothing/accessory/maidapron/inteq/A = new (src)
	attach_accessory(A)

/obj/item/clothing/under/inteq/honorable
	name = "honorable vanguard turtleneck"
	desc = "a midnight black turtleneck worn by honorable Vanguards of the IRMG."
	icon_state = "inteq_honorable"
	item_state = "inteq_honorable"
	supports_variations = KEPORI_VARIATION | DIGITIGRADE_VARIATION
