/datum/weather/rain
	name = "rain"
	desc = "Rain falling down the surface."

	telegraph_message = "<span class='notice'>Dark clouds hover above and you feel humidity in the air..</span>"
	telegraph_duration = 300

	weather_message = "<span class='notice'>Rain starts to fall down..</span>"
	weather_overlay = "rain"
	weather_duration_lower = 600
	weather_duration_upper = 1500

	end_duration = 100
	end_message = "<span class='notice'>The rain stops...</span>"

	area_type = /area
	protect_indoors = TRUE
	barometer_predictable = TRUE
	affects_underground = FALSE
	aesthetic = TRUE

	sound_active_outside = /datum/looping_sound/weather/rain/indoors
	sound_active_inside = /datum/looping_sound/weather/rain

/datum/weather/rain/heavy
	name = "heavy rain"
	desc = "Downpour of rain."

	telegraph_message = "<span class='notice'>Rather suddenly, clouds converge and tear into rain..</span>"
	telegraph_overlay = "rain"

	weather_message = "<span class='notice'>The rain turns into a downpour..</span>"
	weather_overlay = "storm"

	end_message = "<span class='notice'>The downpour dies down...</span>"
	end_overlay = "rain"

	sound_active_outside = /datum/looping_sound/weather/rain/indoors
	sound_active_inside = /datum/looping_sound/weather/rain
	sound_weak_outside = /datum/looping_sound/weather/rain/indoors
	sound_weak_inside = /datum/looping_sound/weather/rain

	thunder_chance = 2

/datum/weather/rain/heavy/storm
	name = "storm"
	desc = "Storm with rain and lightning."
	weather_message = "<span class='warning'>The clouds blacken and the sky starts to flash as thunder strikes down!</span>"
	thunder_chance = 10

/datum/weather/rain/heavy/storm/blocking
	name = "severe storm"
	desc = "Massive storm that blocks vision."
	opacity_in_main_stage = TRUE
	thunder_chance = 60

	telegraph_message = "<span class='notice'>It starts to fog up, the clouds hinting at a severe storm...</span>"
	telegraph_overlay = "smoke"

	weather_message = "<span class='userdanger'>It starts pouring! You can't see a thing!</span>"
	weather_overlay = "rain_high"

	end_message = "<span class='notice'>The downpour dies down...</span>"
	end_overlay = "smoke"


//toxic rain


/datum/weather/rain/toxic
	name = "toxic rain"
	desc = "Toxic Rain falling down the surface."

	telegraph_message = "<span class='danger'>Toxic clouds hover above and you feel humidity in the air. Equip a gas mask and properly cover yourself.</span>"
	telegraph_duration = 300

	weather_message = "<span class='userdanger'>Toxic rain starts to fall down!</span>"
	weather_overlay = "toxic_rain_low"
	weather_duration_lower = 600
	weather_duration_upper = 1500

	end_duration = 100
	end_message = "<span class='notice'>The rain stops...</span>"

	area_type = /area
	protect_indoors = TRUE
	barometer_predictable = TRUE
	affects_underground = FALSE
	aesthetic = FALSE

	sound_active_outside = /datum/looping_sound/weather/rain/indoors
	sound_active_inside = /datum/looping_sound/weather/rain

	var/toxic_power = 2

/datum/weather/rain/toxic/weather_act(mob/living/living_mob)
	if(!iscarbon(living_mob))
		return
	var/mob/living/carbon/carbon = living_mob
	handle_face(carbon)
	handle_eyes(carbon)

	if(!ishuman(living_mob))
		carbon.reagents.add_reagent(/datum/reagent/toxin, toxic_power/2)
		return
	var/mob/living/carbon/human/human = living_mob
	if(!human.head)
		carbon.reagents.add_reagent(/datum/reagent/toxin, toxic_power/4)

	if(!human.wear_suit)
		if(human.wear_neck)
			if(istype (human.wear_neck,/obj/item/clothing/neck/cloak)) //cloaks protect in steed of suits
				return
		human.reagents.add_reagent(/datum/reagent/toxin, toxic_power/4)


