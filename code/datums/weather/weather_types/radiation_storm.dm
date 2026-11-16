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
	harmful = TRUE
	multiply_blend_on_main_stage = TRUE

// basicmobs dont care bout radiation
/datum/weather/rad_storm/affects(mob/living/victim)
	return !isbasicmob(victim) && !HAS_TRAIT(victim, TRAIT_RADIMMUNE)

/datum/weather/rad_storm/weather_act(mob/living/victim)
	if(prob(40))
		victim.rad_act(20)

/datum/weather/rad_storm/end()
	if(..())
		return
