/obj/item/gun
	name = "gun"
	desc = "It's a gun. It's pretty terrible, though."
	icon = 'icons/obj/guns/projectile.dmi'
	icon_state = "detective"
	item_state = "gun"
	lefthand_file = 'icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/guns_righthand.dmi'
	flags_1 =  CONDUCT_1
	slot_flags = ITEM_SLOT_BELT
	custom_materials = list(/datum/material/iron=2000)
	w_class = WEIGHT_CLASS_NORMAL
	throwforce = 5
	throw_speed = 3
	throw_range = 5
	force = 5
	item_flags = NEEDS_PERMIT
	attack_verb = list("struck", "hit", "bashed")
	pickup_sound = 'sound/items/handling/gun_pickup.ogg'
	drop_sound = 'sound/items/handling/gun_drop.ogg'
	//trigger guard on the weapon, hulks can't fire them with their big meaty fingers
	trigger_guard = TRIGGER_GUARD_NORMAL

	///The manufacturer of this weapon. For flavor mostly. If none, this will not show.
	var/manufacturer = MANUFACTURER_NONE

/*
 *  Muzzle
*/
	///Effect for the muzzle flash of the gun.
	var/obj/effect/muzzle_flash/muzzle_flash
	///Icon state of the muzzle flash effect.
	var/muzzleflash_iconstate
	///Brightness of the muzzle flash effect.
	var/muzzle_flash_lum = 3
	///Color of the muzzle flash effect.
	var/muzzle_flash_color = COLOR_VERY_SOFT_YELLOW

/*
 *  Firing
*/
	var/fire_sound = 'sound/weapons/gun/pistol/shot.ogg'
	var/vary_fire_sound = TRUE
	var/fire_sound_volume = 50
	var/dry_fire_sound = 'sound/weapons/gun/general/dry_fire.ogg'
	//change this on non-gun things
	var/dry_fire_text = "click"

/*
 *  Reloading
*/
	var/obj/item/ammo_casing/chambered = null

/*
 *  Operation
*/
	//whether or not a message is displayed when fired
	var/suppressed = null
	var/suppressed_sound = 'sound/weapons/gun/general/heavy_shot_suppressed.ogg'
	var/suppressed_volume = 60
	//description change if weapon is sawn-off
	var/sawn_desc = null
	var/sawn_off = FALSE

	//true if the gun is wielded via twohanded component, shouldnt affect anything else
	var/wielded = FALSE
	//true if the gun is wielded after delay, should affects accuracy
	var/wielded_fully = FALSE
	///Slowdown for wielding
	var/wield_slowdown = 0.1
	///How long between wielding and firing in tenths of seconds
	var/wield_delay	= 0.4 SECONDS
	///Storing value for above
	var/wield_time = 0

/*
 *  Stats
*/
	var/weapon_weight = WEAPON_LIGHT
	//Alters projectile damage multiplicatively based on this value. Use it for "better" or "worse" weapons that use the same ammo.
	var/projectile_damage_multiplier = 1
	//Speed someone can be flung if its point blank
	var/pb_knockback = 0

	//Set to 0 for shotguns. This is used for weapons that don't fire all their bullets at once.
	var/randomspread = 1
	///How much the bullet scatters when fired while wielded.
	var/spread	= 4
	///How much the bullet scatters when fired while unwielded.
	var/spread_unwielded = 12
	//additional spread when dual wielding
	var/dual_wield_spread = 24


	///Screen shake when the weapon is fired while wielded.
	var/recoil = 0
	///Screen shake when the weapon is fired while unwielded.
	var/recoil_unwielded = 0
	///a multiplier of the duration the recoil takes to go back to normal view, this is (recoil*recoil_backtime_multiplier)+1
	var/recoil_backtime_multiplier = 2
	///this is how much deviation the gun recoil can have, recoil pushes the screen towards the reverse angle you shot + some deviation which this is the max.
	var/recoil_deviation = 22.5

	//how large a burst is
	var/burst_size = 1
	//rate of fire for burst firing and semi auto
	var/fire_delay = 0
	//Prevent the weapon from firing again while already firing
	var/firing_burst = 0
	//cooldown handler
	var/semicd = 0

/*
 *  Overlay
*/
	///Used for positioning ammo count overlay on sprite
	var/ammo_x_offset = 0
	var/ammo_y_offset = 0

