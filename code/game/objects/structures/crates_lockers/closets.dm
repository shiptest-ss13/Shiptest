/obj/structure/closet
	name = "closet"
	desc = "It's a basic storage unit."
	icon = 'icons/obj/closet.dmi'
	icon_state = "generic"
	density = TRUE
	drag_slowdown = 1.5		// Same as a prone mob
	max_integrity = 200
	integrity_failure = 0.25
	obj_flags = parent_type::obj_flags | ELEVATED_SURFACE
	armor = list("melee" = 20, "bullet" = 10, "laser" = 10, "energy" = 0, "bomb" = 10, "bio" = 0, "rad" = 0, "fire" = 70, "acid" = 60)

	var/icon_door = null
	var/icon_door_override = FALSE //override to have open overlay use icon different to its base's
	var/secure = FALSE //secure locker or not, also used if overriding a non-secure locker with a secure door overlay to add fancy lights
	var/opened = FALSE
	var/welded = FALSE
	var/locked = FALSE
	var/large = TRUE
	var/wall_mounted = 0 //never solid (You can always pass over it)
	var/breakout_time = 1200
	var/message_cooldown
	var/can_weld_shut = TRUE
	var/horizontal = FALSE
	var/allow_objects = FALSE
	var/allow_dense = FALSE
	var/dense_when_open = FALSE //if it's dense when open or not
	var/max_mob_size = MOB_SIZE_HUMAN //Biggest mob_size accepted by the container
	var/mob_storage_capacity = 3 // how many human sized mob/living can fit together inside a closet.
	var/storage_capacity = 30 //This is so that someone can't pack hundreds of items in a locker/crate then open it in a populated area to crash clients.
	// defaults to welder if null
	var/cutting_tool = TOOL_WELDER
	var/open_sound = 'sound/machines/closet_open.ogg'
	var/close_sound = 'sound/machines/closet_close.ogg'
	var/open_sound_volume = 35
	var/close_sound_volume = 50
	var/material_drop = /obj/item/stack/sheet/metal
	var/material_drop_amount = 2
	var/delivery_icon = "deliverycloset" //which icon to use when packagewrapped. null to be unwrappable.
	var/anchorable = TRUE
	var/icon_welded = "welded"
	/// Whether or not to populate items roundstart
	var/populate = TRUE


/obj/structure/closet/Initialize(mapload)
	. = ..()

	// if closed, any item at the crate's loc is put in the contents
	if (mapload && !opened)
		. = INITIALIZE_HINT_LATELOAD

	update_appearance()
	if(populate)
		PopulateContents()

	RegisterSignal(src, COMSIG_ATOM_CANREACH, PROC_REF(canreach_react))

/obj/structure/closet/LateInitialize()
	take_contents(src)
	return ..()

/obj/structure/closet/proc/canreach_react(datum/source, list/next)
	return COMPONENT_BLOCK_REACH //closed block, open have nothing inside.

//USE THIS TO FILL IT, NOT INITIALIZE OR NEW
/obj/structure/closet/proc/PopulateContents()
	return

/obj/structure/closet/Destroy()
	if(istype(loc, /obj/structure/bigDelivery))
		var/obj/structure/bigDelivery/wrap = loc
		qdel(wrap)
	dump_contents()
	return ..()

/obj/structure/closet/update_appearance(updates=ALL)
	. = ..()
	if(opened || broken || !secure)
		luminosity = 0
		return
	luminosity = 1

/obj/structure/closet/update_icon()
	. = ..()
	if (istype(src, /obj/structure/closet/supplypod))
		return

	layer = opened ? BELOW_OBJ_LAYER : OBJ_LAYER

/obj/structure/closet/update_overlays()
	. = ..()
	closet_update_overlays(.)

/obj/structure/closet/proc/closet_update_overlays(list/new_overlays)
	. = new_overlays
	if(opened)
		. += "[icon_door_override ? icon_door : icon_state]_open"
		return

	. += "[icon_door || icon_state]_door"
	if(welded)
		. += icon_welded

	if(broken || !secure)
		return
	//Overlay is similar enough for both that we can use the same mask for both
	SSvis_overlays.add_vis_overlay(src, icon, "locked", EMISSIVE_LAYER, EMISSIVE_PLANE, dir, alpha)
	. += locked ? "locked" : "unlocked"

