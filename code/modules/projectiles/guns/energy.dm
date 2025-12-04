/obj/item/gun/energy
	name = "energy gun"
	desc = "A basic energy-based gun."
	icon = 'icons/obj/guns/energy.dmi'
	icon_state = "laser"
	item_state = "spur"

	bad_type = /obj/item/gun/energy

	muzzleflash_iconstate = "muzzle_flash_laser"
	light_color = COLOR_SOFT_RED

	has_safety = TRUE
	safety = TRUE

	modifystate = FALSE
	ammo_x_offset = 2

	gun_firemodes = list(FIREMODE_SEMIAUTO)
	default_firemode = FIREMODE_SEMIAUTO

	fire_select_icon_state_prefix = "laser_"

	///Ammotype index -- this is the currently selected ammo type
	var/ammotype_index

	default_ammo_type = /obj/item/stock_parts/cell/gun
	allowed_ammo_types = list(
		/obj/item/stock_parts/cell/gun,
		/obj/item/stock_parts/cell/gun/upgraded,
		/obj/item/stock_parts/cell/gun/empty,
		/obj/item/stock_parts/cell/gun/upgraded/empty,
	)

	tac_reloads = FALSE
	tactical_reload_delay = 1.2 SECONDS

	var/latch_closed = TRUE
	var/latch_toggle_delay = 0.6 SECONDS

	valid_attachments = list(
		/obj/item/attachment/laser_sight,
		/obj/item/attachment/rail_light,
		/obj/item/attachment/bayonet,
	)
	slot_available = list(
		ATTACHMENT_SLOT_RAIL = 1,
		ATTACHMENT_SLOT_MUZZLE = 1
	)
	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 26,
			"y" = 20,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 19,
			"y" = 18,
		),
		ATTACHMENT_SLOT_SCOPE = list(
			"x" = 21,
			"y" = 24,
		)
	)

/obj/item/gun/energy/emp_act(severity)
	. = ..()
	if(!(. & EMP_PROTECT_CONTENTS))
		if(prob(GUN_NO_SAFETY_MALFUNCTION_CHANCE_HIGH))
			discharge("malfunctions from the EMP")
		cell.use(round(cell.charge / severity))
		chambered = null //we empty the chamber
		recharge_newshot() //and try to charge a new shot
		update_appearance()

/obj/item/gun/energy/get_cell()
	return cell

/obj/item/gun/energy/Initialize(mapload, spawn_empty)
	. = ..()
	if(spawn_empty)
		if(internal_magazine)
			spawn_no_ammo = TRUE
		else
			default_ammo_type = FALSE

	if(default_ammo_type)
		cell = new default_ammo_type(src, spawn_no_ammo)
	build_ammotypes()
	update_ammo_types()
	recharge_newshot(TRUE)
	if(selfcharge)
		START_PROCESSING(SSobj, src)
	update_appearance()

/obj/item/gun/energy/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

/obj/item/gun/energy/proc/update_ammo_types()
	var/obj/item/ammo_casing/energy/shot
	for (var/i = 1, i <= ammo_type.len, i++)
		var/shottype = ammo_type[i]
		shot = new shottype(src)
		ammo_type[i] = shot
	shot = ammo_type[select]
	fire_sound = shot.fire_sound
	fire_delay = shot.delay

/obj/item/gun/energy/Destroy()
	if (cell)
		QDEL_NULL(cell)
	STOP_PROCESSING(SSobj, src)
	. = ..()
	ammo_type.Cut()

/obj/item/gun/energy/handle_atom_del(atom/A)
	if(A == cell)
		cell = null
		update_appearance()
	return ..()

/obj/item/gun/energy/process(seconds_per_tick)
	if(selfcharge && cell && cell.percent() < 100)
		charge_timer += seconds_per_tick
		if(charge_timer < charge_delay)
			return
		charge_timer = 0
		cell.give(1000) //WS Edit - Egun energy cells
		if(!chambered) //if empty chamber we try to charge a new shot
			recharge_newshot(TRUE)
		update_appearance()

//ATTACK HAND IGNORING PARENT RETURN VALUE
/obj/item/gun/energy/attack_hand(mob/user)
	if(!internal_magazine && loc == user && user.is_holding(src) && cell && tac_reloads && !(gun_firemodes[firemode_index] == FIREMODE_UNDERBARREL))
		eject_cell(user)
		return
	return ..()