/*
 *  Attachment
*/
	///Attachments spawned on initialization. Should also be in valid attachments or it SHOULD(once i add that) fail
	var/list/default_attachments = list()
	///The types of attachments allowed, a list of types. SUBTYPES OF AN ALLOWED TYPE ARE ALSO ALLOWED
	var/list/valid_attachments = list()
	///Reference to our attachment holder to prevent subtypes having to call GetComponent
	var/datum/component/attachment_holder/attachment_holder
	///Maximum number of attachments allowed
	var/attachment_max = 0
	///Number of attachments that can fit on a given slot
	var/list/slot_available = ATTACHMENT_DEFAULT_SLOT_AVAILABLE
	///Offsets for the slots on this gun. should be indexed by SLOT and then by X/Y
	var/list/slot_offsets = list()

/*
 *  Zooming
*/
	///Whether the gun generates a Zoom action on creation
	var/zoomable = FALSE
	//Zoom toggle
	var/zoomed = FALSE
	///Distance in TURFs to move the user's screen forward (the "zoom" effect)
	var/zoom_amt = 3
	var/zoom_out_amt = 0
	var/datum/action/toggle_scope_zoom/azoom

/*
 * Saftey
*/
	///Does this gun have a saftey and thus can toggle it?
	var/has_safety = FALSE
	///If the saftey on? If so, we can't fire the weapon
	var/safety = FALSE
	///The wording of safety. Useful for guns that have a non-standard safety system, like a revolver
	var/safety_wording = "safety"

/*
 *  Ballistic... For now
*/
	///sound when inserting magazine
	var/load_sound = 'sound/weapons/gun/general/magazine_insert_full.ogg'
	///sound when inserting an empty magazine
	var/load_empty_sound = 'sound/weapons/gun/general/magazine_insert_empty.ogg'
	///volume of loading sound
	var/load_sound_volume = 40
	///whether loading sound should vary
	var/load_sound_vary = TRUE
	///sound of racking
	var/rack_sound = 'sound/weapons/gun/general/bolt_rack.ogg'
	///volume of racking
	var/rack_sound_volume = 60
	///whether racking sound should vary
	var/rack_sound_vary = TRUE
	///sound of when the bolt is locked back manually
	var/lock_back_sound = 'sound/weapons/gun/general/slide_lock_1.ogg'
	///volume of lock back
	var/lock_back_sound_volume = 60
	///whether lock back varies
	var/lock_back_sound_vary = TRUE
	///Sound of ejecting a magazine
	var/eject_sound = 'sound/weapons/gun/general/magazine_remove_full.ogg'
	///sound of ejecting an empty magazine
	var/eject_empty_sound = 'sound/weapons/gun/general/magazine_remove_empty.ogg'
	///volume of ejecting a magazine
	var/eject_sound_volume = 40
	///whether eject sound should vary
	var/eject_sound_vary = TRUE
	///sound of dropping the bolt or releasing a slide
	var/bolt_drop_sound = 'sound/weapons/gun/general/bolt_drop.ogg'
	///volume of bolt drop/slide release
	var/bolt_drop_sound_volume = 60
	///empty alarm sound (if enabled)
	var/empty_alarm_sound = 'sound/weapons/gun/general/empty_alarm.ogg'
	///empty alarm volume sound
	var/empty_alarm_volume = 70
	///whether empty alarm sound varies
	var/empty_alarm_vary = TRUE

	///Whether the gun will spawn loaded with a magazine
	var/spawnwithmagazine = TRUE
	///Compatible magazines with the gun
	var/mag_type = /obj/item/ammo_box/magazine/m10mm //Removes the need for max_ammo and caliber info
	///Whether the sprite has a visible magazine or not
	var/mag_display = FALSE
	///Whether the sprite has a visible ammo display or not
	var/mag_display_ammo = FALSE
	///Whether the sprite has a visible indicator for being empty or not.
	var/empty_indicator = FALSE
	///Whether the gun alarms when empty or not.
	var/empty_alarm = FALSE
	///Do we eject the magazine upon runing out of ammo?
	var/empty_autoeject = FALSE
	///Whether the gun supports multiple special mag types
	var/special_mags = FALSE
	///The bolt type of the gun, affects quite a bit of functionality, see gun.dm in defines for bolt types: BOLT_TYPE_STANDARD; BOLT_TYPE_LOCKING; BOLT_TYPE_OPEN; BOLT_TYPE_NO_BOLT
	var/bolt_type = BOLT_TYPE_STANDARD
	///Used for locking bolt and open bolt guns. Set a bit differently for the two but prevents firing when true for both.
	var/bolt_locked = FALSE
	///Whether the gun has to be racked each shot or not.
	var/semi_auto = TRUE
	///Actual magazine currently contained within the gun
	var/obj/item/ammo_box/magazine/magazine
	///whether the gun ejects the chambered casing
	var/casing_ejector = TRUE
	///Whether the gun has an internal magazine or a detatchable one. Overridden by BOLT_TYPE_NO_BOLT.
	var/internal_magazine = FALSE
	///Phrasing of the bolt in examine and notification messages; ex: bolt, slide, etc.
	var/bolt_wording = "bolt"
	///Phrasing of the magazine in examine and notification messages; ex: magazine, box, etx
	var/magazine_wording = "magazine"
	///Phrasing of the cartridge in examine and notification messages; ex: bullet, shell, dart, etc.
	var/cartridge_wording = "bullet"
	///length between individual racks
	var/rack_delay = 5
	///time of the most recent rack, used for cooldown purposes
	var/recent_rack = 0
	///Whether the gun can be sawn off by sawing tools
	var/can_be_sawn_off  = FALSE

	///Whether the gun can be tacloaded by slapping a fresh magazine directly on it
	var/tac_reloads = TRUE
	///If we have the 'snowflake mechanic,' how long should it take to reload?
	var/tactical_reload_delay  = 1 SECONDS

