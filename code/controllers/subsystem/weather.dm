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
	// controllers with acting weather, indexed by virtual z
	var/list/acting_controllers_by_virtual_z = list()
	// each mob gets weather once every this many fires, with amounts scaled up to match
	var/mob_interval = 2
	// which slice of the mob list this fire handles
	var/mob_slice = 0

/datum/controller/subsystem/weather/fire(resumed)
	if(!resumed)
		acting_controllers_by_virtual_z = list()
		for(var/datum/weather_controller/iterated_controller as anything in weather_controllers)
			iterated_controller.process(wait * 0.1)
			if(!iterated_controller.has_acting_weather())
				continue
			for(var/datum/virtual_level/zone_level as anything in iterated_controller.mapzone.virtual_levels)
				if(zone_level.id > length(acting_controllers_by_virtual_z))
					acting_controllers_by_virtual_z.len = zone_level.id
				acting_controllers_by_virtual_z[zone_level.id] = iterated_controller
		if(!length(acting_controllers_by_virtual_z))
			return
		// a different slice each fire spreads the load evenly
		mob_slice = (mob_slice % mob_interval) + 1
		var/list/all_mobs = GLOB.mob_living_list
		mobs_to_check = list()
		for(var/mob_index in mob_slice to length(all_mobs) step mob_interval)
			mobs_to_check += all_mobs[mob_index]

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
	var/mob_virtual_z = mob_turf.virtual_z
	if(mob_virtual_z < 1 || mob_virtual_z > length(acting_controllers_by_virtual_z))
		return
	var/datum/weather_controller/zone_controller = acting_controllers_by_virtual_z[mob_virtual_z]
	if(!zone_controller?.current_weathers)
		return
	var/seconds_per_tick = mob_interval * wait * 0.1
	for(var/weather_type in zone_controller.current_weathers)
		var/datum/weather/active_weather = zone_controller.current_weathers[weather_type]
		if(active_weather.aesthetic || active_weather.stage != MAIN_STAGE)
			continue
		// area check first, some affects() are costly
		if(active_weather.can_weather_act(living_mob) && active_weather.affects(living_mob))
			active_weather.weather_act(living_mob, seconds_per_tick)

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
