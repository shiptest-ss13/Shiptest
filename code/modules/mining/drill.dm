//For handling the types of randomized malfunctions
#define MALF_LASER 1
#define MALF_SENSOR 2
#define MALF_CAPACITOR 3
#define MALF_STRUCTURAL 4
#define MALF_CALIBRATE 5

//For handling the repair of a completely destroyed drill
#define METAL_ABSENT 0 //Couldn't think of a better word for this but it gets the point across
#define METAL_PLACED 1
#define METAL_SECURED 2

/obj/machinery/drill
	name = "heavy-duty laser mining drill"
	desc = "A large scale laser drill. It's able to mine vast amounts of minerals from near-surface ore pockets, however the seismic activity tends to anger local fauna."
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
	///the vein that we are currently drilling
	var/obj/structure/vein/our_vein
	var/datum/looping_sound/drill/soundloop
	var/obj/item/stock_parts/cell/cell
	var/preload_cell_type = /obj/item/stock_parts/cell
	var/power_cost = 100
	var/metal_attached = METAL_ABSENT
	var/missing_part //I hate this but it's better than most the ideas I've had
	var/current_timerid

/obj/machinery/drill/examine(mob/user)
	. = ..()
	if(panel_open && component_parts)
		. += display_parts(user, TRUE)
	if(cell.charge < power_cost*5)
		. += "<spawn class='notice'>The low power light is blinking.</span>"
	switch(malfunction)
		if(MALF_LASER)
			. += span_notice("The [src]'s <b>laser array</b> appears to be broken and needs to be replaced.")
		if(MALF_SENSOR)
			. += span_notice("The [src]'s <b>sensors</b> appear to be broken and need to be replaced.")
		if(MALF_CAPACITOR)
			. += span_notice("The [src]'s <b>capacitor</b> appears to be broken and needs to be replaced.")
		if(MALF_STRUCTURAL)
			. += span_notice("The [src]'s structure looks like it needs to be <b>welded</b> back together.")
		if(MALF_CALIBRATE)
			. += span_notice("The [src]'s gimbal is out of alignment, it needs to be recalibrated with a <b>multitool</b>.")
	switch(metal_attached)
		if(METAL_PLACED)
			. += span_notice("Replacement plating has been attached to [src], but has not been <b>bolted</b> in place yet.")
		if(METAL_SECURED)
			. += span_notice("Replacement plating has been secured to [src], but still needs to be <b>welded</b> into place.")
	if(machine_stat & BROKEN && !metal_attached)
		. += "<span class='notice'>[src]'s structure has been totaled, the <b>plasteel</b> plating needs to be replaced."
	. += span_notice("The manual shutoff switch can be pulled with <b>Alt Click</b>.")

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

/obj/machinery/drill/process(seconds_per_tick)
	if(machine_stat & BROKEN || (active && !our_vein))
		active = FALSE
		soundloop.stop()
		update_overlays()
		update_icon_state()
	if(!active && our_vein?.currently_spawning)
		our_vein.stop_spawning()

/obj/machinery/drill/Destroy()
	QDEL_NULL(soundloop)
	QDEL_NULL(cell)
	return ..()

//Instead of being qdeled the drill requires mildly expensive repairs to use again
/obj/machinery/drill/deconstruct(disassembled)
	if(active && our_vein)
		say("Drill integrity failure. Engaging emergency shutdown procedure.")
		//Just to make sure mobs don't spawn infinitely from the vein and as a failure state for players
		our_vein.deconstruct()
	atom_break()
	update_icon_state()
	update_overlays()

/obj/machinery/drill/get_cell()
	return cell

//The RPED sort of trivializes a good deal of the malfunction mechancis, as such it will not be allowed to work
/obj/machinery/drill/exchange_parts(mob/user, obj/item/storage/part_replacer/W)
	to_chat(user, "<span class='notice'>[W] does not seem to work on [src], it might require more delicate part manipulation.")
	return

