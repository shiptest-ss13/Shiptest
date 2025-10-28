/obj/machinery/computer
	name = "computer"
	icon = 'icons/obj/machines/computer.dmi'
	icon_state = "computer"
	density = TRUE
	use_power = IDLE_POWER_USE
	idle_power_usage = IDLE_DRAW_LOW
	active_power_usage = ACTIVE_DRAW_LOW
	max_integrity = 200
	integrity_failure = 0.5
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 40, "acid" = 20)
	clicksound = "keyboard"
	req_ship_access = TRUE
	var/brightness_on = 1
	var/icon_keyboard = "generic_key"
	var/icon_screen = "generic"
	var/time_to_screwdrive = 20
	var/authenticated = 0
	/// The object that will drop on deconstruction. Mainly used for computer alt skins.
	var/obj/structure/frame/computer/deconpath = /obj/structure/frame/computer
	///Does this computer have a unique icon_state? Prevents the changing of icons from alternative computer construction
	var/unique_icon = FALSE

	hitsound_type = PROJECTILE_HITSOUND_GLASS

/obj/machinery/computer/Initialize(mapload, obj/item/circuitboard/C)
	. = ..()
	power_change()
	if(!QDELETED(C))
		qdel(circuit)
		circuit = C
		C.moveToNullspace()

/obj/machinery/computer/process(seconds_per_tick)
	if(machine_stat & (NOPOWER|BROKEN))
		return 0
	return 1

/obj/machinery/computer/update_overlays()
	. = ..()
	if(machine_stat & BROKEN)
		SSvis_overlays.add_vis_overlay(src, icon, "[icon_state]_broken", layer, plane, dir)
		return
	if(machine_stat & NOPOWER)
		. += "[icon_keyboard]_off"
		return
	. += icon_keyboard
	SSvis_overlays.add_vis_overlay(src, icon, icon_screen, layer, plane, dir)
	SSvis_overlays.add_vis_overlay(src, icon, icon_screen, layer, EMISSIVE_PLANE, dir)

/obj/machinery/computer/power_change()
	. = ..()
	if(machine_stat & (NOPOWER|BROKEN))
		set_light(0)
	else
		set_light(brightness_on)

/obj/machinery/computer/screwdriver_act(mob/living/user, obj/item/I)
	if(..())
		return TRUE
	if(circuit && !(flags_1&NODECONSTRUCT_1))
		to_chat(user, span_notice("You start to disconnect the monitor..."))
		if(I.use_tool(src, user, time_to_screwdrive, volume=50))
			deconstruct(TRUE, user)
	return TRUE

/obj/machinery/computer/play_attack_sound(damage_amount, damage_type = BRUTE, damage_flag = 0)
	switch(damage_type)
		if(BRUTE)
			if(machine_stat & BROKEN)
				playsound(src.loc, 'sound/effects/hit_on_shattered_glass.ogg', 70, TRUE)
			else
				playsound(src.loc, 'sound/effects/glasshit.ogg', 75, TRUE)
		if(BURN)
			playsound(src.loc, 'sound/items/welder.ogg', 100, TRUE)

/obj/machinery/computer/atom_break(damage_flag)
	if(!circuit) //no circuit, no breaking
		return
	. = ..()
	if(.)
		playsound(loc, 'sound/effects/glassbr3.ogg', 100, TRUE)
		set_light(0)

/obj/machinery/computer/emp_act(severity)
	. = ..()
	if (!(. & EMP_PROTECT_SELF))
		switch(severity)
			if(1)
				if(prob(50))
					atom_break("energy")
			if(2)
				if(prob(10))
					atom_break("energy")

/obj/machinery/computer/deconstruct(disassembled = TRUE, mob/user)
	on_deconstruction()
	if(!(flags_1 & NODECONSTRUCT_1))
		if(circuit) //no circuit, no computer frame
			var/obj/structure/frame/computer/newframe = new deconpath(src.loc)
			newframe.setDir(dir)
			newframe.circuit = circuit
			newframe.set_anchored(TRUE)
			if(machine_stat & BROKEN)
				if(user)
					to_chat(user, span_notice("The broken glass falls out."))
				else
					playsound(src, 'sound/effects/hit_on_shattered_glass.ogg', 70, TRUE)
				new /obj/item/shard(drop_location())
				new /obj/item/shard(drop_location())
				newframe.state = 3
			else
				if(user)
					to_chat(user, span_notice("You disconnect the monitor."))
				newframe.state = 4
			circuit = null
			newframe.update_appearance()
		for(var/obj/internal_objects in src)
			internal_objects.forceMove(loc)
	qdel(src)

/obj/machinery/computer/AltClick(mob/user)
	. = ..()
	if(!user.canUseTopic(src, !issilicon(user)) || !is_operational)
		return

/obj/machinery/computer/examine_more(mob/user)
	. = ..()
	ui_interact(user)
	return
