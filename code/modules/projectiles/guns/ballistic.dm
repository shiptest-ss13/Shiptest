#define EMPTY_GUN_HELPER(gun_type)				\
	/obj/item/gun/ballistic/##gun_type/no_mag {	\
		default_ammo_type = null;				\
	}

///Subtype for any kind of ballistic gun
///This has a shitload of vars on it, and I'm sorry for that, but it does make making new subtypes really easy
/obj/item/gun/ballistic
	desc = "Now comes in flavors like GUN. Uses 10mm ammo, for some reason."
	name = "projectile gun"
	w_class = WEIGHT_CLASS_NORMAL

	has_safety = TRUE
	safety = TRUE

	min_recoil = 0.25

	valid_attachments = list(
		/obj/item/attachment/silencer,
		/obj/item/attachment/laser_sight,
		/obj/item/attachment/rail_light,
		/obj/item/attachment/bayonet
	)
	slot_available = list(
		ATTACHMENT_SLOT_MUZZLE = 1,
		ATTACHMENT_SLOT_RAIL = 1
	)
	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 26,
			"y" = 20,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 19,
			"y" = 18,
		)
	)

/obj/item/gun/ballistic/process_chamber(empty_chamber = TRUE, from_firing = TRUE, chamber_next_round = TRUE, atom/shooter)
	if(!semi_auto && from_firing)
		return
	var/obj/item/ammo_casing/casing = chambered //Find chambered round
	if(istype(casing)) //there's a chambered round
		if(casing_ejector || !from_firing)
			casing.on_eject(shooter)
			chambered = null
		else if(empty_chamber)
			chambered = null
	if (chamber_next_round && (magazine?.max_ammo > 1))
		chamber_round()
	SEND_SIGNAL(src, COMSIG_GUN_CHAMBER_PROCESSED)

///Used to chamber a new round and eject the old one
/obj/item/gun/ballistic/chamber_round(keep_bullet = FALSE)
	if (chambered || !magazine)
		return
	if (magazine.ammo_count())
		chambered = magazine.get_round(keep_bullet || bolt_type == BOLT_TYPE_NO_BOLT)
		if (bolt_type != BOLT_TYPE_OPEN)
			chambered.forceMove(src)

///updates a bunch of racking related stuff and also handles the sound effects and the like
/obj/item/gun/ballistic/rack(mob/user = null, chamber_new_round = TRUE)
	if (bolt_type == BOLT_TYPE_NO_BOLT) //If there's no bolt, nothing to rack
		return
	if (bolt_type == BOLT_TYPE_OPEN)
		if(!bolt_locked)	//If it's an open bolt, racking again would do nothing
			if (user)
				to_chat(user, "<span class='notice'>\The [src]'s [bolt_wording] is already cocked!</span>")
			return
		bolt_locked = FALSE
	if (user)
		to_chat(user, "<span class='notice'>You rack the [bolt_wording] of \the [src].</span>")
	process_chamber(!chambered, FALSE, chamber_new_round, user)
	if ((bolt_type == BOLT_TYPE_LOCKING && !chambered) || bolt_type == BOLT_TYPE_CLIP)
		bolt_locked = TRUE
		playsound(src, lock_back_sound, lock_back_sound_volume, lock_back_sound_vary)
	else
		playsound(src, rack_sound, rack_sound_volume, rack_sound_vary)

	SEND_SIGNAL(src, COMSIG_UPDATE_AMMO_HUD)

///Drops the bolt from a locked position
/obj/item/gun/ballistic/drop_bolt(mob/user = null, chamber_new_round = TRUE)
	playsound(src, bolt_drop_sound, bolt_drop_sound_volume, FALSE)
	if (user)
		to_chat(user, "<span class='notice'>You drop the [bolt_wording] of \the [src].</span>")
	if(chamber_new_round)
		chamber_round()
	bolt_locked = FALSE
	update_appearance()

///Prefire empty checks for the bolt drop
/obj/item/gun/ballistic/prefire_empty_checks()
	if (!chambered && !get_ammo_count())
		if (bolt_type == BOLT_TYPE_OPEN && !bolt_locked)
			bolt_locked = TRUE
			playsound(src, bolt_drop_sound, bolt_drop_sound_volume)
			update_appearance()

