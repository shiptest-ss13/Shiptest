// Only works for simple animals, don't expect this to do anything for carbons

/datum/element/appearance_on_login
	var/list/icon_list

/datum/element/appearance_on_login/borer

/datum/element/appearance_on_login/borer/New()
	. = ..()
	icon_list = list(
		"creepy" = image(icon = 'icons/mob/borer.dmi', icon_state = "creepy"),
		"fluffy" = image(icon = 'icons/mob/borer.dmi', icon_state = "fluffy"),
		"colorful" = image(icon = 'icons/mob/borer.dmi', icon_state = "colorful"),
		"coral" = image(icon = 'icons/mob/borer.dmi', icon_state = "coral"),
		"legacy" = image(icon = 'icons/mob/borer.dmi', icon_state = "legacy")
		)

/datum/element/appearance_on_login/Attach(mob/living/simple_animal/target)
	.=..()
	if(!ismob(target))
		return ELEMENT_INCOMPATIBLE
	if(target.client)
		mob_appearance(target)
		target.RemoveElement(/datum/element/appearance_on_login)
	else
		RegisterSignal(target, COMSIG_MOB_LOGIN, .proc/on_mob_login)

/datum/element/appearance_on_login/proc/on_mob_login(mob/source)
	SIGNAL_HANDLER
	INVOKE_ASYNC(src, .proc/mob_appearance, source)
	UnregisterSignal(source, COMSIG_MOB_LOGIN)
	source.RemoveElement(/datum/element/appearance_on_login)

/datum/element/appearance_on_login/proc/check_menu(mob/living/simple_animal/target)
	if(!istype(target))
		return FALSE
	if(target.incapacitated())
		return FALSE
	return TRUE

/datum/element/appearance_on_login/proc/mob_appearance(mob/living/simple_animal/target)

	var/picked_icon = show_radial_menu(target, target, icon_list, custom_check = CALLBACK(src, .proc/check_menu, target), radius = 38, require_near = TRUE)
	if(picked_icon)
		target.icon_state = "[picked_icon]"
		target.icon_living = "[picked_icon]"
		target.icon_dead = "[picked_icon]_dead"
