SUBSYSTEM_DEF(jukeboxes)
	name = "Jukeboxes"
	wait = 5
	var/list/songs = list()
	var/list/activejukeboxes = list()
	var/list/freejukeboxchannels = list()

/datum/track
	var/song_name = "generic"
	var/song_path = null
	var/song_length = 0
	var/song_beat = 0
	var/song_associated_id = null

/datum/track/New(name, path, length, beat, assocID)
	song_name = name
	song_path = path
	song_length = length
	song_beat = beat
	song_associated_id = assocID

/datum/controller/subsystem/jukeboxes/proc/addjukebox(obj/jukebox, datum/track/T, jukefalloff = 1)
	if(!istype(T))
		CRASH("[src] tried to play a song with a nonexistant track")
	var/channeltoreserve = pick(freejukeboxchannels)
	if(!channeltoreserve)
		return FALSE
	freejukeboxchannels -= channeltoreserve
	var/list/youvegotafreejukebox = list(T, channeltoreserve, jukebox, jukefalloff)
	activejukeboxes.len++
	activejukeboxes[activejukeboxes.len] = youvegotafreejukebox

	//Due to changes in later versions of 512, SOUND_UPDATE no longer properly plays audio when a file is defined in the sound datum. As such, we are now required to init the audio before we can actually do anything with it.
	//Downsides to this? This means that you can *only* hear the jukebox audio if you were present on the server when it started playing, and it means that it's now impossible to add loops to the jukebox track list.
	var/sound/song_to_init = sound(T.song_path)
	song_to_init.status = SOUND_MUTE
	for(var/mob/M in GLOB.player_list)
		if(!M.client)
			continue
		if(!(M.client.prefs.toggles & SOUND_INSTRUMENTS))
			continue

		M.playsound_local(M, null, 100, channel = youvegotafreejukebox[2], S = song_to_init)
	return activejukeboxes.len

/datum/controller/subsystem/jukeboxes/Recover()
	songs = SSjukeboxes.songs
	activejukeboxes = SSjukeboxes.activejukeboxes
	freejukeboxchannels = SSjukeboxes.freejukeboxchannels

/datum/controller/subsystem/jukeboxes/proc/removejukebox(IDtoremove)
	if(islist(activejukeboxes[IDtoremove]))
		var/jukechannel = activejukeboxes[IDtoremove][2]
		for(var/mob/M in GLOB.player_list)
			if(!M.client)
				continue
			M.stop_sound_channel(jukechannel)
		freejukeboxchannels |= jukechannel
		activejukeboxes.Cut(IDtoremove, IDtoremove+1)
		return TRUE
	else
		CRASH("Tried to remove jukebox with invalid ID")

/datum/controller/subsystem/jukeboxes/proc/findjukeboxindex(obj/jukebox)
	if(activejukeboxes.len)
		for(var/list/jukeinfo in activejukeboxes)
			if(jukebox in jukeinfo)
				return activejukeboxes.Find(jukeinfo)
	return FALSE

/datum/controller/subsystem/jukeboxes/Initialize()
	var/list/tracks = flist("[global.config.directory]/jukebox_music/sounds/")

	for(var/S in tracks)
		var/datum/track/T = new()
		T.song_path = file("[global.config.directory]/jukebox_music/sounds/[S]")
		var/list/L = splittext(S,"+")
		if(L.len < 4)
			log_config("Jukebox song [S] has invalid ID.")
			continue
		T.song_name = L[1]
		T.song_length = text2num(L[2])
		T.song_beat = text2num(L[3])
		T.song_associated_id = L[4]
		songs |= T
	for(var/i in CHANNEL_JUKEBOX_START to CHANNEL_JUKEBOX)
		freejukeboxchannels |= i
	return ..()

/datum/controller/subsystem/jukeboxes/fire()
	if(!activejukeboxes.len)
		return
	for(var/list/jukeinfo in activejukeboxes)
		if(!jukeinfo.len)
			stack_trace("Active jukebox without any associated metadata.")
			continue
		var/datum/track/juketrack = jukeinfo[1]
		if(!istype(juketrack))
			stack_trace("Invalid jukebox track datum.")
			continue
		var/obj/machinery/jukebox/jukebox = jukeinfo[3]
		if(!istype(jukebox))
			stack_trace("Nonexistant or invalid object associated with jukebox.")
			continue
		var/sound/song_played = sound(juketrack.song_path)
		var/area/currentarea = get_area(jukebox)
		var/turf/currentturf = get_turf(jukebox)
		var/list/hearerscache = hearers(7, jukebox)
		var/turf/above_turf = currentturf.above()
		var/turf/below_turf = currentturf.below()

		song_played.falloff = jukeinfo[4]

		for(var/mob/M in GLOB.player_list)
			if(!M.client)
				continue
			if(!(M.client.prefs.toggles & SOUND_INSTRUMENTS) || !M.can_hear())
				M.stop_sound_channel(jukeinfo[2])
				continue

			var/inrange = FALSE
			if(jukebox.z == M.z)	//todo - expand this to work with mining planet z-levels when robust jukebox audio gets merged to master
				song_played.status = SOUND_UPDATE
				if(get_area(M) == currentarea)
					inrange = TRUE
				else if(M in hearerscache)
					inrange = TRUE
			else if(above_turf?.z == M.z)
				song_played.status = SOUND_UPDATE
				if(istransparentturf(above_turf) && (get_area(M) == get_area(above_turf)))
					inrange = TRUE
			else if(below_turf?.z == M.z)
				song_played.status = SOUND_UPDATE
				if(istransparentturf(below_turf) && (get_area(M) == get_area(below_turf)))
					inrange = TRUE
			else
				song_played.status = SOUND_MUTE | SOUND_UPDATE	//Setting volume = 0 doesn't let the sound properties update at all, which is lame.

			if(jukebox.volume <= 0)
				song_played.status = SOUND_MUTE

			M.playsound_local(currentturf, null, jukebox.volume, channel = jukeinfo[2], S = song_played, envwet = (inrange ? -250 : 0), envdry = (inrange ? 0 : -10000))
			CHECK_TICK
	return
