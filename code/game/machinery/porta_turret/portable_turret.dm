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
	var/list/mob/living/targets = list()
	/// The current target of the turret, if any
	var/mob/living/current_target

	/// The beam showing which target we're acquiring
	var/datum/simple_beam/target_beam

	/// If the turret's behaviour control access is locked
	var/locked = TRUE

	/// In which mode is turret in, stun or lethal
	var/lethal = FALSE

	/// Stun mode projectile type
	var/stun_projectile = /obj/projectile/beam/disabler
	/// Sound of stun projectile
	var/stun_projectile_sound = 'sound/weapons/melee/plasmacutter/plasma_cutter.ogg'
	/// Lethal mode projectile type
	var/lethal_projectile = /obj/projectile/beam/laser
	/// Sound of lethal projectile
	var/lethal_projectile_sound = 'sound/weapons/melee/plasmacutter/plasma_cutter.ogg'

	/// Power needed per shot
	var/reqpower = 500

	/// If the turret is currently manually controlled
	var/manual_control = FALSE

	/// Ticks until next shot/burst If this needs to go below 5, use SSFastProcess
	var/shot_delay = 1.5 SECONDS

	/// How many shots a turret fires in one "burst"
	var/burst_size = 1

	/// time between shots in a burst.
	var/burst_delay = 5

	/// turret spread.
	var/spread = 5

	/// Cooldown until we can shoot again
	COOLDOWN_DECLARE(fire_cooldown)

	/// Reaction time of the turret, how long it takes after acquiring a target to begin firing
	var/reaction_time
	/// Cooldown until we can start firing
	COOLDOWN_DECLARE(reaction_cooldown)

	/// Determines if the turret is on
	var/on = TRUE
	/// Turret flags about who is turret allowed to shoot
	var/turret_flags = TURRET_FLAG_DEFAULT

	/// If the turret is currently retaliating. Turrets will ignore all other settings to shoot at the attacker until they're dead or out of range //this. does not work. right now.
	var/retaliating = FALSE

	/// Factions accounted for by IFF settings
	var/list/faction = list("neutral", FACTION_TURRET)

	/// does our turret give a flying fuck about what accesses someone has?
	var/turret_respects_id = TRUE

	/// The spark system, used for generating... sparks?
	var/datum/effect_system/spark_spread/spark_system

	/// The turret will try to shoot from a turf in that direction when in a wall
	var/wall_turret_direction

	/// For connecting to additional turrets
	var/id = ""

	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(on_entered),
		COMSIG_ATOM_EXITED = PROC_REF(on_uncrossed),
	)

/obj/machinery/porta_turret/Initialize()
	. = ..()
	if(!reaction_time)
		reaction_time = shot_delay

	target_beam = new(src, null, 'icons/effects/beam.dmi', "1-full", COLOR_RED, 127)
	update_appearance()
	//Sets up a spark system
	spark_system = new /datum/effect_system/spark_spread
	spark_system.set_up(5, 0, src)
	spark_system.attach(src)

/obj/machinery/porta_turret/Destroy()
	targets.Cut()
	targets = null

	set_target(null)

	QDEL_NULL(spark_system)
	QDEL_NULL(target_beam)
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
		/mob/living/basic,
		/obj/mecha,
	))

	if(is_type_in_typecache(new_target, typecache_of_targets))
		targets |= new_target

/obj/machinery/porta_turret/proc/on_uncrossed(atom/old_loc, atom/movable/target)
	//Should also get any deleted targets, since they're moved to nullspace
	targets -= target

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
	id = "[text_ref(port)][id]"
	port.turret_list |= WEAKREF(src)

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
		set_target(null)

	else if(!processing && functional)
		begin_processing()

		var/datum/component/connect_range/prox = GetComponent(/datum/component/connect_range)
		prox?.set_tracked(src)

/obj/machinery/porta_turret/update_icon_state()
	if(machine_stat & BROKEN)
		icon_state = "[base_icon_state]_broken"
		return ..()
	if(!on || !powered())
		icon_state = "[base_icon_state]_off"
		return ..()
	if(lethal)
		icon_state = "[base_icon_state]_lethal"
	else
		icon_state = "[base_icon_state]_stun"
	return ..()

/obj/machinery/porta_turret/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "TurretControl", name)
		ui.open()

