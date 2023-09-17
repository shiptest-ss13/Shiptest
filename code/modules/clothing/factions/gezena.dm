//Jumpsuits
//thgvr TODO: Make more stuff (backpacks, headsets, doodads, part 2?) also guns lol
/obj/item/clothing/under/gezena
	name = "gezenan navywear"
	desc = "Made of a slick synthetic material that is both breathable, and resistant to scale and thorn alike."
	icon = 'icons/obj/clothing/faction/gezena/uniforms.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/gezena/uniforms.dmi'
	icon_state = "naval"
	item_state = "naval"
	supports_variations = DIGITIGRADE_VARIATION
	armor = list("melee" = 10, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 40)

/obj/item/clothing/under/gezena/captain
	name = "gezenan captain's navywear"
	desc = "A refined variation of the basic navywear, sporting sleek silver trim."
	icon_state = "captain"
	item_state = "captain"

/obj/item/clothing/under/gezena/marine
	name = "gezenan marine fatigue"
	desc = "Rough inside and out, these fatigues have seen their fair share."
	icon_state = "marine"
	item_state = "marine"

//Unarmored suit

/obj/item/clothing/suit/toggle/gezena
	name = "silkenweave jacket"
	desc = "Refined and sturdy, emblazoned below the neck with the Federation's symbol."
	icon = 'icons/obj/clothing/faction/gezena/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/gezena/suits.dmi'
	icon_state = "lightcoat"
	item_state = "lightcoat"
	blood_overlay_type = "coat"
	togglename = "zipper"
	body_parts_covered = CHEST|ARMS
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/exo
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON
	armor = list("melee" = 20, "bullet" = 20, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 0)

//Armored suit

/obj/item/clothing/suit/armor/gezena
	name = "navywear coat"
	desc = "Formal navywear, emblazoned across the back with the Gezenan sigil."
	icon = 'icons/obj/clothing/faction/gezena/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/gezena/suits.dmi'
	icon_state = "coat"
	item_state = "coat"
	blood_overlay_type = "coat"
	body_parts_covered = CHEST|ARMS|GROIN|LEGS
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/exo
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON
	armor = list("melee" = 35, "bullet" = 35, "laser" = 20, "energy" = 40, "bomb" = 20, "bio" = 20, "rad" = 0, "fire" = 50, "acid" = 50)
	allowed = list(
					/obj/item/flashlight,
					/obj/item/tank/internals/emergency_oxygen,
					/obj/item/tank/internals/plasmaman,
					/obj/item/toy,
					/obj/item/storage/fancy/cigarettes,
					/obj/item/lighter,
					/obj/item/radio,
					/obj/item/gun/energy/kalix,
					)

/obj/item/clothing/suit/armor/gezena/engi
	name = "engineer navywear coat"
	desc = "Oil and stain resistant, with orange trim signifiying the wearer doesn't mind getting their hands dirty."
	icon_state = "engicoat"
	item_state = "engicoat"

/obj/item/clothing/suit/armor/gezena/captain
	name = "captain's navywear coat"
	desc = "Blood resistant, with silver trim to denote status. Lined with softer material."
	icon_state = "captaincoat"
	item_state = "captaincoat"

/obj/item/clothing/suit/armor/gezena/marine
	name = "\improper Raksha-plating vest"
	desc = "Raksha - a Kalixcian word for 'protection of the heart'. Sturdy and reliable."
	icon_state = "marinevest"
	item_state = "marinevest"

/obj/item/clothing/suit/armor/gezena/marinecoat
	name = "coated Raksha-plating"
	desc = "Less practical with the coat than without."
	icon_state = "marinecoat"
	item_state = "marinecoat"

//Spacesuits

/obj/item/clothing/suit/space/gezena
	name = "\improper Rakalla-suit"
	desc = "Rakalla - a Kalixcian word for 'protection among the stars'. Sturdy, flexible, and reliable."
	icon = 'icons/obj/clothing/faction/gezena/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/gezena/suits.dmi'
	item_state = "spacesuit"
	icon_state = "spacesuit"
	armor = list("melee" = 15, "bullet" = 10, "laser" = 10, "energy" = 10, "bomb" = 15, "bio" = 100, "rad" = 50, "fire" = 75, "acid" = 75)
	w_class = WEIGHT_CLASS_NORMAL
	supports_variations = DIGITIGRADE_VARIATION

/obj/item/clothing/head/helmet/space/gezena
	name = "\improper Rakalla-helm"
	desc = "Featuring rubberized grommets fitting for any length of horn, and an internal monitor for life support."
	icon = 'icons/obj/clothing/faction/gezena/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/gezena/head.dmi'
	item_state = "spacehelmet"
	icon_state = "spacehelmet"
	armor = list("melee" = 15, "bullet" = 10, "laser" = 10, "energy" = 10, "bomb" = 15, "bio" = 100, "rad" = 50, "fire" = 75, "acid" = 75)
	w_class = WEIGHT_CLASS_NORMAL

