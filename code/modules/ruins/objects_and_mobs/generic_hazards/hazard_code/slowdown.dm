/*
slowing hazards! either requires laying down, has a chance to stick, or requires climbing on.
*/

/obj/structure/hazard/slowdown
	name = "slowing hazard"
	desc = "if you see this, tell a maptainer! Waaaait fooorrr meeee guyyyys.."
	icon_state = "hazard"
	//requires laying down to get through, like plastic flaps.
	var/overhead = FALSE
	//requires climbing over like tables
	climbable = FALSE
	//time to climb
	climb_time = 2 SECONDS

	//sticky like spiderwebs, very annoying.
	var/sticky = FALSE
	//chance you get stuck instead of walking into
	var/stick_chance = 50
	//chance it eats a projectile
	var/projectile_stick_chance = 30

	//all hazards can use slowdown! but if you make a generic slowdown hazard, its good practice to make it hazard/slowdown
	slowdown = 0

/obj/structure/hazard/slowdown/CanAllowThrough(atom/movable/mover, border_dir)
	. = ..()
	if(density)
		return FALSE
	if(!on || disabled)
		return TRUE
	var/failed_check = FALSE
	if(sticky)
		failed_check += !sticky_checks(mover)
	if(overhead)
		failed_check += !overhead_checks(mover)
	if(failed_check)
		return FALSE
	else
		return TRUE

//pretty much stolen from plastic flaps.
/obj/structure/hazard/slowdown/proc/overhead_checks(atom/movable/mover)
	if(istype(mover) && (mover.pass_flags & PASSGLASS) && !opacity)
		return TRUE

	if(istype(mover, /obj/structure/bed))
		var/obj/structure/bed/bed_mover = mover
		if(bed_mover.density || bed_mover.has_buckled_mobs())//if it's a bed/chair and is dense or someone is buckled, it will not pass
			return FALSE

	else if(istype(mover, /obj/structure/closet/cardboard))
		var/obj/structure/closet/cardboard/cardboard_mover = mover
		if(cardboard_mover.move_delay)
			return FALSE

	else if(ismecha(mover))
		return FALSE

	else if(isliving(mover)) // You Shall Not Pass!
		var/mob/living/living_mover = mover
		if(isbot(mover)) //Bots understand the secrets
			return TRUE
		if(living_mover.body_position == STANDING_UP && !living_mover.ventcrawler && living_mover.mob_size != MOB_SIZE_TINY)	//If you're not laying down, or a ventcrawler or a small creature, no pass.
			return FALSE
	return TRUE

//based on spider webs. very annoying!
/obj/structure/hazard/slowdown/proc/sticky_checks(atom/movable/mover)
	if(isliving(mover))
		if(prob(stick_chance))
			to_chat(mover, "<span class='danger'>You get stuck in \the [src] for a moment.</span>")
			return FALSE
		return TRUE
	else if(istype(mover, /obj/projectile))
		return prob(projectile_stick_chance)
