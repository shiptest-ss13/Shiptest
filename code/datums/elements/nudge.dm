/// Element for structures that lets you alt-click it to adjust its pixelshift.

/datum/element/nudge
	element_flags = ELEMENT_BESPOKE | ELEMENT_DETACH
	argument_hash_start_idx = 2

	// limits of how far we can nudge stuff
	var/min_x = 0
	var/max_x = 0
	var/min_y = 0
	var/max_y = 0

/datum/element/nudge/Attach(datum/target, _min_x = 0, _max_x = 0, _min_y = 0, _max_y = 0)
	if(!isstructure(target) && !ismachinery(target))
		stack_trace("Nudge element added to non-structure non-machine object: \[[target]\]")
		return ELEMENT_INCOMPATIBLE
	. = ..()
	if(. == ELEMENT_INCOMPATIBLE)
		return
	min_x = _min_x
	max_x = _max_x
	min_y = _min_y
	max_y = _max_y
	RegisterSignal(target, COMSIG_CLICK_ALT, PROC_REF(on_alt_click))
	RegisterSignal(target, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))

/datum/element/nudge/Detach(datum/target)
	UnregisterSignal(target, COMSIG_CLICK_ALT)
	UnregisterSignal(target, COMSIG_ATOM_EXAMINE)
	return ..()

/datum/element/nudge/proc/on_alt_click(obj/structure/thing_to_nudge, mob/living/pusher)
	SIGNAL_HANDLER
	if(!pusher.canUseTopic(thing_to_nudge, BE_CLOSE))
		return
	INVOKE_ASYNC(src, PROC_REF(pick_coords), thing_to_nudge, pusher)

/datum/element/nudge/proc/pick_coords(obj/structure/thing_to_nudge, mob/living/pusher)
	var/x = clamp(input(pusher, "Choose your X coordinate: Valid Range ([min_x], [max_x])", "Pick a location", 0) as num, min_x, max_x)
	var/y = clamp(input(pusher, "Choose your Y coordinate: Valid Range ([min_y], [max_y])", "Pick a location", 0) as num, min_y, max_y)
	// we have to check again in case the user moved away during range selection
	if(!pusher.canUseTopic(thing_to_nudge, BE_CLOSE))
		return
	thing_to_nudge.pixel_x = x
	thing_to_nudge.pixel_y = y

/datum/element/nudge/proc/on_examine(obj/structure/thing_to_examine, mob/examiner, list/examine_texts)
	SIGNAL_HANDLER
	examine_texts += span_notice("You could shift this by <b>Alt+Clicking</b> it!")

