//Bot Construction

/obj/item/bot_assembly
	icon = 'icons/mob/aibots.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	force = 3
	throw_speed = 2
	throw_range = 5
	var/created_name
	var/build_step = ASSEMBLY_FIRST_STEP
	var/robot_arm = /obj/item/bodypart/r_arm/robot

/obj/item/bot_assembly/attackby(obj/item/I, mob/user, params)
	..()
	if(istype(I, /obj/item/pen))
		rename_bot()
		return

/obj/item/bot_assembly/proc/rename_bot()
	var/t = sanitize_name(stripped_input(usr, "Enter new robot name", name, created_name,MAX_NAME_LEN))
	if(!t)
		return
	if(!in_range(src, usr) && loc != usr)
		return
	created_name = t

/obj/item/bot_assembly/proc/can_finish_build(obj/item/I, mob/user)
	if(istype(loc, /obj/item/storage/backpack))
		to_chat(user, span_warning("You must take [src] out of [loc] first!"))
		return FALSE
	if(!I || !user || !user.temporarilyRemoveItemFromInventory(I))
		return FALSE
	return TRUE

//Cleanbot assembly
/obj/item/bot_assembly/cleanbot
	desc = "It's a bucket with a sensor attached."
	name = "incomplete cleanbot assembly"
	icon_state = "bucket_proxy"
	throwforce = 5
	created_name = "Cleanbot"

/obj/item/bot_assembly/cleanbot/attackby(obj/item/W, mob/user, params)
	..()
	if(istype(W, /obj/item/bodypart/l_arm/robot) || istype(W, /obj/item/bodypart/r_arm/robot))
		if(!can_finish_build(W, user))
			return
		var/mob/living/simple_animal/bot/cleanbot/A = new(drop_location())
		A.name = created_name
		A.robot_arm = W.type
		to_chat(user, span_notice("You add [W] to [src]. Beep boop!"))
		qdel(W)
		qdel(src)


//Edbot Assembly
/obj/item/bot_assembly/ed209
	name = "incomplete ED-209 assembly"
	desc = "Some sort of bizarre assembly."
	icon_state = "ed209_frame"
	item_state = "ed209_frame"
	created_name = "ED-209 Security Robot" //To preserve the name if it's a unique securitron I guess
	var/lasercolor = ""
	var/vest_type = /obj/item/clothing/suit/armor/vest

/obj/item/bot_assembly/ed209/attackby(obj/item/W, mob/user, params)
	..()
	switch(build_step)
		if(ASSEMBLY_FIRST_STEP, ASSEMBLY_SECOND_STEP)
			if(istype(W, /obj/item/bodypart/leg/left/robot) || istype(W, /obj/item/bodypart/leg/right/robot))
				if(!user.temporarilyRemoveItemFromInventory(W))
					return
				to_chat(user, span_notice("You add [W] to [src]."))
				qdel(W)
				name = "legs/frame assembly"
				if(build_step == ASSEMBLY_FIRST_STEP)
					item_state = "ed209_leg"
					icon_state = "ed209_leg"
				else
					item_state = "ed209_legs"
					icon_state = "ed209_legs"
				build_step++

		if(ASSEMBLY_THIRD_STEP)
			if(istype(W, /obj/item/clothing/suit/armor/vest))
				if(!user.temporarilyRemoveItemFromInventory(W))
					return
				to_chat(user, span_notice("You add [W] to [src]."))
				qdel(W)
				name = "vest/legs/frame assembly"
				item_state = "ed209_shell"
				icon_state = "ed209_shell"
				build_step++

		if(ASSEMBLY_FOURTH_STEP)
			if(W.tool_behaviour == TOOL_WELDER)
				if(W.use_tool(src, user, 0, volume=40))
					name = "shielded frame assembly"
					to_chat(user, span_notice("You weld the vest to [src]."))
					build_step++

		if(ASSEMBLY_FIFTH_STEP)
			if(istype(W, /obj/item/clothing/head/helmet))
				if(!user.temporarilyRemoveItemFromInventory(W))
					return
				to_chat(user, span_notice("You add [W] to [src]."))
				qdel(W)
				name = "covered and shielded frame assembly"
				item_state = "ed209_hat"
				icon_state = "ed209_hat"
				build_step++

		if(5)
			if(isprox(W))
				if(!user.temporarilyRemoveItemFromInventory(W))
					return
				build_step++
				to_chat(user, span_notice("You add [W] to [src]."))
				qdel(W)
				name = "covered, shielded and sensored frame assembly"
				item_state = "ed209_prox"
				icon_state = "ed209_prox"

		if(6)
			if(istype(W, /obj/item/stack/cable_coil))
				var/obj/item/stack/cable_coil/coil = W
				if(coil.get_amount() < 1)
					to_chat(user, span_warning("You need one length of cable to wire the ED-209!"))
					return
				to_chat(user, span_notice("You start to wire [src]..."))
				if(do_after(user, 40, target = src))
					if(coil.get_amount() >= 1 && build_step == 6)
						coil.use(1)
						to_chat(user, span_notice("You wire [src]."))
						name = "wired ED-209 assembly"
						build_step++

		if(7)
			if(istype(W, /obj/item/gun/energy/disabler))
				if(!user.temporarilyRemoveItemFromInventory(W))
					return
				name = "[W.name] ED-209 assembly"
				to_chat(user, span_notice("You add [W] to [src]."))
				item_state = "ed209_taser"
				icon_state = "ed209_taser"
				qdel(W)
				build_step++

		if(8)
			if(W.tool_behaviour == TOOL_SCREWDRIVER)
				to_chat(user, span_notice("You start attaching the gun to the frame..."))
				if(W.use_tool(src, user, 40, volume=100))
					var/mob/living/simple_animal/bot/secbot/ed209/B = new(drop_location())
					B.name = created_name
					to_chat(user, span_notice("You complete the ED-209."))
					qdel(src)

