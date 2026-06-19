/datum/language/sign_language
	name = "Universal Sign Language"
	desc = "The most commonly used sign language in the galaxy."
	speech_verb = "signs"
	ask_verb = "signs"
	exclaim_verb = "signs"
	yell_verb = "emphatically signs"
	whisper_verb = "subtly signs"
	sing_verb = "rythmically signs"
	key = "u"
	flags = TONGUELESS_SPEECH | LANGUAGE_HIDE_ICON_IF_UNDERSTOOD | ROUNDSTART_LANGUAGE | SIGNED_LANGUAGE | NO_HISS
	default_priority = 99
	use_tone_indicators = TRUE
	bubble_override = "signlang"
