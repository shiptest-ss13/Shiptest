// see _DEFINES/is_helpers.dm for mob type checks

///Find the mob at the bottom of a buckle chain
/mob/proc/lowest_buckled_mob()
	. = src
	if(buckled && ismob(buckled))
		var/mob/Buckled = buckled
		. = Buckled.lowest_buckled_mob()

///Convert a PRECISE ZONE into the BODY_ZONE
/proc/check_zone(zone)
	if(!zone)
		return BODY_ZONE_CHEST
	switch(zone)
		if(BODY_ZONE_PRECISE_EYES)
			zone = BODY_ZONE_HEAD
		if(BODY_ZONE_PRECISE_MOUTH)
			zone = BODY_ZONE_HEAD
		if(BODY_ZONE_PRECISE_L_HAND)
			zone = BODY_ZONE_L_ARM
		if(BODY_ZONE_PRECISE_R_HAND)
			zone = BODY_ZONE_R_ARM
		if(BODY_ZONE_PRECISE_L_FOOT)
			zone = BODY_ZONE_L_LEG
		if(BODY_ZONE_PRECISE_R_FOOT)
			zone = BODY_ZONE_R_LEG
		if(BODY_ZONE_PRECISE_GROIN)
			zone = BODY_ZONE_CHEST
	return zone

/// Returns a generic path of the object based on the slot
/proc/get_path_by_slot(slot_id)
	switch(slot_id)
		if(ITEM_SLOT_BACK)
			return /obj/item/storage/backpack
		if(ITEM_SLOT_MASK)
			return /obj/item/clothing/mask
		if(ITEM_SLOT_NECK)
			return /obj/item/clothing/neck
		if(ITEM_SLOT_HANDCUFFED)
			return /obj/item/restraints/handcuffs
		if(ITEM_SLOT_LEGCUFFED)
			return /obj/item/restraints/legcuffs
		if(ITEM_SLOT_BELT)
			return /obj/item/storage/belt
		if(ITEM_SLOT_ID)
			return /obj/item/card/id
		if(ITEM_SLOT_EARS)
			return /obj/item/clothing/ears
		if(ITEM_SLOT_EYES)
			return /obj/item/clothing/glasses
		if(ITEM_SLOT_GLOVES)
			return /obj/item/clothing/gloves
		if(ITEM_SLOT_HEAD)
			return /obj/item/clothing/head
		if(ITEM_SLOT_FEET)
			return /obj/item/clothing/shoes
		if(ITEM_SLOT_OCLOTHING)
			return /obj/item/clothing/suit
		if(ITEM_SLOT_ICLOTHING)
			return /obj/item/clothing/under
		if(ITEM_SLOT_LPOCKET)
			return /obj/item
		if(ITEM_SLOT_RPOCKET)
			return /obj/item
		if(ITEM_SLOT_SUITSTORE)
			return /obj/item
	return null

/**
 * Return the zone or randomly, another valid zone
 *
 * probability controls the chance it chooses the passed in zone, or another random zone
 * defaults to 80
 */
/proc/ran_zone(zone, probability = 80)
	if(prob(probability))
		zone = check_zone(zone)
	else
		zone = pick_weight(list(BODY_ZONE_HEAD = 4, BODY_ZONE_CHEST = 64, BODY_ZONE_L_ARM = 8, BODY_ZONE_R_ARM = 8, BODY_ZONE_L_LEG = 8, BODY_ZONE_R_LEG = 8))
	return zone

///Would this zone be above the neck
/proc/above_neck(zone)
	var/list/zones = list(BODY_ZONE_HEAD, BODY_ZONE_PRECISE_MOUTH, BODY_ZONE_PRECISE_EYES)
	if(zones.Find(zone))
		return 1
	else
		return 0

/**
 * Convert random parts of a passed in message to stars
 *
 * * phrase - the string to convert
 * * probability - probability any character gets changed
 *
 * This proc is dangerously laggy, avoid it or die
 */
