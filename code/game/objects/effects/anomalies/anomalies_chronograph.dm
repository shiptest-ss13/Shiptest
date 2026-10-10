/obj/effect/anomaly/chronograph
	name = "chronograph"
	icon_state = "chronograph"
	desc = "Time beats forward at greater and greater speeds. The accelerando of life is constant. Here it drives reality."
	density = FALSE
	core = /obj/item/assembly/signaler/anomaly/grav
	effectrange = 6
	pulse_delay = 1 SECONDS
	light_range = 6
	light_color = LIGHT_COLOR_LIGHT_CYAN
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

	if(!COOLDOWN_FINISHED(src, pulse_cooldown))
		return

	for(var/mob/living/old in orange(effectrange, src))
		//closer is better
		var/effect_power = -(get_dist(old, src)) + effectrange
		//prevents runtime @ max distance
		if(effect_power)
			old.adjust_timed_status_effect(effect_power * 1 SECONDS, /datum/status_effect/accelerando, effect_power*30 SECONDS)
			if(prob(10))
				var/timestring = pick("Time begins to slip through your hands", "The world feels that much slower.", "No one else will be as fast as you now.", "Your moments have become something more.", "Seconds turn to hours", "Every instant is eternity")
				to_chat(old, span_warning(timestring))
		do_sparks(6, TRUE, old, /datum/effect_system/spark_spread/blue)

/obj/effect/anomaly/chronograph/planetary
	immortal = TRUE
	immobile = TRUE
