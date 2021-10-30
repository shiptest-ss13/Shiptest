/*
Assistant
*/
/datum/job/assistant
	title = "Assistant"
	faction = "Station"
	total_positions = 5
	spawn_positions = 5
	department_head = list("Head of Personnel")
	supervisors = "absolutely everyone"
	selection_color = "#dddddd"
	access = list()			//See /datum/job/assistant/get_access()
	minimal_access = list()	//See /datum/job/assistant/get_access()
	outfit = /datum/outfit/job/assistant
	antag_rep = 7
	paycheck = PAYCHECK_ASSISTANT // Get a job. Job reassignment changes your paycheck now. Get over it.
	paycheck_department = ACCOUNT_CIV
	display_order = JOB_DISPLAY_ORDER_ASSISTANT
	wiki_page = "Assistant" //WS Edit - Wikilinks/Warning

/datum/job/assistant/get_access()
	if(CONFIG_GET(flag/assistants_have_maint_access) || !CONFIG_GET(flag/jobs_have_minimal_access)) //Config has assistant maint access set
		. = ..()
		. |= list(ACCESS_MAINT_TUNNELS)
	else
		return ..()

/datum/outfit/job/assistant
	name = "Assistant"
	jobtype = /datum/job/assistant
	r_pocket = /obj/item/radio

/datum/outfit/job/assistant/pre_equip(mob/living/carbon/human/H)
	..()
	if (CONFIG_GET(flag/grey_assistants))
		switch(H.jumpsuit_style)
			if(PREF_SUIT)
				uniform = initial(uniform)
			if(PREF_ALTSUIT)
				uniform = /obj/item/clothing/under/misc/assistantformal
			if(PREF_SKIRT)
				uniform = /obj/item/clothing/under/color/jumpskirt/grey
			else
				uniform = /obj/item/clothing/under/color/grey
	else
		switch(H.jumpsuit_style)
			if(PREF_SUIT)
				uniform = initial(uniform)
			if(PREF_ALTSUIT)
				uniform = /obj/item/clothing/under/misc/assistantformal
			if(PREF_SKIRT)
				uniform = /obj/item/clothing/under/utility/skirt
			else
				uniform = /obj/item/clothing/under/utility

/datum/outfit/job/assistant/entertainer
	name = "Assistant (Entertainer)"
	r_hand = /obj/item/bikehorn //comedy

/datum/outfit/job/assistant/engineeringspecialist
	name = "Assistant (Engineering Specialist)"
	accessory = /obj/item/clothing/accessory/armband/engine

/datum/outfit/job/assistant/medicalspecialist
	name = "Assistant (Medical Specialist)"
	uniform = /obj/item/clothing/under/color/white
	accessory = /obj/item/clothing/accessory/armband/med

/datum/outfit/job/assistant/sciencespecialist
	name = "Assistant (Science Specialist)"
	uniform = /obj/item/clothing/under/color/white
	accessory = /obj/item/clothing/accessory/armband/science

/datum/outfit/job/assistant/engineeringspecialist
	name = "Assistant (Deckhand)"
	accessory = /obj/item/clothing/accessory/armband/cargo

/datum/outfit/job/assistant/solgov
	name = "Sailor (SolGov)"

	uniform = /obj/item/clothing/under/solgov
	shoes = /obj/item/clothing/shoes/combat
	head = /obj/item/clothing/head/beret/solgov/plain

/datum/outfit/job/assistant/pirate
	name = "Assistant (Pirate)"

	uniform = /obj/item/clothing/under/costume/sailor
	shoes = /obj/item/clothing/shoes/jackboots