///postfire empty checks for bolt locking and sound alarms
/obj/item/gun/ballistic/postfire_empty_checks(last_shot_succeeded)
	if (!chambered && !get_ammo_count())
		if (empty_alarm && last_shot_succeeded)
			playsound(src, empty_alarm_sound, empty_alarm_volume, empty_alarm_vary)
			update_appearance()
		if (reciever_flags & AMMO_RECIEVER_AUTO_EJECT && last_shot_succeeded && !internal_magazine)
			eject_mag(display_message = FALSE)
			update_appearance()
		if (last_shot_succeeded && bolt_type == BOLT_TYPE_LOCKING)
			bolt_locked = TRUE
			update_appearance()
		if (last_shot_succeeded && bolt_type == BOLT_TYPE_CLIP)
			update_appearance()

/obj/item/gun/ballistic/pre_fire(atom/target, mob/living/user,  message = TRUE, flag, params = null, zone_override = "", bonus_spread = 0, dual_wielded_gun = FALSE)
	prefire_empty_checks()
	return ..()

/obj/item/gun/ballistic/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0, burst_firing = FALSE, spread_override = 0, iteration = 0)
	. = ..() //The gun actually firing
	postfire_empty_checks(.)

/obj/item/gun/ballistic/unique_action(mob/living/user)
	if(bolt_type == BOLT_TYPE_NO_BOLT)
		chambered = null
		var/num_unloaded = 0
		for(var/obj/item/ammo_casing/CB in get_ammo_list(FALSE, TRUE))
			CB.forceMove(drop_location())

			var/angle_of_movement =(rand(-3000, 3000) / 100) + dir2angle(turn(user.dir, 180))
			CB.AddComponent(/datum/component/movable_physics, _horizontal_velocity = rand(350, 450) / 100, _vertical_velocity = rand(400, 450) / 100, _horizontal_friction = rand(20, 24) / 100, _z_gravity = PHYSICS_GRAV_STANDARD, _z_floor = 0, _angle_of_movement = angle_of_movement, _bounce_sound = CB.bounce_sfx_override)

			num_unloaded++
			SSblackbox.record_feedback("tally", "station_mess_created", 1, CB.name)
		if (num_unloaded)
			to_chat(user, "<span class='notice'>You unload [num_unloaded] [cartridge_wording]\s from [src].</span>")
			playsound(user, eject_sound, eject_sound_volume, eject_sound_vary)
			update_appearance()
		else
			to_chat(user, "<span class='warning'>[src] is empty!</span>")
		return
	if((bolt_type == BOLT_TYPE_LOCKING || bolt_type == BOLT_TYPE_CLIP) && bolt_locked)
		drop_bolt(user)
		return

	if (recent_rack > world.time)
		return
	recent_rack = world.time + rack_delay
	if(bolt_type == BOLT_TYPE_CLIP)
		rack(user, FALSE)
		update_appearance()
		return
	rack(user)
	update_appearance()
	return


/obj/item/gun/ballistic/examine(mob/user)
	. = ..()
	if (bolt_locked)
		. += span_notice("The [bolt_wording] is locked back and needs to be released before firing.")
	. += span_info("You can [bolt_wording] it by pressing the <b>unique action</b> key. By default, this is <b>Space</b>")

/*
/obj/item/gun/ballistic/adjust_current_rounds(obj/item/mag, new_rounds)
	var/obj/item/ammo_box/magazine/magazine = mag
	magazine?.current_rounds += new_rounds
*/

///Gets the number of bullets in the gun
/obj/item/gun/ballistic/get_ammo_count(countchambered = TRUE)
	var/rounds = 0
	if (chambered && countchambered)
		rounds++
	if (magazine)
		rounds += magazine?.ammo_count()
	return rounds

/obj/item/gun/ballistic/get_max_ammo(countchamber = TRUE)
	var/rounds = 0
	rounds = magazine?.max_ammo
	if(countchamber)
		rounds += 1
	return rounds

///gets a list of every bullet in the gun
/obj/item/gun/ballistic/get_ammo_list(countchambered = TRUE, drop_all = FALSE)
	var/list/rounds = list()
	if(chambered && countchambered)
		rounds.Add(chambered)
		if(drop_all)
			chambered = null
	rounds.Add(magazine.ammo_list(drop_all))
	return rounds

///used for sawing guns, causes the gun to fire without the input of the user
/obj/item/gun/ballistic/blow_up(mob/user)
	. = FALSE
	for(var/obj/item/ammo_casing/AC in magazine.stored_ammo)
		if(AC.BB)
			process_fire(user, user, FALSE)
			. = TRUE