/obj/machinery/porta_turret/ui_data(mob/user)
	var/allow_manual_control = FALSE
	if(issilicon(user))
		var/mob/living/silicon/silicon_user = user
		allow_manual_control = silicon_user.hack_software

	return list(
		"locked" = locked,
		"enabled" = on,
		"lethal" = lethal,
		"siliconUser" = user.has_unlimited_silicon_privilege && check_ship_ai_access(user),
		"manual_control" = manual_control,
		"dangerous_only" = turret_flags & TURRET_FLAG_SHOOT_DANGEROUS_ONLY,
		"retaliate" = turret_flags & TURRET_FLAG_SHOOT_RETALIATE,
		"shoot_fauna" = turret_flags & TURRET_FLAG_SHOOT_FAUNA,
		"shoot_humans" = turret_flags & TURRET_FLAG_SHOOT_HUMANS,
		"shoot_silicons" = turret_flags & TURRET_FLAG_SHOOT_SILICONS,
		"only_nonfaction" = turret_flags & TURRET_FLAG_SHOOT_NONFACTION,
		"only_specificfaction" = turret_flags & TURRET_FLAG_SHOOT_SPECIFIC_FACTION,
		"allow_manual_control" = allow_manual_control,
	)

/obj/machinery/porta_turret/ui_act(action, list/params)
	. = ..()
	if(.)
		return

	if(locked)
		to_chat(usr, span_warning("[src]'s controls are locked."))
		return

	switch(action)
		if("lock")
			if(!usr.has_unlimited_silicon_privilege)
				return
			toggle_lock(usr)
			return TRUE
		if("power")
			if(anchored)
				toggle_on()
				return TRUE
			else
				to_chat(usr, span_warning("It has to be secured first!"))
		if("manual")
			if(!issilicon(usr))
				return
			var/mob/living/silicon/user = usr
			if(!user.hack_software)
				return
			give_control(usr)
			return TRUE
		if("mode")
			lethal = !lethal
			return TRUE

		if("toggle_dangerous")
			turret_flags ^= TURRET_FLAG_SHOOT_DANGEROUS_ONLY
			return TRUE
		if("toggle_retaliate")
			turret_flags ^= TURRET_FLAG_SHOOT_RETALIATE
			return TRUE

		if("toggle_fauna")
			turret_flags ^= TURRET_FLAG_SHOOT_FAUNA
			return TRUE
		if("toggle_humans")
			turret_flags ^= TURRET_FLAG_SHOOT_HUMANS
			return TRUE
		if("toggle_silicons")
			turret_flags ^= TURRET_FLAG_SHOOT_SILICONS
			return TRUE

		if("toggle_nonfaction")
			turret_flags ^= TURRET_FLAG_SHOOT_NONFACTION
			return TRUE
		if("toggle_specificfaction")
			turret_flags ^= TURRET_FLAG_SHOOT_SPECIFIC_FACTION
			return TRUE

/obj/machinery/porta_turret/power_change()
	. = ..()
	if(!(flags_1 & INITIALIZED_1))
		return
	if(!anchored || (machine_stat & BROKEN) || !powered())
		update_appearance(UPDATE_ICON_STATE)
		remove_control()
		set_target(null)
	check_should_process()

/obj/machinery/porta_turret/attackby(obj/item/I, mob/user, params)
	if(machine_stat & BROKEN && I.tool_behaviour == TOOL_CROWBAR)
		//If the turret is destroyed, you can remove it with a crowbar to
		//try and salvage its components
		to_chat(user, span_notice("You begin prying the metal coverings off..."))
		if(I.use_tool(src, user, 20))
			if(prob(70))
				var/obj/item/gun/stored_gun = locate() in component_parts
				if(stored_gun)
					stored_gun.forceMove(loc)
				to_chat(user, span_notice("You remove the turret and salvage some components."))
				if(prob(50))
					new /obj/item/stack/sheet/metal(loc, rand(1,4))
				if(prob(50))
					new /obj/item/assembly/prox_sensor(loc)
			else
				to_chat(user, span_notice("You remove the turret but did not manage to salvage anything."))
			qdel(src)
		return

	if(I.tool_behaviour == TOOL_WELDER && user.a_intent == INTENT_HELP)
		if(atom_integrity >= max_integrity)
			to_chat(user, span_warning("[src] is already in good condition!"))
			return

		to_chat(user, span_notice("You begin repairing [src]..."))
		while(atom_integrity < max_integrity)
			if(!I.use_tool(src, user, 4 SECONDS, 2, 50))
				break
			atom_integrity = max(atom_integrity + 20, max_integrity)
			to_chat(user, span_notice("You repair [src]."))

			if(atom_integrity > (max_integrity * integrity_failure) && (machine_stat & BROKEN))
				atom_integrity = max_integrity
				set_machine_stat(machine_stat & ~BROKEN)
				update_appearance(UPDATE_ICON_STATE)
				check_should_process()

		return


	if((I.tool_behaviour == TOOL_WRENCH) && !on)
		//This code handles moving the turret around. After all, it's a portable turret!
		if(!anchored && !isinspace())
			set_anchored(TRUE)
			update_appearance(UPDATE_ICON_STATE)
			to_chat(user, span_notice("You secure the exterior bolts on the turret."))
		else if(anchored)
			set_anchored(FALSE)
			to_chat(user, span_notice("You unsecure the exterior bolts on the turret."))
			power_change()
		return

	if(I.tool_behaviour == TOOL_MULTITOOL)
		if(locked)
			to_chat(user, span_warning("The controls are locked."))
			return
		if(!multitool_check_buffer(user, I))
			return
		var/obj/item/multitool/m_tool = I
		if(istype(m_tool.buffer, /obj/machinery/turretid))
			var/obj/machinery/turretid/turret_controls = m_tool.buffer
			turret_controls.turret_refs |= WEAKREF(src)
			to_chat(user, span_notice("You link \the [src] with \the [turret_controls]."))
			return

	if(istype(I, /obj/item/card/id))
		toggle_lock(user)
		return

	return ..()