/obj/structure/closet/examine(mob/user)
	. = ..()
	if(welded)
		. += span_notice("It's welded shut.")
	if(anchored)
		. += span_notice("It is <b>bolted</b> to the ground.")
	if(opened)
		. += span_notice("The parts are <b>welded</b> together.")
	else if(secure && !opened)
		. += span_notice("Right-click to [locked ? "unlock" : "lock"].")

/obj/structure/closet/CanAllowThrough(atom/movable/mover, border_dir)
	. = ..()
	if(wall_mounted)
		return TRUE

/obj/structure/closet/proc/can_open(mob/living/user, force = FALSE)
	if(force)
		return TRUE
	if(welded || locked)
		return FALSE
	var/turf/T = get_turf(src)
	for(var/mob/living/L in T)
		if(L.anchored || horizontal && L.mob_size > MOB_SIZE_TINY && L.density)
			if(user)
				to_chat(user, span_danger("There's something large on top of [src], preventing it from opening.") )
			return FALSE
	return TRUE

/obj/structure/closet/proc/can_close(mob/living/user)
	var/turf/T = get_turf(src)
	for(var/obj/structure/closet/closet in T)
		if(closet != src && !closet.wall_mounted)
			return FALSE
	for(var/mob/living/L in T)
		if(L.anchored || horizontal && L.mob_size > MOB_SIZE_TINY && L.density)
			if(user)
				to_chat(user, span_danger("There's something too large in [src], preventing it from closing."))
			return FALSE
	return TRUE

/obj/structure/closet/dump_contents()
	if(!isturf(loc))
		return
	var/atom/L = drop_location()
	for(var/atom/movable/AM as anything in src)
		AM.forceMove(L)
		if(throwing) // you keep some momentum when getting out of a thrown closet
			step(AM, dir)
	if(throwing)
		throwing.finalize(FALSE)

/obj/structure/closet/proc/take_contents(atom/movable/holder)
	var/atom/L = holder.drop_location()
	for(var/atom/movable/AM in L)
		if(istype(AM, /obj/effect))	//WS edit, closets and crates do not eat your lamp
			continue
		if(AM != src && insert(AM) == -1) // limit reached
			break

/obj/structure/closet/proc/open(mob/living/user, force = FALSE)
	if(!can_open(user, force))
		return
	if(opened)
		return
	welded = FALSE
	locked = FALSE
	playsound(loc, open_sound, open_sound_volume, TRUE, -3)
	opened = TRUE
	if(!dense_when_open)
		density = FALSE
	climb_time *= 0.5 //it's faster to climb onto an open thing
	dump_contents()
	update_appearance()
	return TRUE

/obj/structure/closet/proc/insert(atom/movable/AM)
	if(contents.len >= storage_capacity)
		return -1
	if(insertion_allowed(AM))
		AM.forceMove(src)
		return TRUE
	else
		return FALSE

/obj/structure/closet/proc/insertion_allowed(atom/movable/AM)
	if(ismob(AM))
		if(!isliving(AM)) //let's not put ghosts or camera mobs inside closets...
			return FALSE
		var/mob/living/L = AM
		if(L.anchored || L.buckled || L.incorporeal_move || L.has_buckled_mobs())
			return FALSE
		if(L.mob_size > MOB_SIZE_TINY) // Tiny mobs are treated as items.
			if(horizontal && L.density)
				return FALSE
			if(L.mob_size > max_mob_size)
				return FALSE
			var/mobs_stored = 0
			for(var/mob/living/M in contents)
				if(++mobs_stored >= mob_storage_capacity)
					return FALSE
		L.stop_pulling()

	else if(istype(AM, /obj/structure/closet))
		return FALSE
	else if(isobj(AM))
		if((!allow_dense && AM.density) || AM.anchored || AM.has_buckled_mobs())
			return FALSE
		else if(isitem(AM) && !HAS_TRAIT(AM, TRAIT_NODROP))
			return TRUE
		else if(!allow_objects && !istype(AM, /obj/effect/dummy/chameleon))
			return FALSE
	else
		return FALSE

	return TRUE

/obj/structure/closet/proc/close(mob/living/user)
	if(!opened || !can_close(user))
		return FALSE
	take_contents(src)
	playsound(loc, close_sound, close_sound_volume, TRUE, -3)
	climb_time = initial(climb_time)
	opened = FALSE
	density = TRUE
	update_appearance()
	return TRUE

/obj/structure/closet/proc/toggle(mob/living/user)
	if(opened)
		return close(user)
	else
		return open(user)

