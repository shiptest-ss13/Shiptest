/datum/gear/eyewear
	subtype_path = /datum/gear/eyewear
	slot = ITEM_SLOT_EYES
	sort_category = "Eyewear"

//Glasses
/datum/gear/eyewear/glasses
	subtype_path = /datum/gear/eyewear/glasses
	sort_subcategories = "Glasses"

/datum/gear/eyewear/glasses/cheapsuns
	display_name = "cheap sunglasses"
	path = /obj/item/clothing/glasses/cheapsuns

/datum/gear/eyewear/glasses/cold
	display_name = "cold goggles"
	path = /obj/item/clothing/glasses/cold

/datum/gear/eyewear/glasses/heat
	display_name = "heat goggles"
	path = /obj/item/clothing/glasses/heat

/datum/gear/eyewear/glasses/orange
	display_name = "orange sunglasses"
	path = /obj/item/clothing/glasses/orange

/datum/gear/eyewear/glasses/red
	display_name = "red glasses"
	path = /obj/item/clothing/glasses/red

//Prescription glasses
/datum/gear/eyewear/glasses/prescription
	subtype_path = /datum/gear/eyewear/glasses/prescription
	sort_subcategories = "Glasses, Prescription Glasses"

/datum/gear/eyewear/glasses/prescription/regular
	display_name = "prescription glasses"
	path = /obj/item/clothing/glasses/regular
	role_replacements = list(

		//SecHUD
		/datum/job/hos = /obj/item/clothing/glasses/hud/security/prescription,
		/datum/job/warden = /obj/item/clothing/glasses/hud/security/prescription,
		//Science
		/datum/job/chemist = /obj/item/clothing/glasses/science/prescription,
		//MedHUD
		/datum/job/brig_phys = /obj/item/clothing/glasses/hud/health/prescription,

	)

/datum/gear/eyewear/glasses/prescription/large
	display_name = "prescription glasses, large"
	path = /obj/item/clothing/glasses/regular/circle

/datum/gear/eyewear/glasses/prescription/jamjar
	display_name = "prescription glasses, jamjar"
	path = /obj/item/clothing/glasses/regular/jamjar

/datum/gear/eyewear/glasses/prescription/hipster_glasses
	display_name = "prescription glasses, hipster"
	path = /obj/item/clothing/glasses/regular/hipster


//Misc
/datum/gear/eyewear/eyepatch
	display_name = "eyepatch"
	path = /obj/item/clothing/glasses/eyepatch

/datum/gear/eyewear/monocle
	display_name = "monocle"
	path = /obj/item/clothing/glasses/monocle

/datum/gear/eyewear/blindfold
	display_name = "blindfold"
	path = /obj/item/clothing/glasses/blindfold

/datum/gear/eyewear/trickblindfold
	display_name = "trick blindfold"
	description = "A blindfold you can still see through."
	path = /obj/item/clothing/glasses/trickblindfold
