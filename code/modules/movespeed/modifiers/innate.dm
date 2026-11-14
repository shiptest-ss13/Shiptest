/datum/movespeed_modifier/strained_muscles
	multiplicative_slowdown = -0.55
	blacklisted_movetypes = (FLYING|FLOATING)

/datum/movespeed_modifier/pai_spacewalk
	multiplicative_slowdown = 2
	flags = IGNORE_NOSLOW

/datum/movespeed_modifier/species
	movetypes = ~FLYING
	variable = TRUE
