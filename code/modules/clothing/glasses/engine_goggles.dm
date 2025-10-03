//Engineering Mesons

#define MODE_NONE ""
#define MODE_MESON "meson"
#define MODE_TRAY "t-ray"
#define MODE_RAD "radiation"
#define MODE_SHUTTLE "shuttle"

/obj/item/clothing/glasses/meson/engine
	name = "engineering scanner goggles"
	desc = "Goggles used by engineers. The Meson Scanner mode lets you see basic structural and terrain layouts through walls, the T-ray Scanner mode lets you see underfloor objects such as cables and pipes, and the Radiation Scanner mode lets you see objects contaminated by radiation."
	icon_state = "trayson-meson"
	item_state = "trayson-meson"
	actions_types = list(/datum/action/item_action/toggle_mode)
	glass_colour_type = /datum/client_colour/glass_colour/gray

	vision_flags = NONE
	darkness_view = 2
	invis_view = SEE_INVISIBLE_LIVING

	var/list/modes = list(MODE_NONE = MODE_MESON, MODE_MESON = MODE_TRAY, MODE_TRAY = MODE_RAD, MODE_RAD = MODE_NONE)
	var/mode = MODE_NONE
	var/range = 1

/obj/item/clothing/glasses/meson/engine/Initialize()
	. = ..()
	START_PROCESSING(SSobj, src)
	update_appearance()

/obj/item/clothing/glasses/meson/engine/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

/obj/item/clothing/glasses/meson/engine/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/clothing/glasses/meson/engine/proc/toggle_mode(mob/user, voluntary)
	mode = modes[mode]
	to_chat(user, "<span class='[voluntary ? "notice":"warning"]'>[voluntary ? "You turn the goggles":"The goggles turn"] [mode ? "to [mode] mode":"off"][voluntary ? ".":"!"]</span>")

	switch(mode)
		if(MODE_MESON)
			vision_flags = SEE_TURFS
			darkness_view = 1
			lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_VISIBLE
			change_glass_color(user, /datum/client_colour/glass_colour/yellow)

		if(MODE_TRAY) //undoes the last mode, meson
			vision_flags = NONE
			darkness_view = 2
			lighting_alpha = null
			change_glass_color(user, /datum/client_colour/glass_colour/lightblue)

		if(MODE_RAD)
			change_glass_color(user, /datum/client_colour/glass_colour/lightgreen)

		if(MODE_SHUTTLE)
			change_glass_color(user, /datum/client_colour/glass_colour/red)

		if(MODE_NONE)
			change_glass_color(user, initial(glass_colour_type))

	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(H.glasses == src)
			H.update_sight()

	update_appearance()
	for(var/X in actions)
		var/datum/action/A = X
		A.UpdateButtonIcon()

/obj/item/clothing/glasses/meson/engine/attack_self(mob/user)
	toggle_mode(user, TRUE)

/obj/item/clothing/glasses/meson/engine/process(seconds_per_tick)
	if(!ishuman(loc))
		return
	var/mob/living/carbon/human/user = loc
	if(user.glasses != src)
		return
	switch(mode)
		if(MODE_TRAY)
			t_ray_scan(user, 8, range)
		if(MODE_RAD)
			show_rads()
		if(MODE_SHUTTLE)
			show_shuttle()

/obj/item/clothing/glasses/meson/engine/proc/show_rads()
	var/mob/living/carbon/human/user = loc
	var/list/rad_places = list()
	for(var/datum/component/radioactive/thing in SSradiation.processing)
		var/atom/owner = thing.parent
		var/turf/place = get_turf(owner)
		if(rad_places[place])
			rad_places[place] += thing.strength
		else
			rad_places[place] = thing.strength

	for(var/i in rad_places)
		var/turf/place = i
		if(get_dist(user, place) >= range*5)	//Rads are easier to see than wires under the floor
			continue
		var/strength = round(rad_places[i] / 1000, 0.1)
		var/image/pic = image(loc = place)
		var/mutable_appearance/MA = new()
		MA.maptext = MAPTEXT("[strength]k")
		MA.color = "#04e604"
		MA.layer = RAD_TEXT_LAYER
		MA.plane = GAME_PLANE
		pic.appearance = MA
		flick_overlay(pic, list(user.client), 10)

/obj/item/clothing/glasses/meson/engine/proc/show_shuttle()
	var/mob/living/carbon/human/user = loc
	for(var/obj/docking_port/port as anything in range(30, user))
		if(!port)
			continue
		if(!istype(port))
			continue
		for(var/turf/current_turf as anything in port.return_turfs())
			var/image/pic
			if(istype(port, /obj/docking_port/mobile))
				pic = new('icons/turf/overlays.dmi', current_turf, "greenOverlay", RAD_TEXT_LAYER)
			else
				pic = new('icons/turf/overlays.dmi', current_turf, "redOverlay", RAD_TEXT_LAYER)

			flick_overlay(pic, GLOB.clients, 2 SECONDS)

	/*
	var/obj/docking_port/mobile/port = SSshuttle.get_containing_shuttle(user)
	if(!port)
		return
	var/list/shuttle_areas = port.shuttle_areas
	for(var/r in shuttle_areas)
		var/area/region = r
		for(var/turf/place in region.contents)
			if(get_dist(user, place) > 7)
				continue
			var/image/pic
			if(isshuttleturf(place))
				pic = new('icons/turf/overlays.dmi', place, "greenOverlay", AREA_LAYER)
			else
				pic = new('icons/turf/overlays.dmi', place, "redOverlay", AREA_LAYER)
			flick_overlay(pic, list(user.client), 8)
	*/

/obj/item/clothing/glasses/meson/engine/update_icon_state()
	icon_state = item_state = "trayson-[mode]"
	return ..()

/obj/item/clothing/glasses/meson/engine/tray //atmos techs have lived far too long without tray goggles while those damned engineers get their dual-purpose gogles all to themselves
	name = "optical t-ray scanner"
	icon_state = "trayson-t-ray"
	item_state = "trayson-t-ray"
	desc = "Used by engineering staff to see underfloor objects such as cables and pipes."
	range = 2

	modes = list(MODE_NONE = MODE_TRAY, MODE_TRAY = MODE_NONE)

/obj/item/clothing/glasses/meson/engine/shuttle
	name = "shuttle region scanner"
	icon_state = "trayson-shuttle"
	item_state = "trayson-shuttle"
	desc = "Used to see the boundaries of shuttle regions."

	modes = list(MODE_NONE = MODE_SHUTTLE, MODE_SHUTTLE = MODE_NONE)

/obj/item/clothing/glasses/meson/prescription
	name = "prescription optical meson scanner"
	desc = "Used by engineering and mining staff to see basic structural and terrain layouts through walls, regardless of lighting conditions. This pair also corrects nearsightedness."
	icon_state = "prescriptionmeson"
	vision_correction = 1
	flags_cover = GLASSESCOVERSEYES

/obj/item/clothing/glasses/meson/sunglasses
	name = "optical meson scannerglasses"
	desc = "Used by engineering and mining staff to see basic structural and terrain layouts through walls, regardless of lighting conditions. This pair is built into a pair of sunglasses."
	icon_state = "sunmeson"
	flash_protect = FLASH_PROTECTION_FLASH
	flags_cover = GLASSESCOVERSEYES

#undef MODE_NONE
#undef MODE_MESON
#undef MODE_TRAY
#undef MODE_RAD
#undef MODE_SHUTTLE
