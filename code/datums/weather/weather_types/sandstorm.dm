/datum/weather/sandstorm
	name = "sandstorm"
	desc = "Wshshshshh."

	telegraph_message = "<span class='danger'>You see waves of sand traversing as the wind picks up the pace..</span>"
	telegraph_duration = 300
	telegraph_overlay = "dust"

	weather_message = "<span class='userdanger'><i>A sand storm is upon you! Seek shelter!</i></span>"
	weather_overlay = "sandstorm"
	weather_duration_lower = 600
	weather_duration_upper = 1500

	end_duration = 100
	end_message = "<span class='notice'>The storm dissipiates.</span>"
	end_overlay = "dust"

	area_type = /area
	protect_indoors = TRUE

	immunity_type = "ash"

	barometer_predictable = TRUE
	affects_underground = FALSE

	sound_active_outside = /datum/looping_sound/active_outside_ashstorm
	sound_active_inside = /datum/looping_sound/active_inside_ashstorm
	sound_weak_outside = /datum/looping_sound/weak_outside_ashstorm
	sound_weak_inside = /datum/looping_sound/weak_inside_ashstorm

	opacity_in_main_stage = TRUE

/datum/weather/sandstorm/weather_act(mob/living/living_mob)
	if(iscarbon(living_mob))
		var/mob/living/carbon/carbon = living_mob
		if(HAS_TRAIT(carbon, TRAIT_NOBREATH))
			return
		if(carbon.is_mouth_covered())
			return
		carbon.adjustOxyLoss(1.5)
		if(prob(10))
			carbon.emote("cough")

/datum/weather/sandstorm/rockplanet //for rock games ! !
	name = "severe sandstorm"
	desc = "My battery is low and it's getting dark."

	telegraph_message = "<span class='userdanger'>You see a dust cloud rising over the horizon, coming in fast!</span>"
	telegraph_overlay = "dust_med"
	telegraph_sound = 'sound/effects/siren.ogg'

	weather_message = "<span class='userdanger'><i>Rough sand and wind batter you! Get inside!</i></span>"
	weather_overlay = "dust_high"

	end_message = "<span class='notice'>The shrieking wind whips away the last of the sand and falls to its usual murmur. It should be safe to go outside now.</span>"
	end_overlay = "dust_low"

/datum/weather/sandstorm/rockplanet/weather_act(mob/living/living_mob)
	if(iscarbon(living_mob))
		var/mob/living/carbon/carbon = living_mob
		carbon.adjustBruteLoss(6)
		to_chat(carbon, "<span class='danger'>You are battered by the coarse sand!</span>")
		if(HAS_TRAIT(carbon, TRAIT_NOBREATH))
			return
		if(carbon.is_mouth_covered())
			return
		carbon.adjustOxyLoss(3.5)
		if(prob(10))
			carbon.emote("cough")

/datum/weather/sandstorm/rockplanet/harmless
	name = "Sandfall"
	desc = "A passing sandstorm blankets the area in sand."

	telegraph_message = "<span class='notice'>The wind begins to intensify, blowing sand up from the ground.</span>"
	telegraph_overlay = "dust_low"
	telegraph_sound = null

	weather_message = "<span class='notice'>Gentle sand wafts down around you like grotesque snow.</span>"
	weather_overlay = "dust_med"

	end_message = "<span class='notice'>The sandfall slows, stops. Another layer of sand on the mesa beneath your feet.</span>"
	end_overlay = "dust_low"

	aesthetic = TRUE
	opacity_in_main_stage = FALSE
