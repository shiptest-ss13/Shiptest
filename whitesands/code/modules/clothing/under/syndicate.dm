/obj/item/clothing/under/syndicate/intern
	name = "red polo and khaki pants"
	desc = "A non-descript and slightly suspicious looking polo paired with a respectable yet also suspicious pair of khaki pants."
	icon_state = "jake"
	armor = list("melee" = 10, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 40)
	alt_covers_chest = TRUE
	icon = 'whitesands/icons/obj/clothing/under/syndicate.dmi'
	mob_overlay_icon = 'whitesands/icons/mob/clothing/under/syndicate.dmi'

/obj/item/clothing/under/syndicate/aclf
	name = "2nd Battlegroup uniform"
	desc = "A black uniform worn by the officers of the Gorlex Marauders 2nd Battlegroup."
	icon_state = "aclf"
	armor = list("melee" = 10, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 40)
	alt_covers_chest = TRUE
	icon = 'whitesands/icons/obj/clothing/under/syndicate.dmi'
	mob_overlay_icon = 'whitesands/icons/mob/clothing/under/syndicate.dmi'

/obj/item/clothing/under/syndicate/aclfgrunt
	name = "ACLF uniform"
	desc = "A button-up in a tasteful shade of gray with red pants, used as the uniform of the Anti-Corporate Liberation front on the rim."
	icon_state = "aclfgrunt"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 40)
	alt_covers_chest = TRUE
	icon = 'whitesands/icons/obj/clothing/under/syndicate.dmi'
	mob_overlay_icon = 'whitesands/icons/mob/clothing/under/syndicate.dmi'

/obj/item/clothing/under/syndicate/gorlex
	name = "Gorlex Marauder uniform"
	desc = "Originally worn by the miners of the Gorlex VII colony, it is now donned by veteran Gorlex Marauders."
	icon_state = "gorlex"
	armor = list("melee" = 10, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 40)
	alt_covers_chest = TRUE
	icon = 'whitesands/icons/obj/clothing/under/syndicate.dmi'
	mob_overlay_icon = 'whitesands/icons/mob/clothing/under/syndicate.dmi'

/obj/item/clothing/under/syndicate/cybersun
	name = "Cybersun coveralls"
	desc = "Nomex coveralls worn by workers and research personnel employed by Cybersun industries."
	icon_state = "cybersun"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 60, "acid" = 100)
	alt_covers_chest = TRUE
	icon = 'whitesands/icons/obj/clothing/under/syndicate.dmi'
	mob_overlay_icon = 'whitesands/icons/mob/clothing/under/syndicate.dmi'

/datum/outfit/syndicate/intern
	name = "Syndicate Operative - Intern"

	uniform = /obj/item/clothing/under/syndicate/intern
	suit = /obj/item/clothing/suit/space/syndicate/surplus
	suit_store = /obj/item/tank/internals/emergency_oxygen/engi
	head = /obj/item/clothing/head/helmet/space/syndicate/surplus
	mask = /obj/item/clothing/mask/breath
	shoes = /obj/item/clothing/shoes/laceup
	r_hand = /obj/item/gun/ballistic/automatic/ebr
	gloves =  null
	l_pocket = /obj/item/pinpointer/nuke/syndicate
	r_pocket = /obj/item/ammo_box/magazine/ebr
	belt = null
	back = /obj/item/tank/jetpack/oxygen/harness
	backpack_contents = null
	internals_slot = ITEM_SLOT_SUITSTORE

	tc = 10
	uplink_type = /obj/item/uplink/nuclear
	uplink_slot = ITEM_SLOT_BELT