/*
 * Enegry and powered... For now
*/
	//What type of power cell this uses
	var/obj/item/stock_parts/cell/gun/cell
	var/cell_type = /obj/item/stock_parts/cell/gun
	var/modifystate = 0
	var/list/ammo_type = list(/obj/item/ammo_casing/energy)
	//The state of the select fire switch. Determines from the ammo_type list what kind of shot is fired next.
	var/select = 1
	//Can it be charged in a recharger?
	var/can_charge = TRUE
	//Do we handle overlays with base update_appearance()?
	var/automatic_charge_overlays = TRUE
	var/charge_sections = 4

	//if this gun uses a stateful charge bar for more detail
	var/shaded_charge = FALSE
	var/selfcharge = 0
	var/charge_tick = 0
	var/charge_delay = 4
	//whether the gun's cell drains the cyborg user's cell to recharge
	var/use_cyborg_cell = FALSE
	//set to true so the gun is given an empty cell
	var/dead_cell = FALSE

	//play empty alarm if no battery
	var/empty_battery_sound = FALSE
	///if the gun's cell cannot be replaced
	var/internal_cell = FALSE

	///Used for large and small cells
	var/mag_size = MAG_SIZE_MEDIUM
	//Time it takes to unscrew the cell
	var/unscrewing_time = 2 SECONDS
	//Volume of loading/unloading cell sounds
	var/sound_volume = 40

/obj/item/gun/Initialize()
	. = ..()
	RegisterSignal(src, COMSIG_TWOHANDED_WIELD, PROC_REF(on_wield))
	RegisterSignal(src, COMSIG_TWOHANDED_UNWIELD, PROC_REF(on_unwield))
	muzzle_flash = new(src, muzzleflash_iconstate)
	build_zooming()

/obj/item/gun/ComponentInitialize()
	. = ..()
	attachment_holder = AddComponent(/datum/component/attachment_holder, attachment_max, slot_available, valid_attachments, slot_offsets, default_attachments)
	AddComponent(/datum/component/two_handed)

/// triggered on wield of two handed item
/obj/item/gun/proc/on_wield(obj/item/source, mob/user)
	wielded = TRUE
	INVOKE_ASYNC(src, .proc.do_wield, user)

/obj/item/gun/proc/do_wield(mob/user)
	user.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/gun, multiplicative_slowdown = wield_slowdown)
	wield_time = world.time + wield_delay
	if(wield_time > 0)
		if(do_mob(user, user, wield_delay, FALSE, TRUE, CALLBACK(src, PROC_REF(is_wielded)), ignore_loc_change = TRUE))
			wielded_fully = TRUE
	else
		wielded_fully = TRUE

