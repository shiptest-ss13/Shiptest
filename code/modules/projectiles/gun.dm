/obj/item/gun
	name = "gun"
	desc = "It's a gun. It's pretty terrible, though."
	icon = 'icons/obj/guns/projectile.dmi'
	icon_state = "flatgun"
	item_state = "gun"
	lefthand_file = GUN_LEFTHAND_ICON
	righthand_file = GUN_RIGHTHAND_ICON
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
	var/dry_fire_text = "click"

/*
 *  Reloading
*/
	var/obj/item/ammo_casing/chambered = null
	///Whether the gun can be tacloaded by slapping a fresh magazine directly on it
	var/tac_reloads = TRUE
	///If we have the 'snowflake mechanic,' how long should it take to reload?
	var/tactical_reload_delay = 1 SECONDS

//BALLISTIC
	///Compatible magazines with the gun
	var/default_ammo_type
	var/allowed_ammo_types
	///Whether the gun alarms when empty or not.
	var/empty_alarm = FALSE
	///Do we eject the magazine upon runing out of ammo?
	var/empty_autoeject = FALSE
	///Whether the gun supports multiple special mag types
	var/special_mags = FALSE

	///Actual magazine currently contained within the gun
	var/obj/item/ammo_box/magazine/magazine
	///whether the gun ejects the chambered casing
	var/casing_ejector = TRUE
	///Whether the gun has an internal magazine or a detatchable one. Overridden by BOLT_TYPE_NO_BOLT.
	var/internal_magazine = FALSE
	///Whether the gun *can* be reloaded
	var/sealed_magazine = FALSE


	///Phrasing of the magazine in examine and notification messages; ex: magazine, box, etx
	var/magazine_wording = "magazine"
	///Phrasing of the cartridge in examine and notification messages; ex: bullet, shell, dart, etc.
	var/cartridge_wording = "bullet"

	///sound when inserting magazine
	var/load_sound = 'sound/weapons/gun/general/magazine_insert_full.ogg'
	///sound when inserting an empty magazine
	var/load_empty_sound = 'sound/weapons/gun/general/magazine_insert_empty.ogg'
	///volume of loading sound
	var/load_sound_volume = 40
	///whether loading sound should vary
	var/load_sound_vary = TRUE
	///Sound of ejecting a magazine
	var/eject_sound = 'sound/weapons/gun/general/magazine_remove_full.ogg'
	///sound of ejecting an empty magazine
	var/eject_empty_sound = 'sound/weapons/gun/general/magazine_remove_empty.ogg'
	///volume of ejecting a magazine
	var/eject_sound_volume = 40
	///whether eject sound should vary
	var/eject_sound_vary = TRUE

//ENERGY
	//What type of power cell this uses
	var/obj/item/stock_parts/cell/gun/cell
	//Can it be charged in a recharger?
	var/can_charge = TRUE
	var/selfcharge = FALSE
	var/charge_tick = 0
	var/charge_delay = 4
	//whether the gun's cell drains the cyborg user's cell to recharge
	var/use_cyborg_cell = FALSE
	//Time it takes to unscrew the cell
	var/unscrewing_time = 2 SECONDS

	///if the gun's cell cannot be replaced
	var/internal_cell = FALSE

	var/list/ammo_type = list(/obj/item/ammo_casing/energy)
	//The state of the select fire switch. Determines from the ammo_type list what kind of shot is fired next.
	var/select = 1

/*
 *  Operation
*/
	//whether or not a message is displayed when fired
	var/suppressed = FALSE
	var/suppressed_sound = 'sound/weapons/gun/general/heavy_shot_suppressed.ogg'
	var/suppressed_volume = 60

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

// BALLISTIC
	///Whether the gun has to be racked each shot or not.
	var/semi_auto = TRUE
	///The bolt type of the gun, affects quite a bit of functionality, see gun.dm in defines for bolt types: BOLT_TYPE_STANDARD; BOLT_TYPE_LOCKING; BOLT_TYPE_OPEN; BOLT_TYPE_NO_BOLT
	var/bolt_type = BOLT_TYPE_STANDARD
	///Used for locking bolt and open bolt guns. Set a bit differently for the two but prevents firing when true for both.
	var/bolt_locked = FALSE
	///Phrasing of the bolt in examine and notification messages; ex: bolt, slide, etc.
	var/bolt_wording = "bolt"
	///length between individual racks
	var/rack_delay = 5
	///time of the most recent rack, used for cooldown purposes
	var/recent_rack = 0

	///Whether the gun can be sawn off by sawing tools
	var/can_be_sawn_off = FALSE
	//description change if weapon is sawn-off
	var/sawn_desc = null
	var/sawn_off = FALSE

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