//Floorbot assemblies
/obj/item/bot_assembly/floorbot
	desc = "It's a toolbox with tiles sticking out the top."
	name = "tiles and toolbox"
	icon_state = "toolbox_tiles"
	throwforce = 10
	created_name = "Floorbot"
	var/toolbox = /obj/item/storage/toolbox/mechanical
	var/toolbox_color = "" //Blank for blue, r for red, y for yellow, etc.

/obj/item/bot_assembly/floorbot/Initialize()
	. = ..()
	update_appearance()

/obj/item/bot_assembly/floorbot/update_name()
	. = ..()
	switch(build_step)
		if(ASSEMBLY_SECOND_STEP)
			name = "incomplete floorbot assembly"
		else
			name = initial(name)

/obj/item/bot_assembly/floorbot/update_desc()
	. = ..()
	switch(build_step)
		if(ASSEMBLY_SECOND_STEP)
			desc = "It's a toolbox with tiles sticking out the top and a sensor attached."
		else
			desc = initial(desc)

/obj/item/bot_assembly/floorbot/update_icon_state()
	. = ..()
	switch(build_step)
		if(ASSEMBLY_FIRST_STEP)
			icon_state = "[toolbox_color]toolbox_tiles"
		if(ASSEMBLY_SECOND_STEP)
			icon_state = "[toolbox_color]toolbox_tiles_sensor"

/obj/item/bot_assembly/floorbot/attackby(obj/item/W, mob/user, params)
	..()
	switch(build_step)
		if(ASSEMBLY_FIRST_STEP)
			if(isprox(W))
				if(!user.temporarilyRemoveItemFromInventory(W))
					return
				to_chat(user, span_notice("You add [W] to [src]."))
				qdel(W)
				build_step++
				update_appearance()

		if(ASSEMBLY_SECOND_STEP)
			if(istype(W, /obj/item/bodypart/l_arm/robot) || istype(W, /obj/item/bodypart/r_arm/robot))
				if(!can_finish_build(W, user))
					return
				var/mob/living/simple_animal/bot/floorbot/A = new(drop_location(), toolbox_color)
				A.name = created_name
				A.robot_arm = W.type
				A.toolbox = toolbox
				to_chat(user, span_notice("You add [W] to [src]. Boop beep!"))
				qdel(W)
				qdel(src)


//Medbot Assembly
/obj/item/bot_assembly/medbot
	name = "incomplete medibot assembly"
	desc = "A first aid kit with a robot arm permanently grafted to it."
	icon_state = "firstaid_arm"
	created_name = "Medibot" //To preserve the name if it's a unique medbot I guess
	var/skin = null //Same as medbot, set to tox or ointment for the respective kits.
	var/healthanalyzer = /obj/item/healthanalyzer
	var/firstaid = /obj/item/storage/firstaid

/obj/item/bot_assembly/medbot/proc/set_skin(skin)
	src.skin = skin
	if(skin)
		add_overlay("kit_skin_[skin]")

