/obj/effect/forcefield
	desc = "A space wizard's magic wall."
	name = "FORCEWALL"
	icon_state = "m_shield"
	anchored = TRUE
	opacity = FALSE
	density = TRUE
	CanAtmosPass = ATMOS_PASS_DENSITY
	var/timeleft = 300 //Set to 0 for permanent forcefields (ugh)

/obj/effect/forcefield/Initialize(mapload, new_timeleft)
	. = ..()
	//used to change the time for forcewine
	if(new_timeleft)
		timeleft = new_timeleft
	if(timeleft)
		QDEL_IN(src, timeleft)

/obj/effect/forcefield/singularity_pull()
	return

///////////Mimewalls///////////

/obj/effect/forcefield/mime
	icon_state = "nothing"
	name = "invisible wall"
	desc = "You have a bad feeling about this."
	alpha = 0

/obj/effect/forcefield/mime/advanced
	name = "invisible blockade"
	desc = "You're gonna be here awhile."
	timeleft = 600

/obj/effect/forcefield/resin
	desc = "It's rapidly decaying!"
	name = "resin"
	icon_state = "atmos_resin"
	CanAtmosPass = ATMOS_PASS_NO
	timeleft = 1
