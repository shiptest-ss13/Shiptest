#define ROD_SLOT_BAIT "bait"
#define ROD_SLOT_LINE "line"
#define ROD_SLOT_HOOK "hook"

/obj/item/fishing_rod
	name = "fishing rod"
	desc = "You can fish with this."
	icon = 'icons/obj/fishing.dmi'
	icon_state = "fishing_rod"
	lefthand_file = 'icons/mob/inhands/equipment/fishing_rod_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/fishing_rod_righthand.dmi'
	item_state = "rod"
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	force = 8
	w_class = WEIGHT_CLASS_HUGE

	/// How far can you cast this
	var/cast_range = 5
	/// Fishing minigame difficulty modifier (additive)
	var/difficulty_modifier = 0
	/// Explaination of rod functionality shown in the ui
	var/ui_description = "A classic fishing rod, with no special qualities."

	var/obj/item/bait
	var/obj/item/fishing_line/line
	var/obj/item/fishing_hook/hook

	/// Currently hooked item for item reeling
	var/obj/item/currently_hooked_item

	/// Fishing line visual for the hooked item
	var/datum/beam/hooked_item_fishing_line

	/// Are we currently casting
	var/casting = FALSE

	/// List of fishing line beams
	var/list/fishing_lines = list()

	var/default_line_color = "gray"


/obj/item/fishing_rod/Destroy(force)
	. = ..()
	//Remove any leftover fishing lines
	QDEL_LIST(fishing_lines)


/// Catch weight modifier for the given fish_type (or FISHING_DUD), additive
/obj/item/fishing_rod/proc/fish_bonus(fish_type)
	return 0

/obj/item/fishing_rod/proc/consume_bait(atom/movable/reward)
	if(bait)
		QDEL_NULL(bait)
		update_appearance()

/obj/item/fishing_rod/attack_self(mob/user)
	if(currently_hooked_item)
		reel(user)

/obj/item/fishing_rod/proc/reel(mob/user)
	//Could use sound here for feedback
	if(do_after(user, 1 SECONDS, currently_hooked_item))
		// Should probably respect and used force move later
		step_towards(currently_hooked_item, get_turf(src))
		if(get_dist(currently_hooked_item,get_turf(src)) < 1)
			clear_hooked_item()

/obj/item/fishing_rod/AltClick(mob/user)
	. = ..()
	ui_interact(user)

/obj/item/fishing_rod/pre_attack(atom/targeted_atom, mob/living/user, params)
	. = ..()
	/// Reel in if able
	if(currently_hooked_item)
		reel(user)
		return TRUE
	SEND_SIGNAL(targeted_atom, COMSIG_PRE_FISHING)

/// Generates the fishing line visual from the current user to the target and updates inhands
/obj/item/fishing_rod/proc/create_fishing_line(atom/movable/target, target_py = null)
	var/mob/user = loc
	if(!istype(user))
		return
	var/beam_color = line?.line_color || default_line_color
	var/datum/beam/fishing_line/fishing_line_beam = new(user, target, icon_state = "fishing_line", beam_color = beam_color, override_target_pixel_y = target_py)
	fishing_line_beam.lefthand = user.get_held_index_of_item(src) % 2 == 1
	RegisterSignal(fishing_line_beam, COMSIG_BEAM_BEFORE_DRAW, PROC_REF(check_los))
	RegisterSignal(fishing_line_beam, COMSIG_PARENT_QDELETING, PROC_REF(clear_line))
	fishing_lines += fishing_line_beam
	INVOKE_ASYNC(fishing_line_beam, TYPE_PROC_REF(/datum/beam, Start))
	user.update_inv_hands()
	return fishing_line_beam

/obj/item/fishing_rod/proc/clear_line(datum/source)
	SIGNAL_HANDLER
	fishing_lines -= source
	if(ismob(loc))
		var/mob/user = loc
		user.update_inv_hands()

/obj/item/fishing_rod/dropped(mob/user, silent)
	. = ..()
	if(currently_hooked_item)
		clear_hooked_item()
	for(var/datum/beam/fishing_line in fishing_lines)
		SEND_SIGNAL(fishing_line, COMSIG_FISHING_LINE_SNAPPED)
	QDEL_LIST(fishing_lines)