/obj/item/bot_assembly/medbot/attackby(obj/item/W, mob/user, params)
	..()
	switch(build_step)
		if(ASSEMBLY_FIRST_STEP)
			if(istype(W, /obj/item/healthanalyzer))
				if(!user.temporarilyRemoveItemFromInventory(W))
					return
				healthanalyzer = W.type
				to_chat(user, span_notice("You add [W] to [src]."))
				qdel(W)
				name = "first aid/robot arm/health analyzer assembly"
				add_overlay("na_scanner")
				build_step++

		if(ASSEMBLY_SECOND_STEP)
			if(isprox(W))
				if(!can_finish_build(W, user))
					return
				qdel(W)
				var/mob/living/simple_animal/bot/medbot/S = new(drop_location(), skin)
				to_chat(user, span_notice("You complete the Medbot. Beep boop!"))
				S.name = created_name
				S.firstaid = firstaid
				S.robot_arm = robot_arm
				S.healthanalyzer = healthanalyzer
				qdel(src)

//Secbot Assembly
/obj/item/bot_assembly/secbot
	name = "incomplete securitron assembly"
	desc = "Some sort of bizarre assembly made from a proximity sensor, helmet, and signaler."
	icon_state = "helmet_signaler"
	item_state = "helmet"
	created_name = "Securitron" //To preserve the name if it's a unique securitron I guess
	var/swordamt = 0 //If you're converting it into a grievousbot, how many swords have you attached
	var/toyswordamt = 0 //honk

/obj/item/bot_assembly/secbot/attackby(obj/item/I, mob/user, params)
	..()
	var/atom/Tsec = drop_location()
	switch(build_step)
		if(ASSEMBLY_FIRST_STEP)
			if(I.tool_behaviour == TOOL_WELDER)
				if(I.use_tool(src, user, 0, volume=40))
					add_overlay("hs_hole")
					to_chat(user, span_notice("You weld a hole in [src]!"))
					build_step++

			else if(I.tool_behaviour == TOOL_SCREWDRIVER) //deconstruct
				new /obj/item/assembly/signaler(Tsec)
				new /obj/item/clothing/head/helmet/m10(Tsec)
				to_chat(user, span_notice("You disconnect the signaler from the helmet."))
				qdel(src)

		if(ASSEMBLY_SECOND_STEP)
			if(isprox(I))
				if(!user.temporarilyRemoveItemFromInventory(I))
					return
				to_chat(user, span_notice("You add [I] to [src]!"))
				add_overlay("hs_eye")
				name = "helmet/signaler/prox sensor assembly"
				qdel(I)
				build_step++

			else if(I.tool_behaviour == TOOL_WELDER) //deconstruct
				if(I.use_tool(src, user, 0, volume=40))
					cut_overlay("hs_hole")
					to_chat(user, span_notice("You weld the hole in [src] shut!"))
					build_step--

		if(ASSEMBLY_THIRD_STEP)
			if((istype(I, /obj/item/bodypart/l_arm/robot)) || (istype(I, /obj/item/bodypart/r_arm/robot)))
				if(!user.temporarilyRemoveItemFromInventory(I))
					return
				to_chat(user, span_notice("You add [I] to [src]!"))
				name = "helmet/signaler/prox sensor/robot arm assembly"
				add_overlay("hs_arm")
				robot_arm = I.type
				qdel(I)
				build_step++

			else if(I.tool_behaviour == TOOL_SCREWDRIVER) //deconstruct
				cut_overlay("hs_eye")
				new /obj/item/assembly/prox_sensor(Tsec)
				to_chat(user, span_notice("You detach the proximity sensor from [src]."))
				build_step--

		if(ASSEMBLY_FOURTH_STEP)
			if(istype(I, /obj/item/melee/baton))
				if(!can_finish_build(I, user))
					return
				to_chat(user, span_notice("You complete the Securitron! Beep boop."))
				var/mob/living/simple_animal/bot/secbot/S = new(Tsec)
				S.name = created_name
				S.baton_type = I.type
				S.robot_arm = robot_arm
				qdel(I)
				qdel(src)
			if(I.tool_behaviour == TOOL_WRENCH)
				to_chat(user, span_notice("You adjust [src]'s arm slots to mount extra weapons."))
				build_step ++
				return
			if(istype(I, /obj/item/toy/sword))
				if(toyswordamt < 3 && swordamt <= 0)
					if(!user.temporarilyRemoveItemFromInventory(I))
						return
					created_name = "General Beepsky"
					name = "helmet/signaler/prox sensor/robot arm/toy sword assembly"
					icon_state = "grievous_assembly"
					to_chat(user, span_notice("You superglue [I] onto one of [src]'s arm slots."))
					qdel(I)
					toyswordamt ++
				else
					if(!can_finish_build(I, user))
						return
					to_chat(user, span_notice("You complete the Securitron!...Something seems a bit wrong with it..?"))
					var/mob/living/simple_animal/bot/secbot/grievous/toy/S = new(Tsec)
					S.name = created_name
					S.robot_arm = robot_arm
					qdel(I)
					qdel(src)

			else if(I.tool_behaviour == TOOL_SCREWDRIVER) //deconstruct
				cut_overlay("hs_arm")
				var/obj/item/bodypart/dropped_arm = new robot_arm(Tsec)
				robot_arm = null
				to_chat(user, span_notice("You remove [dropped_arm] from [src]."))
				build_step--
				if(toyswordamt > 0 || toyswordamt)
					toyswordamt = 0
					icon_state = initial(icon_state)
					to_chat(user, span_notice("The superglue binding [src]'s toy swords to its chassis snaps!"))
					for(var/IS in 1 to toyswordamt)
						new /obj/item/toy/sword(Tsec)

		if(ASSEMBLY_FIFTH_STEP)
			if(istype(I, /obj/item/melee/energy/sword/saber))
				if(swordamt < 3)
					if(!user.temporarilyRemoveItemFromInventory(I))
						return
					created_name = "General Beepsky"
					name = "helmet/signaler/prox sensor/robot arm/energy sword assembly"
					icon_state = "grievous_assembly"
					to_chat(user, span_notice("You bolt [I] onto one of [src]'s arm slots."))
					qdel(I)
					swordamt ++
				else
					if(!can_finish_build(I, user))
						return
					to_chat(user, span_notice("You complete the Securitron!...Something seems a bit wrong with it..?"))
					var/mob/living/simple_animal/bot/secbot/grievous/S = new(Tsec)
					S.name = created_name
					S.robot_arm = robot_arm
					qdel(I)
					qdel(src)
			else if(I.tool_behaviour == TOOL_SCREWDRIVER) //deconstruct
				build_step--
				swordamt = 0
				icon_state = initial(icon_state)
				to_chat(user, span_notice("You unbolt [src]'s energy swords."))
				for(var/IS in 1 to swordamt)
					new /obj/item/melee/energy/sword/saber(Tsec)


