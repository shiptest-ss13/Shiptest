/obj/item/survey_handheld
	name = "Survey Handheld"
	desc = "A small tool designed for quick and inefficient data collection about your local star sector."
	icon = 'icons/obj/item/survey_handheld.dmi'
	icon_state = "survey"
	var/static/list/z_active = list()
	var/static/list/z_history = list()
	var/active = FALSE
	var/survey_value = 300
	var/survey_delay = 4 SECONDS
	w_class = WEIGHT_CLASS_BULKY


/obj/item/survey_handheld/advanced
	name = "Advanced Survey Handheld"
	desc = "An improved version of its predecessor this tool collects large amounts of data."
	icon_state = "survey-adv"
	survey_value = 450
	survey_delay = 3 SECONDS

/obj/item/survey_handheld/elite
	name = "Experimental Survey Handheld"
	desc = "An improvement on even the Advanced version; this handheld was designed to be extremely fast in collecting data."
	icon_state = "survey-elite"
	survey_value = 650
	survey_delay = 2 SECONDS

/datum/design/survey_handheld
	name = "Survey Handheld"
	id = "survey-handheld"
	build_type = AUTOLATHE
	build_path = /obj/item/survey_handheld
	materials = list(
		/datum/material/iron = 2000,
		/datum/material/glass = 1000,
	)
	category = list("initial", "Tools")

/datum/design/survey_handheld_advanced
	name = "Advanced Survey Handheld"
	id = "survey-handheld-advanced"
	build_type = PROTOLATHE
	build_path = /obj/item/survey_handheld/advanced
	materials = list(
		/datum/material/iron = 3000,
		/datum/material/glass = 2000,
		/datum/material/gold = 2000,
	)
	category = list("Tool Designs")

/datum/design/survey_handheld_elite
	name = "Elite Survey Handheld"
	id = "survey-handheld-elite"
	build_type = PROTOLATHE
	build_path = /obj/item/survey_handheld/elite
	materials = list(
		/datum/material/iron = 5000,
		/datum/material/silver = 5000,
		/datum/material/gold = 3000,
		/datum/material/uranium = 3000,
		/datum/material/diamond = 2000,
	)
	category = list("Tool Designs")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE


/datum/design/survey_handheld_exp
	name = "Experimental Survey Handheld"
	id = "survey-handheld-exp"
	build_type = PROTOLATHE
	build_path = /obj/item/survey_handheld/elite
	materials = list(
		/datum/material/iron = 5000,
		/datum/material/silver = 5000,
		/datum/material/gold = 3000,
		/datum/material/uranium = 3000,
		/datum/material/diamond = 3000,
		/datum/material/bluespace = 3000,
	)
	category = list("Tool Designs")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/obj/structure/anomaly
	name = "Defaultic Bind"
	desc = "The truly unexpected anomaly. Let a coder know if you see this!"
	max_integrity = 300
