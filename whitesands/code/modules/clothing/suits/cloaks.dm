/obj/item/clothing/suit/hooded/cloak/bone
	name = "Heavy bone armor"
	icon_state = "hbonearmor"
	desc = "A tribal armor plate, crafted from animal bone. A heavier variation of standard bone armor."
	armor = list("melee" = 40, "bullet" = 25, "laser" = 30, "energy" = 30, "bomb" = 30, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)
	hoodtype = /obj/item/clothing/head/hooded/cloakhood/bone
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS
	max_heat_protection_temperature = ARMOR_MAX_TEMP_PROTECT
	resistance_flags = NONE
	transparent_protection = HIDEGLOVES|HIDESUITSTORAGE|HIDEJUMPSUIT|HIDESHOES

/obj/item/clothing/head/hooded/cloakhood/bone
	name = "bone helmet"
	icon_state = "hskull"
	desc = "An intimidating tribal helmet, it doesn't look very comfortable."
	armor = list("melee" = 35, "bullet" = 25, "laser" = 25, "energy" = 10, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)
	heat_protection = HEAD
	max_heat_protection_temperature = HELMET_MAX_TEMP_PROTECT
	resistance_flags = NONE
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE
	flags_cover = HEADCOVERSEYES

/obj/item/clothing/suit/hooded/cloak/goliath/polar
	name = "polar cloak"
	icon_state = "polarcloak"
	hoodtype = /obj/item/clothing/head/hooded/cloakhood/goliath/polar
	desc = "A tribal hood made from a polar bears pelt. Keeps it's wearer warm and looks badass while doing it."
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	cold_protection = CHEST|GROIN|LEGS|FEET|ARMS

/obj/item/clothing/head/hooded/cloakhood/goliath/polar
	name = "polar cloak"
	icon_state = "polhood"
	desc = "Wear bear on head show little man you big man, kill bear for cloak."
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	cold_protection = HEAD
