/obj/item/gun
	name = "gun"
	desc = "It's a gun. It's pretty terrible, though."
	icon = 'icons/obj/guns/projectile.dmi'
	icon_state = "flatgun"
	item_state = "gun"
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

	/// The manufacturer of this weapon. For flavor mostly. If none, this will not show.
	var/manufacturer = MANUFACTURER_NONE

	var/fire_sound = 'sound/weapons/gun/pistol/shot.ogg'
	var/vary_fire_sound = TRUE
	var/fire_sound_volume = 50
	var/dry_fire_sound = 'sound/weapons/gun/general/dry_fire.ogg'
	///Text showed when attempting to fire with no round or empty round.
	var/dry_fire_text = "click"
	///whether or not a message is displayed when fired
	var/suppressed = null
	var/can_suppress = FALSE
	var/suppressed_sound = 'sound/weapons/gun/general/heavy_shot_suppressed.ogg'
	var/suppressed_volume = 60
	var/can_unsuppress = TRUE
	var/obj/item/ammo_casing/chambered = null
	///trigger guard on the weapon. Used for hulk mutations and ashies. I honestly dont know how usefult his is, id avoid touching it
	trigger_guard = TRIGGER_GUARD_NORMAL
	///Set the description of the gun to this when sawed off
	var/sawn_desc = null
	///This triggers some sprite behavior in shotguns and prevents further sawoff, note that can_be_sawn_off is on gun/ballistic and not here, wtf.
	var/sawn_off = FALSE

	/// how many shots per burst, Ex: most machine pistols, M90, some ARs are 3rnd burst, while others like the GAR and laser minigun are 2 round burst.
	var/burst_size = 3
	///The rate of fire when firing in a burst. Not the delay between bursts
	var/burst_delay = 0.15 SECONDS
	///The rate of fire when firing full auto and semi auto, and between bursts; for bursts its fire delay + burst_delay after every burst
	var/fire_delay = 0.2 SECONDS

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
	///affects if you can fire it unwielded or even dual wield it. LIGHT means dual wield allowed, HEAVY and higher means you have to wield to fire
	var/weapon_weight = WEAPON_LIGHT
	///If dual wielding, add this to the spread
	var/dual_wield_spread = 24
	/// ???, no clue what this is. Original desc: //Set to 0 for shotguns. This is used for weapons that don't fire all their bullets at once.
	var/randomspread = 1

	///Alters projectile damage multiplicatively based on this value. Use it for "better" or "worse" weapons that use the same ammo.
	var/projectile_damage_multiplier = 1

	lefthand_file = 'icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/guns_righthand.dmi'

	var/list/attachment_options = list()	//This.. works for now.. gun refactor soon

	var/can_flashlight = FALSE //if a flashlight can be added or removed if it already has one.
	var/obj/item/flashlight/seclite/gun_light
	var/datum/action/item_action/toggle_gunlight/alight
	var/gunlight_state = "flight"

	var/can_bayonet = FALSE //if a bayonet can be added or removed if it already has one.
	var/obj/item/kitchen/knife/bayonet
	var/knife_x_offset = 0
	var/knife_y_offset = 0

	var/ammo_x_offset = 0 //used for positioning ammo count overlay on sprite
	var/ammo_y_offset = 0
	var/flight_x_offset = 0
	var/flight_y_offset = 0

	//Zooming
	var/zoomable = FALSE //whether the gun generates a Zoom action on creation
	var/zoomed = FALSE //Zoom toggle
	var/zoom_amt = 3 //Distance in TURFs to move the user's screen forward (the "zoom" effect)
	var/zoom_out_amt = 0
	var/datum/action/toggle_scope_zoom/azoom

	var/pb_knockback = 0

	var/wielded = FALSE // true if the gun is wielded via twohanded component, shouldnt affect anything else

	var/wielded_fully = FALSE // true if the gun is wielded after delay, should affects accuracy

	///How much the bullet scatters when fired while wielded.
	var/spread	= 4
	///How much the bullet scatters when fired while unwielded.
	var/spread_unwielded = 12

	///Screen shake when the weapon is fired while wielded.
	var/recoil = 0
	///Screen shake when the weapon is fired while unwielded.
	var/recoil_unwielded = 0
	///a multiplier of the duration the recoil takes to go back to normal view, this is (recoil*recoil_backtime_multiplier)+1
	var/recoil_backtime_multiplier = 2
	///this is how much deviation the gun recoil can have, recoil pushes the screen towards the reverse angle you shot + some deviation which this is the max.
	var/recoil_deviation = 22.5

	///Slowdown for wielding
	var/wield_slowdown = 0.1
	///How long between wielding and firing in tenths of seconds
	var/wield_delay	= 0.4 SECONDS
	///Storing value for above
	var/wield_time = 0

	///Effect for the muzzle flash of the gun.
	var/obj/effect/muzzle_flash/muzzle_flash
	///Icon state of the muzzle flash effect.
	var/muzzleflash_iconstate
	///Brightness of the muzzle flash effect.
	var/muzzle_flash_lum = 3
	///Color of the muzzle flash effect.
	var/muzzle_flash_color = COLOR_VERY_SOFT_YELLOW

	//gun saftey
	///Does this gun have a saftey and thus can toggle it?
	var/has_safety = FALSE
	///If the saftey on? If so, we can't fire the weapon
	var/safety = FALSE

	///The wording of safety. Useful for guns that have a non-standard safety system, like a revolver
	var/safety_wording = "safety"

