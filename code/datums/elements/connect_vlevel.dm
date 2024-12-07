/// This element hooks a signal onto the loc the current object is on.
/// When the object moves, it will unhook the signal and rehook it to the new object.
/datum/element/connect_vlevel
	element_flags = ELEMENT_BESPOKE | ELEMENT_DETACH
	id_arg_index = 2

	/// An assoc list of signal -> procpath to register to the loc this object is on.
	var/list/connections

/datum/element/connect_vlevel/Attach(atom/movable/listener, list/connections)
	. = ..()
	if (!istype(listener))
		return ELEMENT_INCOMPATIBLE

	src.connections = connections

	var/turf/location = get_turf(listener)
	RegisterSignal(listener, COMSIG_ATOM_VIRTUAL_Z_CHANGE, PROC_REF(on_vlevel_changed))
	update_signals(listener, location.virtual_z)

/datum/element/connect_vlevel/Detach(atom/movable/listener)
	. = ..()
	var/turf/location = get_turf(listener)
	unregister_signals(listener, location.virtual_z)
	UnregisterSignal(listener, COMSIG_ATOM_VIRTUAL_Z_CHANGE)

/datum/element/connect_vlevel/proc/update_signals(atom/movable/listener, virtual_z)
	var/datum/virtual_level/virtual_level = SSmapping.virtual_z_translation["[virtual_z]"]
	if(isnull(virtual_level))
		return

	for(var/signal in connections)
		//override=TRUE because more than one connect_vlevel element instance tracked object can be on the same loc
		listener.RegisterSignal(virtual_level, signal, connections[signal], override=TRUE)

/datum/element/connect_vlevel/proc/unregister_signals(datum/listener, virtual_z)
	var/datum/virtual_level/virtual_level = SSmapping.virtual_z_translation["[virtual_z]"]
	if(isnull(virtual_level))
		return

	listener.UnregisterSignal(virtual_level, connections)

/datum/element/connect_vlevel/proc/on_vlevel_changed(atom/movable/listener, virtual_z, old_virtual_z)
	SIGNAL_HANDLER
	unregister_signals(listener, old_virtual_z)
	update_signals(listener, virtual_z)
