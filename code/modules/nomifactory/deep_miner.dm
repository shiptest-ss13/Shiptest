/obj/machinery/nomifactory/deep_miner
	name = "Deep Core Tertiary Miner"
	circuit = /obj/item/circuitboard/machine/nomifactory/deep_miner

	/// Whether we are disabled from invalid location
	var/location_overload = FALSE
	/// Maximum number of outputs allowed to roll
	var/max_outputs = 2
	/// A list indexed by item with a value of the probability
	var/list/output_probability_map
	var/progress = 0
	var/payout_progress = 20

/obj/machinery/nomifactory/deep_miner/multitool_act(mob/living/user, obj/item/I)
	if(!location_overload)
		return ..()

	say("Resetting circuitry...")
	location_overload = FALSE
	return COMPONENT_BLOCK_TOOL_ATTACK

/obj/machinery/nomifactory/deep_miner/Initialize()
	. = ..()
	output_probability_map = output_probability_map || create_output_map()

/obj/machinery/nomifactory/deep_miner/is_operational()
	return ..() && !location_overload

/obj/machinery/nomifactory/deep_miner/nomifactory_process()
	if(!valid_location())
		say("Invalid sediment content, internal circuitry overloaded!")
		location_overload = TRUE
		return

	if(progress++ > payout_progress)
		progress = 0
		payout()

/obj/machinery/nomifactory/deep_miner/proc/create_output_map()
	return list(
		/obj/item/stack/ore/glass = 50,
		/obj/item/stack/ore/iron = 40,
		/obj/item/stack/ore/gold = 35,
		/obj/item/stack/ore/uranium = 20,
		/obj/item/stack/ore/plasma = 20,
		/obj/item/stack/ore/titanium = 15,
		/obj/item/stack/ore/diamond = 10,
		/obj/item/stack/ore/bluespace_crystal = 2,
		/obj/item/stack/ore/bananium = 1,
		/obj/item/stack/ore/slag = 1
	)

/obj/machinery/nomifactory/deep_miner/proc/valid_location()
	var/turf/my_turf = get_turf(src)
	if(my_turf != loc)
		return FALSE

	if(isspaceturf(my_turf) || isclosedturf(my_turf))
		return FALSE

	var/static/list/valid_turfs = list(
		/turf/open/floor/plating/asteroid,
		/turf/open/floor/plating/ironsand,
		/turf/open/floor/plating/ashplanet
	)
	return is_type_in_list(my_turf, valid_turfs)

/obj/machinery/nomifactory/deep_miner/proc/payout()
	var/list/outputs = new
	say("Processing mineral load...")

	for(var/output in output_probability_map)
		if(!prob(output_probability_map[output]))
			continue
		outputs[output] = output_probability_map[output]

	if(!length(outputs))
		say("failed to procure any usable sediment.")
		return

	while(length(outputs) > max_outputs)
		var/highest_type
		for(var/output in outputs)
			if(!highest_type || outputs[output] > outputs[highest_type])
				highest_type = output
		outputs -= highest_type

	for(var/output in outputs)
		if(!ismovable(output))
			stack_trace("illegal output for [src]: [output]")
			continue
		var/atom/movable/output_atom = new output
		do_output(output_atom)