/*
 *  Stats
*/
	var/weapon_weight = WEAPON_LIGHT
	//Alters projectile damage multiplicatively based on this value. Use it for "better" or "worse" weapons that use the same ammo.
	var/projectile_damage_multiplier = 1
	//Speed someone can be flung if its point blank
	var/pb_knockback = 0

	//Set to 0 for shotguns. This is used for weapons that don't fire all their bullets at once.
	var/randomspread = TRUE
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

	///Used if the guns recoil is lower then the min, it clamps the highest recoil
	var/min_recoil = 0

	var/gunslinger_recoil_bonus = 0
	var/gunslinger_spread_bonus = 0

	/// how many shots per burst, Ex: most machine pistols, M90, some ARs are 3rnd burst, while others like the GAR and laser minigun are 2 round burst.
	var/burst_size = 3
	///The rate of fire when firing in a burst. Not the delay between bursts
	var/burst_delay = 0.15 SECONDS
	///The rate of fire when firing full auto and semi auto, and between bursts; for bursts its fire delay + burst_delay after every burst
	var/fire_delay = 0.2 SECONDS
	//Prevent the weapon from firing again while already firing
	var/firing_burst = 0

/*
 *  Overlay
*/
	///Used for positioning ammo count overlay on sprite
	var/ammo_x_offset = 0
	var/ammo_y_offset = 0

//BALLISTIC
	///Whether the sprite has a visible magazine or not
	var/mag_display = FALSE
	///Whether the sprite has a visible ammo display or not
	var/mag_display_ammo = FALSE
	///Whether the sprite has a visible indicator for being empty or not.
	var/empty_indicator = FALSE
	///Whether the sprite has a visible magazine or not
	var/show_magazine_on_sprite = FALSE
	///Do we show how much ammo is left on the sprite? In increments of 20.
	var/show_ammo_capacity_on_magazine_sprite = FALSE
	///Whether the sprite has a visible ammo display or not
	var/show_magazine_on_sprite_ammo = FALSE
	///Whether the gun supports multiple special mag types
	var/unique_mag_sprites_for_variants = FALSE

//ENERGY
	//Do we handle overlays with base update_appearance()?
	var/automatic_charge_overlays = TRUE
	var/charge_sections = 4
	//if this gun uses a stateful charge bar for more detail
	var/shaded_charge = FALSE
	//Modifies WHOS state //im SOMEWHAT this is wether or not the overlay changes based on the ammo type selected
	var/modifystate = TRUE

/*
 *  Attachment
*/
	///The types of attachments allowed, a list of types. SUBTYPES OF AN ALLOWED TYPE ARE ALSO ALLOWED
	var/list/valid_attachments = list()
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
 * Safety
*/
	///Does this gun have a saftey and thus can toggle it?
	var/has_safety = FALSE
	///If the saftey on? If so, we can't fire the weapon
	var/safety = FALSE
	///The wording of safety. Useful for guns that have a non-standard safety system, like a revolver
	var/safety_wording = "safety"

/*
 *  Spawn Info (Stuff that becomes useless onces the gun is spawned, mostly here for mappers)
*/
	///Attachments spawned on initialization. Should also be in valid attachments or it SHOULD(once i add that) fail
	var/list/default_attachments = list()

//ENERGY
	//set to true so the gun is given an empty cell
	var/spawn_no_ammo = FALSE

// Need to sort
	///trigger guard on the weapon. Used for hulk mutations and ashies. I honestly dont know how usefult his is, id avoid touching it
	trigger_guard = TRIGGER_GUARD_NORMAL

	/// after initializing, we set the firemode to this
	var/default_firemode = FIREMODE_SEMIAUTO
	///Firemode index, due to code shit this is the currently selected firemode
	var/firemode_index
	/// Our firemodes, subtract and add to this list as needed. NOTE that the autofire component is given on init when FIREMODE_FULLAUTO is here.
	var/list/gun_firemodes = list(FIREMODE_SEMIAUTO, FIREMODE_BURST, FIREMODE_FULLAUTO, FIREMODE_OTHER, FIREMODE_OTHER_TWO)
	/// A acoc list that determines the names of firemodes. Use if you wanna be weird and set the name of say, FIREMODE_OTHER to "Underbarrel grenade launcher" for example.
	var/list/gun_firenames = list(FIREMODE_SEMIAUTO = "single", FIREMODE_BURST = "burst fire", FIREMODE_FULLAUTO = "full auto", FIREMODE_OTHER = "misc. fire", FIREMODE_OTHER_TWO = "very misc. fire")
	///BASICALLY: the little button you select firing modes from? this is jsut the prefix of the icon state of that. For example, if we set it as "laser", the fire select will use "laser_single" and so on.
	var/fire_select_icon_state_prefix = ""
	///If true, we put "safety_" before fire_select_icon_state_prefix's prefix. ex. "safety_laser_single"
	var/adjust_fire_select_icon_state_on_safety = FALSE

	///Are we firing a burst? If so, dont fire again until burst is done
	var/currently_firing_burst = FALSE
	///This prevents gun from firing until the coodown is done, affected by lag
	var/current_cooldown = 0

