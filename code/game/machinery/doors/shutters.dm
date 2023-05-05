/obj/machinery/door/poddoor/shutters
	gender = PLURAL
	name = "shutters"
	desc = "Heavy duty metal shutters that open mechanically."
	icon = 'icons/obj/doors/shutters.dmi'
	damage_deflection = 20
	smoothing_groups = list(SMOOTH_GROUP_AIRLOCK)
	open_sound = 'sound/machines/airlocks/shutters/shutters_open.ogg'
	close_sound = 'sound/machines/airlocks/shutters/shutters_close.ogg'

/obj/machinery/door/poddoor/shutters/preopen
	icon_state = "open"
	density = FALSE
	opacity = FALSE

/obj/machinery/door/poddoor/shutters/indestructible
	name = "hardened shutters"
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

/obj/machinery/door/poddoor/shutters/indestructible/preopen
	icon_state = "open"
	density = FALSE
	opacity = FALSE

/obj/machinery/door/poddoor/gates
	gender = PLURAL
	name = "gate"
	desc = "A gate made out of hard metal."
	icon = 'icons/obj/doors/gates.dmi'
	damage_deflection = 20
	open_sound = 'sound/machines/airlocks/gate.ogg'
	close_sound = 'sound/machines/airlocks/gate.ogg'
	glass = TRUE
	opacity = FALSE

/obj/machinery/door/poddoor/gates/indestructible
	name = "hardened gates"
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	move_resist = MOVE_FORCE_OVERPOWERING

/obj/machinery/door/poddoor/gates/indestructible/preopen
	icon_state = "open"
	density = FALSE
	opacity = FALSE

/obj/machinery/door/poddoor/gates/preopen
	icon_state = "open"
	glass = TRUE
	density = FALSE
	opacity = FALSE
