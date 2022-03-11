/obj/item/chisel
	name = "chisel"
	desc = "A handly little tool that can be used to harness the power of bluespace to smooth and unsmooth the corners of wall! Don't question it."
	icon = 'icons/obj/tools.dmi'
	icon_state = "chisel"
	force = 5
	/// Are we toggling the ability for walls to smooth at all?
	var/toggling_smooth = FALSE

/obj/item/chisel/pre_attack(atom/A, mob/living/user, params)
	if(iswallturf(A))
		attack_wall(A, user)
		return TRUE
	return ..()

/obj/item/chisel/attack_self(mob/user)
	toggling_smooth = !toggling_smooth
	to_chat(user, "<span class='notice'>\the [src] is now set to reform the [(toggling_smooth ? "smoothness" : "corners")] of walls</span>")

/obj/item/chisel/proc/attack_wall(turf/closed/wall/wall, mob/living/user)
	if(toggling_smooth)
		if(wall.smoothing_flags == 0)
			wall.smoothing_flags = initial(wall.smoothing_flags)
			QUEUE_SMOOTH(wall)
			to_chat(user, "<span class='notice'>\the [src] vibrates gently as it reforms the wall to be smooth.</span>")
		else
			wall.smoothing_flags = 0
			wall.icon_state = initial(wall.icon_state)
			to_chat(user, "<span class='notice'>\the [src] vibrates gently as it reforms the wall to be rough.</span>")
		QUEUE_SMOOTH_NEIGHBORS(wall)
		return

	if(!wall_supports_diagonal(wall))
		to_chat(user, "<span class='warning'>\the [src] gives off a tart buzz. It appears that \the [wall] cannot be smoothed diagonally.</span>")
		return

	wall.smoothing_flags ^= SMOOTH_DIAGONAL_CORNERS
	if(wall.smoothing_flags & SMOOTH_DIAGONAL_CORNERS)
		to_chat(user, "<span class='notice'>\the [src] vibrates intensely as it reforms\the [wall] to be rounded.</span>")
		if(!wall.fixed_underlay && length(wall.baseturfs))
			var/turf/baseturf = wall.baseturfs[length(wall.baseturfs)]
			wall.smooth_underlay = mutable_appearance(layer = TURF_LAYER, plane = FLOOR_PLANE)
			wall.smooth_underlay.icon = initial(baseturf.icon)
			wall.smooth_underlay.icon_state = initial(baseturf.icon_state)
			wall.underlays |= wall.smooth_underlay
	else
		to_chat(user, "<span class='notice'>\the [src] vibrates intensely as it reforms \the [wall] to be straight.</span>")
		if(wall.smooth_underlay)
			wall.underlays -= wall.smooth_underlay

	QUEUE_SMOOTH(wall)
	QUEUE_SMOOTH_NEIGHBORS(wall)

/obj/item/chisel/proc/wall_supports_diagonal(turf/closed/wall/wall)
	var/verify_iconstate = "[wall.base_icon_state]-5-d" // Look for a diagonal icon_state, if it exists the wall supports diagonal
	return verify_iconstate in icon_states(wall.icon)

/datum/design/chisel
	name = "Chisel"
	id = "chisel"
	build_type = AUTOLATHE | PROTOLATHE
	materials = list(/datum/material/iron = 200, /datum/material/glass = 50)
	build_path = /obj/item/chisel
	category = list("initial","Tools","Tool Designs")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SERVICE
