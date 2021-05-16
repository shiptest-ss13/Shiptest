/obj/item/clothing/head/helmet/space/solgov
	name = "\improper SolGov Vacuum Helmet"
	icon = 'whitesands/icons/obj/clothing/hats.dmi'
	icon_state = "vachelmet_solgov"
	desc = "This space-proof helmet is meant to be worn with a matching T-MA suit."
	mob_overlay_icon = 'whitesands/icons/mob/clothing/head.dmi'
	item_state = "vachelmet_solgov"
	armor = list("melee" = 40, "bullet" = 20, "laser" = 20,"energy" = 30, "bomb" = 60, "bio" = 100, "rad" = 90, "fire" = 85, "acid" = 75)

/obj/item/clothing/suit/space/solgov
	name = "\improper SolGov Vacuum Suit"
	icon = 'whitesands/icons/obj/clothing/suits.dmi'
	icon_state = "vacsuit_solgov"
	desc = "Originally designed by independent contractors on Luna for the security team of a major hotel chain, the armored and lightweight Tortoise Microlite Armored Suit now sees widespread use by SolGov's peacekeeper forces."
	mob_overlay_icon = 'whitesands/icons/mob/clothing/suits.dmi'
	item_state = "vacsuit_solgov"
	allowed = list(/obj/item/gun, /obj/item/ammo_box, /obj/item/ammo_casing, /obj/item/melee/baton, /obj/item/melee/transforming/energy, /obj/item/tank/internals)
	armor = list("melee" = 40, "bullet" = 20, "laser" = 20,"energy" = 30, "bomb" = 60, "bio" = 100, "rad" = 90, "fire" = 85, "acid" = 75)
	slowdown = 0.5
	w_class = WEIGHT_CLASS_NORMAL
