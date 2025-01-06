/obj/structure/hazard/radioactive/waste
	name = "leaking waste barrel"
	desc = "It wasn't uncommon for early vessels to simply dump their waste like this out the airlock. However this proved to be a terrible long-term solution."
	icon_state = "barrel_tipped"
	anchored = TRUE
	rad_power = 150
	rad_range = 0.8
	random_min = 1 SECONDS
	random_max = 2 SECONDS

/obj/structure/hazard/radioactive/stack
	name = "stack of nuclear waste"
	desc = "Discarded nuclar waste. If enough of this builds up around a planet, radioactive toxins can poison the whole atmosphere."
	icon_state = "barrel_3"
	anchored = TRUE
	rad_power = 300
	client_range = 6
	random_min = 1 SECONDS
	random_max = 1 SECONDS

/obj/structure/hazard/radioactive/supermatter
	name = "decayed supermatter crystal"
	desc = "An abandoned supermatter crystal undergoing extreme nuclear decay as a result of poor maintenence and disposal."
	icon_state = "smdecay"
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF //its an old SM, you shouldn't be able to just shoot it to death to deactivate it.
	anchored = TRUE
	rad_power = 1200
	rad_range = 0.2
	client_range = 7
	random_min = 0.5 SECONDS
	random_max = 0.5 SECONDS
