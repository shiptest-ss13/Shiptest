/datum/weather/ash_storm/sand_storm
	name = "sand storm"
	desc = "An intense atmospheric storm blows the sand from the surface into the planet's lower atmosphere, causing all those caught unprepared to be blinded and buffeted with high-velocity sand."

	telegraph_message = span_boldwarning("An eerie moan rises on the wind. Gusts of sand block the horizon. Seek shelter.")
	telegraph_duration = 300
	telegraph_overlay = "light_sand"

	weather_message = span_userdanger("<i>Gusts of sand blow everywhere! Get inside!</i>")
	weather_duration_lower = 600
	weather_duration_upper = 1200
	weather_overlay = "sand_storm"

	end_message = span_boldannounce("The shrieking wind whips away the last of the sand and falls to its usual murmur. It should be safe to go outside now.")
	end_duration = 300
	end_overlay = "light_sand"

	area_type = /area
	protect_indoors = TRUE

	immunity_type = "sand"

/datum/weather/ash_storm/sand_storm/is_ash_immune(atom/victim)
	while (victim && !isturf(victim))
		if(ismecha(victim)) //Mechs are immune
			return TRUE
		if(ishuman(victim)) //Are you immune?
			var/mob/living/carbon/human/human_victim = victim
			if(human_victim.head && istype(human_victim.head, /obj/item/clothing) && human_victim.wear_suit && istype(human_victim.wear_suit, /obj/item/clothing))
				var/obj/item/clothing/helmet = human_victim.head
				var/obj/item/clothing/suit = human_victim.wear_suit
				if (helmet.clothing_flags & THICKMATERIAL && suit.clothing_flags & THICKMATERIAL)
					return TRUE
		if(isliving(victim))// if we're a non immune mob inside an immune mob we have to reconsider if that mob is immune to protect ourselves
			var/mob/living/the_mob = victim
			if("sand" in the_mob.weather_immunities)
				return TRUE
		victim = victim.loc //Check parent items immunities (recurses up to the turf)
	return FALSE //RIP you

/datum/weather/ash_storm/sand_storm/weather_act(mob/living/victim)
	victim.adjustBruteLoss(3)
	if(!victim.is_eyes_covered())
		victim.blind_eyes(3)
