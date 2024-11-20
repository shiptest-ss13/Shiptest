/datum/mood_event/drunk
	mood_change = 3
	description = span_nicegreen("Everything just feels better after a drink or two.")

/datum/mood_event/drunk/add_effects(param)
	// Display blush visual
	ADD_TRAIT(owner, TRAIT_BLUSHING, "[type]")
	owner.update_body()

/datum/mood_event/drunk/remove_effects()
	// Stop displaying blush visual
	REMOVE_TRAIT(owner, TRAIT_BLUSHING, "[type]")
	owner.update_body()

/datum/mood_event/quality_nice
	description = span_nicegreen("That drink wasn't bad at all.")
	mood_change = 2
	timeout = 7 MINUTES

/datum/mood_event/quality_good
	description = span_nicegreen("That drink was pretty good.")
	mood_change = 4
	timeout = 7 MINUTES

/datum/mood_event/quality_verygood
	description = span_nicegreen("That drink was great!")
	mood_change = 6
	timeout = 7 MINUTES

/datum/mood_event/quality_fantastic
	description = span_nicegreen("That drink was amazing!")
	mood_change = 8
	timeout = 7 MINUTES

/datum/mood_event/amazingtaste
	description = span_nicegreen("Amazing taste!")
	mood_change = 50
	timeout = 10 MINUTES
