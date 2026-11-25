/datum/song/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "InstrumentEditor", parent.name)
		ui.open()

/datum/song/ui_host(mob/user)
	return parent

/datum/song/ui_data(mob/user)
	var/list/data = list()
	data["using_instrument"] = using_instrument?.name || "No instrument loaded!"
	data["instrument_ready"] = using_instrument?.ready()
	data["legacy"] = legacy
	data["note_shift"] = note_shift
	data["octaves"] = round(note_shift / 12, 0.01)
	data["sustain_mode"] = (sustain_mode == SUSTAIN_EXPONENTIAL) ? "Exponential" : "Linear"
	data["sustain_linear_duration"] = sustain_linear_duration / 10
	data["sustain_exponential_dropoff"] = sustain_exponential_dropoff
	data["volume"] = volume
	data["volume_dropoff_threshold"] = sustain_dropoff_volume
	data["sustain_indefinitely"] = full_sustain_held_note
	data["playing"] = playing
	data["repeat"] = repeat
	data["playing_line"] = playing_line
	data["bpm"] = round(600 / tempo)
	return data

/datum/song/ui_static_data(mob/user)
	var/list/data = list()
	var/list/decoded_lines = list()
	for(var/line in lines)
		decoded_lines += html_decode(line)
	data["lines"] = decoded_lines
	data["can_switch_instrument"] = (length(allowed_instrument_ids) > 1)
	data["possible_instruments"] = list()
	for(var/instrument_id in allowed_instrument_ids)
		var/datum/instrument/instrument = SSinstruments.get_instrument(instrument_id)
		if(instrument)
			UNTYPED_LIST_ADD(data["possible_instruments"], list("name" = "[instrument.category || "Other"]: [instrument.name]", "id" = instrument.id))
	data["can_noteshift"] = can_noteshift
	data["note_shift_min"] = note_shift_min
	data["note_shift_max"] = note_shift_max
	data["max_repeats"] = max_repeats
	data["min_volume"] = min_volume
	data["max_volume"] = max_volume
	data["min_dropoff_volume"] = INSTRUMENT_MIN_SUSTAIN_DROPOFF
	data["max_sustain_seconds"] = INSTRUMENT_MAX_TOTAL_SUSTAIN / 10
	data["min_exponential_dropoff"] = INSTRUMENT_EXP_FALLOFF_MIN
	data["max_exponential_dropoff"] = INSTRUMENT_EXP_FALLOFF_MAX
	data["max_line_chars"] = MUSIC_MAXLINECHARS
	data["max_lines"] = MUSIC_MAXLINES
	return data

