/datum/gear/eyewear
	subtype_path = /datum/gear/eyewear
	slot = ITEM_SLOT_EYES
	sort_category = "Eyewear"
	cost = 500

//Prescription glasses
/datum/gear/eyewear/glasses
	display_name = "glasses, prescription"
	path = /obj/item/clothing/glasses/regular

/datum/gear/eyewear/glasses/large
	display_name = "glasses, large prescription"
	path = /obj/item/clothing/glasses/regular/circle

/datum/gear/eyewear/glasses/jamjar
	display_name = "glasses, jamjar prescription"
	path = /obj/item/clothing/glasses/regular/jamjar

//Probably overpowerd but honestly idc
/datum/gear/eyewear/glasses/hud
	subtype_path = /datum/gear/eyewear/glasses/hud
	cost = 2000

/datum/gear/eyewear/glasses/hud/pmed
	display_name = "HUDglasses, prescription health"
	path = /obj/item/clothing/glasses/hud/health/prescription
	allowed_roles = list("Medical Doctor", "Chief Medical Officer")

/datum/gear/eyewear/glasses/hud/psec
	display_name = "HUDglasses, prescription security"
	path = /obj/item/clothing/glasses/hud/security/prescription
	allowed_roles = list("Security Officer", "Warden", "Head of Security")

/datum/gear/eyewear/glasses/hud/pmeson
	display_name = "HUDglasses, prescription meson"
	path = /obj/item/clothing/glasses/meson/prescription
	allowed_roles = list("Shaft Miner", "Station Engineer", "Atmospheric Technician", "Chief Engineer")

/datum/gear/eyewear/glasses/hud/psci
	display_name = "HUDglasses, prescription science"
	path = /obj/item/clothing/glasses/science/prescription
	allowed_roles = list("Chemist", "Scientist", "Research Director")

//Misc
/datum/gear/eyewear/eyepatch
	display_name = "eyepatch"
	path = /obj/item/clothing/glasses/eyepatch

/datum/gear/eyewear/monocle
	display_name = "monocle"
	path = /obj/item/clothing/glasses/monocle

/datum/gear/eyewear/cheapsuns
	display_name = "cheap sunglasses"
	path = /obj/item/clothing/glasses/cheapsuns

/datum/gear/eyewear/blindfold
	display_name = "blindfold"
	path = /obj/item/clothing/glasses/blindfold
	cost = 750

/datum/gear/eyewear/hipster_glasses
	display_name = "Hipster Glasses"
	path = /obj/item/clothing/glasses/regular/hipster
	cost = 1250
