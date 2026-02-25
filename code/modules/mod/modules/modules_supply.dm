//Supply modules for MODsuits

///Internal GPS - Extends a GPS you can use.
/obj/item/mod/module/gps
	name = "MOD internal GPS module"
	desc = "This module uses common Nanotrasen technology to calculate the user's position anywhere in space, \
		down to the exact coordinates. This information is fed to a central database viewable from the device itself, \
		though using it to help people is up to you."
	icon_state = "gps"
	module_type = MODULE_USABLE
	complexity = 1
	use_power_cost = DEFAULT_CHARGE_DRAIN * 0.2
	incompatible_modules = list(/obj/item/mod/module/gps)
	cooldown_time = 0.5 SECONDS
	allowed_inactive = TRUE

/obj/item/mod/module/gps/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/gps/item, "MOD0", TRUE)

/obj/item/mod/module/gps/on_use()
	. = ..()
	if(!.)
		return
	// var/datum/component/gps/item/internal_gps = GetComponent(/datum/component/gps/item)
	// internal_gps.ui_interact(mod.wearer)
	attack_self(mod.wearer)

///Hydraulic Clamp - Lets you pick up and drop crates.
/obj/item/mod/module/clamp
	name = "MOD hydraulic clamp module"
	desc = "A series of actuators installed into both arms of the suit, boasting a lifting capacity of almost a ton. \
		However, this design has been locked by Nanotrasen to be primarily utilized for lifting various crates. \
		A lot of people would say that loading cargo is a dull job, but you could not disagree more."
	icon_state = "clamp"
	module_type = MODULE_ACTIVE
	complexity = 3
	use_power_cost = MODULE_CHARGE_DRAIN_MEDIUM
	incompatible_modules = list(/obj/item/mod/module/clamp)
	cooldown_time = 0.5 SECONDS
	overlay_state_inactive = "module_clamp"
	overlay_state_active = "module_clamp_on"
	/// Time it takes to load a crate.
	var/load_time = 3 SECONDS
	/// The max amount of crates you can carry.
	var/max_crates = 3
	/// The crates stored in the module.
	var/list/stored_crates = list()

/obj/item/mod/module/clamp/on_select_use(atom/target)
	. = ..()
	if(!.)
		return
	if(!mod.wearer.Adjacent(target))
		return
	if(istype(target, /obj/structure/closet/crate))// || istype(target, /obj/item/delivery/big))
		var/atom/movable/picked_crate = target
		if(!check_crate_pickup(picked_crate))
			return
		playsound(src, 'sound/mecha/hydraulic.ogg', 25, TRUE)
		if(!do_after(mod.wearer, load_time, target = target))
			return
		if(!check_crate_pickup(picked_crate))
			return
		stored_crates += picked_crate
		picked_crate.forceMove(src)
		to_chat(mod.wearer,span_notice("You pick up \the [picked_crate]."))
		drain_power(use_power_cost)
		mod.wearer.update_inv_back()
	else if(length(stored_crates))
		var/turf/target_turf = get_turf(target)
		if(target_turf.is_blocked_turf())
			return
		playsound(src, 'sound/mecha/hydraulic.ogg', 25, TRUE)
		if(!do_after(mod.wearer, load_time, target = target))
			return
		if(target_turf.is_blocked_turf())
			return
		var/atom/movable/dropped_crate = pop(stored_crates)
		dropped_crate.forceMove(target_turf)
		to_chat(mod.wearer,span_notice("You drop \the [dropped_crate]"))
		drain_power(use_power_cost)
		mod.wearer.update_inv_back()
	else
		to_chat(mod.wearer,span_warning("Invalid target!"))

/obj/item/mod/module/clamp/on_suit_deactivation(deleting = FALSE)
	if(deleting)
		return
	for(var/atom/movable/crate as anything in stored_crates)
		crate.forceMove(drop_location())
		stored_crates -= crate

/obj/item/mod/module/clamp/proc/check_crate_pickup(atom/movable/target)
	if(length(stored_crates) >= max_crates)
		to_chat(mod.wearer,span_warning("The suit crate storage is full! Clear out some space!"))
		return FALSE
	for(var/mob/living/mob in target.get_all_contents())
		if(mob.mob_size < MOB_SIZE_HUMAN)
			continue
		to_chat(mod.wearer,span_warning("\The [target] is too heavy!"))
		return FALSE
	return TRUE

/obj/item/mod/module/clamp/loader
	name = "MOD loader hydraulic clamp module"
	icon_state = "clamp_loader"
	complexity = 0
	removable = FALSE
	overlay_state_inactive = null
	overlay_state_active = "module_clamp_loader"
	load_time = 1 SECONDS
	max_crates = 5
	use_mod_colors = TRUE