/obj/machinery/porta_turret/AltClick(mob/user)
	. = ..()
	toggle_lock(user)

/obj/machinery/porta_turret/proc/toggle_lock(mob/user)
	if(!user.canUseTopic(src, !issilicon(user)))
		return
	if(!allowed(user))
		to_chat(user, span_alert("Access denied."))
		return
	if(obj_flags & EMAGGED || (machine_stat & (BROKEN|MAINT)))
		to_chat(user, span_warning("The turret is unresponsive!"))
		return

	to_chat(user, span_notice("You [locked ? "unlock" : "lock"] [src]."))
	locked = !locked
	update_appearance()

/obj/machinery/porta_turret/emag_act(mob/user)
	if(obj_flags & EMAGGED)
		return
	to_chat(user, span_warning("You short out [src]'s threat assessment circuits."))
	audible_message(span_hear("[src] hums oddly..."))
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
		if(prob(5))
			turret_flags ^= TURRET_FLAG_SHOOT_HUMANS
		if(prob(5))
			turret_flags ^= TURRET_FLAG_SHOOT_FAUNA
		if(prob(1))
			turret_flags ^= TURRET_FLAG_SHOOT_NONFACTION
		if(prob(1))
			turret_flags ^= TURRET_FLAG_SHOOT_SPECIFIC_FACTION

		toggle_on(FALSE)
		remove_control()

		addtimer(CALLBACK(src, PROC_REF(toggle_on), TRUE), rand(6 SECONDS, 60 SECONDS))

/obj/machinery/porta_turret/take_damage(damage, damage_type = BRUTE, damage_flag = 0, sound_effect = 1)
	. = ..()
	if(!. || atom_integrity <= 0)
		return
	//damage received
	if(prob(30))
		spark_system.start()

/obj/machinery/porta_turret/proc/retaliate(mob/living/target)
	if(!(turret_flags & TURRET_FLAG_SHOOT_RETALIATE) || current_target || !on || (req_ship_access && allowed(target)) || (machine_stat & BROKEN|NOPOWER|MAINT))
		return

	set_target(target)
	target(target)
	retaliating = TRUE

/obj/machinery/porta_turret/bullet_act(obj/projectile/hitting_projectile)
	. = ..()
	if(ismob(hitting_projectile.firer))
		retaliate(hitting_projectile.firer)

/obj/machinery/porta_turret/attacked_by(obj/item/I, mob/living/user)
	. = ..()
	if(!I.force || I.damtype == STAMINA)
		return
	retaliate(user)

/obj/machinery/porta_turret/atom_break(damage_flag)
	. = ..()
	if(.)
		power_change()
		spark_system.start()	//creates some sparks because they look cool

/obj/machinery/porta_turret/process(seconds_per_tick)
	if(!on || (machine_stat & (NOPOWER|BROKEN)) || manual_control)
		return PROCESS_KILL

	if(!COOLDOWN_FINISHED(src, fire_cooldown))
		return

	if(current_target)
		//Try to fire at the current target first
		if(check_target(current_target) && target(current_target))
			return

		//Current target is invalid, so we need to find a new one
		set_target(null)

	for(var/atom/movable/target as anything in targets)
		//TODO: Remove this if it never happens, because it shouldn't
		if(QDELETED(target))
			targets -= target
			stack_trace("Qdeleted target in turret list")
			return FALSE

		if(isnull(target))
			targets -= target
			stack_trace("Null target in turret list")
			continue

		if(check_target(target))
			break

