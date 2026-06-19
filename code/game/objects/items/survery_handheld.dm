/obj/item/survey_handheld
	name = "Survey Handheld"
	desc = "A small tool designed for collecting and correlating information on planetary conditions."
	icon = 'icons/obj/item/survey_handheld.dmi'
	base_icon_state = "survey"
	icon_state = "survey"
	//all of these vars are assigned by the mission that creates us.
	///how many scans does this handheld want?
	var/scans_required
	///how many scans does this handheld have
	var/scan_tally = 0
	///what the target of our scanning is.
	var/atom/scan_target

/obj/item/survey_handheld/examine(mob/user)
	. = ..()
	if(scans_required)
		. += span_notice("The scanner reports [scan_tally] of [scans_required] scans have been completed.")

/obj/item/survey_handheld/pre_attack(atom/A, mob/living/user, params)
	. = ..()
	if(istype(A, /obj/effect/anomaly))
		attack_obj(A, user)

/obj/item/survey_handheld/attack_obj(obj/O, mob/living/user)
	. = ..()
	if(istype(O, scan_target) && scan_tally < scans_required)
		if(O?:mission_scanned == TRUE)
			to_chat(user, span_notice("[O] has already been scanned"))
			playsound(src, 'sound/machines/buzz-sigh.ogg', 20)
			return FALSE
		user.visible_message(span_notice("[user] begins scanning the [O]."), span_notice("You begin scanning [O]."), span_notice("Analytic rustles quickly start and stop"))
		if(do_after(user, 3 SECONDS, O, show_progress = TRUE))
			if(increment_scan())
				to_chat(user, span_notice("You add [O] to the scanner's databank"))
				flick("[base_icon_state]-print", src)
				playsound(src, 'sound/machines/whirr_beep.ogg', 20)
				O?:mission_scanned = TRUE
	if(istype(O, /obj/structure/geyser))
		var/obj/structure/geyser/scan_target = O
		to_chat(user, "[scan_target] is producing [scan_target.reagent_id.name]!")
		return
	if(istype(O, /obj/effect/anomaly))
		var/obj/effect/anomaly/scan_target = O
		to_chat(user, span_notice("[src]'s primary field is fluctuating along frequency [format_frequency(scan_target.core.frequency)], code [scan_target.core.code]. An unstable wavelength is at code [scan_target.core.code_b]!"))
		scan_target.drops_core = FALSE
		scan_target.visible_message(span_warning("Scanning [src] has solidified it's presence in the area! It can no longer be stabilized into a core!"))
		return
	return

/obj/item/survey_handheld/proc/increment_scan()
	scan_tally += 1
	if(scan_tally == scans_required)
		say("Sufficient samples gathered. Scanner ready for turn in!")
	return TRUE

/obj/item/survey_handheld/advanced
	name = "Advanced Survey Handheld"
	desc = "An advanced survey scanner specialized in collecting large amounts of information on unique environments."
	icon_state = "survey-adv"
	base_icon_state = "survey-adv"

/obj/item/survey_handheld/elite
	name = "Experimental Survey Handheld"
	desc = "An experimental survey scanner utilizing deep radar techniques to quickly ascertain information on its locale."
	icon_state = "survey-elite"
	base_icon_state = "survey-elite"
