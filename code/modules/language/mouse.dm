/datum/language/mouse
	name = "Mouse"
	desc = "A rather simple language spoken and understood by mice. It has been developed and shared by genetically advanced mice."
	speech_verb = "squeaks"
	ask_verb = "squeaks"
	exclaim_verb = "squeaks"
	key = "l"
	flags = NO_STUTTER | LANGUAGE_HIDE_ICON_IF_NOT_UNDERSTOOD | LANGUAGE_HIDE_ICON_IF_UNDERSTOOD

/datum/language/mouse/scramble_sentence(input, list/mutual_languages)
	. = ..()
	. = "Squeak"
	. += (copytext(input, length(input)) == "?") ? "?" : "!"
