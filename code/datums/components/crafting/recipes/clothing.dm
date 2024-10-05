// Please separate them based on categories. Made this easier for all of us, god damn it! #Lianvee

// Durathread
/datum/crafting_recipe/durathread_vest
	name = "Durathread Vest"
	result = /obj/item/clothing/suit/armor/vest/durathread
	reqs = list(
		/obj/item/stack/sheet/durathread = 5,
		/obj/item/stack/sheet/leather = 4
	)
	time = 50
	category = CAT_CLOTHING

/datum/crafting_recipe/durathread_helmet
	name = "Durathread Helmet"
	result = /obj/item/clothing/head/helmet/durathread
	reqs = list(
		/obj/item/stack/sheet/durathread = 4,
		/obj/item/stack/sheet/leather = 5
	)
	time = 40
	category = CAT_CLOTHING

/datum/crafting_recipe/durathread_jumpsuit
	name = "Durathread Jumpsuit"
	result = /obj/item/clothing/under/misc/durathread
	reqs = list(/obj/item/stack/sheet/durathread = 4)
	time = 40
	category = CAT_CLOTHING

/datum/crafting_recipe/durathread_beret
	name = "Durathread Beret"
	result = /obj/item/clothing/head/beret/durathread
	reqs = list(/obj/item/stack/sheet/durathread = 2)
	time = 40
	category = CAT_CLOTHING

/datum/crafting_recipe/durathread_beanie
	name = "Durathread Beanie"
	result = /obj/item/clothing/head/beanie/durathread
	reqs = list(/obj/item/stack/sheet/durathread = 2)
	time = 40
	category = CAT_CLOTHING

/datum/crafting_recipe/durathread_bandana
	name = "Durathread Bandana"
	result = /obj/item/clothing/mask/bandana/durathread
	reqs = list(/obj/item/stack/sheet/durathread = 1)
	time = 25
	category = CAT_CLOTHING

// Belts
/datum/crafting_recipe/fannypack
	name = "Fannypack"
	result = /obj/item/storage/belt/fannypack
	reqs = list(
		/obj/item/stack/sheet/cotton/cloth = 2,
		/obj/item/stack/sheet/leather = 1
	)
	time = 20
	category = CAT_CLOTHING

// Eyewear
/datum/crafting_recipe/hudsunsec
	name = "Security HUDsunglasses"
	result = /obj/item/clothing/glasses/hud/security/sunglasses
	time = 20
	tools = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	reqs = list(
		/obj/item/clothing/glasses/hud/security = 1,
		/obj/item/clothing/glasses/sunglasses = 1,
		/obj/item/stack/cable_coil = 5
	)
	category = CAT_CLOTHING

/datum/crafting_recipe/hudsunmed
	name = "Medical HUDsunglasses"
	result = /obj/item/clothing/glasses/hud/health/sunglasses
	time = 20
	tools = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	reqs = list(
		/obj/item/clothing/glasses/hud/health = 1,
		/obj/item/clothing/glasses/sunglasses = 1,
		/obj/item/stack/cable_coil = 5
	)
	category = CAT_CLOTHING

/datum/crafting_recipe/hudsundiag
	name = "Diagnostic HUDsunglasses"
	result = /obj/item/clothing/glasses/hud/diagnostic/sunglasses
	time = 20
	tools = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	reqs = list(
		/obj/item/clothing/glasses/hud/diagnostic = 1,
		/obj/item/clothing/glasses/sunglasses = 1,
		/obj/item/stack/cable_coil = 5
	)
	category = CAT_CLOTHING

/datum/crafting_recipe/sciencesunglasses
	name = "Science Sunglasses"
	result = /obj/item/clothing/glasses/sunglasses/chemical
	time = 20
	tools = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	reqs = list(
		/obj/item/clothing/glasses/science = 1,
		/obj/item/clothing/glasses/sunglasses = 1,
		/obj/item/stack/cable_coil = 5
	)
	category = CAT_CLOTHING

