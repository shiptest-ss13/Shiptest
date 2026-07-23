
//artillery flares
//'dazzles' nearby players
#define CONFUSION_STACK_MAX_MULTIPLIER 2

/obj/effect/temp_visual/above_flare
	icon = 'icons/effects/64x64.dmi'
	icon_state = "flare"
	layer = FLY_LAYER
	light_system = STATIC_LIGHT
	light_power = 15
	light_color = COLOR_VERY_SOFT_YELLOW
	light_range = 12 //Way brighter than most lights

	pixel_x = -18
	pixel_y = 150
	duration = 90 SECONDS
	var/list/already_messaged = list()

/obj/effect/temp_visual/above_flare/Initialize(mapload)
	. = ..()
	var/turf/our_turf = get_turf(src)
	particles = new /particles/smoke/turf_fire
	our_turf.visible_message(span_warning("You see a tiny flash, and then a blindingly bright light from a flare as it lights off in the sky!"))
	playsound(our_turf,'sound/weapons/gun/general/rocket_launch.ogg',100, 1, 6)
	check_flashers_in_range()
	START_PROCESSING(SSprocessing, src)
	animate(src, time = duration, pixel_y = 0)

/obj/effect/temp_visual/above_flare/process(seconds_per_tick)
	check_flashers_in_range()

/obj/effect/temp_visual/above_flare/proc/check_flashers_in_range(range = 6, power = 5)
	var/list/mob/targets = get_flash_targets(get_turf(src), range, FALSE)
	for(var/mob/living/carbon/dazzler in targets)
		do_flash(dazzler, power)
	return TRUE

/obj/effect/temp_visual/above_flare/proc/get_flash_targets(atom/target_loc, range = 2)
	if(!target_loc)
		target_loc = loc
	if(isturf(target_loc) || (ismob(target_loc) && isturf(target_loc.loc)))
		return viewers(range, get_turf(target_loc))
	else
		return typecache_filter_list(target_loc.GetAllContents(), GLOB.typecache_living)

/obj/effect/temp_visual/above_flare/proc/do_flash(mob/living/carbon/dazzler, power = 2)
	var/mob/living/carbon/human/human_human_dazzler = dazzler
	if(!istype(dazzler))
		return

	if(dazzler.has_status_effect(/datum/status_effect/dazzled))
		dazzler.apply_status_effect(/datum/status_effect/dazzled, "flare")
		return

	else if(dazzler.flash_act())
		var/diff = power * CONFUSION_STACK_MAX_MULTIPLIER - dazzler.confused
		dazzler.confused += min(power, diff)
		visible_message(span_danger("The bright flare dazzles [dazzler]!</span>"))
		to_chat(dazzler, span_userdanger("The bright flare dazzles you!"))
		dazzler.apply_status_effect(/datum/status_effect/dazzled, "flare")

	else if(dazzler)
		if(human_human_dazzler.real_name in already_messaged)
			return //avoid message spam
		visible_message(span_warning("The bright flare attempts to dazzle [dazzler], but [dazzler.p_they()] seems unaffected!</span>"))
		to_chat(dazzler, span_userdanger("The bright flare attempts to dazzle you, but your protection prevents it!</span>"))
		if(human_human_dazzler)
			already_messaged += human_human_dazzler.real_name

#undef CONFUSION_STACK_MAX_MULTIPLIER