///Drill - Lets you dig through rock and basalt.
/obj/item/mod/module/drill
	name = "MOD drill module"
	desc = "An integrated drill, typically extending over the user's hand. While useful for drilling through rock, \
		your drill is surely the one that both pierces and creates the heavens."
	icon_state = "drill"
	module_type = MODULE_ACTIVE
	complexity = 2
	use_power_cost = MODULE_CHARGE_DRAIN_MEDIUM
	incompatible_modules = list(/obj/item/mod/module/drill)
	device = /obj/item/pickaxe/drill/mod
	cooldown_time = 0.5 SECONDS
	overlay_state_active = "module_drill"

/obj/item/pickaxe/drill/mod
	name = "MOD Integrated Drill"
	desc = "An integrated drill, complete with self-cleaning bit and part replacements."
	icon = 'icons/obj/clothing/modsuit/mod_modules.dmi'
	toolspeed = 0.3
	icon_state = "drill"

///Ore Bag - Lets you pick up ores and drop them from the suit.
/obj/item/mod/module/orebag
	name = "MOD ore bag module"
	desc = "An integrated ore storage system installed into the suit, \
		this utilizes precise electromagnets and storage compartments to automatically collect and deposit ore. \
		It's recommended by Nakamura Engineering to actually deposit that ore at local refineries."
	icon_state = "ore"
	module_type = MODULE_USABLE
	complexity = 1
	use_power_cost = DEFAULT_CHARGE_DRAIN * 0.2
	incompatible_modules = list(/obj/item/mod/module/orebag)
	cooldown_time = 0.5 SECONDS
	allowed_inactive = TRUE
	/// The ores stored in the bag.
	var/list/ores = list()

/obj/item/mod/module/orebag/on_equip()
	RegisterSignal(mod.wearer, COMSIG_MOVABLE_MOVED, PROC_REF(ore_pickup))

/obj/item/mod/module/orebag/on_unequip()
	UnregisterSignal(mod.wearer, COMSIG_MOVABLE_MOVED)

/obj/item/mod/module/orebag/proc/ore_pickup(atom/movable/source, atom/old_loc, dir, forced)
	SIGNAL_HANDLER

	for(var/obj/item/stack/ore/ore in get_turf(mod.wearer))
		INVOKE_ASYNC(src, PROC_REF(move_ore), ore)
		playsound(src, SFX_RUSTLE, 50, TRUE)

/obj/item/mod/module/orebag/proc/move_ore(obj/item/stack/ore)
	for(var/obj/item/stack/stored_ore as anything in ores)
		if(!ore.can_merge(stored_ore))
			continue
		ore.merge(stored_ore)
		if(QDELETED(ore))
			return
		break
	ore.forceMove(src)
	ores += ore

/obj/item/mod/module/orebag/on_use()
	. = ..()
	if(!.)
		return
	for(var/obj/item/ore as anything in ores)
		ore.forceMove(drop_location())
		ores -= ore
	drain_power(use_power_cost)

/obj/item/mod/module/plasma_engine
	name = "MOD plasma engine module"
	desc = "A minaturized plasma engine, capable of directly intaking raw and refined plasma to recharge the MODsuit's core in the field."
	icon_state = "module"
	module_type = MODULE_TOGGLE
	complexity = 3
	active_power_cost = 0
	incompatible_modules = list(/obj/item/mod/module/plasma_engine)
	cooldown_time = 0.5 SECONDS
	allowed_inactive = TRUE
	var/list/charger_list = list(/obj/item/stack/ore/plasma = 1500, /obj/item/stack/sheet/mineral/plasma = 3000)

/obj/item/mod/module/plasma_engine/on_activation()
	. = ..()
	RegisterSignal(mod, COMSIG_ATOM_ATTACKBY, PROC_REF(on_attackby))
	to_chat(mod.wearer,span_notice("Engine online, insert plasma into core unit."))
	playsound(mod,'sound/mecha/mech_shield_raise.ogg')

/obj/item/mod/module/plasma_engine/on_deactivation(display_message, deleting)
	UnregisterSignal(mod, COMSIG_ATOM_ATTACKBY)
	to_chat(mod.wearer,span_notice("Engine offline."))
	playsound(mod,'sound/mecha/mech_shield_drop.ogg')

	return ..()

/obj/item/mod/module/plasma_engine/proc/on_attackby(datum/source, obj/item/attacking_item, mob/user)
	SIGNAL_HANDLER

	if(charge_plasma(attacking_item, user))
		return COMPONENT_NO_AFTERATTACK
	return NONE

/obj/item/mod/module/plasma_engine/proc/charge_plasma(obj/item/stack/plasma, mob/user)
	var/charge_given = is_type_in_list(plasma, charger_list, zebra = TRUE)
	if(!charge_given)
		return FALSE
	var/uses_needed = min(plasma.amount, ROUND_UP((mod.get_max_charge() - mod.get_charge()) / charge_given))
	if(!plasma.use(uses_needed))
		return FALSE
	mod.add_charge(uses_needed * charge_given)
	to_chat(user,span_notice("You refuel the core."))
	return TRUE

