/proc/toggle_deadchat(toggle = null)
	if(toggle == null)
		GLOB.deadchat_allowed = !GLOB.deadchat_allowed
		return
	if(toggle != GLOB.deadchat_allowed)
		GLOB.deadchat_allowed = toggle
