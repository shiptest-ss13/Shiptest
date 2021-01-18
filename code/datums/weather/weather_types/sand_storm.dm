/datum/weather/ash_storm/sand_storm
	name = "sand storm"
	desc = "An intense atmospheric storm blows the sand from the surface into the planet's lower atmosphere, causing all those caught unprepared to be blinded and buffeted with high-velocity sand."

	telegraph_message = "<span class='boldwarning'>An eerie moan rises on the wind. Gusts of sand block the horizon. Seek shelter.</span>"
	telegraph_duration = 300
	telegraph_overlay = "light_sand"

	weather_message = "<span class='userdanger'><i>Gusts of sand blow everywhere! Get inside!</i></span>"
	weather_duration_lower = 600
	weather_duration_upper = 1200
	weather_overlay = "sand_storm"

	end_message = "<span class='boldannounce'>The shrieking wind whips away the last of the sand and falls to its usual murmur. It should be safe to go outside now.</span>"
	end_duration = 300
	end_overlay = "light_sand"

	area_type = /area
	protect_indoors = TRUE
	target_trait = ZTRAIT_SANDSTORM

	immunity_type = "sand"

/datum/weather/ash_storm/sand_storm/is_ash_immune(atom/L)
	while (L && !isturf(L))
		if(ismecha(L)) //Mechs are immune
			return TRUE
		if(ishuman(L)) //Are you immune?
			var/mob/living/carbon/human/H = L
			if(H.head && istype(H.head, /obj/item/clothing) && H.wear_suit && istype(H.wear_suit, /obj/item/clothing))
				var/obj/item/clothing/CH = H.head
				var/obj/item/clothing/CS = H.wear_suit
				if (CH.clothing_flags & THICKMATERIAL && CS.clothing_flags & THICKMATERIAL)
					return TRUE
		if(isliving(L))// if we're a non immune mob inside an immune mob we have to reconsider if that mob is immune to protect ourselves
			var/mob/living/the_mob = L
			if("sand" in the_mob.weather_immunities)
				return TRUE
		L = L.loc //Check parent items immunities (recurses up to the turf)
	return FALSE //RIP you

/datum/weather/ash_storm/sand_storm/weather_act(mob/living/L)
	if(is_ash_immune(L))
		return
	L.adjustBruteLoss(3)
	if(!L.is_eyes_covered())
		L.blind_eyes(3)
