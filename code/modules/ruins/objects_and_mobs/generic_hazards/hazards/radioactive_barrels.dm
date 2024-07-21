/obj/structure/hazard/radioactive/waste
	name = "leaking waste barrel"
	desc = "It wasn't uncommon for early vessels to simply dump their waste like this out the airlock. However this proved to be a terrible long-term solution."
	icon_state = "barrel_tipped"
	anchored = TRUE
	rad_power = 150
	rad_range = 0.8
	cooldown_time = 1 SECONDS

/obj/structure/hazard/radioactive/stack
	name = "stack of nuclear waste"
	desc = "Discarded nuclar waste. If enough of this builds up around a planet, radioactive toxins can poison the whole atmosphere."
	icon_state = "barrel_3"
	anchored = TRUE
	rad_power = 300
	cooldown_time = 1 SECONDS

/obj/structure/hazard/radioactive/supermatter
	name = "decayed supermatter crystal"
	desc = "An abandoned supermatter crystal undergoing extreme nuclear decay as a result of poor maintenence and disposal."
	icon_state = "smdecay"
	anchored = TRUE
	rad_power = 1200
	rad_range = 0.2
	cooldown_time = 0.5 SECONDS
