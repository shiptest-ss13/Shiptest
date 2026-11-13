/**
 * Compiles our lines into "chords" with numbers. This makes there have to be a bit of lag at the beginning of the song, but repeats will not have to parse it again, and overall playback won't be impacted by as much lag.
 */
/datum/song/proc/compile_synthesized()
	if(!length(src.lines))
		return
	var/list/lines = src.lines		//cache for hyepr speed!
	compiled_chords = list()
	compiled_chord_lines = list()
	var/line_number = 0
	var/list/octaves = list(3, 3, 3, 3, 3, 3, 3)
	var/list/accents = list("n", "n", "n", "n", "n", "n", "n")
	var/note_volume = 100
	for(var/line in lines)
		line_number++
		var/list/chords = splittext(lowertext(line), ",")
		for(var/chord in chords)
			var/list/compiled_chord = list()
			var/tempodiv = 1
			var/list/notes_tempodiv = splittext(chord, "/")
			var/len = length(notes_tempodiv)
			if(len >= 2)
				tempodiv = text2num(notes_tempodiv[2])
			if(len)			//some dunkass is going to do ,,,, to make 3 rests instead of ,/1 because there's no standardization so let's be prepared for that.
				var/list/notes = splittext(notes_tempodiv[1], "-")
				for(var/note in notes)
					if(length(note) == 0)
						continue
					// ~x holds the note at full volume for x beats before it starts to decay
					var/hold = get_note_suffix(note, "~") || 0
					// !x sets the volume percentage for this and following notes
					var/new_volume = get_note_suffix(note, "!")
					if(!isnull(new_volume))
						note_volume = clamp(new_volume, 1, 100)
					note = strip_note_suffixes(note)
					// 1-7, A-G
					var/key = text2ascii(note) - 96
					if((key < 1) || (key > 7))
						continue
					for(var/i in 2 to length(note))
						var/oct_acc = copytext(note, i, i + 1)
						var/num = text2num(oct_acc)
						if(!num)		//it's an accidental
							accents[key] = oct_acc		//if they misspelled it/fucked up that's on them lmao, no safety checks.
						else	//octave
							octaves[key] = clamp(num, octave_min, octave_max)
					var/note_number = clamp((note_offset_lookup[key] + octaves[key] * 12 + accent_lookup[accents[key]]), key_min, key_max)
					// held or quieter notes are stored as list(note number, hold in beats, volume percentage)
					if(hold > 0 || note_volume != 100)
						compiled_chord[++compiled_chord.len] = list(note_number, hold, note_volume)
					else
						compiled_chord += note_number
			compiled_chord += tempodiv		//this goes last
			if(length(compiled_chord))
				compiled_chords[++compiled_chords.len] = compiled_chord
				compiled_chord_lines += line_number
			CHECK_TICK

/**
 * Plays a specific numerical key from our instrument to anyone who can hear us.
 * Does a hearing check if enough time has passed.
 *
 * Arguments:
 * * hold - beats to hold the note at full volume before it starts to decay
 * * note_volume - volume percentage of this note, on top of our volume
 */
/datum/song/proc/playkey_synth(key, mob/user, hold = 0, note_volume = 100)
	if(can_noteshift)
		key = clamp(key + note_shift, key_min, key_max)
	if((world.time - MUSICIAN_HEARCHECK_MINDELAY) > last_hearcheck)
		do_hearcheck()
	var/datum/instrument_key/K = using_instrument.samples[num2text(key)]			//See how fucking easy it is to make a number text? You don't need a complicated 9 line proc!
	//Should probably add channel limiters here at some point but I don't care right now.
	var/channel = pop_channel()
	if(isnull(channel))
		return FALSE
	. = TRUE
	var/sound/copy = sound(K.sample)
	var/volume = src.volume * using_instrument.volume_multiplier * note_volume * 0.01
	copy.frequency = K.frequency
	copy.volume = volume
	var/channel_text = num2text(channel)
	channels_playing[channel_text] = 100
	channels_note_volume[channel_text] = note_volume
	if(hold > 0)
		channels_held[channel_text] = world.time + min(hold * tempo, INSTRUMENT_MAX_TOTAL_SUSTAIN)
	else
		channels_held -= channel_text
	last_channel_played = channel_text
	for(var/i in hearing_mobs)
		var/mob/M = i
		if(user && HAS_TRAIT(user, TRAIT_MUSICIAN) && isliving(M))
			var/mob/living/L = M
			L.apply_status_effect(STATUS_EFFECT_GOOD_MUSIC)
		var/listener_volume = M?.get_instrument_volume()
		if(!listener_volume)
			continue
		copy.environment = SOUND_ENVIRONMENT_NONE
		M.playsound_local(get_turf(parent), null, volume * listener_volume * 0.01, FALSE, K.frequency, null, channel, null, copy)
		// Could do environment and echo later but not for now

