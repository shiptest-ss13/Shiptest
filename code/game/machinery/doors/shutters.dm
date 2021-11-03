/obj/machinery/door/poddoor/shutters
	gender = PLURAL
	name = "shutters"
	desc = "Heavy duty metal shutters that open mechanically."
	icon = 'icons/obj/doors/shutters.dmi'
	layer = SHUTTER_LAYER
	closingLayer = SHUTTER_LAYER
	damage_deflection = 20
	open_sound = 'sound/machines/shutters_open.ogg'
	close_sound = 'sound/machines/shutters_close.ogg'

/obj/machinery/door/poddoor/shutters/preopen
	icon_state = "open"
	density = FALSE
	opacity = FALSE

/obj/machinery/door/poddoor/shutters/indestructible
	name = "hardened shutters"
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

/obj/machinery/door/poddoor/gates
	gender = PLURAL
	name = "gate"
	desc = "A gate made out of hard metal."
	icon = 'icons/obj/doors/gates.dmi'
	layer = SHUTTER_LAYER
	closingLayer = SHUTTER_LAYER
	damage_deflection = 20
	open_sound = 'sound/machines/gate.ogg'
	close_sound = 'sound/machines/gate.ogg'
	glass = TRUE
	opacity = FALSE

/obj/machinery/door/poddoor/gates/indestructible
	name = "hardened gates"
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

/obj/machinery/door/poddoor/gates/indestructible/preopen
	icon_state = "open"
	density = FALSE
	opacity = FALSE

/obj/machinery/door/poddoor/gates/preopen
	icon_state = "open"
	glass = TRUE
	density = FALSE
	opacity = FALSE

/obj/machinery/door/poddoor/crusher
	gender = PLURAL
	name = "industrial presser"
	desc = "A machine that presses materials into plates."
	icon = 'icons/obj/doors/crusher.dmi'
	damage_deflection = 70
	glass = TRUE

/obj/machinery/door/poddoor/crusher/crush()
	. = ..()
	for(var/mob/living/L in get_turf(src))
		var/mob/living/carbon/C = L
		if(istype(C))
			C.bleed(150)
			C.apply_damage(75, forced=TRUE, spread_damage=TRUE)
			C.AddElement(/datum/element/squish, 80 SECONDS)
		else
			L.apply_damage(75, forced=TRUE)

		L.Paralyze(60)
		playsound(L, 'sound/effects/blobattack.ogg', 40, TRUE)
		playsound(L, 'sound/effects/splat.ogg', 50, TRUE)
/*
	for(var/obj/item/stack/ore/O in get_turf(src))
		new O.refined_type/R(src())
		R.amount = O.amount
		O.use(O.amount)
*/
/obj/machinery/door/poddoor/crusher/close()
	. = ..()
	playsound(src, 'sound/effects/bang.ogg', 30, TRUE)

/obj/machinery/door/poddoor/crusher/automatic
	desc = "A machine that presses materials into plates. This one seems to be still functioning."
	var/is_open = FALSE //because it doesnt even track it on machinery/door

/obj/machinery/door/poddoor/crusher/automatic/preopen
	icon_state = "open"
	is_open = FALSE
	density = FALSE
	opacity = FALSE

/obj/machinery/door/poddoor/crusher/automatic/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSobj, src)
	//COOLDOWN_START(src, 3 SECONDS)

/obj/machinery/door/poddoor/crusher/automatic/Destroy()
	. = ..()
	STOP_PROCESSING(SSobj, src)

/obj/machinery/door/poddoor/crusher/automatic/open()
	. = ..()
	is_open = TRUE

/obj/machinery/door/poddoor/crusher/automatic/close()
	. = ..()
	is_open = FALSE

/obj/machinery/door/poddoor/crusher/automatic/process(delta_time)
	if(is_open)
		close()
	else
		open()