/obj/item/gun/energy/attackby(obj/item/A, mob/user, params)
	if(..())
		return FALSE

	if (!internal_magazine && (A.type in (allowed_ammo_types - blacklisted_ammo_types)))
		var/obj/item/stock_parts/cell/gun/C = A
		if (!cell)
			return insert_cell(user, C)
		else
			if (tac_reloads)
				eject_cell(user, C)

/obj/item/gun/energy/proc/insert_cell(mob/user, obj/item/stock_parts/cell/gun/C)
	if(!latch_closed)
		if(user.transferItemToLoc(C, src))
			cell = C
			to_chat(user, span_notice("You load the [C] into \the [src]."))
			playsound(src, load_sound, load_sound_volume, load_sound_vary)
			update_appearance()
			return TRUE
		else
			to_chat(user, span_warning("You cannot seem to get \the [src] out of your hands!"))
			return FALSE
	else
		to_chat(user, span_warning("The [src]'s cell retainment clip is latched!"))
		return FALSE

/obj/item/gun/energy/proc/eject_cell(mob/user, obj/item/stock_parts/cell/gun/tac_load = null)
	playsound(src, load_sound, load_sound_volume, load_sound_vary)
	cell.forceMove(drop_location())
	var/obj/item/stock_parts/cell/gun/old_cell = cell
	old_cell.update_appearance()
	cell = null
	update_appearance()
	if(user)
		to_chat(user, span_notice("You pull the cell out of \the [src]."))
		if(tac_load && tac_reloads)
			if(do_after(user, tactical_reload_delay, src, hidden = TRUE))
				if(insert_cell(user, tac_load))
					to_chat(user, span_notice("You perform a tactical reload on \the [src]."))
				else
					to_chat(user, span_warning("You dropped the old cell, but the new one doesn't fit. How embarassing."))
			else
				to_chat(user, span_warning("Your reload was interupted!"))
				return

		user.put_in_hands(old_cell)
	update_appearance()

//special is_type_in_list method to counteract problem with current method
/obj/item/gun/energy/proc/is_attachment_in_contents_list()
	for(var/content_item in contents)
		if(istype(content_item, /obj/item/attachment/))
			return TRUE
	return FALSE

/obj/item/gun/energy/unique_action(mob/living/user)
	if(..())
		return
	if(!internal_magazine && latch_closed)
		to_chat(user, span_notice("You start to unlatch the [src]'s power cell retainment clip..."))
		if(do_after(user, latch_toggle_delay, src, IGNORE_USER_LOC_CHANGE))
			to_chat(user, span_notice("You unlatch the [src]'s power cell retainment clip " + span_red("OPEN") + "."))
			playsound(src, 'sound/items/taperecorder/taperecorder_play.ogg', 50, FALSE)
			tac_reloads = TRUE
			latch_closed = FALSE
			update_appearance()
	else if(!internal_magazine && !latch_closed)
		// if(!cell && is_attachment_in_contents_list())
		// 	return ..() //should bring up the attachment menu if attachments are added. If none are added, it just does leaves the latch open
		to_chat(user, span_warning("You start to latch the [src]'s power cell retainment clip..."))
		if (do_after(user, latch_toggle_delay, src, IGNORE_USER_LOC_CHANGE))
			to_chat(user, span_notice("You latch the [src]'s power cell retainment clip " + span_green("CLOSED") + "."))
			playsound(src, 'sound/items/taperecorder/taperecorder_close.ogg', 50, FALSE)
			tac_reloads = FALSE
			latch_closed = TRUE
			update_appearance()
	return

/obj/item/gun/energy/can_shoot(visuals)
	if(safety && !visuals)
		return FALSE
	var/obj/item/ammo_casing/energy/shot = ammo_type[select]
	return !QDELETED(cell) ? (cell.charge >= shot.e_cost) : FALSE

/obj/item/gun/energy/recharge_newshot(no_cyborg_drain)
	if (!ammo_type || !cell)
		return
	if(use_cyborg_cell && !no_cyborg_drain)
		if(!iscyborg(loc))
			return
		var/mob/living/silicon/robot/R = loc
		if(!R.cell)
			return
		var/obj/item/ammo_casing/energy/shot = ammo_type[select] //Necessary to find cost of shot
		if(!R.cell.use(shot.e_cost)) 		//Take power from the borg...
			shoot_with_empty_chamber(R)
			return
		cell.give(shot.e_cost)	//... to recharge the shot
	if(!chambered)
		var/obj/item/ammo_casing/energy/AC = ammo_type[select]
		if(cell.charge >= AC.e_cost) //if there's enough power in the cell cell...
			chambered = AC //...prepare a new shot based on the current ammo type selected
			if(!chambered.BB)
				chambered.newshot()

