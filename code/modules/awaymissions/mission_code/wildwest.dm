/* Code for the Wild West map by Brotemis
 * Contains:
 *		Wish Granter
 *		Meat Grinder
 */

///////////////Meatgrinder//////////////


/obj/effect/meatgrinder
	name = "Meat Grinder"
	desc = "What is that thing?"
	density = TRUE
	anchored = TRUE
	icon = 'icons/mob/blob.dmi'
	icon_state = "blobpod"
	var/triggered = 0

/obj/effect/meatgrinder/Initialize()
	. = ..()
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = .proc/on_entered,
	)
	AddElement(/datum/element/connect_loc, loc_connections)

/obj/effect/meatgrinder/proc/on_entered(datum/source, atom/movable/AM)
	SIGNAL_HANDLER
	Bumped(AM)

/obj/effect/meatgrinder/Bumped(atom/movable/AM)

	if(triggered)
		return
	if(!ishuman(AM))
		return

	var/mob/living/carbon/human/M = AM

	if(M.stat != DEAD && M.ckey)
		visible_message("<span class='warning'>[M] triggered [src]!</span>")
		triggered = 1

		var/datum/effect_system/spark_spread/s = new /datum/effect_system/spark_spread
		s.set_up(3, 1, src)
		s.start()
		explosion(M, 1, 0, 0, 0)
		qdel(src)
