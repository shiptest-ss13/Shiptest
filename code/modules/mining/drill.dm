#define MALF_LASER 1
#define MALF_SENSOR 2
#define MALF_CAPACITOR 3
#define MALF_STRUCTURAL 4
#define MALF_CALIBRATE 5

/obj/machinery/drill
	name = "big-ass ore drill"
	desc = "It's like those drills you put in your hand but, like, way bigger."
	icon = 'icons/obj/machines/drill.dmi'
	icon_state = "deep_core_drill"
	max_integrity = 400
	density = TRUE
	anchored = FALSE
	use_power = NO_POWER_USE
	layer = ABOVE_ALL_MOB_LAYER
	armor = list("melee" = 50, "bullet" = 30, "laser" = 30, "energy" = 30, "bomb" = 30, "bio" = 0, "rad" = 0, "fire" = 90, "acid" = 90)
	component_parts = list()

	var/malfunction
	var/active = FALSE
	var/obj/structure/vein/mining
	var/datum/looping_sound/drill/soundloop
	var/obj/item/stock_parts/cell/cell
	var/preload_cell_type = /obj/item/stock_parts/cell
	var/power_cost = 50

	var/debug_laser_var = /obj/item/stock_parts/micro_laser //REMOVE BEFORE PRING
	var/debug_sensor_var = /obj/item/stock_parts/scanning_module
	var/debug_capacitor_var = /obj/item/stock_parts/capacitor


/obj/machinery/drill/Initialize()
	. = ..()
	component_parts += new /obj/item/stock_parts/capacitor(null)
	component_parts += new /obj/item/stock_parts/micro_laser(null)
	component_parts += new /obj/item/stock_parts/scanning_module(null)
	if(preload_cell_type)
		if(!ispath(preload_cell_type,/obj/item/stock_parts/cell))
			log_mapping("[src] at [AREACOORD(src)] had an invalid preload_cell_type: [preload_cell_type].")
		else
			cell = new preload_cell_type(src)
	soundloop = new(list(src), active)

/obj/machinery/drill/process()
	if(machine_stat & BROKEN || (active && !mining))
		active = FALSE
		soundloop.stop()
		update_overlays()
		update_icon_state()
		return

/obj/machinery/drill/Destroy()
	QDEL_NULL(soundloop)
	return ..()

/obj/machinery/drill/deconstruct(disassembled)
	obj_break()
	update_icon_state()

/obj/machinery/drill/get_cell()
	return cell

/obj/machinery/drill/attackby(obj/item/tool, mob/living/user, params)
	var/obj/structure/vein/vein = locate(/obj/structure/vein) in src.loc
	if(tool.tool_behaviour == TOOL_WRENCH)
		if(!vein && !anchored)
			to_chat(user, "<span class='notice'>[src] must be on top of an ore vein.</span>")
			return
		if(active)
			to_chat(user, "<span class='notice'>[src] can't be unsecured while it's running!</span>")
			return
		playsound(src, 'sound/items/ratchet.ogg', 50, TRUE)
		if(!anchored && do_after(user, 30, target = src))
			to_chat(user, "<span class='notice'>You secure the [src] to the ore vein.</span>")
			playsound(src, 'sound/items/deconstruct.ogg', 50, TRUE)
			mining = vein
			anchored = TRUE
			update_icon_state()
			return
		if(do_after(user, 30, target = src))
			to_chat(user, "<span class='notice'>You unsecure the [src] from the ore vein.</span>")
			playsound(src, 'sound/items/deconstruct.ogg', 50, TRUE)
			anchored = FALSE
			mining = null
			update_icon_state()
			return
	if(default_deconstruction_screwdriver(user,"deep_core_drill","deep_core_drill",tool))
		return TRUE
	if(panel_open)
		/*var/list/needed_parts = list(/obj/item/stock_parts/scanning_module,/obj/item/stock_parts/micro_laser,/obj/item/stock_parts/capacitor)
		if(is_type_in_list(tool,needed_parts))
			for(var/obj/item/stock_parts/part in component_parts)
				var/obj/item/stock_parts/new_part = tool
				if(new_part.part_behaviour == part.part_behaviour)
					if(new_part.rating > part.rating)*/




			/*var/obj/item/stock_parts/new_part = tool
			for(var/obj/item/stock_parts/part in component_parts)
				if(new_part.parent_type == part.parent_type || istype(new_part,part))
					if(new_part.rating > part.rating)
						component_parts.Remove(part)
						component_parts.Add(new_part)
						to_chat(user, "<span class='notice'>You swap the drill's [part] with a [tool].</span>")
						return
					else
						to_chat(user, "<span class='notice'>The [part] doesn't need replacing.</span>")
						return
				else
					new_part.forceMove(component_parts)
					/*component_parts.Add(new_part)*/
					malfunction = null*/


	return ..()