/obj/item/gun/proc/is_wielded()
	return wielded

/// triggered on unwield of two handed item
/obj/item/gun/proc/on_unwield(obj/item/source, mob/user)
	wielded = FALSE
	wielded_fully = FALSE
	user.remove_movespeed_modifier(/datum/movespeed_modifier/gun)

/obj/item/gun/Destroy()
	if(chambered) //Not all guns are chambered (EMP'ed energy guns etc)
		QDEL_NULL(chambered)
	if(azoom)
		QDEL_NULL(azoom)
	if(muzzle_flash)
		QDEL_NULL(muzzle_flash)
	return ..()

/obj/item/gun/handle_atom_del(atom/A)
	if(A == chambered)
		chambered = null
		update_icon()
	return ..()

/obj/item/gun/examine(mob/user)
	. = ..()
	if(has_safety)
		. += "The safety is [safety ? "<span class='green'>ON</span>" : "<span class='red'>OFF</span>"]. Ctrl-Click to toggle the safety."

	if(manufacturer)
		. += "<span class='notice'>It has <b>[manufacturer]</b> engraved on it.</span>"

/obj/item/gun/equipped(mob/living/user, slot)
	. = ..()
	if(zoomed && user.get_active_held_item() != src)
		zoom(user, user.dir, FALSE) //we can only stay zoomed in if it's in our hands	//yeah and we only unzoom if we're actually zoomed using the gun!!

//called after the gun has successfully fired its chambered ammo.
/obj/item/gun/proc/process_chamber()
	SEND_SIGNAL(src, COMSIG_GUN_CHAMBER_PROCESSED)
	return FALSE

//check if there's enough ammo/energy/whatever to shoot one time
//i.e if clicking would make it shoot
/obj/item/gun/proc/can_shoot()
	if(safety)
		return FALSE
	return TRUE

/obj/item/gun/proc/shoot_with_empty_chamber(mob/living/user as mob|obj)
	if(!safety)
		to_chat(user, "<span class='danger'>*[dry_fire_text]*</span>")
		playsound(src, dry_fire_sound, 30, TRUE)
		return
	to_chat(user, "<span class='danger'>Safeties are active on the [src]! Turn them off to fire!</span>")


/obj/item/gun/proc/shoot_live_shot(mob/living/user, pointblank = 0, atom/pbtarget = null, message = 1)
	var/actual_angle = get_angle_with_scatter((user || get_turf(src)), pbtarget, rand(-recoil_deviation, recoil_deviation) + 180)
	var/muzzle_angle = Get_Angle(get_turf(src), pbtarget)
	if(muzzle_flash && !muzzle_flash.applied)
		handle_muzzle_flash(user, muzzle_angle)

	if(wielded_fully)
		simulate_recoil(user, recoil, actual_angle)
	else if(!wielded_fully)
		simulate_recoil(user, recoil_unwielded, actual_angle)

	if(suppressed)
		playsound(user, suppressed_sound, suppressed_volume, vary_fire_sound, ignore_walls = FALSE, extrarange = SILENCED_SOUND_EXTRARANGE, falloff_distance = 0)
	else
		playsound(user, fire_sound, fire_sound_volume, vary_fire_sound)
		if(message)
			if(pointblank)
				user.visible_message(
						span_danger("[user] fires [src] point blank at [pbtarget]!"),
						span_danger("You fire [src] point blank at [pbtarget]!"),
						span_hear("You hear a gunshot!"), COMBAT_MESSAGE_RANGE, pbtarget
				)
				to_chat(pbtarget, "<span class='userdanger'>[user] fires [src] point blank at you!</span>")
				if(pb_knockback > 0 && ismob(pbtarget))
					var/mob/PBT = pbtarget
					var/atom/throw_target = get_edge_target_turf(PBT, user.dir)
					PBT.throw_at(throw_target, pb_knockback, 2)
			else
				user.visible_message(
						span_danger("[user] fires [src]!"),
						blind_message = span_hear("You hear a gunshot!"),
						vision_distance = COMBAT_MESSAGE_RANGE,
						ignored_mobs = user
				)

/obj/item/gun/emp_act(severity)
	. = ..()
	if(!(. & EMP_PROTECT_CONTENTS))
		for(var/obj/O in contents)
			O.emp_act(severity)

