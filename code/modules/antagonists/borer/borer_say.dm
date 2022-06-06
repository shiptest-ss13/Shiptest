/mob/living/proc/borer_talk(message, shown_name = real_name)
	src.log_talk(message, LOG_SAY)
	message = trim(message)
	if(!message)
		return

	var/message_a = say_quote(message)
	var/rendered = "<span class='borer'>Cortical Link: [shown_name] [message_a]"
	for(var/mob/S in GLOB.player_list)
		if(!S.stat && S.borercheck())
			to_chat(S, rendered)
		if(S in GLOB.dead_mob_list)
			var/link = FOLLOW_LINK(S, src)
			to_chat(S, "[link] [rendered]")

/mob/living/simple_animal/borer/borercheck()
	return TRUE
