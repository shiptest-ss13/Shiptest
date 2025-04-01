/*
slowing hazards! either requires laying down, has a chance to stick, or requires climbing on.
*/

/obj/structure/hazard/slowdown
	name = "slowing hazard"
	desc = "if you see this, tell a maptainer! Waaaait fooorrr meeee guyyyys.."
	icon_state = "hazard"
	density = FALSE
	//requires laying down to get through, like plastic flaps.
	var/overhead = FALSE
	//requires climbing over like tables
	climbable = FALSE
	//time to climb
	climb_time = 2 SECONDS

	//sticky like spiderwebs, very annoying.
	var/sticky = FALSE
	//chance you get stuck instead of walking into the hazard
	var/stick_chance = 50
	//chance the hazard eats a projectile
	var/projectile_stick_chance = 30

	//all hazards can use slowdown! but if you make a generic slowdown hazard, its good practice to make it hazard/slowdown
	slowdown = 0

/obj/structure/hazard/slowdown/CanAllowThrough(atom/movable/mover, border_dir)
	. = ..()
	//if this hazard is dense, stop players
	if(density)
		return FALSE
	//if this hazard is disabled or off, let players through
	if(!on || disabled)
		return TRUE
	//stops players if sticky or overhead checks return TRUE
	var/failed_check = FALSE
	if(sticky)
		failed_check += !sticky_checks(mover)
	if(overhead)
		failed_check += !overhead_checks(mover)
	if(failed_check)
		return FALSE
	else
		return TRUE

//based on plastic flaps, requires crawling under
/obj/structure/hazard/slowdown/proc/overhead_checks(atom/movable/mover)
	//lets lasers through if not opaque
	if(istype(mover) && (mover.pass_flags & PASSGLASS) && !opacity)
		return TRUE

	//people on beds and dense beds can't get through
	if(istype(mover, /obj/structure/bed))
		var/obj/structure/bed/bed_mover = mover
		if(bed_mover.density || bed_mover.has_buckled_mobs())
			return FALSE

	//people in cardboard boxes have to wait for their delay
	else if(istype(mover, /obj/structure/closet/cardboard))
		var/obj/structure/closet/cardboard/cardboard_mover = mover
		if(cardboard_mover.move_delay)
			return FALSE

	//no mechs!
	else if(ismecha(mover))
		return FALSE

	//actual living checks
	else if(isliving(mover))
		var/mob/living/living_mover = mover

		//bots (cleaning, medical, etc) can go under by default.
		if(isbot(mover))
			return TRUE

		//laying down, being a ventcrawler, or being tiny lets you through.
		if(living_mover.body_position == STANDING_UP && !living_mover.ventcrawler && living_mover.mob_size != MOB_SIZE_TINY)
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
