/obj/item/gun/energy
	name = "energy gun"
	desc = "A basic energy-based gun."
	icon = 'icons/obj/guns/energy.dmi'
	icon_state = "laser"

	muzzleflash_iconstate = "muzzle_flash_laser"
	muzzle_flash_color = COLOR_SOFT_RED

	has_safety = TRUE
	safety = TRUE

	modifystate = FALSE
	ammo_x_offset = 2
	ammo_overlay_sections = 4

	gun_firemodes = list(FIREMODE_SEMIAUTO)
	default_firemode = FIREMODE_SEMIAUTO

	fire_select_icon_state_prefix = "laser_"

	default_ammo_type = /obj/item/stock_parts/cell/gun
	allowed_ammo_types = list(
		/obj/item/stock_parts/cell/gun,
		/obj/item/stock_parts/cell/gun/upgraded,
	)

	tac_reloads = FALSE
	tactical_reload_delay = 1.2 SECONDS

	valid_attachments = list(
		/obj/item/attachment/laser_sight,
		/obj/item/attachment/rail_light,
		/obj/item/attachment/bayonet
	)
	slot_available = list(
		ATTACHMENT_SLOT_RAIL = 1
	)
	slot_offsets = list(
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 19,
			"y" = 18,
		)
	)

	reciever_flags = AMMO_RECIEVER_CELL|AMMO_RECIEVER_CYCLE_ONLY_BEFORE_FIRE|AMMO_RECIEVER_DO_NOT_EJECT_HANDFULS
	gun_features_flags = GUN_ENERGY|GUN_AMMO_COUNTER|GUN_AMMO_COUNT_BY_SHOTS_REMAINING

/obj/item/gun/energy/emp_act(severity)
	. = ..()
	if(!(. & EMP_PROTECT_CONTENTS))
		adjust_current_rounds(installed_cell, round(get_ammo_count() / severity))
		chambered = null //we empty the chamber
		recharge_newshot() //and try to charge a new shot
		update_appearance()

/obj/item/gun/energy/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

/obj/item/gun/energy/update_ammo_types()
	var/obj/item/ammo_casing/energy/shot
	for (var/i = 1, i <= ammo_type.len, i++)
		var/shottype = ammo_type[i]
		shot = new shottype(src)
		ammo_type[i] = shot
	shot = ammo_type[select]
	fire_sound = shot.fire_sound
	fire_delay = shot.delay

/obj/item/gun/energy/Destroy()
	if (installed_cell)
		QDEL_NULL(installed_cell)
	STOP_PROCESSING(SSobj, src)
	. = ..()
	ammo_type.Cut()

/obj/item/gun/energy/handle_atom_del(atom/A)
	if(A == installed_cell)
		installed_cell = null
		update_appearance()
	return ..()

/obj/item/gun/energy/process()
	if(selfcharge && installed_cell && installed_cell.percent() < 100)
		charge_tick++
		if(charge_tick < charge_delay)
			return
		charge_tick = 0
		installed_cell.give(1000)
		if(!chambered) //if empty chamber we try to charge a new shot
			recharge_newshot(TRUE)
		update_appearance()

///Drops the bolt from a locked position
/obj/item/gun/energy/unique_action(mob/living/user)
	if(ammo_type.len > 1)
		select_fire(user)
		update_appearance()

/obj/item/gun/energy/can_shoot(visuals)
	if(safety && !visuals)
		return FALSE
	var/obj/item/ammo_casing/energy/shot = ammo_type[select]
	return !QDELETED(installed_cell) ? (get_ammo_count(TRUE) >= shot.rounds_per_shot) : FALSE

/obj/item/gun/energy/recharge_newshot(no_cyborg_drain)
	if (!ammo_type || !installed_cell)
		return
	if(use_cyborg_cell && !no_cyborg_drain)
		if(!iscyborg(loc))
			return
		var/mob/living/silicon/robot/R = loc
		if(!R.cell)
			return
		var/obj/item/ammo_casing/energy/shot = ammo_type[select] //Necessary to find cost of shot
		if(!R.cell.use(shot.rounds_per_shot)) 		//Take power from the borg...
			shoot_with_empty_chamber(R)
			return
		installed_cell.give(shot.rounds_per_shot)	//... to recharge the shot
	if(!chambered)
		var/obj/item/ammo_casing/energy/AC = ammo_type[select]
		if(get_ammo_count(TRUE) >= AC.rounds_per_shot) //if there's enough power in the cell cell...
			chambered = AC //...prepare a new shot based on the current ammo type selected
			if(!chambered.BB)
				chambered.newshot()

/obj/item/gun/energy/process_chamber(atom/shooter)
	if(chambered && !chambered.BB) //if BB is null, i.e the shot has been fired...
		var/obj/item/ammo_casing/energy/shot = chambered
		installed_cell.use(shot.rounds_per_shot)//... drain the cell cell
	chambered = null //either way, released the prepared shot
	recharge_newshot() //try to charge a new shot
	SEND_SIGNAL(src, COMSIG_GUN_CHAMBER_PROCESSED)

/obj/item/gun/energy/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0)
	if(!chambered && can_shoot())
		process_chamber()	// If the gun was drained and then recharged, load a new shot.
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

///Used by update_icon_state() and update_overlays()
/obj/item/gun/energy/get_charge_ratio()
	return can_shoot(visuals = TRUE) ? CEILING(clamp(get_ammo_count() / get_max_ammo(), 0, 1) * ammo_overlay_sections, 1) : 0
	// Sets the ratio to 0 if the gun doesn't have enough charge to fire, or if its power cell is removed.

/obj/item/gun/energy/adjust_current_rounds(obj/item/mag, new_rounds)
	var/obj/item/stock_parts/cell/gun/cell = mag
	return cell?.use(new_rounds)

/obj/item/gun/energy/get_ammo_count(countchambered = TRUE)
	return installed_cell.charge

/obj/item/gun/energy/get_rounds_per_shot()
	var/obj/item/ammo_casing/energy/shot = ammo_type[select]
	return shot.rounds_per_shot

/obj/item/gun/energy/get_max_ammo(countchambered = TRUE)
	return installed_cell.maxcharge

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
			adjust_current_rounds(installed_cell, E.rounds_per_shot)
			. = ""
		else if(BB.damage_type != BURN)
			user.visible_message(span_danger("[user] tries to light [user.p_their()] [A.name] with [src], but only succeeds in utterly destroying it. Dumbass."))
			playsound(user, E.fire_sound, 50, TRUE)
			playsound(user, BB.hitsound_non_living, 50, TRUE)
			adjust_current_rounds(installed_cell, E.rounds_per_shot)
			qdel(A)
			. = ""
		else
			playsound(user, E.fire_sound, 50, TRUE)
			playsound(user, BB.hitsound_non_living, 50, TRUE)
			adjust_current_rounds(installed_cell, E.rounds_per_shot)
			. = span_danger("[user] casually lights their [A.name] with [src]. Damn.")
