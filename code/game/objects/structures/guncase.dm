//GUNCASES//
/obj/structure/guncloset
	name = "gun locker"
	desc = "A locker that holds guns."
	icon = 'icons/obj/closet.dmi'
	icon_state = "shotguncase"
	anchored = FALSE
	density = TRUE
	drag_slowdown = 1.5
	opacity = FALSE
	var/case_type = ""
	var/gun_category = /obj/item/gun
	var/open = TRUE
	var/capacity = 8

/obj/structure/guncloset/examine(mob/user)
	. = ..()
	. += span_notice("Alt-click to [open ? "close" : "open"] it.")

/obj/structure/guncloset/Initialize(mapload)
	. = ..()
	if(mapload)
		for(var/obj/item/I in loc.contents)
			if(istype(I, gun_category))
				I.forceMove(src)
			if(contents.len >= capacity)
				break
	update_appearance()

/obj/structure/guncloset/update_overlays()
	. = ..()
	if(case_type && LAZYLEN(contents))
		var/mutable_appearance/gun_overlay = mutable_appearance(icon, case_type)
		for(var/i in 1 to contents.len)
			gun_overlay.pixel_x = 3 * (i - 1)
			. += new /mutable_appearance(gun_overlay)
	. += "[icon_state]_[open ? "open" : "door"]"

/obj/structure/guncloset/attackby(obj/item/I, mob/user, params)
	if(iscyborg(user) || isalien(user))
		return
	if(istype(I, gun_category) && open)
		if(LAZYLEN(contents) < capacity)
			if(!user.transferItemToLoc(I, src))
				return
			to_chat(user, span_notice("You place [I] in [src]."))
			update_appearance()
		else
			to_chat(user, span_warning("[src] is full."))
		return
	else
		return ..()

/obj/structure/guncloset/tool_act(mob/living/user, obj/item/I)
	. = TRUE
	if (I.tool_behaviour == TOOL_WRENCH)
		if(isinspace() && !anchored)
			return
		set_anchored(!anchored)
		I.play_tool_sound(src, 75)
		user.visible_message(span_notice("[user] [anchored ? "anchored" : "unanchored"] \the [src] [anchored ? "to" : "from"] the ground."), \
				span_notice("You [anchored ? "anchored" : "unanchored"] \the [src] [anchored ? "to" : "from"] the ground."), \
				span_hear("You hear a ratchet.")
		)
		return
	else
		return FALSE

/obj/structure/guncloset/deconstruct_act(mob/living/user, obj/item/tool)
	if(..())
		return TRUE
	cut_apart(user, tool)
	return TRUE

/obj/structure/guncloset/welder_act(mob/living/user, obj/item/tool)
	if(..() || ((resistance_flags & INDESTRUCTIBLE)))
		return TRUE
	cut_apart(user, tool)
	return TRUE

/obj/structure/guncloset/proc/cut_apart(mob/living/user, obj/item/tool)
	if(contents.len)
		to_chat(user, span_danger("\The [src] is not empty!"))
		return
	to_chat(user, span_notice("You begin cutting \the [src] apart..."))
	if(!tool.use_tool(src, user, 40, volume=50))
		return
	user.visible_message(
		span_notice("[user] slices apart \the [src]."),
		span_notice("You cut \the [src] apart with \the [tool]."),
		span_hear("You hear cutting."),
	)
	deconstruct(TRUE)

/obj/structure/guncloset/deconstruct(disassembled = TRUE)
	if (disassembled)
		new /obj/item/stack/sheet/metal(loc, 10)
	for(var/obj/stuff in contents)
		stuff.forceMove(loc)

	SEND_SIGNAL(src, COMSIG_OBJ_DECONSTRUCT, disassembled)
	qdel(src)

/obj/structure/guncloset/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	if(iscyborg(user) || isalien(user))
		return
	if(contents.len && open)
		show_menu(user)
	else
		open = !open
		update_appearance()

/obj/structure/guncloset/attack_hand_secondary(mob/user, list/modifiers)
	open = !open
	update_appearance()
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/structure/guncloset/AltClick(mob/user)
	if(!user.canUseTopic(src, BE_CLOSE, NO_DEXTERITY))
		return FALSE
	open = !open
	update_appearance()
	return TRUE

/**
 * show_menu: Shows a radial menu to a user consisting of an available weaponry for taking
 *
 * Arguments:
 * * user The mob to which we are showing the radial menu
 */
/obj/structure/guncloset/proc/show_menu(mob/user)
	if(!LAZYLEN(contents))
		return

	var/list/display_names = list()
	var/list/items = list()
	for(var/i in 1 to length(contents))
		var/obj/item/thing = contents[i]
		display_names["[thing.name] ([i])"] = REF(thing)
		var/image/item_image = image(icon = thing.icon, icon_state = thing.icon_state)
		if(length(thing.overlays))
			item_image.copy_overlays(thing)
		items += list("[thing.name] ([i])" = item_image)

	var/pick = show_radial_menu(user, src, items, custom_check = CALLBACK(src, PROC_REF(check_menu), user), radius = 36, require_near = TRUE)
	if(!pick)
		return

	var/weapon_reference = display_names[pick]
	var/obj/item/weapon = locate(weapon_reference) in contents
	if(!istype(weapon))
		return
	if(!user.put_in_hands(weapon))
		weapon.forceMove(get_turf(src))
	update_appearance()

/**
 * check_menu: Checks if we are allowed to interact with a radial menu
 *
 * Arguments:
 * * user The mob interacting with a menu
 */
/obj/structure/guncloset/proc/check_menu(mob/living/carbon/human/user)
	if(!open)
		return FALSE
	if(!istype(user))
		return FALSE
	if(user.incapacitated())
		return FALSE
	return TRUE

/obj/structure/guncloset/handle_atom_del(atom/A)
	update_appearance()

/obj/structure/guncloset/contents_explosion(severity, target)
	for(var/atom/A in contents)
		switch(severity)
			if(EXPLODE_DEVASTATE)
				SSexplosions.highobj += A
			if(EXPLODE_HEAVY)
				SSexplosions.medobj += A
			if(EXPLODE_LIGHT)
				SSexplosions.lowobj += A

/obj/structure/guncloset/shotgun
	name = "shotgun locker"
	desc = "A locker that holds shotguns."
	case_type = "shotgun"
	gun_category = /obj/item/gun/ballistic/shotgun

/obj/structure/guncloset/ecase
	name = "energy gun locker"
	desc = "A locker that holds energy guns."
	icon_state = "ecase"
	case_type = "egun"
	gun_category = /obj/item/gun/energy/sharplite/x12
