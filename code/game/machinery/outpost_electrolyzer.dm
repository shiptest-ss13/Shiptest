//allows production of hydrogen from ice chunks
#define MOLS_PER_ICE 50

/obj/machinery/mineral/electrolyzer_unloader
	name = "ice unloading machine"
	icon = 'icons/obj/machines/mining_machines.dmi'
	icon_state = "unloader"
	density = TRUE
	input_dir = WEST
	output_dir = EAST
	needs_item_input = TRUE
	processing_flags = START_PROCESSING_MANUALLY

/obj/machinery/mineral/electrolyzer_unloader/pickup_item(datum/source, atom/movable/target, atom/oldLoc)
	if(istype(target, /obj/structure/ore_box))
		var/obj/structure/ore_box/box = target
		for(var/obj/item/stack/ore/ice/chunk in box)
			unload_mineral(chunk)
	else if(istype(target, /obj/item/stack/ore/ice))
		var/obj/item/stack/ore/chunk = target
		unload_mineral(chunk)

/obj/machinery/mineral/electrolyzer
	name = "ice crusher"
	desc = "Breaks down ice into hydrogen and oxygen."
	icon = 'icons/obj/recycling.dmi'
	icon_state = "grinder-o1"
	input_dir = WEST
	density = TRUE
	use_power = IDLE_POWER_USE
	idle_power_usage = 50
	active_power_usage = 1000
	max_integrity = 500
	var/crush_damage = 1000
	var/datum/weakref/attached_output

/obj/machinery/mineral/electrolyzer/Initialize()
	. = ..()
	update_appearance()
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(on_entered),
	)
	AddElement(/datum/element/connect_loc, loc_connections)

/obj/machinery/mineral/electrolyzer/CanAllowThrough(atom/movable/mover, border_dir)
	. = ..()
	if(!anchored)
		return
	if(border_dir == input_dir)
		return TRUE

/obj/machinery/mineral/electrolyzer/proc/on_entered(datum/source, atom/movable/AM)
	SIGNAL_HANDLER
	set_electrolyzer_output()
	INVOKE_ASYNC(src, PROC_REF(electrolyze), AM)


/obj/machinery/mineral/electrolyzer/proc/electrolyze(atom/movable/electrolyze_target, sound=TRUE)
	if(machine_stat & (BROKEN|NOPOWER))
		return
	if(!isturf(electrolyze_target.loc))
		return
	if(istype(electrolyze_target, /obj/effect))
		return	//effects are not touchable

	var/list/to_electrolyze = electrolyze_target.GetAllContents()

	var/list/electrolyze = list()

	var/not_electrolyzed //used to play sounds if something that isnt ice gets chucked in

	var/obj/machinery/atmospherics/components/binary/electrolyzer_out/resolved_output = attached_output?.resolve()

	if(!resolved_output)
		return
	for(var/atom/movable/target as anything in to_electrolyze)
		if(istype(target, /obj/item/stack/ore/ice))
			electrolyze += target
			continue
		not_electrolyzed = TRUE
		if(isliving(target))
			crush_living(target)
	if(not_electrolyzed)
		playsound(src, 'sound/machines/buzz-sigh.ogg', 50, FALSE, 1) // Dont play a ton of sounds for a ton of items
	for(var/electro in electrolyze)
		resolved_output.electrolyze_item(electro)

	if(!ismob(electrolyze_target)) //MULCH IT IF IT AINT ICE
		qdel(electrolyze_target)


/obj/machinery/mineral/electrolyzer/proc/set_electrolyzer_output()
	for(var/direction in GLOB.cardinals)
		for(var/obj/machinery/atmospherics/components/binary/electrolyzer_out/found in get_step(get_turf(src), direction))
			attached_output = WEAKREF(found)
			update_icon_state()
			return TRUE

/obj/machinery/mineral/electrolyzer/proc/crush_living(mob/living/L)

	L.forceMove(loc)

	if(issilicon(L))
		playsound(src, 'sound/items/welder.ogg', 50, TRUE)
	else
		playsound(src, 'sound/effects/splat.ogg', 50, TRUE)

	if(iscarbon(L) && L.stat == CONSCIOUS)
		L.emote("scream")

	// Instantly lie down, also go unconscious from the pain, before you die.
	L.Unconscious(100)
	L.adjustBruteLoss(crush_damage)

/obj/machinery/atmospherics/components/binary/electrolyzer_out
	name = "electrolyzing chamber"
	desc = "Breaks down ice into hydrogen and oxygen."
	icon = 'icons/obj/shuttle.dmi'
	icon_state = "heater_pipe"

	use_power = IDLE_POWER_USE
	idle_power_usage = 50
	active_power_usage = 1000

	density = TRUE
	max_integrity = 400
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 100, "bomb" = 0, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 30)
	layer = OBJ_LAYER
	showpipe = TRUE
	pipe_flags = PIPING_ONE_PER_TURF | PIPING_DEFAULT_LAYER_ONLY

/obj/machinery/atmospherics/components/binary/electrolyzer_out/process_atmos()
	update_parents()

/obj/machinery/atmospherics/components/binary/electrolyzer_out/proc/electrolyze_item(obj/item/I)
	var/datum/gas_mixture/air1 = airs[1] //hydrogen out
	var/datum/gas_mixture/air2 = airs[2] //oxygen out
	var/obj/item/stack/ore/ice/S = I
	var/molestomake = S.get_amount() * MOLS_PER_ICE
	air1.adjust_moles(GAS_HYDROGEN, molestomake)
	air1.set_temperature(T20C) //sets temp, otherwise the gas spawns at lowest possible temp
	air2.adjust_moles(GAS_O2, molestomake / 2)
	air2.set_temperature(T20C)
	update_parents()

#undef MOLS_PER_ICE