/obj/machinery/drill/interact(mob/user, special_state)
	. = ..()
	if(malfunction)
		say("Please resolve existing malfunction before continuing mining operations.")
		return
	if(!mining)
		to_chat(user, "<span class='notice'>[src] isn't sercured over an ore vein!</span>")
		return
	if(!active)
		playsound(src, 'sound/machines/click.ogg', 100, TRUE)
		user.visible_message( \
					"[user] activates [src].", \
					"<span class='notice'>You hit the ignition button to activate [src].</span>", \
					"<span class='hear'>You hear a drill churn to life.</span>")
		start_mining()
		return
	else
		to_chat(user, "<span class='notice'>[src] is currently busy, wait till it's done!</span>")
		return

/obj/machinery/drill/update_icon_state()
	if(anchored)
		if(machine_stat && BROKEN)
			icon_state = "deep_core_drill-deployed_broken"
			return ..()
		if(active)
			icon_state = "deep_core_drill-active"
			return ..()
		else
			icon_state = "deep_core_drill-idle"
			return ..()
	else
		if(machine_stat && BROKEN)
			icon_state = "deep_core_drill-broken"
			return ..()
		icon_state = "deep_core_drill"
		return ..()

/obj/machinery/drill/update_overlays()
	. = ..()
	SSvis_overlays.remove_vis_overlay(src, managed_vis_overlays)
	//Cool beam of light ignores shadows.
	if(active && anchored)
		set_light(3, 1, "99FFFF")
		SSvis_overlays.add_vis_overlay(src, icon, "mining_beam-particles", layer, plane, dir)
		SSvis_overlays.add_vis_overlay(src, icon, "mining_beam-particles", layer, EMISSIVE_PLANE, dir)
	else
		set_light(0)

/obj/machinery/drill/proc/start_mining()
	var/eta
	var/power_use
	for(var/obj/item/stock_parts/capacitor/capacitor in component_parts)
		power_use = power_cost/capacitor.rating
	if(cell.charge < power_use)
		say("Error: Internal cell charge deplted")
		active = FALSE
		soundloop.stop()
		return
	if(obj_integrity <= max_integrity/2)
		malfunction = rand(1,5)
		malfunction(malfunction)
		active = FALSE
		update_icon_state()
		update_overlays()
		return
	if(mining.mining_charges >= 1)
		var/mine_time
		active = TRUE
		soundloop.start()
		mining.begin_spawning()
		for(var/obj/item/stock_parts/micro_laser/laser in component_parts)
			mine_time = round((300/sqrt(laser.rating)))
		eta = mine_time*mining.mining_charges
		cell.use(power_use)
		addtimer(CALLBACK(src, .proc/mine), mine_time)
		say("Estimated time until vein depletion: [time2text(eta,"mm:ss")].")
		return
	else
		say("Vein depleted.")
		active = FALSE
		soundloop.stop()
		mining.deconstruct()
		mining = null
		update_icon_state()
		update_overlays()

/obj/machinery/drill/proc/mine()
	var/sensor_rating
	for(var/obj/item/stock_parts/scanning_module/sensor in component_parts)
		sensor_rating = sensor.rating
	if(mining.mining_charges)
		mining.mining_charges -= 1
		mining.drop_ore(round(sqrt(sensor_rating), 0.1))
		start_mining()
	else if(!mining.mining_charges) //Extra check to prevent vein related errors locking us in place
		say("Error: Vein Depleted")
		active = FALSE
		update_icon_state()
		update_overlays()

/obj/machinery/drill/proc/malfunction(malfunction_type)
	switch(malfunction_type)
		if(MALF_LASER)
			say("Malfunction: Laser array damaged, please replace before continuing mining operations.")
			for (var/obj/item/stock_parts/micro_laser/laser in component_parts)
				component_parts.Remove(laser)
			return
		if(MALF_SENSOR)
			say("Malfunction: Ground penetrating scanner damaged, please replace before continuing mining operations.")
			for (var/obj/item/stock_parts/scanning_module/sensor in component_parts)
				component_parts.Remove(sensor)
			return
		if(MALF_CAPACITOR)
			say("Malfunction: Energy cell capacitor damaged, please replace before continuin mining operations.")
			for (var/obj/item/stock_parts/capacitor/capacitor in component_parts)
				component_parts.Remove(capacitor)
			return
		if(MALF_STRUCTURAL)
			say("Malfunction: Drill plating damaged, provide structural repairs before continuing mining operations.")
			/*playsound()*/
			return
		if(MALF_CALIBRATE)
			say("Malfunction: Drill laser calibrations out of alignment, please recalibrate before continuing.")
			return
