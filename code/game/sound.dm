
///Default override for echo
/sound
	echo = list(
		0, // Direct
		0, // DirectHF
		-10000, // Room, -10000 means no low frequency sound reverb
		-10000, // RoomHF, -10000 means no high frequency sound reverb
		0, // Obstruction
		0, // ObstructionLFRatio
		0, // Occlusion
		0.25, // OcclusionLFRatio
		1.5, // OcclusionRoomRatio
		1.0, // OcclusionDirectRatio
		0, // Exclusion
		1.0, // ExclusionLFRatio
		0, // OutsideVolumeHF
		0, // DopplerFactor
		0, // RolloffFactor
		0, // RoomRolloffFactor
		1.0, // AirAbsorptionFactor
		0, // Flags (1 = Auto Direct, 2 = Auto Room, 4 = Auto RoomHF)
	)
	environment = SOUND_ENVIRONMENT_NONE //Default to none so sounds without overrides dont get reverb

/*! playsound

playsound is a proc used to play a 3D sound in a specific range. This uses SOUND_RANGE + extra_range to determine that.

source - Origin of sound
soundin - Either a file, or a string that can be used to get an SFX
vol - The volume of the sound, excluding falloff and pressure affection.
vary - bool that determines if the sound changes pitch every time it plays
extrarange - modifier for sound range. This gets added on top of SOUND_RANGE
falloff_exponent - Rate of falloff for the audio. Higher means quicker drop to low volume. Should generally be over 1 to indicate a quick dive to 0 rather than a slow dive.
frequency - playback speed of audio
channel - The channel the sound is played at
pressure_affected - Whether or not difference in pressure affects the sound (E.g. if you can hear in space)
ignore_walls - Whether or not the sound can pass through walls.
falloff_distance - Distance at which falloff begins. Sound is at peak volume (in regards to falloff) aslong as it is in this range.

*/

/proc/playsound(atom/source, soundin, vol as num, vary, extrarange as num, falloff_exponent = SOUND_FALLOFF_EXPONENT, frequency = null, channel = 0, pressure_affected = TRUE, ignore_walls = TRUE, falloff_distance = SOUND_DEFAULT_FALLOFF_DISTANCE, use_reverb = TRUE, mono_adj = FALSE)	//WS Edit, Make tools and nearby airlocks use mono sound
	if(isarea(source))
		CRASH("playsound(): source is an area")

	var/turf/turf_source = get_turf(source)

	if (!turf_source)
		return

	//allocate a channel if necessary now so its the same for everyone
	channel = channel || SSsounds.random_available_channel()

	// Looping through the player list has the added bonus of working for mobs inside containers
	var/sound/S = sound(get_sfx(soundin))
	var/maxdistance = SOUND_RANGE + extrarange
	var/source_z = "[turf_source.virtual_z]"
	var/list/listeners = LAZYACCESS(SSmobs.players_by_virtual_z, source_z) || list()

	var/turf/above_turf = turf_source.above()
	var/turf/below_turf = turf_source.below()

	if(!ignore_walls) //these sounds don't carry through walls
		listeners = listeners & hearers(maxdistance,turf_source)

		if(above_turf && istransparentturf(above_turf))
			listeners += hearers(maxdistance,above_turf)

		if(below_turf && istransparentturf(turf_source))
			listeners += hearers(maxdistance,below_turf)

	else
		if(above_turf && istransparentturf(above_turf))
			listeners += LAZYACCESS(SSmobs.players_by_virtual_z, "[above_turf.virtual_z()]") || list()

		if(below_turf && istransparentturf(turf_source))
			listeners += LAZYACCESS(SSmobs.players_by_virtual_z, "[below_turf.virtual_z()]") || list()

	for(var/P in listeners)
		var/mob/M = P
		var/ismono = FALSE
		if(mono_adj)
			ismono = get_dist(get_turf(P), turf_source) < 2	//If adjacent, play as mono
		if(get_dist(M, turf_source) <= maxdistance)
			M.playsound_local(turf_source, soundin, vol, vary, frequency, falloff_exponent, channel, pressure_affected, S, maxdistance, falloff_distance, ignore_direction = ismono)

	for(var/P in LAZYACCESS(SSmobs.dead_players_by_virtual_z, source_z))
		var/mob/M = P
		var/ismono = FALSE
		if(mono_adj)
			ismono = get_dist(get_turf(P), turf_source) < 2
		if(get_dist(M, turf_source) <= maxdistance)
			M.playsound_local(turf_source, soundin, vol, vary, frequency, falloff_exponent, channel, pressure_affected, S, maxdistance, falloff_distance, ignore_direction = ismono)

