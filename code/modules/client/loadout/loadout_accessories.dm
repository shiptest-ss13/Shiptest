//Neckwear

/datum/gear/neckwear
	subtype_path = /datum/gear/neckwear
	slot = ITEM_SLOT_NECK

	//Scarves

/datum/gear/neckwear/scarf
	subtype_path = /datum/gear/neckwear/scarf
	sort_categories = "Scarves"

/datum/gear/neckwear/scarf/red
	display_name = "scarf, red"
	path = /obj/item/clothing/neck/scarf/red
	sort_categories = "Scarves, Colored, Red"

/datum/gear/neckwear/scarf/green
	display_name = "scarf, green"
	path = /obj/item/clothing/neck/scarf/green
	sort_categories = "Scarves, Colored, Green"

/datum/gear/neckwear/scarf/blue
	display_name = "scarf, blue"
	path = /obj/item/clothing/neck/scarf/darkblue
	sort_categories = "Scarves, Colored, Blue"

/datum/gear/neckwear/scarf/striped
	subtype_path = /datum/gear/neckwear/scarf/striped

/datum/gear/neckwear/scarf/striped/red
	display_name = "striped scarf, red"
	path = /obj/item/clothing/neck/stripedredscarf
	sort_categories = "Scarves, Colored, Red"

/datum/gear/neckwear/scarf/striped/green
	display_name = "striped scarf, green"
	path = /obj/item/clothing/neck/stripedgreenscarf
	sort_categories = "Scarves, Colored, Green"

/datum/gear/neckwear/scarf/striped/blue
	display_name = "striped scarf, blue"
	path = /obj/item/clothing/neck/stripedbluescarf
	sort_categories = "Scarves, Colored, Blue"

	//Ties

/datum/gear/neckwear/tie
	subtype_path = /datum/gear/neckwear/tie
	sort_categories = "Ties"

/datum/gear/neckwear/tie/recolorable
	display_name = "tie, recolorable"
	path =  /obj/item/clothing/neck/tie
	sort_categories = "Ties, Recolorable"

	//Misc

/datum/gear/neckwear/shemagh
	display_name = "shemagh"
	path = /obj/item/clothing/neck/shemagh

/datum/gear/neckwear/stethoscope
	display_name = "stethoscope"
	path = /obj/item/clothing/neck/stethoscope
	allowed_roles = list(
		/datum/job/cmo,
		/datum/job/doctor,
		/datum/job/paramedic)

/datum/gear/neckwear/collar
	display_name = "pet collar"
	description = "Only the truly insane would wear this around their neck."
	path = /obj/item/clothing/neck/petcollar

/datum/gear/neckwear/maidneckpiece
	display_name = "maid neckpiece"
	path = /obj/item/clothing/neck/maid

//Gloves

/datum/gear/gloves
	subtype_path = /datum/gear/gloves
	slot = ITEM_SLOT_GLOVES

/datum/gear/gloves/black
	display_name = "gloves, black"
	description = "Standard hand coverings for everyday use."
	path = /obj/item/clothing/gloves/color/black
	sort_categories = "Colored, Black"

/datum/gear/gloves/white
	display_name = "gloves, white"
	description = "Standard hand coverings for everyday use."
	path = /obj/item/clothing/gloves/color/white
	sort_categories = "Colored, White"

/datum/gear/gloves/evening
	display_name = "evening gloves"
	description = "Excessively fancy elbow-length gloves."
	path = /obj/item/clothing/gloves/color/evening

/datum/gear/gloves/maid
	display_name = "maid arm covers"
	path = /obj/item/clothing/gloves/maid

//Facewear

/datum/gear/facewear
	subtype_path = /datum/gear/facewear
	slot = ITEM_SLOT_MASK

/datum/gear/facewear/bandana
	display_name = "face bandana, red"
	path = /obj/item/clothing/mask/bandana/red

/datum/gear/facewear/surgical_mask
	display_name = "surgical mask"
	path = /obj/item/clothing/mask/surgical

/datum/gear/facewear/balaclava
	display_name = "balaclava"
	path = /obj/item/clothing/mask/balaclava

/datum/gear/facewear/tiki
	display_name = "tiki mask"
	description = "A wooden mask, simple, really."
	path = /obj/item/clothing/mask/gas/tiki_mask

/datum/gear/facewear/joymask
	display_name = "face with tears of joy mask"
	path = /obj/item/clothing/mask/joy

/datum/gear/facewear/horse
	display_name = "horse mask"
	path = /obj/item/clothing/mask/horsehead

//Attachables

/datum/gear/attachables/waistcoat
	display_name = "waistcoat"
	path = /obj/item/clothing/accessory/waistcoat
	sort_categories = "Attachables"