/obj/item/gun/energy/process_chamber(atom/shooter)
	if(chambered && !chambered.BB) //if BB is null, i.e the shot has been fired...
		var/obj/item/ammo_casing/energy/shot = chambered
		cell.use(shot.e_cost)//... drain the cell cell
	chambered = null //either way, released the prepared shot
	recharge_newshot() //try to charge a new shot
	SEND_SIGNAL(src, COMSIG_GUN_CHAMBER_PROCESSED)

/obj/item/gun/energy/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0)
	if(!chambered && can_shoot())
		process_chamber()	// If the gun was drained and then recharged, load a new shot.
	..() //process the gunshot as normal
	if((!latch_closed && prob(65)) && (cell != null)) //make the cell slide out if it's fired while the retainment clip is unlatched, with a 65% probability
		to_chat(user, span_warning("The [src]'s cell falls out!"))
		eject_cell()
	return

/obj/item/gun/energy/proc/build_ammotypes()
	for(var/datum/action/item_action/toggle_ammotype/old_ammotype in actions)
		old_ammotype.Destroy()
	var/datum/action/item_action/our_action

	if(ammo_type.len > 1)
		our_action = new /datum/action/item_action/toggle_ammotype(src)

		for(var/i=1, i <= ammo_type.len, i++)
			if(default_ammo_type == ammo_type[i])
				ammotype_index = i
				if(our_action)
					our_action.UpdateButtonIcon()
				return
		ammotype_index = 1

/obj/item/gun/energy/ui_action_click(mob/user, actiontype)
	if (istype(actiontype, /datum/action/item_action/toggle_ammotype))
		select_fire(user)
		update_appearance()
	else
		..()

/datum/action/item_action/toggle_ammotype/UpdateButtonIcon(status_only = FALSE, force = FALSE)
	var/obj/item/gun/energy/our_gun = target
	var/obj/item/ammo_casing/energy/shot = our_gun.ammo_type[our_gun.select]
	var/current_ammotype = shot.select_name

	var/manufacturer_prefix = "fallback"
	if (our_gun.manufacturer == MANUFACTURER_EOEHOMA)
		manufacturer_prefix = "eoehoma"
	else if (our_gun.manufacturer == MANUFACTURER_SHARPLITE_NEW)
		manufacturer_prefix = "sharplite"
	else if (our_gun.manufacturer == MANUFACTURER_PGF)
		manufacturer_prefix = "etherbor"
	else
		current_ammotype = "fallback"

	current_ammotype = lowertext(current_ammotype)

	// A list of all ammotypes that have icons for them
	if (!(current_ammotype in list("kill", "disable", "overcharge", "stun", "ion", "energy", "ar", "dmr")))
		current_ammotype = "fallback"

	button_icon_state = "[manufacturer_prefix]["_laser_"][current_ammotype]"

	return ..()

/obj/item/gun/energy/proc/select_fire(mob/living/user)
	select++
	if (select > ammo_type.len)
		select = 1
	var/obj/item/ammo_casing/energy/shot = ammo_type[select]
	fire_sound = shot.fire_sound
	fire_delay = shot.delay
	if (shot.select_name)
		to_chat(user, span_notice("[src] is now set to [shot.select_name]."))
	chambered = null
	playsound(user, 'sound/weapons/gun/general/selector.ogg', 100, TRUE)
	recharge_newshot(TRUE)
	update_appearance()
	return

/obj/item/gun/energy/update_icon_state()
	if(initial(item_state))
		return ..()
	var/ratio = get_charge_ratio()
	var/new_item_state = ""
	new_item_state = initial(icon_state)
	if(modifystate)
		var/obj/item/ammo_casing/energy/shot = ammo_type[select]
		new_item_state += "[shot.select_name]"
	new_item_state += "[ratio]"
	item_state = new_item_state
	return ..()

