/obj/item/clothing/suit/hooded/hoodie/
	name = "hoodie"
	desc = "HOW"
	hoodtype = /obj/item/clothing/head/hooded/hood/
	body_parts_covered = CHEST|ARMS
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/exo/large
	allowed = list(	/obj/item/flashlight,
					/obj/item/tank/internals/emergency_oxygen,
					/obj/item/tank/internals/plasmaman,
					/obj/item/toy,
					/obj/item/storage/fancy/cigarettes,
					/obj/item/lighter,
					/obj/item/radio,
					)
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0) //it's just a hoodie.
	supports_variations = KEPORI_VARIATION

/obj/item/clothing/head/hooded/hood/
	name = "hood"
	desc = "HOW"
	body_parts_covered = HEAD
	flags_inv = HIDEHAIR|HIDEEARS
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0) //it's just a hoodie.
	supports_variations = KEPORI_VARIATION

/obj/item/clothing/suit/hooded/hoodie/black
	name = "black hoodie"
	desc = "A hoodie that is black. It has a comfy pocket for keeping your hands warm."
	icon_state = "hoodie_black"
	item_state = "hoodie_black"
	hoodtype = /obj/item/clothing/head/hooded/hood/black

/obj/item/clothing/head/hooded/hood/black
	name = "black hood"
	desc = "A black hood for your black hoodie."
	icon_state = "hoodie_black"
	item_state = "hoodie_black"

/obj/item/clothing/suit/hooded/hoodie/red
	name = "red hoodie"
	desc = "A hoodie that is red. It has a comfy pocket for keeping your hands warm."
	icon_state = "hoodie_red"
	item_state = "hoodie_red"
	hoodtype = /obj/item/clothing/head/hooded/hood/red

/obj/item/clothing/head/hooded/hood/red
	name = "red hood"
	desc = "A red hood for your red hoodie."
	icon_state = "hoodie_red"
	item_state = "hoodie_red"

/obj/item/clothing/suit/hooded/hoodie/blue
	name = "blue hoodie"
	desc = "A hoodie that is blue. It has a comfy pocket for keeping your hands warm."
	icon_state = "hoodie_blue"
	item_state = "hoodie_blue"
	hoodtype = /obj/item/clothing/head/hooded/hood/blue

/obj/item/clothing/head/hooded/hood/blue
	name = "blue hood"
	desc = "A blue hood for your blue hoodie."
	icon_state = "hoodie_blue"
	item_state = "hoodie_blue"

/obj/item/clothing/suit/hooded/hoodie/gray
	name = "gray hoodie"
	desc = "A hoodie that is gray. It has a comfy pocket for keeping your hands warm."
	icon_state = "hoodie_gray"
	item_state = "hoodie_gray"
	hoodtype = /obj/item/clothing/head/hooded/hood/gray

/obj/item/clothing/head/hooded/hood/gray
	name = "gray hood"
	desc = "A gray hood for your gray hoodie."
	icon_state = "hoodie_gray"
	item_state = "hoodie_gray"
