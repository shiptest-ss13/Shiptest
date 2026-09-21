/**
 * A screen object, which acts as a container for turfs and other things
 * you want to show on the map, which you usually attach to "vis_contents".
 * Additionally manages the plane masters required to display said container contents
 */
INITIALIZE_IMMEDIATE(/atom/movable/screen/map_view)
/atom/movable/screen/map_view
	name = "screen"
	// Map view has to be on the lowest plane to enable proper lighting
	layer = GAME_PLANE
	plane = GAME_PLANE
	del_on_map_removal = FALSE

	// Weakrefs of all our hud viewers -> a weakref to the hud datum they last used
	var/list/datum/weakref/viewers_to_huds = list()
	// this sucks and I don't have any idea if it'll even work. just port Plane Cube someday, sorry
	/// All the plane masters that need to be applied.
	var/list/plane_masters

/atom/movable/screen/map_view/Destroy()
	for(var/datum/weakref/client_ref in viewers_to_huds)
		hide_from_client(client_ref.resolve())

	QDEL_LIST(plane_masters)

	return ..()

/atom/movable/screen/map_view/proc/generate_view(map_key, render_lighting)
	// Map keys have to start and end with an A-Z character,
	// and definitely NOT with a square bracket or even a number.
	// I wasted 6 hours on this. :agony:
	// -- Stylemistake
	assigned_map = map_key
	set_position(1, 1)

	plane_masters = list()
	for(var/plane in subtypesof(/atom/movable/screen/plane_master))
		var/atom/movable/screen/instance = new plane()
		if (!render_lighting && instance.plane == LIGHTING_PLANE)
			instance.alpha = 100
		instance.assigned_map = map_key
		instance.del_on_map_removal = TRUE
		instance.set_position(1, 1)
		plane_masters += instance


/**
 * Generates and displays the map view to a client
 * Make sure you at least try to pass tgui_window if map view needed on UI,
 * so it will wait a signal from TGUI, which tells windows is fully visible.
 *
 * If you use map view not in TGUI, just call it as usualy.
 * If UI needs planes, call display_to_client.
 *
 * * show_to - Mob which needs map view
 * * window - Optional. TGUI window which needs map view
 */
/atom/movable/screen/map_view/proc/display_to(mob/show_to, datum/tgui_window/window)
	if(window && !window.visible)
		RegisterSignal(window, COMSIG_TGUI_WINDOW_VISIBLE, PROC_REF(display_on_ui_visible))
	else
		display_to_client(show_to.client)

/atom/movable/screen/map_view/proc/display_on_ui_visible(datum/tgui_window/window, client/show_to)
	SIGNAL_HANDLER
	display_to_client(show_to)
	UnregisterSignal(window, COMSIG_TGUI_WINDOW_VISIBLE)

/atom/movable/screen/map_view/proc/display_to_client(client/show_to)
	show_to.register_map_obj(src)
	for(var/atom/movable/screen/plane as anything in plane_masters)
		show_to.register_map_obj(plane)

	var/datum/weakref/client_ref = WEAKREF(show_to)
	viewers_to_huds[client_ref] = WEAKREF(show_to.mob.hud_used)

/atom/movable/screen/map_view/proc/hide_from(mob/hide_from)
	hide_from_client(hide_from?.client)

/atom/movable/screen/map_view/proc/hide_from_client(client/hide_from)
	if(!hide_from)
		return
	hide_from.clear_map(assigned_map)
