/obj/effect/survey_point //sure effects shouldn't be attackable, sue me.
	name = "Survey Point"
	desc = "A location of particular survey value."




	var/research_value
	var/research_time


/obj/effect/survey_point(obj/item/W, mob/user, params)
	if(W.tool_behaviour == TOOL_ANALYZER && )
		if(active)
			return

		var/turf/user_turf = get_turf(user)

		active = TRUE
		while(user.get_active_held_item() == src)
			to_chat(user, "<span class='notice'>You begin to scan [src] with [W].</span>")

			if(!do_after_mob(user, list(src), survey_delay / penalty))
				flick(icon_state + "-corrupted", src)
				playsound(src, 'sound/machines/buzz-sigh.ogg', 20)
				src_turf.visible_message("<span class='warning'>Warning: results corrupted. Please try again.</span>")
				break

			flick(icon_state + "print", src)
			playsound(src, 'sound/machines/whirr_beep.ogg', 20)
			src_turf.visible_message("<span class='notice'>Data recorded and enscribed to research packet.</span>")

			var/obj/item/result = new /obj/item/research_notes(null, survey_value * penalty, pick(list("astronomy", "physics", "planets", "space")))

			var/obj/item/research_notes/notes = locate() in get_turf(user)
			if(notes)
				notes.merge(result)
			else if(!user.put_in_hands(result) && istype(user.get_inactive_held_item(), /obj/item/research_notes))
				var/obj/item/research_notes/research = user.get_inactive_held_item()
				research.merge(result)
				continue
