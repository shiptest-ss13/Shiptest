/datum/gear/accessory
	subtype_path = /datum/gear/accessory
	slot = ITEM_SLOT_NECK
	sort_category = "Accessories"

//Scarves

/datum/gear/accessory/scarf
	subtype_path = /datum/gear/accessory/scarf

/datum/gear/accessory/scarf/red
	display_name = "scarf, red"
	path = /obj/item/clothing/neck/scarf/red

/datum/gear/accessory/scarf/green
	display_name = "scarf, green"
	path = /obj/item/clothing/neck/scarf/green

/datum/gear/accessory/scarf/blue
	display_name = "scarf, blue"
	path = /obj/item/clothing/neck/scarf/darkblue

/datum/gear/accessory/shemagh
	display_name = "shemagh"
	path = /obj/item/clothing/neck/shemagh

//(The actually good scarves)

/datum/gear/accessory/scarf/striped
	subtype_path = /datum/gear/accessory/scarf/striped

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

/datum/gear/accessory/tie/recolorable
	display_name = "tie, recolorable"
	path =  /obj/item/clothing/neck/tie

//Gloves

/datum/gear/accessory/gloves
	subtype_path = /datum/gear/accessory/gloves
	slot = ITEM_SLOT_GLOVES

/datum/gear/accessory/gloves/black
	display_name = "gloves, black"
	description = "Standard hand coverings for everyday use."
	path = /obj/item/clothing/gloves/color/black

/datum/gear/accessory/gloves/white
	display_name = "gloves, white"
	description = "Standard hand coverings for everyday use."
	path = /obj/item/clothing/gloves/color/white

/datum/gear/accessory/gloves/brown
	display_name = "gloves, brown"
	description = "Standard hand coverings for everyday use."
	path = /obj/item/clothing/gloves/color/brown

/datum/gear/accessory/gloves/fingerless
	display_name = "gloves, fingerless"
	description = "Radical hand coverings for everyday use."
	path = /obj/item/clothing/gloves/fingerless

/datum/gear/accessory/gloves/evening
	display_name = "gloves, evening"
	description = "Excessively fancy elbow-length gloves."
	path = /obj/item/clothing/gloves/color/evening

//Bone

/datum/gear/accessory/fangnecklace
	display_name = "wolf fang necklace"
	path = /obj/item/clothing/neck/fangnecklace

/datum/gear/accessory/bonearmlet
	display_name = "bone armlet"
	path = /obj/item/clothing/accessory/bonearmlet
	slot = null

//Masks

/datum/gear/accessory/mask
	subtype_path = /datum/gear/accessory/mask
	slot = ITEM_SLOT_MASK

/datum/gear/accessory/mask/bandana
	subtype_path = /datum/gear/accessory/mask/bandana

/datum/gear/accessory/mask/bandana/red
	display_name = "bandana, red"
	path = /obj/item/clothing/mask/bandana/red

/datum/gear/accessory/mask/bandana/skull
	display_name = "bandana, skull"
	path = /obj/item/clothing/mask/bandana/skull

/datum/gear/accessory/mask/bandana/black
	display_name = "bandana, black"
	path = /obj/item/clothing/mask/bandana/black

/datum/gear/accessory/mask/bandana/blue
	display_name = "bandana, blue"
	path = /obj/item/clothing/mask/bandana/blue

/datum/gear/accessory/mask/surgical
	display_name = "surgical mask"
	path = /obj/item/clothing/mask/surgical

/datum/gear/accessory/mask/balaclava
	display_name = "balaclava"
	path = /obj/item/clothing/mask/balaclava

//Misc

/datum/gear/accessory/waistcoat
	display_name = "waistcoat"
	path = /obj/item/clothing/accessory/waistcoat
	slot = null

/datum/gear/accessory/stethoscope
	display_name = "stethoscope"
	path = /obj/item/clothing/neck/stethoscope
	allowed_roles = list("Medical Doctor", "Chief Medical Officer")

/datum/gear/accessory/headphones
	display_name = "headphones"
	slot = ITEM_SLOT_EARS
	path = /obj/item/instrument/piano_synth/headphones

/datum/gear/accessory/pocketprotector
	display_name = "pocket protector"
	path = /obj/item/clothing/accessory/pocketprotector
