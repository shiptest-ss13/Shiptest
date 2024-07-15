#define EMPTY_GUN_HELPER(gun_type)				\
	/obj/item/gun/ballistic/##gun_type/no_mag {	\
		spawnwithmagazine = FALSE;				\
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

/obj/item/gun/ballistic/Initialize()
	. = ..()
	if (!spawnwithmagazine && !ispath(mag_type, /obj/item/ammo_box/magazine/internal))
		bolt_locked = TRUE
		update_appearance()
		return
	if (!magazine)
		magazine = new mag_type(src)
	if (!spawnwithmagazine)
		get_ammo_list (drop_all = TRUE)
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
	if (magazine)
		if (unique_mag_sprites_for_variants)
			. += "[icon_state]_mag_[magazine.base_icon_state]"
			if (!magazine.ammo_count())
				. += "[icon_state]_mag_empty"
		else
			. += "[icon_state]_mag"
			var/capacity_number = 0
			capacity_number = ROUND_UP((get_ammo_count() / get_max_ammo()) * ammo_overlay_sections)
			if (capacity_number)
				. += "[icon_state]_mag_[capacity_number]"
	if(!chambered && empty_indicator)
		. += "[icon_state]_empty"

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
/obj/item/gun/ballistic/proc/chamber_round(keep_bullet = FALSE)
	if (chambered || !magazine)
		return
	if (magazine.ammo_count())
		chambered = magazine.get_round(keep_bullet || bolt_type == BOLT_TYPE_NO_BOLT)
		if (bolt_type != BOLT_TYPE_OPEN)
			chambered.forceMove(src)

///updates a bunch of racking related stuff and also handles the sound effects and the like
/obj/item/gun/ballistic/proc/rack(mob/user = null)
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
	process_chamber(!chambered, FALSE, shooter = user)
	if (bolt_type == BOLT_TYPE_LOCKING && !chambered)
		bolt_locked = TRUE
		playsound(src, lock_back_sound, lock_back_sound_volume, lock_back_sound_vary)
	else
		playsound(src, rack_sound, rack_sound_volume, rack_sound_vary)
	update_appearance()
	SEND_SIGNAL(src, COMSIG_UPDATE_AMMO_HUD)

///Drops the bolt from a locked position
/obj/item/gun/ballistic/proc/drop_bolt(mob/user = null)
	playsound(src, bolt_drop_sound, bolt_drop_sound_volume, FALSE)
	if (user)
		to_chat(user, "<span class='notice'>You drop the [bolt_wording] of \the [src].</span>")
	chamber_round()
	bolt_locked = FALSE
	update_appearance()

///Handles all the logic needed for magazine insertion
/obj/item/gun/ballistic/proc/insert_magazine(mob/user, obj/item/ammo_box/magazine/inserted_mag, display_message = TRUE)
	if(!istype(inserted_mag, mag_type))
		to_chat(user, "<span class='warning'>\The [inserted_mag] doesn't seem to fit into \the [src]...</span>")
		return FALSE
	if(user.transferItemToLoc(inserted_mag, src))
		magazine = inserted_mag
		if (display_message)
			to_chat(user, "<span class='notice'>You load a new [magazine_wording] into \the [src].</span>")
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
		to_chat(user, "<span class='warning'>You cannot seem to get \the [src] out of your hands!</span>")
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
		to_chat(user, "<span class='notice'>You pull the [magazine_wording] out of \the [src].</span>")
	update_appearance()
	SEND_SIGNAL(src, COMSIG_UPDATE_AMMO_HUD)
	if (tac_load)
		if(do_after(user, tactical_reload_delay, src, hidden = TRUE))
			if (insert_magazine(user, tac_load, FALSE))
				to_chat(user, "<span class='notice'>You perform a tactical reload on \the [src].</span>")
			else
				to_chat(user, "<span class='warning'>You dropped the old [magazine_wording], but the new one doesn't fit. How embarassing.</span>")
		else
			to_chat(user, "<span class='warning'>Your reload was interupted!</span>")
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
	. = ..()
	if (.)
		return
	if (!internal_magazine && istype(A, /obj/item/ammo_box/magazine))
		var/obj/item/ammo_box/magazine/AM = A
		if (!magazine)
			insert_magazine(user, AM)
		else
			if (tac_reloads)
				eject_magazine(user, FALSE, AM)
			else
				to_chat(user, "<span class='notice'>There's already a [magazine_wording] in \the [src].</span>")
		return
	if (istype(A, /obj/item/ammo_casing) || istype(A, /obj/item/ammo_box))
		if (bolt_type == BOLT_TYPE_NO_BOLT || internal_magazine)
			if (chambered && !chambered.BB)
				chambered.on_eject(shooter = user)
				chambered = null
			var/num_loaded = magazine.attackby(A, user, params)
			if (num_loaded)
				to_chat(user, "<span class='notice'>You load [num_loaded] [cartridge_wording]\s into \the [src].</span>")
				playsound(src, load_sound, load_sound_volume, load_sound_vary)
				if (chambered == null && bolt_type == BOLT_TYPE_NO_BOLT)
					chamber_round()
				A.update_appearance()
				update_appearance()
			return
	if (can_be_sawn_off)
		if (sawoff(user, A))
			return
	return FALSE

