//supertype for CS gauss cause they do things different.
/obj/item/gun/ballistic/cs_gauss
	name = "cybersun gauss gun supertype"

	//more bullet per bullet
	casing_ejector = FALSE

	slot_available = list()

	empty_alarm = TRUE
	empty_autoeject = TRUE
	//if i read this correctly this should mean its always ready to fire //it doesn't but whatever
	bolt_type = BOLT_TYPE_STANDARD
	always_chambers = TRUE

	tac_reloads = FALSE
	bolt_wording = "prime"
	cartridge_wording = "dart"

	show_magazine_on_sprite = TRUE

	gun_firemodes = list(FIREMODE_SEMIAUTO, FIREMODE_BURST, FIREMODE_FULLAUTO)
	gun_firenames = list(FIREMODE_SEMIAUTO = "solo", FIREMODE_BURST = "burst", FIREMODE_FULLAUTO = "automatic")

	recoil = 0.3

	wear_minor_threshold = 180
	/// Gun will start to jam more at this level of wear. The grace period between jams is also removed for extra fun
	wear_major_threshold = 300
	/// Highest wear value so the gun doesn't end up completely irreperable
	wear_maximum = 480

	ammo_counter = TRUE

	//shameless asset reuse
	fire_select_icon_state_prefix = "lance_"

	bad_type = /obj/item/gun/ballistic/cs_gauss

	//if this has the functionality for locking a target
	var/smart_lock = TRUE
	//the current target of the gun
	var/datum/weakref/current_target = null
	//how fuzzy our smart lock is. Basically a flat chance our shots won't home.
	var/lock_loss = 0

/obj/item/gun/ballistic/cs_gauss/examine(mob/user)
	. = ..()
	. += span_notice("You can <b>Right-Click</b> a mob to lock it as a target!")

/obj/item/gun/ballistic/cs_gauss/update_overlays()
	. = ..()
	if(smart_lock)
		if(magazine)
			. += "[base_icon_state]-scope-0"
		else
			. += "[base_icon_state]-scope-1"

/obj/item/gun/ballistic/cs_gauss/afterattack_secondary(atom/target, mob/user, proximity_flag, click_parameters)
	if(proximity_flag)
		return SECONDARY_ATTACK_CALL_NORMAL

	if(!smart_lock)
		return SECONDARY_ATTACK_CALL_NORMAL

	if(isturf(target))
		current_target = WEAKREF(locate(/mob/living) in get_turf(target))
		if(current_target)
			balloon_alert(user, "target locked")
			lock_loss = 0
			START_PROCESSING(SSfastprocess, src)
		else
			if(current_target)
				current_target = null
				balloon_alert(user, "target cleared")
				STOP_PROCESSING(SSfastprocess, src)

	else if(ismob(target))
		current_target = WEAKREF(target)
		balloon_alert(user, "target locked")
		lock_loss = 0
		START_PROCESSING(SSfastprocess, src)

	else
		if(current_target)
			current_target = null
			balloon_alert(user, "target cleared")
			STOP_PROCESSING(SSfastprocess, src)

	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/item/gun/ballistic/cs_gauss/process(seconds_per_tick)
	if(!current_target)
		STOP_PROCESSING(SSfastprocess, src)
		return PROCESS_KILL

	if(!can_see(src, current_target.resolve(), 8))
		lock_loss = min(lock_loss+5, 100)
	else
		lock_loss = max(lock_loss-5, 0)

	if(lock_loss == 100)
		balloon_alert_to_viewers("Target lost.", vision_distance = 1)
		current_target = null
		lock_loss = 0
		STOP_PROCESSING(SSfastprocess, src)

/obj/item/gun/ballistic/cs_gauss/process_fire(atom/target, mob/living/user, message, params, zone_override, bonus_spread, burst_firing, spread_override, iteration)
	if(current_target)
		if(!prob(lock_loss) || !lock_loss)
			chambered.BB.homing = TRUE
			chambered.BB.homing_target = current_target.resolve()
			chambered.BB.accuracy_mod = 3
	. = ..()


/obj/item/gun/ballistic/cs_gauss/rectifier
	name = "\improper SG27 Rectifier"
	desc = "The successor to the iconic 'SG11 Amend' gauss pistol manufactured by Tadeusz Armory. Virtual Solutions Troubleshooters demanded an version with enhanced target tracking for indoor complex indoor combat context. Payload was reduced, and digitalized targetting system was added to coordinate fire, leading to the SG27 Rectifier."
	base_icon_state = "rectifier"
	icon_state = "rectifier"
	item_state = "small"
	icon = 'icons/obj/guns/manufacturer/cybersun/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/cybersun/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/cybersun/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/cybersun/onmob.dmi'

	w_class = WEIGHT_CLASS_SMALL
	default_ammo_type = /obj/item/ammo_box/magazine/cs_gauss/pistol


	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/cs_gauss/pistol,
	)

	load_sound = 'sound/weapons/gun/gauss/pistol_reload.ogg'
	load_empty_sound = 'sound/weapons/gun/gauss/pistol_reload.ogg'
	eject_sound = 'sound/weapons/gun/pistol/mag_release.ogg'
	eject_empty_sound = 'sound/weapons/gun/pistol/mag_release.ogg'

	rack_sound = 'sound/weapons/gun/pistol/rack_small.ogg'

	fire_sound = 'sound/weapons/gun/cybersun/gauss.ogg'
	fire_sound_volume = 75
	vary_fire_sound = TRUE

	///How much the bullet scatters when fired while wielded.
	spread	= 8
	///How much the bullet scatters when fired while unwielded.
	spread_unwielded = 16
	//additional spread when dual wielding
	dual_wield_spread = 24

	fire_delay = 0.04
	burst_delay = 0.03
	burst_size = 5

