/datum/weather_controller
	/// What possible weather types will be rolled naturally here, assoc list of type to weight. You'll still be able to call different weathers by events and such
	var/list/possible_weathers
	/// The lowest interval between one naturally occuring weather and another
	var/wait_interval_low = 6.5 MINUTES
	/// The highest interval between one naturally occuring weather and another
	var/wait_interval_high = 13.5 MINUTES
	/// What will be the next weather type rolled, rolled before initializing it for barometers
	var/next_weather_type
	/// When will the next weather will be rolled, also read by barometers
	var/next_weather = 0
	/// Current weathers this controller is handling. Associative of type to reference
	var/list/current_weathers
	/// The linked map zone of our controller
	var/datum/map_zone/mapzone
	/// Percentage of how much we're blocking the sky, for the day/night controller to read from
	var/skyblock = 0
	/// A simple cache to make sure we dont call updates with no changes
	var/last_checked_skyblock = 0

/datum/weather_controller/New(datum/map_zone/passed_mapzone)
	. = ..()
	mapzone = passed_mapzone
	mapzone.weather_controller = src
	SSweather.weather_controllers += src
	roll_next_weather()

/datum/weather_controller/proc/UpdateSkyblock()
	if(skyblock == last_checked_skyblock)
		return
	last_checked_skyblock = skyblock

/// In theory this should never be destroyed, unless you plan to dynamically change existing z levels
/datum/weather_controller/Destroy()
	mapzone.weather_controller = null
	mapzone = null
	if(current_weathers)
		for(var/i in current_weathers)
			var/datum/weather/W = i
			W.end()
	SSweather.weather_controllers -= src
	return ..()

/datum/weather_controller/process()
	if(current_weathers)
		for(var/i in current_weathers)
			var/datum/weather/W = current_weathers[i]
			W.process()
	if(possible_weathers && world.time > next_weather)
		run_weather(next_weather_type)
		roll_next_weather()

/datum/weather_controller/proc/roll_next_weather()
	if(!possible_weathers)
		return
	next_weather = world.time + rand(wait_interval_low, wait_interval_high)
	next_weather_type = pickweight(possible_weathers)

/datum/weather_controller/proc/run_weather(datum/weather/weather_datum_type, telegraph = TRUE)
	if(!ispath(weather_datum_type, /datum/weather))
		CRASH("run_weather called with invalid weather_datum_type: [weather_datum_type || "null"]")
	LAZYINITLIST(current_weathers)
	if(current_weathers[weather_datum_type])
		CRASH("run_weather tried to create a weather that was already simulated")
	var/datum/weather/weather = new weather_datum_type(src)
	if(telegraph)
		weather.telegraph()
	return weather