/// Hooks the item
/obj/item/fishing_rod/proc/hook_item(mob/user, atom/target_atom)
	if(currently_hooked_item)
		return
	if(!can_be_hooked(target_atom))
		return
	currently_hooked_item = target_atom
	hooked_item_fishing_line = create_fishing_line(target_atom)
	RegisterSignal(hooked_item_fishing_line, COMSIG_FISHING_LINE_SNAPPED, PROC_REF(clear_hooked_item))

/// Checks what can be hooked
/obj/item/fishing_rod/proc/can_be_hooked(atom/movable/target)
	// Could be made dependent on actual hook, ie magnet to hook metallic items
	return istype(target, /obj/item)

/obj/item/fishing_rod/proc/clear_hooked_item()
	SIGNAL_HANDLER

	if(!QDELETED(hooked_item_fishing_line))
		QDEL_NULL(hooked_item_fishing_line)
	currently_hooked_item = null

// Checks fishing line for interruptions and range
/obj/item/fishing_rod/proc/check_los(datum/beam/source)
	SIGNAL_HANDLER
	. = NONE

	if(!isturf(source.origin) || !isturf(source.target) || !CheckToolReach(src, source.target, cast_range))
		SEND_SIGNAL(source, COMSIG_FISHING_LINE_SNAPPED) //Stepped out of range or los interrupted
		return BEAM_CANCEL_DRAW

/obj/item/fishing_rod/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	. = ..()

	/// Reel in if able
	if(currently_hooked_item)
		reel(user)
		return

	/// If the line to whatever that is is clear and we're not already busy, try fishing in it
	if(!casting && !currently_hooked_item && !proximity_flag && CheckToolReach(user, target, cast_range))
		/// Annoyingly pre attack is only called in melee
		SEND_SIGNAL(target, COMSIG_PRE_FISHING)
		casting = TRUE
		var/obj/projectile/fishing_cast/cast_projectile = new(get_turf(src))
		cast_projectile.range = cast_range
		cast_projectile.owner = src
		cast_projectile.original = target
		cast_projectile.fired_from = src
		cast_projectile.firer = user
		LAZYSET(cast_projectile.impacted, user, TRUE)
		cast_projectile.preparePixelProjectile(target, user)
		cast_projectile.fire()

/// Called by hook projectile when hitting things
/obj/item/fishing_rod/proc/hook_hit(atom/atom_hit_by_hook_projectile)
	var/mob/user = loc
	if(!istype(user))
		return
	if(SEND_SIGNAL(atom_hit_by_hook_projectile, COMSIG_FISHING_ROD_CAST, src, user) & FISHING_ROD_CAST_HANDLED)
		return
	/// If you can't fish in it, try hooking it
	hook_item(user, atom_hit_by_hook_projectile)

/obj/item/fishing_rod/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "FishingRod", name)
		ui.set_autoupdate(FALSE)
		ui.open()

/obj/item/fishing_rod/update_overlays()
	. = ..()
	var/line_color = line?.line_color || default_line_color
	/// Line part by the rod, always visible
	var/mutable_appearance/reel_overlay = mutable_appearance(icon, "reel_overlay")
	reel_overlay.color = line_color;
	. += reel_overlay

	// Line & hook is also visible when only bait is equipped but it uses default appearances then
	if(hook || bait)
		var/mutable_appearance/line_overlay = mutable_appearance(icon, "line_overlay")
		line_overlay.color = line_color;
		. += line_overlay
		var/mutable_appearance/hook_overlay = mutable_appearance(icon, hook?.rod_overlay_icon_state || "hook_overlay")
		. += hook_overlay

	if(bait)
		var/bait_state = "worm_overlay" //default to worm overlay for anything without specific one
		if(istype(bait, /obj/item/food/bait))
			var/obj/item/food/bait/real_bait = bait
			bait_state = real_bait.rod_overlay_icon_state
		. += bait_state

/obj/item/fishing_rod/worn_overlays(mutable_appearance/standing, isinhands, icon_file)
	. = ..()
	var/line_color = line?.line_color || default_line_color
	var/mutable_appearance/reel_overlay = mutable_appearance(icon_file, "reel_overlay")
	reel_overlay.appearance_flags |= RESET_COLOR
	reel_overlay.color = line_color
	. += reel_overlay
	/// if we don't have anything hooked show the dangling hook & line
	if(isinhands && length(fishing_lines) == 0)
		var/mutable_appearance/line_overlay = mutable_appearance(icon_file, "line_overlay")
		line_overlay.appearance_flags |= RESET_COLOR
		line_overlay.color = line_color
		. += line_overlay
		. += mutable_appearance(icon_file, "hook_overlay")

