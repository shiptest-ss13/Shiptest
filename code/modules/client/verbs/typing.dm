#define IC_VERBS list("say", "me", "whisper")

/client/var/commandbar_thinking = FALSE
/client/var/commandbar_typing = FALSE

/client/proc/initialize_commandbar_spy()
	src << output('html/typing_indicator.html', "commandbar_spy")

/client/proc/handle_commandbar_typing(href_list)
	if (length(href_list["verb"]) < 1 || !(lowertext(href_list["verb"]) in IC_VERBS) || text2num(href_list["argument_length"]) < 1)
		if (commandbar_typing)
			commandbar_typing = FALSE
			stop_typing()
		return

	if (!commandbar_typing)
		commandbar_typing = TRUE
		start_typing()

/client/proc/start_typing()
	mob.set_typing_indicator(TRUE)

/client/proc/stop_typing()
	if(isnull(mob))
		return FALSE
	mob.set_typing_indicator(FALSE)

#undef IC_VERBS
