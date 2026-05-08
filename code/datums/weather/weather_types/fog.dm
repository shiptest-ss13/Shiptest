/datum/weather/thousand_eyes_fog
	name = "fog"
	desc = "Fog clouds rolling in, blocking vision."
	opacity_in_main_stage = TRUE
	thunder_chance = 0

	telegraph_message = span_danger("Fog starts to roll in through the gravitic bubble...")
	telegraph_overlay = "smoke"

	area_type = /area
	protect_indoors = TRUE

	barometer_predictable = FALSE
	affects_underground = FALSE
	thunder_chance = 14

	weather_duration_lower = 900
	weather_duration_upper = 1500

	multiply_blend_on_main_stage = TRUE

	weather_message = span_boldwarning("Thick fog has set in around the perch!")
	weather_overlay = "smoke"

	end_message = span_notice("The fog starts to dissipate..")
	end_overlay = "smoke"