/**
 * Stops all sounds we are "responsible" for. Only works in synthesized mode.
 */
/datum/song/proc/terminate_all_sounds(clear_channels = TRUE)
	for(var/i in hearing_mobs)
		terminate_sound_mob(i)
	if(clear_channels)
		channels_playing.len = 0
		channels_idle.len = 0
		channels_held.len = 0
		channels_note_volume.len = 0
		SSinstruments.current_instrument_channels -= using_sound_channels
		using_sound_channels = 0
		SSsounds.free_datum_channels(src)

/**
 * Stops all sounds we are responsible for in a given person. Only works in synthesized mode.
 */
/datum/song/proc/terminate_sound_mob(mob/M)
	for(var/channel in channels_playing)
		M.stop_sound_channel(text2num(channel))

/**
 * Pops a channel we have reserved so we don't have to release and re-request them from SSsounds every time we play a note. This is faster.
 */
/datum/song/proc/pop_channel()
	if(length(channels_idle))			//just pop one off of here if we have one available
		. = text2num(channels_idle[1])
		channels_idle.Cut(1,2)
		return
	if(using_sound_channels < max_sound_channels)
		. = SSinstruments.reserve_instrument_channel(src)
		if(!isnull(.))
			using_sound_channels++
			return
	return steal_channel()

/**
 * Out of channels, so we steal one from the quietest note.
 */
/datum/song/proc/steal_channel()
	var/quietest_channel
	var/quietest_volume = INFINITY
	for(var/channel in channels_playing)
		var/channel_volume = channels_playing[channel] * channels_note_volume[channel]
		if(channel_volume < quietest_volume)
			quietest_channel = channel
			quietest_volume = channel_volume
	if(isnull(quietest_channel))
		return
	channels_playing -= quietest_channel
	return text2num(quietest_channel)

/**
 * Decays our channels and updates their volumes to mobs who can hear us.
 *
 * Arguments:
 * * wait_ds - the deciseconds we should decay by. This is to compensate for any lag, as otherwise songs would get pretty nasty during high time dilation.
 */
/datum/song/proc/process_decay(wait_ds)
	var/linear_dropoff = cached_linear_dropoff * wait_ds
	var/exponential_dropoff = cached_exponential_dropoff ** wait_ds
	var/list/listener_groups = list()
	for(var/mob/hearer as anything in hearing_mobs)
		var/listener_volume = hearer?.get_instrument_volume()
		if(!listener_volume)
			continue
		var/group_key = "[listener_volume]"
		if(!listener_groups[group_key])
			listener_groups[group_key] = list()
		listener_groups[group_key] += hearer
	for(var/channel in channels_playing)
		if(full_sustain_held_note && (channel == last_channel_played))
			continue
		var/held_until = channels_held[channel]
		if(held_until)
			if(world.time < held_until)
				continue
			channels_held -= channel
		var/current_volume = channels_playing[channel]
		switch(sustain_mode)
			if(SUSTAIN_LINEAR)
				current_volume -= linear_dropoff
			if(SUSTAIN_EXPONENTIAL)
				current_volume /= exponential_dropoff
		channels_playing[channel] = current_volume
		var/dead = current_volume <= sustain_dropoff_volume
		var/channelnumber = text2num(channel)
		if(dead)
			channels_playing -= channel
			channels_idle += channel
			var/sound/stop_sound = sound(null, repeat = 0, wait = 0, channel = channelnumber)
			for(var/group_key in listener_groups)
				for(var/mob/listener as anything in listener_groups[group_key])
					SEND_SOUND(listener, stop_sound)
			continue
		var/output_volume = (current_volume * 0.01) * (channels_note_volume[channel] * 0.01) * volume * using_instrument.volume_multiplier
		// one sound per volume group, rather than a new one for each listener
		for(var/group_key in listener_groups)
			var/sound/update_sound = sound(null, FALSE, FALSE, channelnumber, output_volume * text2num(group_key) * 0.01)
			update_sound.status = SOUND_UPDATE
			for(var/mob/listener as anything in listener_groups[group_key])
				SEND_SOUND(listener, update_sound)
