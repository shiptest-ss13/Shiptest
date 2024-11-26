/obj/machinery/porta_turret
	name = "turret"
	icon = 'icons/obj/turrets.dmi'
	icon_state = "standard_stun"
	density = TRUE
	desc = "A turret that shoots at its enemies."
	use_power = IDLE_POWER_USE
	idle_power_usage = IDLE_DRAW_LOW
	active_power_usage = ACTIVE_DRAW_HIGH
	req_access = list(ACCESS_SECURITY)
	power_channel = AREA_USAGE_EQUIP
	max_integrity = 200
	integrity_failure = 0.5
	armor = list("melee" = 50, "bullet" = 30, "laser" = 30, "energy" = 30, "bomb" = 30, "bio" = 0, "rad" = 0, "fire" = 90, "acid" = 90)
	base_icon_state = "standard"
	subsystem_type = /datum/controller/subsystem/processing/turrets
	circuit = /obj/item/circuitboard/machine/turret

	/// Scan range of the turret for locating targets
	var/scan_range = 7
	/// List of ALL targets in range, even if they are not visible
	var/list/datum/weakref/targets = list()
	/// The current target of the turret, if any
	var/datum/weakref/current_target_ref

	/// If the turret's behaviour control access is locked
	var/locked = TRUE

	/// In which mode is turret in, stun or lethal
	var/mode = TURRET_STUN

	/// Stun mode projectile type
	var/stun_projectile = /obj/projectile/beam/disabler
	/// Sound of stun projectile
	var/stun_projectile_sound = 'sound/weapons/plasma_cutter.ogg'
	/// Lethal mode projectile type
	var/lethal_projectile = /obj/projectile/beam/laser
	/// Sound of lethal projectile
	var/lethal_projectile_sound = 'sound/weapons/plasma_cutter.ogg'

	/// Power needed per shot
	var/reqpower = 500

	/// If the turret is currently manually controlled
	var/manual_control = FALSE

	/// Ticks until next shot If this needs to go below 5, use SSFastProcess
	var/shot_delay = 1.5 SECONDS
	/// Cooldown until we can shoot again
	COOLDOWN_DECLARE(fire_cooldown)

	var/reaction_time = 5 SECONDS
	COOLDOWN_DECLARE(reaction_cooldown)

	/// Determines if the turret is on
	var/on = TRUE
	/// Turret flags about who is turret allowed to shoot
	var/turret_flags = TURRET_FLAG_SHOOT_CRIMINALS | TURRET_FLAG_SHOOT_ANOMALOUS

	/// Same faction mobs will never be shot at, no matter the other settings
	var/list/faction = list("neutral", "turret")

	/// The spark system, used for generating... sparks?
	var/datum/effect_system/spark_spread/spark_system

	/// The turret will try to shoot from a turf in that direction when in a wall
	var/wall_turret_direction

	/// For connecting to additional turrets
	var/id = ""

	var/datum/beam/target_beam

	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(on_entered),
		COMSIG_ATOM_EXITED = PROC_REF(on_uncrossed),
	)

/obj/machinery/porta_turret/Initialize()
	. = ..()
	update_appearance()
	//Sets up a spark system
	spark_system = new /datum/effect_system/spark_spread
	spark_system.set_up(5, 0, src)
	spark_system.attach(src)

/obj/machinery/porta_turret/Destroy()
	QDEL_NULL(spark_system)
	remove_control()
	return ..()

/obj/machinery/porta_turret/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/connect_range, src, loc_connections, scan_range, TRUE)

/obj/machinery/porta_turret/proc/on_entered(atom/old_loc, atom/movable/new_target)
	var/static/list/typecache_of_targets = typecacheof(list(
		/mob/living/carbon,
		/mob/living/silicon,
		/mob/living/simple_animal,
		/obj/mecha,
	))

	if(is_type_in_typecache(new_target, typecache_of_targets))
		targets |= WEAKREF(new_target)

/obj/machinery/porta_turret/proc/on_uncrossed(atom/old_loc, atom/movable/target)
	targets -= WEAKREF(target)

/obj/machinery/porta_turret/RefreshParts()
	var/obj/item/gun/turret_gun = locate() in component_parts

	if(!turret_gun)
		return

	var/list/gun_properties = turret_gun.get_turret_properties()

	//required properties
	stun_projectile = gun_properties["stun_projectile"]
	stun_projectile_sound = gun_properties["stun_projectile_sound"]
	lethal_projectile = gun_properties["lethal_projectile"]
	lethal_projectile_sound = gun_properties["lethal_projectile_sound"]
	base_icon_state = gun_properties["base_icon_state"]

	//optional properties
	if(gun_properties["shot_delay"])
		shot_delay = gun_properties["shot_delay"]
	if(gun_properties["reqpower"])
		reqpower = gun_properties["reqpower"]

	update_appearance(UPDATE_ICON_STATE)
	return gun_properties

