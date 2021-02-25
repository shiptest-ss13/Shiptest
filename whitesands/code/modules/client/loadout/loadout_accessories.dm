/datum/gear/accessory
	subtype_path = /datum/gear/accessory
	slot = ITEM_SLOT_NECK
	sort_category = "Accessories"

//Scarves

/datum/gear/accessory/scarf
	subtype_path = /datum/gear/accessory/scarf
	cost = 500

/datum/gear/accessory/scarf/red
	display_name = "scarf, red"
	path = /obj/item/clothing/neck/scarf/red

/datum/gear/accessory/scarf/green
	display_name = "scarf, green"
	path = /obj/item/clothing/neck/scarf/green

/datum/gear/accessory/scarf/blue
	display_name = "scarf, blue"
	path = /obj/item/clothing/neck/scarf/darkblue

//(The actually good scarves)

/datum/gear/accessory/scarf/striped
	subtype_path = /datum/gear/accessory/scarf/striped
	cost = 750

/datum/gear/accessory/scarf/striped/red
	display_name = "striped scarf, red"
	path = /obj/item/clothing/neck/stripedredscarf

/datum/gear/accessory/scarf/striped/green
	display_name = "striped scarf, green"
	path = /obj/item/clothing/neck/stripedgreenscarf

/datum/gear/accessory/scarf/striped/blue
	display_name = "striped scarf, blue"
	path = /obj/item/clothing/neck/stripedbluescarf

//Ties

/datum/gear/accessory/tie
	subtype_path = /datum/gear/accessory/tie
	cost = 500

/datum/gear/accessory/tie/black
	display_name = "tie, black"
	path =  /obj/item/clothing/neck/tie/black

/datum/gear/accessory/tie/red
	display_name = "tie, red"
	path =  /obj/item/clothing/neck/tie/red

/datum/gear/accessory/tie/blue
	display_name = "tie, blue"
	path =  /obj/item/clothing/neck/tie/blue

/datum/gear/accessory/tie/horrible
	display_name = "tie, horrible"
	path = /obj/item/clothing/neck/tie/horrible

//Misc

/datum/gear/accessory/armband_red
	display_name = "armband"
	path = /obj/item/clothing/accessory/armband
	slot = null
	cost = 750

/datum/gear/accessory/stethoscope
	display_name = "stethoscope"
	path = /obj/item/clothing/neck/stethoscope
	allowed_roles = list("Medical Doctor", "Chief Medical Officer")
	cost = 750

/datum/gear/accessory/collar
	display_name = "pet collar"
	description = "Only the truly insane would wear this around their neck."
	path = /obj/item/clothing/neck/petcollar
	cost = 5000
