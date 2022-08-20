/*
Assistant
*/
/datum/job/assistant
	name = "Assistant"
	total_positions = 5
	spawn_positions = 5
	access = list()			//See /datum/job/assistant/get_access()
	minimal_access = list()	//See /datum/job/assistant/get_access()
	outfit = /datum/outfit/job/assistant
	display_order = JOB_DISPLAY_ORDER_ASSISTANT
	wiki_page = "Assistant"

/datum/job/assistant/get_access()
	if(CONFIG_GET(flag/assistants_have_maint_access) || !CONFIG_GET(flag/jobs_have_minimal_access)) //Config has assistant maint access set
		. = ..()
		. |= list(ACCESS_MAINT_TUNNELS)
	else
		return ..()

/datum/outfit/job/assistant
	name = "Assistant"
	job_icon = "assistant"
	jobtype = /datum/job/assistant
	r_pocket = /obj/item/radio
	belt = /obj/item/pda

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

//Shiptest outfits

/datum/outfit/job/assistant/solgov
	name = "Sailor (SolGov)"

	uniform = /obj/item/clothing/under/solgov
	shoes = /obj/item/clothing/shoes/combat
	head = /obj/item/clothing/head/beret/solgov/plain

/datum/outfit/job/assistant/solgov/rebel
	name = "Sailor (Deserter)"

	uniform = /obj/item/clothing/under/syndicate/camo
	head = /obj/item/clothing/head/beret/solgov/terragov/plain

/datum/outfit/job/assistant/minutemen
	name = "Volunteer (Minutemen)"

	uniform = /obj/item/clothing/under/rank/security/officer/minutemen

/datum/outfit/job/assistant/inteq
	name = "IRMG Recruit (Inteq)"

	uniform = /obj/item/clothing/under/syndicate/inteq

/datum/outfit/job/assistant/intern
	name = "Assistant (Intern)"
	uniform = /obj/item/clothing/under/suit/black
	neck = /obj/item/clothing/neck/tie
	shoes = /obj/item/clothing/shoes/laceup
	r_pocket = /obj/item/pen/fountain

/datum/outfit/job/assistant/receptionist
	name = "Assistant (Receptionist)"
	uniform = /obj/item/clothing/under/suit/beige
	glasses = /obj/item/clothing/glasses/regular/hipster
	shoes = /obj/item/clothing/shoes/laceup
	r_pocket = /obj/item/pen/fourcolor
	l_pocket = /obj/item/clipboard

/datum/outfit/job/assistant/receptionist/pre_equip(mob/living/carbon/human/H)
	..()
	switch(H.jumpsuit_style)
		if(PREF_SUIT)
			uniform = initial(uniform)
		if(PREF_ALTSUIT)
			uniform = /obj/item/clothing/under/suit/blacktwopiece
		if(PREF_SKIRT)
			uniform = /obj/item/clothing/under/dress/skirt/plaid
		else
			uniform = /obj/item/clothing/under/suit/beige

/datum/outfit/job/assistant/pirate
	name = "Assistant (Pirate)"

	uniform = /obj/item/clothing/under/costume/sailor
	shoes = /obj/item/clothing/shoes/jackboots

/datum/outfit/job/assistant/corporate
	name = "Business Associate"

	uniform = /obj/item/clothing/under/suit/black
	shoes = /obj/item/clothing/shoes/laceup
	suit = /obj/item/clothing/suit/toggle/lawyer/black

/datum/outfit/job/assistant/syndicate
	name = "Junior Agent (Assistant)"

	id = /obj/item/card/id/syndicate_command/crew_id
	uniform = /obj/item/clothing/under/syndicate
	alt_uniform = null
	shoes = /obj/item/clothing/shoes/jackboots

/datum/outfit/job/assistant/syndicate/gorlex
	name = "Junior Agent (Gorlex Marauders)"

	uniform = /obj/item/clothing/under/syndicate/gorlex
	alt_uniform = /obj/item/clothing/under/syndicate

/datum/outfit/job/assistant/independent/crewmatefancy
	name = "Crewmate (Independent)"

	uniform = /obj/item/clothing/under/misc/assistantformal
	shoes = /obj/item/clothing/shoes/laceup
	gloves = /obj/item/clothing/gloves/color/white

/datum/outfit/job/assistant/ex_prisoner
	name = "Assistant (Ex-Prisoner)"

	glasses = /obj/item/clothing/glasses/sunglasses
	uniform = /obj/item/clothing/under/rank/prisoner
	shoes = /obj/item/clothing/shoes/sneakers/orange
	accessory = /obj/item/clothing/accessory/armband/deputy

/datum/outfit/job/assistant/waiter
	name = "Assistant (Waiter)"

	uniform = /obj/item/clothing/under/suit/waiter
	shoes = /obj/item/clothing/shoes/laceup
	ears = /obj/item/radio/headset/headset_srv
	gloves = /obj/item/clothing/gloves/color/white

/datum/outfit/job/assistant/artist
	name = "Assistant (Artist)"

	uniform = /obj/item/clothing/under/suit/burgundy
	suit = /obj/item/clothing/suit/toggle/suspenders
	head = /obj/item/clothing/head/beret/black
	shoes = /obj/item/clothing/shoes/laceup
	gloves = /obj/item/clothing/gloves/color/white
	accessory = /obj/item/clothing/neck/scarf/darkblue

/datum/outfit/job/assistant/waiter/syndicate
	name = "Assistant (Syndicate Waiter)"
	uniform = /obj/item/clothing/under/suit/waiter/syndicate

/datum/outfit/job/assistant/roumain
	name = "Shadow (Saint-Roumain Militia)"

	uniform = /obj/item/clothing/under/suit/roumain
	alt_uniform = null
	shoes = /obj/item/clothing/shoes/workboots/mining
	suit = /obj/item/clothing/suit/armor/roumain/shadow

	head = /obj/item/clothing/head/cowboy/sec/roumain/shadow
