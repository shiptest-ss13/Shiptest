/datum/ship_module
	var/name = "defunct module"
	var/datum/weakref/parent_ship_ref
	var/is_enabled = FALSE
	var/is_configurable = FALSE

	// Ship Modifiers
	var/thrust_modifier = 1

/datum/ship_module/proc/render_info(mob/user)
	return "\[[(is_enabled ? "E": "D")]\]"

/datum/ship_module/proc/install(datum/overmap/ship/controlled/parent)
	SHOULD_CALL_PARENT(TRUE)

	if(!(type in parent.modules))
		parent.modules[type] = list(src)
	else
		parent.modules[type] += list(src)
	parent_ship_ref = WEAKREF(parent)

	SEND_SIGNAL(parent, COMSIG_SHIP_MODULES_UPDATED)

/datum/ship_module/proc/can_install(datum/overmap/ship/controlled/parent)
	return TRUE

/datum/ship_module/proc/uninstall(datum/overmap/ship/controlled/parent, qdel_self = TRUE, send_signal = TRUE)
	var/list/parent_modules = parent.modules[type]
	parent_modules -= src
	if(length(parent_modules) == 0)
		parent.modules -= type

	unregister_signals(parent)
	if(send_signal)
		SEND_SIGNAL(parent, COMSIG_SHIP_MODULES_UPDATED)

	if(qdel_self)
		qdel(src)

/datum/ship_module/proc/register_signals(target)
	SHOULD_CALL_PARENT(TRUE)
	RegisterSignal(target, COMSIG_SHIP_MODULES_UPDATED, .proc/on_parent_ship_modules_updated)

/datum/ship_module/proc/unregister_signals(target)
	SHOULD_CALL_PARENT(TRUE)
	UnregisterSignal(target, COMSIG_SHIP_MODULES_UPDATED)

/datum/ship_module/Destroy(force, ...)
	uninstall(parent_ship_ref.resolve(), qdel_self = FALSE, send_signal = FALSE)
	parent_ship_ref = null
	return ..()

/datum/ship_module/proc/on_parent_ship_modules_updated(datum/overmap/ship/controlled/parent)
	return

/datum/ship_module/proc/configure(mob/user)
	return
