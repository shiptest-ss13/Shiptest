/obj/machinery/deepcore/drill
	name = "Deep Core Bluespace Drill"
	desc = "A sophisticated machince capable of extracting ores deep within a planets surface."
	icon = 'whitesands/icons/obj/machines/drill.dmi'
	icon_state = "deep_core_drill"
	density = TRUE
	anchored = FALSE
	use_power = NO_POWER_USE
	pressure_resistance = 30
	max_integrity = 200
	integrity_failure = 0.3
	circuit = /obj/item/circuitboard/machine/deepcore/drill

	var/deployed = FALSE //If the drill is anchored and ready-to-mine
	var/active = FALSE //If the drill is activly mining ore
	var/obj/effect/landmark/ore_vein/active_vein //Ore vein currently set to be mined in

/obj/machinery/deepcore/drill/Initialize(mapload)
	. = ..()
	container.max_amount = 4000 //Give the drill some room to buffer mats, but not much

/obj/machinery/deepcore/drill/interact(mob/user, special_state)
	. = ..()
	if(machine_stat & BROKEN)
		return .
	if(deployed)
		if(active)
			active = FALSE
			to_chat(user, "<span class='notice'>You deactivate [src]</span>")
		else
			active = TRUE
			to_chat(user, "<span class='notice'>You reactivate [src]</span>")
		update_icon_state()
		update_overlays()
		return TRUE
	else
		var/obj/effect/landmark/ore_vein/O = scanArea()
		if(O)
			anchored = TRUE
			playsound(src, 'sound/machines/windowdoor.ogg', 50)
			flick("deep_core_drill-deploy", src)
			addtimer(CALLBACK(src, .proc/Deploy), 14)
			to_chat(user, "<span class='notice'>[src] detects a [O.name] and begins to deploy...</span>")
			return TRUE
		else
			to_chat(user, "<span class='warning'>[src] fails to locate any ore in the area!</span>")

/obj/machinery/deepcore/drill/AltClick(mob/user)
	. = ..()
	if(active)
		to_chat(user, "<span class='warning'>You can't disengage [src] while it's active!</span>")
		return
	else
		playsound(src, 'sound/machines/windowdoor.ogg', 50)
		flick("deep_core_drill-undeploy", src)
		addtimer(CALLBACK(src, .proc/Undeploy), 13)

/obj/machinery/deepcore/drill/process()
	if(machine_stat & BROKEN || (active && !active_vein))
		active = FALSE
		update_overlays()
		update_icon_state()
		return
	if(deployed && active)
		if(!mineOre())
			active = FALSE
			update_overlays()
			update_icon_state()
		if(network)
			network.Push(container)
		else //Dry deployment of ores
			dropOre()

/obj/machinery/deepcore/drill/proc/mineOre()
	var/list/extracted = active_vein.extract_ore()
	for(var/O in extracted)
		var/datum/material/M = O
		container.insert_amount_mat(extracted[M], M)
	return TRUE

/obj/machinery/deepcore/drill/proc/dropOre(datum/material/M, amount)
	return container.retrieve_all(get_step(src, SOUTH))

/obj/machinery/deepcore/drill/proc/scanArea()
	//Checks for ores and latches to an active vein if one is located.
	var/turf/deployed_zone = get_turf(src)
	var/obj/effect/landmark/ore_vein/vein = locate() in deployed_zone
	if(vein)
		active_vein = vein
		return vein
	else
		return FALSE

/obj/machinery/deepcore/drill/proc/Deploy()
	deployed = TRUE
	update_icon_state()
	playsound(src, 'sound/machines/boltsdown.ogg', 50)
	visible_message("<span class='notice'>[src] is now deployed and ready to operate!</span>")

/obj/machinery/deepcore/drill/proc/Undeploy()
	active_vein = null
	deployed = FALSE
	anchored = FALSE
	update_icon_state()
	playsound(src, 'sound/machines/boltsup.ogg', 50)
	visible_message("<span class='notice'>[src] is now undeployed and safe to move!</span>")

/obj/machinery/deepcore/drill/update_icon_state()
	if(deployed)
		if(machine_stat & BROKEN)
			icon_state = "deep_core_drill-deployed-broken"
			return
		if(active)
			icon_state = "deep_core_drill-active"
		else
			icon_state = "deep_core_drill-idle"
	else
		if(machine_stat & BROKEN)
			icon_state = "deep_core_drill-broken"
		else
			icon_state = "deep_core_drill"

/obj/machinery/deepcore/drill/update_overlays()
	. = ..()
	SSvis_overlays.remove_vis_overlay(src, managed_vis_overlays)
	//Cool beam of light ignores shadows.
	if(active && deployed)
		set_light(3, 1, "99FFFF")
		SSvis_overlays.add_vis_overlay(src, icon, "mining_beam-particles", layer, plane, dir)
		SSvis_overlays.add_vis_overlay(src, icon, "mining_beam-particles", layer, EMISSIVE_PLANE, dir)
	else
		set_light(0)

/obj/machinery/deepcore/drill/obj_break(damage_flag)
	. = ..()
	if(.)
		active = FALSE
		set_light(0)
		update_overlays()

/obj/machinery/deepcore/drill/can_be_unfasten_wrench(mob/user, silent)
	to_chat(user, "<span class='notice'>You don't need a wrench to deploy [src]!</span>")
	return CANT_UNFASTEN

