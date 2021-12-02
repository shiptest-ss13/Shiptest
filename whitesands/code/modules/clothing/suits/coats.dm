/obj/item/clothing/suit/toggle/lawyer/cmo
	name = "light blue suit jacket"
	desc = "A foppish dress jacket."
	icon_state = "suitjacket_cmo"

/obj/item/clothing/suit/toggle/lawyer/medical
	name = "saturated blue suit jacket"
	desc = "A foppish dress jacket."
	icon_state = "suitjacket_medical"

/obj/item/clothing/suit/toggle/lawyer/science
	name = "purple suit jacket"
	desc = "A foppish dress jacket."
	icon_state = "suitjacket_science"

/obj/item/clothing/suit/toggle/lawyer/brown
	name = "brown suit jacket"
	desc = "A foppish dress jacket."
	icon_state = "suitjacket_brown"

/obj/item/clothing/suit/toggle/lawyer/orange
	name = "orange suit jacket"
	desc = "A foppish dress jacket."
	icon_state = "suitjacket_orange"

/obj/item/clothing/suit/toggle/lawyer/atmos
	name = "light blue jacket"
	desc = "A foppish dress jacket."
	icon_state = "suitjacket_light_blue"

/obj/item/clothing/suit/toggle/labcoat/chemist/side
	name = "pharmacologist labcoat"
	desc = "A lab coat that buttons on the side, which provides some protection from chemical spills. It in chemistry colors."
	icon_state = "labcoat_side_chem"

/obj/item/clothing/suit/toggle/lieutenant
	name = "lieutenant's coat"
	desc = "Surplus from some military. You finally have your own coat."
	icon_state = "blueshield_coat"
	item_state = "blueshield_coat"
	allowed = list(/obj/item/gun/energy, /obj/item/reagent_containers/spray/pepper, /obj/item/ammo_box, /obj/item/ammo_casing,/obj/item/melee/baton, /obj/item/restraints/handcuffs, /obj/item/flashlight/seclite, /obj/item/melee/classic_baton)
	armor = list("melee" = 35, "bullet" = 30, "laser" = 30, "energy" = 40, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)
	body_parts_covered = CHEST|GROIN|ARMS|HANDS

/obj/item/clothing/suit/toggle/solgov
	name = "\improper SolGov coat"
	desc = "An armored coat worn for special occasions. This one is dyed in SolGov blue."
	body_parts_covered = CHEST|GROIN|ARMS|HANDS
	icon_state = "coat_solgov"
	item_state = "coat_solgov"
	blood_overlay_type = "coat"
	togglename = "buttons"
	armor = list("melee" = 35, "bullet" = 30, "laser" = 30, "energy" = 40, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)

/obj/item/clothing/suit/toggle/solgov/terragov
	name = "\improper Terragov coat"
	desc = "An armored coat worn for special occasions. This one is still dyed in original TerraGov green."
	icon_state = "coat_terragov"
	item_state = "coat_terragov"

/obj/item/clothing/suit/aclf
	name = "\improper 2nd Battlegroup jacket"
	desc = "An armored jacket worn by the Gorlex Marauders 2nd Battlegroup."
	body_parts_covered = CHEST|GROIN|ARMS|HANDS
	icon_state = "aclfjacket"
	item_state = "aclfjacket"
	blood_overlay_type = "coat"
	armor = list("melee" = 35, "bullet" = 30, "laser" = 30, "energy" = 40, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)
