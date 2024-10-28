/obj/item/clothing/suit/hooded/hoodie
	name = "hoodie"
	desc = "HOW"
	icon_state = null
	hoodtype = /obj/item/clothing/head/hooded/hood
	body_parts_covered = CHEST|ARMS
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/exo/large
	allowed = list(	/obj/item/flashlight,
					/obj/item/tank/internals/emergency_oxygen,
					/obj/item/tank/internals/plasmaman,
					/obj/item/toy,
					/obj/item/storage/fancy/cigarettes,
					/obj/item/lighter,
					/obj/item/radio,
					/obj/item/storage/pill_bottle
					)
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0) //it's just a hoodie.
	supports_variations = KEPORI_VARIATION

/obj/item/clothing/head/hooded/hood
	name = "hood"
	desc = "HOW"
	icon_state = null
	icon = 'icons/obj/clothing/head/winterhood.dmi'
	mob_overlay_icon = 'icons/mob/clothing/head/winterhood.dmi'
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

/obj/item/clothing/suit/hooded/hoodie/fbp
	name = "\improper FBP kepori hoodie"
	desc = "A hoodie themed to look like a kepori in a Full Body Prosthetic. It has a comfy pocket for keeping your hands warm."
	icon_state = "hoodie_fbp"
	item_state = "hoodie_fbp"
	hoodtype = /obj/item/clothing/head/hooded/hood/fbp

/obj/item/clothing/head/hooded/hood/fbp
	name = "\improper FBP kepori hood"
	desc = "A hood for your FBP hoodie."
	icon_state = "hoodie_fbp"
	item_state = "hoodie_fbp"

/obj/item/clothing/suit/hooded/hoodie/rilena
	name = "K4L1 hoodie"
	desc = "A hoodie themed to look like K4L1 from the popular webseries RILENA. It has a comfy pocket for keeping your hands warm."
	icon_state = "hoodie_rilena"
	item_state = "hoodie_rilena"
	hoodtype = /obj/item/clothing/head/hooded/hood/rilena

/obj/item/clothing/suit/hooded/hoodie/rilena/equipped(mob/user, slot)
	. = ..()
	if(slot != ITEM_SLOT_OCLOTHING)
		return
	var/mob/living/L = user
	if(HAS_TRAIT(L, TRAIT_FAN_RILENA))
		SEND_SIGNAL(L, COMSIG_ADD_MOOD_EVENT, "hoodie_rilena", /datum/mood_event/rilena_super_fan)

/obj/item/clothing/suit/hooded/hoodie/rilena/dropped(mob/user)
	. = ..()
	var/mob/living/L = user
	if(HAS_TRAIT(L, TRAIT_FAN_RILENA))
		SEND_SIGNAL(L, COMSIG_CLEAR_MOOD_EVENT, "hoodie_rilena")

/obj/item/clothing/head/hooded/hood/rilena
	name = "RILENA: LMR K4L1 hood"
	desc = "A hood for your RILENA themed hoodie."
	icon_state = "hoodie_rilena"
	item_state = "hoodie_rilena"

/obj/item/clothing/suit/hooded/hoodie/blackwa
	name = "black and white hoodie"
	desc = "A hoodie that is black, with a white hood. It has a comfy pocket for keeping your hands warm."
	icon_state = "hoodie_bwa"
	item_state = "hoodie_bwa"
	hoodtype = /obj/item/clothing/head/hooded/hood/gray