/obj/item/gun/Initialize()
	. = ..()
	RegisterSignal(src, COMSIG_TWOHANDED_WIELD, PROC_REF(on_wield))
	RegisterSignal(src, COMSIG_TWOHANDED_UNWIELD, PROC_REF(on_unwield))
	if(gun_light)
		alight = new(src)
	muzzle_flash = new(src, muzzleflash_iconstate)
	build_zooming()
	build_firemodes()

/obj/item/gun/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed)

/// triggered on wield of two handed item
/obj/item/gun/proc/on_wield(obj/item/source, mob/user)
	wielded = TRUE
	INVOKE_ASYNC(src, .proc.do_wield, user)

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

/obj/item/gun/proc/is_wielded()
	return wielded

/// triggered on unwield of two handed item
/obj/item/gun/proc/on_unwield(obj/item/source, mob/user)
	wielded = FALSE
	wielded_fully = FALSE
	zoom(user, forced_zoom = FALSE)
	user.remove_movespeed_modifier(/datum/movespeed_modifier/gun)

/obj/item/gun/Destroy()
	if(gun_light)
		QDEL_NULL(gun_light)
	if(bayonet)
		QDEL_NULL(bayonet)
	if(chambered) //Not all guns are chambered (EMP'ed energy guns etc)
		QDEL_NULL(chambered)
	if(azoom)
		QDEL_NULL(azoom)
	if(isatom(suppressed)) //SUPPRESSED IS USED AS BOTH A TRUE/FALSE AND AS A REF, WHAT THE FUCKKKKKKKKKKKKKKKKK
		QDEL_NULL(suppressed)
	if(muzzle_flash)
		QDEL_NULL(muzzle_flash)
	return ..()

/obj/item/gun/handle_atom_del(atom/A)
	if(A == chambered)
		chambered = null
		update_appearance()
	if(A == bayonet)
		clear_bayonet()
	if(A == gun_light)
		clear_gunlight()
	return ..()

/obj/item/gun/examine(mob/user)
	. = ..()
	if(gun_light)
		. += "It has \a [gun_light] [can_flashlight ? "" : "permanently "]mounted on it."
		if(can_flashlight) //if it has a light and this is false, the light is permanent.
			. += "<span class='info'>[gun_light] looks like it can be <b>unscrewed</b> from [src].</span>"
	else if(can_flashlight)
		. += "It has a mounting point for a <b>seclite</b>."

	if(bayonet)
		. += "It has \a [bayonet] [can_bayonet ? "" : "permanently "]affixed to it."
		if(can_bayonet) //if it has a bayonet and this is false, the bayonet is permanent.
			. += "<span class='info'>[bayonet] looks like it can be <b>unscrewed</b> from [src].</span>"
	else if(can_bayonet)
		. += "It has a <b>bayonet</b> lug on it."

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
		if(bayonet)
			M.attackby(bayonet, user)
			return
		else
			return ..()
	return

/obj/item/gun/attack_obj(obj/O, mob/user)
	if(user.a_intent == INTENT_HARM)
		if(bayonet)
			O.attackby(bayonet, user)
			return
	return ..()

/obj/item/gun/attackby(obj/item/I, mob/user, params)
	if(user.a_intent == INTENT_HARM)
		return ..()
	else if(istype(I, /obj/item/flashlight/seclite))
		if(!can_flashlight)
			return ..()
		var/obj/item/flashlight/seclite/S = I
		if(!gun_light)
			if(!user.transferItemToLoc(I, src))
				return
			to_chat(user, "<span class='notice'>You click [S] into place on [src].</span>")
			set_gun_light(S)
			update_gunlight()
			alight = new(src)
			if(loc == user)
				alight.Grant(user)
	else if(istype(I, /obj/item/kitchen/knife))
		var/obj/item/kitchen/knife/K = I
		if(!can_bayonet || !K.bayonet || bayonet) //ensure the gun has an attachment point available, and that the knife is compatible with it.
			return ..()
		if(!user.transferItemToLoc(I, src))
			return
		to_chat(user, "<span class='notice'>You attach [K] to [src]'s bayonet lug.</span>")
		bayonet = K
		update_appearance()

	else
		return ..()

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