/obj/machinery/porta_turret/connect_to_shuttle(obj/docking_port/mobile/port, obj/docking_port/stationary/dock)
	id = "[text_ref(port)][initial(id)]"
	port.turret_list |= WEAKREF(src)

/obj/machinery/porta_turret/disconnect_from_shuttle(obj/docking_port/mobile/port)
	id = initial(id)
	port.turret_list -= WEAKREF(src)

/obj/machinery/porta_turret/proc/toggle_on(set_to)
	var/current = on
	if (!isnull(set_to))
		on = set_to
	else
		on = !on
	if (current != on)
		check_should_process()

/obj/machinery/porta_turret/proc/check_should_process()
	var/functional = (on && anchored && !(machine_stat & BROKEN) && powered())
	var/processing = (datum_flags & DF_ISPROCESSING)

	if(processing && !functional)
		end_processing()

		var/datum/component/connect_range/prox = GetComponent(/datum/component/connect_range)
		prox?.set_tracked(null)
	else if(!processing && functional)
		begin_processing()

		var/datum/component/connect_range/prox = GetComponent(/datum/component/connect_range)
		prox?.set_tracked(src)

/obj/machinery/porta_turret/update_icon_state()
	if(machine_stat & BROKEN)
		icon_state = "[base_icon_state]_broken"
		return ..()
	if(!powered())
		icon_state = "[base_icon_state]_unpowered"
		return ..()
	if(!on)
		icon_state = "[base_icon_state]_off"
		return ..()
	switch(mode)
		if(TURRET_STUN)
			icon_state = "[base_icon_state]_stun"
		if(TURRET_LETHAL)
			icon_state = "[base_icon_state]_lethal"
	return ..()

/obj/machinery/porta_turret/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "PortableTurret", name)
		ui.open()

/obj/machinery/porta_turret/ui_data(mob/user)
	var/list/data = list(
		"locked" = locked,
		"on" = on,
		"check_weapons" = turret_flags & TURRET_FLAG_AUTH_WEAPONS,
		"neutralize_criminals" = turret_flags & TURRET_FLAG_SHOOT_CRIMINALS,
		"neutralize_all" = turret_flags & TURRET_FLAG_SHOOT_ALL,
		"neutralize_unidentified" = turret_flags & TURRET_FLAG_SHOOT_ANOMALOUS,
		"neutralize_nonmindshielded" = turret_flags & TURRET_FLAG_SHOOT_UNSHIELDED,
		"neutralize_cyborgs" = turret_flags & TURRET_FLAG_SHOOT_BORGS,
		"ignore_heads" = turret_flags & TURRET_FLAG_SHOOT_HEADS,
		"manual_control" = manual_control,
		"silicon_user" = FALSE,
		"allow_manual_control" = FALSE,
	)
	if(issilicon(user))
		data["silicon_user"] = TRUE
		if(!manual_control)
			var/mob/living/silicon/S = user
			if(S.hack_software)
				data["allow_manual_control"] = TRUE
	return data

/obj/machinery/porta_turret/ui_act(action, list/params)
	. = ..()
	if(.)
		return

	switch(action)
		if("power")
			if(anchored)
				toggle_on()
				return TRUE
			else
				to_chat(usr, "<span class='warning'>It has to be secured first!</span>")
		if("authweapon")
			turret_flags ^= TURRET_FLAG_AUTH_WEAPONS
			return TRUE
		if("shootcriminals")
			turret_flags ^= TURRET_FLAG_SHOOT_CRIMINALS
			return TRUE
		if("shootall")
			turret_flags ^= TURRET_FLAG_SHOOT_ALL
			return TRUE
		if("checkxenos")
			turret_flags ^= TURRET_FLAG_SHOOT_ANOMALOUS
			return TRUE
		if("checkloyal")
			turret_flags ^= TURRET_FLAG_SHOOT_UNSHIELDED
			return TRUE
		if("shootborgs")
			turret_flags ^= TURRET_FLAG_SHOOT_BORGS
			return TRUE
		if("shootheads")
			turret_flags ^= TURRET_FLAG_SHOOT_HEADS
			return TRUE
		if("manual")
			if(!issilicon(usr))
				return
			var/mob/living/silicon/user = usr
			if(!user.hack_software)
				return
			give_control(usr)
			return TRUE