//Hats

/obj/item/clothing/head/gezena
	name = "navywear cap"
	desc = "PH"
	icon = 'icons/obj/clothing/faction/gezena/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/gezena/head.dmi'
	icon_state = "navalhat"
	item_state = "navalhat"
	armor = list("melee" = 10, "bullet" = 10, "laser" = 10, "energy" = 10, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)

/obj/item/clothing/head/gezena/flap
	name = "navywear flap-hat"
	desc = "PH"
	icon_state = "navalflap"
	item_state = "navalflap"

/obj/item/clothing/head/gezena/marine
	name = "\improper Gezenan marine cap"
	desc = "PH"
	icon_state = "marinehat"
	item_state = "marinehat"

/obj/item/clothing/head/gezena/marine/flap
	name = "\improper Gezenan marine"
	desc = "PH"
	icon_state = "marineflap"
	item_state = "marineflap"

/obj/item/clothing/head/gezena/medic
	name = "PGF medic hat"
	desc = "PH"
	icon_state = "medichat"
	item_state = "medichat"

/obj/item/clothing/head/gezena/medic/flap
	name = "PGF navy flap hat"
	desc = "PH"
	icon_state = "medicflap"
	item_state = "medicflap"

/obj/item/clothing/head/gezena/captain // no captain flap yet(?)
	name = "captain's navywear cap"
	desc = "PH"
	icon_state = "captainhat"
	item_state = "captainhat"

/obj/item/clothing/head/helmet/gezena
	name = "\improper Raksha-helm"
	desc = "PH"
	icon = 'icons/obj/clothing/faction/gezena/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/gezena/head.dmi'
	icon_state = "marinehelmet"
	item_state = "marinehelmet"

//Gloves

/obj/item/clothing/gloves/gezena
	name = "navywear gloves"
	desc = "PH"
	icon = 'icons/obj/clothing/faction/gezena/hands.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/gezena/hands.dmi'
	icon_state = "navalgloves"
	item_state = "navalgloves"
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	armor = list("melee" = 5, "bullet" = 5, "laser" = 5, "energy" = 5, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)

/obj/item/clothing/gloves/gezena/marine
	name = "gezenan infantry gloves"
	desc = "PH"
	icon_state = "marinegloves"
	item_state = "marinegloves"
	armor = list("melee" = 10, "bullet" = 10, "laser" = 10, "energy" = 10, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 75, "acid" = 50)

/obj/item/clothing/gloves/gezena/engi
	name = "gezenan engineering gloves"
	desc = "PH"
	icon_state = "engigloves"
	item_state = "engigloves"
	siemens_coefficient = 0

/obj/item/clothing/gloves/gezena/captain
	name = "captain's navywear gloves"
	desc = "PH"
	icon_state = "captaingloves"
	item_state = "captaingloves"
	siemens_coefficient = 0

//Boots

/obj/item/clothing/shoes/combat/gezena 
	name = "gezenan steel-boots"
	desc = "PH"
	icon = 'icons/obj/clothing/faction/gezena/feet.dmi'
	//mob_overlay_icon = 'icons/mob/clothing/faction/gezena/belt.dmi' todo: find out why digi breaks here
	icon_state = "pgfboots"
	item_state = "pgfboots"

//Belt

/obj/item/storage/belt/military/gezena
	name = "infantry pouches"
	desc = "PH"
	icon = 'icons/obj/clothing/faction/gezena/belt.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/gezena/belt.dmi'
	icon_state = "pouches"
	item_state = "pouches"

/obj/item/storage/belt/medical/gezena
	name = "infantry medical pouches"
	desc = "PH"
	icon = 'icons/obj/clothing/faction/gezena/belt.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/gezena/belt.dmi'
	icon_state = "medpouches"
	item_state = "medpouches"

//Capes

/obj/item/clothing/neck/cloak/gezena
	name = "gezenan half-cape"
	desc = "PH."
	icon = 'icons/obj/clothing/faction/gezena/neck.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/gezena/neck.dmi'
	icon_state = "cape"
	item_state = "cape"

/obj/item/clothing/neck/cloak/gezena/engi
	name = "gezenan engineer's half-cape"
	desc = "PH."
	icon_state = "engicape"
	item_state = "engicape"

/obj/item/clothing/neck/cloak/gezena/med
	name = "gezenan medic's half-cape"
	desc = "PH."
	icon_state = "medcape"
	item_state = "medcape"

/obj/item/clothing/neck/cloak/gezena/captain
	name = "gezenan captain's half-cape"
	desc = "PH."
	icon_state = "captaincape"
	item_state = "captaincape"
