///A component that allows players to use the item to zoom out. Mainly intended for firearms, but now works with other items too.
/datum/component/scope
	/// How far we can extend, with modifier of 1, up to our vision edge, higher numbers multiply.
	var/range_modifier
	/// The slowdown while scoped in with this item.
	var/aimed_wield_slowdown
	/// Fullscreen object we use for tracking.
	var/atom/movable/screen/fullscreen/scope/tracker
	/// The method which we zoom in and out
	var/zoom_method = ZOOM_METHOD_RIGHT_CLICK
	/// if not null, an item action will be added. Redundant if the mode is ZOOM_METHOD_RIGHT_CLICK or ZOOM_METHOD_WIELD.
	var/item_action_type
	/// Whether scoping in requires being
	var/require_wielded

/datum/component/scope/Initialize(range_modifier = 1, aimed_wield_slowdown = 0, zoom_method = ZOOM_METHOD_RIGHT_CLICK, item_action_type, require_wielded = FALSE)
	if(!isitem(parent))
		return COMPONENT_INCOMPATIBLE
	src.range_modifier = range_modifier
	src.aimed_wield_slowdown = aimed_wield_slowdown
	src.zoom_method = zoom_method
	src.item_action_type = item_action_type
	src.require_wielded = require_wielded

/datum/component/scope/Destroy(force, silent)
	if(tracker)
		stop_zooming(tracker.marksman)
	return ..()

/datum/component/scope/RegisterWithParent()
	RegisterSignal(parent, COMSIG_MOVABLE_MOVED, PROC_REF(on_move))
	switch(zoom_method)
		if(ZOOM_METHOD_RIGHT_CLICK)
			RegisterSignal(parent, COMSIG_ITEM_AFTERATTACK_SECONDARY, PROC_REF(on_secondary_afterattack))
			if(require_wielded)
				RegisterSignal(parent, SIGNAL_REMOVETRAIT(TRAIT_WIELDED), PROC_REF(on_unwielded))
		if(ZOOM_METHOD_WIELD)
			RegisterSignal(parent, SIGNAL_ADDTRAIT(TRAIT_WIELDED), PROC_REF(on_wielded))
			RegisterSignal(parent, SIGNAL_REMOVETRAIT(TRAIT_WIELDED), PROC_REF(on_unwielded))
	if(item_action_type)
		var/obj/item/parent_item = parent
		var/datum/action/item_action/scope = parent_item.add_item_action(item_action_type)
		RegisterSignal(scope, COMSIG_ACTION_TRIGGER, PROC_REF(on_action_trigger))
	RegisterSignal(parent, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))
	if(isgun(parent))
		RegisterSignal(parent, COMSIG_GUN_TRY_FIRE, PROC_REF(on_gun_fire))

/datum/component/scope/UnregisterFromParent()
	if(item_action_type)
		var/obj/item/parent_item = parent
		var/datum/action/item_action/scope = locate(item_action_type) in parent_item.actions
		parent_item.remove_item_action(scope)
	UnregisterSignal(parent, list(
		COMSIG_MOVABLE_MOVED,
		COMSIG_ITEM_AFTERATTACK_SECONDARY,
		SIGNAL_ADDTRAIT(TRAIT_WIELDED),
		SIGNAL_REMOVETRAIT(TRAIT_WIELDED),
		COMSIG_GUN_TRY_FIRE,
		COMSIG_ATOM_EXAMINE,
	))

/datum/component/scope/process(delta_time)
	if(!tracker.marksman.client)
		stop_zooming(tracker.marksman)
		return
	if(!length(tracker.marksman.client.keys_held & tracker.marksman.client.movement_keys))
		tracker.marksman.face_atom(tracker.given_turf)
	animate(tracker.marksman.client, 0.1 SECONDS, easing = SINE_EASING, flags = EASE_OUT, pixel_x = tracker.given_x, pixel_y = tracker.given_y)

/datum/component/scope/proc/on_move(atom/movable/source, atom/oldloc, dir, forced)
	SIGNAL_HANDLER

	if(!tracker)
		return
	stop_zooming(tracker.marksman)