/obj/machinery/porta_turret/power_change()
	. = ..()
	if(!anchored || (machine_stat & BROKEN) || !powered())
		update_appearance(UPDATE_ICON_STATE)
		remove_control()
	check_should_process()

/obj/machinery/porta_turret/attackby(obj/item/I, mob/user, params)
	if(machine_stat & BROKEN && I.tool_behaviour == TOOL_CROWBAR)
		//If the turret is destroyed, you can remove it with a crowbar to
		//try and salvage its components
		to_chat(user, "<span class='notice'>You begin prying the metal coverings off...</span>")
		if(I.use_tool(src, user, 20))
			if(prob(70))
				var/obj/item/gun/stored_gun = locate() in component_parts
				if(stored_gun)
					stored_gun.forceMove(loc)
				to_chat(user, "<span class='notice'>You remove the turret and salvage some components.</span>")
				if(prob(50))
					new /obj/item/stack/sheet/metal(loc, rand(1,4))
				if(prob(50))
					new /obj/item/assembly/prox_sensor(loc)
			else
				to_chat(user, "<span class='notice'>You remove the turret but did not manage to salvage anything.</span>")
			qdel(src)
		return

	if(I.tool_behaviour == TOOL_WELDER && user.a_intent == INTENT_HELP)
		if(obj_integrity >= max_integrity)
			to_chat(user, "<span class='warning'>[src] is already in good condition!</span>")
			return

		if(!I.tool_start_check(user, amount=0))
			return

		to_chat(user, "<span class='notice'>You begin repairing [src]...</span>")
		if(I.use_tool(src, user, 40, volume=50))
			obj_integrity = max(obj_integrity + 20, max_integrity)
			to_chat(user, "<span class='notice'>You repair [src].</span>")

			if(obj_integrity > (max_integrity * integrity_failure) && (machine_stat & BROKEN))
				obj_integrity = max_integrity
				set_machine_stat(machine_stat & ~BROKEN)
				update_appearance(UPDATE_ICON_STATE)
				check_should_process()

		return


	if((I.tool_behaviour == TOOL_WRENCH) && !on)
		//This code handles moving the turret around. After all, it's a portable turret!
		if(!anchored && !isinspace())
			set_anchored(TRUE)
			update_appearance(UPDATE_ICON_STATE)
			to_chat(user, "<span class='notice'>You secure the exterior bolts on the turret.</span>")
		else if(anchored)
			set_anchored(FALSE)
			to_chat(user, "<span class='notice'>You unsecure the exterior bolts on the turret.</span>")
			power_change()
		return

	if(I.tool_behaviour == TOOL_MULTITOOL && !locked)
		if(!multitool_check_buffer(user, I))
			return
		var/obj/item/multitool/M = I
		M.buffer = src
		to_chat(user, "<span class='notice'>You add [src] to multitool buffer.</span>")
		return

	if(istype(I, /obj/item/card/id))
		//Behavior lock/unlock mangement
		if(allowed(user))
			locked = !locked
			to_chat(user, "<span wclass='notice'>Controls are now [locked ? "locked" : "unlocked"].</span>")
		else
			to_chat(user, "<span class='alert'>Access denied.</span>")
		return

	return ..()

/obj/machinery/porta_turret/emag_act(mob/user)
	if(obj_flags & EMAGGED)
		return
	to_chat(user, "<span class='warning'>You short out [src]'s threat assessment circuits.</span>")
	audible_message("<span class='hear'>[src] hums oddly...</span>")
	obj_flags |= EMAGGED
	locked = TRUE
	toggle_on(FALSE) //turns off the turret temporarily
	update_appearance(UPDATE_ICON_STATE)
	//6 seconds for the traitor to gtfo of the area before the turret decides to ruin his shit
	addtimer(CALLBACK(src, PROC_REF(toggle_on), TRUE), 6 SECONDS)

/obj/machinery/porta_turret/emp_act(severity)
	. = ..()
	if (. & EMP_PROTECT_SELF)
		return
	if(on)
		//if the turret is on, the EMP no matter how severe disables the turret for a while
		//and scrambles its settings, with a slight chance of having an emag effect
		if(prob(10))
			turret_flags |= TURRET_FLAG_SHOOT_CRIMINALS
		if(prob(10))
			turret_flags |= TURRET_FLAG_AUTH_WEAPONS
		if(prob(1))
			turret_flags |= TURRET_FLAG_SHOOT_ALL // Shooting everyone is a pretty big deal, so it's least likely to get turned on

		toggle_on(FALSE)
		remove_control()

		addtimer(CALLBACK(src, PROC_REF(toggle_on), TRUE), rand(6 SECONDS, 60 SECONDS))

