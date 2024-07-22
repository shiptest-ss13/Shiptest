/obj/structure/hazard
	name = "ruin hazard"
	desc = "tell a maptainer if you see this. you shouldnt!"
	icon = 'icons/obj/hazard/generic.dmi'
	icon_state = "hazard"
	anchored = TRUE
	density = TRUE
	//add clever ways to disable these hazards! even just tools is better than smashing it to bits. Make sure to overwrite if you want people to be able to destroy this.
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	COOLDOWN_DECLARE(cooldown)
	//cooldown on contact effects
	var/cooldown_time = 2 SECONDS
	//needs to be enabled for contact effects to work, please automatically set this on subtype inits (see electrical for example)
	var/enter_activated = FALSE

	//calls do_random_effect() with a delay between the random_min and random_max. if min and max are equal, the delay will be constant.
	var/random_effect = FALSE
	var/random_min = 10 SECONDS
	var/random_max = 30 SECONDS

	//Whether this hazard can be disabled. Does nothing without implementing a way to disable the hazard.
	var/can_be_disabled = FALSE
	//Can be used for do_afters on disable checks, also toolchecks.
	var/time_to_disable = 5 SECONDS
	//whether this hazard has been disabled, which no longer functions and doesn't listen to hazard shutoffs.
	var/disabled = FALSE
	//examine text shown if can_be_disabled is true. Make sure to set this if you add a way to disable your hazard.
	var/disable_text = "a way you don't know! (this needs to be set)"

	//ID for use with hazard shutoffs, should be set per map and not in code.
	var/id = null
	//whether this hazard is on or off. Offline hazards don't get contact() or do_random_effect() procs sent.
	var/on = TRUE

	//slowdown, which increases the slowdown of the turf the hazard is on. All hazards can use this.
	var/slowdown = 0

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

//on off procs

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

//real code

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

//contact checks, based on density.

/obj/structure/hazard/proc/on_entered(datum/source, atom/movable/AM)
	SIGNAL_HANDLER

	if(!iseffect(AM) && on && !disabled)
		var/target = AM
		contact(target)

/obj/structure/hazard/Bumped(atom/movable/AM)
	if(!iseffect(AM) && on && !disabled)
		var/target = AM
		contact(target)

//attacked checks

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

//slowdown code, sets the loc turf slowness. Make sure your hazard can't be moved if you do this, or it will cause issues.

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
	GLOB.ruin_hazards -= src
	return ..()