/obj/machinery/drill/attackby(obj/item/tool, mob/living/user, params)
	var/obj/structure/vein/vein = locate(/obj/structure/vein) in src.loc
	if(machine_stat & BROKEN)
		if(istype(tool,/obj/item/stack/sheet/plasteel))
			var/obj/item/stack/sheet/plasteel/plating = tool
			if(plating.use(10,FALSE,TRUE))
				metal_attached = METAL_PLACED
				to_chat(user, span_notice("You prepare to attach the plating to [src]."))
				return
			else
				to_chat(user, span_notice("You don't have enough plasteel to fix the plating."))
				return
		if(metal_attached == METAL_SECURED && tool.tool_behaviour == TOOL_WELDER)
			if(tool.use_tool(src, user, 30, volume=50))
				to_chat(user, "<span class='notice'>You weld the new plating onto the [src], successfully repairing it.")
				metal_attached = METAL_ABSENT
				atom_integrity = max_integrity
				set_machine_stat(machine_stat & ~BROKEN)
				update_icon_state()
				return
	if(tool.tool_behaviour == TOOL_WRENCH)
		if(metal_attached && machine_stat & BROKEN)
			if(tool.use_tool(src, user, 30, volume=50))
				to_chat(user, span_notice("You bolt the plating the plating in place on [src]."))
				metal_attached = METAL_SECURED
				return
		if(!vein && !anchored)
			to_chat(user, span_notice("[src] must be on top of an ore vein."))
			return
		if(active)
			to_chat(user, span_notice("[src] can't be unsecured while it's running!"))
			return
		if(!anchored && tool.use_tool(src, user, 30, volume=50))
			to_chat(user, span_notice("You secure the [src] to the ore vein."))
			playsound(src, 'sound/items/deconstruct.ogg', 50, TRUE)
			our_vein = vein
			our_vein.our_drill = src
			anchored = TRUE
			update_icon_state()
			return
		if(tool.use_tool(src, user, 30, volume=50))
			to_chat(user, span_notice("You unsecure the [src] from the ore vein."))
			playsound(src, 'sound/items/deconstruct.ogg', 50, TRUE)
			anchored = FALSE

			if(our_vein?.currently_spawning)
				our_vein.stop_spawning()
			our_vein.our_drill = null
			our_vein = null
			update_icon_state()
			return
	if(default_deconstruction_screwdriver(user,icon_state,icon_state,tool))
		return TRUE
	if(panel_open) //All malfunction repair and maintenance actions are handled under here
		var/list/needed_parts = list(/obj/item/stock_parts/scanning_module,/obj/item/stock_parts/micro_laser,/obj/item/stock_parts/capacitor)
		if(is_type_in_list(tool,needed_parts))
			for(var/obj/item/stock_parts/part in component_parts)
				var/obj/item/stock_parts/new_part = tool
				if(new_part.part_behaviour == part.part_behaviour)
					user.transferItemToLoc(tool,src)
					try_put_in_hand(part, user)
					component_parts += new_part
					component_parts -= part
					to_chat(user, span_notice("You replace [part] with [new_part]."))
					break
				else if(istype(new_part,missing_part))
					user.transferItemToLoc(tool,src)
					component_parts += new_part
					malfunction = null
					missing_part = null
					atom_integrity = max_integrity
					to_chat(user, span_notice("You replace the broken part with [new_part]."))
					break
			return
		if(tool.tool_behaviour == TOOL_MULTITOOL && malfunction == MALF_CALIBRATE)
			user.visible_message(span_notice("[user] begins recalibrating [src]."), \
				span_notice("You begin recalibrating [src]..."))
			if(tool.use_tool(src, user, 100, volume=50))
				malfunction = null
				atom_integrity = max_integrity
				return
		if(tool.tool_behaviour == TOOL_WELDER && malfunction == MALF_STRUCTURAL)
			if(!tool.tool_start_check(user, src, amount=0))
				return
			user.visible_message(span_notice("[user] begins repairing [src]."), \
				span_notice("You begin repairing [src]..."), \
				span_hear("You hear welding."))
			if(tool.use_tool(src, user, 100, volume=50))
				malfunction = null
				atom_integrity = max_integrity
				return
		if(istype(tool, /obj/item/stock_parts/cell))
			var/obj/item/stock_parts/cell/battery = tool
			if(cell)
				to_chat(user, span_warning("[src] already has a cell!"))
				return
			else //This should literally never be tripped unless someone tries to put a watch battery in it or something, but just in case
				if(battery.maxcharge < power_cost)
					to_chat(user, span_notice("[src] requires a higher capacity cell."))
					return
			if(!user.transferItemToLoc(tool, src))
				return
			cell = tool
			to_chat(user, span_notice("You install a cell in [src]."))
			return
		if(tool.tool_behaviour == TOOL_CROWBAR)
			cell.update_appearance()
			try_put_in_hand(cell, user)
			cell = null
			to_chat(user, span_notice("You remove the cell from [src]."))
			active = FALSE
			update_appearance()
			return
	return ..()

