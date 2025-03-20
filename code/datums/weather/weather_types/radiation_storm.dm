//Radiation storms occur when the station passes through an irradiated area, and irradiate anyone not standing in protected areas (maintenance, emergency storage, etc.)
/datum/weather/rad_storm
	name = "radiation storm"
	desc = "A cloud of intense radiation passes through the area dealing rad damage to those who are unprotected."

	telegraph_duration = 400
	telegraph_message = "<span class='danger'>The air begins to grow warm.</span>"

	weather_message = "<span class='userdanger'><i>You feel waves of heat wash over you! Find shelter!</i></span>"
	weather_overlay = "rad_storm"
	weather_duration_lower = 600
	weather_duration_upper = 1500
	weather_sound = 'sound/misc/bloblarm.ogg'

	end_duration = 100
	end_message = "<span class='notice'>The air seems to be cooling off again.</span>"

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