/obj/item/gun/Initialize(mapload, spawn_empty)
	. = ..()
	RegisterSignal(src, COMSIG_TWOHANDED_WIELD, PROC_REF(on_wield))
	RegisterSignal(src, COMSIG_TWOHANDED_UNWIELD, PROC_REF(on_unwield))
	muzzle_flash = new(src, muzzleflash_iconstate)
	build_zooming()
	build_firemodes()
	if(sawn_off)
		sawoff(forced = TRUE)

/obj/item/gun/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/attachment_holder, slot_available, valid_attachments, slot_offsets, default_attachments)
	AddComponent(/datum/component/two_handed)

/// triggered on wield of two handed item
/obj/item/gun/proc/on_wield(obj/item/source, mob/user)
	wielded = TRUE
	INVOKE_ASYNC(src, PROC_REF(do_wield), user)

/obj/item/gun/proc/do_wield(mob/user)
	user.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/gun, multiplicative_slowdown = wield_slowdown)
	wield_time = world.time + wield_delay
	if(wield_time > 0)
		if(do_after(
			user,
			wield_delay,
			user,
			FALSE,
			TRUE,
			CALLBACK(src, PROC_REF(is_wielded)),
			timed_action_flags = IGNORE_USER_LOC_CHANGE
			)
			)
			wielded_fully = TRUE
			return TRUE
	else
		wielded_fully = TRUE
		return TRUE

/// triggered on unwield of two handed item
/obj/item/gun/proc/on_unwield(obj/item/source, mob/user)
	wielded = FALSE
	wielded_fully = FALSE
	zoom(user, forced_zoom = FALSE)
	user.remove_movespeed_modifier(/datum/movespeed_modifier/gun)

/obj/item/gun/proc/is_wielded()
	return wielded

/obj/item/gun/Destroy()
	if(chambered) //Not all guns are chambered (EMP'ed energy guns etc)
		QDEL_NULL(chambered)
	if(azoom)
		QDEL_NULL(azoom)
	if(muzzle_flash)
		QDEL_NULL(muzzle_flash)
	if(magazine)
		QDEL_NULL(magazine)
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

/obj/item/gun/attack(mob/M as mob, mob/user)
	if(user.a_intent == INTENT_HARM) //Flogging
		return ..()
	return

//called after the gun has successfully fired its chambered ammo.
/obj/item/gun/proc/process_chamber(atom/shooter)
	SEND_SIGNAL(src, COMSIG_GUN_CHAMBER_PROCESSED)
	return FALSE

//check if there's enough ammo/energy/whatever to shoot one time
//i.e if clicking would make it shoot
/obj/item/gun/proc/can_shoot()
	if(safety)
		return FALSE
	return TRUE

/obj/item/gun/emp_act(severity)
	. = ..()
	if(!(. & EMP_PROTECT_CONTENTS))
		for(var/obj/O in contents)
			O.emp_act(severity)


/obj/item/gun/proc/recharge_newshot()
	return

/obj/item/gun/afterattack(atom/target, mob/living/user, flag, params)
	. = ..()
	//No target? Why are we even firing anyways...
	if(!target)
		return
	//If we are burst firing, don't fire, obviously
	if(currently_firing_burst)
		return
	//This var happens when we are either clicking someone next to us or ourselves. Check if we don't want to fire...
	if(flag)
		if(target in user.contents) //can't shoot stuff inside us.
			return
		if(!ismob(target) || user.a_intent == INTENT_HARM) //melee attack
			return
		if(target == user && user.zone_selected != BODY_ZONE_PRECISE_MOUTH) //so we can't shoot ourselves (unless mouth selected)
			return
