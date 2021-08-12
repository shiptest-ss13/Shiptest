/datum/keybinding/client/communication
	category = CATEGORY_COMMUNICATION

/datum/keybinding/client/communication/say
	hotkey_keys = list("CtrlT")
	name = "Say"
	full_name = "IC Say"
	keybind_signal = COMSIG_KB_CLIENT_SAY_DOWN

/datum/keybinding/client/communication/say_indicator
	hotkey_keys = list("T")
	name = "Say_indicator"
	full_name = "IC Say with Indicator"
	keybind_signal = COMSIG_KB_CLIENT_SAY_INDICATOR_DOWN

/datum/keybinding/client/communication/say_indicator/down(client/user)
	. = ..()
	user.mob.say_with_indicator()
	return TRUE

/datum/keybinding/client/communication/ooc
	hotkey_keys = list("O")
	name = "OOC"
	full_name = "Out Of Character Say (OOC)"
	keybind_signal = COMSIG_KB_CLIENT_OOC_DOWN

/datum/keybinding/client/communication/looc
	hotkey_keys = list("L")
	name = "LOOC"
	full_name = "Local Out Of Character Say (LOOC)"
	keybind_signal = COMSIG_KB_CLIENT_LOOC_DOWN

/datum/keybinding/client/communication/me
	hotkey_keys = list("CtrlM")
	name = "Me"
	full_name = "Custom Emote (/Me)"
	keybind_signal = COMSIG_KB_CLIENT_ME_DOWN

/datum/keybinding/client/communication/me_indicator
	hotkey_keys = list("M")
	name = "Me_indicator"
	full_name = "Custom Emote (/Me) with Indicator"
	keybind_signal = COMSIG_KB_CLIENT_ME_INDICATOR_DOWN

/datum/keybinding/client/communication/me_indicator/down(client/user)
	. = ..()
	user.mob.me_with_indicator()
	return TRUE
