#define NO_MAG_GUN_HELPER(gun_type)				\
	/obj/item/gun/ballistic/##gun_type/no_mag {	\
		default_ammo_type = FALSE;				\
	}

#define EMPTY_GUN_HELPER(gun_type)				\
	/obj/item/gun/ballistic/##gun_type/empty {	\
		spawn_no_ammo = TRUE;					\
	}


#define JAM_CHANCE_MINOR 10
#define JAM_GRACE_MINOR 4
#define JAM_CHANCE_MAJOR 30

///Subtype for any kind of ballistic gun
///This has a shitload of vars on it, and I'm sorry for that, but it does make making new subtypes really easy
/obj/item/gun/ballistic
	desc = "Now comes in flavors like GUN. Uses 10x22mm ammo, for some reason."
	name = "projectile gun"

	bad_type = /obj/item/gun/ballistic

	w_class = WEIGHT_CLASS_NORMAL
	has_safety = TRUE
	safety = TRUE
	// when we load the gun, should it instantly chamber the next round?
	var/always_chambers = FALSE
	/// How utterly fucked the gun is. High gun_wear can cause failure to cycle rounds in some guns
	var/gun_wear = 0
	/// How much gun_wear is generated when we shoot. Increased when using surplus rounds
	var/wear_rate = 1 // 60 to malfunction, 180 to critical
	/// Multiplier for wear reduction
	var/clean_rate = 1
	/// Number of times we have successfully fired since the last time the the gun has jammed. Low but not abysmal condition will only jam so often.
	var/last_jam = 0
	/// Gun will start to jam at this level of wear
	var/wear_minor_threshold = 60
	/// Gun will start to jam more at this level of wear. The grace period between jams is also removed for extra fun
	var/wear_major_threshold = 180
	/// Highest wear value so the gun doesn't end up completely irreperable
	var/wear_maximum = 300
	var/ignores_wear = FALSE
	/// Doesn't ever keep ammo when loading a new round into the chamber. Mainly for BOLT_TYPE_NO_BOLT guns.
	var/doesnt_keep_bullet = FALSE

	///If you can examine a gun to see its current ammo count
	var/ammo_counter = FALSE

	min_recoil = 0.1

	valid_attachments = list(
		/obj/item/attachment/silencer,
		/obj/item/attachment/laser_sight,
		/obj/item/attachment/rail_light,
		/obj/item/attachment/bayonet,
		/obj/item/attachment/ammo_counter,
		/obj/item/attachment/gun
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

/obj/item/gun/ballistic/Initialize(mapload, spawn_empty)
	. = ..()

	allowed_ammo_types = typecacheof(allowed_ammo_types) - blacklisted_ammo_types

	if(spawn_empty)
		if(internal_magazine)
			spawn_no_ammo = TRUE
		else
			default_ammo_type = FALSE

	if (!default_ammo_type && !internal_magazine)
		bolt_locked = TRUE
		update_appearance()
		return
	if (ispath(default_ammo_type))
		magazine = new default_ammo_type(src)
	if (spawn_no_ammo)
		get_ammo_list(drop_all = TRUE)
	else
		chamber_round()
	update_appearance()

/obj/item/gun/ballistic/update_icon_state()
	if(current_skin)
		icon_state = "[unique_reskin[current_skin]][sawn_off ? "_sawn" : ""]"
	else
		icon_state = "[base_icon_state || initial(icon_state)][sawn_off ? "_sawn" : ""]"
	return ..()

/obj/item/gun/ballistic/update_overlays()
	. = ..()
	if (bolt_type == BOLT_TYPE_LOCKING)
		. += "[icon_state]_bolt[bolt_locked ? "_locked" : ""]"
	if (bolt_type == BOLT_TYPE_OPEN && bolt_locked)
		. += "[icon_state]_bolt"
	if (show_magazine_on_sprite && magazine)
		if (unique_mag_sprites_for_variants)
			. += "[icon_state]_mag_[magazine.base_icon_state]"
			if (!magazine.ammo_count())
				. += "[icon_state]_mag_[magazine.base_icon_state]_empty"
		else
			. += "[icon_state]_mag"
		if(show_ammo_capacity_on_magazine_sprite)
			var/capacity_number = 0
			switch(get_ammo() / magazine.max_ammo)
				if(0.2 to 0.39)
					capacity_number = 20
				if(0.4 to 0.59)
					capacity_number = 40
				if(0.6 to 0.79)
					capacity_number = 60
				if(0.8 to 0.99)
					capacity_number = 80
				if(1.0 to 2.0) //to catch the chambered round
					capacity_number = 100
			if (capacity_number && unique_mag_sprites_for_variants)
				. += "[icon_state]_mag_[magazine.base_icon_state]_[capacity_number]"
			else if (capacity_number)
				. += "[icon_state]_mag_[capacity_number]"
	if(!chambered && empty_indicator)
		. += "[icon_state]_empty"
	if(chambered && mag_display_ammo)
		. += "[icon_state]_chambered"

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
	if (chamber_next_round && (magazine?.max_ammo >= 1) && !condition_check(from_firing, shooter))
		chamber_round()
	SEND_SIGNAL(src, COMSIG_GUN_CHAMBER_PROCESSED)

/// Handles weapon condition. Returning TRUE prevents process_chamber from automatically loading a new round
/obj/item/gun/ballistic/proc/condition_check(from_firing = TRUE, atom/shooter)
	if(bolt_type == BOLT_TYPE_NO_BOLT || !from_firing || !magazine.ammo_count(FALSE)) //The revolver is one of the most reliable firearms ever designed, as long as you don't need to fire any more than six bullets at something. Which, of course, you do not.
		return FALSE
	last_jam++
	if(gun_wear < wear_minor_threshold)
		return FALSE
	if(gun_wear >= wear_major_threshold ?  prob(JAM_CHANCE_MAJOR) : prob(JAM_CHANCE_MINOR) && last_jam >= JAM_GRACE_MINOR)
		bolt_locked = TRUE
		last_jam = 0 // sighs and erases number on whiteboard
		balloon_alert(shooter, "jammed!")
		playsound(src, 'sound/weapons/gun/general/dry_fire_old.ogg', 50, TRUE, -15) //click. uhoh.
		return TRUE

///Used to chamber a new round and eject the old one
/obj/item/gun/ballistic/proc/chamber_round(keep_bullet = FALSE)
	if (chambered || !magazine)
		return
	if (magazine.ammo_count())
		if(doesnt_keep_bullet)
			chambered = magazine.get_round(FALSE)
		else
			chambered = magazine.get_round(keep_bullet || bolt_type == BOLT_TYPE_NO_BOLT)
		if (bolt_type != BOLT_TYPE_OPEN)
			chambered.forceMove(src)

///updates a bunch of racking related stuff and also handles the sound effects and the like
/obj/item/gun/ballistic/proc/rack(mob/user = null, chamber_new_round = TRUE)
	if (bolt_type == BOLT_TYPE_NO_BOLT) //If there's no bolt, nothing to rack
		return
	if (bolt_type == BOLT_TYPE_OPEN)
		if(!bolt_locked)	//If it's an open bolt, racking again would do nothing
			if (user)
				to_chat(user, span_notice("\The [src]'s [bolt_wording] is already cocked!"))
			return
		bolt_locked = FALSE
	if (user)
		to_chat(user, span_notice("You rack the [bolt_wording] of \the [src]."))
	process_chamber(!chambered, FALSE, chamber_new_round, user)
	if ((bolt_type == BOLT_TYPE_LOCKING && !chambered) || bolt_type == BOLT_TYPE_CLIP)
		bolt_locked = TRUE
		playsound(src, lock_back_sound, lock_back_sound_volume, lock_back_sound_vary)
	else
		playsound(src, rack_sound, rack_sound_volume, rack_sound_vary)

	SEND_SIGNAL(src, COMSIG_UPDATE_AMMO_HUD)

///Drops the bolt from a locked position
/obj/item/gun/ballistic/proc/drop_bolt(mob/user = null, chamber_new_round = TRUE)
	playsound(src, bolt_drop_sound, bolt_drop_sound_volume, FALSE)
	if (user)
		to_chat(user, span_notice("You drop the [bolt_wording] of \the [src]."))
	if(chamber_new_round)
		chamber_round()
	bolt_locked = FALSE
	update_appearance()

///Handles all the logic needed for magazine insertion
/obj/item/gun/ballistic/proc/insert_magazine(mob/user, obj/item/ammo_box/magazine/inserted_mag, display_message = TRUE)
	if(!(inserted_mag.type in allowed_ammo_types))
		to_chat(user, span_warning("\The [inserted_mag] doesn't seem to fit into \the [src]..."))
		return FALSE
	if(user.transferItemToLoc(inserted_mag, src))
		magazine = inserted_mag
		if (display_message)
			to_chat(user, span_notice("You load a new [magazine_wording] into \the [src]."))
		if (magazine.ammo_count())
			playsound(src, load_sound, load_sound_volume, load_sound_vary)
		else
			playsound(src, load_empty_sound, load_sound_volume, load_sound_vary)
		if (bolt_type == BOLT_TYPE_OPEN && !bolt_locked)
			chamber_round(TRUE)
		update_appearance()
		SEND_SIGNAL(src, COMSIG_UPDATE_AMMO_HUD)
		return TRUE
	else
		to_chat(user, span_warning("You cannot seem to get \the [src] out of your hands!"))
		return FALSE

///Handles all the logic of magazine ejection, if tac_load is set that magazine will be tacloaded in the place of the old eject
/obj/item/gun/ballistic/proc/eject_magazine(mob/user, display_message = TRUE, obj/item/ammo_box/magazine/tac_load = null)
	if(bolt_type == BOLT_TYPE_OPEN)
		chambered = null
	if (magazine.ammo_count())
		playsound(src, eject_sound, eject_sound_volume, eject_sound_vary)
	else
		playsound(src, eject_empty_sound, eject_sound_volume, eject_sound_vary)
	magazine.forceMove(drop_location())
	var/obj/item/ammo_box/magazine/old_mag = magazine
	old_mag.update_appearance()
	magazine = null
	if (display_message)
		to_chat(user, span_notice("You pull the [magazine_wording] out of \the [src]."))
	update_appearance()
	SEND_SIGNAL(src, COMSIG_UPDATE_AMMO_HUD)
	if (tac_load)
		if(do_after(user, tactical_reload_delay, src, hidden = TRUE))
			if (insert_magazine(user, tac_load, FALSE))
				to_chat(user, span_notice("You perform a tactical reload on \the [src]."))
			else
				to_chat(user, span_warning("You dropped the old [magazine_wording], but the new one doesn't fit. How embarassing."))
		else
			to_chat(user, span_warning("Your reload was interupted!"))
			return
	if(user)
		user.put_in_hands(old_mag)
	update_appearance()
	SEND_SIGNAL(src, COMSIG_UPDATE_AMMO_HUD)

/obj/item/gun/ballistic/can_shoot()
	if(safety)
		return FALSE
	return chambered

/obj/item/gun/ballistic/attackby(obj/item/A, mob/user, params)
	if(..())
		return FALSE

	if(sealed_magazine)
		to_chat(user, span_warning("The [magazine_wording] on [src] is sealed and cannot be reloaded!"))
		return
	if(!internal_magazine && istype(A, /obj/item/ammo_box/magazine))
		var/obj/item/ammo_box/magazine/AM = A
		if (!magazine)
			insert_magazine(user, AM)
		else
			if (tac_reloads)
				eject_magazine(user, FALSE, AM)
			else
				to_chat(user, span_notice("There's already a [magazine_wording] in \the [src]."))
		return

	if(istype(A, /obj/item/ammo_casing) || istype(A, /obj/item/ammo_box))
		if (bolt_type == BOLT_TYPE_NO_BOLT || internal_magazine)
			if ((chambered && !chambered.BB) || (chambered && always_chambers))
				chambered.on_eject(shooter = user)
				chambered = null
			var/num_loaded = magazine.attackby(A, user, params)
			if (num_loaded)
				to_chat(user, span_notice("You load [num_loaded] [cartridge_wording]\s into \the [src]."))
				playsound(src, load_sound, load_sound_volume, load_sound_vary)
				if ((chambered == null && bolt_type == BOLT_TYPE_NO_BOLT) || always_chambers)
					chamber_round()
				A.update_appearance()
				update_appearance()
			return
	if (can_be_sawn_off)
		if (try_sawoff(user, A))
			return

	return FALSE

///Prefire empty checks for the bolt drop
/obj/item/gun/ballistic/proc/prefire_empty_checks()
	if (!chambered && !get_ammo())
		if (bolt_type == BOLT_TYPE_OPEN && !bolt_locked)
			bolt_locked = TRUE
			playsound(src, bolt_drop_sound, bolt_drop_sound_volume)
			update_appearance()

///postfire empty checks for bolt locking and sound alarms
/obj/item/gun/ballistic/proc/postfire_empty_checks(last_shot_succeeded)
	if (!chambered && !get_ammo())
		if (empty_alarm && last_shot_succeeded)
			playsound(src, empty_alarm_sound, empty_alarm_volume, empty_alarm_vary)
			update_appearance()
		if (empty_autoeject && last_shot_succeeded && !internal_magazine)
			eject_magazine(display_message = FALSE)
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

//ATTACK HAND IGNORING PARENT RETURN VALUE
/obj/item/gun/ballistic/attack_hand(mob/user)
	// the main calls it's own eject mag before the underbarrel. fix this
	if(user.is_holding(src) && loc == user && !(gun_firemodes[firemode_index] == FIREMODE_UNDERBARREL))
		if(sealed_magazine)
			to_chat(user, span_warning("The [magazine_wording] on [src] is sealed and cannot be accessed!"))
			return
		if(bolt_type == BOLT_TYPE_NO_BOLT && (chambered || internal_magazine))
			chambered = null
			var/num_unloaded = 0
			for(var/obj/item/ammo_casing/CB in get_ammo_list(FALSE, TRUE))
				CB.forceMove(drop_location())

				var/angle_of_movement =(rand(-3000, 3000) / 100) + dir2angle(turn(user.dir, 180))
				CB.AddComponent(/datum/component/movable_physics, _horizontal_velocity = rand(350, 450) / 100, _vertical_velocity = rand(400, 450) / 100, _horizontal_friction = rand(20, 24) / 100, _z_gravity = PHYSICS_GRAV_STANDARD, _z_floor = 0, _angle_of_movement = angle_of_movement, _bounce_sound = CB.bounce_sfx_override)

				num_unloaded++
				SSblackbox.record_feedback("tally", "station_mess_created", 1, CB.name)
			if (num_unloaded)
				to_chat(user, span_notice("You unload [num_unloaded] [cartridge_wording]\s from [src]."))
				playsound(user, eject_sound, eject_sound_volume, eject_sound_vary)
				update_appearance()
			else
				to_chat(user, span_warning("[src] is empty!"))
			return
		if(!internal_magazine && magazine)
			eject_magazine(user)
			return
		return ..()
	return ..()

/obj/item/gun/ballistic/unique_action(mob/living/user)
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
	if(!chambered)
		. += "It does not seem to have a round chambered."
	if(bolt_locked)
		. += "The [bolt_wording] is locked back and needs to be released before firing."
	if(ammo_counter)
		var/count_chambered = !(bolt_type == BOLT_TYPE_NO_BOLT || bolt_type == BOLT_TYPE_OPEN)
		. += span_notice("It has <b>[get_ammo(count_chambered)]</b> round\s remaining.")

/obj/item/gun/ballistic/examine_more(mob/user)
	. = ..()
	if(bolt_type != BOLT_TYPE_NO_BOLT && wear_rate)
		. += "You can [bolt_wording] [src] by pressing the <b>unique action</b> key. By default, this is <b>space</b>"
		var/conditionstr = span_boldwarning("critical")
		var/minorhalf = wear_minor_threshold / 2
		var/majorhalf = wear_minor_threshold + (wear_major_threshold-wear_minor_threshold) / 2
		if(gun_wear <= minorhalf)
			conditionstr = span_green("good")
		else if(gun_wear <= wear_minor_threshold)
			conditionstr = span_nicegreen("decent") //nicegreen is less neon than green so it looks less :)))
		else if(gun_wear <= majorhalf)
			conditionstr = span_red("poor")
		else if(gun_wear <= wear_major_threshold) //TTD: switch doesn't play nice with variables but this sucks
			conditionstr = span_warning("terrible")
		. += "it is in [conditionstr] condition[gun_wear >= wear_minor_threshold ? gun_wear >= wear_major_threshold ? " and will suffer constant malfunctions" : " and will suffer from regular malfunctions" :""]."

///Gets the number of bullets in the gun
/obj/item/gun/ballistic/proc/get_ammo(countchambered = TRUE)
	var/boolets = 0 //mature var names for mature people
	if (chambered && countchambered)
		boolets++
	if (magazine)
		boolets += magazine.ammo_count()
	return boolets

///gets a list of every bullet in the gun
/obj/item/gun/ballistic/proc/get_ammo_list(countchambered = TRUE, drop_all = FALSE)
	var/list/rounds = list()
	if(chambered && countchambered)
		rounds.Add(chambered)
		if(drop_all)
			chambered = null
	if(magazine)
		rounds.Add(magazine.ammo_list(drop_all))
	return rounds

/obj/item/gun/ballistic/blow_up(mob/user)
	. = FALSE
	for(var/obj/item/ammo_casing/AC in magazine.stored_ammo)
		if(AC.BB)
			process_fire(user, user, FALSE)
			. = TRUE

/obj/item/gun/ballistic/unsafe_shot(target, empty_chamber = TRUE)
	. = ..()
	process_chamber(empty_chamber,TRUE)

/obj/item/gun/ballistic/proc/adjust_wear(amt)
	if(amt > 0)
		gun_wear = round(clamp(gun_wear + wear_rate * amt, 0, wear_maximum), 0.01)
	else
		gun_wear = round(clamp(gun_wear + clean_rate * amt, 0, wear_maximum), 0.01)

/// Remember: you can always trust a loaded gun to go off at least once.
/obj/item/gun/ballistic/proc/accidents_happen(mob/darwin)
	. = TRUE
	if(safety)
		return FALSE
	if(!magazine && !chambered)
		return
	if(internal_magazine && !magazine.ammo_count(TRUE))
		return
	if(prob(0.5)) //this gets called I think once per decisecond so we don't really want a high chance here
		if(!chambered)
			to_chat(darwin, span_warning("You accidentally chamber a round-"))
			chamber_round()
			return
		to_chat(darwin, span_boldwarning("The trigger on [src] gets caught-"))
		unsafe_shot(darwin)
		return FALSE
