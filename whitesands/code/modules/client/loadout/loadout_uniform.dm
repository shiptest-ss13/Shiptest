// Uniform slot
/datum/gear/uniform
	subtype_path = /datum/gear/uniform
	slot = ITEM_SLOT_ICLOTHING
	sort_category = "Uniforms"

// Utility jumpsuits

/datum/gear/uniform/utility
	path = /obj/item/clothing/under/utility
	description = "A cheaply manufactured jumpsuit made out of cheap materials designed for use by cheap labor."
	cost = 0

/datum/gear/uniform/utility_skirt
	path = /obj/item/clothing/under/utility/skirt
	description = "Does it being a skirt defeat the purpose of use in a hazardous work environment?"
	cost = 0

//Colored jumpsuits

/datum/gear/uniform/color
	subtype_path = /datum/gear/uniform/color
	cost = 1000

/datum/gear/uniform/color/red
	display_name = "jumpsuit, red"
	path = /obj/item/clothing/under/color/red

/datum/gear/uniform/color/green
	display_name = "jumpsuit, green"
	path = /obj/item/clothing/under/color/green

/datum/gear/uniform/color/blue
	display_name = "jumpsuit, blue"
	path = /obj/item/clothing/under/color/blue

/datum/gear/uniform/color/yellow
	display_name = "jumpsuit, yellow"
	path = /obj/item/clothing/under/color/yellow

/datum/gear/uniform/color/pink
	display_name = "jumpsuit, pink"
	path = /obj/item/clothing/under/color/pink

/datum/gear/uniform/color/black
	display_name = "jumpsuit, black"
	path = /obj/item/clothing/under/color/black

/datum/gear/uniform/color/white
	display_name = "jumpsuit, white"
	path = /obj/item/clothing/under/color/white

/datum/gear/uniform/color/random
	display_name = "jumpsuit, random"
	path = /obj/item/clothing/under/color/random //literally useless if grey assistants is off
	cost = 2500

/datum/gear/uniform/color/rainbow
	display_name = "jumpsuit, rainbow"
	path = /obj/item/clothing/under/color/rainbow
	cost = 5000

//Shorts

/datum/gear/uniform/athshortsred
	display_name = "athletic shorts, red"
	path = /obj/item/clothing/under/shorts/red
	cost = 1000

/datum/gear/uniform/athshortsblack
	display_name = "athletic shorts, black"
	path = /obj/item/clothing/under/shorts/black
	cost = 1000

//JUMPSUIT "SUITS"

/datum/gear/uniform/suit
	subtype_path = /datum/gear/uniform/suit
	cost = 1000

/datum/gear/uniform/suit/amish
	display_name = "suit, amish"
	path = /obj/item/clothing/under/suit/sl

/datum/gear/uniform/suit/white
	display_name = "suit, white"
	path = /obj/item/clothing/under/suit/white

/datum/gear/uniform/suit/tan
	display_name = "suit, tan"
	path = /obj/item/clothing/under/suit/tan

/datum/gear/uniform/suit/black
	display_name = "suit, executive"
	path = /obj/item/clothing/under/suit/black_really

/datum/gear/uniform/suit/black/skirt
	display_name = "suitskirt, executive"
	path = /obj/item/clothing/under/suit/black_really/skirt

/datum/gear/uniform/suit/navy
	display_name = "suit, navy"
	path = /obj/item/clothing/under/suit/navy

/datum/gear/uniform/suit/burgundy
	display_name = "suit, burgundy"
	path = /obj/item/clothing/under/suit/burgundy

/datum/gear/uniform/suit/galaxy
	display_name = "suit, galaxy"
	path = /obj/item/clothing/under/rank/civilian/lawyer/galaxy
	cost = 7500

/datum/gear/uniform/suit/white/skirt
	display_name = "suitskirt, white shirt"
	path = /obj/item/clothing/under/suit/black/skirt

/datum/gear/uniform/suit/white_shirt
	display_name = "suit, white shirt"
	path = /obj/item/clothing/under/suit/black

//Premium
/datum/gear/uniform/tacticool
	display_name = "tacticool turtleneck"
	path = /obj/item/clothing/under/syndicate/tacticool
	cost = 10000

/datum/gear/uniform/psychedelic
	display_name = "psychedelic suit"
	path = /obj/item/clothing/under/misc/psyche
	cost = 10000
