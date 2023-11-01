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
		for(var/obj/item/stack/ore/ice/O in box)
			unload_mineral(O)
	else if(istype(target, /obj/item/stack/ore/ice))
		var/obj/item/stack/ore/O = target
		unload_mineral(O)

/obj/machinery/mineral/electrolyzer
	name = "ice crusher"
	desc = "breaks down ice into hydrogen and oxygen."
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
		COMSIG_ATOM_ENTERED = .proc/on_entered,
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
	INVOKE_ASYNC(src, .proc/electrolyze, AM)


/obj/machinery/mineral/electrolyzer/proc/electrolyze(atom/movable/AM0, sound=TRUE)
	if(machine_stat & (BROKEN|NOPOWER))
		return
	if(!isturf(AM0.loc))
		return
	if(istype(AM0, /obj/effect))
		return	//effects are not touchable

	var/list/to_electrolyze = AM0.GetAllContents()

	var/list/electrolyze = list()

	var/not_electrolyzed //used to play sounds if something that isnt ice gets chucked in

	var/obj/machinery/atmospherics/components/binary/electrolyzer_out/resolved_output = attached_output?.resolve()

	if(!resolved_output)
		return
	for(var/i in to_electrolyze)
		var/atom/movable/AM = i
		if(istype(AM, /obj/item/stack/ore/ice))
			electrolyze += AM
		else
			not_electrolyzed = 1
		if(isliving(AM))
			crush_living(AM)
	if(not_electrolyzed == 1)
		playsound(src, 'sound/machines/buzz-sigh.ogg', 50, FALSE, 1) // Dont play a ton of sounds for a ton of items
	for(var/electro in electrolyze)
		resolved_output.electrolyze_item(electro)

	if(!ismob(AM0)) //MULCH IT IF IT AINT ICE
		AM0.moveToNullspace()
		qdel(AM0)


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

	if(iscarbon(L))
		if(L.stat == CONSCIOUS)
			L.say("YOUWCH!!!!", forced="recycler grinding")

	// Instantly lie down, also go unconscious from the pain, before you die.
	L.Unconscious(100)
	L.adjustBruteLoss(crush_damage)

/obj/machinery/atmospherics/components/binary/electrolyzer_out
	name = "electrolyzing chamber"
	desc = "breaks down ice into hydrogen and oxygen."
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
	var/molstomakedebug //removewhendone


/obj/machinery/atmospherics/components/binary/electrolyzer_out/process_atmos()
	update_parents()

/obj/machinery/atmospherics/components/binary/electrolyzer_out/proc/electrolyze_item(obj/item/I)
	var/datum/gas_mixture/air1 = airs[1] //hydrogen out
	var/datum/gas_mixture/air2 = airs[2] //oxygen out
	var/obj/item/stack/ore/ice/S = I
	var/molstomake = S.get_amount() * MOLS_PER_ICE
	molstomakedebug = molstomake
	air1.adjust_moles (GAS_HYDROGEN, molstomake)
	air1.set_temperature (T20C)
	air2.adjust_moles (GAS_O2, molstomake / 2)
	air2.set_temperature (T20C)
	update_parents()
