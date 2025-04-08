#define OPEN_TURF_ONLY 1
#define CLOSED_TURF_ONLY 2
#define NO_TURFS 3
#define ALL_TURFS 4

/obj/item/chisel
	name = "chisel"
	desc = "A handly little tool that can be used to harness the power of bluespace to smooth and unsmooth the corners of wall! Don't question it."
	icon = 'icons/obj/tools.dmi'
	icon_state = "chisel"
	force = 5
	/// Are we toggling the ability for atoms to smooth at all?
	var/toggling_smooth = FALSE
	/// Are we allowing them to smooth turfs
	var/turf_options = CLOSED_TURF_ONLY // THIS IS SET FOR NOW BECAUSE I DO NOT KNOW WHY OPEN TURFS REFUSE TO WORK
	/// Static list to store the original icon_state of atoms we smoothed
	var/static/list/pre_smooth_state_cache = list()

/obj/item/chisel/pre_attack(atom/target, mob/living/user, params)
	if(ismob(target))
		return ..()
	if(isturf(target))
		if(istype(target, /turf/open/floor/concrete))
			var/turf/open/floor/concrete/conc_floor = target
			return conc_floor.handle_shape(user)
		if(turf_options == NO_TURFS)
			return ..()
		switch(turf_options)
			if(OPEN_TURF_ONLY)
				if(isclosedturf(target))
					return ..()
			if(CLOSED_TURF_ONLY)
				if(isopenturf(target))
					return ..()
	. = TRUE
	if(toggling_smooth)
		if(!atom_supports_smoothing(target))
			to_chat(user, "<span class='warning'>\the [src] makes a tart buzz. \the [target] doesn't appear to support smoothing.</span>")
			return ..()
		smooth_atom(target, user)
	else
		if(!atom_supports_diagonal(target))
			to_chat(user, "<span class='warning'>\the [src] makes a tart buzz. \the [target] doesn't appear to support smoothed corners.</span>")
			return ..()
		smooth_atom_diagonal(target, user)
	return

/obj/item/chisel/attack_self(mob/user)
	toggling_smooth = !toggling_smooth
	to_chat(user, "<span class='notice'>\the [src] is now set to reform the [(toggling_smooth ? "smoothness" : "corners")] of objects.</span>")

/obj/item/chisel/proc/smooth_atom(atom/target, mob/living/user)
	target.smoothing_flags ^= SMOOTH_BITMASK
	to_chat(user, "<span class='notice'>\the [src] vibrates gently as it reforms \the [target] to be [((target.smoothing_flags & SMOOTH_BITMASK) ? "smooth" : "rough")].</span>")
	if(target.smoothing_flags & SMOOTH_BITMASK)
		pre_smooth_state_cache[target] = target.icon_state
	else
		target.icon_state = pre_smooth_state_cache[target] || initial(target.icon_state)
	QUEUE_SMOOTH(target)
	QUEUE_SMOOTH_NEIGHBORS(target)


/// A bit more complex and in-depth, mainly checks for turfs to append an underlay
/obj/item/chisel/proc/smooth_atom_diagonal(atom/target, mob/living/user)
	if(target.smoothing_flags & SMOOTH_DIAGONAL_CORNERS)
		target.smoothing_flags &= ~SMOOTH_DIAGONAL_CORNERS
		QUEUE_SMOOTH(target)
		QUEUE_SMOOTH_NEIGHBORS(target)
		if(iswallturf(target))
			remove_turf_underlay(target)
	else
		target.smoothing_flags |= SMOOTH_DIAGONAL_CORNERS
		QUEUE_SMOOTH(target)
		QUEUE_SMOOTH_NEIGHBORS(target)
		if(iswallturf(target))
			add_turf_underlay(target)
	to_chat(user, "<span class='notice'>\the [src] vibrates intensely as it reforms \the [target]'s corners.</span>")

#define UNDERLAY_FOUND 1
#define UNDERLAY_MISSING 3

/obj/item/chisel/proc/add_turf_underlay(turf/target)
	if(target.fixed_underlay)
		return

	var/turf/baseturf
	var/found = UNDERLAY_MISSING
	var/idx = length(target.baseturfs)

	if(!idx)
		CRASH("[target] does not have any baseturfs")

	while(idx)
		baseturf = target.baseturfs[idx]
		if(ispath(baseturf, /turf/baseturf_skipover))
			idx--
			continue
		found = UNDERLAY_FOUND
		if(ispath(baseturf, /turf/baseturf_bottom))
			baseturf = target.get_z_base_turf()
		break

	if(found == UNDERLAY_MISSING)
		CRASH("Unable to find valid baseturf underlay for [target]")

	target.smooth_underlay = mutable_appearance(layer = TURF_LAYER, plane = FLOOR_PLANE)
	target.smooth_underlay.icon = initial(baseturf.icon)
	target.smooth_underlay.icon_state = initial(baseturf.icon_state)
	target.underlays |= target.smooth_underlay

/obj/item/chisel/proc/remove_turf_underlay(turf/target)
	if(!target.smooth_underlay)
		return
	target.underlays -= target.smooth_underlay

#undef UNDERLAY_FOUND
#undef UNDERLAY_MISSING

/obj/item/chisel/proc/atom_supports_smoothing(atom/target)
	if(initial(target.smoothing_flags) & SMOOTH_BITMASK)
		return TRUE // If they start off with valid smoothing flags assume yes
	var/find_this = "[target.base_icon_state]-5"
	return find_this in icon_states(target.icon)

/obj/item/chisel/proc/atom_supports_diagonal(atom/target)
	if(initial(target.smoothing_flags) & SMOOTH_DIAGONAL_CORNERS)
		return TRUE // If they start off with valid corner flags assume yes
	var/verify_iconstate = "[target.base_icon_state]-5-d" // Look for a diagonal icon_state, if it exists the atom supports diagonal corners
	return verify_iconstate in icon_states(target.icon)

/datum/design/chisel
	name = "Chisel"
	id = "chisel"
	build_type = AUTOLATHE | PROTOLATHE
	materials = list(/datum/material/iron = 200, /datum/material/glass = 50)
	build_path = /obj/item/chisel
	category = list("initial","Tools","Tool Designs")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SERVICE

#undef OPEN_TURF_ONLY
#undef CLOSED_TURF_ONLY
#undef NO_TURFS
#undef ALL_TURFS