/obj/machinery/porta_turret/proc/check_target(atom/movable/target, check_flags = turret_flags)
	// mecha|carbon|silicon|simple_animal
	if(ismecha(target))
		var/obj/mecha/mech = target
		if(!mech.occupant)
			targets -= target
			return FALSE
		target = mech.occupant

	// We know the target must be a mob now
	var/mob/target_mob = target

	if(target_mob.stat == DEAD)
		//They probably won't need to be re-checked
		targets -= target
		return FALSE

	if((check_flags & TURRET_FLAG_SHOOT_NONFACTION) && faction_check(src.faction, target_mob.faction)) //contrary to what these say they do they actually exclude targets rather than include them
		return FALSE

	if((check_flags & TURRET_FLAG_SHOOT_SPECIFIC_FACTION) && !faction_check(src.faction, target_mob.faction)) //in case you ever wanted to only have a turret shoot 1 faction. or turn it on its masters (ship turrets have undying loyalty their crew)
		return FALSE

	if(iscyborg(target_mob))
		return (check_flags & TURRET_FLAG_SHOOT_SILICONS) && target(target_mob)

	if(!ishuman(target_mob))
		if(!(check_flags & TURRET_FLAG_SHOOT_FAUNA))
			return FALSE

		if(!(check_flags & TURRET_FLAG_SHOOT_DANGEROUS_ONLY))
			return target(target_mob)

		//this is still a bit gross, but less gross than before
		var/static/list/dangerous_fauna = typecacheof(list(/mob/living/simple_animal/hostile, /mob/living/basic, /mob/living/carbon/alien, /mob/living/carbon/monkey))
		if(!is_type_in_typecache(target_mob, dangerous_fauna) || faction_check(list("neutral"), target_mob.faction))
			return FALSE

		if(istype(target_mob, /mob/living/simple_animal/hostile/retaliate))
			var/mob/living/simple_animal/hostile/retaliate/target_animal = target_mob
			return length(target_animal.enemies) && target(target_mob)

		return target(target_mob)

	//We know the target must be a human now
	if(!(check_flags & TURRET_FLAG_SHOOT_HUMANS))
		return FALSE

	var/mob/living/carbon/human/target_carbon = target_mob

	if(turret_respects_id)
		if(req_ship_access && (check_access(target_carbon.get_active_held_item()) || check_access(target_carbon.wear_id)))
			return FALSE

	if(!(check_flags & TURRET_FLAG_SHOOT_DANGEROUS_ONLY))
		return target(target_carbon)

	//Not dangerous if you can't hold anything
	if(target_carbon.handcuffed || !(target_carbon.mobility_flags & MOBILITY_USE))
		return FALSE

	if(target_carbon.stat != CONSCIOUS)
		return FALSE

	if(target_carbon.is_holding_item_of_type(/obj/item/gun) || target_carbon.is_holding_item_of_type(/obj/item/melee))
		return target(target_carbon)

/obj/machinery/porta_turret/proc/in_faction(mob/target)
	for(var/faction1 in faction)
		if(faction1 in target.faction)
			return TRUE
	return FALSE

//Returns whether or not we should stop searching for targets
/obj/machinery/porta_turret/proc/target(mob/living/target)
	if(!COOLDOWN_FINISHED(src, fire_cooldown))
		return TRUE

	var/turf/our_turf = get_turf(src)
	if(!istype(our_turf))
		return TRUE

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

	setDir(get_dir(our_turf, target))

	if(!manual_control)
		if(current_target != target)
			set_target(target)
			COOLDOWN_START(src, reaction_cooldown, reaction_time)

			if(ishuman(target) || target.client)
				target.do_alert_animation()

			return TRUE

		if(!COOLDOWN_FINISHED(src, reaction_cooldown))
			return TRUE

	target_beam.set_target(null)
	COOLDOWN_START(src, fire_cooldown, shot_delay)

	update_appearance(UPDATE_ICON_STATE)

	//Shooting Code:
	var/turf/target_turf = get_turf(target)
	for(var/i = 1 to burst_size)
		addtimer(CALLBACK(src, PROC_REF(turret_fire), our_turf, target_turf), burst_delay * (i - 1))

	return TRUE

/obj/machinery/porta_turret/proc/turret_fire(our_turf, target_turf)
	var/obj/projectile/shot
	//any lethaling turrets drain 2x the power and use a different projectile
	if(lethal)
		use_power(reqpower * 2)
		shot = new lethal_projectile(our_turf)
		playsound(loc, lethal_projectile_sound, 75, TRUE)
	else
		use_power(reqpower)
		shot = new stun_projectile(our_turf)
		playsound(loc, stun_projectile_sound, 75, TRUE)
	shot.spread = spread
	shot.preparePixelProjectile(target_turf, our_turf)
	shot.firer = src
	shot.fired_from = src
	shot.fire()

/obj/machinery/porta_turret/proc/set_target(atom/movable/target = null)
	if(current_target)
		UnregisterSignal(current_target, COMSIG_QDELETING)

	retaliating = FALSE
	current_target = target
	target_beam.set_target(target)

	if(current_target)
		RegisterSignal(target, COMSIG_QDELETING, PROC_REF(set_target))

/obj/machinery/porta_turret/proc/set_state(on, new_lethal, new_flags)
	if(!isnull(new_flags))
		turret_flags = new_flags

	lethal = new_lethal
	toggle_on(on)
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
