/datum/looping_sound/active_outside_ashstorm
	mid_sounds = list(
		'sound/weather/ashstorm/outside/active_mid_01.ogg'=1,
		'sound/weather/ashstorm/outside/active_mid_02.ogg'=1,
		'sound/weather/ashstorm/outside/active_mid_03.ogg'=1,
		'sound/weather/ashstorm/outside/active_mid_04.ogg'=1,
		'sound/weather/ashstorm/outside/active_mid_05.ogg'=1,
		'sound/weather/ashstorm/outside/active_mid_06.ogg'=1,
		'sound/weather/ashstorm/outside/active_mid_07.ogg'=1,
		'sound/weather/ashstorm/outside/active_mid_08.ogg'=1
		)
	mid_length = 0.8 SECONDS
	start_sound = 'sound/weather/ashstorm/outside/active_start.ogg'
	start_length = 6 SECONDS
	end_sound = 'sound/weather/ashstorm/outside/active_end.ogg'
	volume = 15

/datum/looping_sound/active_inside_ashstorm
	mid_sounds = list(
		'sound/weather/ashstorm/inside/active_inside_mid_01.ogg'=1,
		'sound/weather/ashstorm/inside/active_inside_mid_02.ogg'=1,
		'sound/weather/ashstorm/inside/active_inside_mid_03.ogg'=1,
		'sound/weather/ashstorm/inside/active_inside_mid_04.ogg'=1,
		'sound/weather/ashstorm/inside/active_inside_mid_05.ogg'=1,
		'sound/weather/ashstorm/inside/active_inside_mid_06.ogg'=1,
		'sound/weather/ashstorm/inside/active_inside_mid_07.ogg'=1,
		'sound/weather/ashstorm/inside/active_inside_mid_08.ogg'=1,
		'sound/weather/ashstorm/inside/active_inside_mid_09.ogg'=1
		)
	mid_length = 0.75 SECONDS
	start_sound = 'sound/weather/ashstorm/inside/active_inside_start.ogg'
	start_length = 130
	end_sound = 'sound/weather/ashstorm/inside/active_inside_end.ogg'
	volume = 15

/datum/looping_sound/weak_outside_ashstorm
	mid_sounds = list(
		'sound/weather/ashstorm/outside/weak_mid_01.ogg'=1,
		'sound/weather/ashstorm/outside/weak_mid_02.ogg'=1,
		'sound/weather/ashstorm/outside/weak_mid_03.ogg'=1,
		'sound/weather/ashstorm/outside/weak_mid_04.ogg'=1,
		'sound/weather/ashstorm/outside/weak_mid_05.ogg'=1,
		'sound/weather/ashstorm/outside/weak_mid_06.ogg'=1,
		'sound/weather/ashstorm/outside/weak_mid_07.ogg'=1,
		'sound/weather/ashstorm/outside/weak_mid_08.ogg'=1,
		'sound/weather/ashstorm/outside/weak_mid_09.ogg'=1
		)
	mid_length = 0.85 SECONDS
	start_sound = 'sound/weather/ashstorm/outside/weak_start.ogg'
	start_length = 13 SECONDS
	end_sound = 'sound/weather/ashstorm/outside/weak_end.ogg'
	volume = 15

/datum/looping_sound/weak_inside_ashstorm
	mid_sounds = list(
		'sound/weather/ashstorm/inside/weak_inside_mid_01.ogg'=1,
		'sound/weather/ashstorm/inside/weak_inside_mid_02.ogg'=1,
		'sound/weather/ashstorm/inside/weak_inside_mid_03.ogg'=1,
		'sound/weather/ashstorm/inside/weak_inside_mid_04.ogg'=1,
		'sound/weather/ashstorm/inside/weak_inside_mid_05.ogg'=1,
		'sound/weather/ashstorm/inside/weak_inside_mid_06.ogg'=1,
		'sound/weather/ashstorm/inside/weak_inside_mid_07.ogg'=1,
		'sound/weather/ashstorm/inside/weak_inside_mid_08.ogg'=1,
		'sound/weather/ashstorm/inside/weak_inside_mid_09.ogg'=1
		)
	mid_length = 0.75 SECONDS
	start_sound = 'sound/weather/ashstorm/inside/weak_inside_start.ogg'
	start_length = 130
	end_sound = 'sound/weather/ashstorm/inside/weak_inside_end.ogg'
	volume = 10

