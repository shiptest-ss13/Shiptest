/obj/item/gear_pack/survey_pack
	name = "Survey Pack"
	desc = "A large scientific kit designed for planetary survey"
	icon = 'icons/obj/item/survey_handheld.dmi'
	icon_state = "survey"
	item_state = "survey"
	lefthand_file = 'icons/mob/inhands/equipment/backpack_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/backpack_righthand.dmi'
	attachment_type = /obj/item/attachment/survey_scanner
	slowdown = 1
	var/survey_mult = 1
	var/survey_delay = 4 SECONDS

/obj/item/gear_pack/survey_pack/advanced //can be purchased, is Expendy.
	name = "Advanced Survey Pack"
	desc = "A high hech piece of scientific kit designed for thorough planetary survey"
	icon_state = "survey-adv"
	survey_mult = 1.5
	slowdown = 0.8

/obj/item/gear_pack/survey_pack/advanced/nt
	name = "Nanotrasen Survey Pack"
	desc = "A large, high tech piece of Nanotrasen kit, designed for mining survey."
	icon_state = "survey-nt"
	survey_mult = 1.6
	survey_delay = 3 SECONDS
	slowdown = 0.5

/obj/item/gear_pack/survey_pack/Experimental //these should never be purchasable or manufacturable, loot only.
	name = "Experimental Survey Pack"
	desc = "An experimental survey pack, capable of analyzing entire regions in seconds."
	icon_state = "survey-elite"
	survey_mult = 2
	survey_delay = 2 SECONDS


/obj/item/attachment/survey_scanner
	name = "survey scanner"
	desc = "A wired tool designed to work in tandem with a survey pack"
	w_class = WEIGHT_CLASS_BULKY
	icon = 'icons/obj/item/survey_handheld.dmi'
	icon_state = "survey-att"
	lefthand_file = 'icons/mob/inhands/equipment/backpack_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/backpack_righthand.dmi'
	pack = /obj/item/gear_pack/survey_pack
	tool_behaviour = TOOL_ANALYZER
	usecost = 100
	var/survey_mult
	var/survey_delay
	var/active
	var/cooldown = FALSE
	var/cooldown_time

/obj/item/attachment/survey_scanner/New(loc, ...)
	. = ..()
	survey_mult = pack?:survey_mult
	survey_delay = pack?:survey_delay
	return

/obj/item/attachment/survey_scanner/attack_self(mob/living/user)
	if(src.pack.powered)
		user.visible_message("<span class='notice'>[user] fires a ping off from [src]</span>")
		playsound(src, 'sound/effects/ping.ogg', 75)
		for(var/obj/effect/survey_point/revealed in orange(1, user))
			revealed.invisibility = 0 //could use an effect but I'm lazy
			animate(revealed, alpha = 255,time = 15)
			revealed.visible_message("<span class='notice'>[revealed] reveals itself in a short burst of energy!</span>")
		src.pack.deductcharge(usecost / 2)
		return
	else
		to_chat(user,"<span_class='notice'> [src.pack] is out of power!")

/obj/item/attachment/survey_scanner/proc/ping()
	if(isliving(loc))
		var/mob/living/L = loc
		to_chat(L, "<span class='notice'>[src]'s barometer function is ready!</span>")
	playsound(src, 'sound/machines/click.ogg', 100)
	cooldown = FALSE

/obj/item/attachment/survey_scanner/proc/butchertime(amount)
	if(!amount)
		return

/obj/item/attachment/survey_scanner/examine(mob/user)
	. = ..()
	. += "<span class='notice'>Alt-click [src] to activate the barometer function.</span>"

/obj/item/attachment/survey_scanner/AltClick(mob/living/user)
	..()
	if(user.canUseTopic(src, BE_CLOSE))
		if(cooldown)
			to_chat(user, "<span class='warning'>[src]'s barometer function is preparing itself.</span>")
			return
		var/turf/T = get_turf(user)
		if(!T)
			return
		var/datum/weather_controller/weather_controller = SSmapping.get_map_zone_weather_controller(T)
		playsound(src, 'sound/effects/pop.ogg', 100)
		var/area/user_area = T.loc
		var/datum/weather/ongoing_weather = null
		if(!user_area.outdoors)
			to_chat(user, "<span class='warning'>[src]'s barometer function won't work indoors!</span>")
			return
		if(weather_controller.current_weathers)
			for(var/datum/weather/W as anything in weather_controller.current_weathers)
				if(W.barometer_predictable && W.my_controller.mapzone.is_in_bounds(T) && W.area_type == user_area.type && !(W.stage == END_STAGE))
					ongoing_weather = W
					break
		if(ongoing_weather)
			if((ongoing_weather.stage == MAIN_STAGE) || (ongoing_weather.stage == WIND_DOWN_STAGE))
				to_chat(user, "<span class='warning'>[src]'s barometer function can't trace anything while the storm is [ongoing_weather.stage == MAIN_STAGE ? "already here!" : "winding down."]</span>")
				return
			if(ongoing_weather.aesthetic)
				to_chat(user, "<span class='warning'>[src]'s barometer function says that the next storm will breeze on by.</span>")
		else
			var/next_hit = weather_controller.next_weather
			var/fixed = next_hit - world.time
			if(fixed <= 0)
				to_chat(user, "<span class='warning'>[src]'s barometer function was unable to trace any weather patterns.</span>")
			else
				to_chat(user, "<span class='warning'>[src]'s barometer function says a storm will land in approximately [butchertime(fixed)].</span>")
		cooldown = TRUE
		addtimer(CALLBACK(src,/obj/item/attachment/survey_scanner/proc/ping), cooldown_time)