/obj/item/mod/module/disposal_connector
	name = "MOD disposal selector module"
	desc = "A module that connects to the disposal pipeline, causing the user to go into their config selected disposal. \
		Only seems to work when the suit is on."
	icon_state = "disposal"
	complexity = 2
	idle_power_cost = DEFAULT_CHARGE_DRAIN * 0.3
	incompatible_modules = list(/obj/item/mod/module/disposal_connector)
	var/disposal_tag = NONE

/obj/item/mod/module/disposal_connector/Initialize(mapload)
	. = ..()
	disposal_tag = pick(GLOB.TAGGERLOCATIONS)

/obj/item/mod/module/disposal_connector/on_suit_activation()
	RegisterSignal(mod.wearer, COMSIG_MOVABLE_DISPOSING, PROC_REF(disposal_handling))

/obj/item/mod/module/disposal_connector/on_suit_deactivation(deleting = FALSE)
	UnregisterSignal(mod.wearer, COMSIG_MOVABLE_DISPOSING)

/obj/item/mod/module/disposal_connector/get_configuration()
	. = ..()
	.["disposal_tag"] = add_ui_configuration("Disposal Tag", "list", GLOB.TAGGERLOCATIONS[disposal_tag], GLOB.TAGGERLOCATIONS)

/obj/item/mod/module/disposal_connector/configure_edit(key, value)
	switch(key)
		if("disposal_tag")
			for(var/tag in 1 to length(GLOB.TAGGERLOCATIONS))
				if(GLOB.TAGGERLOCATIONS[tag] == value)
					disposal_tag = tag
					break

/obj/item/mod/module/disposal_connector/proc/disposal_handling(datum/disposal_source, obj/structure/disposalholder/disposal_holder, obj/machinery/disposal/disposal_machine, hasmob)
	SIGNAL_HANDLER

	disposal_holder.destinationTag = disposal_tag

/obj/item/mod/module/magnet
	name = "MOD loader hydraulic magnet module"
	desc = "A powerful hydraulic electromagnet able to launch crates and lockers towards the user, and keep 'em attached."
	icon_state = "magnet_loader"
	module_type = MODULE_ACTIVE
	removable = FALSE
	use_power_cost = MODULE_CHARGE_DRAIN_MASSIVE
	incompatible_modules = list(/obj/item/mod/module/magnet)
	cooldown_time = 1.5 SECONDS
	overlay_state_active = "module_magnet"
	use_mod_colors = TRUE

/obj/item/mod/module/magnet/on_select_use(atom/target)
	. = ..()
	if(!.)
		return
	if(istype(mod.wearer.pulling, /obj/structure/closet))
		var/obj/structure/closet/locker = mod.wearer.pulling
		playsound(locker, 'sound/effects/gravhit.ogg', 75, TRUE)
		locker.forceMove(mod.wearer.loc)
		locker.throw_at(target, range = 7, speed = 4, thrower = mod.wearer)
		return
	if(!istype(target, /obj/structure/closet) || !(target in view(mod.wearer)))
		to_chat(mod.wearer,span_warning("Invalid target!"))
		return
	var/obj/structure/closet/locker = target
	if(locker.anchored || locker.move_resist >= MOVE_FORCE_OVERPOWERING)
		to_chat(mod.wearer,span_warning("\The [locker] is anchored to the ground!"))
		return
	new /obj/effect/temp_visual/mook_dust(get_turf(locker))
	playsound(locker, 'sound/effects/gravhit.ogg', 75, TRUE)
	locker.throw_at(mod.wearer, range = 7, speed = 3, force = MOVE_FORCE_WEAK, \
		callback = CALLBACK(src, PROC_REF(check_locker), locker))

/obj/item/mod/module/magnet/on_deactivation(display_message = TRUE, deleting = FALSE)
	. = ..()
	if(!.)
		return
	if(istype(mod.wearer.pulling, /obj/structure/closet))
		mod.wearer.stop_pulling()

/obj/item/mod/module/magnet/proc/check_locker(obj/structure/closet/locker)
	if(!mod?.wearer)
		return
	if(!locker.Adjacent(mod.wearer) || !isturf(locker.loc) || !isturf(mod.wearer.loc))
		return
	mod.wearer.start_pulling(locker)
	//locker.strong_grab = TRUE
	RegisterSignal(locker, COMSIG_ATOM_NO_LONGER_PULLED, PROC_REF(on_stop_pull))

/obj/item/mod/module/magnet/proc/on_stop_pull(obj/structure/closet/locker, atom/movable/last_puller)
	SIGNAL_HANDLER

	//locker.strong_grab = FALSE
	UnregisterSignal(locker, COMSIG_ATOM_NO_LONGER_PULLED)
