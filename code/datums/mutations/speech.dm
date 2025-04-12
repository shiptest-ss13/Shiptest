//These are all minor mutations that affect your speech somehow.
//Individual ones aren't commented since their functions should be evident at a glance

/datum/mutation/human/nervousness
	name = "Nervousness"
	desc = "Causes the holder to stutter."
	quality = MINOR_NEGATIVE
	text_gain_indication = span_danger("You feel nervous.")

/datum/mutation/human/nervousness/on_life()
	if(prob(10))
		owner.stuttering = max(10, owner.stuttering)


/datum/mutation/human/wacky
	name = "Wacky"
	desc = "You are not a clown. You are the entire circus."
	quality = MINOR_NEGATIVE
	text_gain_indication = span_sans("You feel an off sensation in your voicebox.")
	text_lose_indication = span_notice("The off sensation passes.")

/datum/mutation/human/wacky/on_acquiring(mob/living/carbon/human/owner)
	if(..())
		return
	RegisterSignal(owner, COMSIG_MOB_SAY, PROC_REF(handle_speech))

/datum/mutation/human/wacky/on_losing(mob/living/carbon/human/owner)
	if(..())
		return
	UnregisterSignal(owner, COMSIG_MOB_SAY)

/datum/mutation/human/wacky/proc/handle_speech(datum/source, list/speech_args)
	SIGNAL_HANDLER

	speech_args[SPEECH_SPANS] |= SPAN_SANS

/datum/mutation/human/mute
	name = "Mute"
	desc = "Completely inhibits the vocal section of the brain."
	quality = NEGATIVE
	text_gain_indication = span_danger("You feel unable to express yourself at all.")
	text_lose_indication = span_danger("You feel able to speak freely again.")

/datum/mutation/human/mute/on_acquiring(mob/living/carbon/human/owner)
	if(..())
		return
	ADD_TRAIT(owner, TRAIT_MUTE, GENETIC_MUTATION)

/datum/mutation/human/mute/on_losing(mob/living/carbon/human/owner)
	if(..())
		return
	REMOVE_TRAIT(owner, TRAIT_MUTE, GENETIC_MUTATION)

/datum/mutation/human/unintelligible
	name = "Unintelligible"
	desc = "Partially inhibits the vocal center of the brain, severely distorting speech."
	quality = NEGATIVE
	text_gain_indication = span_danger("You can't seem to form any coherent thoughts!")
	text_lose_indication = span_danger("Your mind feels more clear.")

/datum/mutation/human/unintelligible/on_acquiring(mob/living/carbon/human/owner)
	if(..())
		return
	ADD_TRAIT(owner, TRAIT_UNINTELLIGIBLE_SPEECH, GENETIC_MUTATION)

/datum/mutation/human/unintelligible/on_losing(mob/living/carbon/human/owner)
	if(..())
		return
	REMOVE_TRAIT(owner, TRAIT_UNINTELLIGIBLE_SPEECH, GENETIC_MUTATION)

/datum/mutation/human/stoner
	name = "Stoner"
	desc = "A common mutation that severely decreases intelligence."
	quality = NEGATIVE
	locked = TRUE
	text_gain_indication = span_notice("You feel...totally chill, man!")
	text_lose_indication = span_notice("You feel like you have a better sense of time.")
