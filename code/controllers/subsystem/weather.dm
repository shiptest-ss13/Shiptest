#define STARTUP_STAGE 1
#define MAIN_STAGE 2
#define WIND_DOWN_STAGE 3
#define END_STAGE 4

//Used for all kinds of weather, ex. lavaland ash storms.
SUBSYSTEM_DEF(weather)
	name = "Weather"
	flags = SS_BACKGROUND
	wait = 10
	runlevels = RUNLEVEL_GAME
	var/list/weather_controllers = list()

/datum/controller/subsystem/weather/fire()
	// process active weather controllers
	for(var/i in weather_controllers)
		var/datum/weather_controller/iterated_controller = i
		iterated_controller.process()

/datum/controller/subsystem/weather/proc/get_all_current_weather()
	var/list/returned_weathers = list()
	for(var/i in weather_controllers)
		var/datum/weather_controller/iterated_controller = i
		if(iterated_controller.current_weathers)
			for(var/b in iterated_controller.current_weathers)
				returned_weathers += iterated_controller.current_weathers[b]
	return returned_weathers
