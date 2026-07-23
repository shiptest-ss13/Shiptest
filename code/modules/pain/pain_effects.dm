#warn demodularize before merge
// -- Pain effects - mood, modifiers, statuses. --

/atom/movable/screen/fullscreen/pain
	icon = 'icons/hud/screen_full.dmi'
	icon_state = "painoverlay"
	layer = UI_DAMAGE_LAYER

/mob/living/carbon/proc/flash_pain_overlay(severity = 1, time = 10)
	overlay_fullscreen("pain", /atom/movable/screen/fullscreen/pain, severity)
	clear_fullscreen("pain", time)

/datum/movespeed_modifier/pain
	id = MOVESPEED_ID_PAIN
	movetypes = GROUND

// >= 100 total pain
/datum/movespeed_modifier/pain/light
	multiplicative_slowdown = 0.1

// >= 200 total pain
/datum/movespeed_modifier/pain/medium
	multiplicative_slowdown = 0.2

// >= 300 total pain
/datum/movespeed_modifier/pain/heavy
	multiplicative_slowdown = 0.35

// >= 400 total pain
/datum/movespeed_modifier/pain/crippling
	multiplicative_slowdown = 0.5

/datum/actionspeed_modifier/pain
	id = ACTIONSPEED_ID_PAIN

// >= 100 total pain
/datum/actionspeed_modifier/pain/light
	multiplicative_slowdown = 0.2

// >= 200 total pain
/datum/actionspeed_modifier/pain/medium
	multiplicative_slowdown = 0.2

// >= 300 total pain
/datum/actionspeed_modifier/pain/heavy
	multiplicative_slowdown = 0.35

// >= 400 total pain
/datum/actionspeed_modifier/pain/crippling
	multiplicative_slowdown = 0.5

/datum/mood_event/light_pain
	description = "<span class='warning'>Everything aches.</span>\n"
	mood_change = -3

/datum/mood_event/med_pain
	description = "<span class='warning'>Everything feels sore.</span>\n"
	mood_change = -6

/datum/mood_event/heavy_pain
	description = "<span class='boldwarning'>Everything hurts!</span>\n"
	mood_change = -10

/datum/mood_event/crippling_pain
	description = "<span class='boldwarning'>STOP THE PAIN!</span>\n"
	mood_change = -15

/datum/mood_event/anesthetic
	description = "Thank science for modern medicine."
	mood_change = 2
	timeout = 6 MINUTES

// Applied by most surgeries if you get operated on without anesthetics
/datum/mood_event/surgery
	description = "They're operating on me while I'm awake!"
	mood_change = -6
	timeout = 3 MINUTES

// Applied by some surgeries that are especially bad without anesthetics
/datum/mood_event/surgery/major
	mood_change = -9
	description = "THEY'RE CUTTING ME OPEN!!"
	mood_change = -10
	timeout = 6 MINUTES

/atom/movable/screen/alert/numbed
	name = "Numbed"
	desc = "Your body is numb, painless. You're under the effect of some kind of painkiller."
	icon_state = "drugged"

/datum/mood_event/narcotic_light
	description = "I feel numb."
	mood_change = 4
	timeout = 3 MINUTES