/obj/machinery/drill/AltClick(mob/user)
	if(active)
		to_chat(user, span_notice("You begin the manual shutoff process."))
		if(do_after(user, 10, src))
			if(active)
				say("Manual shutoff engaged, ceasing mining operations.")
				stop_mining()
			else
				to_chat(user, span_warning("The drill has already been turned off!"))
		else
			to_chat(user, span_notice("You cancel the manual shutoff process."))

//Can we even turn the damn thing on?
/obj/machinery/drill/interact(mob/user, special_state)
	. = ..()
	if(malfunction)
		say("Please resolve existing malfunction before continuing mining operations.")
		return
	if(!our_vein)
		to_chat(user, span_notice("[src] isn't secured over an ore vein!"))
		return
	if(!active)
		playsound(src, 'sound/machines/click.ogg', 100, TRUE)
		user.visible_message( \
					"[user] activates [src].", \
					span_notice("You hit the ignition button to activate [src]."), \
					span_hear("You hear a drill churn to life."))
		start_mining()
	else
		to_chat(user, span_notice("[src] is currently busy, wait until it's done!"))

/obj/machinery/drill/update_icon_state()
	if(anchored)
		if(machine_stat & BROKEN)
			icon_state = "deep_core_drill-deployed_broken"
			return ..()
		if(active)
			icon_state = "deep_core_drill-active"
			return ..()
		else
			icon_state = "deep_core_drill-idle"
			return ..()
	else
		if(machine_stat & BROKEN)
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

//shut the drill DOWN NOW!!
/obj/machinery/drill/proc/stop_mining(destructive=FALSE)
	active = FALSE
	soundloop.stop()
	deltimer(current_timerid)
	if(our_vein?.currently_spawning)
		our_vein.stop_spawning()
	if(destructive)
		our_vein.Destroy()
		our_vein = null
	playsound(src, 'sound/machines/switch2.ogg', 50, TRUE)
	update_icon_state()
	update_overlays()

//Handles all checks before starting the 30 second (on average) mining tick
/obj/machinery/drill/proc/start_mining()
	var/eta
	var/power_use
	for(var/obj/item/stock_parts/capacitor/capacitor in component_parts)
		power_use = power_cost/capacitor.rating
	if(cell.charge < power_use)
		say("Error: Internal cell charge depleted")
		active = FALSE
		soundloop.stop()
		update_overlays()
		return
	if(atom_integrity <= max_integrity/1.5)
		malfunction = rand(1,5)
		malfunction(malfunction)
		active = FALSE
		update_icon_state()
		update_overlays()
		return
	if(our_vein.mining_charges >= 1)
		var/mine_time
		active = TRUE
		soundloop.start()
		our_vein.begin_spawning()
		if(!our_vein.currently_spawning)
			our_vein.stop_spawning()
		for(var/obj/item/stock_parts/micro_laser/laser in component_parts)
			mine_time = round((300/sqrt(laser.rating))*our_vein.mine_time_multiplier)
		eta = mine_time*our_vein.mining_charges
		cell.use(power_use)
		current_timerid = addtimer(CALLBACK(src, PROC_REF(mine)), mine_time, TIMER_STOPPABLE)
		say("Estimated time until vein depletion: [time2text(eta,"mm:ss")].")
		update_icon_state()
		update_overlays()

