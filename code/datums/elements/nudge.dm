/// Element for structures that lets you alt-click it to adjust its pixelshift.

/datum/element/nudge
	element_flags = ELEMENT_DETACH

/datum/element/nudge/Attach(datum/target)
	if(!isstructure(target) && !ismachinery(target))
		stack_trace("Nudge element added to non-structure non-machine object: \[[target]\]")
		return ELEMENT_INCOMPATIBLE
	. = ..()
	if(. == ELEMENT_INCOMPATIBLE)
		return
	RegisterSignal(target, COMSIG_CLICK_ALT, PROC_REF(on_alt_click))
	RegisterSignal(target, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))

/datum/element/nudge/Detach(datum/target)
	UnregisterSignal(target, COMSIG_CLICK_ALT)
	UnregisterSignal(target, COMSIG_ATOM_EXAMINE)
	return ..()

/datum/element/nudge/proc/on_alt_click(obj/structure/thing_to_nudge, mob/living/pusher)
	SIGNAL_HANDLER

	var/x = clamp(input(pusher, "Choose your X coordinate: Valid Range (-8, 8)", "Pick a location", 0) as num, -8, 8)
	var/y = clamp(input(pusher, "Choose your y coordinate: Valid Range (0, 16)", "Pick a location", 0) as num, 0, 16)
	thing_to_nudge.pixel_x = x
	thing_to_nudge.pixel_y = y

/datum/element/nudge/proc/on_examine(obj/structure/thing_to_examine, mob/examiner, list/examine_texts)
	SIGNAL_HANDLER
	examine_texts += span_notice("You could shift this by <b>Alt+Clicking</b> it!")

