/mob/living/silicon/examine(mob/user) //Displays a silicon's laws to ghosts
	. = ..()
	if(laws && isobserver(user))
		. += "<b>[src] has the following laws:</b>"
		for(var/law in laws.get_law_list(include_zeroth = TRUE))
			. += law
	if(client)
		var/line
		if(length(client.prefs.features["silicon_flavor_text"]))
			var/message = client.prefs.features["silicon_flavor_text"]
			if(length_char(message) <= 40)
				line = "<span class='notice'>[message]</span>"
			else
				line = "<span class='notice'>[copytext_char(message, 1, 37)]... <a href='?src=[REF(src)];lookup_info=silicon_flavor_text'>More...</a></span>"
		line += " <span class='notice'><a href='?src=[REF(src)];lookup_info=ooc_prefs'>\[OOC\]</a></span>"
		. += line
