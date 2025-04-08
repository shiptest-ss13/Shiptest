/datum/weather/rain
	name = "rain"
	desc = "Rain falling down the surface."

	telegraph_message = span_notice("Dark clouds hover above and you feel humidity in the air..")
	telegraph_duration = 300

	weather_message = span_notice("Rain starts to fall down..")
	weather_overlay = "rain"
	weather_duration_lower = 600
	weather_duration_upper = 1500

	end_duration = 100
	end_message = span_notice("The rain stops...")

	area_type = /area
	protect_indoors = TRUE
	barometer_predictable = TRUE
	affects_underground = FALSE
	aesthetic = TRUE

	sound_active_outside = /datum/looping_sound/weather/rain/indoors
	sound_active_inside = /datum/looping_sound/weather/rain

	fire_suppression = 6

/datum/weather/rain/heavy
	name = "heavy rain"
	desc = "Downpour of rain."

	telegraph_message = span_notice("Rather suddenly, clouds converge and tear into rain..")
	telegraph_overlay = "rain"

	weather_message = span_notice("The rain turns into a downpour..")
	weather_overlay = "storm"

	end_message = span_notice("The downpour dies down...")
	end_overlay = "rain"

	sound_active_outside = /datum/looping_sound/weather/rain/indoors
	sound_active_inside = /datum/looping_sound/weather/rain
	sound_weak_outside = /datum/looping_sound/weather/rain/indoors
	sound_weak_inside = /datum/looping_sound/weather/rain

	fire_suppression = 8
	thunder_chance = 2

/datum/weather/rain/heavy/storm
	name = "storm"
	desc = "Storm with rain and lightning."
	weather_message = span_warning("The clouds blacken and the sky starts to flash as thunder strikes down!")
	fire_suppression = 12
	thunder_chance = 10

/datum/weather/rain/heavy/storm_intense
	name = "storm"
	desc = "Storm with rain and lightning."
	weather_overlay = "storm_very"
	thunder_chance = 20
	weather_color = "#a3daf7"
	weather_duration_lower = 420690
	weather_duration_upper = 420690
	fire_suppression = 16

	sound_active_outside = /datum/looping_sound/weather/rain/storm/indoors
	sound_active_inside = /datum/looping_sound/weather/rain/storm
	sound_weak_outside = /datum/looping_sound/weather/rain/storm/indoors
	sound_weak_inside = /datum/looping_sound/weather/rain/storm
