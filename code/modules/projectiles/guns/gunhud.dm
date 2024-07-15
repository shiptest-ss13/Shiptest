/*
*	Customizable ammo hud
*	- Adapted from SR's gun hud. Most of the bad stuff was cut out and sprites were mostly replace by some azlan did years ago.
*	- var names and code have been cleaned up, for the most parts. There still some weirdly named stuff like the number hud (wtf does OTH even mean?)
*	- Most of this SHOULDN'T be used yet, only instance of this being used at the moment is the revolver which has completely differnt behavior
*/

/*
*	This hud is controlled namely by the ammo_hud component. Generally speaking this is inactive much like all other hud components until it's needed.
*	It does not do any calculations of it's own, you must do this externally.
*	If you wish to use this hud, use the ammo_hud component or create another one which interacts with it via the below procs.
*	proc/turn_off
*	proc/turn_on
*	proc/set_hud
*	Check the gun_hud.dmi for all available icons you can use.
*/

// Ammo counter
#define ui_ammocounter "EAST-1:28,CENTER+1:25"

/datum/hud
	var/atom/movable/screen/ammo_counter

/atom/movable/screen/ammo_counter
	name = "ammo counter"
	icon = 'icons/hud/gun_hud.dmi'
	icon_state = "backing"
	screen_loc = ui_ammocounter
	invisibility = INVISIBILITY_ABSTRACT

	///This is the color assigned to the OTH backing, numbers and indicator.
	var/backing_color = COLOR_RED
	/// The prefix used for the hud
	var/prefix = ""

	//Below are the OTH numbers, these are assigned by oX, tX and hX, x being the number you wish to display(0-9)
	///OTH position X00
	var/oth_o
	///OTH position 0X0
	var/oth_t
	///OTH position 00X
	var/oth_h
	///This is the custom indicator sprite that will appear in the box at the bottom of the ammo hud, use this for something like semi/auto toggle on a gun.
	var/indicator

///This proc simply resets the hud to standard and removes it from the players visible hud.
/atom/movable/screen/ammo_counter/proc/turn_off()
	invisibility = INVISIBILITY_ABSTRACT
	maptext = null
	backing_color = COLOR_RED
	oth_o = ""
	oth_t = ""
	oth_h = ""
	indicator = ""
	update_appearance()

///This proc turns the hud on, but does not set it to anything other than the currently set values
/atom/movable/screen/ammo_counter/proc/turn_on()
	invisibility = 0

///This is the main proc for altering the hud's appeareance, it controls the setting of the overlays. Use the OTH and below variables to set it accordingly.
/atom/movable/screen/ammo_counter/proc/set_hud(_backing_color, _oth_o, _oth_t, _oth_h, _indicator)
	backing_color = _backing_color
	oth_o = _oth_o
	oth_t = _oth_t
	oth_h = _oth_h
	indicator = _indicator

	update_appearance()

/atom/movable/screen/ammo_counter/update_overlays(list/rounds)
	. = ..()
	cut_overlays()
	if(oth_o)
		var/mutable_appearance/o_overlay = mutable_appearance(icon, oth_o)
		o_overlay.color = backing_color
		. += o_overlay
	if(oth_t)
		var/mutable_appearance/t_overlay = mutable_appearance(icon, oth_t)
		t_overlay.color = backing_color
		. += t_overlay
	if(oth_h)
		var/mutable_appearance/h_overlay = mutable_appearance(icon, oth_h)
		h_overlay.color = backing_color
		. += h_overlay
	if(indicator)
		var/mutable_appearance/indicator_overlay = mutable_appearance(icon, indicator)
		indicator_overlay.color = backing_color
		. += indicator_overlay
	if(!rounds)
		return

	for(var/image/round as anything in rounds)
		add_overlay(round)

//*////////////////////////////////////////////////////////////////////////////////////////////////////////////*

/datum/component/ammo_hud
	var/atom/movable/screen/ammo_counter/hud
	/// The prefix used for the hud
	var/prefix = ""
	var/backing_color = "#FFFFFF" // why was this hardcoded dlfhakhjdfj

/datum/component/ammo_hud/Initialize()
	. = ..()
	if(!istype(parent, /obj/item/gun) && !istype(parent, /obj/item/weldingtool))
		return COMPONENT_INCOMPATIBLE
	RegisterSignal(parent, COMSIG_ITEM_EQUIPPED, PROC_REF(wake_up))

/datum/component/ammo_hud/Destroy()
	turn_off()
	return ..()

/datum/component/ammo_hud/proc/wake_up(datum/source, mob/user, slot)
	SIGNAL_HANDLER

	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(H.is_holding(parent))
			if(H.hud_used)
				hud = H.hud_used.ammo_counter
				turn_on()
		else
			turn_off()

