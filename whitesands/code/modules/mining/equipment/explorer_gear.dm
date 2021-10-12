/obj/item/clothing/suit/hooded/survivor
	name = "survivor suit"
	desc = "A ragged makeshift suit resembling the explorer suit, covered with the emblems of a failed revolution. It's been repaired so many times it's hard to tell if it's more suit or patch. The joints have been redesigned for quicker movement."
	icon = 'whitesands/icons/obj/clothing/suits.dmi'
	lefthand_file = 'whitesands/icons/mob/inhands/clothing/lefthand.dmi'
	righthand_file = 'whitesands/icons/mob/inhands/clothing/righthand.dmi'
	mob_overlay_icon = 'whitesands/icons/mob/clothing/suits.dmi'
	icon_state = "survivor_suit"
	item_state = "survivor_suit"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	min_cold_protection_temperature = (FIRE_SUIT_MIN_TEMP_PROTECT * 2)
	cold_protection = CHEST|GROIN|LEGS|ARMS
	max_heat_protection_temperature = (FIRE_SUIT_MAX_TEMP_PROTECT / 2)
	heat_protection = CHEST|GROIN|LEGS|ARMS
	hoodtype = /obj/item/clothing/head/hooded/survivor_hood
	armor = list("melee" = 15, "bullet" = 10, "laser" = 10, "energy" = 15, "bomb" = 20, "bio" = 100, "rad" = 20, "fire" = 50, "acid" = 30)
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals, /obj/item/resonator, /obj/item/mining_scanner, /obj/item/t_scanner/adv_mining_scanner, /obj/item/gun/energy/kinetic_accelerator, /obj/item/pickaxe, /obj/item/pinpointer/deepcore)
	resistance_flags = FIRE_PROOF
	slowdown = -0.3//finally, a reason for shiptesters to steal this

/obj/item/clothing/head/hooded/survivor_hood
	name = "survivor hood"
	desc = "A loose-fitting hood, patched up with sealant and adhesive. Somewhat protects the head from the environment, but gets the job done."
	icon = 'whitesands/icons/obj/clothing/hats.dmi'
	mob_overlay_icon = 'whitesands/icons/mob/clothing/head.dmi'
	icon_state = "survivor_hood"
	suit = /obj/item/clothing/suit/hooded/survivor
	body_parts_covered = HEAD
	flags_inv = HIDEHAIR|HIDEFACE|HIDEEARS
	min_cold_protection_temperature = FIRE_HELM_MIN_TEMP_PROTECT
	max_heat_protection_temperature = FIRE_HELM_MAX_TEMP_PROTECT
	armor = list("melee" = 15, "bullet" = 10, "laser" = 10, "energy" = 15, "bomb" = 20, "bio" = 100, "rad" = 20, "fire" = 50, "acid" = 30)
	resistance_flags = FIRE_PROOF