/* TODO: gunpointing is very broken, port the old skyrat gunpointing? its much better, usablity wise and rp wise?
		if(ismob(target) && user.a_intent == INTENT_GRAB)
			if(user.GetComponent(/datum/component/gunpoint))
				to_chat(user, "<span class='warning'>You are already holding someone up!</span>")
				return
			user.AddComponent(/datum/component/gunpoint, target, src)
			return
*/
	// Good job, but we have exta checks to do...
	return pre_fire(target, user, TRUE, flag, params, null)

/obj/item/gun/proc/pre_fire(atom/target, mob/living/user,  message = TRUE, flag, params = null, zone_override = "", bonus_spread = 0, dual_wielded_gun = FALSE)
	add_fingerprint(user)

	// If we have a cooldown, don't do anything, obviously
	if(current_cooldown)
		return

	//We check if the user can even use the gun, if not, we assume the user isn't alive(turrets) so we go ahead.
	if(istype(user))
		var/mob/living/living_user = user
		if(!can_trigger_gun(living_user))
			return

	//If targetting the mouth, we do suicide instead.
	if(flag)
		if(user.zone_selected == BODY_ZONE_PRECISE_MOUTH)
			handle_suicide(user, target, params)
			return

	//Just because we can pull the trigger doesn't mean it can fire. Mostly for safties.
	if(!can_shoot())
		shoot_with_empty_chamber(user)
		return

	//we then check our weapon weight vs if we are being wielded...
	if(weapon_weight == WEAPON_VERY_HEAVY && (!wielded_fully))
		to_chat(user, "<span class='warning'>You need a fully secure grip to fire [src]!</span>")
		return

	if(weapon_weight == WEAPON_HEAVY && (!wielded))
		to_chat(user, "<span class='warning'>You need a more secure grip to fire [src]!</span>")
		return
	//If we have the pacifist trait and a chambered round, don't fire. Honestly, pacifism quirk is pretty stupid, and as such we check again in process_fire() anyways
	if(chambered)
		if(HAS_TRAIT(user, TRAIT_PACIFISM)) // If the user has the pacifist trait, then they won't be able to fire [src] if the round chambered inside of [src] is lethal.
			if(chambered.harmful) // Is the bullet chambered harmful?
				to_chat(user, "<span class='warning'>[src] is lethally chambered! You don't want to risk harming anyone...</span>")
				return

	//Dual wielding handling. Not the biggest fan of this, but it's here. Dual berettas not included
	var/loop_counter = 0
	if(ishuman(user) && user.a_intent == INTENT_HARM && !dual_wielded_gun)
		var/mob/living/carbon/human/our_cowboy = user
		for(var/obj/item/gun/found_gun in our_cowboy.held_items)
			if(found_gun == src || found_gun.weapon_weight >= WEAPON_MEDIUM)
				continue
			else if(found_gun.can_trigger_gun(user))
				bonus_spread += dual_wield_spread
				loop_counter++
				addtimer(CALLBACK(found_gun, TYPE_PROC_REF(/obj/item/gun, pre_fire), target, user, TRUE, params, null, bonus_spread), loop_counter)

	//get current firemode
	var/current_firemode = gun_firemodes[firemode_index]
	//FIREMODE_OTHER and its sister directs you to another proc for special handling
	if(current_firemode == FIREMODE_OTHER)
		return process_other(target, user, message, flag, params, zone_override, bonus_spread)
	if(current_firemode == FIREMODE_OTHER_TWO)
		return process_other_two(target, user, message, flag, params, zone_override, bonus_spread)

	//if all of that succeded, we finally get to process firing
	return process_fire(target, user, TRUE, params, null, bonus_spread)

/obj/item/gun/proc/process_other(atom/target, mob/living/user, message = TRUE, flag, params = null, zone_override = "", bonus_spread = 0)
	return //use this for 'underbarrels!!

/obj/item/gun/proc/process_other_two(atom/target, mob/living/user, message = TRUE, flag, params = null, zone_override = "", bonus_spread = 0)
	return //reserved in case another fire mode is needed, if you need special behavior, put it here then call process_fire, or call process_fire and have the special behavior there