/*! playsound

playsound_local is a proc used to play a sound directly on a mob from a specific turf.
This is called by playsound to send sounds to players, in which case it also gets the max_distance of that sound.

turf_source - Origin of sound
soundin - Either a file, or a string that can be used to get an SFX
vol - The volume of the sound, excluding falloff
vary - bool that determines if the sound changes pitch every time it plays
frequency - playback speed of audio
falloff_exponent - Rate of falloff for the audio. Higher means quicker drop to low volume. Should generally be over 1 to indicate a quick dive to 0 rather than a slow dive.
channel - The channel the sound is played at
pressure_affected - Whether or not difference in pressure affects the sound (E.g. if you can hear in space)
max_distance - The peak distance of the sound, if this is a 3D sound
falloff_distance - Distance at which falloff begins, if this is a 3D sound
distance_multiplier - Can be used to multiply the distance at which the sound is heard

*/

/mob/proc/playsound_local(turf/turf_source, soundin, vol as num, vary, frequency, falloff_exponent = SOUND_FALLOFF_EXPONENT, channel = 0, pressure_affected = TRUE, sound/S, max_distance, falloff_distance = SOUND_DEFAULT_FALLOFF_DISTANCE, distance_multiplier = 1, use_reverb = TRUE, envwet = -10000, envdry = 0, ignore_direction) // Env Wet / Dry is Reverb
	if(!client || !can_hear())
		return

	if(!S)
		S = sound(get_sfx(soundin))

	S.wait = 0 //No queue
	S.channel = channel || SSsounds.random_available_channel()
	S.volume = vol

	if(vary)
		if(frequency)
			S.frequency = frequency
		else
			S.frequency = get_rand_frequency()

	if(isturf(turf_source))
		var/turf/T = get_turf(src)

		//sound volume falloff with distance
		var/distance = get_dist(T, turf_source)

		distance *= distance_multiplier

		if(max_distance) //If theres no max_distance we're not a 3D sound, so no falloff.
			S.volume -= (max(distance - falloff_distance, 0) ** (1 / falloff_exponent)) / ((max(max_distance, distance) - falloff_distance) ** (1 / falloff_exponent)) * S.volume
			//https://www.desmos.com/calculator/sqdfl8ipgf

		if(pressure_affected)
			//Atmosphere affects sound
			var/pressure_factor = 1
			var/datum/gas_mixture/hearer_env = T.return_air()
			var/datum/gas_mixture/source_env = turf_source.return_air()

			if(hearer_env && source_env)
				var/pressure = min(hearer_env.return_pressure(), source_env.return_pressure())
				if(pressure < ONE_ATMOSPHERE)
					pressure_factor = max((pressure - SOUND_MINIMUM_PRESSURE)/(ONE_ATMOSPHERE - SOUND_MINIMUM_PRESSURE), 0)
			else //space
				pressure_factor = 0

			S.echo = list(envdry, null, envwet, null, null, null, null, null, null, null, null, null, null, 1, 1, 1, null, null)

			if(distance <= 1)
				pressure_factor = max(pressure_factor, 0.15) //touching the source of the sound

			S.volume *= pressure_factor
			//End Atmosphere affecting sound

		if(S.volume <= 0)
			return //No sound
		if(!ignore_direction)	//WS Edit, allow for disabling directionality.
			var/dx = turf_source.x - T.x // Hearing from the right/left
			S.x = dx * distance_multiplier
			var/dz = turf_source.y - T.y // Hearing from infront/behind
			S.z = dz * distance_multiplier
			var/dy = (turf_source.z - T.z) * 5 * distance_multiplier // Hearing from  above / below, multiplied by 5 because we assume height is further along coords.
			S.y = dy
		else
			S.y = 1	//To make sure the mono sound doesn't make you feel like you're dying.
		S.falloff = max_distance || 1

		if(S.environment == SOUND_ENVIRONMENT_NONE)
			if(sound_environment_override != SOUND_ENVIRONMENT_NONE)
				S.environment = sound_environment_override
			else
				var/area/A = get_area(src)
				if(A.sound_environment != SOUND_ENVIRONMENT_NONE)
					S.environment = A.sound_environment

		if(use_reverb && S.environment != SOUND_ENVIRONMENT_NONE) //We have reverb, reset our echo setting
			S.echo[3] = 0 //Room setting, 0 means normal reverb
			S.echo[4] = 0 //RoomHF setting, 0 means normal reverb.

	SEND_SOUND(src, S)