/obj/item/gun/afterattack(atom/target, mob/living/user, flag, params)
	. = ..()
	if(!target)
		return
	if(firing_burst)
		return
	if(flag) //It's adjacent, is the user, or is on the user's person
		if(target in user.contents) //can't shoot stuff inside us.
			return
		if(!ismob(target) || user.a_intent == INTENT_HARM) //melee attack
			return
		if(target == user && user.zone_selected != BODY_ZONE_PRECISE_MOUTH) //so we can't shoot ourselves (unless mouth selected)
			return
		if(ismob(target) && user.a_intent == INTENT_GRAB)
			if(user.GetComponent(/datum/component/gunpoint))
				to_chat(user, "<span class='warning'>You are already holding someone up!</span>")
				return
			user.AddComponent(/datum/component/gunpoint, target, src)
			return

	if(istype(user))//Check if the user can use the gun, if the user isn't alive(turrets) assume it can.
		var/mob/living/L = user
		if(!can_trigger_gun(L))
			return

	if(flag)
		if(user.zone_selected == BODY_ZONE_PRECISE_MOUTH)
			handle_suicide(user, target, params)
			return

	if(!can_shoot()) //Just because you can pull the trigger doesn't mean it can shoot.
		shoot_with_empty_chamber(user)
		return

	if(weapon_weight == WEAPON_HEAVY && (!wielded))
		to_chat(user, "<span class='warning'>You need a more secure grip to fire [src]!</span>")
		return
	//DUAL (or more!) WIELDING
	var/bonus_spread = 0
	var/loop_counter = 0
	if(ishuman(user) && user.a_intent == INTENT_HARM)
		var/mob/living/carbon/human/H = user
		for(var/obj/item/gun/G in H.held_items)
			if(G == src || G.weapon_weight >= WEAPON_MEDIUM)
				continue
			else if(G.can_trigger_gun(user))
				bonus_spread += dual_wield_spread
				loop_counter++
				addtimer(CALLBACK(G, TYPE_PROC_REF(/obj/item/gun, process_fire), target, user, TRUE, params, null, bonus_spread), loop_counter)

	return process_fire(target, user, TRUE, params, null, bonus_spread)

/obj/item/gun/proc/recharge_newshot()
	return

/obj/item/gun/proc/process_burst(mob/living/user, atom/target, message = TRUE, params=null, zone_override = "", sprd = 0, randomized_gun_spread = 0, randomized_bonus_spread = 0, rand_spr = 0, iteration = 0)
	if(!user || !firing_burst)
		firing_burst = FALSE
		return FALSE
	if(!issilicon(user))
		if(iteration > 1 && !(user.is_holding(src))) //for burst firing
			firing_burst = FALSE
			return FALSE
	if(chambered && chambered.BB)
		if(HAS_TRAIT(user, TRAIT_PACIFISM)) // If the user has the pacifist trait, then they won't be able to fire [src] if the round chambered inside of [src] is lethal.
			if(chambered.harmful) // Is the bullet chambered harmful?
				to_chat(user, "<span class='warning'>[src] is lethally chambered! You don't want to risk harming anyone...</span>")
				return
		if(randomspread)
			sprd = round((rand() - 0.5) * DUALWIELD_PENALTY_EXTRA_MULTIPLIER * (randomized_gun_spread + randomized_bonus_spread))
		else //Smart spread
			sprd = round((((rand_spr/burst_size) * iteration) - (0.5 + (rand_spr * 0.25))) * (randomized_gun_spread + randomized_bonus_spread))
		before_firing(target,user)
		if(!chambered.fire_casing(target, user, params, ,suppressed, zone_override, sprd, src))
			shoot_with_empty_chamber(user)
			firing_burst = FALSE
			return FALSE
		else
			if(get_dist(user, target) <= 1) //Making sure whether the target is in vicinity for the pointblank shot
				shoot_live_shot(user, 1, target, message)
			else
				shoot_live_shot(user, 0, target, message)
			if (iteration >= burst_size)
				firing_burst = FALSE
	else
		shoot_with_empty_chamber(user)
		firing_burst = FALSE
		return FALSE
	process_chamber()
	update_appearance()
	return TRUE