/obj/machinery/porta_turret/take_damage(damage, damage_type = BRUTE, damage_flag = 0, sound_effect = 1)
	. = ..()
	if(!. || obj_integrity <= 0)
		return
	//damage received
	if(prob(30))
		spark_system.start()
	if(on && !(turret_flags & TURRET_FLAG_SHOOT_ALL_REACT) && !(obj_flags & EMAGGED))
		turret_flags |= TURRET_FLAG_SHOOT_ALL_REACT
		addtimer(CALLBACK(src, PROC_REF(reset_attacked)), 60)

/obj/machinery/porta_turret/proc/reset_attacked()
	turret_flags &= ~TURRET_FLAG_SHOOT_ALL_REACT

/obj/machinery/porta_turret/obj_break(damage_flag)
	. = ..()
	if(.)
		power_change()
		spark_system.start()	//creates some sparks because they look cool

/obj/machinery/porta_turret/process()
	if(!on || (machine_stat & (NOPOWER|BROKEN)) || manual_control)
		return PROCESS_KILL

	if(!COOLDOWN_FINISHED(src, fire_cooldown))
		return

	if(current_target_ref)
		var/mob/current_target = current_target_ref?.resolve()
		if(current_target && check_target(current_target, current_target) && target(current_target))
			return

		current_target_ref = null
		if(target_beam)
			qdel(target_beam)

	for(var/datum/weakref/ref as anything in targets)
		var/atom/movable/target = ref.resolve()
		if(isnull(target))
			targets -= ref
			stack_trace("Invalid target in turret list")
			return FALSE

		if(check_target(target, ref))
			break

/obj/machinery/porta_turret/proc/check_target(atom/movable/target, datum/weakref/ref)
	// mecha|carbon|silicon|simple_animal
	if(ismecha(target))
		var/obj/mecha/mech = target
		if(!mech.occupant)
			targets -= ref
			return FALSE
		target = mech.occupant

	// We know the target must be a mob now
	var/mob/target_mob = target

	if(target_mob.stat == DEAD)
		//They probably won't need to be re-checked
		targets -= ref
		return FALSE

	if(faction_check(src.faction, target_mob.faction))
		return FALSE

	if(iscyborg(target_mob))
		return (turret_flags & TURRET_FLAG_SHOOT_BORGS) && target(target_mob)

	if(isanimal(target_mob))
		return (turret_flags & TURRET_FLAG_SHOOT_ANOMALOUS) && target(target_mob)

	//We know the target must be a carbon now
	var/mob/living/carbon/target_carbon = target_mob

	//Nonhuman carbons, e.g. monkeys, xenos, etc.
	if(!ishuman(target_carbon))
		return (turret_flags & TURRET_FLAG_SHOOT_ANOMALOUS) && target(target_carbon)

	//If not set to lethal, only target carbons that can use items
	if(mode != TURRET_LETHAL && (target_carbon.handcuffed || !(target_carbon.mobility_flags & MOBILITY_USE)))
		return FALSE

	return assess_perp(target_carbon) >= 4 && target(target_carbon)

/obj/machinery/porta_turret/proc/assess_perp(mob/living/carbon/human/perp)
	var/threatcount = 0	//the integer returned

	if(obj_flags & EMAGGED)
		return 10	//if emagged, always return 10.

	if((turret_flags & (TURRET_FLAG_SHOOT_ALL | TURRET_FLAG_SHOOT_ALL_REACT)) && !allowed(perp))
		//if the turret has been attacked or is angry, target all non-sec people
		return 10

	if(turret_flags & TURRET_FLAG_AUTH_WEAPONS)	//check for weapon authorization
		if(isnull(perp.wear_id) || istype(perp.wear_id.GetID(), /obj/item/card/id/syndicate))

			if(allowed(perp)) //if the perp has security access, return 0
				return 0
			if(perp.is_holding_item_of_type(/obj/item/gun) ||  perp.is_holding_item_of_type(/obj/item/melee/baton))
				threatcount += 4

			if(istype(perp.belt, /obj/item/gun) || istype(perp.belt, /obj/item/melee/baton))
				threatcount += 2

	if(turret_flags & TURRET_FLAG_SHOOT_CRIMINALS)	//if the turret can check the records, check if they are set to *Arrest* on records
		var/perpname = perp.get_face_name(perp.get_id_name())
		var/datum/data/record/R = find_record("name", perpname, GLOB.data_core.security)
		if(!R || (R.fields["criminal"] == "*Arrest*"))
			threatcount += 4

	if((turret_flags & TURRET_FLAG_SHOOT_UNSHIELDED) && (!HAS_TRAIT(perp, TRAIT_MINDSHIELD)))
		threatcount += 4

	// If we aren't shooting heads then return a threatcount of 0
	if (!(turret_flags & TURRET_FLAG_SHOOT_HEADS) && (perp.get_assignment() in GLOB.command_positions))
		return 0

	return threatcount