/obj/item/gun/energy/update_overlays()
	. = ..()
	if(!automatic_charge_overlays || QDELETED(src))
		return
	// Every time I see code this "flexible", a kitten fucking dies //it got worse
	//todo: refactor this a bit to allow showing of charge on a gun's cell
	var/overlay_icon_state = "[icon_state]_charge"
	var/obj/item/ammo_casing/energy/shot = ammo_type[modifystate ? select : 1]
	var/ratio = get_charge_ratio()
	if(ismob(loc) && !internal_magazine)
		var/mutable_appearance/latch_overlay
		latch_overlay = mutable_appearance('icons/obj/guns/cell_latch.dmi')
		if(latch_closed)
			if(cell)
				latch_overlay.icon_state = "latch-on-full"
			else
				latch_overlay.icon_state = "latch-on-empty"
		else
			if(cell)
				latch_overlay.icon_state = "latch-off-full"
			else
				latch_overlay.icon_state = "latch-off-empty"
		. += latch_overlay
	if(cell)
		. += "[icon_state]_cell"
		if(ratio == 0)
			. += "[icon_state]_cellempty"
	if(ratio == 0)
		if(modifystate)
			. += "[icon_state]_[shot.select_name]"
		. += "[icon_state]_empty"
	else
		if(!shaded_charge)
			if(modifystate)
				. += "[icon_state]_[shot.select_name]"
				overlay_icon_state += "_[shot.select_name]"
			var/mutable_appearance/charge_overlay = mutable_appearance(icon, overlay_icon_state)
			for(var/i = ratio, i >= 1, i--)
				charge_overlay.pixel_x = ammo_x_offset * (i - 1)
				charge_overlay.pixel_y = ammo_y_offset * (i - 1)
				. += new /mutable_appearance(charge_overlay)
		else
			if(modifystate)
				. += "[icon_state]_charge[ratio]_[shot.select_name]" //:drooling_face:
			else
				. += "[icon_state]_charge[ratio]"

///Used by update_icon_state() and update_overlays()
/obj/item/gun/energy/proc/get_charge_ratio()
	return can_shoot(visuals = TRUE) ? CEILING(clamp(cell.charge / cell.maxcharge, 0, 1) * charge_sections, 1) : 0
	// Sets the ratio to 0 if the gun doesn't have enough charge to fire, or if its power cell is removed.

/obj/item/gun/energy/vv_edit_var(var_name, var_value)
	switch(var_name)
		if(NAMEOF(src, selfcharge))
			if(var_value)
				START_PROCESSING(SSobj, src)
			else
				STOP_PROCESSING(SSobj, src)
	. = ..()


/obj/item/gun/energy/ignition_effect(atom/A, mob/living/user)
	if(!can_shoot() || !ammo_type[select])
		shoot_with_empty_chamber()
		. = ""
	else
		var/obj/item/ammo_casing/energy/E = ammo_type[select]
		var/obj/projectile/energy/BB = E.BB
		if(!BB)
			. = ""
		else if(BB.nodamage || !BB.damage || BB.damage_type == STAMINA)
			user.visible_message(span_danger("[user] tries to light [user.p_their()] [A.name] with [src], but it doesn't do anything. Dumbass."))
			playsound(user, E.fire_sound, 50, TRUE)
			playsound(user, BB.hitsound_non_living, 50, TRUE)
			cell.use(E.e_cost)
			. = ""
		else if(BB.damage_type != BURN)
			user.visible_message(span_danger("[user] tries to light [user.p_their()] [A.name] with [src], but only succeeds in utterly destroying it. Dumbass."))
			playsound(user, E.fire_sound, 50, TRUE)
			playsound(user, BB.hitsound_non_living, 50, TRUE)
			cell.use(E.e_cost)
			qdel(A)
			. = ""
		else
			playsound(user, E.fire_sound, 50, TRUE)
			playsound(user, BB.hitsound_non_living, 50, TRUE)
			cell.use(E.e_cost)
			. = span_danger("[user] casually lights their [A.name] with [src]. Damn.")


/obj/item/gun/energy/examine(mob/user)
	. = ..()
	if(!internal_magazine)
		. += "The cell retainment latch is [latch_closed ? span_green("CLOSED") : span_red("OPEN")]. Press the Unique Action Key to toggle the latch. By default, this is <b>space</b>."
	var/obj/item/ammo_casing/energy/shot = ammo_type[select]
	if(ammo_type.len > 1)
		. += "You can switch ammo modes by pressing the <b>Ammo Toggle</b> button."
	if(cell)
		. += "\The [name]'s cell has [cell.percent()]% charge remaining."
		. += "\The [name] has [round(cell.charge/shot.e_cost)] shots remaining on <b>[shot.select_name]</b> mode."
	else
		. += span_notice("\The [name] doesn't seem to have a cell!")

/obj/item/gun/energy/unsafe_shot(target)
	. = ..()
	process_chamber()