/proc/stars(phrase, probability = 25)
	if(probability <= 0)
		return phrase
	phrase = html_decode(phrase)
	var/leng = length(phrase)
	. = ""
	var/char = ""
	for(var/i = 1, i <= leng, i += length(char))
		char = phrase[i]
		if(char == " " || !prob(probability))
			. += char
		else
			. += "*"
	return sanitize(.)

/**
 * Makes you speak like you're drunk
 */
/proc/slur(phrase)
	phrase = html_decode(phrase)
	var/leng = length(phrase)
	. = ""
	var/newletter = ""
	var/rawchar = ""
	for(var/i = 1, i <= leng, i += length(rawchar))
		rawchar = newletter = phrase[i]
		if(rand(1, 3) == 3)
			var/lowerletter = lowertext(newletter)
			if(lowerletter == "o")
				newletter = "u"
			else if(lowerletter == "s")
				newletter = "ch"
			else if(lowerletter == "a")
				newletter = "ah"
			else if(lowerletter == "u")
				newletter = "oo"
			else if(lowerletter == "c")
				newletter = "k"
		switch(rand(1, 20))
			if(1)
				newletter += "'"
			if(10)
				newletter += "[newletter]"
			if(20)
				newletter += "[newletter][newletter]"
			else
				EMPTY_BLOCK_GUARD
		. += "[newletter]"
	return sanitize(.)

/// Makes you talk like you got cult stunned, which is slurring but with some dark messages
/proc/cultslur(phrase) // Inflicted on victims of a stun talisman
	phrase = html_decode(phrase)
	var/leng = length(phrase)
	. = ""
	var/newletter = ""
	var/rawchar = ""
	for(var/i = 1, i <= leng, i += length(rawchar))
		rawchar = newletter = phrase[i]
		if(rand(1, 2) == 2)
			var/lowerletter = lowertext(newletter)
			if(lowerletter == "o")
				newletter = "u"
			else if(lowerletter == "t")
				newletter = "ch"
			else if(lowerletter == "a")
				newletter = "ah"
			else if(lowerletter == "u")
				newletter = "oo"
			else if(lowerletter == "c")
				newletter = " NAR "
			else if(lowerletter == "s")
				newletter = " SIE "
		if(rand(1, 4) == 4)
			if(newletter == " ")
				newletter = " no hope... "
			else if(newletter == "H")
				newletter = " IT COMES... "

		switch(rand(1, 15))
			if(1)
				newletter = "'"
			if(2)
				newletter += "agn"
			if(3)
				newletter = "fth"
			if(4)
				newletter = "nglu"
			if(5)
				newletter = "glor"
			else
				EMPTY_BLOCK_GUARD
		. += newletter
	return sanitize(.)

#define CLOCK_CULT_SLUR(phrase) sanitize(text2ratvar(phrase))

