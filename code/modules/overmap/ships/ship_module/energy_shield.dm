/datum/ship_module/shield
	name = "Energy Shield"
	slot = SHIP_SLOT_SHIELD
	cost = 10
	should_process = TRUE
	structure_path = /obj/structure/ship_module/shield

/obj/structure/overmap/ship/simulated/proc/has_active_shield()
	var/datum/ship_module/shield/shield_instance = GLOB.ship_modules[/datum/ship_module/shield]
	var/obj/structure/ship_module/shield/shield_struc = shield_instance.installed_on[src]
	return(shield_struc?.charge)

/obj/structure/ship_module/shield
	name = "Energy Shield Core"
	icon_state = "shield_base"
	structure_process = TRUE
	/// The current charge of the shield
	var/charge = 0
	/// The charge that the shield begins with.
	var/charge_base = 20
	/// The amount of charge the shield is allowed to spool to
	var/charge_limit
	/// The rate at which this shield can charge
	var/charge_rate = 20
	/// The maximum charge allowed for the shield
	var/charge_max = 100
	/// The power required to spool the shield. THIS IS PER POINT OF CHARGE
	var/charge_cost = 4
	/// The static number to add to the charge limit for each pylon
	var/pylon_add = 2
	/// The static number to multiply for each concentrator, multiplicative
	var/concentrator_mult = 1.2
	/// How long does the shield take to recover from a zero sum charge
	var/spool_windup = 2 SECONDS
	/// Are we actively spooling
	var/spool_winding = FALSE
	/// Whether or not this shield has finished spooling
	var/spool_active = FALSE
	/// The world.time we will begin attempting to spool
	var/spool_time

	/// Internal list for calculating the charge limit
	var/list/prop_cache = new

/obj/structure/ship_module/shield/process()
	update_icon()
	var/area/local_area = get_area(src)
	var/obj/machinery/power/apc/local_apc = local_area.get_apc()
	if(!spool_active)
		if(!spool_winding && spool_time < world.time)
			INVOKE_ASYNC(src, .proc/spool)
		return
	if(local_apc.operating && local_apc.equipment)
		var/wanted = min(charge_limit - charge, charge_rate)
		var/avail = local_apc?.avail()
		wanted = min(avail, wanted)
		if(wanted)
			local_apc.use_power(wanted * charge_cost)
			charge += wanted
	if(!charge)
		visible_message("[src] blares a warning as the flywheel suddenly grinds to a halt, the magnetic field scattering and failing.")
		playsound(src, 'sound/machines/defib_failed.ogg', 100)
		for(var/i in 1 to 2)
			tesla_zap(src, 2, 5, ZAP_MOB_STUN)
		spool_active = FALSE
		spool_winding = FALSE
		spool_time = world.time + spool_windup
	return

/obj/structure/ship_module/shield/ship_damage(ship, damage, damage_type, originator)
	. = SHIP_ALLOW
	var/effective_damage = damage
	if(IS_DAMAGE_TYPE(damage_type, DAMAGE_EMP)) // EMPs deal double damage to shields, always
		effective_damage *= 2
		. = SHIP_FORCE_BLOCK // If we are hit with an EMP we always force block it, unless the shield is down
	charge -= effective_damage
	// After we take a hit force a process cycle
	process()
	if(charge) // If we have remaining charge it means that we blocked the shot
		return SHIP_FORCE_BLOCK

/obj/structure/ship_module/shield/update_overlays()
	. = ..()
	if(charge)
		. += mutable_appearance(icon, "shield_online")
	else
		if(spool_winding)
			. += mutable_appearance(icon, "shield_spooling")
		else
			. += mutable_appearance(icon, "shield_offline")

/obj/structure/ship_module/shield/proc/spool()
	if(spool_winding)
		return
	spool_winding = TRUE
	update_icon()
	visible_message("[src] begins to emit a loud whine as the tungsten-phoron flywheel begins to spool.")
	sleep(5 SECONDS)
	visible_message("[src] blares an alarm as the flywheel approaches terminal velocity. <span class='danger'>It might be a good idea to <b>back away.</b></span>")
	playsound(src, 'sound/machines/defib_failed.ogg', 100)
	sleep(5 SECONDS)
	visible_message("[src] suddenly lurches as the flywheel engages with the ionic resonators; creating an intense localized magnetic field.")
	for(var/mob/living/onlooker in viewers(3, src))
		onlooker.emp_act(EMP_HEAVY)
	sleep(5 SECONDS)
	visible_message("[src] chimes as the morphic reflector concentrates and ionizes the magnetic field; the shield projector is now active.")
	playsound(src, 'sound/machines/chime.ogg', 50)
	calculate_max_shield()
	charge = round(charge_limit / 10)
	spool_active = TRUE
	update_icon()

/obj/structure/ship_module/shield/proc/calculate_max_shield()
	for(var/prop in prop_cache)
		UnregisterSignal(prop, COMSIG_PARENT_QDELETING)
	prop_cache.Cut()
	propagate(prop_cache)
	var/running_total = charge_base
	for(var/obj/structure/ship_module/shield/pylon/py in prop_cache)
		running_total += pylon_add
	for(var/obj/structure/ship_module/shield/concentrator/cc in prop_cache)
		running_total *= concentrator_mult
	charge_limit = min(running_total, charge_max)

/obj/structure/ship_module/shield/proc/propagate(list/cache)
	for(var/dir in list(NORTH, SOUTH, EAST, WEST))
		var/turf/neighbor = get_step(src, dir)
		var/obj/structure/ship_module/shield/prop = locate() in neighbor
		if(!prop || prop in cache)
			continue
		cache |= prop
		RegisterSignal(prop, COMSIG_PARENT_QDELETING, .proc/calculate_max_shield)
		prop.propagate(cache)

// These inherit the above procs, but they really shouldnt, except for propagate, but ohwell

/obj/structure/ship_module/shield/pylon
	name = "Energy Shield Injection Pylon"
	icon_state = "shield_pylon"

/obj/structure/ship_module/shield/concentrator
	name = "Energy Shield Tesla Reflector"
	icon_state = "shield_conc"