/datum/weather/rain/toxic/proc/handle_face(mob/living/carbon/living_mob)
	if(HAS_TRAIT(living_mob, TRAIT_NOBREATH))
		return
	if(living_mob.internal)
		return
	if(living_mob.is_mouth_covered()) //in case theres an unflipped explorer mask
		if(living_mob.wear_mask)
			if(istype(living_mob.wear_mask, /obj/item/clothing/mask/gas)) //gas masks FINALLY useful?
				return
	living_mob.adjustOrganLoss(ORGAN_SLOT_LUNGS, toxic_power/4)
	if(prob(45))
		living_mob.emote("cough")
		to_chat(living_mob, "<span class='userdanger'>It's painful to breathe!</span>")
		living_mob.adjustOxyLoss(1.5*toxic_power)

/datum/weather/rain/toxic/proc/handle_eyes(mob/living/carbon/living_mob)
	if(living_mob.is_eyes_covered())
		return

	if(living_mob.wear_mask)
		if(istype(living_mob.wear_mask, /obj/item/clothing/mask/gas)) //if we have a gas mask, dont care about eye protection?
			return
	var/eye_damage = toxic_power/2
	eye_damage -= living_mob.get_eye_protection()
	if((eye_damage < 0))
		return

	living_mob.adjustOrganLoss(ORGAN_SLOT_EYES, toxic_power/2)
	if(prob(65))
		living_mob.emote("cry")
		to_chat(living_mob, "<span class='userdanger'>Your eyes tear up and burn severely!</span>")
		living_mob.blur_eyes(10)



/datum/weather/rain/toxic/heavy
	name = "heavy toxic rain"
	desc = "Downpour of toxic rain."

	telegraph_message = "<span class='userdanger'>Rather suddenly, toxic clouds converge and tear into rain. Equip a gas mask and properly cover yourself.</span>"
	telegraph_overlay = "toxic_rain_low"

	weather_message = "<span class='userdanger'>The toxic rain starts pouring!</span>"
	weather_overlay = "toxic_rain"

	end_message = "<span class='notice'>The downpour dies down...</span>"
	end_overlay = "rain"

	sound_active_outside = /datum/looping_sound/weather/rain/indoors
	sound_active_inside = /datum/looping_sound/weather/rain
	sound_weak_outside = /datum/looping_sound/weather/rain/indoors
	sound_weak_inside = /datum/looping_sound/weather/rain

	thunder_chance = 10

	toxic_power = 10


/datum/weather/rain/toxic/heavy/blocking
	name = "severe storm"
	desc = "Massive storm that blocks vision."
	opacity_in_main_stage = TRUE
	thunder_chance = 60

	telegraph_message = "<span class='userdanger'>It starts to fog up, the toxic clouds hinting at a severe storm. Equip a gas mask and properly cover yourself as severe storms can be extremely lethal without protection.</span>"
	telegraph_overlay = "smoke"

	weather_message = "<span class='userdanger'>It starts pouring toxin rain! You can't see a thing!</span>"
	weather_overlay = "toxic_rain"

	end_message = "<span class='notice'>The downpour dies down...</span>"
	end_overlay = "smoke"

	toxic_power = 20
/datum/weather/rain/heavy/storm_intense
	name = "storm"
	desc = "Storm with rain and lightning."
	weather_overlay = "storm_very"
	thunder_chance = 20
	weather_color = "#a3daf7"
	weather_duration_lower = 420690
	weather_duration_upper = 420690

	sound_active_outside = /datum/looping_sound/weather/rain/storm/indoors
	sound_active_inside = /datum/looping_sound/weather/rain/storm
	sound_weak_outside = /datum/looping_sound/weather/rain/storm/indoors
	sound_weak_inside = /datum/looping_sound/weather/rain/storm
