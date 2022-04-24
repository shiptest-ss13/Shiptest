/datum/keybinding/movement
	category = CATEGORY_MOVEMENT
	weight = WEIGHT_HIGHEST

/datum/keybinding/movement/north
	hotkey_keys = list("W", "North")
	name = "North"
	full_name = "Move North"
	description = "Moves your character north"
	keybind_signal = COMSIG_KB_MOVEMENT_NORTH_DOWN

/datum/keybinding/movement/south
	hotkey_keys = list("S", "South")
	name = "South"
	full_name = "Move South"
	description = "Moves your character south"
	keybind_signal = COMSIG_KB_MOVEMENT_SOUTH_DOWN

/datum/keybinding/movement/west
	hotkey_keys = list("A", "West")
	name = "West"
	full_name = "Move West"
	description = "Moves your character left"
	keybind_signal = COMSIG_KB_MOVEMENT_WEST_DOWN

/datum/keybinding/movement/east
	hotkey_keys = list("D", "East")
	name = "East"
	full_name = "Move East"
	description = "Moves your character east"
	keybind_signal = COMSIG_KB_MOVEMENT_EAST_DOWN

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
