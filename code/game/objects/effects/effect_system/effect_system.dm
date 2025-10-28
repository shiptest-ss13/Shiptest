/* This is an attempt to make some easily reusable "particle" type effect, to stop the code
constantly having to be rewritten. An item like the jetpack that uses the ion_trail_follow system, just has one
defined, then set up when it is created with New(). Then this same system can just be reused each time
it needs to create more trails.A beaker could have a steam_trail_follow system set up, then the steam
would spawn and follow the beaker, even if it is carried or thrown.
*/


/obj/effect/particle_effect
	name = "particle effect"
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	pass_flags = PASSTABLE | PASSGRILLE
	anchored = TRUE

/obj/effect/particle_effect/Initialize()
	. = ..()
	GLOB.cameranet.updateVisibility(src)

/obj/effect/particle_effect/Destroy()
	GLOB.cameranet.updateVisibility(src)
	return ..()

/obj/effect/particle_effect/newtonian_move() // Prevents effects from getting registered for SSspacedrift
	return TRUE

/datum/effect_system
	var/number = 3
	var/cardinals = FALSE
	var/turf/location
	var/atom/holder
	var/effect_type
	var/total_effects = 0
	var/autocleanup = FALSE //will delete itself after use

/datum/effect_system/Destroy()
	holder = null
	location = null
	return ..()

/datum/effect_system/proc/set_up(n = 3, c = FALSE, loca)
	if(n > 10)
		n = 10
	number = n
	cardinals = c
	if(isturf(loca))
		location = loca
	else
		location = get_turf(loca)

/datum/effect_system/proc/attach(atom/atom)
	holder = atom

/datum/effect_system/proc/start()
	if(QDELETED(src))
		return
	for(var/i in 1 to number)
		if(total_effects > 20)
			return
		generate_effect()

/datum/effect_system/proc/generate_effect()
	if(holder)
		location = get_turf(holder)
	var/obj/effect/E = new effect_type(location)
	total_effects++
	var/direction
	if(cardinals)
		direction = pick(GLOB.cardinals)
	else
		direction = pick(GLOB.alldirs)
	var/steps_amt = rand(1, 3)
	addtimer(CALLBACK(src, PROC_REF(scoot), direction, E, steps_amt), 5)

/datum/effect_system/proc/scoot(direction, obj/effect/ref, steps)
	if(QDELETED(src))
		return
	var/step = get_step(ref, direction)
	if(isnull(step))
		return

	step_towards(ref, step)

	if(steps)
		addtimer(CALLBACK(src, PROC_REF(scoot), direction, ref, steps - 1), 5)
	else
		addtimer(CALLBACK(src, PROC_REF(decrement_total_effect)), 20)

/datum/effect_system/proc/decrement_total_effect()
	total_effects--
	if(autocleanup && total_effects <= 0)
		qdel(src)
