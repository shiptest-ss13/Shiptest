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
	// living mobs left to check this cycle
	var/list/mobs_to_check = list()

/datum/controller/subsystem/weather/fire(resumed)
	if(!resumed)
		var/any_weather_acting = FALSE
		for(var/datum/weather_controller/iterated_controller as anything in weather_controllers)
			iterated_controller.process(wait * 0.1)
			if(!any_weather_acting && iterated_controller.has_acting_weather())
				any_weather_acting = TRUE
		if(!any_weather_acting)
			return
		mobs_to_check = GLOB.mob_living_list.Copy()

	// one pass over all mobs, rather than one pass per active weather
	while(length(mobs_to_check))
		var/mob/living/living_mob = mobs_to_check[length(mobs_to_check)]
		mobs_to_check.len--
		if(!QDELETED(living_mob))
			apply_weather(living_mob)
		if(MC_TICK_CHECK)
			return

/datum/controller/subsystem/weather/proc/apply_weather(mob/living/living_mob)
	var/turf/mob_turf = get_turf(living_mob)
	if(!mob_turf)
		return
	var/datum/virtual_level/mob_level = mob_turf.get_virtual_level()
	var/datum/weather_controller/zone_controller = mob_level?.parent_map_zone?.weather_controller
	if(!zone_controller?.current_weathers)
		return
	for(var/weather_type in zone_controller.current_weathers)
		var/datum/weather/active_weather = zone_controller.current_weathers[weather_type]
		if(active_weather.aesthetic || active_weather.stage != MAIN_STAGE)
			continue
		if(active_weather.can_weather_act(living_mob))
			active_weather.weather_act(living_mob)

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
