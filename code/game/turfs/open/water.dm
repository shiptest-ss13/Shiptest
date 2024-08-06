/turf/open/water
	gender = PLURAL
	name = "water"
	desc = "Shallow water."
	icon = 'icons/turf/floors.dmi'
	icon_state = "riverwater_motion"
	baseturfs = /turf/open/water
	planetary_atmos = TRUE
	slowdown = 1
	bullet_sizzle = TRUE
	bullet_bounce_sound = null //needs a splashing sound one day.

	footstep = FOOTSTEP_WATER
	barefootstep = FOOTSTEP_WATER
	clawfootstep = FOOTSTEP_WATER
	heavyfootstep = FOOTSTEP_WATER

	var/datum/reagent/reagent_to_extract = /datum/reagent/water
	var/extracted_reagent_visible_name = "water"

/turf/open/water/examine(mob/user)
	. = ..()
	. += span_notice("You could probably scoop some of the [extracted_reagent_visible_name] if you had a beaker...")

/turf/open/water/attackby(obj/item/_item, mob/user, params)
	if(istype(_item, /obj/item/fish))
		to_chat(user, span_notice("You toss the [_item.name] into the [name]."))
		playsound(_item, "sound/effects/bigsplash.ogg", 90)
		qdel(_item)
	if(istype(_item, /obj/item/reagent_containers/glass))
		extract_reagents(_item,user,params)

	. = ..()

/turf/open/water/proc/extract_reagents(obj/item/reagent_containers/glass/container, mob/user, params)
	if(!reagent_to_extract)
		return FALSE
	if(!container.is_refillable())
		to_chat(user, span_danger("\The [container]'s cap is on! Take it off first."))
		return FALSE
	if(container.reagents.total_volume >= container.volume)
		to_chat(user, span_danger("\The [container] is full."))
		return FALSE
	container.reagents.add_reagent(reagent_to_extract, rand(5, 10))
	user.visible_message(span_notice("[user] scoops [extracted_reagent_visible_name] from the [src] with \the [container]."), span_notice("You scoop out [extracted_reagent_visible_name] from the [src] using \the [container]."))
	return TRUE

/turf/open/water/can_have_cabling()
	return FALSE

/turf/open/water/rcd_vals(mob/user, obj/item/construction/rcd/the_rcd)
	switch(the_rcd.mode)
		if(RCD_FLOORWALL)
			return list("mode" = RCD_FLOORWALL, "delay" = 0, "cost" = 3)
	return FALSE

/turf/open/water/rcd_act(mob/user, obj/item/construction/rcd/the_rcd, passed_mode)
	switch(passed_mode)
		if(RCD_FLOORWALL)
			to_chat(user, span_notice("You build a floor."))
			PlaceOnTop(/turf/open/floor/plating, flags = CHANGETURF_INHERIT_AIR)
			return TRUE
	return FALSE

/turf/open/water/MakeSlippery(wet_setting, min_wet_time, wet_time_to_add, max_wet_time, permanent) //water? wet? not in this economy.
	return

/turf/open/water/jungle
	light_range = 2
	light_power = 0.6
	light_color = COLOR_VERY_LIGHT_GRAY

/turf/open/water/jungle/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/lazy_fishing_spot, FISHING_SPOT_PRESET_JUNGLE)

/turf/open/water/beach
	color = COLOR_CYAN
	light_range = 2
	light_power = 0.80
	light_color = LIGHT_COLOR_BLUE

/turf/open/water/beach/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/lazy_fishing_spot, FISHING_SPOT_PRESET_BEACH)

/turf/open/water/beach/deep
	color = "#0099ff"
	light_color = LIGHT_COLOR_DARK_BLUE

/turf/open/water/tar
	name = "tar pit"
	desc = "Shallow tar. Will slow you down significantly."
	color = "#473a3a"
	light_range = 0
	slowdown = 2
	reagent_to_extract = /datum/reagent/asphalt
	extracted_reagent_visible_name = "tar"
