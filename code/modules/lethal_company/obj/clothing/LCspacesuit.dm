/obj/item/clothing/head/helmet/space/lethal
	name = "Company issued space helmet"
	desc = "Never in your life have you seen something more bulky and awkward than this."
	icon = 'spacehelm_item.dmi'
	mob_overlay_icon = 'spacehelm_worn.dmi'
	item_state = "lethal_helmet"
	icon_state = "lethal_helmet"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	flash_protect = 0

/obj/item/clothing/suit/space/lethal
	name = "Company issued spacesuit"
	desc = "This thing... is complete garbage. Disposable suit for disposable people!"
	icon = 'spacesuit_item.dmi'
	mob_overlay_icon = 'spacesuit_worn.dmi'
	item_state = "lethal_suit"
	icon_state = "lethal_suit"
	slowdown = 0
	permeability_coefficient = 1
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 3, "fire" = 0, "acid" = 0)