/datum/component/scope/proc/on_secondary_afterattack(datum/source, atom/target, mob/user, proximity_flag, click_parameters)
	SIGNAL_HANDLER

	if(tracker)
		stop_zooming(user)
	else
		zoom(user)
	return COMPONENT_SECONDARY_CANCEL_ATTACK_CHAIN

/datum/component/scope/proc/on_action_trigger(datum/action/source)
	SIGNAL_HANDLER
	var/obj/item/item = source.target
	var/mob/living/user = item.loc
	if(tracker)
		stop_zooming(user)
	else
		zoom(user)

/datum/component/scope/proc/on_wielded(obj/item/source, trait)
	SIGNAL_HANDLER
	var/mob/living/user = source.loc
	zoom(user)

/datum/component/scope/proc/on_unwielded(obj/item/source, trait)
	SIGNAL_HANDLER
	var/mob/living/user = source.loc
	stop_zooming(user)

/datum/component/scope/proc/on_gun_fire(obj/item/gun/source, mob/living/user, atom/target, flag, params)
	SIGNAL_HANDLER

	if(!tracker?.given_turf || target == get_target(tracker.given_turf))
		return NONE
	INVOKE_ASYNC(source, TYPE_PROC_REF(/obj/item/gun, fire_gun), get_target(tracker.given_turf), user)
	return COMPONENT_CANCEL_GUN_FIRE

/datum/component/scope/proc/on_examine(datum/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	var/scope = isgun(parent) ? "scope in" : "zoom out"
	switch(zoom_method)
		if(ZOOM_METHOD_RIGHT_CLICK)
			examine_list += span_notice("You can [scope] with <b>right-click</b>.")
		if(ZOOM_METHOD_WIELD)
			examine_list += span_notice("You can [scope] by wielding it with both hands.")

/**
 * We find and return the best target to hit on a given turf.
 *
 * Arguments:
 * * target_turf: The turf we are looking for targets on.
*/
/datum/component/scope/proc/get_target(turf/target_turf)
	var/list/object_targets = list()
	var/list/non_dense_targets = list()
	for(var/atom/movable/possible_target in target_turf)
		if(possible_target.layer <= PROJECTILE_HIT_THRESHHOLD_LAYER)
			continue
		if(possible_target.invisibility > tracker.marksman.see_invisible)
			continue
		if(!possible_target.mouse_opacity)
			continue
		if(iseffect(possible_target))
			continue
		if(ismob(possible_target))
			return possible_target
		if(!possible_target.density)
			non_dense_targets += possible_target
			continue
		object_targets += possible_target
	for(var/obj/important_object as anything in object_targets)
		return important_object
	for(var/obj/unimportant_object as anything in non_dense_targets)
		return unimportant_object
	return target_turf

/**
 * We start zooming by adding our tracker overlay and starting our processing.
 *
 * Arguments:
 * * user: The mob we are starting zooming on.
*/
/datum/component/scope/proc/zoom(mob/user)
	if(isnull(user.client))
		return
	if(require_wielded && !HAS_TRAIT(parent, TRAIT_WIELDED))
		user.balloon_alert(user, "wield it first!")
		return
	if(HAS_TRAIT(user, TRAIT_USER_SCOPED))
		user.balloon_alert(user, "already zoomed!")
		return
	user.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/aiming, multiplicative_slowdown = aimed_wield_slowdown)
	user.client.mouse_override_icon = 'icons/effects/mouse_pointers/scope_hide.dmi'
	user.update_mouse_pointer()
	user.playsound_local(parent, 'sound/weapons/scope.ogg', 75, TRUE)
	tracker = user.overlay_fullscreen("scope", /atom/movable/screen/fullscreen/scope, isgun(parent))
	tracker.range_modifier = range_modifier
	tracker.marksman = user
	tracker.RegisterSignal(user, COMSIG_MOVABLE_MOVED, TYPE_PROC_REF(/atom/movable/screen/fullscreen/scope, on_move))
	if(user.is_holding(parent))
		RegisterSignals(user, list(COMSIG_MOB_SWAP_HANDS, COMSIG_QDELETING), PROC_REF(stop_zooming))
	else // The item is likely worn
		RegisterSignal(user, COMSIG_QDELETING, PROC_REF(stop_zooming))
		var/static/list/capacity_signals = list(
			COMSIG_LIVING_STATUS_KNOCKDOWN,
			COMSIG_LIVING_STATUS_PARALYZE,
			COMSIG_LIVING_STATUS_STUN,
		)
		RegisterSignals(user, capacity_signals, PROC_REF(on_incapacitated))
	START_PROCESSING(SSprojectiles, src)
	ADD_TRAIT(user, TRAIT_USER_SCOPED, REF(src))
	return TRUE

