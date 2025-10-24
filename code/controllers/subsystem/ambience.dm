/// The subsystem used to play ambience to users every now and then, makes them real excited.
SUBSYSTEM_DEF(ambience)
	name = "Ambience"
	flags = SS_BACKGROUND|SS_NO_INIT
	priority = FIRE_PRIORITY_AMBIENCE
	runlevels = RUNLEVEL_GAME | RUNLEVEL_POSTGAME
	wait = 1 SECONDS
	///Assoc list of listening client - next ambience time
	var/list/ambience_listening_clients = list()

/datum/controller/subsystem/ambience/fire(resumed)
	for(var/client/client_iterator as anything in ambience_listening_clients)

		//Check to see if the client exists and isn't held by a new player
		var/mob/client_mob = client_iterator?.mob

		if(isnull(client_iterator) || isnewplayer(client_iterator.mob))
			ambience_listening_clients -= client_iterator
			continue

		if(ambience_listening_clients[client_iterator] > world.time)
			continue //Not ready for the next sound

		var/area/current_area = get_area(client_iterator.mob)

		ambience_listening_clients[client_iterator] = world.time + current_area.play_ambience(client_mob)

///Attempts to play an ambient sound to a mob, returning the cooldown in deciseconds
/area/proc/play_ambience(mob/M, sound/override_sound, volume = 27)
	var/sound/new_sound = override_sound || pick(ambientsounds)
	new_sound = sound(new_sound, repeat = 0, wait = 0, volume = 25, channel = CHANNEL_AMBIENCE)

	SEND_SOUND(M, new_sound)

	var/sound_length = ceil(SSsound_cache.get_sound_length(new_sound.file))
	return rand(min_ambience_cooldown + sound_length, max_ambience_cooldown + sound_length)