/obj/item/gun/proc/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0)
	if(user)
		SEND_SIGNAL(user, COMSIG_MOB_FIRED_GUN, user, target, params, zone_override)

	add_fingerprint(user)

	if(semicd)
		return

	var/sprd = 0
	var/randomized_gun_spread = 0
	var/rand_spr = rand()

	if(wielded_fully && spread)
		randomized_gun_spread =	rand(0,spread)
	else if(!wielded_fully && spread_unwielded)
		randomized_gun_spread =	rand(0,spread_unwielded)

	if(HAS_TRAIT(user, TRAIT_POOR_AIM)) //nice shootin' tex
		bonus_spread += 25
	var/randomized_bonus_spread = rand(0, bonus_spread)

	if(burst_size > 1)
		firing_burst = TRUE
		for(var/i = 1 to burst_size)
			addtimer(CALLBACK(src, PROC_REF(process_burst), user, target, message, params, zone_override, sprd, randomized_gun_spread, randomized_bonus_spread, rand_spr, i), fire_delay * (i - 1))
	else
		if(chambered)
			if(HAS_TRAIT(user, TRAIT_PACIFISM)) // If the user has the pacifist trait, then they won't be able to fire [src] if the round chambered inside of [src] is lethal.
				if(chambered.harmful) // Is the bullet chambered harmful?
					to_chat(user, "<span class='warning'>[src] is lethally chambered! You don't want to risk harming anyone...</span>")
					return
			sprd = round((rand() - 0.5) * DUALWIELD_PENALTY_EXTRA_MULTIPLIER * (randomized_gun_spread + randomized_bonus_spread))
			sprd = calculate_spread(user, sprd)

			before_firing(target,user)
			if(!chambered.fire_casing(target, user, params, , suppressed, zone_override, sprd, src))
				shoot_with_empty_chamber(user)
				return
			else
				if(get_dist(user, target) <= 1) //Making sure whether the target is in vicinity for the pointblank shot
					shoot_live_shot(user, TRUE, target, message)
				else
					shoot_live_shot(user, FALSE, target, message)
		else
			shoot_with_empty_chamber(user)
			return
		process_chamber()
		update_appearance()
		if(fire_delay)
			semicd = TRUE
			addtimer(CALLBACK(src, PROC_REF(reset_semicd)), fire_delay)

	if(user)
		user.update_inv_hands()
	SSblackbox.record_feedback("tally", "gun_fired", 1, type)
	return TRUE

/obj/item/gun/proc/reset_semicd()
	semicd = FALSE

/obj/item/gun/attack(mob/M as mob, mob/user)
	if(user.a_intent == INTENT_HARM) //Flogging
		return ..()
	return

/obj/item/gun/CtrlClick(mob/user)
	. = ..()
	if(!has_safety)
		return

	if(src != user.get_active_held_item())
		return

	if(isliving(user) && in_range(src, user))
		toggle_safety(user)

/obj/item/gun/proc/toggle_safety(mob/user, silent=FALSE)
	safety = !safety

	if(!silent)
		playsound(user, 'sound/weapons/gun/general/selector.ogg', 100, TRUE)
		user.visible_message(
			span_notice("[user] turns the [safety_wording] on [src] [safety ? "<span class='green'>ON</span>" : "<span class='red'>OFF</span>"]."),
			span_notice("You turn the [safety_wording] on [src] [safety ? "<span class='green'>ON</span>" : "<span class='red'>OFF</span>"]."),
		)

	update_appearance()

/obj/item/gun/attack_hand(mob/user)
	. = ..()
	update_appearance()

/obj/item/gun/pickup(mob/user)
	. = ..()
	update_appearance()
	if(azoom)
		azoom.Grant(user)

/obj/item/gun/dropped(mob/user)
	. = ..()
	update_appearance()
	if(azoom)
		azoom.Remove(user)
	if(zoomed)
		zoom(user, user.dir)

/obj/item/gun/update_overlays()
	. = ..()
	if(ismob(loc) && has_safety)
		var/mutable_appearance/safety_overlay
		safety_overlay = mutable_appearance('icons/obj/guns/safety.dmi')
		if(safety)
			safety_overlay.icon_state = "[safety_wording]-on"
		else
			safety_overlay.icon_state = "[safety_wording]-off"
		. += safety_overlay

#define BRAINS_BLOWN_THROW_RANGE 2
#define BRAINS_BLOWN_THROW_SPEED 1

