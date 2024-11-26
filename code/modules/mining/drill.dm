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
	var/obj/structure/vein/mining
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
			. += "<span class='notice'>The [src]'s <b>laser array</b> appears to be broken and needs to be replaced.</span>"
		if(MALF_SENSOR)
			. += "<span class='notice'>The [src]'s <b>sensors</b> appear to be broken and need to be replaced.</span>"
		if(MALF_CAPACITOR)
			. += "<span class='notice'>The [src]'s <b>capacitor</b> appears to be broken and needs to be replaced.</span>"
		if(MALF_STRUCTURAL)
			. += "<span class='notice'>The [src]'s structure looks like it needs to be <b>welded</b> back together.</span>"
		if(MALF_CALIBRATE)
			. += "<span class='notice'>The [src]'s gimbal is out of alignment, it needs to be recalibrated with a <b>multitool</b>.</span>"
	switch(metal_attached)
		if(METAL_PLACED)
			. += "<span class='notice'>Replacement plating has been attached to [src], but has not been <b>bolted</b> in place yet.</span>"
		if(METAL_SECURED)
			. += "<span class='notice'>Replacement plating has been secured to [src], but still needs to be <b>welded</b> into place.</span>"
	if(machine_stat & BROKEN && !metal_attached)
		. += "<span class='notice'>[src]'s structure has been totaled, the <b>plasteel</b> plating needs to be replaced."
	. += "<span class='notice'>The manual shutoff switch can be pulled with <b>Alt Click</b>.</span>"

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

/obj/machinery/drill/Destroy()
	QDEL_NULL(soundloop)
	QDEL_NULL(cell)
	return ..()

//Instead of being qdeled the drill requires mildly expensive repairs to use again
/obj/machinery/drill/deconstruct(disassembled)
	if(active && mining)
		say("Drill integrity failure. Engaging emergency shutdown procedure.")
		//Just to make sure mobs don't spawn infinitely from the vein and as a failure state for players
		mining.deconstruct()
	obj_break()
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
				to_chat(user, "<span class='notice'>You prepare to attach the plating to [src].</span>")
				return
			else
				to_chat(user, "<span class='notice'>You don't have enough plasteel to fix the plating.</span>")
				return
		if(metal_attached == METAL_SECURED && tool.tool_behaviour == TOOL_WELDER)
			if(tool.use_tool(src, user, 30, volume=50))
				to_chat(user, "<span class='notice'>You weld the new plating onto the [src], successfully repairing it.")
				metal_attached = METAL_ABSENT
				obj_integrity = max_integrity
				set_machine_stat(machine_stat & ~BROKEN)
				update_icon_state()
				return
	if(tool.tool_behaviour == TOOL_WRENCH)
		if(metal_attached && machine_stat & BROKEN)
			if(tool.use_tool(src, user, 30, volume=50))
				to_chat(user, "<span class='notice'>You bolt the plating the plating in place on [src].</span>")
				metal_attached = METAL_SECURED
				return
		if(!vein && !anchored)
			to_chat(user, "<span class='notice'>[src] must be on top of an ore vein.</span>")
			return
		if(active)
			to_chat(user, "<span class='notice'>[src] can't be unsecured while it's running!</span>")
			return
		if(!anchored && tool.use_tool(src, user, 30, volume=50))
			to_chat(user, "<span class='notice'>You secure the [src] to the ore vein.</span>")
			playsound(src, 'sound/items/deconstruct.ogg', 50, TRUE)
			mining = vein
			anchored = TRUE
			update_icon_state()
			return
		if(tool.use_tool(src, user, 30, volume=50))
			to_chat(user, "<span class='notice'>You unsecure the [src] from the ore vein.</span>")
			playsound(src, 'sound/items/deconstruct.ogg', 50, TRUE)
			anchored = FALSE

			if(mining?.spawner_attached && mining?.spawning_started)
				mining.toggle_spawning()
			mining = null
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
					part.forceMove(user.loc)
					component_parts += new_part
					component_parts -= part
					to_chat(user, "<span class='notice'>You replace [part] with [new_part].</span>")
					break
				else if(istype(new_part,missing_part))
					user.transferItemToLoc(tool,src)
					component_parts += new_part
					malfunction = null
					missing_part = null
					obj_integrity = max_integrity
					to_chat(user, "<span class='notice'>You replace the broken part with [new_part].</span>")
					break
			return
		if(tool.tool_behaviour == TOOL_MULTITOOL && malfunction == MALF_CALIBRATE)
			user.visible_message("<span class='notice'>[user] begins recalibrating [src].</span>", \
				"<span class='notice'>You begin recalibrating [src]...</span>")
			if(tool.use_tool(src, user, 100, volume=50))
				malfunction = null
				obj_integrity = max_integrity
				return
		if(tool.tool_behaviour == TOOL_WELDER && malfunction == MALF_STRUCTURAL)
			if(!tool.tool_start_check(user, amount=0))
				return
			user.visible_message("<span class='notice'>[user] begins repairing [src].</span>", \
				"<span class='notice'>You begin repairing [src]...</span>", \
				"<span class='hear'>You hear welding.</span>")
			if(tool.use_tool(src, user, 100, volume=50))
				malfunction = null
				obj_integrity = max_integrity
				return
		if(istype(tool, /obj/item/stock_parts/cell))
			var/obj/item/stock_parts/cell/battery = tool
			if(cell)
				to_chat(user, "<span class='warning'>[src] already has a cell!</span>")
				return
			else //This should literally never be tripped unless someone tries to put a watch battery in it or something, but just in case
				if(battery.maxcharge < power_cost)
					to_chat(user, "<span class='notice'>[src] requires a higher capacity cell.</span>")
					return
			if(!user.transferItemToLoc(tool, src))
				return
			cell = tool
			to_chat(user, "<span class='notice'>You install a cell in [src].</span>")
			return
		if(tool.tool_behaviour == TOOL_CROWBAR)
			cell.update_appearance()
			cell.forceMove(get_turf(src))
			cell = null
			to_chat(user, "<span class='notice'>You remove the cell from [src].</span>")
			active = FALSE
			update_appearance()
			return
	return ..()