/obj/item/gun/screwdriver_act(mob/living/user, obj/item/I)
	. = ..()
	if(.)
		return
	if(!user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		return
	attachment_options = list()
	get_gun_attachments()
	if(LAZYLEN(attachment_options) == 1)
		remove_gun_attachments(user, I, attachment_options[1])
	else if (LAZYLEN(attachment_options))
		var/picked_option = show_radial_menu(user, src, attachment_options, radius = 38, require_near = TRUE)
		remove_gun_attachments(user, I, picked_option)

/obj/item/gun/proc/get_gun_attachments()
	if(can_flashlight && gun_light)
		attachment_options += list("Light" = image(icon = gun_light.icon, icon_state = gun_light.icon_state))
	if(can_bayonet && bayonet)
		attachment_options += list("Knife" = image(icon = bayonet.icon, icon_state = bayonet.icon_state))

/obj/item/gun/proc/remove_gun_attachments(mob/living/user, obj/item/I, picked_option)
	if(picked_option == "Light")
		return remove_gun_attachment(user, I, gun_light, "unscrewed")
	else if(picked_option == "Knife")
		return remove_gun_attachment(user, I, bayonet, "unfix")

/obj/item/gun/proc/remove_gun_attachment(mob/living/user, obj/item/tool_item, obj/item/item_to_remove, removal_verb)
	if(tool_item)
		tool_item.play_tool_sound(src)
	to_chat(user, "<span class='notice'>You [removal_verb ? removal_verb : "remove"] [item_to_remove] from [src].</span>")
	item_to_remove.forceMove(drop_location())

	if(Adjacent(user) && !issilicon(user))
		user.put_in_hands(item_to_remove)

	if(item_to_remove == bayonet)
		return clear_bayonet()
	else if(item_to_remove == gun_light)
		return clear_gunlight()

/obj/item/gun/proc/clear_bayonet()
	if(!bayonet)
		return
	bayonet = null
	update_appearance()
	return TRUE

/obj/item/gun/proc/clear_gunlight()
	if(!gun_light)
		return
	var/obj/item/flashlight/seclite/removed_light = gun_light
	set_gun_light(null)
	update_gunlight()
	removed_light.update_brightness()
	QDEL_NULL(alight)
	return TRUE

/**
 * Swaps the gun's seclight, dropping the old seclight if it has not been qdel'd.
 *
 * Returns the former gun_light that has now been replaced by this proc.
 * Arguments:
 * * new_light - The new light to attach to the weapon. Can be null, which will mean the old light is removed with no replacement.
 */
/obj/item/gun/proc/set_gun_light(obj/item/flashlight/seclite/new_light)
	// Doesn't look like this should ever happen? We're replacing our old light with our old light?
	if(gun_light == new_light)
		CRASH("Tried to set a new gun light when the old gun light was also the new gun light.")

	. = gun_light

	// If there's an old gun light that isn't being QDELETED, detatch and drop it to the floor.
	if(!QDELETED(gun_light))
		gun_light.set_light_flags(gun_light.light_flags & ~LIGHT_ATTACHED)
		if(gun_light.loc != get_turf(src))
			gun_light.forceMove(get_turf(src))

	// If there's a new gun light to be added, attach and move it to the gun.
	if(new_light)
		new_light.set_light_flags(new_light.light_flags | LIGHT_ATTACHED)
		if(new_light.loc != src)
			new_light.forceMove(src)

	gun_light = new_light

/obj/item/gun/ui_action_click(mob/user, actiontype)
	if(istype(actiontype, alight))
		toggle_gunlight()
	else
		..()

/obj/item/gun/proc/toggle_gunlight()
	if(!gun_light)
		return

	var/mob/living/carbon/human/user = usr
	gun_light.on = !gun_light.on
	gun_light.update_brightness()
	to_chat(user, "<span class='notice'>You toggle the gunlight [gun_light.on ? "on":"off"].</span>")

	playsound(user, gun_light.on ? gun_light.toggle_on_sound : gun_light.toggle_off_sound, 40, TRUE)
	update_gunlight()

/obj/item/gun/proc/update_gunlight()
	update_appearance()
	for(var/X in actions)
		var/datum/action/A = X
		A.UpdateButtonIcon()

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
	if(gun_light)
		var/mutable_appearance/flashlight_overlay
		var/state = "[gunlight_state][gun_light.on? "_on":""]"	//Generic state.
		if(gun_light.icon_state in icon_states('icons/obj/guns/flashlights.dmi'))	//Snowflake state?
			state = gun_light.icon_state
		flashlight_overlay = mutable_appearance('icons/obj/guns/flashlights.dmi', state)
		flashlight_overlay.pixel_x = flight_x_offset
		flashlight_overlay.pixel_y = flight_y_offset
		. += flashlight_overlay

	if(bayonet)
		var/mutable_appearance/knife_overlay
		var/state = "bayonet"							//Generic state.
		if(bayonet.icon_state in icon_states('icons/obj/guns/bayonets.dmi'))		//Snowflake state?
			state = bayonet.icon_state
		var/icon/bayonet_icons = 'icons/obj/guns/bayonets.dmi'
		knife_overlay = mutable_appearance(bayonet_icons, state)
		knife_overlay.pixel_x = knife_x_offset
		knife_overlay.pixel_y = knife_y_offset
		. += knife_overlay

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
		if(!pre_fire(target, user, TRUE, params, BODY_ZONE_HEAD))
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

// We do it like this in case theres some specific gun behavior for adjusting recoil, like bipods or folded stocks
/obj/item/gun/proc/calculate_recoil(mob/user, recoil_bonus = 0)
	return recoil_bonus

// We do it like this in case theres some specific gun behavior for adjusting spread, like bipods or folded stocks
/obj/item/gun/proc/calculate_spread(mob/user, bonus_spread)
	///our final spread value
	var/sprd = 0
	///our randomized value after checking if we are wielded or not
	var/randomized_gun_spread = 0
	///bonus
	var/randomized_bonus_spread
	// do we have poor aim
	var/poor_aim = FALSE

	//do we have bonus_spread ? If so, set sprd to it because it means a subtype's proc messed with it
	sprd += bonus_spread

	//reset bonus_spread for poor aim...
	bonus_spread = 0

	// if we have poor aim, we fuck the shooter over
	if(HAS_TRAIT(user, TRAIT_POOR_AIM))
		bonus_spread += 25
		poor_aim = TRUE
	// then we randomize the bonus spread
	randomized_bonus_spread = rand(poor_aim ? 10 : 0, bonus_spread) //poor aim is no longer just a nusiance

	//then, we mutiply previous bonus spread as it means dual wielding usually, it also means poor aim is also even more severe
	randomized_bonus_spread *= DUALWIELD_PENALTY_EXTRA_MULTIPLIER

	// we will then calculate gun spread depending on if we are fully wielding (after do_after) the gun or not
	randomized_gun_spread =	rand(0, wielded_fully ? spread : spread_unwielded)

	//finally, we put it all together including if sprd has a value
	sprd += randomized_gun_spread + randomized_bonus_spread

	//clamp it down to avoid guns with negative spread to have worse recoil...
	sprd = clamp(sprd, 0, INFINITY)

	// im not sure what this does, i beleive its meant to make it so  bullet spread goes in the opposite direction? get back to me on this - update,i have commented it out, however it appears be dapening spread. weird.
	//sprd *= (rand() - 0.5)

	//coin flip if we mutiply output by -1 so spread isn't JUST to the right
	if(prob(50))
		sprd *= -1

	// then we round it up and send it!
	sprd = round(sprd)

	return sprd

/obj/item/gun/proc/simulate_recoil(mob/living/user, recoil_bonus = 0, firing_angle)
	var/total_recoil = calculate_recoil(user, recoil_bonus)
	total_recoil = clamp(total_recoil, 0 , INFINITY)

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

/////////////
// ZOOMING //
/////////////

/datum/action/toggle_scope_zoom
	name = "Toggle Scope"
	check_flags = AB_CHECK_CONSCIOUS|AB_CHECK_HANDS_BLOCKED|AB_CHECK_IMMOBILE|AB_CHECK_LYING
	icon_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "sniper_zoom"
	var/obj/item/gun/gun = null

/datum/action/toggle_scope_zoom/Trigger()
	gun.zoom(owner, owner.dir)

/datum/action/toggle_scope_zoom/IsAvailable()
	. = ..()
	if(!. && gun)
		gun.zoom(owner, owner.dir, FALSE)

/datum/action/toggle_scope_zoom/Remove(mob/living/L)
	gun.zoom(L, L.dir, FALSE)
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
		azoom = new()
		azoom.gun = src

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
