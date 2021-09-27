/**
  * Generate a visible message from this atom that can only be seen by sufficently skilled mobs
  *
  * Show a message to all player mobs who sees this atom and have sufficent skill
  *
  * Show a message to the src mob (if the src is a mob)
  *
  * Use for atoms performing visible actions
  *
  * message is output to anyone who can see, e.g. "The [src] does something!"
  *
  * Vars:
  * * self_message (optional) is what the src mob sees e.g. "You do something!"
  * * blind_message (optional) is what blind people will hear e.g. "You hear something!"
  * * vision_distance (optional) define how many tiles away the message can be seen.
  * * ignored_mob (optional) doesn't show any message to a given mob if TRUE.
  * * skill - The type of skill needed
  * * skill_level - The level of the skill needed
  */
/atom/proc/skill_message(message, self_message, blind_message, vision_distance = DEFAULT_MESSAGE_RANGE, list/ignored_mobs, visible_message_flags = NONE, skill, skill_level)
	var/turf/T = get_turf(src)
	if(!T)
		return

	if(!islist(ignored_mobs))
		ignored_mobs = list(ignored_mobs)
	var/list/hearers = get_hearers_in_view(vision_distance, src) //caches the hearers and then removes ignored mobs.
	hearers -= ignored_mobs

	if(self_message)
		hearers -= src

	var/raw_msg = message
	if(visible_message_flags & EMOTE_MESSAGE)
		message = "<span class='emote'><b>[src]</b> [message]</span>"

	for(var/mob/M in hearers)
		if(!M.client)
			continue

		if(M.mind?.get_skill_level(skill) < skill_level)
			continue

		//This entire if/else chain could be in two lines but isn't for readibilties sake.
		var/msg = message
		if(M.see_invisible < invisibility)//if src is invisible to M
			msg = blind_message
		else if(T != loc && T != src) //if src is inside something and not a turf.
			msg = blind_message
		else if(T.lighting_object && T.lighting_object.invisibility <= M.see_invisible && T.is_softly_lit()) //if it is too dark.
			msg = blind_message
		if(!msg)
			continue

		if(visible_message_flags & EMOTE_MESSAGE && runechat_prefs_check(M, visible_message_flags))
			M.create_chat_message(src, raw_message = raw_msg, runechat_flags = visible_message_flags)

		M.show_message(msg, MSG_VISUAL, blind_message, MSG_AUDIBLE)
