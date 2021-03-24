/obj/item/clothing/under/syndicate/intern
	name = "red polo and khaki pants"
	desc = "A non-descript and slightly suspicious looking polo paired with a respectable yet also suspicious pair of khaki pants."
	icon_state = "jake"
	armor = list("melee" = 10, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 40)
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
