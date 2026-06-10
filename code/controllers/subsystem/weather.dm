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
	var/list/current_run = list()

/datum/controller/subsystem/weather/fire(resumed = FALSE)
	if (!resumed)
		src.current_run = weather_controllers.Copy()

	//cache for sanic speed (lists are references anyways)
	var/list/current_run = src.current_run

	// process active weather controllers
	while(current_run.len)
		var/datum/weather_controller/iterated_controller = current_run[current_run.len]
		iterated_controller.process(wait * 0.1)

		if (MC_TICK_CHECK)
			return

/datum/controller/subsystem/weather/proc/get_all_current_weather()
	var/list/returned_weathers = list()
	for(var/datum/weather_controller/iterated_controller as anything in weather_controllers)
		if(iterated_controller.current_weathers)
			for(var/b in iterated_controller.current_weathers)
				returned_weathers += iterated_controller.current_weathers[b]
	return returned_weathers

/datum/controller/subsystem/weather/get_metrics()
	. = ..()
	var/list/cust = list()
	cust["processing"] = 0
	for(var/datum/weather_controller/iterated_controller as anything in weather_controllers)
		cust["processing"] += length(iterated_controller.current_weathers)
	.["custom"] = cust