///Prefire empty checks for the bolt drop
/obj/item/gun/ballistic/proc/prefire_empty_checks()
	if (!chambered && !get_ammo_count())
		if (bolt_type == BOLT_TYPE_OPEN && !bolt_locked)
			bolt_locked = TRUE
			playsound(src, bolt_drop_sound, bolt_drop_sound_volume)
			update_appearance()

///postfire empty checks for bolt locking and sound alarms
/obj/item/gun/ballistic/proc/postfire_empty_checks(last_shot_succeeded)
	if (!chambered && !get_ammo_count())
		if (empty_alarm && last_shot_succeeded)
			playsound(src, empty_alarm_sound, empty_alarm_volume, empty_alarm_vary)
			update_appearance()
		if (empty_autoeject && last_shot_succeeded && !internal_magazine)
			eject_magazine(display_message = FALSE)
			update_appearance()
		if (last_shot_succeeded && bolt_type == BOLT_TYPE_LOCKING)
			bolt_locked = TRUE
			update_appearance()

/obj/item/gun/ballistic/pre_fire(atom/target, mob/living/user,  message = TRUE, flag, params = null, zone_override = "", bonus_spread = 0, dual_wielded_gun = FALSE)
	prefire_empty_checks()
	return ..()

/obj/item/gun/ballistic/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0, burst_firing = FALSE, spread_override = 0, iteration = 0)
	. = ..() //The gun actually firing
	postfire_empty_checks(.)

//ATTACK HAND IGNORING PARENT RETURN VALUE
/obj/item/gun/ballistic/attack_hand(mob/user)
	if(!internal_magazine && loc == user && user.is_holding(src) && magazine)
		eject_magazine(user)
		return
	return ..()

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
	if(bolt_type == BOLT_TYPE_LOCKING && bolt_locked)
		drop_bolt(user)
		return
	if (recent_rack > world.time)
		return
	recent_rack = world.time + rack_delay
	rack(user)
	return


/obj/item/gun/ballistic/examine(mob/user)
	. = ..()
	var/count_chambered = !(bolt_type == BOLT_TYPE_NO_BOLT || bolt_type == BOLT_TYPE_OPEN)
	. += "It has [get_ammo_count(count_chambered)] round\s remaining."
	if (!chambered)
		. += "It does not seem to have a round chambered."
	if (bolt_locked)
		. += "The [bolt_wording] is locked back and needs to be released before firing."
	. += "You can [bolt_wording] [src] by pressing the <b>unqiue action</b> key. By default, this is <b>space</b>"

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
/obj/item/gun/ballistic/proc/get_ammo_list(countchambered = TRUE, drop_all = FALSE)
	var/list/rounds = list()
	if(chambered && countchambered)
		rounds.Add(chambered)
		if(drop_all)
			chambered = null
	rounds.Add(magazine.ammo_list(drop_all))
	return rounds

GLOBAL_LIST_INIT(gun_saw_types, typecacheof(list(
	/obj/item/gun/energy/plasmacutter,
	/obj/item/melee/transforming/energy,
	)))

///Handles all the logic of sawing off guns,
/obj/item/gun/ballistic/proc/sawoff(mob/user, obj/item/saw)
	if(!saw.get_sharpness() || !is_type_in_typecache(saw, GLOB.gun_saw_types) && saw.tool_behaviour != TOOL_SAW) //needs to be sharp. Otherwise turned off eswords can cut this.
		return
	if(sawn_off)
		to_chat(user, "<span class='warning'>\The [src] is already shortened!</span>")
		return
	user.changeNext_move(CLICK_CD_MELEE)
	user.visible_message("<span class='notice'>[user] begins to shorten \the [src].</span>", "<span class='notice'>You begin to shorten \the [src]...</span>")

	//if there's any live ammo inside the gun, makes it go off
	if(blow_up(user))
		user.visible_message("<span class='danger'>\The [src] goes off!</span>", "<span class='danger'>\The [src] goes off in your face!</span>")
		return

	if(do_after(user, 30, target = src))
		if(sawn_off)
			return
		user.visible_message("<span class='notice'>[user] shortens \the [src]!</span>", "<span class='notice'>You shorten \the [src].</span>")
		name = "sawn-off [src.name]"
		desc = sawn_desc
		w_class = WEIGHT_CLASS_NORMAL
		item_state = "gun"
		slot_flags &= ~ITEM_SLOT_BACK	//you can't sling it on your back
		slot_flags |= ITEM_SLOT_BELT		//but you can wear it on your belt (poorly concealed under a trenchcoat, ideally)
		recoil = SAWN_OFF_RECOIL
		sawn_off = TRUE
		update_appearance()
		return TRUE

///used for sawing guns, causes the gun to fire without the input of the user
/obj/item/gun/ballistic/proc/blow_up(mob/user)
	. = FALSE
	for(var/obj/item/ammo_casing/AC in magazine.stored_ammo)
		if(AC.BB)
			process_fire(user, user, FALSE)
			. = TRUE