/obj/item/gun/proc/handle_suicide(mob/living/carbon/human/user, mob/living/carbon/human/target, params, bypass_timer)
	if(!ishuman(user) || !ishuman(target))
		return

	if(semicd)
		return

	if(!can_shoot()) //Just because you can pull the trigger doesn't mean it can shoot.
		shoot_with_empty_chamber(user)
		return

	if(user == target)
		target.visible_message(span_warning("[user] sticks [src] in [user.p_their()] mouth, ready to pull the trigger..."), \
			span_userdanger("You stick [src] in your mouth, ready to pull the trigger..."))
	else
		target.visible_message(span_warning("[user] points [src] at [target]'s head, ready to pull the trigger..."), \
			span_userdanger("[user] points [src] at your head, ready to pull the trigger..."))

	semicd = TRUE

	if(!bypass_timer && (!do_mob(user, target, 100) || user.zone_selected != BODY_ZONE_PRECISE_MOUTH))
		if(user)
			if(user == target)
				user.visible_message(span_notice("[user] decided not to shoot."))
			else if(target && target.Adjacent(user))
				target.visible_message(span_notice("[user] has decided to spare [target]."), span_notice("[user] has decided to spare your life!"))
		semicd = FALSE
		return

	semicd = FALSE

	target.visible_message(span_warning("[user] pulls the trigger!"), span_userdanger("[(user == target) ? "You pull" : "[user] pulls"] the trigger!"))

	if(chambered && chambered.BB && can_trigger_gun(user))
		chambered.BB.damage *= 3
		//Check is here for safeties and such, brain will be removed after
		process_fire(target, user, TRUE, params, BODY_ZONE_HEAD)

		var/obj/item/organ/brain/brain_to_blast = target.getorganslot(ORGAN_SLOT_BRAIN)
		if(brain_to_blast)

			//Check if the projectile is actually damaging and not of type STAMINA
			if(chambered.BB.nodamage || !chambered.BB.damage || chambered.BB.damage_type == STAMINA)
				return

			//Remove brain of the mob shot
			brain_to_blast.Remove(target)

			var/turf/splat_turf = get_turf(target)
			//Move the brain of the person shot to selected turf
			brain_to_blast.forceMove(splat_turf)

			var/turf/splat_target = get_ranged_target_turf(target, REVERSE_DIR(target.dir), BRAINS_BLOWN_THROW_RANGE)
			var/datum/callback/gibspawner = CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(spawn_atom_to_turf), /obj/effect/gibspawner/generic, brain_to_blast, 1, FALSE, target)
			//Throw the brain that has been removed away and place a gibspawner on landing
			brain_to_blast.throw_at(splat_target, BRAINS_BLOWN_THROW_RANGE, BRAINS_BLOWN_THROW_SPEED, callback = gibspawner)

#undef BRAINS_BLOWN_THROW_RANGE
#undef BRAINS_BLOWN_THROW_SPEED

//Happens before the actual projectile creation
/obj/item/gun/proc/before_firing(atom/target,mob/user)
	return

// We do it like this in case theres some specific gun behavior for adjusting recoil, like bipods or folded stocks
/obj/item/gun/proc/calculate_recoil(mob/user, recoil_bonus = 0)
	return recoil_bonus

// We do it like this in case theres some specific gun behavior for adjusting spread, like bipods or folded stocks
/obj/item/gun/proc/calculate_spread(mob/user, bonus_spread)
	return bonus_spread

/obj/item/gun/proc/simulate_recoil(mob/living/user, recoil_bonus = 0, firing_angle)
	var/total_recoil = calculate_recoil(user, recoil_bonus)

	var/actual_angle = firing_angle + rand(-recoil_deviation, recoil_deviation) + 180
	if(actual_angle > 360)
		actual_angle -= 360
	if(total_recoil > 0)
		recoil_camera(user, total_recoil + 1, (total_recoil * recoil_backtime_multiplier)+1, total_recoil, actual_angle)
		return TRUE

