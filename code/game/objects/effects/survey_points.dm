/obj/effect/survey_point //sure effects shouldn't be attackable, sue me.
	name = "Survey Point"
	desc = "A location of particular survey value."
	icon = 'icons/effects/landmarks_static.dmi'
	icon_state = "x"
	var/research_value

/obj/effect/survey_point/Initialize()
	. = ..()
	research_value = rand(750, 1500)

/obj/effect/survey_point/examine(mob/user)
	. = ..()
	if(user.research_scanner)
		to_chat(user, "<span class='notice'>This survey point appears to be worth [research_value] research points")

/obj/effect/survey_point/attackby(obj/item/item, mob/user, params)
	if(ispath(/obj/item/attachment/survey_scanner))
		var/obj/item/attachment/survey_scanner/scangler = item
		if(scangler.active)
			return

		var/turf/user_turf = get_turf(user)



		if(!scangler.pack.powered)
			to_chat(user, "Insufficient power to scan [src]")
			return

		to_chat(user, "<span class='notice'>You begin to scan [src] with [scangler].</span>")
		scangler.active = TRUE

		if(do_after(user, scangler.survey_delay, TRUE))
			flick(icon_state + "-print", item)
			playsound(src, 'sound/machines/whirr_beep.ogg', 20)
			user_turf.visible_message("<span class='notice'>Data recorded and enscribed to research packet.</span>")
			scangler.active = FALSE
			scangler.pack.deductcharge(scangler.usecost)
			qdel(src)
		else
			flick(icon_state + "-corrupted", item)
			playsound(src, 'sound/machines/buzz-sigh.ogg', 20)
			user_turf.visible_message("<span class='warning'>Warning: Results corrupted. Attempt scan again.</span>")
			scangler.active = FALSE
			return

		var/obj/item/result = new /obj/item/research_notes(null, research_value, pick(list(
			"geographic analysis",
			"soil composition",
			"atmospheric deviation",
			"planetary survey",
			"background radiation levels",
			"watertable readings",
			"biohazard potential",
			"plasma density",
			"ore vein potential",
			"fauna protein analysis",
			"fern probablity index",
			"carcinization threshold"
		))) //I should just make this a proper list

		var/obj/item/research_notes/notes = locate() in get_turf(user)
		if(notes)
			notes.merge(result)
		else if(!user.put_in_hands(result) && istype(user.get_inactive_held_item(), /obj/item/research_notes))
			var/obj/item/research_notes/research = user.get_inactive_held_item()
			research.merge(result)
	return
