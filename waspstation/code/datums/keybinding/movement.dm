/datum/keybinding/movement/move_upwards
	hotkey_keys = list("AltE")
	name = "Upwards"
	full_name = "Move Upwards"
	description = "Moves your character up"
	keybind_signal = COMSIG_KB_MOVEMENT_UPWARDS_DOWN

/datum/keybinding/movement/move_upwards/down(client/user)
	. = ..()
	if(.)
		return
	var/mob/M = user.mob
	for(var/obj/structure/ladder/ladder in range(1, M.loc))
		if(ladder.up)
			ladder.travel(TRUE, M, FALSE, ladder.up)
			return TRUE
	M.zMove(UP, TRUE)
	return TRUE

/datum/keybinding/movement/move_downwards
	hotkey_keys = list("AltQ")
	name = "Downwards"
	full_name = "Move Downwards"
	description = "Moves your character down"
	keybind_signal = COMSIG_KB_MOVEMENT_DOWNWARDS_DOWN

/datum/keybinding/movement/move_downwards/down(client/user)
	. = ..()
	if(.)
		return
	var/mob/M = user.mob
	for(var/obj/structure/ladder/ladder in range(1, M.loc))
		if(ladder.down)
			ladder.travel(FALSE, M, FALSE, ladder.down)
			return TRUE
	M.zMove(DOWN, TRUE)
	return TRUE
