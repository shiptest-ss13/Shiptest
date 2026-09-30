/datum/status_effect/accelerando
	alert_type = /atom/movable/screen/alert/status_effect/cloaked
	tick_interval = 3
	duration = -1
	//how close to the chronograph are we?
	var/source_anomaly

/datum/status_effect/accelerando/on_creation(mob/living/new_owner, _duration = 10 SECONDS)
	duration = _duration
	return ..()

/datum/status_effect/accelerando/on_apply()
	. = ..()
	RegisterSignal(owner, COMSIG_MOVABLE_MOVED, PROC_REF(on_move))
	owner.add_filter("chronoblur", 1, angular_blur_filter(3, 3, 8))
	animate(owner.get_filter("chronoblur"), 20, size = 8)

/datum/status_effect/accelerando/cloaked/tick()
	owner.alpha = max(min_alpha, owner.alpha - 25)
	if(prob(20))
		if(!owner.get_filter("chronoblur"))
			owner.add_filter("chronoblur", 1, angular_blur_filter(3, 3, 16))
		animate(owner.get_filter("chronoblur"), 5, size = rand(-4,4))

/datum/status_effect/accelerando/cloaked/proc/on_move()
	SIGNAL_HANDLER

	owner.alpha = min(255, owner.alpha + 15)

/datum/status_effect/accelerando/cloaked/on_remove()
	if(..())
		return
	owner.alpha = 255
	animate(owner.get_filter("cloak_distort"), 20, size = 0)
	addtimer(CALLBACK(owner, PROC_REF(remove_filter), "cloak_distort"), 20)
	UnregisterSignal(owner, COMSIG_MOVABLE_MOVED)

/atom/movable/screen/alert/status_effect/accelerando
	name = "Accelerando"
	desc = "Out of sync. Out of time. Yet you're still here?"
	icon_state = ""

/atom/movable/chrono_effect
	appearance_flags = PIXEL_SCALE|LONG_GLIDE // no tile bound so you can see it around corners and so
	icon = 'icons/effects/light_overlays/light_352.dmi'
	icon_state = "light"
	pixel_x = -176
	pixel_y = -176

/obj/effect/anomaly/chronograph
	name = "chronograph"
	icon_state = "chronograph"
	desc = "Time beats forward at greater and greater speeds. The accelerando of life is constant. Here it drives reality."
	density = FALSE
	core = /obj/item/assembly/signaler/anomaly/grav
	effectrange = 6
	pulse_delay = 1 SECOND
	///Warp effect holder for displacement filter to "pulse" the anomaly
	var/atom/movable/chrono_effect/chrono

/obj/effect/anomaly/grav/Initialize(mapload, new_lifespan, drops_core)
	. = ..()
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(on_entered),
	)
	AddElement(/datum/element/connect_loc, loc_connections)

/obj/effect/anomaly/chronograph/anomalyEffect()
	. = ..()
	for(var/mob/living/old in orange(effectrange, src))
		//closer is better
		var/effect_power = -(get_dist(old, src)) + effectrange
		old.adjust_timed_status_effect(effect_power * 3, /datum/status_effect/accelerando, effect_power*30)

/obj/effect/anomaly/chronograph/proc/on_entered(datum/source, atom/movable/AM)
	SIGNAL_HANDLER


/obj/effect/anomaly/chronograph/Bump(atom/A)


/obj/effect/anomaly/chronograph/Bumped(atom/movable/AM)



/obj/effect/anomaly/chronograph/planetary
	immortal = TRUE
	immobile = TRUE
