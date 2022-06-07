/datum/weather/snowfall
	name = "snowfall"
	desc = "Harmless snow particles showering the surface."

	telegraph_message = "<span class='notice'>Drifting particles of snow begin to dust the surrounding area..</span>"
	telegraph_duration = 300
	telegraph_overlay = "snowfall_light"

	weather_message = "<span class='notice'>Soft and puffy snow falls down on the surface, creating a layer of snow..</span>"
	weather_overlay = "snowfall_med"
	weather_duration_lower = 600
	weather_duration_upper = 1500

	end_duration = 100
	end_message = "<span class='notice'>The snowfall stops...</span>"

	area_type = /area
	protect_indoors = TRUE
	barometer_predictable = TRUE
	affects_underground = FALSE
	aesthetic = TRUE

/datum/weather/snowfall/heavy
	name = "heavy snowfall"
	desc = "Heavy amounts of snow raining down."

	telegraph_message = "<span class='notice'>Rather suddenly, snow starts raining down..</span>"
	telegraph_overlay = "snowfall_med"

	weather_message = "<span class='danger'>The snowfall turns into a blizzard..</span>"
	weather_overlay = "snowfall_heavy"

	end_overlay = "light_snow"
	end_message = "<span class='notice'>The blizzard dies down...</span>"

	sound_active_outside = /datum/looping_sound/weather/wind/indoors
	sound_active_inside = /datum/looping_sound/weather/wind
	sound_weak_outside = /datum/looping_sound/weather/wind/indoors
	sound_weak_inside = /datum/looping_sound/weather/wind

	immunity_type = "snow"
	aesthetic = FALSE
	thunder_chance = 2

/datum/weather/snowfall/heavy/weather_act(mob/living/living_mob)
	living_mob.adjust_bodytemperature(-rand(2,4))
