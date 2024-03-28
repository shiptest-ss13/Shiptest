#define TWO_POINT_DISTANCE(xa,ya,xb,yb) sqrt(((yb-ya)**2) + ((xa-xb)**2))
#define TWO_POINT_DISTANCE_OV(o1,o2) TWO_POINT_DISTANCE(o1.x,o1.y,o2.x,o2.y)
#define IN_LOCK_RANGE(o1,o2) (TWO_POINT_DISTANCE_OV(o1,o2) <= OVERMAP_LOCK_RANGE) //i don't know what this does. but i had to port this over to make this code work. someone please tell me what this does and whether it's OK to use here.

/datum/ambience_controller
	/// Client we play things to and respects prefs of
	var/client/client
	/// Next time we shall play area ambience at
	var/next_area_ambience = 0
	/// When do we call the updates for area and ship ambience handling
	var/next_area_handling = 0

	var/current_main_area_ambience

	/// Preference variables
	var/pref_ship_ambience = TRUE
	var/pref_area_ambience = TRUE
	var/pref_object_ambience = TRUE

	var/sound/ship_ambience_sound
	var/ship_ambience_volume = 0

	var/mob_x
	var/mob_y
	var/mob_z

	var/mob_pressure_factor = 1

	var/last_mob_positions_update = 0
	var/needs_position_updates = FALSE

	var/list/current_area_ambient_noises

	/// Time until the next object sweep for scheduling played object ambience
	var/next_object_sweep = 0
	/// Fast ref to the list with ambient datums
	var/static/list/ambient_sounds
	/// A list of lists of cooldowns per emitters to our ambient sounds
	var/list/ambience_cooldowns[TOTAL_AMBIENT_SOUNDS]
	/// Queued object ambiences that we process
	var/list/queued_object_ambience = list()
	/// List of free channels for playing ambient sounds
	var/list/free_channels = list()
	/// List of sounds we're currently managing. They will take up channels and free them when they end
	var/list/managed_sounds = list()

/datum/ambience_controller/New(client/applied_client)
	. = ..()
	for(var/i in CHANNEL_AMBIENT_SOUNDS_START to CHANNEL_AMBIENT_SOUNDS_END)
		free_channels+= i
	if(!ambient_sounds)
		ambient_sounds = SSambience.ambient_sounds
	ship_ambience_sound = new('sound/ambience/shipambience.ogg', repeat = TRUE, wait = 0, volume = 0, channel = CHANNEL_BUZZ)
	client = applied_client
	SEND_SOUND(client, ship_ambience_sound)
	SSambience.ambience_controller_list += src
	client_pref_update()

/datum/ambience_controller/Destroy()
	client = null
	SSambience.ambience_controller_list -= src
	return ..()

/datum/ambience_controller/process()
	var/mob/client_mob = client.mob
	// Dont try and play ambience for new players
	if(isnewplayer(client_mob))
		return
	if(next_area_handling <= world.time)
		next_area_handling = world.time + 1 SECONDS
		handle_area_ambience(client_mob)
		handle_ship_ambience(client_mob)
	if(next_object_sweep <= world.time)
		handle_object_sweep(client_mob)
	handle_managed_ambience(client_mob)
	handle_object_ambience(client_mob)

/datum/ambience_controller/proc/handle_area_ambience(mob/client_mob)
	if(!pref_area_ambience)
		return
	var/area/current_area = get_area(client_mob)
	var/new_main_ambience = current_area.main_ambience
	var/list/new_area_ambient_noises = current_area.ambient_noises
	if(new_main_ambience != current_main_area_ambience)
		if(current_main_area_ambience)
			set_target_volume_for_ambience_id(current_main_area_ambience, 0)
		if(current_area_ambient_noises)
			for(var/noise in current_area_ambient_noises)
				set_target_volume_for_ambience_id(noise, 0)
		current_main_area_ambience = new_main_ambience
		if(current_main_area_ambience)
			set_target_volume_for_ambience_id(current_main_area_ambience, 1)

		if(new_area_ambient_noises)
			for(var/noise in new_area_ambient_noises)
				set_target_volume_for_ambience_id(noise, 1)

		if(new_area_ambient_noises)
			add_area_noises_cooldowns(new_area_ambient_noises)
	if(current_main_area_ambience)
		var/datum/ambient_sound/sound_datum = ambient_sounds[current_main_area_ambience]
		try_invoke_ambient_sound(current_main_area_ambience, null, sound_datum)

	current_area_ambient_noises = new_area_ambient_noises

	if(current_area_ambient_noises)
		for(var/noise in current_area_ambient_noises)
			var/datum/ambient_sound/sound_datum = ambient_sounds[noise]
			try_invoke_ambient_sound(noise, null, sound_datum)

