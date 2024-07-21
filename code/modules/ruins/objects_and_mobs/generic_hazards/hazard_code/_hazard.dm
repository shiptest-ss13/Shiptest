/obj/structure/hazard
	name = "ruin hazard"
	desc = "tell a maptainer if you see this. you shouldnt!"
	icon = 'icons/obj/hazard/generic.dmi'
	icon_state = "hazard"
	anchored = TRUE
	density = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF //add clever ways to disable these hazards! even just tools is better than smashing it to bits
	COOLDOWN_DECLARE(cooldown)
	var/cooldown_time = 2 SECONDS //stops people from spamming effects
	var/enter_activated = FALSE

	var/random_effect = FALSE //repeats an effect after a random amount of time
	var/random_min = 10 SECONDS
	var/random_max = 30 SECONDS

	var/can_be_disabled = FALSE //can we disable this? Used by most subtypes.
	var/time_to_disable = 5 SECONDS //how long does the toolcheck take?
	var/disabled = FALSE //if disabled, stops doing effects. Used by subtypes

	var/id = null //used to turn off hazards with mapped in cutoffs (fuseboxes, valves, etc)
	var/on = TRUE //used when turned off.

	var/slowdown = 0 //all hazards can use slowdown! but if you make a generic slowdown hazard, its good practice to make it hazard/slowdown
	var/disable_text = "a way you don't know! (this needs to be set)"

	FASTDMM_PROP(\
		pinned_vars = list("name", "dir", "id")\
	)

/*
procs used to set off effects
*/

/obj/structure/hazard/proc/do_random_effect() //if random_effect is TRUE, repeats an effect after a randomly selected period of time between two values.
	return

/obj/structure/hazard/proc/contact(mob/target) //goes off if bumped or entered
	return

/obj/structure/hazard/proc/attacked() //goes off if attacked or shot by most things.
	return

/*
evil 'code' that sets off the above procs. mappers beware!
*/

/obj/structure/hazard/proc/turn_on()
	if(QDELETED(src) || disabled)
		return
	on = TRUE
	update_appearance()

/obj/structure/hazard/proc/turn_off()
	if(QDELETED(src) || disabled)
		return
	on = FALSE
	update_appearance()

/obj/structure/hazard/proc/toggle()
	if(QDELETED(src) || disabled)
		return
	on = !on
	update_appearance()

/obj/structure/hazard/proc/disable()
	disabled = TRUE
	update_appearance()

/obj/structure/hazard/Initialize()
	. = ..()
	GLOB.ruin_hazards += src
	if(random_effect)
		random_effect(TRUE)
	if(slowdown)
		update_turf_slowdown()
	if(enter_activated)
		var/static/list/loc_connections = list(
			COMSIG_ATOM_ENTERED = PROC_REF(on_entered),
		)
		AddElement(/datum/element/connect_loc, loc_connections)

/obj/structure/hazard/update_icon_state()
	if(disabled)
		icon_state = initial(icon_state) + "-disabled"
	else if(!on)
		icon_state = initial(icon_state) + "-off"
	else
		icon_state = initial(icon_state)
	return ..()

/obj/structure/hazard/examine(mob/user)
	. = ..()
	if(disabled)
		. += span_notice("[src] has been disabled.</span>")
	else if(can_be_disabled)
		. += span_notice("[src] could be disabled by [disable_text].</span>")

/obj/structure/hazard/proc/random_effect(start = FALSE)
	if(QDELETED(src) || disabled)
		return
	if(!start && on)
		do_random_effect()
	var/delay = rand(random_min, random_max)
	addtimer(CALLBACK(src, PROC_REF(random_effect)), delay, TIMER_UNIQUE | TIMER_NO_HASH_WAIT)


/obj/structure/hazard/proc/on_entered(datum/source, atom/movable/AM)
	SIGNAL_HANDLER

	var/target = AM
	if(on && !disabled)
		contact(target)

/obj/structure/hazard/Bumped(atom/movable/AM)
	if(!iseffect(AM) && on && !disabled)
		var/target = AM
		contact(target)

/obj/structure/hazard/bullet_act(obj/projectile/P)
	if(on && !disabled)
		attacked()
	. = ..()

/obj/structure/hazard/attack_tk(mob/user)
	if(on && !disabled)
		attacked()

/obj/structure/hazard/attack_paw(mob/user)
	if(on && !disabled)
		attacked()

/obj/structure/hazard/attack_alien(mob/living/carbon/alien/humanoid/user)
	if(on && !disabled)
		attacked()

/obj/structure/hazard/attack_animal(mob/living/simple_animal/M)
	if(on && !disabled)
		attacked()

/obj/structure/hazard/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	if(on && !disabled)
		attacked()

/obj/structure/hazard/proc/update_turf_slowdown(reset = FALSE)
	var/turf/open/OT = get_turf(src)
	if(!isopenturf(OT))
		return
	if(reset)
		OT.slowdown = initial(OT.slowdown)
	else
		OT.slowdown = initial(OT.slowdown) + slowdown

/obj/structure/hazard/slowdown/Destroy()
	update_turf_slowdown(TRUE)
	. = ..()
