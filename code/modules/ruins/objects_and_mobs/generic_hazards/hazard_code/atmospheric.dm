/obj/structure/hazard/atmospheric
	name = "atmospheric hazard"
	desc = "if you're seeing this, tell a maptainer! FWOOSH!"
	icon_state = "hazard"

	var/random_gas = FALSE
	var/contact_gas = FALSE
	var/created_gas = GAS_H2O
	var/mols_created_gas = 20
	var/max_pressure = 303
	var/temperature = T20C

/obj/structure/hazard/atmospheric/Initialize()
	//if contact, need to set enter_activated
	if(contact_gas)
		enter_activated = TRUE
	//if random, need to set random_effect
	if(random_gas)
		random_effect = TRUE
	. = ..()

/obj/structure/hazard/atmospheric/do_random_effect()
	if(random_gas)
		emit_gas()

/obj/structure/hazard/atmospheric/contact(target)
	if(contact_gas)
		emit_gas()

/obj/structure/hazard/atmospheric/proc/emit_gas()
	var/datum/gas_mixture/air = loc.return_air()
	if(air.return_pressure() >= max_pressure)
		return
	playsound(src, pick('sound/effects/smoke.ogg','sound/effects/space_wind.ogg'), 15, TRUE, -1)
	atmos_spawn_air("[created_gas]=[mols_created_gas];TEMP=[temperature]")