/datum/component/ammo_hud/proc/turn_on()
	SIGNAL_HANDLER

	RegisterSignal(parent, COMSIG_ITEM_DROPPED, PROC_REF(turn_off))
	RegisterSignal(parent, list(COMSIG_UPDATE_AMMO_HUD, COMSIG_GUN_CHAMBER_PROCESSED), PROC_REF(update_hud))

	hud.turn_on()
	update_hud()

/datum/component/ammo_hud/proc/turn_off()
	SIGNAL_HANDLER

	UnregisterSignal(parent, list(COMSIG_ITEM_DROPPED, COMSIG_UPDATE_AMMO_HUD, COMSIG_GUN_CHAMBER_PROCESSED))

	if(hud)
		hud.turn_off()
		hud = null

/// Returns get_ammo_count() with the appropriate args passed to it - some guns like the revolver and bow are special cases
/datum/component/ammo_hud/proc/get_accurate_ammo_count(obj/item/gun/ballistic/the_gun)
	// fucking revolvers indeed - do not count empty or chambered rounds for the display HUD
	if(istype(the_gun, /obj/item/gun/ballistic/revolver))
		var/obj/item/gun/ballistic/revolver/the_revolver = the_gun
		return the_revolver.get_ammo_count(countchambered = FALSE, countempties = FALSE)

	// bows are also weird and shouldn't count the chambered
	if(istype(the_gun, /obj/item/gun/ballistic/bow))
		return the_gun.get_ammo_count(countchambered = FALSE)

	return the_gun.get_ammo_count(countchambered = TRUE)

/datum/component/ammo_hud/proc/get_accurate_laser_count(obj/item/gun/energy/the_gun)
	var/obj/item/ammo_casing/energy/current_mode = the_gun.chambered
	if(!current_mode)
		return FALSE
	return round(the_gun.installed_cell.charge/current_mode.rounds_per_shot)

/datum/component/ammo_hud/proc/update_hud()
	SIGNAL_HANDLER
	var/obj/item/gun/ballistic/pew = parent
	hud.maptext = null
	hud.icon_state = "[prefix]backing"
	if(!pew.magazine)
		hud.set_hud(backing_color, "[prefix]oe", "[prefix]te", "[prefix]he", "[prefix]no_mag")
		return
	if(!pew.get_ammo_count())
		hud.set_hud(backing_color, "[prefix]oe", "[prefix]te", "[prefix]he", "[prefix]empty_flash")
		return

	var/indicator
	var/rounds = num2text(get_accurate_ammo_count(pew))
	var/oth_o
	var/oth_t
	var/oth_h

	switch(length(rounds))
		if(1)
			oth_o = "[prefix]o[rounds[1]]"
		if(2)
			oth_o = "[prefix]o[rounds[2]]"
			oth_t = "[prefix]t[rounds[1]]"
		if(3)
			oth_o = "[prefix]o[rounds[3]]"
			oth_t = "[prefix]t[rounds[2]]"
			oth_h = "[prefix]h[rounds[1]]"
		else
			oth_o = "[prefix]o9"
			oth_t = "[prefix]t9"
			oth_h = "[prefix]h9"
	hud.set_hud(backing_color, oth_o, oth_t, oth_h, indicator)

/datum/component/ammo_hud/laser/update_hud()
	var/obj/item/gun/energy/pew = parent
	hud.maptext = null
	hud.icon_state = "[prefix]backing"
	if(!pew.installed_cell)
		hud.set_hud(backing_color, "[prefix]oe", "[prefix]te", "[prefix]he", "[prefix]no_mag")
		return
	if(!get_accurate_laser_count(pew))
		hud.set_hud(backing_color, "[prefix]oe", "[prefix]te", "[prefix]he", "[prefix]empty_flash")
		return

	var/indicator
	var/rounds = num2text(get_accurate_laser_count(pew))
	var/oth_o
	var/oth_t
	var/oth_h

	switch(length(rounds))
		if(1)
			oth_o = "[prefix]o[rounds[1]]"
		if(2)
			oth_o = "[prefix]o[rounds[2]]"
			oth_t = "[prefix]t[rounds[1]]"
		if(3)
			oth_o = "[prefix]o[rounds[3]]"
			oth_t = "[prefix]t[rounds[2]]"
			oth_h = "[prefix]h[rounds[1]]"
		else
			oth_o = "[prefix]o9"
			oth_t = "[prefix]t9"
			oth_h = "[prefix]h9"
	hud.set_hud(backing_color, oth_o, oth_t, oth_h, indicator)

