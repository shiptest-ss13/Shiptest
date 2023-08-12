/obj/structure/frame/computer
	name = "computer frame"
	icon_state = "console_frame"
	state = 0
	base_icon_state = "console"
	var/obj/item/stack/sheet/decon_material = /obj/item/stack/sheet/metal
	var/built_icon = 'icons/obj/machines/computer.dmi'
	var/built_icon_state = "computer"
	var/deconpath = /obj/structure/frame/computer

/obj/structure/frame/computer/attackby(obj/item/P, mob/user, params)
	add_fingerprint(user)
	switch(state)
		if(0)
			if(P.tool_behaviour == TOOL_WRENCH)
				to_chat(user, "<span class='notice'>You start wrenching the frame into place...</span>")
				if(P.use_tool(src, user, 20, volume=50))
					to_chat(user, "<span class='notice'>You wrench the frame into place.</span>")
					set_anchored(TRUE)
					state = 1
				return
			if(P.tool_behaviour == TOOL_WELDER)
				if(!P.tool_start_check(user, amount=0))
					return

				to_chat(user, "<span class='notice'>You start deconstructing the frame...</span>")
				if(P.use_tool(src, user, 20, volume=50))
					to_chat(user, "<span class='notice'>You deconstruct the frame.</span>")

					var/obj/dropped_sheet = new decon_material(drop_location(), 5)
					dropped_sheet.add_fingerprint(user)
					qdel(src)
				return
		if(1)
			if(P.tool_behaviour == TOOL_WRENCH)
				to_chat(user, "<span class='notice'>You start to unfasten the frame...</span>")
				if(P.use_tool(src, user, 20, volume=50))
					to_chat(user, "<span class='notice'>You unfasten the frame.</span>")
					set_anchored(FALSE)
					state = 0
				return
			if(istype(P, /obj/item/circuitboard/computer) && !circuit)
				if(!user.transferItemToLoc(P, src))
					return
				playsound(src, 'sound/items/deconstruct.ogg', 50, TRUE)
				to_chat(user, "<span class='notice'>You place [P] inside the frame.</span>")
				circuit = P
				circuit.add_fingerprint(user)
				update_appearance()
				return

			else if(istype(P, /obj/item/circuitboard) && !circuit)
				to_chat(user, "<span class='warning'>This frame does not accept circuit boards of this type!</span>")
				return
			if(P.tool_behaviour == TOOL_SCREWDRIVER && circuit)
				P.play_tool_sound(src)
				to_chat(user, "<span class='notice'>You screw [circuit] into place.</span>")
				state = 2
				update_appearance()
				return
			if(P.tool_behaviour == TOOL_CROWBAR && circuit)
				P.play_tool_sound(src)
				to_chat(user, "<span class='notice'>You remove [circuit].</span>")
				state = 1
				circuit.forceMove(drop_location())
				circuit.add_fingerprint(user)
				circuit = null
				update_appearance()
				return
		if(2)
			if(P.tool_behaviour == TOOL_SCREWDRIVER && circuit)
				P.play_tool_sound(src)
				to_chat(user, "<span class='notice'>You unfasten the circuit board.</span>")
				state = 1
				update_appearance()
				return
			if(istype(P, /obj/item/stack/cable_coil))
				if(!P.tool_start_check(user, amount=5))
					return
				to_chat(user, "<span class='notice'>You start adding cables to the frame...</span>")
				if(P.use_tool(src, user, 20, volume=50, amount=5))
					if(state != 2)
						return
					to_chat(user, "<span class='notice'>You add cables to the frame.</span>")
					state = 3
					update_appearance()
				return
		if(3)
			if(P.tool_behaviour == TOOL_WIRECUTTER)
				P.play_tool_sound(src)
				to_chat(user, "<span class='notice'>You remove the cables.</span>")
				state = 2
				update_appearance()
				var/obj/item/stack/cable_coil/A = new (drop_location(), 5)
				A.add_fingerprint(user)
				return

			if(istype(P, /obj/item/stack/sheet/glass))
				if(!P.tool_start_check(user, amount=2))
					return
				playsound(src, 'sound/items/deconstruct.ogg', 50, TRUE)
				to_chat(user, "<span class='notice'>You start to put in the glass panel...</span>")
				if(P.use_tool(src, user, 20, amount=2))
					if(state != 3)
						return
					to_chat(user, "<span class='notice'>You put in the glass panel.</span>")
					state = 4
					update_appearance()
				return
		if(4)
			if(P.tool_behaviour == TOOL_CROWBAR)
				P.play_tool_sound(src)
				to_chat(user, "<span class='notice'>You remove the glass panel.</span>")
				state = 3
				update_appearance()
				var/obj/item/stack/sheet/glass/G = new(drop_location(), 2)
				G.add_fingerprint(user)
				return
			if(P.tool_behaviour == TOOL_SCREWDRIVER)
				P.play_tool_sound(src)
				to_chat(user, "<span class='notice'>You connect the monitor.</span>")
				var/obj/machinery/computer/built_comp = new circuit.build_path (loc, circuit)
				built_comp.setDir(dir)
				transfer_fingerprints_to(built_comp)
				if(!built_comp.unique_icon)
					built_comp.icon = built_icon
					built_comp.icon_state = built_icon_state
				built_comp.deconpath = deconpath
				built_comp.update_appearance()
				qdel(src)
				return
	if(user.a_intent == INTENT_HARM)
		return ..()

/obj/structure/frame/computer/update_overlays()
	. = ..()
	var/mutable_appearance/step
	if(circuit)
		step = mutable_appearance(icon, "[base_icon_state]-[state]")
	else
		step = mutable_appearance(icon, null)
	. += step

/obj/structure/frame/computer/deconstruct(disassembled = TRUE)
	if(!(flags_1 & NODECONSTRUCT_1))
		if(state == 4)
			new /obj/item/shard(drop_location())
			new /obj/item/shard(drop_location())
		if(state >= 3)
			new /obj/item/stack/cable_coil(drop_location(), 5)
	..()

/obj/structure/frame/computer/AltClick(mob/user)
	..()
	if(!isliving(user) || !user.canUseTopic(src, BE_CLOSE, ismonkey(user)))
		return

	if(anchored)
		to_chat(usr, "<span class='warning'>You must unwrench [src] before rotating it!</span>")
		return

	setDir(turn(dir, -90))

/obj/structure/frame/computer/retro
	name = "retro computer frame"
	icon_state = "console_frame-retro"
	base_icon_state = "retro"
	decon_material = /obj/item/stack/sheet/plastic
	built_icon = 'icons/obj/machines/retro_computer.dmi'
	built_icon_state = "computer-retro"
	deconpath = /obj/structure/frame/computer/retro

/obj/structure/frame/computer/solgov
	name = "wooden computer frame"
	icon_state = "console_frame-solgov"
	base_icon_state = "solgov"
	decon_material = /obj/item/stack/sheet/mineral/wood
	built_icon = 'icons/obj/machines/retro_computer.dmi'
	built_icon_state = "computer-solgov"
	deconpath = /obj/structure/frame/computer/retro
