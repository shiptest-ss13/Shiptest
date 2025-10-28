//////////////////////////////////////////////////////
////////////////////SUBTLE COMMAND////////////////////	(ported from citadel, needed for LOOC and flavour text)
//////////////////////////////////////////////////////
/mob
	var/flavor_text = "" //tired of fucking double checking this

/mob/proc/update_flavor_text()
	set name = "Update Flavor Text"
	set category = "IC"
	set src in usr

	if(usr != src)
		to_chat(usr, span_warning("You can't set someone else's flavour text!"))
	var/msg = input(usr, "A snippet of text shown when others examine you, describing what you may look like. This can also be used for OOC notes.", "Flavor Text", html_decode("flavor_text")) as message|null

	if(msg)
		msg = copytext(msg, 1, MAX_MESSAGE_LEN)
		msg = html_encode(msg)

		flavor_text = msg

/mob/proc/print_flavor_text()
	if(flavor_text && flavor_text != "")
		var/msg = replacetext(flavor_text, "\n", " ")
		if(length(msg) <= MAX_SHORTFLAVOR_LEN)
			return span_notice("[msg]")
		else
			return "[span_notice("[copytext(msg, 1, MAX_SHORTFLAVOR_LEN)]... <a href=\"byond://?src=[text_ref(src)];flavor_more=1\">More...")]</a>"

/mob/proc/get_top_level_mob()
	if(istype(src.loc,/mob)&&src.loc!=src)
		var/mob/M=src.loc
		return M.get_top_level_mob()
	return src

/proc/get_top_level_mob(mob/S)
	if(istype(S.loc,/mob)&&S.loc!=S)
		var/mob/M=S.loc
		return M.get_top_level_mob()
	return S


/*
SUBTLER
*/

/datum/emote/living/subtler
	key = "subtler"
	key_third_person = "subtler"
	message = null
	mob_type_blacklist_typecache = list(/mob/living/brain)


/datum/emote/living/subtler/proc/check_invalid(mob/user, input)
	if(stop_bypasser.Find(input, 1, 1))
		to_chat(user, span_danger("Invalid emote."))
		return TRUE
	return FALSE

/datum/emote/living/subtler/run_emote(mob/user, params, type_override = null)
	if(is_banned_from(user, "emote"))
		to_chat(user, "You cannot send subtle emotes (banned).")
		return FALSE
	else if(user.client && user.client.prefs.muted & MUTE_IC)
		to_chat(user, "You cannot send IC messages (muted).")
		return FALSE
	else if(!params)
		var/subtle_emote = sanitize(input(user, "Choose an emote to display.", "Subtler"))
		if(subtle_emote && !check_invalid(user, subtle_emote))
			var/type = input("Is this a visible or hearable emote?") as null|anything in list("Visible", "Hearable")
			switch(type)
				if("Visible")
					emote_type = EMOTE_VISIBLE
				if("Hearable")
					emote_type = EMOTE_AUDIBLE
				else
					alert("Unable to use this emote, must be either hearable or visible.")
					return
			message = subtle_emote
		else
			return FALSE
	else
		message = params
		if(type_override)
			emote_type = type_override
	. = TRUE
	if(!can_run_emote(user))
		return FALSE

	user.log_message(message, LOG_SUBTLER)
	message = "<b>[user]</b> " + "<i>[message]</i>"

	if(emote_type == EMOTE_AUDIBLE)
		user.audible_message(message = message, hearing_distance = 1)
	else
		user.visible_message(message = message, self_message = message, vision_distance = 1)

///////////////// VERB CODE
/mob/living/verb/subtler()
	set name = "Subtler"
	set category = "IC"
	if(GLOB.say_disabled)	//This is here to try to identify lag problems
		to_chat(usr, span_danger("Speech is currently admin-disabled."))
		return
	usr.emote("subtler")