/**
 * Handles everything involving firing.
 * * gun.dm is still a fucking mess, and I will document everything next time i get to it... for now this will suffice.
 *
 * Returns TRUE or FALSE depending on if it actually fired a shot.
 * Arguments:
 * * target - The atom we are trying to hit.
 * * user - The living mob firing the gun, if any.
 * * message - Do we show the usual messages? eg. "x fires the y!"
 * * params - Is the params string from byond [/atom/proc/Click] code, see that documentation.
 * * zone_override - The bodypart we attempt to hit, sometimes hits another.
 * * bonus_spread - Adds this value to spread, in this case used by dual wielding.
 * * burst_firing - Not to be confused with currently_firing_burst. This var is TRUE when we are doing a burst except for the first shot in a burst, as to override the spam burst checks.
 * * spread_override - Bullet spread is forcibly set to this. This is usually because of bursts attempting to share the same burst trajectory.
 * * iteration - Which shot in a burst are we in.
 */
/obj/item/gun/proc/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0, burst_firing = FALSE, spread_override = 0, iteration = 0)
	//OKAY, this prevents us from firing until our cooldown is done
	if(!burst_firing) //if we're firing a burst, dont interfere to avoid issues
		if(current_cooldown)
			return FALSE

	//Check one last time for safeties...
	if(!can_shoot())
		shoot_with_empty_chamber(user)
		currently_firing_burst = FALSE
		return FALSE

	//special hahnding for burst firing
	if(burst_firing)
		if(!user || !currently_firing_burst)
			currently_firing_burst = FALSE
			return FALSE
		if(!issilicon(user))
			//If we aren't holding the gun, what are we doing, stop firing!
			if(iteration > 1 && !(user.is_holding(src)))
				currently_firing_burst = FALSE
				return FALSE

	//Do we have a round? If not, stop the whole chain, and if we do, check if the gun is chambered. Pacisim is pretty lame anyways.
	if(chambered)
		if(HAS_TRAIT(user, TRAIT_PACIFISM)) // If the user has the pacifist trait, then they won't be able to fire [src] if the round chambered inside of [src] is lethal.
			if(chambered.harmful) // Is the bullet chambered harmful?
				to_chat(user, "<span class='warning'>[src] is lethally chambered! You don't want to risk harming anyone...</span>")
				currently_firing_burst = FALSE //no burst 4 u
				return FALSE
	else
		shoot_with_empty_chamber(user)
		currently_firing_burst = FALSE
		return FALSE

	// we hold the total spread in this var
	var/sprd
	// if we ARE burst firing and don't have "randomspread", we add the burst's penalty on top of it.
	if(burst_firing && !randomspread)
		bonus_spread += burst_size * iteration

	//override spread? usually happens only in bursts
	if(spread_override && !randomspread)
		sprd = spread_override
	else
		//Calculate spread
		sprd = calculate_spread(user, bonus_spread)

	before_firing(target,user)
	//If we cant fire the round, just end the proc here. Otherwise, continue
	if(!chambered.fire_casing(target, user, params, , suppressed, zone_override, sprd, src))
		shoot_with_empty_chamber(user)
		currently_firing_burst = FALSE
		return FALSE
	//Are we PBing someone? If so, set pointblank to TRUE
	shoot_live_shot(user, (get_dist(user, target) <= 1), target, message) //Making sure whether the target is in vicinity for the pointblank shot

	//process the chamber...
	process_chamber(shooter = user)
	update_appearance()
	//get our current firemode...
	var/current_firemode = gun_firemodes[firemode_index]

	//If we are set to burst fire, then we burst fire!
	if(burst_size > 1 && (current_firemode == FIREMODE_BURST) && !burst_firing)
		currently_firing_burst = TRUE
		for(var/i = 2 to burst_size) //we fire the first burst normally, hence why its 2
			addtimer(CALLBACK(src, PROC_REF(process_fire), target, user, message, params, zone_override, 0, TRUE, sprd, i), burst_delay * (i - 1))

	//if we have a fire delay, set up a cooldown
	if(fire_delay && (!burst_firing && !currently_firing_burst))
		current_cooldown = TRUE
		addtimer(CALLBACK(src, PROC_REF(reset_current_cooldown)), fire_delay)
	if(burst_firing && iteration >= burst_size)
		current_cooldown = TRUE
		addtimer(CALLBACK(src, PROC_REF(reset_current_cooldown)), fire_delay+burst_delay)
		currently_firing_burst = FALSE

	// update our inhands...
	if(user)
		user.update_inv_hands()

	SSblackbox.record_feedback("tally", "gun_fired", 1, type)
	return TRUE

/obj/item/gun/proc/reset_current_cooldown()
	current_cooldown = FALSE

