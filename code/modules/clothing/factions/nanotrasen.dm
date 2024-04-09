// Uniforms //

/obj/item/clothing/under/nanotrasen
	name = "deckhand's uniform"
	desc = ""
	icon = 'icons/obj/clothing/faction/nanotrasen/uniforms.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/nanotrasen/uniforms.dmi'
	lefthand_file = 'icons/mob/inhands/faction/nanotrasen/nt_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/nanotrasen/nt_righthand.dmi'
	icon_state = "deckhand"
	item_state = "graycloth"

// Engineering uniforms
/obj/item/clothing/under/nanotrasen/engineering
	name = "engineering jumpsuit"
	desc = 
	icon_state = "engi"
	item_state = "greycloth"

/obj/item/clothing/under/nanotrasen/engineering/atmos
	name = "atmospherics jumpsuit"
	desc = 
	icon_state = "atmos_tech"
	item_state = "greycloth"

/obj/item/clothing/under/nanotrasen/engineering/director
	name = "director's overalls"
	desc = 
	icon_state = "engi_director"
	item_state = "blackcloth"

//Supply uniforms
/obj/item/clothing/under/nanotrasen/supply
	name = "supply shorts"
	desc = 
	icon_state = "supply"
	item_state = "browncloth"

/obj/item/clothing/under/nanotrasen/supply/qm
	name = "supply pants"
	desc = 
	icon_state = "supply_director"
	item_state = "browncloth"

/obj/item/clothing/under/nanotrasen/supply/miner
	name = "supply overalls"
	desc = 
	icon_state = "miner"
	item_state = "browncloth"

//Science uniforms
/obj/item/clothing/under/nanotrasen/science
	name = "science slacks"
	desc = 
	icon_state = "sci"
	item_state = "whitecloth"

/obj/item/clothing/under/nanotrasen/science/robotics
	name = "robotics jumpsuit"
	desc = 
	icon_state = "robotics"
	item_state = "blackcloth"

/obj/item/clothing/under/nanotrasen/science/director
	name = "science director's slacks"
	desc = 
	icon_state = "sci_director"
	item_state = 

//Medical uniforms
/obj/item/clothing/under/nanotrasen/medical
	name = "medical slacks"
	desc = 
	icon_state = "doctor"
	item_state = "whitecloth"

/obj/item/clothing/under/nanotrasen/medical/paramedic
	name = "paramedic slacks"
	desc = 
	icon_state = "paramedic"
	item_state = "whitecloth"

/obj/item/clothing/under/nanotrasen/medical/director
	name = "medical director's slacks"
	desc = 
	icon_state = "medical_cirector"
	item_state = "bluecloth"

//Security/civilian uniforms

/obj/item/clothing/under/nanotrasen/janitor
	name = "janitor's uniform"
	desc = 
	icon_state = "janitor"
	item_state = "graycloth"

/obj/item/clothing/under/nanotrasen/affairs
	name = "neatly pleated slacks"
	desc = 
	icon_state = "affairs"
	item_state = "whitecloth"

/obj/item/clothing/under/nanotrasen/security
	name = "security slacks"
	desc = 
	icon_state = "security"
	item_state = "graycloth"

/obj/item/clothing/under/nanotrasen/security/director
	name = "security director's slacks"
	desc = 
	icon_state = "security_director"
	item_state = "redcloth"

//Command uniforms
/obj/item/clothing/under/nanotrasen/captain
	name = "captain's slacks"
	desc = 
	icon_state = "captain"
	item_state = "bluecloth"

/obj/item/clothing/under/nanotrasen/captain/skirt
	name = "captain's skirt"
	desc = 
	icon_state = "captain_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON

/*
/obj/item/clothing/under/nanotrasen/captain/parade
	name = 
	desc =
	icon_state = "captain_parade"
	can_adjust = FALSE
*/

/obj/item/clothing/under/nanotrasen/officer
	name = "officer's slacks"
	desc = 
	icon_state = "officer"
	item_state = "bluecloth"

/obj/item/clothing/under/nanotrasen/officer/skirt
	name = "officer's skirt"
	desc = 
	icon_state = "officer_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON

// Suits //