/*
/obj/machinery/mineral/electrolyzer
	name = "ice crusher"
	desc = "breaks down ice into hydrogen and oxygen."
	icon = 'icons/obj/recycling.dmi'
	icon_state = "grinder-o0"
	circuit = /obj/item/circuitboard/machine/electrolyzer
	input_dir = WEST
	output_dir = EAST
	density = TRUE
	use_power = IDLE_POWER_USE
	idle_power_usage = 50
	active_power_usage = 1000
	max_integrity = 500

	var/icon_name = "grinder-o"
	var/amount_produced = 50
	var/item_recycle_sound = 'sound/items/welder.ogg'


	/obj/machinery/electrolyzer/Initialize()
	. = ..()

/obj/machinery/electrolyzer/attackby(obj/item/I, mob/user, params)
	if(default_deconstruction_screwdriver(user, "grinder-oOpen", "grinder-o0", I))
		return

	if(default_pry_open(I))
		return

	if(default_deconstruction_crowbar(I))
		return
	return ..()

/obj/machinery/electrolyzer/CanAllowThrough(atom/movable/mover, border_dir)
	. = ..()
	if(!anchored)
		return
	if(border_dir == eat_dir)
		return TRUE

/obj/machinery/electrolyzer/proc/on_entered(datum/source, atom/movable/AM)
	SIGNAL_HANDLER
	INVOKE_ASYNC(src, .proc/electrolyze, AM)


/obj/machinery/electrolyzer/proc/electrolyze(atom/movable/AM0, sound=TRUE)
	if(machine_stat & (BROKEN|NOPOWER))
		return
	if(!isturf(AM0.loc))
		return
	if(istype(AM0, /obj/effect))
		return	//effects are not touchable

	var/list/to_electrolyze = AM0.GetAllContents()

	var/list/electrolyze = list()

	for(var/i in to_electrolyze)
		var/atom/movable/AM = i
		if(istype(AM, /obj/item/ice_chunk))
			electrolyze += AM
		else if (istype(AM, /obj/item))
			playsound(src, 'sound/machines/buzz-sigh.ogg', 20, FALSE)

	for(var/electrolyzed in electrolyze)
		electrolyze_item()


/obj/machinery/electrolyzer/proc/electrolyze(atom/movable/AM0, sound=TRUE)
	if(QDELETED(target))
		return
	if(machine_stat & (BROKEN|NOPOWER))
		return
	if(!isturf(AM0.loc))
		return
	if(istype(AM0, /obj/effect))
		return	//effects are not touchable

	var/list/to_electrolyze = AM0.GetAllContents()

	var/list/electrolyze = list()

	for(var/i in to_electrolyze)
		var/atom/movable/AM = i
		if(istype(AM, /obj/item))
			var/obj/item/bodypart/head/as_head = AM
			var/obj/item/mmi/as_mmi = AM
			if(istype(AM, /obj/item/organ/brain) || (istype(as_head) && as_head.brain) || (istype(as_mmi) && as_mmi.brain) || istype(AM, /obj/item/dullahan_relay))
				living_detected = TRUE
			nom += AM
		else if(isliving(AM))
			living_detected = TRUE
			crunchy_nom += AM
	var/not_eaten = to_eat.len - nom.len - crunchy_nom.len
	if(living_detected) // First, check if we have any living beings detected.
		if(obj_flags & EMAGGED)
			for(var/CRUNCH in crunchy_nom) // Eat them and keep going because we don't care about safety.
				if(isliving(CRUNCH)) // MMIs and brains will get eaten like normal items
					crush_living(CRUNCH)
		else // Stop processing right now without eating anything.
			emergency_stop()
			return
	for(var/nommed in nom)
		recycle_item(nommed)
	if(nom.len && sound)
		playsound(src, item_recycle_sound, (50 + nom.len*5), TRUE, nom.len, ignore_walls = (nom.len - 10)) // As a substitute for playing 50 sounds at once.
	if(not_eaten)
		playsound(src, 'sound/machines/buzz-sigh.ogg', (50 + not_eaten*5), FALSE, not_eaten, ignore_walls = (not_eaten - 10)) // Ditto.
	if(!ismob(AM0))
		AM0.moveToNullspace()
		qdel(AM0)
	else // Lets not move a mob to nullspace and qdel it, yes?
		for(var/i in AM0.contents)
			var/atom/movable/content = i
			content.moveToNullspace()
			qdel(content)

/obj/machinery/atmospherics/components/binary/electrolyzer_out
	name = "electrolyzing chamber"
	desc = "breaks down ice into hydrogen and oxygen."
	icon = 'icons/obj/shuttle.dmi'

	use_power = IDLE_POWER_USE
	idle_power_usage = 50
	active_power_usage = 1000

	density = TRUE
	max_integrity = 400
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 100, "bomb" = 0, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 30)
	layer = OBJ_LAYER
	showpipe = TRUE

/obj/machinery/atmospherics/components/binary/electrolyzer_out/electrolyze()
*/