/proc/sound_to_playing_players(soundin, volume = 100, vary = FALSE, frequency = 0, channel = 0, pressure_affected = FALSE, sound/S)
	if(!S)
		S = sound(get_sfx(soundin))
	for(var/m in GLOB.player_list)
		if(ismob(m) && !isnewplayer(m))
			var/mob/M = m
			M.playsound_local(M, null, volume, vary, frequency, null, channel, pressure_affected, S)

/mob/proc/stop_sound_channel(chan)
	SEND_SOUND(src, sound(null, repeat = 0, wait = 0, channel = chan))

/mob/proc/set_sound_channel_volume(channel, volume)
	var/sound/S = sound(null, FALSE, FALSE, channel, volume)
	S.status = SOUND_UPDATE
	SEND_SOUND(src, S)

/client/proc/playtitlemusic(vol = 85)
	set waitfor = FALSE
	UNTIL(SSticker.login_music) //wait for SSticker init to set the login music

	if(prefs && (prefs.toggles & SOUND_LOBBY))
		SEND_SOUND(src, sound(SSticker.login_music, repeat = 0, wait = 0, volume = vol, channel = CHANNEL_LOBBYMUSIC)) // MAD JAMS

/proc/get_rand_frequency()
	return rand(32000, 55000) //Frequency stuff only works with 45kbps oggs.

/proc/get_sfx(soundin)
	if(istext(soundin))
		switch(soundin)

			if("explosion_large")
				soundin = pick('sound/effects/explosion_large1.ogg','sound/effects/explosion_large2.ogg','sound/effects/explosion_large3.ogg','sound/effects/explosion_large4.ogg','sound/effects/explosion_large5.ogg','sound/effects/explosion_large6.ogg')
			if("explosion_micro")
				soundin = pick('sound/effects/explosion_micro1.ogg','sound/effects/explosion_micro2.ogg','sound/effects/explosion_micro3.ogg')
			if("explosion_small")
				soundin = pick('sound/effects/explosion_small1.ogg','sound/effects/explosion_small2.ogg','sound/effects/explosion_small3.ogg','sound/effects/explosion_small4.ogg')
			if("explosion_med")
				soundin = pick('sound/effects/explosion_med1.ogg','sound/effects/explosion_med2.ogg','sound/effects/explosion_med3.ogg','sound/effects/explosion_med4.ogg','sound/effects/explosion_med5.ogg','sound/effects/explosion_med6.ogg')
			if("explosion_small_distant")
				soundin = pick('sound/effects/explosion_smallfar1.ogg','sound/effects/explosion_smallfar2.ogg','sound/effects/explosion_smallfar3.ogg','sound/effects/explosion_smallfar4.ogg')
			if("explosion_large_distant")
				soundin = pick('sound/effects/explosion_far1.ogg','sound/effects/explosion_far2.ogg','sound/effects/explosion_far3.ogg','sound/effects/explosion_far4.ogg','sound/effects/explosion_far5.ogg')

			if ("shatter")
				soundin = pick('sound/effects/glassbr1.ogg','sound/effects/glassbr2.ogg','sound/effects/glassbr3.ogg')
			if ("explosion")
				soundin = pick('sound/effects/explosion1.ogg','sound/effects/explosion2.ogg')
			if ("explosion_creaking")
				soundin = pick('sound/effects/explosioncreak1.ogg', 'sound/effects/explosioncreak2.ogg')
			if ("hull_creaking")
				soundin = pick('sound/effects/creak1.ogg', 'sound/effects/creak2.ogg', 'sound/effects/creak3.ogg')

			if ("sparks")
				soundin = pick('sound/effects/sparks1.ogg','sound/effects/sparks2.ogg','sound/effects/sparks3.ogg','sound/effects/sparks4.ogg')
			if ("rustle")
				soundin = pick('sound/items/storage/rustle1.ogg','sound/items/storage/rustle2.ogg','sound/items/storage/rustle3.ogg','sound/items/storage/rustle4.ogg','sound/items/storage/rustle5.ogg')
			if ("bodyfall")
				soundin = pick('sound/effects/bodyfall1.ogg','sound/effects/bodyfall2.ogg','sound/effects/bodyfall3.ogg','sound/effects/bodyfall4.ogg')
			if ("punch")
				soundin = pick('sound/weapons/punch1.ogg','sound/weapons/punch2.ogg','sound/weapons/punch3.ogg','sound/weapons/punch4.ogg')
			if ("clownstep")
				soundin = pick('sound/effects/clownstep1.ogg','sound/effects/clownstep2.ogg')
			if ("suitstep")
				soundin = pick('sound/effects/suitstep1.ogg','sound/effects/suitstep2.ogg')
			if ("swing_hit")
				soundin = pick('sound/weapons/genhit1.ogg', 'sound/weapons/genhit2.ogg', 'sound/weapons/genhit3.ogg')
			if ("hiss")
				soundin = pick('sound/voice/hiss1.ogg','sound/voice/hiss2.ogg','sound/voice/hiss3.ogg','sound/voice/hiss4.ogg')
			if ("pageturn")
				soundin = pick('sound/effects/pageturn1.ogg', 'sound/effects/pageturn2.ogg','sound/effects/pageturn3.ogg')
