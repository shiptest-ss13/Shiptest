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

/datum/gear/accessory/tie/rainbow
	display_name = "tie, rainbow"
	path = /obj/item/clothing/neck/tie/rainbow

/datum/gear/accessory/tie/horrible
	display_name = "tie, horrible"
	path = /obj/item/clothing/neck/tie/horrible

/datum/gear/accessory/tie/trans
	display_name = "tie, transgender"
	path = /obj/item/clothing/neck/tie/trans

/datum/gear/accessory/tie/horrible
	display_name = "tie, pansexual"
	path = /obj/item/clothing/neck/tie/pan

/datum/gear/accessory/tie/enby
	display_name = "tie, nonbinary"
	path = /obj/item/clothing/neck/tie/enby

/datum/gear/accessory/tie/bi
	display_name = "tie, bisexual"
	path = /obj/item/clothing/neck/tie/bi

/datum/gear/accessory/tie/bi
	display_name = "tie, horrible"
	path = /obj/item/clothing/neck/tie/horrible

/datum/gear/accessory/tie/lesbian
	display_name = "tie, lesbian"
	path = /obj/item/clothing/neck/tie/lesbian

/datum/gear/accessory/tie/interesx
	display_name = "tie, interesx"
	path = /obj/item/clothing/neck/tie/intersex

/datum/gear/accessory/tie/gay
	display_name = "tie, gay"
	path = /obj/item/clothing/neck/tie/gay

/datum/gear/accessory/tie/gay/genderfluid
	display_name = "tie, genderfluid"
	path = /obj/item/clothing/neck/tie/genderfluid

/datum/gear/accessory/tie/asexual
	display_name = "tie, asexual"
	path = /obj/item/clothing/neck/tie/asexual

/datum/gear/accessory/tie/genderfae
	display_name = "tie, genderfae"
	path = /obj/item/clothing/neck/tie/genderfae

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