/obj/structure/closet/deconstruct(disassembled = TRUE)
	if(ispath(material_drop) && material_drop_amount && !(flags_1 & NODECONSTRUCT_1))
		new material_drop(loc, material_drop_amount)
	qdel(src)

/obj/structure/closet/atom_break(damage_flag)
	if(!broken && !(flags_1 & NODECONSTRUCT_1))
		bust_open()
	. = ..()

/obj/structure/closet/attackby(obj/item/attacking_item, mob/user, params)
	if(user in src)
		return
	if(user.a_intent == INTENT_HARM)
		return ..()
	if(attacking_item.GetID()) //if you're hitting with an id item, toggle the lock
		togglelock(user)
		return TRUE
	if(opened && user.transferItemToLoc(attacking_item, drop_location())) //try to transfer the held item to it
		return TRUE
	else
		return ..()

/obj/structure/closet/proc/try_deconstruct(obj/item/tool, mob/user)
	if(!tool.tool_start_check(user, src, amount = 0))
		return
	to_chat(user, span_notice("You begin cutting \the [src] apart..."))
	if(tool.use_tool(src, user, 40, volume = 50))
		user.visible_message(
			span_notice("[user] slices apart \the [src]."),
			span_notice("You cut \the [src] apart with \the [tool]."),
			span_hear("You hear welding."),
		)
		deconstruct(TRUE)
	return TRUE

/obj/structure/closet/welder_act(mob/living/user, obj/item/tool, modifiers)
	if(user.a_intent == INTENT_HARM)
		return FALSE
	if(!tool.tool_start_check(user, amount=0))
		return FALSE
	if(opened && !(flags_1 & NODECONSTRUCT_1))
		if(tool.tool_behaviour != cutting_tool)
			return FALSE // the wrong tool
		to_chat(user, span_notice("You begin cutting \the [src] apart..."))
		if(tool.use_tool(src, user, 4 SECONDS, volume=50))
			if(!opened)
				return TRUE
			user.visible_message(span_notice("[user] slices apart \the [src]."),
				span_notice("You cut \the [src] apart with \the [tool]."),
				span_italics("You hear welding."))
			deconstruct(TRUE)
		return TRUE
	if(can_weld_shut)
		to_chat(user, span_notice("You begin [welded ? "unwelding":"welding"] \the [src]..."))
		if(tool.use_tool(src, user, 4 SECONDS, volume=50))
			if(opened)
				return TRUE
			welded = !welded
			after_weld(welded)
			user.visible_message(span_notice("[user] [welded ? "welds shut" : "unwelded"] \the [src]."),
				span_notice("You [welded ? "weld" : "unwelded"] \the [src] with \the [tool]."),
				span_italics("You hear welding."))
			update_appearance()
		return TRUE
	return FALSE

/obj/structure/closet/wirecutter_act(mob/living/user, obj/item/tool, modifiers)
	if(user.a_intent == INTENT_HARM)
		return FALSE
	if(tool.tool_behaviour != cutting_tool)
		return FALSE
	user.visible_message(span_notice("[user] cut apart \the [src]."), \
		span_notice("You cut \the [src] apart with \the [tool]."))
	deconstruct(TRUE)
	return TRUE

/obj/structure/closet/wrench_act(mob/living/user, obj/item/tool, modifiers)
	if(user.a_intent == INTENT_HARM)
		return FALSE
	if(!anchorable)
		return FALSE
	if(isinspace() && !anchored)
		return FALSE
	set_anchored(!anchored)
	tool.play_tool_sound(src, 75)
	user.visible_message(span_notice("[user] [anchored ? "anchored" : "unanchored"] \the [src] [anchored ? "to" : "from"] the ground."), \
		span_notice("You [anchored ? "anchored" : "unanchored"] \the [src] [anchored ? "to" : "from"] the ground."), \
		span_italics("You hear a ratchet."))
	return TRUE

/obj/structure/closet/tool_act(mob/living/user, obj/item/tool, tool_type, params)
	if(user in src)
		return FALSE
	var/list/modifiers = params2list(params)
	if(opened && !LAZYACCESS(modifiers, RIGHT_CLICK) && user.transferItemToLoc(tool, drop_location()))
		return TRUE
	return ..()

