/proc/time_stamp(format = "YYYY-MM-DD hh:mm:ss", show_ds)
	var/time_string = time2text(world.timeofday, format)
	return show_ds ? "[time_string]:[world.timeofday % 10]" : time_string

/proc/game_timestamp(format = "hh:mm:ss", wtime = world.time)
	return time2text(wtime - GLOB.timezoneOffset, format)

/proc/station_time(display_only = FALSE, wtime = world.time)
	return ((((wtime - SSticker.round_start_time) * SSticker.station_time_rate_multiplier) + SSticker.gametime_offset) % 864000) - (display_only? GLOB.timezoneOffset : 0)

/proc/station_time_timestamp(format = "hh:mm:ss", wtime)
	return time2text(station_time(TRUE, wtime), format)

/proc/station_time_timestamp_fancy(format = "hh:mm", wtime)
	. = station_time_timestamp(format, wtime)
	if(station_time() > 432000)
		. += " PM"
	else
		. += " AM"

/proc/sector_datestamp(realtime = world.realtime, shortened = FALSE)
	//International Fixed Calendar format (https://en.wikipedia.org/wiki/International_Fixed_Calendar)
	var/days_since = round(realtime / (24 HOURS))
	var/year = round(days_since / 365) + 481
	var/day_of_year = days_since % 365
	var/month = round(day_of_year / 28)
	var/day_of_month = day_of_year % 28 + 1

	if(shortened)
		return "[year]-[month]-[day_of_month]FSC"

	var/monthname
	switch(month)
		if(0)
			monthname = "January"
		if(1)
			monthname = "February"
		if(2)
			monthname = "March"
		if(3)
			monthname = "April"
		if(4)
			monthname = "May"
		if(5)
			monthname = "June"
		if(6)
			monthname = "Sol"
		if(7)
			monthname = "July"
		if(8)
			monthname = "August"
		if(9)
			monthname = "September"
		if(10)
			monthname = "October"
		if(11)
			monthname = "November"
		if(12)
			monthname = "December"
		if(13)
			return "Year Day, [year] FSC"

	return "[monthname] [day_of_month], [year] FSC"

//returns timestamp in a sql and a not-quite-compliant ISO 8601 friendly format
/proc/SQLtime(timevar)
	return time2text(timevar || world.timeofday, "YYYY-MM-DD hh:mm:ss")


GLOBAL_VAR_INIT(midnight_rollovers, 0)
GLOBAL_VAR_INIT(rollovercheck_last_timeofday, 0)
/proc/update_midnight_rollover()
	if (world.timeofday < GLOB.rollovercheck_last_timeofday) //TIME IS GOING BACKWARDS!
		GLOB.midnight_rollovers++
	GLOB.rollovercheck_last_timeofday = world.timeofday
	return GLOB.midnight_rollovers

/proc/weekdayofthemonth()
	var/DD = text2num(time2text(world.timeofday, "DD")) 	// get the current day
	switch(DD)
		if(8 to 13)
			return 2
		if(14 to 20)
			return 3
		if(21 to 27)
			return 4
		if(28 to INFINITY)
			return 5
		else
			return 1

//Takes a value of time in deciseconds.
//Returns a text value of that number in hours, minutes, or seconds.
/proc/DisplayTimeText(time_value, round_seconds_to = 0.1)
	var/second = FLOOR(time_value * 0.1, round_seconds_to)
	if(!second)
		return "right now"
	if(second < 60)
		return "[second] second[(second != 1)? "s":""]"
	var/minute = FLOOR(second / 60, 1)
	second = FLOOR(MODULUS(second, 60), round_seconds_to)
	var/secondT
	if(second)
		secondT = " and [second] second[(second != 1)? "s":""]"
	if(minute < 60)
		return "[minute] minute[(minute != 1)? "s":""][secondT]"
	var/hour = FLOOR(minute / 60, 1)
	minute = MODULUS(minute, 60)
	var/minuteT
	if(minute)
		minuteT = " and [minute] minute[(minute != 1)? "s":""]"
	if(hour < 24)
		return "[hour] hour[(hour != 1)? "s":""][minuteT][secondT]"
	var/day = FLOOR(hour / 24, 1)
	hour = MODULUS(hour, 24)
	var/hourT
	if(hour)
		hourT = " and [hour] hour[(hour != 1)? "s":""]"
	return "[day] day[(day != 1)? "s":""][hourT][minuteT][secondT]"


/proc/daysSince(realtimev)
	return round((world.realtime - realtimev) / (24 HOURS))

/// Returns the time in an ISO-8601 friendly format. Used when dumping data into external services such as ElasticSearch
/proc/iso_timestamp(timevar)
	return time2text(timevar || world.timeofday, "YYYY-MM-DDThh:mm:ss")