/// Adds cooldowns to non looping ambient noises of the area as we enter it
/datum/ambience_controller/proc/add_area_noises_cooldowns(list/noises)
	var/world_time = world.time
	for(var/noise in noises)
		var/datum/ambient_sound/sound_datum = ambient_sounds[noise]
		if(sound_datum.loops)
			continue
		var/list/cooldown_list = ambience_cooldowns[noise]
		if(!cooldown_list)
			ambience_cooldowns[noise] = cooldown_list = list()
		for(var/i in 1 to sound_datum.maximum_emitters)
			var/frequency_time = sound_datum.frequency_time_high ? rand(sound_datum.frequency_time, sound_datum.frequency_time_high) : sound_datum.frequency_time
			if(cooldown_list.len < i)
				cooldown_list += world_time + frequency_time
			else
				cooldown_list[i] = world_time + frequency_time

/// Sets the target volumes for currently playing ambiences of an ID
/datum/ambience_controller/proc/set_target_volume_for_ambience_id(ambience_id, target_volume)
	for(var/datum/managed_ambience/managed as anything in managed_sounds)
		if(managed.ambience_id == ambience_id)
			managed.target_volume_multiplier = target_volume

/datum/ambience_controller/proc/handle_ship_ambience(mob/client_mob)
	var/area/current_area = get_area(client_mob)
	var/should_play_ship_ambience = (pref_ship_ambience && !current_area.outdoors)
	if(ship_ambience_volume == should_play_ship_ambience)
		return
	if(should_play_ship_ambience)
		ship_ambience_volume = min(ship_ambience_volume + 0.2, 1)
	else
		ship_ambience_volume = max(ship_ambience_volume - 0.2, 0)
	if(ship_ambience_volume <= 0)
		ship_ambience_sound.status = SOUND_UPDATE | SOUND_MUTE
	else
		ship_ambience_sound.status = SOUND_UPDATE
	ship_ambience_sound.volume = ship_ambience_volume * SHIP_AMBIENCE_VOLUME
	SEND_SOUND(client, ship_ambience_sound)

/// When our client pref gets updated.
/datum/ambience_controller/proc/client_pref_update()
	var/datum/preferences/prefs = client.prefs
	var/mob/client_mob = client.mob

	pref_ship_ambience = (prefs.toggles & SOUND_SHIP_AMBIENCE)
	pref_area_ambience = (prefs.toggles & SOUND_AMBIENCE)
	pref_object_ambience = TRUE

	if(isnewplayer(client_mob))
		return

	handle_area_ambience(client_mob)
	handle_ship_ambience(client_mob)

/datum/ambience_controller/proc/clear_cooldowns()
	///Clear existing cooldowns
	var/i = 0
	var/world_time = world.time
	for(var/list/cooldown_list as anything in ambience_cooldowns)
		i++
		if(!cooldown_list)
			continue
		for(var/cooldown in cooldown_list)
			if(cooldown <= world_time)
				cooldown_list -= cooldown
		if(!cooldown_list.len)
			ambience_cooldowns[i] = null

// This proc goes hard feel free to copy
// This proc is very complex and does 3 important tasks:
// 1. Goes over the cooldown list for ambience emitters and clears any ones that have passed, unsetting empty lists too
// 2. Sweeps a range of nearby turfs to get new ambiences
// 3. Iterates over all new ambiences and checks if it can be played, setting the appropriate cooldowns (The cooldown setting is rather complex)
/datum/ambience_controller/proc/handle_object_sweep(mob/client_mob)
	next_object_sweep = world.time + AMBIENCE_SWEEP_TIME
	if(!pref_object_ambience)
		return

	clear_cooldowns()

	///Do a sweep
	var/turf/mob_turf = get_turf(client_mob)
	if(!mob_turf)
		return
	var/list/found_ambience = list()
	for(var/turf/nearby_turf as anything in RANGE_TURFS(MAX_AMBIENCE_RANGE, mob_turf))
		if(nearby_turf.ambience)
			found_ambience += new /datum/ambience_sort(nearby_turf.ambience, nearby_turf, TWO_POINT_DISTANCE(nearby_turf.x, nearby_turf.y, mob_turf.x, mob_turf.y))
		if(nearby_turf.ambience_list)
			for(var/ambience in nearby_turf.ambience_list)
				found_ambience += new /datum/ambience_sort(ambience, nearby_turf, TWO_POINT_DISTANCE(nearby_turf.x, nearby_turf.y, mob_turf.x, mob_turf.y))
	if(!found_ambience.len)
		return
	/// Sort by distance
	sortTim(found_ambience, cmp=/proc/cmp_ambience_dist_asc)

	/// Try and queue the ambiences we have found
	var/list/cached_ambience_sounds = ambient_sounds
	var/list/barred_ambience
	for(var/datum/ambience_sort/ambience_sort in found_ambience)
		var/ambience = ambience_sort.ambience_id
		var/datum/ambient_sound/sound_datum = cached_ambience_sounds[ambience]
		if(barred_ambience && (ambience in barred_ambience))
			continue
		/// Consider if it's out of the range.
		if(ambience_sort.dist > sound_datum.range)
			continue
		if(!try_invoke_ambient_sound(ambience, ambience_sort.source_turf, sound_datum))
			LAZYINITLIST(barred_ambience)
			barred_ambience += ambience