/datum/component/ammo_hud/laser/cybersun
	prefix = "cybersun_"

//please be aware, this only supports 6 round revolvers. It is comically easy to support more or less rounds,like in game there are 7 round and 5 round revolvers, but that requires sprites, and i'm lasy
/datum/component/ammo_hud/revolver
	prefix = "revolver_"

/// Returns get_ammo_count() with the appropriate args passed to it - some guns like the revolver and bow are special cases
/datum/component/ammo_hud/revolver/get_accurate_ammo_count(obj/item/gun/ballistic/revolver/the_gun)
	if(istype(the_gun, /obj/item/gun/ballistic/revolver))
		var/obj/item/gun/ballistic/revolver/the_revolver = the_gun
		if(the_revolver.magazine)
			return the_revolver.magazine.ammo_list()

/* //for counter-clockwise, kept here for reference
	var/list/round_positions = list(
		list("x" = 12,"y" = 22),

		list("x" = 20,"y" = 17),
		list("x" = 20,"y" = 7 ),
		list("x" = 12,"y" = 2 ),
		list("x" = 4 ,"y" = 7 ),
		list("x" = 4 ,"y" = 17)
	)
*/

/datum/component/ammo_hud/revolver/update_hud()
	var/obj/item/gun/ballistic/revolver/pew = parent
	hud.icon_state = "[prefix]backing"

	var/list/rounds = get_accurate_ammo_count(pew)
	var/list/round_images = list()
	var/list/round_positions = list(
		list("x" = 12,"y" = 22),

		list("x" = 4 ,"y" = 17),
		list("x" = 4 ,"y" = 7 ),
		list("x" = 12,"y" = 2 ),
		list("x" = 20,"y" = 7 ),
		list("x" = 20,"y" = 17)

	)

	var/bullet_count = 0
	for(var/obj/item/ammo_casing/bullet as anything in rounds)
		bullet_count++
		if(!bullet)
			continue
		var/image/current_bullet_image = image(icon = 'icons/hud/gun_hud.dmi')
		var/list/bullet_position = round_positions[bullet_count]
		current_bullet_image.pixel_x = bullet_position["x"]
		current_bullet_image.pixel_y = bullet_position["y"]
		current_bullet_image.icon_state = "revolver_casing[bullet.BB ? "_live" : ""]"
		round_images += current_bullet_image

	hud.update_overlays(round_images)

/datum/component/ammo_hud/eoehoma
	backing_color = "#cb001a"

/datum/component/ammo_hud/eoehoma/update_hud()
	var/obj/item/gun/ballistic/automatic/assault/e40/pew = parent
	var/obj/item/gun/energy/laser/e40_laser_secondary/pew_secondary = pew.secondary
	hud.maptext = null
	hud.icon_state = "[prefix]backing"

	var/indicator
	var/rounds = num2text(get_accurate_ammo_count(pew))
	var/oth_o
	var/oth_t
	var/oth_h

	var/current_firemode = pew.gun_firemodes[pew.firemode_index]
	if(current_firemode == FIREMODE_FULLAUTO)
		if(!pew.magazine)
			hud.set_hud(backing_color, "[prefix]oe", "[prefix]te", "[prefix]he", "[prefix]no_mag")
			return
		if(!pew.get_ammo_count())
			hud.set_hud(backing_color, "[prefix]oe", "[prefix]te", "[prefix]he", "[prefix]empty_flash")
			return
		rounds = num2text(get_accurate_ammo_count(pew))
		indicator = "bullet"
	else
		if(!pew_secondary.installed_cell)
			hud.set_hud(backing_color, "[prefix]oe", "[prefix]te", "[prefix]he", "[prefix]no_mag")
			return
		if(!get_accurate_laser_count(pew_secondary))
			hud.set_hud(backing_color, "[prefix]oe", "[prefix]te", "[prefix]he", "[prefix]empty_flash_laser")
			return
		rounds = num2text(get_accurate_laser_count(pew_secondary))
		indicator = "laser"


	switch(length(rounds))
		if(1)
			oth_o = "[prefix]o[rounds[1]]"
		if(2)
			oth_o = "[prefix]o[rounds[2]]"
			oth_t = "[prefix]t[rounds[1]]"
		if(3)
			oth_o = "[prefix]o[rounds[3]]"
			oth_t = "[prefix]t[rounds[2]]"
			oth_h = "[prefix]h[rounds[1]]"
		else
			oth_o = "[prefix]o9"
			oth_t = "[prefix]t9"
			oth_h = "[prefix]h9"
	hud.set_hud(backing_color, oth_o, oth_t, oth_h, indicator)