/datum/component/scope/proc/on_incapacitated(mob/living/source, amount = 0, ignore_canstun = FALSE)
	SIGNAL_HANDLER

	if(amount > 0)
		stop_zooming(source)

/**
 * We stop zooming, canceling processing, resetting stuff back to normal and deleting our tracker.
 *
 * Arguments:
 * * user: The mob we are canceling zooming on.
*/
/datum/component/scope/proc/stop_zooming(mob/user)
	SIGNAL_HANDLER

	if(!HAS_TRAIT(user, TRAIT_USER_SCOPED))
		return

	STOP_PROCESSING(SSprojectiles, src)
	UnregisterSignal(user, list(
		COMSIG_LIVING_STATUS_KNOCKDOWN,
		COMSIG_LIVING_STATUS_PARALYZE,
		COMSIG_LIVING_STATUS_STUN,
		COMSIG_MOB_SWAP_HANDS,
		COMSIG_QDELETING,
	))
	REMOVE_TRAIT(user, TRAIT_USER_SCOPED, REF(src))

	user.playsound_local(parent, 'sound/weapons/scope.ogg', 75, TRUE, frequency = -1)
	user.clear_fullscreen("scope")

	if(user.client)
		animate(user.client, 0.2 SECONDS, pixel_x = 0, pixel_y = 0)
		user.client.mouse_override_icon = null
		user.update_mouse_pointer()

	user.remove_movespeed_modifier(/datum/movespeed_modifier/aiming)
	tracker = null

/atom/movable/screen/fullscreen/scope
	icon_state = "scope"
	plane = HUD_PLANE
	mouse_opacity = MOUSE_OPACITY_ICON
	/// Multiplier for given_X an given_y.
	var/range_modifier = 1
	/// The mob the scope is on.
	var/mob/marksman
	/// Pixel x we send to the scope component.
	var/given_x = 0
	/// Pixel y we send to the scope component.
	var/given_y = 0
	/// The turf we send to the scope component.
	var/turf/given_turf
	/// The coordinate on our mouseentered, for performance reasons.
	COOLDOWN_DECLARE(coordinate_cooldown)

/atom/movable/screen/fullscreen/scope/proc/on_move(atom/source, atom/oldloc, dir, forced)
	SIGNAL_HANDLER

	if(!given_turf)
		return
	var/x_offset = source.loc.x - oldloc.x
	var/y_offset = source.loc.y - oldloc.y
	given_turf = locate(given_turf.x+x_offset, given_turf.y+y_offset, given_turf.z)

/atom/movable/screen/fullscreen/scope/MouseEntered(location, control, params)
	. = ..()
	MouseMove(location, control, params)

/atom/movable/screen/fullscreen/scope/MouseMove(location, control, params)
	if(!marksman?.client || usr != marksman)
		return
	if(!COOLDOWN_FINISHED(src, coordinate_cooldown))
		return
	COOLDOWN_START(src, coordinate_cooldown, 0.05 SECONDS)
	var/list/modifiers = params2list(params)
	var/icon_x = text2num(LAZYACCESS(modifiers, VIS_X))
	var/icon_y = text2num(LAZYACCESS(modifiers, VIS_Y))
	var/list/view = getviewsize(marksman.client.view)
	given_x = round(range_modifier * (icon_x - view[1]*world.icon_size/2))
	given_y = round(range_modifier * (icon_y - view[2]*world.icon_size/2))
	given_turf = locate(marksman.x+round(given_x/world.icon_size, 1),marksman.y+round(given_y/world.icon_size, 1),marksman.z)