//Handles the process of withdrawing ore from the vein itself
/obj/machinery/drill/proc/mine()
	if(our_vein.mining_charges)
		our_vein.mining_charges--
		mine_success()
		if(!active)
			return FALSE
		if(our_vein.mining_charges < 1)
			say("Vein depleted, shutting down.")
			stop_mining(TRUE)
		else
			start_mining()
	else if(!our_vein.mining_charges) //Extra check to prevent vein related errors locking us in place
		say("Error: Vein Depleted")
		active = FALSE
		update_icon_state()
		update_overlays()

//Called when it's time for the drill to rip that sweet ore from the earth
/obj/machinery/drill/proc/mine_success()
	var/sensor_rating
	for(var/obj/item/stock_parts/scanning_module/sensor in component_parts)
		sensor_rating = round(sqrt(sensor.rating))
	our_vein.drop_ore(sensor_rating, src)

//Overly long proc to handle the unique properties for each malfunction type
/obj/machinery/drill/proc/malfunction(malfunction_type)

	//we want to pause the creation of new spawners
	if(active && our_vein?.currently_spawning)
		our_vein.stop_spawning()

	switch(malfunction_type)
		if(MALF_LASER)
			say("Malfunction: Laser array damaged, please replace before continuing mining operations.")
			for (var/obj/item/stock_parts/micro_laser/laser in component_parts)
				component_parts.Remove(laser)
			missing_part = /obj/item/stock_parts/micro_laser
		if(MALF_SENSOR)
			say("Malfunction: Ground penetrating scanner damaged, please replace before continuing mining operations.")
			for (var/obj/item/stock_parts/scanning_module/sensor in component_parts)
				component_parts.Remove(sensor)
			missing_part = /obj/item/stock_parts/scanning_module
		if(MALF_CAPACITOR)
			say("Malfunction: Energy cell capacitor damaged, please replace before continuing mining operations.")
			for (var/obj/item/stock_parts/capacitor/capacitor in component_parts)
				component_parts.Remove(capacitor)
			missing_part = /obj/item/stock_parts/capacitor
		if(MALF_STRUCTURAL)
			say("Malfunction: Drill plating damaged, provide structural repairs before continuing mining operations.")
		if(MALF_CALIBRATE)
			say("Malfunction: Drill laser calibrations out of alignment, please recalibrate before continuing.")

/obj/item/paper/guides/drill
	name = "Laser Mining Drill Operation Manual"
	default_raw_text = "<center><b>Laser Mining Drill Operation Manual</b></center><br><br><center>Thank you for opting in to the paid testing of Nanotrasen's new, experimental laser drilling device (trademark pending). We are legally obligated to mention that despite this new and wonderful drilling device being less dangerous than past iterations (note the 75% decrease in plasma ignition incidents), the seismic activity created by the drill has been noted to anger most forms of xenofauna. As such our legal team advises only armed mining expeditions make use of this drill.<br><br><c><b>How to set up your Laser Mining Drill</b></center><br><br>1. Find a suitable ore vein with the included scanner.<br>2. Wrench the drill's anchors in place over the vein.<br>3. Protect the drill from any enraged xenofauna until it has finished drilling.<br><br><center>With all this done, your ore should be well on its way out of the ground and into your pockets! Be warned though, the Laser Mining Drill is prone to numerous malfunctions when exposed to most forms of physical trauma. As such, we advise any teams utilizing this drill to bring with them a set of replacement Nanotrasen brand stock parts and a set of tools to handle repairs. If the drill suffers a total structural failure, then plasteel alloy may be needed to repair said structure.</center>"