/obj/item/gun/proc/handle_muzzle_flash(mob/living/user, firing_angle)
	var/atom/movable/flash_loc = user
	var/prev_light = light_range
	if(!light_on && (light_range <= muzzle_flash_lum))
		set_light_range(muzzle_flash_lum)
		set_light_color(muzzle_flash_color)
		set_light_on(TRUE)
		update_light()
		addtimer(CALLBACK(src, PROC_REF(reset_light_range), prev_light), 1 SECONDS)
	//Offset the pixels.
	switch(firing_angle)
		if(0, 360)
			muzzle_flash.pixel_x = 0
			muzzle_flash.pixel_y = 8
			muzzle_flash.layer = initial(muzzle_flash.layer)
		if(1 to 44)
			muzzle_flash.pixel_x = round(4 * ((firing_angle) / 45))
			muzzle_flash.pixel_y = 8
			muzzle_flash.layer = initial(muzzle_flash.layer)
		if(45)
			muzzle_flash.pixel_x = 8
			muzzle_flash.pixel_y = 8
			muzzle_flash.layer = initial(muzzle_flash.layer)
		if(46 to 89)
			muzzle_flash.pixel_x = 8
			muzzle_flash.pixel_y = round(4 * ((90 - firing_angle) / 45))
			muzzle_flash.layer = initial(muzzle_flash.layer)
		if(90)
			muzzle_flash.pixel_x = 8
			muzzle_flash.pixel_y = 0
			muzzle_flash.layer = initial(muzzle_flash.layer)
		if(91 to 134)
			muzzle_flash.pixel_x = 8
			muzzle_flash.pixel_y = round(-3 * ((firing_angle - 90) / 45))
			muzzle_flash.layer = initial(muzzle_flash.layer)
		if(135)
			muzzle_flash.pixel_x = 8
			muzzle_flash.pixel_y = -6
			muzzle_flash.layer = initial(muzzle_flash.layer)
		if(136 to 179)
			muzzle_flash.pixel_x = round(4 * ((180 - firing_angle) / 45))
			muzzle_flash.pixel_y = -6
			muzzle_flash.layer = ABOVE_MOB_LAYER
		if(180)
			muzzle_flash.pixel_x = 0
			muzzle_flash.pixel_y = -6
			muzzle_flash.layer = ABOVE_MOB_LAYER
		if(181 to 224)
			muzzle_flash.pixel_x = round(-6 * ((firing_angle - 180) / 45))
			muzzle_flash.pixel_y = -6
			muzzle_flash.layer = ABOVE_MOB_LAYER
		if(225)
			muzzle_flash.pixel_x = -6
			muzzle_flash.pixel_y = -6
			muzzle_flash.layer = initial(muzzle_flash.layer)
		if(226 to 269)
			muzzle_flash.pixel_x = -6
			muzzle_flash.pixel_y = round(-6 * ((270 - firing_angle) / 45))
			muzzle_flash.layer = initial(muzzle_flash.layer)
		if(270)
			muzzle_flash.pixel_x = -6
			muzzle_flash.pixel_y = 0
			muzzle_flash.layer = initial(muzzle_flash.layer)
		if(271 to 314)
			muzzle_flash.pixel_x = -6
			muzzle_flash.pixel_y = round(8 * ((firing_angle - 270) / 45))
			muzzle_flash.layer = initial(muzzle_flash.layer)
		if(315)
			muzzle_flash.pixel_x = -6
			muzzle_flash.pixel_y = 8
			muzzle_flash.layer = initial(muzzle_flash.layer)
		if(316 to 359)
			muzzle_flash.pixel_x = round(-6 * ((360 - firing_angle) / 45))
			muzzle_flash.pixel_y = 8
			muzzle_flash.layer = initial(muzzle_flash.layer)

	muzzle_flash.transform = null
	muzzle_flash.transform = turn(muzzle_flash.transform, firing_angle)
	flash_loc.vis_contents += muzzle_flash
	muzzle_flash.applied = TRUE

	addtimer(CALLBACK(src, PROC_REF(remove_muzzle_flash), flash_loc, muzzle_flash), 0.2 SECONDS)

/obj/item/gun/proc/reset_light_range(lightrange)
	set_light_range(lightrange)
	set_light_color(initial(light_color))
	if(lightrange <= 0)
		set_light_on(FALSE)
	update_light()

/obj/item/gun/proc/remove_muzzle_flash(atom/movable/flash_loc, obj/effect/muzzle_flash/muzzle_flash)
	if(!QDELETED(flash_loc))
		flash_loc.vis_contents -= muzzle_flash
	muzzle_flash.applied = FALSE
