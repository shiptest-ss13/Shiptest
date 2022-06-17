/datum/weather/hailstorm
	name = "hailstorm"
	desc = "Harsh hailstorm, battering the unfortunate who wound up in it."

	telegraph_message = "<span class='danger'>Dark clouds converge as drifting particles of snow begin to dust the surrounding area..</span>"
	telegraph_duration = 300
	telegraph_overlay = "snowfall_light"

	weather_message = "<span class='userdanger'><i>Hail starts to rain down from the sky! Seek shelter!</i></span>"
	weather_overlay = "hail"
	weather_duration_lower = 600
	weather_duration_upper = 1500

	end_duration = 100
	end_message = "<span class='notice'>The hailstorm dies down, it should be safe to go outside again.</span>"

	area_type = /area
	protect_indoors = TRUE

	immunity_type = "snow"

	barometer_predictable = TRUE
	affects_underground = FALSE
	thunder_chance = 4

	sound_active_outside = /datum/looping_sound/weather/wind/indoors
	sound_active_inside = /datum/looping_sound/weather/wind
	sound_weak_outside = /datum/looping_sound/weather/wind/indoors
	sound_weak_inside = /datum/looping_sound/weather/wind

/datum/weather/hailstorm/weather_act(mob/living/living_mob)
	/// Think of some good solution of how weather should affect monsters and how they should be resistant to things like this
	if(isanimal(living_mob))
		return
	living_mob.adjust_bodytemperature(-rand(3,6))
	living_mob.adjustBruteLoss(rand(2,4))