//gun related stuff start
			if ("bullet_hit")
				soundin = pick('sound/weapons/gun/hit/bullet_impact1.ogg', 'sound/weapons/gun/hit/bullet_impact2.ogg','sound/weapons/gun/hit/bullet_impact3.ogg')
			if ("bullet_impact")
				soundin = pick('sound/weapons/gun/hit/bullet_ricochet1.ogg', 'sound/weapons/gun/hit/bullet_ricochet2.ogg','sound/weapons/gun/hit/bullet_ricochet3.ogg','sound/weapons/gun/hit/bullet_ricochet4.ogg','sound/weapons/gun/hit/bullet_ricochet5.ogg','sound/weapons/gun/hit/bullet_ricochet6.ogg','sound/weapons/gun/hit/bullet_ricochet7.ogg','sound/weapons/gun/hit/bullet_ricochet8.ogg')
			if ("bullet_bounce")
				soundin = pick('sound/weapons/gun/hit/bullet_bounce1.ogg', 'sound/weapons/gun/hit/bullet_bounce2.ogg','sound/weapons/gun/hit/bullet_bounce3.ogg','sound/weapons/gun/hit/bullet_bounce4.ogg','sound/weapons/gun/hit/bullet_bounce5.ogg')
			if("bullet_miss")
				soundin = pick('sound/weapons/gun/hit/bullet_miss1.ogg', 'sound/weapons/gun/hit/bullet_miss2.ogg', 'sound/weapons/gun/hit/bullet_miss3.ogg')
			if("bullet_hit_glass")
				soundin = pick(
					'sound/weapons/gun/hit/bullet_glass_01.ogg',
					'sound/weapons/gun/hit/bullet_glass_02.ogg',
					'sound/weapons/gun/hit/bullet_glass_03.ogg',
					'sound/weapons/gun/hit/bullet_glass_04.ogg',
					'sound/weapons/gun/hit/bullet_glass_05.ogg',
					'sound/weapons/gun/hit/bullet_glass_06.ogg',
					'sound/weapons/gun/hit/bullet_glass_07.ogg',
				)
			if("bullet_hit_stone")
				soundin = pick(
					'sound/weapons/gun/hit/bullet_masonry_01.ogg',
					'sound/weapons/gun/hit/bullet_masonry_02.ogg',
					'sound/weapons/gun/hit/bullet_masonry_03.ogg',
					'sound/weapons/gun/hit/bullet_masonry_04.ogg',
					'sound/weapons/gun/hit/bullet_masonry_05.ogg',
					'sound/weapons/gun/hit/bullet_masonry_06.ogg',
				)
			if("bullet_hit_metal")
				soundin = pick(
					'sound/weapons/gun/hit/bullet_metal_01.ogg',
					'sound/weapons/gun/hit/bullet_metal_02.ogg',
					'sound/weapons/gun/hit/bullet_metal_03.ogg',
					'sound/weapons/gun/hit/bullet_metal_04.ogg',
					'sound/weapons/gun/hit/bullet_metal_05.ogg',
					'sound/weapons/gun/hit/bullet_metal_06.ogg',
				)
			if("bullet_hit_wood")
				soundin = pick(
					'sound/weapons/gun/hit/bullet_wood_01.ogg',
					'sound/weapons/gun/hit/bullet_wood_02.ogg',
					'sound/weapons/gun/hit/bullet_wood_03.ogg',
					'sound/weapons/gun/hit/bullet_wood_04.ogg',
					'sound/weapons/gun/hit/bullet_wood_05.ogg',
					'sound/weapons/gun/hit/bullet_wood_06.ogg',
				)
			if("bullet_hit_snow")
				soundin = pick(
					'sound/weapons/gun/hit/bullet_snow_01.ogg',
					'sound/weapons/gun/hit/bullet_snow_02.ogg',
					'sound/weapons/gun/hit/bullet_snow_03.ogg',
					'sound/weapons/gun/hit/bullet_snow_04.ogg',
					'sound/weapons/gun/hit/bullet_snow_05.ogg',
					'sound/weapons/gun/hit/bullet_snow_06.ogg',
				)
