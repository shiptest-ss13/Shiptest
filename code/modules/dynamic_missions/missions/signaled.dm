/datum/mission/dynamic/signaled
	var/registered_type
	var/atom/movable/registered_item
	/// What signal will spawn the required item
	var/mission_main_signal

/datum/mission/dynamic/signaled/spawn_main_piece(obj/effect/landmark/mission_poi/mission_poi)
	var/registered_item = set_bound(mission_poi.use_poi(registered_type), null, FALSE, TRUE)
	RegisterSignal(registered_item, mission_main_signal, PROC_REF(on_signaled))

/datum/mission/dynamic/signaled/proc/on_signaled(atom/movable/registered_item)
	SIGNAL_HANDLER

	required_item = new setpiece_item(registered_item.loc)
	set_bound(required_item, null, FALSE, TRUE)
	UnregisterSignal(registered_item, mission_main_signal)
	remove_bound(registered_item)
