/datum/emote/living/carbon/human
	mob_type_allowed_typecache = list(/mob/living/carbon/human)

/datum/emote/living/carbon/human/cry
	key = "cry"
	key_third_person = "cries"
	message = "cries."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/dap
	key = "dap"
	key_third_person = "daps"
	message = "sadly can't find anybody to give daps to, and daps themself. Shameful."
	message_param = "give daps to %t."
	hands_use_check = TRUE

/datum/emote/living/carbon/human/eyebrow
	key = "eyebrow"
	message = "raises an eyebrow."

/datum/emote/living/carbon/human/grumble
	key = "grumble"
	key_third_person = "grumbles"
	message = "grumbles!"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/handshake
	key = "handshake"
	message = "shakes their own hands."
	message_param = "shakes hands with %t."
	hands_use_check = TRUE
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/hug
	key = "hug"
	key_third_person = "hugs"
	message = "hugs themself."
	message_param = "hugs %t."
	hands_use_check = TRUE
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/mumble
	key = "mumble"
	key_third_person = "mumbles"
	message = "mumbles!"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/scream
	key = "scream"
	key_third_person = "screams"
	message = "screams!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE

/datum/emote/living/carbon/human/scream/get_sound(mob/living/user)
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/H = user
	if(ishumanbasic(H))
		if(user.gender == FEMALE)
			return pick('sound/voice/human/femalescream_1.ogg', 'sound/voice/human/femalescream_2.ogg', 'sound/voice/human/femalescream_3.ogg', 'sound/voice/human/femalescream_4.ogg', 'sound/voice/human/femalescream_5.ogg')
		else
			if(prob(1))
				return 'sound/voice/human/wilhelm_scream.ogg'
			return pick('sound/voice/human/malescream_1.ogg', 'sound/voice/human/malescream_2.ogg', 'sound/voice/human/malescream_3.ogg', 'sound/voice/human/malescream_4.ogg', 'sound/voice/human/malescream_5.ogg', 'sound/voice/human/malescream_6.ogg')
	else if(ismoth(H))
		return 'sound/voice/moth/scream_moth.ogg'
	else if(isvox(H))
		return 'sound/voice/vox/vox_scream_1.ogg'
	else if(islizard(H))
		return pick('sound/voice/lizard/lizard_scream_1.ogg', 'sound/voice/lizard/lizard_scream_2.ogg', 'sound/voice/lizard/lizard_scream_3.ogg', 'sound/voice/lizard/lizard_scream_4.ogg')

/datum/emote/living/carbon/human/hiss //lizard
	key = "hiss"
	key_third_person = "hisses"
	message = "hisses!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE

/datum/emote/living/carbon/human/hiss/get_sound(mob/living/user)
	if(!ishuman(user))
		return
	if(islizard(user))
		return 'sound/voice/lizard/hiss.ogg'

/datum/emote/living/carbon/human/squeal //lizard
	key = "squeal"
	key_third_person = "squeals"
	message = "squeals!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE

/datum/emote/living/carbon/human/squeal/get_sound(mob/living/user)
	if(!ishuman(user))
		return
	if(islizard(user))
		return 'sound/voice/lizard/squeal.ogg' //This is from Bay

/datum/emote/living/carbon/human/tailthump //lizard + vox
	key = "thump"
	key_third_person = "thumps their tail"
	message = "thumps their tail!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE

/datum/emote/living/carbon/human/tailthump/get_sound(mob/living/user)
	if(!ishuman(user))
		return
	if(!isnull(user.getorgan(/obj/item/organ/tail)) || (isvox(user)))
		return 'sound/voice/lizard/tailthump.ogg' //https://freesound.org/people/TylerAM/sounds/389665/

/datum/emote/living/carbon/human/stomp
	key = "stomp"
	key_third_person = "stomps their foot"
	message = "stomps their foot!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE

/datum/emote/living/carbon/human/stomp/get_sound(mob/living/user)
	if(ishuman(user))
		if(!user.get_bodypart(BODY_ZONE_L_LEG) || !user.get_bodypart(BODY_ZONE_R_LEG))
			return
		else
			return 'sound/voice/lizard/tailthump.ogg' //https://freesound.org/people/TylerAM/sounds/389665/