/obj/item/fishing_rod/attackby(obj/item/attacking_item, mob/user, params)
	if(slot_check(attacking_item,ROD_SLOT_LINE))
		use_slot(ROD_SLOT_LINE, user, attacking_item)
		SStgui.update_uis(src)
		return TRUE
	else if(slot_check(attacking_item,ROD_SLOT_HOOK))
		use_slot(ROD_SLOT_HOOK, user, attacking_item)
		SStgui.update_uis(src)
		return TRUE
	else if(slot_check(attacking_item,ROD_SLOT_BAIT))
		use_slot(ROD_SLOT_BAIT, user, attacking_item)
		SStgui.update_uis(src)
		return TRUE
	else if(istype(attacking_item, /obj/item/bait_can)) //Quicker filling from bait can
		var/obj/item/bait_can/can = attacking_item
		var/bait = can.retrieve_bait(user)
		if(bait)
			use_slot(ROD_SLOT_BAIT, user, bait)
			SStgui.update_uis(src)
		return TRUE
	. = ..()

/obj/item/fishing_rod/ui_data(mob/user)
	. = ..()
	var/list/data = list()

	data["bait_name"] = format_text(bait?.name)
	data["bait_icon"] = bait != null ? icon2base64(icon(bait.icon, bait.icon_state)) : null

	data["line_name"] = format_text(line?.name)
	data["line_icon"] = line != null ? icon2base64(icon(line.icon, line.icon_state)) : null

	data["hook_name"] = format_text(hook?.name)
	data["hook_icon"] = hook != null ? icon2base64(icon(hook.icon, hook.icon_state)) : null

	data["description"] = ui_description

	return data

/// Checks if the item fits the slot
/obj/item/fishing_rod/proc/slot_check(obj/item/item,slot)
	if(!istype(item))
		return FALSE
	switch(slot)
		if(ROD_SLOT_HOOK)
			if(!istype(item,/obj/item/fishing_hook))
				return FALSE
		if(ROD_SLOT_LINE)
			if(!istype(item,/obj/item/fishing_line))
				return FALSE
		if(ROD_SLOT_BAIT)
			if(!HAS_TRAIT(item, FISHING_BAIT_TRAIT))
				return FALSE
	return TRUE

/obj/item/fishing_rod/ui_act(action, list/params)
	. = ..()
	if(.)
		return .
	var/mob/user = usr
	switch(action)
		if("slot_action")
			// Simple click with empty hand to remove, click with item to insert/switch
			var/obj/item/held_item = user.get_active_held_item()
			if(held_item == src)
				return
			use_slot(params["slot"], user, held_item)
			return TRUE

/// Ideally this will be replaced with generic slotted storage datum + display
/obj/item/fishing_rod/proc/use_slot(slot, mob/user, obj/item/new_item)
	var/obj/item/current_item
	switch(slot)
		if(ROD_SLOT_BAIT)
			current_item = bait
		if(ROD_SLOT_HOOK)
			current_item = hook
		if(ROD_SLOT_LINE)
			current_item = line
	if(!new_item && !current_item)
		return
	// Trying to remove the item
	if(!new_item && current_item)
		user.put_in_hands(current_item)
		update_appearance()
		return
	// Trying to insert item into empty slot
	if(new_item && !current_item)
		if(!slot_check(new_item, slot))
			return
		if(user.transferItemToLoc(new_item,src))
			switch(slot)
				if(ROD_SLOT_BAIT)
					bait = new_item
				if(ROD_SLOT_HOOK)
					hook = new_item
				if(ROD_SLOT_LINE)
					line = new_item
			update_appearance()
	/// Trying to swap item
	if(new_item && current_item)
		if(!slot_check(new_item,slot))
			return
		if(user.transferItemToLoc(new_item,src))
			switch(slot)
				if(ROD_SLOT_BAIT)
					bait = new_item
				if(ROD_SLOT_HOOK)
					hook = new_item
				if(ROD_SLOT_LINE)
					line = new_item
		user.put_in_hands(current_item)
		update_appearance()


/obj/item/fishing_rod/Exited(atom/movable/gone, direction)
	. = ..()
	if(gone == bait)
		bait = null
	if(gone == line)
		line = null
	if(gone == hook)
		hook = null

