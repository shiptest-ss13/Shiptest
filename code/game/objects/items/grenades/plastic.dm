/obj/item/grenade/c4
	name = "C-4 charge"
	desc = "Used to put holes in specific areas without too much extra hole. A saboteur's favorite."
	icon_state = "plastic-explosive0"
	item_state = "plastic-explosive"
	lefthand_file = 'icons/mob/inhands/weapons/bombs_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/bombs_righthand.dmi'
	item_flags = NOBLUDGEON
	flags_1 = NONE
	det_time = 10
	display_timer = FALSE
	w_class = WEIGHT_CLASS_SMALL
	gender = PLURAL
	var/atom/target = null
	var/mutable_appearance/plastic_overlay
	var/directional = FALSE
	var/aim_dir = NORTH
	var/boom_sizes = list(0, 0, 3)
	var/full_damage_on_mobs = FALSE

/obj/item/grenade/c4/Initialize()
	. = ..()
	plastic_overlay = mutable_appearance(icon, "[item_state]2", HIGH_OBJ_LAYER)
	wires = new /datum/wires/explosive/c4(src)

/obj/item/grenade/c4/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/empprotection, EMP_PROTECT_WIRES)

/obj/item/grenade/c4/Destroy()
	QDEL_NULL(wires)
	target = null
	return ..()

/obj/item/grenade/c4/attackby(obj/item/I, mob/user, params)
	if(I.tool_behaviour == TOOL_SCREWDRIVER)
		to_chat(user, "<span class='notice'>The wire panel can be accessed without a screwdriver.</span>")
	else if(is_wire_tool(I))
		wires.interact(user)
	else
		return ..()

/obj/item/grenade/c4/prime()
	if(QDELETED(src))
		return

	. = ..()
	var/turf/location
	if(target)
		if(!QDELETED(target))
			location = get_turf(target)
			target.cut_overlay(plastic_overlay, TRUE)
			if(!ismob(target) || full_damage_on_mobs)
				target.ex_act(EXPLODE_HEAVY, target)
			if(iswallturf(target))
				var/turf/closed/wall/wall = target
				wall.dismantle_wall(TRUE)
	else
		location = get_turf(src)
	if(location)
		if(directional && target && target.density)
			var/turf/T = get_step(location, aim_dir)
			explosion(get_step(T, aim_dir), boom_sizes[1], boom_sizes[2], boom_sizes[3])
		else
			explosion(location, boom_sizes[1], boom_sizes[2], boom_sizes[3])
	resolve()

//assembly stuff
/obj/item/grenade/c4/receive_signal()
	if(!active)
		active = TRUE
		icon_state = "[item_state]2"
		balloon_alert_to_viewers("[src] begins ticking!")
		addtimer(CALLBACK(src, PROC_REF(prime)), det_time*10)
	return

/obj/item/grenade/c4/attack_self(mob/user)
	var/newtime = input(usr, "Please set the timer.", "Timer", 10) as num|null

	if (isnull(newtime))
		return

	if(user.get_active_held_item() == src)
		newtime = clamp(newtime, 10, 60000)
		det_time = newtime
		to_chat(user, "Timer set for [det_time] seconds.")

/obj/item/grenade/c4/afterattack(atom/movable/AM, mob/user, flag)
	. = ..()
	aim_dir = get_dir(user,AM)
	if(!flag)
		return

	to_chat(user, "<span class='notice'>You start planting [src]. The timer is set to [det_time]...</span>")

	if(do_after(user, 30, target = AM))
		if(!user.temporarilyRemoveItemFromInventory(src))
			return
		target = AM

		message_admins("[ADMIN_LOOKUPFLW(user)] planted [name] on [target.name] at [ADMIN_VERBOSEJMP(target)] with [det_time] second fuse")
		log_game("[key_name(user)] planted [name] on [target.name] at [AREACOORD(user)] with a [det_time] second fuse")

		notify_ghosts("[user] has planted \a [src] on [target] with a [det_time] second fuse!", source = target, action = NOTIFY_ORBIT, flashwindow = FALSE, header = "Explosive Planted")

		moveToNullspace()	//Yep

		if(istype(AM, /obj/item)) //your crappy throwing star can't fly so good with a giant brick of c4 on it.
			var/obj/item/I = AM
			I.throw_speed = max(1, (I.throw_speed - 3))
			I.throw_range = max(1, (I.throw_range - 3))
			if(I.embedding)
				I.embedding["embed_chance"] = 0
				I.updateEmbedding()
		else if(istype(AM, /mob/living))
			plastic_overlay.layer = FLOAT_LAYER

		target.add_overlay(plastic_overlay)
		to_chat(user, "<span class='notice'>You plant the bomb. Timer counting down from [det_time].</span>")
		addtimer(CALLBACK(src, PROC_REF(prime)), det_time*10)

// X4 is an upgraded directional variant of c4 which is relatively safe to be standing next to. And much less safe to be standing on the other side of.
// C4 is intended to be used for infiltration, and destroying tech. X4 is intended to be used for heavy breaching and tight spaces.
// Intended to replace C4 for nukeops, and to be a randomdrop in surplus/random traitor purchases.

/obj/item/grenade/c4/x4
	name = "X-4 charge"
	desc = "A shaped high-explosive breaching charge. Designed to ensure user safety and wall nonsafety."
	icon_state = "plasticx40"
	item_state = "plasticx4"
	directional = TRUE
	boom_sizes = list(0, 2, 5)


// x-com ufo defense high ex charge 1993
/obj/item/grenade/c4/satchel_charge
	name = "\improper satchel charge"
	desc = "Used to put craters into places without too much hassle. An engineer's favorite."
	w_class = WEIGHT_CLASS_NORMAL
	icon_state = "satchel_charge0"
	item_state = "satchel_charge"
	throw_range = 3
	lefthand_file = 'icons/mob/inhands/weapons/bombs_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/bombs_righthand.dmi'
	boom_sizes = list(0, 3, 5)