/datum/song/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	var/mob/user = ui.user
	if(!istype(user))
		return FALSE
	parent.add_fingerprint(user)

	switch(action)
		//PLAYBACK
		if("play_music")
			if(!playing)
				INVOKE_ASYNC(src, PROC_REF(start_playing), user)
			else
				stop_playing()
			return TRUE
		if("set_repeat_amount")
			if(playing)
				return FALSE
			var/repeat_amount = params["amount"]
			if(!isnum(repeat_amount))
				return FALSE
			repeat = clamp(round(repeat_amount), 0, max_repeats)
			return TRUE
		if("change_instrument")
			var/new_instrument = params["new_instrument"]
			if(!(new_instrument in allowed_instrument_ids))
				return FALSE
			set_instrument(new_instrument)
			return TRUE

		//SONG MAKING
		if("tempo")
			var/tempo_diff = (params["tempo_change"] == "slower") ? world.tick_lag : -world.tick_lag
			tempo = sanitize_tempo(tempo + tempo_diff)
			return TRUE
		if("import_song")
			var/song_text = ""
			do
				song_text = html_encode(input(user, "Please paste the entire song, formatted:", name, song_text) as message|null)
				if(!song_text || !in_range(parent, user))
					return FALSE
				if(length_char(song_text) >= MUSIC_MAXLINES * MUSIC_MAXLINECHARS)
					var/should_continue = tgui_alert(user, "Your message is too long! Would you like to continue editing it?", "Warning", list("Yes", "No"))
					if(should_continue != "Yes")
						break
			while(length_char(song_text) > MUSIC_MAXLINES * MUSIC_MAXLINECHARS)
			stop_playing()
			ParseSong(song_text)
			return TRUE
		if("start_new_song")
			stop_playing()
			name = ""
			lines = new()
			tempo = sanitize_tempo(5) // default 120 BPM
			update_static_data_for_all_viewers()
			return TRUE
		if("add_new_line")
			var/new_line = tgui_input_text(user, "Enter your line", parent.name, max_length = MUSIC_MAXLINECHARS)
			if(!new_line || !in_range(parent, user))
				return FALSE
			if(length(lines) >= MUSIC_MAXLINES)
				return FALSE
			lines += new_line
			update_static_data_for_all_viewers()
			return TRUE
		if("delete_line")
			var/line_number = params["line"]
			if(!isnum(line_number) || line_number > length(lines) || line_number < 1)
				return FALSE
			lines.Cut(line_number, line_number + 1)
			update_static_data_for_all_viewers()
			return TRUE
		if("modify_line")
			var/line_number = params["line"]
			if(!isnum(line_number) || line_number > length(lines) || line_number < 1)
				return FALSE
			var/new_line = tgui_input_text(user, "Enter your line", parent.name, lines[line_number], max_length = MUSIC_MAXLINECHARS)
			if(!new_line || !in_range(parent, user))
				return FALSE
			// the song may have changed while we were typing
			if(line_number > length(lines))
				return FALSE
			lines[line_number] = new_line
			update_static_data_for_all_viewers()
			return TRUE

		//SETTINGS
		if("set_sustain_mode")
			switch(params["new_mode"])
				if("Linear")
					sustain_mode = SUSTAIN_LINEAR
				if("Exponential")
					sustain_mode = SUSTAIN_EXPONENTIAL
				else
					return FALSE
			return TRUE
		if("edit_sustain_mode")
			var/sustain_amount = params["amount"]
			if(!isnum(sustain_amount))
				return FALSE
			switch(sustain_mode)
				if(SUSTAIN_LINEAR)
					set_linear_falloff_duration(round(sustain_amount * 10, world.tick_lag))
				if(SUSTAIN_EXPONENTIAL)
					set_exponential_drop_rate(round(sustain_amount, 0.00001))
			return TRUE
		if("set_note_shift")
			var/amount = params["amount"]
			if(!can_noteshift || !isnum(amount))
				return FALSE
			note_shift = clamp(round(amount), note_shift_min, note_shift_max)
			return TRUE
		if("set_volume")
			var/new_volume = params["amount"]
			if(!isnum(new_volume))
				return FALSE
			set_volume(round(new_volume, 1))
			return TRUE
		if("set_dropoff_volume")
			var/dropoff_threshold = params["amount"]
			if(!isnum(dropoff_threshold))
				return FALSE
			set_dropoff_volume(round(dropoff_threshold, 0.01))
			return TRUE
		if("toggle_sustain_hold_indefinitely")
			full_sustain_held_note = !full_sustain_held_note
			return TRUE

/**
 * Parses a song the user has input into lines and stores them.
 */
/datum/song/proc/ParseSong(text)
	set waitfor = FALSE
	//split into lines
	lines = splittext(text, "\n")
	if(lines.len)
		var/bpm_string = "BPM: "
		var/sustain_string = "SUSTAIN: "
		var/hold_last_string = "HOLDLAST: "
		tempo = sanitize_tempo(5) // default 120 BPM
		while(lines.len)
			var/header = lines[1]
			if(findtext(header, bpm_string, 1, length(bpm_string) + 1))
				var/divisor = text2num(copytext(header, length(bpm_string) + 1)) || 120
				tempo = sanitize_tempo(600 / round(divisor, 1))
			else if(findtext(header, sustain_string, 1, length(sustain_string) + 1))
				parse_sustain_header(copytext(header, length(sustain_string) + 1))
			else if(findtext(header, hold_last_string, 1, length(hold_last_string) + 1))
				switch(lowertext(trim(copytext(header, length(hold_last_string) + 1))))
					if("on")
						full_sustain_held_note = TRUE
					if("off")
						full_sustain_held_note = FALSE
			else
				break
			lines.Cut(1, 2)
		if(lines.len > MUSIC_MAXLINES)
			to_chat(usr, "Too many lines!")
			lines.Cut(MUSIC_MAXLINES + 1)
		var/list/valid_lines = list()
		var/linenum = 0
		for(var/l in lines)
			linenum++
			if(length_char(l) > MUSIC_MAXLINECHARS)
				to_chat(usr, "Line [linenum] too long!")
			else
				valid_lines += l
		lines = valid_lines
	update_static_data_for_all_viewers()

/**
 * Sets our sustain from a SUSTAIN: header, such as "linear 0.5" for a duration in seconds or "exponential 1.4" for a falloff factor.
 */
/datum/song/proc/parse_sustain_header(text)
	var/list/sustain_args = splittext(lowertext(trim(text)), " ")
	if(length(sustain_args) < 2)
		return
	var/amount = text2num(sustain_args[2])
	if(isnull(amount))
		return
	switch(sustain_args[1])
		if("linear")
			sustain_mode = SUSTAIN_LINEAR
			set_linear_falloff_duration(round(amount * 10, world.tick_lag))
		if("exponential")
			sustain_mode = SUSTAIN_EXPONENTIAL
			set_exponential_drop_rate(round(amount, 0.00001))