/datum/ambience_controller/proc/try_invoke_ambient_sound(ambience, turf/ambience_turf, datum/ambient_sound/sound_datum)
	var/world_time = world.time //faster access I think????
	var/frequency_time = sound_datum.frequency_time_high ? rand(sound_datum.frequency_time, sound_datum.frequency_time_high) : sound_datum.frequency_time
	var/list/cooldown_list = ambience_cooldowns[ambience]
	var/cooldown_list_index = 1
	var/cooldown_time_to_set = world_time + frequency_time
	/// Check the cooldown in the cooldown lists
	var/wait_time = world_time
	if(cooldown_list)
		// We have a free spot in the emitter list, add a new cooldown.
		if(cooldown_list.len < sound_datum.maximum_emitters)
			cooldown_list += 0
			cooldown_list_index = cooldown_list.len
		// If we don't, we try and queue
		else
			cooldown_list_index = 0
			var/found_any = FALSE
			/// Iterate over all cooldowns and see if we can play a sound in the next 5s (AMBIENCE_QUEUE_TIME)
			for(var/current_cooldown in cooldown_list)
				cooldown_list_index++
				if(current_cooldown < world_time + AMBIENCE_QUEUE_TIME)
					found_any = TRUE
					wait_time = current_cooldown
					cooldown_time_to_set = current_cooldown + frequency_time
					break
			if(!found_any)
				// We cant find any ambience that can be played within 5s
				return FALSE
	/// If there isn't a cooldown list, free to assume we can create a new cooldown.
	else
		ambience_cooldowns[ambience] = cooldown_list = list()
		cooldown_list += 0

	/// While the next played ambience would have to happen before the next queue, add another queued sound and increment cooldown approprietly
	while(cooldown_time_to_set < world_time + AMBIENCE_QUEUE_TIME)
		invoke_ambient_sound(ambience, ambience_turf, cooldown_time_to_set, cooldown_list_index, sound_datum)
		cooldown_time_to_set = cooldown_time_to_set + frequency_time
	/// Set the cooldown and add a queued sound.
	cooldown_list[cooldown_list_index] = cooldown_time_to_set
	invoke_ambient_sound(ambience, ambience_turf, wait_time, cooldown_list_index, sound_datum)
	/// If there is a cooldown between emitters, populate the cooldown list and fill them all with the cooldown
	if(sound_datum.cooldown_between_emitters)
		var/beetween_cooldown = world_time + sound_datum.cooldown_between_emitters
		cooldown_list_index = 0
		for(var/cooldown in cooldown_list)
			cooldown_list_index++
			if(cooldown < beetween_cooldown)
				cooldown_list[cooldown_list_index] = beetween_cooldown
		while(cooldown_list.len < sound_datum.maximum_emitters)
			cooldown_list += beetween_cooldown
	return TRUE

/datum/ambience_controller/proc/invoke_ambient_sound(ambience_id, ambience_turf, wait_time, emitter_index, datum/ambient_sound/sound_datum)
	//If it loops, try and find existing playing managed sound and up its duration instead
	if(sound_datum.loops)
		for(var/datum/managed_ambience/managed as anything in managed_sounds)
			if(managed.ambience_id == ambience_id && managed.emitter_index == emitter_index)
				managed.play_until = wait_time + sound_datum.sound_length
				managed.set_turf(ambience_turf)
				managed.target_volume_multiplier = 1
				return
	queued_object_ambience += new /datum/ambience_queued(ambience_id, ambience_turf, wait_time, emitter_index)

