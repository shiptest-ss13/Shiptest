/obj/item/clothing/head/helmet/space/hardsuit/terragov
	name = "terragov hardsuit helmet"
	desc = "An armored spaceproof helmet. The glass has a metallic shine on it."
	icon_state = "hardsuit0-terra"
	item_state = "terra_helm"
	hardsuit_type = "terra"
	armor = list("melee" = 50, "bullet" = 45, "laser" = 40,"energy" = 30, "bomb" = 60, "bio" = 100, "rad" = 90, "fire" = 85, "acid" = 75)
	icon = 'waspstation/icons/obj/clothing/hats.dmi'
	mob_overlay_icon = 'waspstation/icons/mob/clothing/head.dmi'

/obj/item/clothing/suit/space/hardsuit/terragov
	icon_state = "terrasuit"
	name = "terragov hardsuit"
	desc = "An armored spaceproof suit. An exoskeleton helps the user not have slowdown, allowing full mobility with the suit."
	item_state = "terrasuit"
	armor = list("melee" = 50, "bullet" = 45, "laser" = 40, "energy" = 30, "bomb" = 60, "bio" = 100, "rad" = 90, "fire" = 85, "acid" = 75) //intentionally the fucking strong, this is master chief-tier armor
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/terragov
	slowdown = 0
	icon = 'waspstation/icons/obj/clothing/suits.dmi'
	mob_overlay_icon = 'waspstation/icons/mob/clothing/suits.dmi'
	