/datum/emote/living/carbon/human/weh //lizard
	key = "weh"
	key_third_person = "lets out a weh"
	message = "lets out a weh!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE

/datum/emote/living/carbon/human/weh/get_sound(mob/living/user)
	if(!ishuman(user))
		return
	if(islizard(user))
		return 'sound/voice/lizard/weh.ogg'

/datum/emote/living/carbon/human/pale
	key = "pale"
	message = "goes pale for a second."

/datum/emote/living/carbon/human/raise
	key = "raise"
	key_third_person = "raises"
	message = "raises a hand."
	hands_use_check = TRUE

/datum/emote/living/carbon/human/salute
	key = "salute"
	key_third_person = "salutes"
	message = "salutes."
	message_param = "salutes to %t."
	hands_use_check = TRUE

/datum/emote/living/carbon/human/shrug
	key = "shrug"
	key_third_person = "shrugs"
	message = "shrugs."

/datum/emote/living/carbon/human/wag
	key = "wag"
	key_third_person = "wags"
	message = "wags their tail."

/datum/emote/living/carbon/human/wag/run_emote(mob/user, params, type_override, intentional)
	. = ..()
	if(!.)
		return
	var/mob/living/carbon/human/H = user
	if(!istype(H) || !H.dna || !H.dna.species || !H.dna.species.can_wag_tail(H))
		return
	if(!H.dna.species.is_wagging_tail())
		H.dna.species.start_wagging_tail(H)
	else
		H.dna.species.stop_wagging_tail(H)

/datum/emote/living/carbon/human/wag/can_run_emote(mob/user, status_check = TRUE , intentional)
	if(!..())
		return FALSE
	var/mob/living/carbon/human/H = user
	return H.dna && H.dna.species && H.dna.species.can_wag_tail(user)

/datum/emote/living/carbon/human/wag/select_message_type(mob/user, intentional)
	. = ..()
	var/mob/living/carbon/human/H = user
	if(!H.dna || !H.dna.species)
		return
	if(H.dna.species.is_wagging_tail())
		. = null

/datum/emote/living/carbon/human/wing
	key = "wing"
	key_third_person = "wings"
	message = "their wings."

/datum/emote/living/carbon/human/wing/run_emote(mob/user, params, type_override, intentional)
	. = ..()
	if(.)
		var/mob/living/carbon/human/H = user
		if(findtext(select_message_type(user,intentional), "open"))
			H.OpenWings()
		else
			H.CloseWings()

/datum/emote/living/carbon/human/wing/select_message_type(mob/user, intentional)
	. = ..()
	var/mob/living/carbon/human/H = user
	if("wings" in H.dna.species.mutant_bodyparts)
		. = "opens " + message
	else
		. = "closes " + message

/datum/emote/living/carbon/human/wing/can_run_emote(mob/user, status_check = TRUE, intentional)
	if(!..())
		return FALSE
	var/mob/living/carbon/human/H = user
	if(H.dna && H.dna.species && (H.dna.features["wings"] != "None"))
		return TRUE

/mob/living/carbon/human/proc/OpenWings()
	if(!dna || !dna.species)
		return
	if("wings" in dna.species.mutant_bodyparts)
		dna.species.mutant_bodyparts -= "wings"
		dna.species.mutant_bodyparts |= "wingsopen"
	update_body()

/mob/living/carbon/human/proc/CloseWings()
	if(!dna || !dna.species)
		return
	if("wingsopen" in dna.species.mutant_bodyparts)
		dna.species.mutant_bodyparts -= "wingsopen"
		dna.species.mutant_bodyparts |= "wings"
	update_body()
	if(isturf(loc))
		var/turf/T = loc
		T.Entered(src)

// Robotic Tongue emotes. Beep!

/datum/emote/living/carbon/human/robot_tongue/can_run_emote(mob/user, status_check = TRUE , intentional)
	if(!..())
		return FALSE
	var/obj/item/organ/tongue/T = user.getorganslot("tongue")
	if(T.status == ORGAN_ROBOTIC)
		return TRUE

/datum/emote/living/carbon/human/robot_tongue/beep
	key = "beep"
	key_third_person = "beeps"
	message = "beeps."
	message_param = "beeps at %t."

