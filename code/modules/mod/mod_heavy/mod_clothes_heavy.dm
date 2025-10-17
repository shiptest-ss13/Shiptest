/obj/item/clothing/head/mod/heavy
	name = "power armor helmet"
	desc = "A helmet for a MODsuit."
	icon = 'icons/obj/clothing/modsuit/mod_clothing.dmi'
	icon_state = "corporate-helmet"
	base_icon_state = "helmet"
	mob_overlay_icon = 'icons/mob/clothing/modsuit/mod_clothing.dmi'
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	body_parts_covered = HEAD
	heat_protection = HEAD
	cold_protection = HEAD
	obj_flags = IMMUTABLE_SLOW
	visor_flags = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|ALLOWINTERNALS

	equipping_sound = null
	unequipping_sound = null
	equip_delay_self = null
	strip_delay = null
	equip_self_flags = null

/obj/item/clothing/suit/mod/heavy
	name = "power armor chestplate"
	desc = "A chestplate for power armor."
	icon = 'icons/obj/clothing/modsuit/mod_clothing.dmi'
	icon_state = "corporate-chestplate"
	base_icon_state = "chestplate"
	mob_overlay_icon = 'icons/mob/clothing/modsuit/mod_clothing.dmi'
	blood_overlay_type = "armor"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	body_parts_covered = CHEST|GROIN
	heat_protection = CHEST|GROIN
	cold_protection = CHEST|GROIN
	obj_flags = IMMUTABLE_SLOW

	equipping_sound = null
	unequipping_sound = null
	equip_delay_self = null
	strip_delay = null
	equip_self_flags = null

/obj/item/clothing/gloves/mod/heavy
	name = "power armor gauntlets"
	desc = "A pair of gauntlets for power armor."
	icon = 'icons/obj/clothing/modsuit/mod_clothing.dmi'
	icon_state = "corporate-gauntlets"
	base_icon_state = "gauntlets"
	mob_overlay_icon = 'icons/mob/clothing/modsuit/mod_clothing.dmi'
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	body_parts_covered = HANDS|ARMS
	heat_protection = HANDS|ARMS
	cold_protection = HANDS|ARMS
	obj_flags = IMMUTABLE_SLOW

	equipping_sound = null
	unequipping_sound = null
	equip_delay_self = null
	strip_delay = null
	equip_self_flags = null

/obj/item/clothing/shoes/mod/heavy
	name = "power armor boots"
	desc = "A pair of boots for power armort."
	icon = 'icons/obj/clothing/modsuit/mod_clothing.dmi'
	icon_state = "corporate-boots"
	base_icon_state = "boots"
	mob_overlay_icon = 'icons/mob/clothing/modsuit/mod_clothing.dmi'
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	body_parts_covered = FEET|LEGS
	heat_protection = FEET|LEGS
	cold_protection = FEET|LEGS
	obj_flags = IMMUTABLE_SLOW
	supports_variations = DIGITIGRADE_VARIATION
	can_be_tied = FALSE
	visor_flags_inv = HIDESHOES

	equipping_sound = null
	unequipping_sound = null
	equip_delay_self = null
	strip_delay = null
	equip_self_flags = null
