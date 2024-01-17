/*
Assistant
*/
/datum/job/assistant
	name = "Assistant"
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