/obj/item/clothing/suit/nanotrasen //Base type, do not use
	name = "Suit"
	desc = "You shouldn't be here."
	icon = 'icons/obj/clothing/faction/nanotrasen/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/nanotrasen/suits.dmi'
	lefthand_file = 'icons/mob/inhands/faction/nanotrasen/nt_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/nanotrasen/nt_righthand.dmi'

/obj/item/clothing/suit/nanotrasen/medical_smock
	name = "surgical smock"
	desc = 
	icon_state = "med_smock"
	item_state = "bluecloth"

/obj/item/clothing/suit/nanotrasen/suitjacket
	name = "fancy suit jacket"
	desc = 
	icon_state = "suit_jacket"
	item_state = "blackcloth"

/obj/item/clothing/suit/nanotrasen/vest
	name = "black hazard vest"
	desc = 
	icon_state = "engi_vest"
	item_state = "blackcloth"

/obj/item/clothing/suit/nanotrasen/vest/blue
	name = "blue hazard vest"
	desc = 
	icon_state = "atmos_vest"
	item_state = "bluecloth"

/obj/item/clothing/suit/toggle/nanotrasen
	name = "officer's coat"
	desc = 
	icon = 'icons/obj/clothing/faction/nanotrasen/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/nanotrasen/suits.dmi'
	lefthand_file = 'icons/mob/inhands/faction/nanotrasen/nt_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/nanotrasen/nt_righthand.dmi'
	icon_state = "officer_formal"
	item_state = "bluecloth"

/obj/item/clothing/suit/toggle/labcoat/nanotrasen
	name = "labcoat"
	desc = ""
	icon = 'icons/obj/clothing/faction/nanotrasen/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/nanotrasen/suits.dmi'
	lefthand_file = 'icons/mob/inhands/faction/nanotrasen/nt_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/nanotrasen/nt_righthand.dmi'
	icon_state = "labcoat"
	item_state = "whitecloth"

/obj/item/clothing/suit/toggle/labcoat/nanotrasen/blue
	name = "medical director's labcoat"
	desc = ""
	icon_state = "med_labcoat"
	item_state = "whitecloth"

/obj/item/clothing/suit/toggle/labcoat/nanotrasen/black
	name = "science director's labcoat"
	desc = ""
	icon_state = "black_labcoat"
	item_state = "blackcloth"

/obj/item/clothing/suit/toggle/labcoat/nanotrasen/paramedic
	name = "paramedic jacket"
	desc = ""
	icon_state = "med_jacket"
	item_state = "bluecloth"

/obj/item/clothing/suit/armor/nanotrasen
	name = "armor vest"
	desc = "A protective vest produced by Nanotrasen. Comes with a free stripe."
	icon = 'icons/obj/clothing/faction/nanotrasen/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/nanotrasen/suits.dmi'
	lefthand_file = 'icons/mob/inhands/faction/nanotrasen/nt_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/nanotrasen/nt_righthand.dmi'
	icon_state = "armor"
	item_state = "blackcloth"
	body_parts_covered = CHEST|GROIN
	armor = list("melee" = 30, "bullet" = 40, "laser" = 30, "energy" = 50, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 90)
	resistance_flags = FIRE_PROOF

/obj/item/clothing/suit/armor/nanotrasen/slim
	name = "slim armor vest"
	icon_state = "armor_slim"

/obj/item/clothing/suit/armor/nanotrasen/sec_director
	name = "security director's overcoat"
	desc = ""
	icon_state = "command_coat"
	body_parts_covered = CHEST|GROIN|ARMS
	armor = list("melee" = 30, "bullet" = 0, "laser" = 30, "energy" = 20, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 90)

/obj/item/clothing/suit/armor/nanotrasen/captain
	name = "commanding officer's vest"
	desc = ""
	icon_state = "armor_captain"
	item_state = "bluecloth"
	body_parts_covered = CHEST|GROIN
	armor = list("melee" = 50, "bullet" = 60, "laser" = 60, "energy" = 50, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 90)
	resistance_flags = FIRE_PROOF

/obj/item/clothing/suit/armor/nanotrasen/captain/parade
	name = "captain's fancy coat"
	desc = 
	icon_state = "captain_formal"
	item_state = "bluecloth"
	body_parts_covered = CHEST|GROIN|ARMS
	armor = list("melee" = 30, "bullet" = 0, "laser" = 30, "energy" = 20, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 90)

