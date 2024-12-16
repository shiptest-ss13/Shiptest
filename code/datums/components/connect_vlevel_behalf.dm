/// This is to connect_vlevel as connect_loc_behalf is to connect_loc.
/// See connect_loc_behalf for more information. Basically lets us register signals on one thing on behalf of another's current vlevel.
/datum/component/connect_vlevel_behalf
	dupe_mode = COMPONENT_DUPE_UNIQUE

	/// An assoc list of signal -> procpath to register to the virtual level this object is in.
	var/list/connections

	var/atom/movable/tracked

	var/datum/virtual_level/tracked_level

/datum/component/connect_vlevel_behalf/Initialize(atom/movable/tracked, list/connections)
	. = ..()
	if (!istype(tracked))
		return COMPONENT_INCOMPATIBLE
	src.connections = connections
	src.tracked = tracked

/datum/component/connect_vlevel_behalf/RegisterWithParent()
	RegisterSignal(tracked, COMSIG_MOVABLE_VIRTUAL_Z_CHANGE, PROC_REF(on_vlevel_changed))
	RegisterSignal(tracked, COMSIG_PARENT_QDELETING, PROC_REF(handle_tracked_qdel))
	update_signals(tracked.get_virtual_level())

/datum/component/connect_vlevel_behalf/UnregisterFromParent()
	unregister_signals()
	UnregisterSignal(tracked, list(
		COMSIG_MOVABLE_VIRTUAL_Z_CHANGE,
		COMSIG_PARENT_QDELETING,
	))

	tracked = null

/datum/component/connect_vlevel_behalf/proc/handle_tracked_qdel()
	SIGNAL_HANDLER
	qdel(src)

/datum/component/connect_vlevel_behalf/proc/update_signals(virtual_z)
	var/datum/virtual_level/virtual_level = SSmapping.virtual_z_translation["[virtual_z]"]
	if(isnull(virtual_level))
		return

	tracked_level = virtual_level

	for (var/signal in connections)
		parent.RegisterSignal(tracked_level, signal, connections[signal])

/datum/component/connect_vlevel_behalf/proc/unregister_signals()
	if(isnull(tracked_level))
		return

	parent.UnregisterSignal(tracked_level, connections)

	tracked_level = null

/datum/component/connect_vlevel_behalf/proc/on_vlevel_changed(atom/movable/listener, virtual_z, old_virtual_z)
	SIGNAL_HANDLER
	unregister_signals()
	update_signals(virtual_z)