/datum/emote/living/carbon/human/robot_tongue/beep/run_emote(mob/user, params)
	. = ..()
	if(.)
		playsound(user.loc, 'sound/machines/twobeep.ogg', 50)

/datum/emote/living/carbon/human/robot_tongue/buzz
	key = "buzz"
	key_third_person = "buzzes"
	message = "buzzes."
	message_param = "buzzes at %t."

/datum/emote/living/carbon/human/robot_tongue/buzz/run_emote(mob/user, params)
	. = ..()
	if(.)
		playsound(user.loc, 'sound/machines/buzz-sigh.ogg', 50)

/datum/emote/living/carbon/human/robot_tongue/buzz2
	key = "buzz2"
	message = "buzzes twice."

/datum/emote/living/carbon/human/robot_tongue/buzz2/run_emote(mob/user, params)
	. = ..()
	if(.)
		playsound(user.loc, 'sound/machines/buzz-two.ogg', 50)

/datum/emote/living/carbon/human/robot_tongue/chime
	key = "chime"
	key_third_person = "chimes"
	message = "chimes."

/datum/emote/living/carbon/human/robot_tongue/chime/run_emote(mob/user, params)
	. = ..()
	if(.)
		playsound(user.loc, 'sound/machines/chime.ogg', 50)

/datum/emote/living/carbon/human/robot_tongue/no
	key = "no"
	key_third_person = "no"
	message = "emits a negative blip."

/datum/emote/living/carbon/human/robot_tongue/no/run_emote(mob/user, params)
	. = ..()
	if(.)
		playsound(user.loc, 'sound/machines/synth_no.ogg', 50)

/datum/emote/living/carbon/human/robot_tongue/ping
	key = "ping"
	key_third_person = "pings"
	message = "pings."
	message_param = "pings at %t."

/datum/emote/living/carbon/human/robot_tongue/ping/run_emote(mob/user, params)
	. = ..()
	if(.)
		playsound(user.loc, 'sound/machines/ping.ogg', 50)

/datum/emote/living/carbon/human/robot_tongue/warn
	key = "warn"
	key_third_person = "warn"
	message = "blares an alarm!"

/datum/emote/living/carbon/human/robot_tongue/warn/run_emote(mob/user, params)
	. = ..()
	if(.)
		playsound(user.loc, 'sound/machines/warning-buzzer.ogg', 50)

/datum/emote/living/carbon/human/robot_tongue/yes
	key = "yes"
	key_third_person = "yes"
	message = "emits an affirmative blip."

/datum/emote/living/carbon/human/robot_tongue/yes/run_emote(mob/user, params)
	. = ..()
	if(.)
		playsound(user.loc, 'sound/machines/synth_yes.ogg', 50)

/datum/emote/living/carbon/human/robot_tongue/sad
	key = "sad"
	key_third_person = "plays a sad trombone..."
	message = "plays a sad trombone..."

/datum/emote/living/carbon/human/robot_tongue/sad/run_emote(mob/user, params)
	. = ..()
	if(.)
		playsound(user.loc, 'sound/misc/sadtrombone.ogg', 50)

//kepi (plus one vox i guess)

/datum/emote/living/carbon/human/kepiclick
	key = "click"
	key_third_person = "clicks"
	message = "clicks."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/kepiclick/get_sound(mob/living/user)
	if(!ishuman(user))
		return
	if(iskepori(user) || (isvox(user)))
		return 'sound/voice/kepori/kepiclick.ogg' //https://freesound.org/people/Ambiabstract/sounds/584212/

/datum/emote/living/carbon/human/kepiwhistle
	key = "whistle"
	key_third_person = "whistles"
	message = "whistles!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE

/datum/emote/living/carbon/human/kepiwhistle/get_sound(mob/living/user)
	if(!ishuman(user))
		return
	if(iskepori(user))
		return 'sound/voice/kepori/kepiwhistle.ogg' //https://freesound.org/people/Andreas.Mustola/sounds/338277/

/datum/emote/living/carbon/human/kepiwoop // i have yet to find a woop sound that doesnt suck i will do it later
	key = "woop"
	key_third_person = "woops"
	message = "woops!"
	emote_type = EMOTE_AUDIBLE