/obj/item/gun/proc/shoot_with_empty_chamber(mob/living/user as mob|obj)
	if(!safety)
		to_chat(user, "<span class='danger'>*[dry_fire_text]*</span>")
		playsound(src, dry_fire_sound, 30, TRUE)
		return
	to_chat(user, "<span class='danger'>Safeties are active on the [src]! Turn them off to fire!</span>")


/obj/item/gun/proc/shoot_live_shot(mob/living/user, pointblank = FALSE, atom/pbtarget = null, message = TRUE)
	var/actual_angle = get_angle_with_scatter((user || get_turf(src)), pbtarget, rand(-recoil_deviation, recoil_deviation) + 180)
	var/muzzle_angle = Get_Angle(get_turf(src), pbtarget)

	user.changeNext_move(clamp(fire_delay, 0, CLICK_CD_RANGE))

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

	//cloudy sent a meme in the discord. i dont know if its true, but i made this piece of code in honor of it
	var/mob/living/carbon/human/living_human = user
	if(istype(living_human))
		if(!living_human.wear_neck)
			return //if nothing on the neck, don't do anything
		var/current_month = text2num(time2text(world.timeofday, "MM"))
		var/static/regex/bian = regex("(?:^\\W*lesbian)", "i")

		if(current_month == JUNE)
			return //if it isn't june, don't do this easter egg

		if(!findtext(bian, living_human.generic_adjective))
			return //dont bother if we already are affected by it

		if(istype(living_human.wear_neck, /obj/item/clothing/neck/tie/lesbian) || living_human.wear_neck.icon_state == "lesbian")
			var/use_space = "[living_human.generic_adjective ? " " : ""]"
			living_human.generic_adjective = "lesbian[use_space][living_human.generic_adjective]" //i actually don't remember the meme. it was something like lesbians will stop working if they see another with a gun. or something.

/obj/item/gun/CtrlClick(mob/user)
	. = ..()
	if(!has_safety)
		return
	// only checks for first level storage e.g pockets, hands, suit storage, belts, nothing in containers
	if(!in_contents_of(user))
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

/obj/item/gun/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	. = ..()
	if(prob(GUN_NO_SAFETY_MALFUNCTION_CHANCE_HIGH))
		discharge("hits the ground hard")

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

	if(current_cooldown)
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

	current_cooldown = TRUE

	if(!bypass_timer && (!do_after(user, 100, target) || user.zone_selected != BODY_ZONE_PRECISE_MOUTH))
		if(user)
			if(user == target)
				user.visible_message(span_notice("[user] decided not to shoot."))
			else if(target && target.Adjacent(user))
				target.visible_message(span_notice("[user] has decided to spare [target]."), span_notice("[user] has decided to spare your life!"))
		current_cooldown = FALSE
		return

	current_cooldown = FALSE

	target.visible_message(span_warning("[user] pulls the trigger!"), span_userdanger("[(user == target) ? "You pull" : "[user] pulls"] the trigger!"))

	if(chambered && chambered.BB && can_trigger_gun(user))
		chambered.BB.damage *= 3
		//Check is here for safeties and such, brain will be removed after
		if(!pre_fire(target, user, TRUE, FALSE, params, BODY_ZONE_HEAD)) // We're already in handle_suicide, hence the 4th parameter needs to be FALSE to avoid circular logic. Also, BODY_ZONE_HEAD because we want to damage the head as a whole.
			return

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

/obj/item/gun/proc/calculate_recoil(mob/user, recoil_bonus = 0)
	if(HAS_TRAIT(user, TRAIT_GUNSLINGER))
		recoil_bonus += gunslinger_recoil_bonus
	return clamp(recoil_bonus, min_recoil , INFINITY)

/obj/item/gun/proc/calculate_spread(mob/user, bonus_spread)
	var/final_spread = 0
	var/randomized_gun_spread = 0
	var/randomized_bonus_spread = 0

	final_spread += bonus_spread

	if(HAS_TRAIT(user, TRAIT_GUNSLINGER))
		randomized_bonus_spread += rand(0, gunslinger_spread_bonus)

	if(HAS_TRAIT(user, TRAIT_POOR_AIM))
		randomized_bonus_spread += rand(0, 25)

	//We will then calculate gun spread depending on if we are fully wielding (after do_after) the gun or not
	randomized_gun_spread =	rand(0, wielded_fully ? spread : spread_unwielded)

	final_spread += randomized_gun_spread + randomized_bonus_spread

	//Clamp it down to avoid guns with negative spread to have worse recoil...
	final_spread = clamp(final_spread, 0, INFINITY)

	//So spread isn't JUST to the right
	if(prob(50))
		final_spread *= -1

	final_spread = round(final_spread)

	return final_spread

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