//Returns whether or not we should stop searching for targets
/obj/machinery/porta_turret/proc/target(mob/living/target)
	if(!COOLDOWN_FINISHED(src, fire_cooldown))
		return TRUE
	COOLDOWN_START(src, fire_cooldown, shot_delay)

	var/turf/our_turf = get_turf(src)
	if(!istype(our_turf))
		return TRUE

	setDir(get_dir(our_turf, target))

	//Wall turrets will try to find adjacent empty turf to shoot from to cover full arc
	if(our_turf.density)
		if(wall_turret_direction)
			var/turf/closer = get_step(our_turf, wall_turret_direction)
			if(istype(closer) && !closer.is_blocked_turf() && our_turf.Adjacent(closer))
				our_turf = closer
		else
			var/target_dir = get_dir(our_turf, target)
			for(var/d in list(0, -45, 45))
				var/turf/closer = get_step(our_turf, turn(target_dir, d))
				if(istype(closer) && !closer.is_blocked_turf() && our_turf.Adjacent(closer))
					our_turf = closer
					break

	if(!can_see(our_turf, target, scan_range))
		return FALSE

	if(current_target_ref?.resolve() != target)
		//We have a new target, so we need to update the reference
		current_target_ref = WEAKREF(target)
		COOLDOWN_START(src, reaction_cooldown, reaction_time)

		target_beam = Beam(target, icon_state="1-full", beam_color=COLOR_RED, maxdistance=scan_range, time=reaction_time)

		target.do_alert_animation(src)

		return TRUE

	update_appearance(UPDATE_ICON_STATE)
	var/obj/projectile/shot
	//any lethaling turrets drain 2x power and use a different projectile
	if(mode == TURRET_STUN)
		use_power(reqpower)
		shot = new stun_projectile(our_turf)
		playsound(loc, stun_projectile_sound, 75, TRUE)
	else
		use_power(reqpower * 2)
		shot = new lethal_projectile(our_turf)
		playsound(loc, lethal_projectile_sound, 75, TRUE)

	//Focus on them, since we seem to be able to hit them
	current_target_ref = WEAKREF(target)

	//Shooting Code:
	shot.preparePixelProjectile(target, our_turf)
	shot.firer = src
	shot.fired_from = src
	shot.fire()
	return TRUE

/obj/machinery/porta_turret/proc/setState(on, mode, shoot_cyborgs)
	if(locked)
		return

	shoot_cyborgs ? (turret_flags |= TURRET_FLAG_SHOOT_BORGS) : (turret_flags &= ~TURRET_FLAG_SHOOT_BORGS)
	toggle_on(on)
	src.mode = mode
	power_change()

/obj/item/gun/proc/get_turret_properties()
	. = list()
	.["lethal_projectile"] = null
	.["lethal_projectile_sound"] = null
	.["stun_projectile"] = null
	.["stun_projectile_sound"] = null
	.["base_icon_state"] = "standard"

/obj/item/gun/energy/get_turret_properties()
	. = ..()

	var/obj/item/ammo_casing/primary_ammo = ammo_type[1]

	.["stun_projectile"] = initial(primary_ammo.projectile_type)
	.["stun_projectile_sound"] = initial(primary_ammo.fire_sound)

	if(ammo_type.len > 1)
		var/obj/item/ammo_casing/secondary_ammo = ammo_type[2]
		.["lethal_projectile"] = initial(secondary_ammo.projectile_type)
		.["lethal_projectile_sound"] = initial(secondary_ammo.fire_sound)
	else
		.["lethal_projectile"] = .["stun_projectile"]
		.["lethal_projectile_sound"] = .["stun_projectile_sound"]

/obj/item/gun/ballistic/get_turret_properties()
	. = ..()
	var/obj/item/ammo_box/mag = default_ammo_type
	var/obj/item/ammo_casing/primary_ammo = initial(mag.ammo_type)

	.["base_icon_state"] = "syndie"
	.["stun_projectile"] = initial(primary_ammo.projectile_type)
	.["stun_projectile_sound"] = initial(primary_ammo.fire_sound)
	.["lethal_projectile"] = .["stun_projectile"]
	.["lethal_projectile_sound"] = .["stun_projectile_sound"]
