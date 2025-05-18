/datum/quirk/csl
	name = "Common Second Language"
	desc = "For some reason or another, you still haven't learned all the intricacies of Galactic Common."
	value = -1
	gain_text = span_danger("You still haven't cracked Galactic Common")
	lose_text = span_notice("Oh! That's what that word means.")
	detectable = FALSE

/datum/quirk/csl/add()
	quirk_holder.remove_language(/datum/language/galactic_common, UNDERSTOOD_LANGUAGE, LANGUAGE_ATOM)
	//make this a choosable thing when someone finishes prefs (literally never) ((redeem this comment for an erika token if you finish prefs))
	quirk_holder.grant_partial_language(/datum/language/galactic_common, 70, type)

/datum/quirk/csl/remove()
	if(QDELING(quirk_holder))
		return

	quirk_holder.remove_partial_language(/datum/language/galactic_common, type)
	quirk_holder.grant_language(/datum/language/galactic_common, UNDERSTOOD_LANGUAGE, LANGUAGE_ATOM)