/datum/looping_sound/weather/wind
	mid_sounds = list(
		'sound/weather/wind/wind1.ogg' = 1,
		'sound/weather/wind/wind2.ogg' = 1,
		'sound/weather/wind/wind3.ogg' = 1,
		'sound/weather/wind/wind4.ogg' = 1,
		'sound/weather/wind/wind5.ogg' = 1,
		'sound/weather/wind/wind6.ogg' = 1
		)
	mid_length = 10 SECONDS // The lengths for the files vary, but the longest is ten seconds, so this will make it sound like intermittent wind.
	volume = 50

// Don't have special sounds so we just make it quieter indoors.
/datum/looping_sound/weather/wind/indoors
	volume = 30

/datum/looping_sound/weather/rain
	mid_sounds = list(
		'sound/weather/rain/rain_mid_01.ogg' = 1,
		'sound/weather/rain/rain_mid_02.ogg' = 1,
		'sound/weather/rain/rain_mid_03.ogg' = 1,
		'sound/weather/rain/rain_mid_04.ogg' = 1,
		'sound/weather/rain/rain_mid_05.ogg' = 1,
		'sound/weather/rain/rain_mid_06.ogg' = 1
		)
	mid_length = 0.75 SECONDS
	end_sound = 'sound/weather/rain/rain_end.ogg'
	volume = 50
	start_length = 6 SECONDS
	start_sound = 'sound/weather/rain/rain_start.ogg'

/datum/looping_sound/weather/rain/no_start
	start_length = null
	start_sound = null

/datum/looping_sound/weather/rain/indoors
	volume = 30
	mid_sounds = list(
		'sound/weather/rain/rain_inside_mid_01.ogg' = 1,
		'sound/weather/rain/rain_inside_mid_02.ogg' = 1,
		'sound/weather/rain/rain_inside_mid_03.ogg' = 1,
		'sound/weather/rain/rain_inside_mid_04.ogg' = 1,
		'sound/weather/rain/rain_inside_mid_05.ogg' = 1,
		'sound/weather/rain/rain_inside_mid_06.ogg' = 1
		)
	start_sound = 'sound/weather/rain/rain_indoors_start.ogg'
	end_sound = 'sound/weather/rain/rain_indoors_end.ogg'

/datum/looping_sound/weather/rain/weak
	mid_sounds = list(
		'sound/weather/rain/rain_weak_mid_01.ogg' = 1,
		'sound/weather/rain/rain_weak_mid_02.ogg' = 1,
		'sound/weather/rain/rain_weak_mid_03.ogg' = 1,
		'sound/weather/rain/rain_weak_mid_04.ogg' = 1,
		'sound/weather/rain/rain_weak_mid_05.ogg' = 1
		)
	start_sound = 'sound/weather/rain/rain_weak_start.ogg'
	start_length = 12 SECONDS
	volume = 40

/datum/looping_sound/weather/rain/weak/indoors
	mid_sounds = list(
		'sound/weather/rain/rain_weak_inside_mid_01.ogg' = 1,
		'sound/weather/rain/rain_weak_inside_mid_02.ogg' = 1,
		'sound/weather/rain/rain_weak_inside_mid_03.ogg' = 1,
		'sound/weather/rain/rain_weak_inside_mid_04.ogg' = 1,
		'sound/weather/rain/rain_weak_inside_mid_05.ogg' = 1
		)
	start_sound = 'sound/weather/rain/rain_indoors_start.ogg'
	end_sound = 'sound/weather/rain/rain_indoors_end.ogg'

/datum/looping_sound/weather/rain/storm
	mid_sounds = list(
		'sound/weather/rain/storm_outdoors_1.ogg' = 1,
		'sound/weather/rain/storm_outdoors_2.ogg' = 1
		)
	mid_length = 10.03 SECONDS // The lengths for the files vary, but the longest is ten seconds, so this will make it sound like intermittent wind.
	start_sound = 'sound/weather/rain/rain_weak_start.ogg'
	start_length = null
	end_sound = null
	volume = 50

/datum/looping_sound/weather/rain/storm/indoors
	volume = 30
	mid_sounds = list(
		'sound/weather/rain/storm_indoors_1.ogg' = 1,
		'sound/weather/rain/storm_indoors_2.ogg' = 1
		)
	mid_length = 10.03 SECONDS // The lengths for the files vary, but the longest is ten seconds, so this will make it sound like intermittent wind.
	start_sound = 'sound/weather/rain/rain_indoors_start.ogg'
