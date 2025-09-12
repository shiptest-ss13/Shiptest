//Languages - not worth their own file

// Kalixcian Common
/datum/quirk/lang_kalixcian
	name = "(Language) Kalixcian Common"
	desc = "You're fluent in Kalixcian Common."
	value = 0
	gain_text = span_notice("You know Kalixcian Common.")
	lose_text = span_danger("You forget Kalixcian Common.")
	detectable = FALSE

/datum/quirk/lang_kalixcian/add()
	var/mob/living/carbon/human/knower = quirk_holder
	knower.grant_language(/datum/language/kalixcian_common, source = LANGUAGE_MIND)

/datum/quirk/lang_kalixcian/remove()
	if(quirk_holder)
		var/mob/living/carbon/human/knower = quirk_holder
		knower.remove_language(/datum/language/kalixcian_common, source = LANGUAGE_MIND)

// Teceti Unified Standard
/datum/quirk/lang_tuc
	name = "(Language) Teceti Unified Standard"
	desc = "You're fluent in Teceti Unified Standard."
	value = 0
	gain_text = span_notice("You know Teceti Unified.")
	lose_text = span_danger("You forget Teceti Unified.")
	detectable = FALSE

/datum/quirk/lang_tuc/add()
	var/mob/living/carbon/human/knower = quirk_holder
	knower.grant_language(/datum/language/teceti_unified, source = LANGUAGE_MIND)

/datum/quirk/lang_tuc/remove()
	if(quirk_holder)
		var/mob/living/carbon/human/knower = quirk_holder
		knower.remove_language(/datum/language/teceti_unified, source = LANGUAGE_MIND)

// Solarian International
/datum/quirk/lang_solarian_international
	name = "(Language) Solarian International"
	desc = "You're fluent in Solarian International."
	value = 0
	gain_text = span_notice("You know Solarian International.")
	lose_text = span_danger("You forget Solarian International.")
	detectable = FALSE

/datum/quirk/lang_solarian_international/add()
	var/mob/living/carbon/human/knower = quirk_holder
	knower.grant_language(/datum/language/solarian_international, source = LANGUAGE_MIND)

/datum/quirk/lang_solarian_international/remove()
	if(quirk_holder)
		var/mob/living/carbon/human/knower = quirk_holder
		knower.remove_language(/datum/language/solarian_international, source = LANGUAGE_MIND)

// Moth Pidgin
/datum/quirk/lang_moth
	name = "(Language) Moth Pidgin"
	desc = "You're fluent in Moth Pidgin."
	gain_text = span_notice("You know Moth Pidgin.")
	lose_text = span_danger("You forget Moth Pidgin.")
	detectable = FALSE

/datum/quirk/lang_moth/add()
	var/mob/living/carbon/human/knower = quirk_holder
	knower.grant_language(/datum/language/moffic, source = LANGUAGE_MIND)

/datum/quirk/lang_moth/remove()
	if(quirk_holder)
		var/mob/living/carbon/human/knower = quirk_holder
		knower.remove_language(/datum/language/moffic, source = LANGUAGE_MIND)

// Sign Language
/datum/quirk/signer
	name = "Signer"
	desc = "You're fluent in Universal Sign Language."
	value = 0
	gain_text = span_notice("You know Universal Sign Language.")
	lose_text = span_danger("You forget Universal Sign Language.")
	detectable = FALSE

/datum/quirk/signer/add()
	var/mob/living/carbon/human/knower = quirk_holder
	knower.grant_language(/datum/language/sign_language, source = LANGUAGE_MIND)

/datum/quirk/signer/remove()
	if(quirk_holder)
		var/mob/living/carbon/human/knower = quirk_holder
		knower.remove_language(/datum/language/sign_language, source = LANGUAGE_MIND)
