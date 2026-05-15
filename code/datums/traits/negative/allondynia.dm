// More vulnerable to pain + get pain from more actions (Glass bones and paper skin)
/datum/quirk/allodynia
	name = "Allodynia"
	desc = "Your nerves are extremely sensitive - you may recieve pain from things that wouldn't normally be painful, such as hugs."
	value = -10
	gain_text = "<span class='danger'>You feel fragile.</span>"
	lose_text = "<span class='notice'>You feel less delicate.</span>"
	medical_record_text = "Patient has Allodynia, and is extremely sensitive to touch, pain, and similar stimuli."
	COOLDOWN_DECLARE(time_since_last_touch)

/datum/quirk/allodynia/add()
	var/mob/living/carbon/carbon_holder = quirk_holder
	if(istype(carbon_holder))
		carbon_holder.set_pain_mod(PAIN_MOD_QUIRK, 1.2)
	ADD_TRAIT(quirk_holder, TRAIT_EXTRA_PAIN, ROUNDSTART_TRAIT)
	RegisterSignal(quirk_holder, list(COMSIG_LIVING_GET_PULLED, COMSIG_CARBON_HUGGED), .proc/cause_body_pain)
	RegisterSignal(quirk_holder, COMSIG_CARBON_HEADPAT, .proc/cause_head_pain)

/datum/quirk/allodynia/remove()
	var/mob/living/carbon/carbon_holder = quirk_holder
	if(istype(carbon_holder))
		carbon_holder.unset_pain_mod(PAIN_MOD_QUIRK)
	REMOVE_TRAIT(quirk_holder, TRAIT_EXTRA_PAIN, ROUNDSTART_TRAIT)
	UnregisterSignal(quirk_holder, list(COMSIG_LIVING_GET_PULLED, COMSIG_CARBON_HUGGED, COMSIG_CARBON_HEADPAT))

/*
 * Causes pain to arm zones if they're targeted, and the chest zone otherwise.
 *
 * source - quirk_holder / the mob being touched
 * toucher - the mob that's interacting with source (pulls, hugs, etc)
 */
/datum/quirk/allodynia/proc/cause_body_pain(datum/source, mob/living/toucher)
	SIGNAL_HANDLER

	if(!COOLDOWN_FINISHED(src, time_since_last_touch))
		return

	if(quirk_holder.stat != CONSCIOUS)
		return

	var/pain_zone = ( toucher.zone_selected == BODY_ZONE_L_ARM ? BODY_ZONE_L_ARM : ( toucher.zone_selected == BODY_ZONE_R_ARM ? BODY_ZONE_R_ARM : BODY_ZONE_CHEST ))

	to_chat(quirk_holder, span_danger("[toucher] touches you, causing a wave of sharp pain throughout your body!"))
	actually_hurt(pain_zone, 9)

/*
 * Causes pain to the head when they're headpatted.
 *
 * source - quirk_holder / the mob being touched
 * toucher - the mob that's headpatting
 */
/datum/quirk/allodynia/proc/cause_head_pain(datum/source, mob/living/patter)
	SIGNAL_HANDLER

	if(!COOLDOWN_FINISHED(src, time_since_last_touch))
		return

	if(quirk_holder.stat != CONSCIOUS)
		return

	to_chat(quirk_holder, span_danger("[patter] taps your head, causing a sensation of pain!"))
	actually_hurt(BODY_ZONE_HEAD, 7)

/*
 * Actually cause the pain to the target limb, causing a visual effect, emote, and a negative moodlet.
 *
 * zone - the body zone being affected
 * amount - the amount of pain being added
 */
/datum/quirk/allodynia/proc/actually_hurt(zone, amount)
	var/mob/living/carbon/carbon_holder = quirk_holder
	if(!istype(carbon_holder))
		return

	new /obj/effect/temp_visual/annoyed(quirk_holder.loc)
	carbon_holder.cause_pain(zone, amount)
	INVOKE_ASYNC(quirk_holder, /mob.proc/emote, pick(PAIN_EMOTES))
	SEND_SIGNAL(quirk_holder, COMSIG_ADD_MOOD_EVENT, "bad_touch", /datum/mood_event/very_bad_touch)
	COOLDOWN_START(src, time_since_last_touch, 30 SECONDS)
