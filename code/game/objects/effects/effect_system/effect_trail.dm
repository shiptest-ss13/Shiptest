/datum/effect_system/trail_follow
	var/turf/oldposition
	var/active = FALSE
	var/allow_overlap = FALSE
	var/auto_process = TRUE
	var/qdel_in_time = 10
	var/fadetype = "ion_fade"
	var/fade = TRUE
	var/nograv_required = FALSE

/datum/effect_system/trail_follow/set_up(atom/atom)
	attach(atom)
	oldposition = get_turf(atom)

/datum/effect_system/trail_follow/Destroy()
	oldposition = null
	stop()
	return ..()

/datum/effect_system/trail_follow/proc/stop()
	oldposition = null
	STOP_PROCESSING(SSfastprocess, src)
	active = FALSE
	return TRUE

/datum/effect_system/trail_follow/start()
	oldposition = get_turf(holder)
	if(!check_conditions())
		return FALSE
	if(auto_process)
		START_PROCESSING(SSfastprocess, src)
	active = TRUE
	return TRUE

/datum/effect_system/trail_follow/process()
	generate_effect()

/datum/effect_system/trail_follow/generate_effect()
	if(!check_conditions())
		return stop()
	if(oldposition && !(oldposition == get_turf(holder)))
		if(!has_gravity(oldposition) || !nograv_required)
			var/obj/effect/E = new effect_type(oldposition)
			set_dir(E)
			if(fade)
				flick(fadetype, E)
				E.icon_state = ""
			if(qdel_in_time)
				QDEL_IN(E, qdel_in_time)
	oldposition = get_turf(holder)

/datum/effect_system/trail_follow/proc/check_conditions()
	if(!get_turf(holder))
		return FALSE
	return TRUE

/// Ion trails for jetpacks, ion thrusters and other space-flying things
/obj/effect/particle_effect/ion_trails
	name = "ion trails"
	icon_state = "ion_fade"

/obj/effect/particle_effect/ion_trails/Initialize(mapload, targetdir)
	. = ..()
	dir = targetdir
	QDEL_IN(src, 0.6 SECONDS)

/datum/effect_system/trail_follow/ion
	effect_type = /obj/effect/particle_effect/ion_trails
	nograv_required = TRUE
	qdel_in_time = 20

/datum/effect_system/trail_follow/proc/set_dir(obj/effect/particle_effect/ion_trails/I)
	I.setDir(holder.dir)

/datum/effect_system/trail_follow/ion/grav_allowed
	nograv_required = FALSE
