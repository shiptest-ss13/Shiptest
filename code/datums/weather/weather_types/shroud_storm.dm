/datum/weather/shroud_storm
	name = "shroudstorm"
	desc = "Zap."

	telegraph_message = "<span class='danger'>You hear thunder in the distance, static electricity rising in the air, wind starts to pickup..</span>"
	telegraph_duration = 300
	telegraph_overlay = "electric_ash"

	weather_message = "<span class='userdanger'><i>An electric storm is upon you! Seek shelter!</i></span>"
	weather_overlay = "electric_storm"
	weather_duration_lower = 600
	weather_duration_upper = 1500

	end_duration = 100
	end_message ="<span class='notice'>The storm dissipates.</span>"
	end_overlay = "electric_ash"

	area_type = /area
	protect_indoors = TRUE

	immunity_type = "ash"

	barometer_predictable = TRUE
	affects_underground = FALSE
	thunder_chance = 14

	sound_active_outside = /datum/looping_sound/weather/wind/indoors
	sound_active_inside = /datum/looping_sound/weather/wind
	sound_weak_outside = /datum/looping_sound/weather/wind/indoors
	sound_weak_inside = /datum/looping_sound/weather/wind

	multiply_blend_on_main_stage = TRUE

/datum/weather/shroud_storm/weather_act(mob/living/living_mob)
	/// Think of some good solution of how weather should affect monsters and how they should be resistant to things like this
	if(isanimal(living_mob))
		return
	if(prob(10))
		living_mob.electrocute_act(rand(5, 20), "weather", TRUE)
	if(prob(10))
		empulse(living_mob, 0, 3)