// gun related stuff  end
			if ("terminal_type")
				soundin = pick('sound/machines/terminal_button01.ogg', 'sound/machines/terminal_button02.ogg', 'sound/machines/terminal_button03.ogg', \
								'sound/machines/terminal_button04.ogg', 'sound/machines/terminal_button05.ogg', 'sound/machines/terminal_button06.ogg', \
								'sound/machines/terminal_button07.ogg', 'sound/machines/terminal_button08.ogg')
			if ("desceration")
				soundin = pick('sound/misc/desceration-01.ogg', 'sound/misc/desceration-02.ogg', 'sound/misc/desceration-03.ogg')
			if ("im_here")
				soundin = pick('sound/hallucinations/im_here1.ogg', 'sound/hallucinations/im_here2.ogg')
			if ("can_open")
				soundin = pick('sound/effects/can_open1.ogg', 'sound/effects/can_open2.ogg', 'sound/effects/can_open3.ogg')
			if("revolver_spin")
				soundin = pick('sound/weapons/gun/revolver/spin1.ogg', 'sound/weapons/gun/revolver/spin2.ogg', 'sound/weapons/gun/revolver/spin3.ogg')
			if("law")
				soundin = pick('sound/voice/beepsky/god.ogg', 'sound/voice/beepsky/iamthelaw.ogg', 'sound/voice/beepsky/secureday.ogg', 'sound/voice/beepsky/radio.ogg', 'sound/voice/beepsky/insult.ogg', 'sound/voice/beepsky/creep.ogg')
			if("goose")
				soundin = pick('sound/creatures/goose1.ogg', 'sound/creatures/goose2.ogg', 'sound/creatures/goose3.ogg', 'sound/creatures/goose4.ogg')
			if("warpspeed")
				soundin = 'sound/runtime/hyperspace/hyperspace_begin.ogg'
			if("smcalm")
				soundin = pick('sound/machines/sm/accent/normal/1.ogg', 'sound/machines/sm/accent/normal/2.ogg', 'sound/machines/sm/accent/normal/3.ogg', 'sound/machines/sm/accent/normal/4.ogg', 'sound/machines/sm/accent/normal/5.ogg', 'sound/machines/sm/accent/normal/6.ogg', 'sound/machines/sm/accent/normal/7.ogg', 'sound/machines/sm/accent/normal/8.ogg', 'sound/machines/sm/accent/normal/9.ogg', 'sound/machines/sm/accent/normal/10.ogg', 'sound/machines/sm/accent/normal/11.ogg', 'sound/machines/sm/accent/normal/12.ogg', 'sound/machines/sm/accent/normal/13.ogg', 'sound/machines/sm/accent/normal/14.ogg', 'sound/machines/sm/accent/normal/15.ogg', 'sound/machines/sm/accent/normal/16.ogg', 'sound/machines/sm/accent/normal/17.ogg', 'sound/machines/sm/accent/normal/18.ogg', 'sound/machines/sm/accent/normal/19.ogg', 'sound/machines/sm/accent/normal/20.ogg', 'sound/machines/sm/accent/normal/21.ogg', 'sound/machines/sm/accent/normal/22.ogg', 'sound/machines/sm/accent/normal/23.ogg', 'sound/machines/sm/accent/normal/24.ogg', 'sound/machines/sm/accent/normal/25.ogg', 'sound/machines/sm/accent/normal/26.ogg', 'sound/machines/sm/accent/normal/27.ogg', 'sound/machines/sm/accent/normal/28.ogg', 'sound/machines/sm/accent/normal/29.ogg', 'sound/machines/sm/accent/normal/30.ogg', 'sound/machines/sm/accent/normal/31.ogg', 'sound/machines/sm/accent/normal/32.ogg', 'sound/machines/sm/accent/normal/33.ogg')
			if("smdelam")
				soundin = pick('sound/machines/sm/accent/delam/1.ogg', 'sound/machines/sm/accent/normal/2.ogg', 'sound/machines/sm/accent/normal/3.ogg', 'sound/machines/sm/accent/normal/4.ogg', 'sound/machines/sm/accent/normal/5.ogg', 'sound/machines/sm/accent/normal/6.ogg', 'sound/machines/sm/accent/normal/7.ogg', 'sound/machines/sm/accent/normal/8.ogg', 'sound/machines/sm/accent/normal/9.ogg', 'sound/machines/sm/accent/normal/10.ogg', 'sound/machines/sm/accent/normal/11.ogg', 'sound/machines/sm/accent/normal/12.ogg', 'sound/machines/sm/accent/normal/13.ogg', 'sound/machines/sm/accent/normal/14.ogg', 'sound/machines/sm/accent/normal/15.ogg', 'sound/machines/sm/accent/normal/16.ogg', 'sound/machines/sm/accent/normal/17.ogg', 'sound/machines/sm/accent/normal/18.ogg', 'sound/machines/sm/accent/normal/19.ogg', 'sound/machines/sm/accent/normal/20.ogg', 'sound/machines/sm/accent/normal/21.ogg', 'sound/machines/sm/accent/normal/22.ogg', 'sound/machines/sm/accent/normal/23.ogg', 'sound/machines/sm/accent/normal/24.ogg', 'sound/machines/sm/accent/normal/25.ogg', 'sound/machines/sm/accent/normal/26.ogg', 'sound/machines/sm/accent/normal/27.ogg', 'sound/machines/sm/accent/normal/28.ogg', 'sound/machines/sm/accent/normal/29.ogg', 'sound/machines/sm/accent/normal/30.ogg', 'sound/machines/sm/accent/normal/31.ogg', 'sound/machines/sm/accent/normal/32.ogg', 'sound/machines/sm/accent/normal/33.ogg')
			if("keystroke")
				soundin = pick('sound/machines/keyboard/keypress1.ogg','sound/machines/keyboard/keypress2.ogg','sound/machines/keyboard/keypress3.ogg','sound/machines/keyboard/keypress4.ogg')
			if("keyboard")
				soundin = pick('sound/machines/keyboard/keystroke1.ogg','sound/machines/keyboard/keystroke2.ogg','sound/machines/keyboard/keystroke3.ogg','sound/machines/keyboard/keystroke4.ogg')
			if("button")
				soundin = pick('sound/machines/button1.ogg','sound/machines/button2.ogg','sound/machines/button3.ogg','sound/machines/button4.ogg')
			if("switch")	//stolen from nsv
				soundin = pick('sound/machines/switch1.ogg','sound/machines/switch2.ogg','sound/machines/switch3.ogg')
	return soundin