/obj/item/gun/ballistic/cs_gauss/rectifier/export
	name = "\improper SG11 Amend"
	desc = "An iconic gauss pistol manufactured by Tadeusz Armory. Sold to dozens of security agencies in the South Teceti Combine before finding a secondary market in space due to low risk of the gauss darts causing overpenetration. Modern versions are made in the same caliber as the SG27 Rectifier."


	///How much the bullet scatters when fired while wielded.
	spread = 6
	///How much the bullet scatters when fired while unwielded.
	spread_unwielded = 8
	//additional spread when dual wielding
	dual_wield_spread = 24

	ammo_counter = FALSE
	smart_lock = FALSE

NO_MAG_GUN_HELPER(cs_gauss/rectifier)
NO_MAG_GUN_HELPER(cs_gauss/rectifier/export)

/obj/item/gun/ballistic/cs_gauss/convergence
	name = "\improper SG49 Convergence"
	desc = "Designed to suppress hostile targets with sustained accurate fire, the Convergence fires the same round as the smaller Rectifier, but with double the magazine capacity to allow fire to be sustained. Longer accelerator also makes unassisted fire more accurate, leading to a fairly reliable automatic weapon."
	base_icon_state = "convergence"
	icon_state = "convergence"
	item_state = "convergence"
	icon = 'icons/obj/guns/manufacturer/cybersun/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/cybersun/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/cybersun/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/cybersun/onmob.dmi'

	w_class = WEIGHT_CLASS_BULKY
	default_ammo_type = /obj/item/ammo_box/magazine/cs_gauss

	wear_minor_threshold = 240
	wear_major_threshold = 380

	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/cs_gauss,
	)

	load_sound = 'sound/weapons/gun/gauss/rifle_reload.ogg'
	load_empty_sound = 'sound/weapons/gun/gauss/rifle_reload.ogg'
	eject_sound = 'sound/weapons/gun/smg/smg_unload.ogg'
	eject_empty_sound = 'sound/weapons/gun/smg/smg_unload.ogg'

	rack_sound = 'sound/weapons/gun/smg/uzi_cocked.ogg'

	fire_sound = 'sound/weapons/gun/cybersun/gauss.ogg'
	fire_sound_volume = 100
	vary_fire_sound = TRUE

	spread = 8
	spread_unwielded = 12

	fire_delay = 0.03

/obj/item/gun/ballistic/cs_gauss/convergence/export
	name = "\improper SG48 Divergence"
	desc = "A mildly more accurate version of the SG49 Convergence, manufactured for public sale. The targetting computer is removed and power used for it is redirected to the accelerator, leading to sustained, semi-accurate low calibre fire."

	spread = 6
	spread_unwielded = 12

	ammo_counter = FALSE
	smart_lock = FALSE

NO_MAG_GUN_HELPER(cs_gauss/convergence)
NO_MAG_GUN_HELPER(cs_gauss/convergence/export)

/obj/item/gun/ballistic/cs_gauss/vector
	name = "\improper SG95 Vector"
	desc = "The largest smart-gauss weapon manufactured by Tadeusz Armory. The SG95 Vector is an upscaled accelerator mechanism from the SG49 Convergence refitted for 3x20mm Deu'Sha gauss darts. Larger darts have mildly more penetrative power, but challenge the power supply, reducing the effective rate of fire."
	base_icon_state = "vector"
	icon_state = "vector"
	item_state = "vector"
	icon = 'icons/obj/guns/manufacturer/cybersun/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/cybersun/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/cybersun/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/cybersun/onmob.dmi'

	w_class = WEIGHT_CLASS_BULKY
	default_ammo_type = /obj/item/ammo_box/magazine/cs_gauss/rifle


	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/cs_gauss/rifle,
	)

	load_sound = 'sound/weapons/gun/gauss/rifle_reload.ogg'
	load_empty_sound = 'sound/weapons/gun/gauss/rifle_reload.ogg'
	eject_sound = 'sound/weapons/gun/smg/smg_unload.ogg'
	eject_empty_sound = 'sound/weapons/gun/smg/smg_unload.ogg'

	rack_sound = 'sound/weapons/gun/smg/uzi_cocked.ogg'

	fire_sound = 'sound/weapons/gun/cybersun/gauss2.ogg'
	fire_sound_volume = 100
	vary_fire_sound = TRUE

	recoil = 0.6

	spread = 2
	spread_unwielded = 6

	fire_delay = 0.1
	burst_delay = 0.1
	burst_size = 4

/obj/item/gun/ballistic/cs_gauss/vector/export
	name = "\improper SG90 Director"
	desc = "An export version of the SG95 Vector. Fires larger gauss darts in exchange for a reduced rate of fire. The Director is renowned for being a stable firing platform compared to the Vector, which is reputed to be off-weight due to the targetting computer."

	spread = 0
	spread_unwielded = 6

	gun_firemodes = list(FIREMODE_SEMIAUTO, FIREMODE_BURST)
	burst_delay = 0.15
	burst_size = 6

	ammo_counter = FALSE
	smart_lock = FALSE

NO_MAG_GUN_HELPER(cs_gauss/vector)
NO_MAG_GUN_HELPER(cs_gauss/vector/export)
