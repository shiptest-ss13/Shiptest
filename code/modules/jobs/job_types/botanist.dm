/datum/job/hydro
	name = "Botanist"
	total_positions = 3
	spawn_positions = 2
	wiki_page = "Guide_to_Botany" //WS Edit - Wikilinks/Warning

	outfit = /datum/outfit/job/botanist

	access = list(ACCESS_HYDROPONICS, ACCESS_BAR, ACCESS_KITCHEN, ACCESS_MORGUE, ACCESS_MINERAL_STOREROOM)
	minimal_access = list(ACCESS_HYDROPONICS, ACCESS_MORGUE, ACCESS_MINERAL_STOREROOM)
	display_order = JOB_DISPLAY_ORDER_BOTANIST

/datum/outfit/job/botanist
	name = "Botanist"
	job_icon = "botanist"
	jobtype = /datum/job/hydro

	belt = /obj/item/pda/botanist
	ears = /obj/item/radio/headset/headset_srv
	uniform = /obj/item/clothing/under/rank/civilian/hydroponics
	alt_uniform = /obj/item/clothing/under/color/green //WS Edit - Alt Uniforms
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/hydro //WS Edit - Alt Uniforms
	suit = /obj/item/clothing/suit/apron
	alt_suit = /obj/item/clothing/suit/apron/overalls
	gloves  =/obj/item/clothing/gloves/botanic_leather
	suit_store = /obj/item/plant_analyzer

	backpack = /obj/item/storage/backpack/botany
	satchel = /obj/item/storage/backpack/satchel/hyd
	courierbag = /obj/item/storage/backpack/messenger/hyd

//shiptest!!!!!!!!!!
/datum/outfit/job/botanist/syndicate/nsv
	name = "Botanist-Chemist (NSV-M)"

	uniform = /obj/item/clothing/under/syndicate
	id = /obj/item/card/id/syndicate_command/crew_id
	shoes = /obj/item/clothing/shoes/jackboots
	glasses = /obj/item/clothing/glasses/science
	suit =  /obj/item/clothing/suit/toggle/labcoat/chemist
	suit_store = null


