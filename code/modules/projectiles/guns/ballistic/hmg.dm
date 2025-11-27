//TODO: rename this file to lmg.dm and: /obj/item/gun/ballistic/automatic/hmg --> /obj/item/gun/ballistic/automatic/lmg

/obj/item/gun/ballistic/automatic/hmg
	bad_type = /obj/item/gun/ballistic/automatic/hmg
	w_class = WEIGHT_CLASS_HUGE
	slot_flags = 0
	weapon_weight = WEAPON_HEAVY
	burst_size = 1
	actions_types = list(/datum/action/item_action/deploy_bipod) //this is on hmg, as I need the same mechanics for a future gun. ideally, this would be an attachment, but that's still pending
	drag_slowdown = 1.5
	fire_delay = 0.1 SECONDS

	gun_firemodes = list(FIREMODE_FULLAUTO)
	default_firemode = FIREMODE_FULLAUTO

	wield_slowdown = HMG_SLOWDOWN

	spread = 4
	spread_unwielded = 80
	recoil = 1
	recoil_unwielded = 4

	gunslinger_recoil_bonus = 2
	gunslinger_spread_bonus = 20

	///does this have a bipod?
	var/has_bipod = FALSE
	///is the bipod deployed?
	var/bipod_deployed = FALSE
	///how long do we need to deploy the bipod?
	var/deploy_time = 0.5 SECONDS

	///we add these two values to recoi/spread when we have the bipod deployed
	var/deploy_recoil_bonus = -1
	var/deploy_spread_bonus = -5

	var/list/deployable_on_structures = list(
	/obj/structure/table,
	/obj/structure/barricade,
	/obj/structure/bed,
	/obj/structure/chair,
	/obj/structure/railing,
	/obj/structure/flippedtable
	)
	wear_minor_threshold = 300
	wear_major_threshold = 900
	wear_maximum = 1500


/obj/item/gun/ballistic/automatic/hmg/Initialize()
	. = ..()
	for(var/datum/action/item_action/deploy_bipod/action as anything in actions)
		if(!has_bipod)
			qdel(action)

/obj/item/gun/ballistic/automatic/hmg/ComponentInitialize()
	. = ..()
	RegisterSignals(src, list(COMSIG_ITEM_EQUIPPED,COMSIG_MOVABLE_MOVED), PROC_REF(retract_bipod))

/datum/action/item_action/deploy_bipod //TODO: Make this an accessory when that's added
	name = "Deploy Bipod"
	desc = "Deploy the bipod when bracing against something to increase accuracy."

/obj/item/gun/ballistic/automatic/hmg/ui_action_click(mob/user, action)
	if(!istype(action, /datum/action/item_action/deploy_bipod))
		return ..()
	if(!bipod_deployed)
		deploy_bipod(user)
	else
		retract_bipod(user=user)

/obj/item/gun/ballistic/automatic/hmg/calculate_recoil(mob/user, recoil_bonus = 0)
	var/total_recoil = recoil_bonus

	if(bipod_deployed)
		total_recoil += deploy_recoil_bonus

	return ..(user, total_recoil)

/obj/item/gun/ballistic/automatic/hmg/calculate_spread(mob/user, bonus_spread)
	var/total_spread = bonus_spread

	if(bipod_deployed)
		total_spread += deploy_spread_bonus

	return ..(user, total_spread)

/obj/item/gun/ballistic/automatic/hmg/proc/deploy_bipod(mob/user)
	//we check if we can actually deploy the thing
	var/can_deploy = TRUE
	var/mob/living/wielder = user

	if(!wielder)
		return

	if(!wielded_fully)
		to_chat(user, span_warning("You need to fully grip [src] to deploy it's bipod!"))
		return

	if(wielder.body_position != LYING_DOWN) //are we braced against the ground? if not, we check for objects to brace against
		can_deploy = FALSE

		for(var/direction_to_check as anything in GLOB.cardinals) //help
			var/turf/open/turf_to_check = get_step(get_turf(src),direction_to_check)
			for(var/obj/structure/checked_struct as anything in turf_to_check.contents) //while you can fire in non-braced directions, this makes it so you have to get good positioning to fire standing up.
				for(var/checking_allowed as anything in deployable_on_structures)
					if(istype(checked_struct, checking_allowed)) //help if you know how to write this better
						can_deploy = TRUE
						break


	if(!can_deploy)
		to_chat(user, span_warning("You need to brace against something to deploy [src]'s bipod! Either lie on the floor or stand next to a waist high object like a table!"))
		return
	if(!do_after(user, deploy_time, src, NONE, TRUE, CALLBACK(src, PROC_REF(is_wielded))))
		to_chat(user, span_warning("You need to hold still to deploy [src]'s bipod!"))
		return
	playsound(src, 'sound/machines/click.ogg', 75, TRUE)
	to_chat(user, span_notice("You deploy [src]'s bipod."))
	bipod_deployed = TRUE

	RegisterSignal(user, COMSIG_MOVABLE_MOVED, PROC_REF(retract_bipod))
	update_appearance()

/obj/item/gun/ballistic/automatic/hmg/proc/retract_bipod(atom/source, mob/user)
	SIGNAL_HANDLER
	if(!bipod_deployed)
		return
	if(!user || !ismob(user))
		user = loc
	playsound(src, 'sound/machines/click.ogg', 75, TRUE)
	to_chat(user, span_notice("The bipod undeploys itself."))
	bipod_deployed = FALSE

	UnregisterSignal(user, COMSIG_MOVABLE_MOVED)
	update_appearance()


/obj/item/gun/ballistic/automatic/hmg/on_unwield(obj/item/source, mob/user)
	. = ..()
	retract_bipod(user=user)

/obj/item/gun/ballistic/automatic/hmg/update_icon_state()
	. = ..()
	item_state = "[initial(item_state)][bipod_deployed ? "_deployed" : ""]"

/obj/item/gun/ballistic/automatic/hmg/update_overlays()
	. = ..()
	if(has_bipod)
		. += "[base_icon_state || initial(icon_state)][bipod_deployed ? "_deployed" : "_undeployed"]"

/obj/item/gun/ballistic/automatic/hmg/solar //This thing fires a 5.56 equivalent, that's an LMG, not an HMG, get out
	name = "\improper Solar"
	desc = "A TerraGov LMG-169 designed in 169 FS, nicknamed 'Solar.' A inscription reads: 'PROPERTY OF TERRAGOV', with 'TERRAGOV' poorly scribbled out, and replaced by 'SOLAR ARMORIES'. Chambered in 4.73×33mm caseless ammunition."
	icon = 'icons/obj/guns/manufacturer/solararmories/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/solararmories/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/solararmories/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/solararmories/onmob.dmi'

	icon_state = "solar"

	fire_sound = 'sound/weapons/gun/l6/shot.ogg'
	default_ammo_type = /obj/item/ammo_box/magazine/rifle47x33mm
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/rifle47x33mm,
	)
	spread = 7

	fire_delay = 0.1 SECONDS

	fire_select_icon_state_prefix = "caseless_"

	show_magazine_on_sprite = TRUE
	w_class = WEIGHT_CLASS_BULKY
	manufacturer = MANUFACTURER_SOLARARMORIES


