//Radiation storms occur when the station passes through an irradiated area, and irradiate anyone not standing in protected areas (maintenance, emergency storage, etc.)
/datum/weather/rad_storm
	name = "radiation storm"
	desc = "A cloud of intense radiation passes through the area dealing rad damage to those who are unprotected."

	telegraph_duration = 400
	telegraph_message = span_danger("The air begins to grow warm.")

	weather_message = span_userdanger("<i>You feel waves of heat wash over you! Find shelter!</i>")
	weather_overlay = "rad_storm"
	weather_duration_lower = 600
	weather_duration_upper = 1500
	weather_sound = 'sound/misc/bloblarm.ogg'

	end_duration = 100
	end_message = span_notice("The air seems to be cooling off again.")

	area_type = /area
	protected_areas = list(/area/ship, /area/overmap_encounter/planetoid/cave)

	protect_indoors = TRUE

	immunity_type = "rad"
	multiply_blend_on_main_stage = TRUE

/datum/weather/rad_storm/weather_act(mob/living/L)
	if(prob(40))
		L.rad_act(20)

/datum/weather/rad_storm/end()
	if(..())
		return
