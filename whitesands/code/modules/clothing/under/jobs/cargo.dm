//Alt uniforms

//QM

/obj/item/clothing/under/suit/qm
	name = "supply chief suit"
	desc = "A suit with supply colors, worn by those who lead the supply department."
	icon_state = "supply_chief"
	fitted = NO_FEMALE_UNIFORM
	icon = 'icons/obj/clothing/under/cargo.dmi'
	mob_overlay_icon = 'icons/mob/clothing/under/cargo.dmi'

/obj/item/clothing/under/suit/qm/skirt
	name = "supply chief skirtsuit"
	icon_state = "supply_chief_skirt"

	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON

//Cargo

/obj/item/clothing/under/suit/cargo_tech
	name = "deliveries officer suit"
	desc = "A suit with cargo colors, with a pair of shorts..."
	icon_state = "deliveries_officer"
	fitted = NO_FEMALE_UNIFORM
	icon = 'icons/obj/clothing/under/cargo.dmi'
	mob_overlay_icon = 'icons/mob/clothing/under/cargo.dmi'

/obj/item/clothing/under/suit/cargo_tech/skirt
	name = "deliveries officer skirtsuit"
	desc = "A suit with cargo colors, with a skirt..."
	icon_state = "deliveries_officer_skirt"

	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/rank/cargo/tech/mailroom_technician
	name = "mailroom technician's jumpsuit"
	desc = "Shorts and lost mail makes up this jumpsuit."
	icon_state = "mailroom_technician"
	body_parts_covered = CHEST|GROIN|ARMS
	// mutantrace_variation = NO_MUTANTRACE_VARIATION
	fitted = NO_FEMALE_UNIFORM
	icon = 'icons/obj/clothing/under/cargo.dmi'
	mob_overlay_icon = 'icons/mob/clothing/under/cargo.dmi'

/obj/item/clothing/under/rank/cargo/tech/mailroom_technician/skirt
	name = "mailroom technician's jumpskirt"
	desc = "Skirts and lost mail makes up this jumpskirt."
	icon_state = "mailroom_technician_skirt"
	can_adjust = FALSE
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON
