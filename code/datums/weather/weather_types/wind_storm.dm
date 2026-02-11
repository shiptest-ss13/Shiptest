/datum/weather/thousand_eyes
	name = "Wind Storm"
	desc = "Zap."

	telegraph_message = span_danger("The wind battering the platform begin to pick up...")
	telegraph_duration = 300
	telegraph_overlay = ""

	weather_message = span_userdanger("Gusts of wind start to batter the gravitic bubble!")
	weather_overlay = ""
	weather_duration_lower = 600
	weather_duration_upper = 1500

	end_duration = 100
	end_message =span_notice("The wind slowly passes by")
	end_overlay = ""

	area_type = /area
	protect_indoors = TRUE

	barometer_predictable = FALSE
	affects_underground = FALSE
	thunder_chance = 14

	sound_active_outside = /datum/looping_sound/weather/wind/indoors
	sound_active_inside = /datum/looping_sound/weather/wind
	sound_weak_outside = /datum/looping_sound/weather/wind/indoors
	sound_weak_inside = /datum/looping_sound/weather/wind

	multiply_blend_on_main_stage = TRUE