// for guns firing on their own without a user
/obj/item/gun/proc/discharge(cause, seek_chance = 10)
	var/target
	if(!safety && has_safety)
		// someone is very unlucky and about to be shot
		if(prob(seek_chance))
			for(var/mob/living/target_mob in range(6, get_turf(src)))
				if(!isInSight(src, target_mob))
					continue
				target = target_mob
				break
		if(!target)
			var/fire_dir = pick(GLOB.alldirs)
			target = get_ranged_target_turf(get_turf(src),fire_dir,6)
		if(!chambered || !chambered.BB)
			visible_message(span_danger("\The [src] [cause ? "[cause], suddenly going off" : "suddenly goes off"] without its safteies on! Luckily it wasn't live."))
			playsound(src, dry_fire_sound, 30, TRUE)
		else
			visible_message(span_danger("\The [src] [cause ? "[cause], suddenly going off" : "suddenly goes off"] without its safeties on!"))
			unsafe_shot(target)

/obj/item/gun/proc/unsafe_shot(target)
	if(chambered)
		chambered.fire_casing(target,null, null, null, suppressed, ran_zone(BODY_ZONE_CHEST, 50), 0, src,TRUE)
		playsound(src, fire_sound, 100, TRUE)

/mob/living/proc/trip_with_gun(cause)
	var/mob/living/carbon/human/human_holder
	if(ishuman(src))
		human_holder = src
	for(var/obj/item/gun/at_risk in get_all_contents())
		var/chance_to_fire = GUN_NO_SAFETY_MALFUNCTION_CHANCE_MEDIUM
		if(human_holder)
			// gun is less likely to go off in a holster
			if(at_risk == human_holder.s_store)
				chance_to_fire = GUN_NO_SAFETY_MALFUNCTION_CHANCE_LOW
		if(at_risk.safety == FALSE && prob(chance_to_fire))
			if(at_risk.process_fire(src,src,FALSE, null,  pick(BODY_ZONE_L_LEG,BODY_ZONE_R_LEG)) == TRUE)
				log_combat(src,src,"misfired",at_risk,"caused by [cause]")
				visible_message(span_danger("\The [at_risk.name]'s trigger gets caught as [src] falls, suddenly going off into [src]'s leg without its safties on!"), span_danger("\The [at_risk.name]'s trigger gets caught on something as you fall, suddenly going off into your leg without its safeties on!"))
				emote("scream")

//I need to refactor this into an attachment
/datum/action/toggle_scope_zoom
	name = "Toggle Scope"
	check_flags = AB_CHECK_CONSCIOUS|AB_CHECK_HANDS_BLOCKED|AB_CHECK_IMMOBILE|AB_CHECK_LYING
	icon_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "sniper_zoom"

/datum/action/toggle_scope_zoom/Trigger()
	if(!istype(target, /obj/item/gun) || !..())
		return

	var/obj/item/gun/gun = target
	gun.zoom(owner, owner.dir)

/datum/action/toggle_scope_zoom/Remove(mob/user)
	if(!istype(target, /obj/item/gun))
		return ..()

	var/obj/item/gun/gun = target
	gun.zoom(user, user.dir, FALSE)

	..()

/obj/item/gun/proc/rotate(atom/thing, old_dir, new_dir)
	SIGNAL_HANDLER

	if(ismob(thing))
		var/mob/lad = thing
		lad.client.view_size.zoomOut(zoom_out_amt, zoom_amt, new_dir)

/obj/item/gun/proc/zoom(mob/living/user, direc, forced_zoom)
	if(!user || !user.client)
		return

	if(isnull(forced_zoom))
		if((!zoomed && wielded_fully) || zoomed)
			zoomed = !zoomed
		else
			to_chat(user, "<span class='danger'>You can't look down the scope without wielding [src]!</span>")
			zoomed = FALSE
	else
		zoomed = forced_zoom

	if(zoomed)
		RegisterSignal(user, COMSIG_ATOM_DIR_CHANGE, PROC_REF(rotate))
		user.client.view_size.zoomOut(zoom_out_amt, zoom_amt, direc)
	else
		UnregisterSignal(user, COMSIG_ATOM_DIR_CHANGE)
		user.client.view_size.zoomIn()
	return zoomed

