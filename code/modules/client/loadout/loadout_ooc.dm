/datum/gear/ooc
	subtype_path = /datum/gear/ooc
	sort_category = "OOC"

/datum/gear/ooc/char_slot
	display_name = "extra character slot"
	description = "An extra charslot. Pretty self-explanatory."
	cost = 7500

/datum/gear/ooc/char_slot/purchase(var/client/C)
	C?.prefs?.max_save_slots += 1

/datum/gear/ooc/custom_color
	display_name = "custom ooc color"
	sort_category = "OOC"
	description = "If you can buy this, you deserve it."
	cost = 25000

/datum/gear/ooc/custom_color/purchase(var/client/C)
	C?.prefs?.custom_ooc = TRUE