/obj/machinery/drill/AltClick(mob/user)
	if(active)
		to_chat(user, "<span class='notice'>You begin the manual shutoff process.</span>")
		if(do_after(user, 10, src))
			active = FALSE
			soundloop.stop()
			deltimer(current_timerid)
			mining.toggle_spawning()
			playsound(src, 'sound/machines/switch2.ogg', 50, TRUE)
			say("Manual shutoff engaged, ceasing mining operations.")
			update_icon_state()
			update_overlays()
		else
			to_chat(user, "<span class='notice'>You cancel the manual shutoff process.</span>")

//Can we even turn the damn thing on?
/obj/machinery/drill/interact(mob/user, special_state)
	. = ..()
	if(malfunction)
		say("Please resolve existing malfunction before continuing mining operations.")
		return
	if(!mining)
		to_chat(user, "<span class='notice'>[src] isn't secured over an ore vein!</span>")
		return
	if(!active)
		playsound(src, 'sound/machines/click.ogg', 100, TRUE)
		user.visible_message( \
					"[user] activates [src].", \
					"<span class='notice'>You hit the ignition button to activate [src].</span>", \
					"<span class='hear'>You hear a drill churn to life.</span>")
		start_mining()
	else
		to_chat(user, "<span class='notice'>[src] is currently busy, wait until it's done!</span>")

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
	if(obj_integrity <= max_integrity/1.5)
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
		if(!mining.spawner_attached)
			mining.begin_spawning()
		else if(!mining.spawning_started)
			mining.toggle_spawning()
		for(var/obj/item/stock_parts/micro_laser/laser in component_parts)
			mine_time = round((300/sqrt(laser.rating))*mining.mine_time_multiplier)
		eta = mine_time*mining.mining_charges
		cell.use(power_use)
		current_timerid = addtimer(CALLBACK(src, PROC_REF(mine)), mine_time, TIMER_STOPPABLE)
		say("Estimated time until vein depletion: [time2text(eta,"mm:ss")].")
		update_icon_state()
		update_overlays()

//Handles the process of withdrawing ore from the vein itself
/obj/machinery/drill/proc/mine()
	if(mining.mining_charges)
		mining.mining_charges--
		mine_success()
		if(mining.mining_charges < 1)
			say("Vein depleted.")
			active = FALSE
			soundloop.stop()
			mining.deconstruct()
			mining = null
			update_icon_state()
			update_overlays()
		else
			start_mining()
	else if(!mining.mining_charges) //Extra check to prevent vein related errors locking us in place
		say("Error: Vein Depleted")
		active = FALSE
		update_icon_state()
		update_overlays()

//Called when it's time for the drill to rip that sweet ore from the earth
/obj/machinery/drill/proc/mine_success()
	var/sensor_rating
	for(var/obj/item/stock_parts/scanning_module/sensor in component_parts)
		sensor_rating = round(sqrt(sensor.rating))
	mining.drop_ore(sensor_rating, src)

//Overly long proc to handle the unique properties for each malfunction type
/obj/machinery/drill/proc/malfunction(malfunction_type)
	if(active)
		mining.toggle_spawning() //turns mob spawning off after a malfunction
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