#define AMBIENCE_RANGE_LEISURE 1

/datum/ambience_controller/proc/handle_object_ambience(mob/client_mob)
	update_mob_positions(client_mob)
	for(var/datum/ambience_queued/qued_ambience as anything in queued_object_ambience)
		if(qued_ambience.play_when > world.time)
			continue
		queued_object_ambience -= qued_ambience
		var/datum/ambient_sound/sound_datum = ambient_sounds[qued_ambience.ambience_id]
		/// Once again, checking the distance, but adding 1 for extra leisure to not cancel too many queued ambiences
		if(qued_ambience.play_turf)
			var/turf/mob_turf = get_turf(client_mob)
			if(get_dist(qued_ambience.play_turf, mob_turf) > sound_datum.range + AMBIENCE_RANGE_LEISURE)
				continue
		play_ambience_sound(client_mob, qued_ambience.play_turf, sound_datum, qued_ambience.emitter_index)

#undef AMBIENCE_RANGE_LEISURE

/datum/ambience_controller/proc/play_ambience_sound(mob/client_mob, turf/play_turf, datum/ambient_sound/sound_datum, emitter_index)
	var/sound_to_use = pick(sound_datum.sounds)
	var/channel = get_free_channel()

	var/sound/sound = sound(sound_to_use)
	sound.wait = FALSE
	sound.channel = channel
	sound.repeat = sound_datum.loops
	if(sound_datum.vary)
		sound.frequency = get_rand_frequency()
	if(play_turf)
		sound.falloff = MAX_DISTANCE_AMBIENCE_SOUND

	var/datum/managed_ambience/managed_sound = new /datum/managed_ambience(emitter_index, sound_datum.id, sound, channel, play_turf, sound_datum.sound_length)
	managed_sound.update_position_and_pressure_factor(mob_pressure_factor, mob_x, mob_y, sound_datum)
	managed_sound.update_volume(sound_datum)
	managed_sounds += managed_sound

	SEND_SOUND(client_mob, sound)
	sound.status = SOUND_UPDATE

/datum/ambience_controller/proc/handle_managed_ambience(mob/client_mob)
	update_mob_positions(client_mob)
	for(var/datum/managed_ambience/managed as anything in managed_sounds)
		/// If a sound is expired, free it's channel and remove it.
		if(managed.play_until <= world.time)
			if(managed.loops)
				client_mob.stop_sound_channel(managed.channel)
			free_channel(managed.channel)
			managed_sounds -= managed
			continue
		var/turf/play_turf = managed.source_turf
		/// Sound is not expired and has a turf. Update it's xyz position and volume
		var/datum/ambient_sound/sound_datum = ambient_sounds[managed.ambience_id]
		var/position_update = (needs_position_updates && play_turf)
		if(position_update)
			managed.update_position_and_pressure_factor(mob_pressure_factor, mob_x, mob_y, sound_datum)

		if(!managed.update_volume(sound_datum) && !position_update)
			continue

		SEND_SOUND(client_mob, managed.sound)
	needs_position_updates = FALSE

/// Returns TRUE if updated anything, FALSE if not
/datum/ambience_controller/proc/update_mob_positions(mob/client_mob)
	if(last_mob_positions_update == world.time)
		return FALSE
	last_mob_positions_update = world.time
	var/turf/mob_turf = get_turf(client_mob)
	if(!mob_turf)
		return FALSE
	if(mob_turf.x == mob_x && mob_turf.y == mob_y && mob_turf.z == mob_z)
		return FALSE
	mob_x = mob_turf.x
	mob_y = mob_turf.y
	mob_z = mob_turf.z

	/// This will not be updated if the user position does not change, but that's fine.
	mob_pressure_factor = 1
	var/datum/gas_mixture/source_env = mob_turf.return_air()
	if(source_env)
		var/pressure = source_env.return_pressure()
		if(pressure < ONE_ATMOSPHERE)
			mob_pressure_factor = max((pressure - SOUND_MINIMUM_PRESSURE)/(ONE_ATMOSPHERE - SOUND_MINIMUM_PRESSURE), 0)
	needs_position_updates = TRUE
	return TRUE

/// Takes a free channel from the pool of remaining channels. Null if none left
/datum/ambience_controller/proc/get_free_channel()
	if(!free_channels.len)
		return
	var/channel = free_channels[free_channels.len]
	free_channels.len--
	return channel

