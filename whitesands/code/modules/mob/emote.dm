//WS Emotes

/datum/emote/speen
	key = "speen"
	key_third_person = "speeeens"
	hands_use_check = TRUE
	mob_type_allowed_typecache = list(/mob/living, /mob/dead/observer)
	mob_type_ignore_stat_typecache = list(/mob/dead/observer)

/datum/emote/speen/run_emote(mob/user, params,  type_override, intentional)
	. = ..()
	if(.)
		user.spin(20, 1)
		if(isobserver(user) && prob(90)) //Speening in their grave
			user.playsound_local(get_turf(user), 'whitesands/sound/voice/speen.ogg', 50, TRUE)
			return
		playsound(user, 'whitesands/sound/voice/speen.ogg', 50, 1, -1)
		if((iscyborg(user) || isanimal(user)) && user.has_buckled_mobs())
			var/mob/living/L = user
			var/datum/component/riding/riding_datum = L.GetComponent(/datum/component/riding)
			if(riding_datum)
				if(L.a_intent == INTENT_HELP)
					for(var/mob/M in L.buckled_mobs)
						riding_datum.force_dismount(M, TRUE)
				else
					for(var/mob/M in L.buckled_mobs)
						riding_datum.force_dismount(M)
			else
				L.unbuckle_all_mobs()
