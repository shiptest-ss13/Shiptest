//Jumpsuits
//thgvr TODO: Make more stuff (backpacks, headsets, doodads, part 2?) also guns lol
/obj/item/clothing/under/gezena
	name = "pgf navy jump"
	desc = "PH"
	icon = 'icons/obj/clothing/faction/gezena/uniforms.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/gezena/uniforms.dmi'
	icon_state = "naval"
	item_state = "naval"
	supports_variations = DIGITIGRADE_VARIATION
	armor = list("melee" = 10, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 40)

/obj/item/clothing/under/gezena/captain
	name = "pgf captain jump"
	desc = "PH"
	icon_state = "captain"
	item_state = "captain"

/obj/item/clothing/under/gezena/marine
	name = "pgf marine jump"
	desc = "PH"
	icon_state = "marine"
	item_state = "marine"

//Unarmored suit

/obj/item/clothing/suit/toggle/gezena
	name = "pgf jacket PH"
	desc = "PH"
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
	name = "pgf longcoat"
	desc = "PH"
	icon = 'icons/obj/clothing/faction/gezena/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/gezena/suits.dmi'
	icon_state = "coat"
	item_state = "coat"
	blood_overlay_type = "coat"
	body_parts_covered = CHEST|ARMS|GROIN|LEGS
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/exo
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON
	armor = list("melee" = 35, "bullet" = 35, "laser" = 20, "energy" = 40, "bomb" = 20, "bio" = 20, "rad" = 0, "fire" = 50, "acid" = 50)
	allowed = list(	/obj/item/flashlight,
					/obj/item/tank/internals/emergency_oxygen,
					/obj/item/tank/internals/plasmaman,
					/obj/item/toy,
					/obj/item/storage/fancy/cigarettes,
					/obj/item/lighter,
					/obj/item/radio,
					)

/obj/item/clothing/suit/armor/gezena/engi
	name = "pgf engineer coat"
	desc = "PH"
	icon_state = "engicoat"
	item_state = "engicoat"

/obj/item/clothing/suit/armor/gezena/captain
	name = "pgf captain coat"
	desc = "PH"
	icon_state = "captaincoat"
	item_state = "captaincoat"

/obj/item/clothing/suit/armor/gezena/marine
	name = "pgf armor vest"
	desc = "PH"
	icon_state = "marinevest"
	item_state = "marinevest"

/obj/item/clothing/suit/armor/gezena/marinecoat
	name = "pgf armor vest with coat"
	desc = "PH"
	icon_state = "marinecoat"
	item_state = "marinecoat"

//Spacesuits

/obj/item/clothing/suit/space/gezena
	name = "pgf space suit"
	desc = "PH"
	icon = 'icons/obj/clothing/faction/gezena/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/gezena/suits.dmi'
	item_state = "spacesuit"
	icon_state = "spacesuit"
	armor = list("melee" = 15, "bullet" = 10, "laser" = 10, "energy" = 10, "bomb" = 15, "bio" = 100, "rad" = 50, "fire" = 75, "acid" = 75)
	w_class = WEIGHT_CLASS_NORMAL
	supports_variations = DIGITIGRADE_VARIATION

/obj/item/clothing/head/helmet/space/gezena
	name = "pgf space helmet"
	desc = "PH"
	icon = 'icons/obj/clothing/faction/gezena/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/gezena/head.dmi'
	item_state = "spacehelmet"
	icon_state = "spacehelmet"
	armor = list("melee" = 15, "bullet" = 10, "laser" = 10, "energy" = 10, "bomb" = 15, "bio" = 100, "rad" = 50, "fire" = 75, "acid" = 75)
	w_class = WEIGHT_CLASS_NORMAL

//Hats

/obj/item/clothing/head/gezena
	name = "PGF navy hat"
	desc = "PH"
	icon = 'icons/obj/clothing/faction/gezena/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/gezena/head.dmi'
	icon_state = "navalhat"
	item_state = "navalhat"
	armor = list("melee" = 10, "bullet" = 10, "laser" = 10, "energy" = 10, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)

/obj/item/clothing/head/gezena/flap
	name = "PGF navy flap hat"
	desc = "PH"
	icon_state = "navalflap"
	item_state = "navalflap"

/obj/item/clothing/head/gezena/marine
	name = "PGF marine hat"
	desc = "PH"
	icon_state = "marinehat"
	item_state = "marinehat"

/obj/item/clothing/head/gezena/marine/flap
	name = "PGF navy flap hat"
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
	name = "PGF captain hat"
	desc = "PH"
	icon_state = "captainhat"
	item_state = "captainhat"

/obj/item/clothing/head/helmet/gezena
	name = "pgf marine helmet"
	desc = "PH"
	icon_state = "marinehelmet"
	item_state = "marinehelmet"

//Gloves

/obj/item/clothing/gloves/gezena
	name = "pgf navy gloves"
	desc = "PH"
	icon = 'icons/obj/clothing/faction/gezena/hands.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/gezena/hands.dmi'
	icon_state = "navalgloves"
	item_state = "navalgloves"
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	armor = list("melee" = 5, "bullet" = 5, "laser" = 5, "energy" = 5, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)

/obj/item/clothing/gloves/gezena/marine
	name = "pgf marine gloves"
	desc = "PH"
	icon_state = "marinegloves"
	item_state = "marinegloves"
	armor = list("melee" = 10, "bullet" = 10, "laser" = 10, "energy" = 10, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 75, "acid" = 50)

/obj/item/clothing/gloves/gezena/engi
	name = "pgf engi gloves"
	desc = "PH"
	icon_state = "engigloves"
	item_state = "engigloves"
	siemens_coefficient = 0

/obj/item/clothing/gloves/gezena/captain
	name = "pgf captain gloves"
	desc = "PH"
	icon_state = "captaingloves"
	item_state = "captaingloves"
	siemens_coefficient = 0

//Boots

/obj/item/clothing/shoes/combat/gezena
	name = "pgf duty boots"
	desc = "PH"
	icon_state = "pgfboots"
	item_state = "pgfboots"

//Belt

/obj/item/storage/belt/military/gezena
	name = "pgf drop pouches"
	desc = "PH"
	icon = 'icons/obj/clothing/faction/gezena/belt.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/gezena/belt.dmi'
	icon_state = "pouches"
	item_state = "pouches"

/obj/item/storage/belt/medical/gezena
	name = "pgf med pouches"
	desc = "PH"
	icon = 'icons/obj/clothing/faction/gezena/belt.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/gezena/belt.dmi'
	icon_state = "medpouches"
	item_state = "medpouches"

//Capes

/obj/item/clothing/neck/cloak/gezena
	name = "pgf halfcape"
	desc = "PH."
	icon = 'icons/obj/clothing/faction/gezena/neck.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/gezena/neck.dmi'
	icon_state = "cape"
	item_state = "cape"

/obj/item/clothing/neck/cloak/gezena/engi
	name = "pgf engi halfcape"
	desc = "PH."
	icon_state = "engicape"
	item_state = "engicape"

/obj/item/clothing/neck/cloak/gezena/med
	name = "pgf med halfcape"
	desc = "PH."
	icon_state = "medcape"
	item_state = "medcape"

/obj/item/clothing/neck/cloak/gezena/captain
	name = "pgf captain halfcape"
	desc = "PH."
	icon_state = "captaincape"
	item_state = "captaincape"