/obj/structure/closet/deconstruct_act(mob/living/user, obj/item/tool)
	if(..())
		return TRUE
	if(locked)
		user.visible_message(
			span_warning("[user] is cutting \the [src] open!)"),
			span_notice("You begin to cut \the [src] open."),
		)
		if (tool.use_tool(src, user, 10 SECONDS, volume=0))
			bust_open()
			user.visible_message(
				span_warning("[user] busted \the [src] open!"),
				span_notice("You finish cutting \the [src] open."),
			)
	else
		try_deconstruct(tool, user)
	return TRUE

/obj/structure/closet/proc/after_weld(weld_state)
	return

/obj/structure/closet/MouseDrop_T(atom/movable/O, mob/living/user)
	if(!istype(O) || O.anchored || istype(O, /atom/movable/screen))
		return
	if(!istype(user) || user.incapacitated() || user.body_position == LYING_DOWN)
		return
	if(!Adjacent(user) || !user.Adjacent(O))
		return
	if(user == O) //try to climb onto it
		return ..()
	if(!opened)
		return
	if(!isturf(O.loc))
		return

	var/actuallyismob = 0
	if(isliving(O))
		actuallyismob = 1
	else if(!isitem(O))
		return
	var/turf/T = get_turf(src)
	var/list/targets = list(O, src)
	add_fingerprint(user)
	user.visible_message(
		span_warning("[user] [actuallyismob ? "tries to ":""]stuff [O] into [src]."), \
		span_warning("You [actuallyismob ? "try to ":""]stuff [O] into [src]."), \
		span_hear("You hear clanging."))
	if(actuallyismob)
		if(do_after(user, 40, targets))
			user.visible_message(
				span_notice("[user] stuffs [O] into [src]."), \
				span_notice("You stuff [O] into [src]."), \
				span_hear("You hear a loud metal bang."))
			var/mob/living/L = O
			if(!issilicon(L))
				L.Paralyze(40)
			if(istype(src, /obj/structure/closet/supplypod/extractionpod))
				O.forceMove(src)
			else
				O.forceMove(T)
				close()
			O.forceMove(T)
			close()
	else
		O.forceMove(T)
	return 1

/obj/structure/closet/relaymove(mob/living/user, direction)
	if(user.stat || !isturf(loc))
		return
	if(locked)
		if(message_cooldown <= world.time)
			message_cooldown = world.time + 50
			to_chat(user, span_warning("[src]'s door won't budge!"))
		return
	container_resist_act(user)


/obj/structure/closet/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	if(user.body_position == LYING_DOWN && get_dist(src, user) > 0)
		return

	if(!toggle(user))
		togglelock(user)

/obj/structure/closet/attack_hand_secondary(mob/user, modifiers)
	if(!opened && secure)
		togglelock(user)
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/structure/closet/attackby_secondary(obj/item/weapon, mob/user, params)
	if(!opened && secure)
		togglelock(user)
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/structure/closet/attack_paw(mob/user)
	return attack_hand(user)

/obj/structure/closet/attack_robot(mob/user)
	if(user.Adjacent(src))
		return attack_hand(user)

// tk grab then use on self
/obj/structure/closet/attack_self_tk(mob/user)
	return attack_hand(user)

/obj/structure/closet/verb/verb_toggleopen()
	set src in view(1)
	set category = "Object"
	set name = "Toggle Open"

	if(!usr.canUseTopic(src, BE_CLOSE) || !isturf(loc))
		return

	if(iscarbon(usr) || issilicon(usr) || isdrone(usr))
		return toggle(usr)
	else
		to_chat(usr, span_warning("This mob type can't use this verb."))

// Objects that try to exit a locker by stepping were doing so successfully,
// and due to an oversight in turf/Enter() were going through walls.  That
// should be independently resolved, but this is also an interesting twist.
/obj/structure/closet/Exit(atom/movable/AM)
	open()
	if(AM.loc == src)
		return 0
	return 1

