/obj/structure/hazard/electrical/wire_mess
	name = "wire tangle"
	desc = "a dense tangle of wires, likely electrified."
	icon_state = "wiremess"
	density = FALSE
	contact_sparks = TRUE
	contact_stun = TRUE
	stun_time = 30
	contact_damage = 15
	shock_flags = SHOCK_NOGLOVES | SHOCK_NOSTUN
	slowdown = 1

/obj/structure/hazard_shutoff/electrical_shutoff
	name = "rusting power switch"
	desc = "An old emergency shutoff switch for industrial power sources."
	icon_state = "electric_toggle"
	shutoff_message = "The lever creaks as you force it, toggling the old power system."
	cooldown_time = 5 SECONDS

/obj/structure/hazard_shutoff/electrical_shutoff/resets
	name = "power cycle button"
	desc = "a cracked button that's used to initiate a power cycle. You get the feeling this won't last very long."
	icon_state = "electric_reset"
	shutoff_message = "The button emits a mechanical clicking, starting a power reset cycle..."
	resets = 15 SECONDS

/obj/structure/hazard_shutoff/electrical_shutoff/activate(mob/user)
	. = ..()
	if(. == TRUE)
		do_sparks(1, TRUE, src)