/obj/item/fishing_rod/master
	name = "master fishing rod"
	desc = "The mythical rod of a lost fisher king. Said to be imbued with un-paralleled fishing power. There's writing on the back of the pole. \"中国航天制造\""
	difficulty_modifier = -10
	ui_description = "This rods makes fishing easy even for an absolute beginner."
	icon_state = "fishing_rod_master"


/obj/item/fishing_rod/tech
	name = "advanced fishing rod"
	desc = "An embedded universal constructor along with micro-fusion generator makes this marvel of technology never run out of bait. Interstellar treaties prevent using it outside of recreational fishing. And you can fish with this. "
	ui_description = "This rod has an infinite supply of synthetic bait."
	icon_state = "fishing_rod_science"

/obj/item/fishing_rod/tech/Initialize(mapload)
	. = ..()
	var/obj/item/food/bait/doughball/synthetic/infinite_supply_of_bait = new(src)
	bait = infinite_supply_of_bait
	update_appearance()

/obj/item/fishing_rod/tech/consume_bait()
	return

/obj/item/fishing_rod/tech/use_slot(slot, mob/user, obj/item/new_item)
	if(slot == ROD_SLOT_BAIT)
		return
	return ..()

#undef ROD_SLOT_BAIT
#undef ROD_SLOT_LINE
#undef ROD_SLOT_HOOK

/obj/projectile/fishing_cast
	name = "fishing hook"
	icon = 'icons/obj/fishing.dmi'
	icon_state = "hook_projectile"
	damage = 0
	nodamage = TRUE
	range = 5
	suppressed =  SUPPRESSED_VERY
	can_hit_turfs = TRUE

	var/obj/item/fishing_rod/owner
	var/datum/beam/our_line

/obj/projectile/fishing_cast/Impact(atom/hit_atom)
	. = ..()
	owner.hook_hit(hit_atom)
	qdel(src)

/obj/projectile/fishing_cast/fire(angle, atom/direct_target)
	. = ..()
	our_line = owner.create_fishing_line(src)

/obj/projectile/fishing_cast/Destroy()
	. = ..()
	QDEL_NULL(our_line)
	owner?.casting = FALSE



/datum/beam/fishing_line
	// Is the fishing rod held in left side hand
	var/lefthand = FALSE

/datum/beam/fishing_line/Start()
	update_offsets(origin.dir)
	. = ..()
	RegisterSignal(origin, COMSIG_ATOM_DIR_CHANGE, PROC_REF(handle_dir_change))

/datum/beam/fishing_line/Destroy()
	UnregisterSignal(origin, COMSIG_ATOM_DIR_CHANGE)
	. = ..()

/datum/beam/fishing_line/proc/handle_dir_change(atom/movable/source, olddir, newdir)
	SIGNAL_HANDLER
	update_offsets(newdir)
	INVOKE_ASYNC(src, TYPE_PROC_REF(/datum/beam, redrawing))

/datum/beam/fishing_line/proc/update_offsets(user_dir)
	switch(user_dir)
		if(SOUTH)
			override_origin_pixel_x = lefthand ? lefthand_s_px : righthand_s_px
			override_origin_pixel_y = lefthand ? lefthand_s_py : righthand_s_py
		if(EAST)
			override_origin_pixel_x = lefthand ? lefthand_e_px : righthand_e_px
			override_origin_pixel_y = lefthand ? lefthand_e_py : righthand_e_py
		if(WEST)
			override_origin_pixel_x = lefthand ? lefthand_w_px : righthand_w_px
			override_origin_pixel_y = lefthand ? lefthand_w_py : righthand_w_py
		if(NORTH)
			override_origin_pixel_x = lefthand ? lefthand_n_px : righthand_n_px
			override_origin_pixel_y = lefthand ? lefthand_n_py : righthand_n_py

// Make these inline with final sprites
/datum/beam/fishing_line
	var/righthand_s_px = 13
	var/righthand_s_py = 16

	var/righthand_e_px = 18
	var/righthand_e_py = 16

	var/righthand_w_px = -20
	var/righthand_w_py = 18

	var/righthand_n_px = -14
	var/righthand_n_py = 16

	var/lefthand_s_px = -13
	var/lefthand_s_py = 15

	var/lefthand_e_px = 24
	var/lefthand_e_py = 18

	var/lefthand_w_px = -17
	var/lefthand_w_py = 16

	var/lefthand_n_px = 13
	var/lefthand_n_py = 15