//Firebot Assembly
/obj/item/bot_assembly/firebot
	name = "incomplete firebot assembly"
	desc = "A fire extinguisher with an arm attached to it."
	icon_state = "firebot_arm"
	created_name = "Firebot"

/obj/item/bot_assembly/firebot/attackby(obj/item/I, mob/user, params)
	..()
	switch(build_step)
		if(ASSEMBLY_FIRST_STEP)
			if(istype(I, /obj/item/clothing/head/hardhat/red))
				if(!user.temporarilyRemoveItemFromInventory(I))
					return
				to_chat(user,span_notice("You add the [I] to [src]!"))
				icon_state = "firebot_helmet"
				desc = "An incomplete firebot assembly with a fire helmet."
				qdel(I)
				build_step++

		if(ASSEMBLY_SECOND_STEP)
			if(isprox(I))
				if(!can_finish_build(I, user))
					return
				to_chat(user, span_notice("You add the [I] to [src]! Beep Boop!"))
				var/mob/living/simple_animal/bot/firebot/F = new(drop_location())
				F.name = created_name
				qdel(I)
				qdel(src)

//Get cleaned
/obj/item/bot_assembly/hygienebot
	name = "incomplete hygienebot assembly"
	desc = "Clear out the swamp once and for all"
	icon = 'icons/obj/watercloset.dmi'
	icon_state = "drone"
	created_name = "Hygienebot"

/obj/item/bot_assembly/hygienebot/attackby(obj/item/I, mob/user, params)
	. = ..()
	switch(build_step)
		if(ASSEMBLY_FIRST_STEP)
			if(I.tool_behaviour == TOOL_WELDER)
				if(I.use_tool(src, user, 0, volume=40))
					add_overlay("hs_hole")
					to_chat(user, span_notice("You weld a water hole in [src]!"))
					build_step++
					return

		//WS Start -- hygienebot construction fix (Issue #301)
		if(ASSEMBLY_SECOND_STEP)
			if(istype(I, /obj/item/stack/ducts))
				var/obj/item/stack/ducts/D = I
				if(D.get_amount() < 1)
					to_chat(user, span_warning("You need one fluid duct to finish [src]"))
					return
				to_chat(user, span_notice("You start to pipe up [src]..."))
				if(do_after(user, 40, target = src))
					if(D.get_amount() >= 1)
						D.use(1)
						to_chat(user, span_notice("You pipe up [src]."))
						build_step++
						var/mob/living/simple_animal/bot/hygienebot/H = new(drop_location())
						H.name = created_name
						qdel(src)
						return TRUE
		//WS end
