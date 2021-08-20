/obj/item/survey_handheld
	name = "Survey Handheld"
	desc = "A small tool designed for quick and inefficient data collection about your local star sector."
	icon = 'icons/obj/item/survey_handheld.dmi'
	icon_state = "survey"
	var/static/list/z_active = list()
	var/static/list/z_history = list()
	var/active = FALSE
	var/survey_value = 50
	var/survey_delay = 2 SECONDS

/obj/item/survey_handheld/advanced
	name = "Advanced Survey Handheld"
	desc = "An improved version of its predecessor this tool collects large amounts of data."
	icon_state = "survey-adv"
	survey_value = 100

/obj/item/survey_handheld/elite
	name = "Experimental Survey Handheld"
	desc = "An improvement on even the Advanced version; this handheld was designed to be extremely fast in collecting data."
	icon_state = "survey-elite"
	survey_value = 100
	survey_delay = 1 SECONDS

/obj/item/survey_handheld/attack_self(mob/user)
	if(active)
		return

	if(z_active["[z]"])
		visible_message("Warning: There is already an active survey in progress.")
		return

	active = TRUE
	z_active["[z]"] = TRUE

	while(user.get_active_held_item() == src)
		to_chat(user, "<span class='notice'>You begin to scan your surroundings with [src].</span>")

		var/penalty = 1
		if(z_history["[z]"])
			penalty += z_history["[z]"] * 0.05
		else
			z_history["[z]"] = 0

		if(penalty > 2)
			visible_message("Warning: there is very little data left to analyze in this sector.")

		if(!do_after_mob(user, list(src), survey_delay * penalty))
			flick(icon_state + "-corrupted", src)
			playsound(src, 'sound/machines/buzz-sigh.ogg')
			visible_message("Warning: results corrupted. Please try again.")
			break

		z_history["[z]"]++

		flick(icon_state + "print", src)
		playsound(src, 'sound/machines/chime.ogg')
		visible_message("Data recorded and enscribed to research packet.")



		var/obj/item/result = new /obj/item/research_notes(user.loc, survey_value / penalty, pick(list("astronomy", "physics", "planetary", "space")))
		if(!user.put_in_hands(result) && istype(user.get_inactive_held_item(), /obj/item/research_notes))
			var/obj/item/research_notes/research = user.get_inactive_held_item()
			research.merge(result)
			continue

		var/obj/item/research_notes/notes = locate() in get_turf(user)
		if(notes)
			notes.merge(result)

	active = FALSE
	z_active["[z]"] = FALSE

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
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

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
