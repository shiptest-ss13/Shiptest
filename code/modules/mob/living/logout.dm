/mob/living/Logout()
	..()
	if(mind && mind.active)
		player_logged = TRUE
	else
		player_logged = FALSE

	if(!key && mind)	//key and mind have become separated.
		mind.active = 0	//This is to stop say, a mind.transfer_to call on a corpse causing a ghost to re-enter its body.

	LAZYREMOVEASSOC(SSmobs.players_by_virtual_z, "[virtual_z()]", src)
