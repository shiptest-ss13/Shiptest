/datum/looping_sound/active_outside_ashstorm
	mid_sounds = list(
		'sound/weather/ashstorm/outside/active_mid1.ogg'=1,
		'sound/weather/ashstorm/outside/active_mid1.ogg'=1,
		'sound/weather/ashstorm/outside/active_mid1.ogg'=1
		)
	mid_length = 80
	start_sound = 'sound/weather/ashstorm/outside/active_start.ogg'
	start_length = 130
	end_sound = 'sound/weather/ashstorm/outside/active_end.ogg'
	volume = 40

/datum/looping_sound/active_inside_ashstorm
	mid_sounds = list(
		'sound/weather/ashstorm/inside/active_mid1.ogg'=1,
		'sound/weather/ashstorm/inside/active_mid2.ogg'=1,
		'sound/weather/ashstorm/inside/active_mid3.ogg'=1
		)
	mid_length = 80
	start_sound = 'sound/weather/ashstorm/inside/active_start.ogg'
	start_length = 130
	end_sound = 'sound/weather/ashstorm/inside/active_end.ogg'
	volume = 60

/datum/looping_sound/weak_outside_ashstorm
	mid_sounds = list(
		'sound/weather/ashstorm/outside/weak_mid1.ogg'=1,
		'sound/weather/ashstorm/outside/weak_mid2.ogg'=1,
		'sound/weather/ashstorm/outside/weak_mid3.ogg'=1
		)
	mid_length = 80
	start_sound = 'sound/weather/ashstorm/outside/weak_start.ogg'
	start_length = 130
	end_sound = 'sound/weather/ashstorm/outside/weak_end.ogg'
	volume = 10

/datum/looping_sound/weak_inside_ashstorm
	mid_sounds = list(
		'sound/weather/ashstorm/inside/weak_mid1.ogg'=1,
		'sound/weather/ashstorm/inside/weak_mid2.ogg'=1,
		'sound/weather/ashstorm/inside/weak_mid3.ogg'=1
		)
	mid_length = 80
	start_sound = 'sound/weather/ashstorm/inside/weak_start.ogg'
	start_length = 130
	end_sound = 'sound/weather/ashstorm/inside/weak_end.ogg'
	volume = 40

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
		'sound/ambience/acidrain_mid.ogg' = 1
		)
	mid_length = 15 SECONDS // The lengths for the files vary, but the longest is ten seconds, so this will make it sound like intermittent wind.
	start_sound = 'sound/ambience/acidrain_start.ogg'
	start_length = 13 SECONDS
	end_sound = 'sound/ambience/acidrain_end.ogg'
	volume = 50

/datum/looping_sound/weather/rain/indoors
	volume = 30

/datum/looping_sound/weather/rain/storm
	mid_sounds = list(
		'sound/ambience/storm_outdoors.ogg' = 1
		)
	mid_length = 20.03 SECONDS // The lengths for the files vary, but the longest is ten seconds, so this will make it sound like intermittent wind.
	start_sound = 'sound/ambience/acidrain_start.ogg'
	start_length = null
	end_sound = null
	volume = 50

/datum/looping_sound/weather/rain/storm/indoors
	volume = 30
	mid_sounds = list(
		'sound/ambience/storm_indoors.ogg' = 1
		)
	mid_length = 20.03 SECONDS // The lengths for the files vary, but the longest is ten seconds, so this will make it sound like intermittent wind.
