/obj/item/ship_module_card/hyper_drive
	name = "hyper engine overclocker"
	desc = "Do you like speed? We like speed."
	module_path = /datum/ship_module/hyper_drive

/datum/ship_module/hyper_drive
	name = "Hyper Drive"
	thrust_modifier = 20

/datum/ship_module/hyper_drive/register_signals(target)
	..()
	RegisterSignal(target, COMSIG_SHIP_REFRESH_ENGINES, .proc/on_engine_refresh)

/datum/ship_module/hyper_drive/unregister_signals(target)
	..()
	UnregisterSignal(target, COMSIG_SHIP_REFRESH_ENGINES)

/datum/ship_module/hyper_drive/proc/on_engine_refresh(datum/overmap/ship/controlled/parent)
	parent.est_thrust *= thrust_modifier