// Hats //

/obj/item/clothing/head/nanotrasen
	name = "blue flatcap"
	desc = ""
	icon = 'icons/obj/clothing/faction/nanotrasen/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/nanotrasen/head.dmi'
	lefthand_file = 'icons/mob/inhands/faction/nanotrasen/nt_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/nanotrasen/nt_righthand.dmi'
	icon_state = "com_flatcap"
	item_state = "bluecloth"

/obj/item/clothing/head/nanotrasen/beret
	name = "fancy blue beret"
	desc = ""
	icon_state = "beret_blue"
	item_state = "bluecloth"

/obj/item/clothing/head/nanotrasen/beret/security
	name = "fancy red beret"
	desc = ""
	icon_state = "beret_red"
	item_state = "redcloth"

/obj/item/clothing/head/nanotrasen/beret/security/command
	name = "fancy black beret"
	desc = ""
	icon_state = "beret_blue"
	item_state = "bluecloth"

/obj/item/clothing/head/nanotrasen/surgical
	name = "surgical cap"
	desc = ""
	icon_state = "surgical_white"
	item_state = "whitecloth"

/obj/item/clothing/head/nanotrasen/surgical/blue
	name = "blue surgical cap"
	desc = ""
	icon_state = "surgical_blue"
	item_state = "bluecloth"

/obj/item/clothing/head/nanotrasen/cap // Base type, do not use
	name = "generic cap"
	desc = "You don't belong here."

/obj/item/clothing/head/nanotrasen/cap/security
	name = "red softcap"
	desc = ""
	icon_state = "cap_red"
	item_state = "redcloth"

/obj/item/clothing/head/nanotrasen/cap/supply
	name = "brown softcap"
	desc = ""
	icon_state = "cap_brown"
	item_state = "browncloth"

/obj/item/clothing/head/nanotrasen/cap/janitor
	name = "purple softcap"
	desc = ""
	icon_state = "cap_purple"
	//item_state = "purplecloth" //todo: purple

/obj/item/clothing/head/nanotrasen/cap/medical
	name = "blue softcap"
	desc = ""
	icon_state = "cap_blue"
	item_state = "bluecloth"

/obj/item/clothing/head/nanotrasen/officer
	name = "officer's hat"
	desc = ""
	icon_state = "officer_peaked"
	item_state = "bluecloth"

/obj/item/clothing/head/nanotrasen/officer
	name = "officer's fedora"
	desc = ""
	icon_state = "officer_fedora"
	item_state = "bluecloth"

/obj/item/clothing/head/nanotrasen/captain
	name = "captain's ornamental hat"
	desc = ""
	icon_state = "com_hat"
	item_state = "bluecloth"

/obj/item/clothing/head/nanotrasen/captain/peaked
	name = "captain's peaked cap"
	desc = ""
	icon_state = "com_peaked"
	item_state = "bluecloth"

/obj/item/clothing/head/hardhat/nanotrasen //TODO: inhands for hardhats
	name = "black heavy-duty hat"
	desc = 
	icon = 'icons/obj/clothing/faction/nanotrasen/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/nanotrasen/head.dmi'
	lefthand_file = 'icons/mob/inhands/faction/nanotrasen/nt_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/nanotrasen/nt_righthand.dmi'
	icon_state = "hardhat_black"
	item_state = "blackcloth"

/obj/item/clothing/head/hardhat/nanotrasen/blue
	name = "blue heavy-duty hat"
	desc = ""
	icon_state = "hardhat_blue"
	item_state = "bluecloth"

/obj/item/clothing/head/hardhat/nanotrasen/white
	name = "white heavy-duty hat"
	desc = ""
	icon_state = "hardhat_white"
	item_state = "graycloth"


// Neck //

/obj/item/clothing/neck/cloak/nanotrasen
	name = "command sash"
	desc = ""
	icon = 'icons/obj/clothing/faction/nanotrasen/neck.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/nanotrasen/neck.dmi'
	lefthand_file = 'icons/mob/inhands/faction/nanotrasen/nt_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/nanotrasen/nt_righthand.dmi'
	icon_state = "sash"
	item_state = "redcloth"