/// Frees a once taken channel
/datum/ambience_controller/proc/free_channel(channel_to_free)
	free_channels += channel_to_free

/// Struct-like datum that holds information about the queued ambience sound
/datum/ambience_queued
	/// What kind of ambience sound we shall play?
	var/ambience_id
	/// Which turf we will play the sound on?
	var/turf/play_turf
	/// When do we play the sound?
	var/play_when

	var/emitter_index

/datum/ambience_queued/New(passed_id, passed_turf, passed_when, passed_emitter)
	ambience_id = passed_id
	play_turf = passed_turf
	play_when = passed_when
	emitter_index = passed_emitter

/// Struct-like datum that holds information about the currently played sound
/datum/managed_ambience
	/// Index of our emitter
	var/emitter_index
	/// What kind of ambience sound we shall play?
	var/ambience_id
	/// Our sound datum
	var/sound/sound
	/// Channel we are playing on
	var/channel
	/// Which turf we will play the sound on?
	var/turf/source_turf
	/// When do we stop playing the sound
	var/play_until
	/// Whether the managed sound loops
	var/loops = FALSE
	/// Pressure factor for calculating volume
	var/pressure_factor = 1

	var/calculated_pressure_factor = 1

	var/position_volume_penalty = 0
	var/old_volume

	var/volume_multiplier = 1
	var/target_volume_multiplier = 1

/datum/managed_ambience/New(emitter_index, ambience_id, sound/sound, channel, source_turf, sound_length)
	src.emitter_index = emitter_index
	src.ambience_id = ambience_id
	src.sound = sound
	src.loops = sound.repeat
	src.channel = channel
	src.play_until = world.time + sound_length
	set_turf(source_turf)

/datum/managed_ambience/proc/set_turf(turf/turf_to_set)
	if(!turf_to_set)
		return
	source_turf = turf_to_set
	pressure_factor = 1
	var/datum/gas_mixture/source_env = source_turf.return_air()
	if(source_env)
		var/pressure = source_env.return_pressure()
		if(pressure < ONE_ATMOSPHERE)
			pressure_factor = max((pressure - SOUND_MINIMUM_PRESSURE)/(ONE_ATMOSPHERE - SOUND_MINIMUM_PRESSURE), 0)

/datum/managed_ambience/proc/update_position_and_pressure_factor(mob_pressure_factor, mob_x, mob_y, datum/ambient_sound/sound_datum)
	if(!mob_x || !source_turf)
		return
	var/sound/local_sound = sound

	var/volume = sound_datum.volume
	var/falloff_exponent = sound_datum.falloff_exponent
	var/falloff_distance = sound_datum.falloff_distance

	var/distance = TWO_POINT_DISTANCE(source_turf.x,source_turf.y,mob_x,mob_y)

	var/max_distance = MAX_DISTANCE_AMBIENCE_SOUND

	position_volume_penalty = (max(distance - falloff_distance, 0) ** (1 / sound_datum.falloff_exponent)) / ((max(max_distance, distance) - falloff_distance) ** (1 / falloff_exponent)) * volume
	local_sound.x = source_turf.x - mob_x // Hearing from the right/left
	local_sound.z = source_turf.y - mob_y // Hearing from infront/behind

	var/local_pressure_factor = min(pressure_factor, mob_pressure_factor)
	if(distance <= 1.5)
		local_pressure_factor = max(pressure_factor, 0.2)

	calculated_pressure_factor = local_pressure_factor

/datum/managed_ambience/proc/update_volume(datum/ambient_sound/sound_datum)
	var/target_volume = (sound_datum.volume - position_volume_penalty) * calculated_pressure_factor
	if(volume_multiplier != target_volume_multiplier)
		if(volume_multiplier < target_volume_multiplier)
			volume_multiplier = min(target_volume_multiplier, volume_multiplier + 0.15)
		else
			volume_multiplier = max(target_volume_multiplier, volume_multiplier - 0.15)
	target_volume *= volume_multiplier
	if(target_volume == old_volume)
		return FALSE
	old_volume = target_volume
	sound.volume = target_volume
	return TRUE

/// Structlike datum for sorting ambience
/datum/ambience_sort
	var/ambience_id
	var/turf/source_turf
	var/dist

/datum/ambience_sort/New(ambience_id, source_turf, dist)
	src.ambience_id = ambience_id
	src.source_turf = source_turf
	src.dist = dist
