/obj/machinery/power/emitter/energycannon
	name = "Energy Cannon"
	desc = "A heavy duty industrial laser."
	icon = 'icons/obj/singularity.dmi'
	icon_state = "emitter_+a"
	base_icon_state = "emitter_+a"
	anchored = TRUE
	density = TRUE
	resistance_flags = INDESTRUCTIBLE | FIRE_PROOF | ACID_PROOF

	use_power = NO_POWER_USE
	idle_power_usage = 0
	active_power_usage = 0

	active = TRUE
	locked = TRUE
	welded = TRUE

/obj/machinery/power/emitter/energycannon/RefreshParts()
	return

/obj/machinery/power/emitter/energycannon/ctf
	processing_flags = START_PROCESSING_MANUALLY

/obj/machinery/power/emitter/energycannon/ctf/proc/toggle_ctf(ctf_enabled)
	src.active = ctf_enabled
	if(ctf_enabled)
		START_PROCESSING(SSmachines, src)
	else
		STOP_PROCESSING(SSmachines, src)
