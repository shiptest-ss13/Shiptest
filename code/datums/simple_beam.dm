/datum/simple_beam
	///The source of the beam, which must be visible for the beam to be seen. Can NOT be null.
	VAR_PRIVATE/atom/movable/origin
	///The target of the beam. Can be null.
	VAR_PRIVATE/atom/movable/target
	///The visual representation of the beam.
	VAR_PRIVATE/obj/effect/simple_beam/its_beam

/datum/simple_beam/New(_origin, _target, icon = 'icons/effects/beam.dmi', icon_state = "1-full", icon_color = null, icon_alpha = 255)
	origin = _origin
	target = _target

	its_beam = new /obj/effect/simple_beam(origin, icon, icon_state, icon_color, icon_alpha)
	origin.vis_contents += its_beam

	set_target(target)

/datum/simple_beam/Destroy(force)
	origin.vis_contents -= its_beam
	QDEL_NULL(its_beam)

	if(target)
		UnregisterSignal(origin, COMSIG_MOVABLE_MOVED)
		UnregisterSignal(target, COMSIG_MOVABLE_MOVED)

	return ..()

/datum/simple_beam/proc/draw()
	if(origin.z != target.z)
		set_target(null)
		return

	var/f_dx = ((target.pixel_x - origin.pixel_x + 16) / world.icon_size) + (target.x - origin.x)
	var/f_dy = ((target.pixel_y - origin.pixel_y) / world.icon_size) + (target.y - origin.y)
	var/dist = sqrt(f_dx * f_dx + f_dy * f_dy)
	var/s_dx = f_dy/dist
	var/s_dy = -f_dx/dist
	var/matrix/translation = matrix()
	translation.Translate(0, 16)
	translation.Multiply(new /matrix(s_dx, f_dx, 0, s_dy, f_dy, 0))

	its_beam.transform = translation

/datum/simple_beam/proc/set_target(new_target)
	if(target)
		UnregisterSignal(target, COMSIG_MOVABLE_MOVED)
		UnregisterSignal(origin, COMSIG_MOVABLE_MOVED)

	target = new_target

	if(target)
		its_beam.vis_flags &= ~VIS_HIDE

		RegisterSignal(target, COMSIG_MOVABLE_MOVED, PROC_REF(draw))
		RegisterSignal(origin, COMSIG_MOVABLE_MOVED, PROC_REF(draw))

		draw()
	else
		its_beam.vis_flags |= VIS_HIDE

/obj/effect/simple_beam
	layer = ABOVE_LIGHTING_LAYER
	plane = ABOVE_LIGHTING_PLANE

/obj/effect/simple_beam/New(loc, icon, icon_state, icon_color, icon_alpha)
	src.icon = icon
	src.icon_state = icon_state
	src.color = icon_color
	src.alpha = icon_alpha

	return ..()