/datum/crafting_recipe/medhudglasses // The prescription HUD glasses. This long to have them... #Lianvee
	name = "MedicalHUD Prescription Glasses"
	result = /obj/item/clothing/glasses/hud/health/prescription
	time = 20
	tools = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	reqs = list(
		/obj/item/clothing/glasses/hud/health = 1,
		/obj/item/clothing/glasses/regular = 1,
		/obj/item/stack/cable_coil = 5
	)
	category = CAT_CLOTHING

/datum/crafting_recipe/sechudglasses
	name = "SecurityHUD Prescription Glasses"
	result = /obj/item/clothing/glasses/hud/security/prescription
	time = 20
	tools = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	reqs = list(
		/obj/item/clothing/glasses/hud/security = 1,
		/obj/item/clothing/glasses/regular = 1,
		/obj/item/stack/cable_coil = 5
	)
	category = CAT_CLOTHING

/datum/crafting_recipe/mesonglasses
	name = "Meson Prescription Glasses"
	result = /obj/item/clothing/glasses/meson/prescription
	time = 20
	tools = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	reqs = list(
		/obj/item/clothing/glasses/meson = 1,
		/obj/item/clothing/glasses/regular = 1,
		/obj/item/stack/cable_coil = 5
	)
	category = CAT_CLOTHING

/datum/crafting_recipe/scienceglasses
	name = "Science Prescription Glasses"
	result = /obj/item/clothing/glasses/science/prescription
	time = 20
	tools = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	reqs = list(
		/obj/item/clothing/glasses/science = 1,
		/obj/item/clothing/glasses/regular = 1,
		/obj/item/stack/cable_coil = 5
	)
	category = CAT_CLOTHING

// Misc.
/datum/crafting_recipe/ghostsheet
	name = "Ghost Sheet"
	result = /obj/item/clothing/suit/ghost_sheet
	time = 5
	tools = list(TOOL_WIRECUTTER)
	reqs = list(/obj/item/bedsheet = 1)
	category = CAT_CLOTHING

/datum/crafting_recipe/cowboyboots
	name = "Cowboy Boots"
	result = /obj/item/clothing/shoes/cowboy
	reqs = list(/obj/item/stack/sheet/leather = 2)
	time = 45
	category = CAT_CLOTHING

/datum/crafting_recipe/gripperoffbrand
	name = "Improvised Gripper Gloves"
	reqs = list(
			/obj/item/clothing/gloves/fingerless = 1,
			/obj/item/stack/tape = 1)
	result = /obj/item/clothing/gloves/tackler/offbrand
	category = CAT_CLOTHING

/datum/crafting_recipe/bonearmlet
	name = "Bone Armlet"
	result = /obj/item/clothing/accessory/bonearmlet
	time = 20
	reqs = list(/obj/item/stack/sheet/bone = 2,
				/obj/item/stack/sheet/sinew = 1)
	category = CAT_CLOTHING

/datum/crafting_recipe/fangnecklace
	name = "Wolf Fang Necklace"
	result = /obj/item/clothing/neck/fangnecklace
	time = 20
	reqs = list(/obj/item/stack/sheet/sinew = 2,
				/obj/item/mob_trophy/fang = 1)
	category = CAT_CLOTHING

/datum/crafting_recipe/goliathcloak
	name = "Goliath Cloak"
	result = /obj/item/clothing/suit/hooded/cloak/goliath
	time = 50
	reqs = list(/obj/item/stack/sheet/leather = 2,
				/obj/item/stack/sheet/sinew = 2,
				/obj/item/stack/sheet/animalhide/goliath_hide = 2) //it takes 4 goliaths to make 1 cloak if the plates are skinned
	category = CAT_CLOTHING

/datum/crafting_recipe/hunterbelt
	name = "Hunters Belt"
	result = /obj/item/storage/belt/mining/primitive
	time = 20
	reqs = list(/obj/item/stack/sheet/sinew = 2,
				/obj/item/stack/sheet/animalhide/goliath_hide = 2)
	category = CAT_CLOTHING
