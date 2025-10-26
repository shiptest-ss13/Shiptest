//Acid rain is part of the natural weather cycle in the humid forests of Planetstation, and cause acid damage to anyone unprotected.
/datum/weather/acid_rain
	name = "acid rain"
	desc = "The planet's thunderstorms are by nature acidic, and will incinerate anyone standing beneath them without protection."

	telegraph_duration = 400
	telegraph_message = span_boldwarning("Thunder rumbles far above. You hear droplets drumming against the canopy. Seek shelter.")
	telegraph_overlay = "acid_rain_low"

	weather_message = span_userdanger("<i>Acidic rain pours down around you! Get inside!</i>")
	weather_overlay = "acid_rain"
	weather_duration_lower = 600
	weather_duration_upper = 1500

	end_duration = 100
	end_message = span_boldannounce("The downpour gradually slows to a light shower. It should be safe outside now.")

	area_type = /area
	protect_indoors = TRUE

	immunity_type = "acid" // temp

	barometer_predictable = TRUE

	sound_active_outside = /datum/looping_sound/weather/rain/no_start
	sound_active_inside = /datum/looping_sound/weather/rain/indoors
	sound_weak_outside = /datum/looping_sound/weather/rain/weak
	sound_weak_inside = /datum/looping_sound/weather/rain/weak/indoors

	fire_suppression = 6

/datum/weather/acid_rain/weather_act(mob/living/L)
	/// Think of some good solution of how weather should affect monsters and how they should be resistant to things like this
	if(isanimal(L))
		return
	var/resist = L.getarmor(null, "acid")
	if(prob(max(0,100-resist)))
		L.acid_act(20,1)