/obj/structure/closet/container_resist_act(mob/living/user)
	if(opened)
		return
	if(ismovable(loc))
		user.changeNext_move(CLICK_CD_BREAKOUT)
		user.last_special = world.time + CLICK_CD_BREAKOUT
		var/atom/movable/AM = loc
		AM.relay_container_resist_act(user, src)
		return
	if(!welded && !locked)
		open()
		return

	//okay, so the closet is either welded or locked... resist!!!
	user.changeNext_move(CLICK_CD_BREAKOUT)
	user.last_special = world.time + CLICK_CD_BREAKOUT
	user.visible_message(span_warning("[src] begins to shake violently!"), \
		span_notice("You lean on the back of [src] and start pushing the door open... (this will take about [DisplayTimeText(breakout_time)].)"), \
		span_hear("You hear banging from [src]."))
	if(do_after(user,(breakout_time), target = src))
		if(!user || user.stat != CONSCIOUS || user.loc != src || opened || (!locked && !welded))
			return
		//we check after a while whether there is a point of resisting anymore and whether the user is capable of resisting
		user.visible_message(span_danger("[user] successfully broke out of [src]!"),
							span_notice("You successfully break out of [src]!"))
		bust_open()
	else
		if(user.loc == src) //so we don't get the message if we resisted multiple times and succeeded.
			to_chat(user, span_warning("You fail to break out of [src]!"))

/obj/structure/closet/proc/bust_open()
	welded = FALSE //applies to all lockers
	locked = FALSE //applies to critter crates and secure lockers only
	broken = TRUE //applies to secure lockers only
	open()

/obj/structure/closet/proc/togglelock(mob/living/user, silent)
	if(secure && !broken)
		if(allowed(user))
			if(iscarbon(user))
				add_fingerprint(user)
			locked = !locked
			user.visible_message(span_notice("[user] [locked ? null : "un"]locks [src]."),
							span_notice("You [locked ? null : "un"]lock [src]."))
			update_appearance()
		else if(!silent)
			to_chat(user, span_alert("Access Denied."))
	else if(secure && broken)
		to_chat(user, span_warning("\The [src] is broken!"))

/obj/structure/closet/emag_act(mob/user)
	if(secure && !broken)
		if(user)
			user.visible_message(span_warning("Sparks fly from [src]!"),
							span_warning("You scramble [src]'s lock, breaking it open!"),
							span_hear("You hear a faint electrical spark."))
		playsound(src, "sparks", 50, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
		broken = TRUE
		locked = FALSE
		update_appearance()

/obj/structure/closet/get_remote_view_fullscreens(mob/user)
	if(user.stat == DEAD || !(user.sight & (SEEOBJS|SEEMOBS)))
		user.overlay_fullscreen("remote_view", /atom/movable/screen/fullscreen/impaired, 1)

/obj/structure/closet/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	if (!(. & EMP_PROTECT_CONTENTS))
		for(var/atom/movable/AM as anything in src)
			AM.emp_act(severity)
	if(secure && !broken && !(. & EMP_PROTECT_SELF))
		if(prob(50 / severity))
			locked = !locked
			update_appearance()
		if(prob(20 / severity) && !opened)
			if(!locked)
				open()

/obj/structure/closet/contents_explosion(severity, target)
	for(var/atom/A in contents)
		switch(severity)
			if(EXPLODE_DEVASTATE)
				SSexplosions.highobj += A
			if(EXPLODE_HEAVY)
				SSexplosions.medobj += A
			if(EXPLODE_LIGHT)
				SSexplosions.lowobj += A

/obj/structure/closet/singularity_act()
	dump_contents()
	..()

/obj/structure/closet/AllowDrop()
	return TRUE


/obj/structure/closet/return_temperature()
	return

/obj/structure/closet/proc/dive_into(mob/living/user)
	var/turf/T1 = get_turf(user)
	var/turf/T2 = get_turf(src)
	if(!opened)
		if(locked)
			togglelock(user, TRUE)
		if(!open(user))
			to_chat(user, span_warning("It won't budge!"))
			return
	step_towards(user, T2)
	T1 = get_turf(user)
	if(T1 == T2)
		user.set_resting(TRUE) //so people can jump into crates without slamming the lid on their head
		if(!close(user))
			to_chat(user, span_warning("You can't get [src] to close!"))
			user.set_resting(FALSE)
			return
		user.set_resting(FALSE)
		togglelock(user)
		T1.visible_message(span_warning("[user] dives into [src]!"))

/obj/structure/closet/on_object_saved(depth = 0)
	if(depth >= 10)
		return ""
	var/dat = ""
	for(var/obj/item in contents)
		var/metadata = generate_tgm_metadata(item)
		dat += "[dat ? ",\n" : ""][item.type][metadata]"
		//Save the contents of things inside the things inside us, EG saving the contents of bags inside lockers
		var/custom_data = item.on_object_saved(depth++)
		dat += "[custom_data ? ",\n[custom_data]" : ""]"
	return dat