///Adds stuttering to the message passed in
/proc/stutter(phrase)
	phrase = html_decode(phrase)
	var/leng = length(phrase)
	. = ""
	var/newletter = ""
	var/rawchar = ""
	var/static/regex/nostutter = regex(@@[aeiouAEIOU "'()[\]{}.!?,:;_`~-]@)
	for(var/i = 1, i <= leng, i += length(rawchar))
		rawchar = newletter = phrase[i]
		if(prob(70) && !nostutter.Find(rawchar))
			if(prob(25))
				newletter = "[newletter]-[newletter]-[newletter]"
			else
				newletter = "[newletter]-[newletter]"
		. += newletter
	return sanitize(.)

///Convert a message to derpy speak
/proc/derpspeech(message, stuttering)
	message = replacetext(message, " am ", " ")
	message = replacetext(message, " is ", " ")
	message = replacetext(message, " are ", " ")
	message = replacetext(message, "you", "u")
	message = replacetext(message, "help", "halp")
	message = replacetext(message, "grief", "grife")
	message = replacetext(message, "space", "spess")
	message = replacetext(message, "carp", "crap")
	message = replacetext(message, "reason", "raisin")
	if(prob(50))
		message = uppertext(message)
		message += "[stutter(pick("!", "!!", "!!!"))]"
	if(!stuttering && prob(15))
		message = stutter(message)
	return message

/**
 * Turn text into complete gibberish!
 *
 * text is the inputted message, replace_characters will cause original letters to be replaced and chance are the odds that a character gets modified.
 */
/proc/Gibberish(text, replace_characters = FALSE, chance = 50)
	text = html_decode(text)
	. = ""
	if(!chance)
		return sanitize(.)
	var/rawchar = ""
	var/letter = ""
	var/lentext = length(text)
	for(var/i = 1, i <= lentext, i += length(rawchar))
		rawchar = letter = text[i]
		if(prob(chance))
			if(replace_characters)
				letter = ""
			for(var/j in 1 to rand(0, 2))
				letter += pick("#", "@", "*", "&", "%", "$", "/", "<", ">", ";", "*", "*", "*", "*", "*", "*", "*")
		. += letter
	return sanitize(.)

///Shake the camera of the person viewing the mob SO REAL!
/proc/shake_camera(mob/recoilster, duration, strength=1)
	if(!recoilster || !recoilster.client || duration < 1)
		return
	var/client/client_to_shake = recoilster.client
	var/oldx = client_to_shake.pixel_x
	var/oldy = client_to_shake.pixel_y
	var/max = strength*world.icon_size
	var/min = -(strength*world.icon_size)

	for(var/i in 0 to duration-1)
		if (i == 0)
			animate(client_to_shake, pixel_x=rand(min,max), pixel_y=rand(min,max), time=1)
		else
			animate(pixel_x=rand(min,max), pixel_y=rand(min,max), time=1)
	animate(pixel_x=oldx, pixel_y=oldy, time=1)


/proc/recoil_camera(mob/recoilster, duration, backtime_duration, strength, angle)
	if(!recoilster || !recoilster.client)
		return
	strength *= world.icon_size
	var/client/client_to_shake = recoilster.client
	var/oldx = client_to_shake.pixel_x
	var/oldy = client_to_shake.pixel_y

	//get pixels to move the camera in an angle
	var/mpx = sin(angle) * strength
	var/mpy = cos(angle) * strength
	animate(client_to_shake, pixel_x = oldx+mpx, pixel_y = oldy+mpy, time = duration, flags = ANIMATION_RELATIVE)
	animate(pixel_x = oldx, pixel_y = oldy, time = backtime_duration, easing = BACK_EASING)

///Find if the message has the real name of any user mob in the mob_list
/proc/findname(msg)
	if(!istext(msg))
		msg = "[msg]"
	for(var/i in GLOB.mob_list)
		var/mob/M = i
		if(lowertext(M.real_name) == lowertext(msg))
			return M
	return 0

///Find the first name of a mob from the real name with regex
/mob/proc/first_name()
	var/static/regex/firstname = new("^\[^\\s-\]+") //First word before whitespace or "-"
	firstname.Find(real_name)
	return firstname.match


/**
 * change a mob's act-intent.
 *
 * Input the intent as a string such as "help" or use "right"/"left
 */
/mob/verb/a_intent_change(input as text)
	set name = "a-intent"
	set hidden = TRUE

	if(!possible_a_intents || !possible_a_intents.len)
		return

	if(input in possible_a_intents)
		a_intent = input
	else
		var/current_intent = possible_a_intents.Find(a_intent)

		if(!current_intent)
			// Failsafe. Just in case some badmin was playing with VV.
			current_intent = 1

		if(input == INTENT_HOTKEY_RIGHT)
			current_intent += 1
		if(input == INTENT_HOTKEY_LEFT)
			current_intent -= 1

		// Handle looping
		if(current_intent < 1)
			current_intent = possible_a_intents.len
		if(current_intent > possible_a_intents.len)
			current_intent = 1

		a_intent = possible_a_intents[current_intent]

	if(hud_used && hud_used.action_intent)
		hud_used.action_intent.icon_state = "[a_intent]"

///Returns a mob's real name between brackets. Useful when you want to display a mob's name alongside their real name
/mob/proc/get_realname_string()
	if(real_name && real_name != name)
		return " \[[real_name]\]"
	return ""

///Checks if the mob is able to see or not. eye_blind is temporary blindness, the trait is if they're permanently blind.
/mob/proc/is_blind()
	SHOULD_BE_PURE(TRUE)
	return eye_blind ? TRUE : HAS_TRAIT(src, TRAIT_BLIND)

///Is the mob hallucinating?
/mob/proc/hallucinating()
	return FALSE


// moved out of admins.dm because things other than admin procs were calling this.
/**
 * Is this mob special to the gamemode?
 *
 * returns 1 for special characters and 2 for heroes of gamemode
 *
 */
/proc/is_special_character(mob/M)
	if(!SSticker.HasRoundStarted())
		return FALSE
	if(!istype(M))
		return FALSE
	if(issilicon(M))
		if(iscyborg(M)) //For cyborgs, returns 1 if the cyborg has a law 0 and special_role. Returns 0 if the borg is merely slaved to an AI traitor.
			return FALSE
		else if(isAI(M))
			var/mob/living/silicon/ai/A = M
			if(A.laws && A.laws.zeroth && A.mind && A.mind.special_role)
				return TRUE
		return FALSE
	if(M.mind && M.mind.special_role)//If they have a mind and special role, they are some type of traitor or antagonist.
		switch(SSticker.mode.config_tag)
			if("nuclear")
				if(M.mind.has_antag_datum(/datum/antagonist/nukeop,TRUE))
					return 2
			if("changeling")
				if(M.mind.has_antag_datum(/datum/antagonist/changeling,TRUE))
					return 2
			if("wizard")
				if(iswizard(M))
					return 2
			if("apprentice")
				if(M.mind in SSticker.mode.apprentices)
					return 2

		return TRUE
	if(M.mind && LAZYLEN(M.mind.antag_datums)) //they have an antag datum!
		return TRUE
	return FALSE


/mob/proc/handled_by_species(datum/reagent/R) // utilized in the species code
	return 1


/**
 * Fancy notifications for ghosts
 *
 * The kitchen sink of notification procs
 *
 * Arguments:
 * * message
 * * ghost_sound sound to play
 * * enter_link Href link to enter the ghost role being notified for
 * * source The source of the notification
 * * alert_overlay The alert overlay to show in the alert message
 * * action What action to take upon the ghost interacting with the notification, defaults to NOTIFY_JUMP
 * * flashwindow Flash the byond client window
 * * ignore_key  Ignore keys if they're in the GLOB.poll_ignore list
 * * header The header of the notifiaction
 * * notify_volume How loud the sound should be to spook the user
 */
/proc/notify_ghosts(message, ghost_sound = null, enter_link = null, atom/source = null, mutable_appearance/alert_overlay = null, action = NOTIFY_JUMP, flashwindow = TRUE, ignore_mapload = TRUE, ignore_key, header = null, notify_volume = 100) //Easy notification of ghosts.
	if(ignore_mapload && SSatoms.initialized != INITIALIZATION_INNEW_REGULAR)	//don't notify for objects created during a map load
		return
	for(var/mob/dead/observer/O in GLOB.player_list)
		if (ignore_key && (O.ckey in GLOB.poll_ignore[ignore_key]))
			continue
		var/orbit_link
		if (source && action == NOTIFY_ORBIT)
			orbit_link = " <a href='byond://?src=[REF(O)];follow=[REF(source)]'>(Orbit)</a>"
		to_chat(O, span_ghostalert("[message][(enter_link) ? " [enter_link]" : ""][orbit_link]"))
		if(ghost_sound)
			SEND_SOUND(O, sound(ghost_sound, volume = notify_volume))
		if(flashwindow)
			window_flash(O.client)
		if(source)
			var/atom/movable/screen/alert/notify_action/A = O.throw_alert("[REF(source)]_notify_action", /atom/movable/screen/alert/notify_action)
			if(A)
				if(O.client.prefs && O.client.prefs.UI_style)
					A.icon = ui_style2icon(O.client.prefs.UI_style)
				if (header)
					A.name = header
				A.desc = message
				A.action = action
				A.target_ref = WEAKREF(source)
				if(!alert_overlay)
					alert_overlay = new(source)
				alert_overlay.layer = FLOAT_LAYER
				alert_overlay.plane = FLOAT_PLANE
				A.add_overlay(alert_overlay)

/**
 * Heal a robotic body part on a mob
 */
/proc/item_heal_robotic(mob/living/carbon/human/H, mob/user, brute_heal, burn_heal)
	var/obj/item/bodypart/affecting = H.get_bodypart(check_zone(user.zone_selected))
	if(affecting && (!IS_ORGANIC_LIMB(affecting)))
		var/dam //changes repair text based on how much brute/burn was supplied
		if(brute_heal > burn_heal)
			dam = 1
		else
			dam = 0
		if((brute_heal > 0 && affecting.brute_dam > 0) || (burn_heal > 0 && affecting.burn_dam > 0))
			if(affecting.heal_damage(brute_heal, burn_heal, 0, BODYTYPE_ROBOTIC))
				H.update_damage_overlays()
			user.visible_message("[user] has fixed some of the [dam ? "dents on" : "burnt wires in"] [H]'s [parse_zone(affecting.body_zone)].", \
			span_notice("You fix some of the [dam ? "dents on" : "burnt wires in"] [H == user ? "your" : "[H]'s"] [parse_zone(affecting.body_zone)]."))
			return 1 //successful heal
		else
			to_chat(user, span_warning("[affecting] is already in good condition!"))

///Is the passed in mob a ghost with admin powers, doesn't check for AI interact like isAdminGhost() used to
/proc/isAdminObserver(mob/user)
	if(!user)		//Are they a mob? Auto interface updates call this with a null src
		return
	if(!user.client) // Do they have a client?
		return
	if(!isobserver(user)) // Are they a ghost?
		return
	if(!check_rights_for(user.client, R_ADMIN|R_DEBUG)) // Are they allowed?
		return
	return TRUE

///Is the passed in mob an admin ghost WITH AI INTERACT enabled
/proc/isAdminGhostAI(mob/user)
	if(!isAdminObserver(user))
		return
	if(!user.client.AI_Interact) // Do they have it enabled?
		return
	return TRUE

/**
 * Offer control of the passed in mob to dead player
 *
 * Automatic logging and uses pollCandidatesForMob, how convenient
 */
/proc/offer_control(mob/M)
	to_chat(M, "Control of your mob has been offered to dead players.")
	if(usr)
		log_admin("[key_name(usr)] has offered control of ([key_name(M)]) to ghosts.")
		message_admins("[key_name_admin(usr)] has offered control of ([ADMIN_LOOKUPFLW(M)]) to ghosts")
	var/poll_message = "Do you want to play as [M.real_name]?"
	if(M.mind && M.mind.assigned_role)
		poll_message = "[poll_message] Job:[M.mind.assigned_role]."
	if(M.mind && M.mind.special_role)
		poll_message = "[poll_message] Status:[M.mind.special_role]."
	else if(M.mind)
		var/datum/antagonist/A = M.mind.has_antag_datum(/datum/antagonist/)
		if(A)
			poll_message = "[poll_message] Status:[A.name]."
	var/list/mob/dead/observer/candidates = pollCandidatesForMob(poll_message, ROLE_PAI, null, FALSE, 100, M)

	if(LAZYLEN(candidates))
		var/mob/dead/observer/C = pick(candidates)
		to_chat(M, "Your mob has been taken over by a ghost!")
		message_admins("[key_name_admin(C)] has taken control of ([ADMIN_LOOKUPFLW(M)])")
		M.ghostize(0)
		M.key = C.key
		return TRUE
	else
		to_chat(M, "There were no ghosts willing to take control.")
		message_admins("No ghosts were willing to take control of [ADMIN_LOOKUPFLW(M)])")
		return FALSE

///Clicks a random nearby mob with the source from this mob
/mob/proc/click_random_mob()
	var/list/nearby_mobs = list()
	for(var/mob/living/L in range(1, src))
		if(L!=src)
			nearby_mobs |= L
	if(nearby_mobs.len)
		var/mob/living/T = pick(nearby_mobs)
		ClickOn(T)

/// Logs a message in a mob's individual log, and in the global logs as well if log_globally is true
/mob/log_message(message, message_type, color=null, log_globally = TRUE)
	if(!LAZYLEN(message))
		stack_trace("Empty message")
		return

	// Cannot use the list as a map if the key is a number, so we stringify it (thank you BYOND)
	var/smessage_type = num2text(message_type)

	if(client)
		if(!islist(client.player_details.logging[smessage_type]))
			client.player_details.logging[smessage_type] = list()

	if(!islist(logging[smessage_type]))
		logging[smessage_type] = list()

	var/colored_message = message
	if(color)
		if(color[1] == "#")
			colored_message = "<font color=[color]>[message]</font>"
		else
			colored_message = "<font color='[color]'>[message]</font>"

	//This makes readability a bit better for admins.
	switch(message_type)
		if(LOG_WHISPER)
			colored_message = "(WHISPER) [colored_message]"
		if(LOG_OOC)
			colored_message = "(OOC) [colored_message]"
		if(LOG_ASAY)
			colored_message = "(ASAY) [colored_message]"
		if(LOG_EMOTE)
			colored_message = "(EMOTE) [colored_message]"

	var/list/timestamped_message = list("\[[time_stamp()]\] [key_name(src)] [loc_name(src)]" = colored_message)

	logging[smessage_type] += timestamped_message

	if(client)
		client.player_details.logging[smessage_type] += timestamped_message

	..()

///Can the mob hear
/mob/proc/can_hear()
	. = TRUE

/mob/proc/has_mouth()
	return FALSE

/**
 * Examine text for traits shared by multiple types.
 *
 * I wish examine was less copypasted. (oranges say, be the change you want to see buddy)
 */
/mob/proc/common_trait_examine()
	if(HAS_TRAIT(src, TRAIT_DISSECTED))
		var/dissectionmsg = ""
		if(HAS_TRAIT_FROM(src, TRAIT_DISSECTED,"Extraterrestrial Dissection"))
			dissectionmsg = " via Extraterrestrial Dissection. It is no longer worth experimenting on"
		else if(HAS_TRAIT_FROM(src, TRAIT_DISSECTED,"Experimental Dissection"))
			dissectionmsg = " via Experimental Dissection"
		else if(HAS_TRAIT_FROM(src, TRAIT_DISSECTED,"Thorough Dissection"))
			dissectionmsg = " via Thorough Dissection"
		. += "[span_notice("This body has been dissected and analyzed[dissectionmsg].")]<br>"

/**
 * Get the list of keywords for policy config
 *
 * This gets the type, mind assigned roles and antag datums as a list, these are later used
 * to send the user relevant headadmin policy config
 */
/mob/proc/get_policy_keywords()
	. = list()
	. += "[type]"
	if(mind)
		. += mind.assigned_role
		. += mind.special_role //In case there's something special leftover, try to avoid
		for(var/datum/antagonist/A in mind.antag_datums)
			. += "[A.type]"

///Can the mob see reagents inside of containers?
/mob/proc/can_see_reagents()
	return stat == DEAD || has_unlimited_silicon_privilege //Dead guys and silicons can always see reagents