//Proc, so that gun accessories/scopes/etc. can easily add zooming.
/obj/item/gun/proc/build_zooming()
	if(azoom)
		return

	if(zoomable)
		azoom = new(src)

/obj/item/gun/proc/build_firemodes()
	if(FIREMODE_FULLAUTO in gun_firemodes)
		AddComponent(/datum/component/automatic_fire, fire_delay)
		SEND_SIGNAL(src, COMSIG_GUN_DISABLE_AUTOFIRE)
	var/datum/action/item_action/our_action

	if(gun_firemodes.len > 1)
		our_action = new /datum/action/item_action/toggle_firemode(src)

	for(var/i=1, i <= gun_firemodes.len+1, i++)
		if(default_firemode == gun_firemodes[i])
			firemode_index = i
			if(gun_firemodes[i] == FIREMODE_FULLAUTO)
				SEND_SIGNAL(src, COMSIG_GUN_ENABLE_AUTOFIRE)
			if(our_action)
				our_action.UpdateButtonIcon()
			return

	firemode_index = 1
	CRASH("default_firemode isn't in the gun_firemodes list of [src.type]!! Defaulting to 1!!")

/obj/item/gun/ui_action_click(mob/user, actiontype)
	if(istype(actiontype, /datum/action/item_action/toggle_firemode))
		fire_select(user)
	else
		..()

/obj/item/gun/proc/fire_select(mob/living/carbon/human/user)

	//gun_firemodes = list(FIREMODE_SEMIAUTO, FIREMODE_BURST, FIREMODE_FULLAUTO, FIREMODE_OTHER)

	firemode_index++
	if(firemode_index > gun_firemodes.len)
		firemode_index = 1 //reset to the first index if it's over the limit. Byond arrays start at 1 instead of 0, hence why its set to 1.

	var/current_firemode = gun_firemodes[firemode_index]
	if(current_firemode == FIREMODE_FULLAUTO)
		SEND_SIGNAL(src, COMSIG_GUN_ENABLE_AUTOFIRE)
	else
		SEND_SIGNAL(src, COMSIG_GUN_DISABLE_AUTOFIRE)
//wawa
	to_chat(user, "<span class='notice'>Switched to [gun_firenames[current_firemode]].</span>")
	playsound(user, 'sound/weapons/gun/general/selector.ogg', 100, TRUE)
	update_appearance()
	for(var/datum/action/current_action as anything in actions)
		current_action.UpdateButtonIcon()

/datum/action/item_action/toggle_firemode/UpdateButtonIcon(status_only = FALSE, force = FALSE)
	var/obj/item/gun/our_gun = target

	var/current_firemode = our_gun.gun_firemodes[our_gun.firemode_index]
	//tldr; if we have adjust_fire_select_icon_state_on_safety as true, we append "safety_" to the prefix, otherwise nothing.
	var/safety_prefix = "[our_gun.adjust_fire_select_icon_state_on_safety ? "[our_gun.safety ? "safety_" : ""]" : ""]"
	button_icon_state = "[safety_prefix][our_gun.fire_select_icon_state_prefix][current_firemode]"
	return ..()

GLOBAL_LIST_INIT(gun_saw_types, typecacheof(list(
	/obj/item/gun/energy/plasmacutter,
	/obj/item/melee/energy,
	)))

///Handles all the logic of sawing off guns,
/obj/item/gun/proc/try_sawoff(mob/user, obj/item/saw)
	if(!saw.get_sharpness() || !is_type_in_typecache(saw, GLOB.gun_saw_types) && saw.tool_behaviour != TOOL_SAW) //needs to be sharp. Otherwise turned off eswords can cut this.
		return
	if(sawn_off)
		to_chat(user, span_warning("\The [src] is already shortened!"))
		return
	user.changeNext_move(CLICK_CD_MELEE)
	user.visible_message(span_notice("[user] begins to shorten \the [src]."), span_notice("You begin to shorten \the [src]..."))

	//if there's any live ammo inside the gun, makes it go off
	if(blow_up(user))
		user.visible_message(span_danger("\The [src] goes off!"), span_danger("\The [src] goes off in your face!"))
		return

	if(do_after(user, 30, target = src))
		user.visible_message(span_notice("[user] shortens \the [src]!"), span_notice("You shorten \the [src]."))
		sawoff(user, saw)

///Used on init or try_sawoff
/obj/item/gun/proc/sawoff(forced = FALSE)
	if(sawn_off && !forced)
		return
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
/obj/item/gun/proc/blow_up(mob/user)
	return
