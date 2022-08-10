/datum/research_design
	var/name
	var/id
	var/abstract = /datum/research_node

	/// Assosciative list of: typepath -> amount
	var/list/builds

	/// List of: material typepath -> amount
	var/list/costs

	var/buildtype_flags = NONE
	var/departmental_flags = NONE

/datum/research_design/proc/make_output(atom/output_loc)
	for(var/atom/movable/path as anything in builds)
		for(var/idx in 1 to builds[path])
			path = new path(null) // start in nullspace first, we want to call forceMove
			path.forceMove(output_loc) // to ensure signals are being sent correctly

/datum/research_design/proc/use_inputs(datum/component/remote_materials/material_store, input_mod = 1)
	var/list/using = list()
	for(var/material in costs)
		var/mat_needed = costs[material] * input_mod
		if(!mat_needed || material_store.mat_container.get_material_amount(material) < mat_needed)
			return FALSE
		using[material] = mat_needed
	for(var/material in using)
		material_store.mat_container.use_amount_mat(using[material], material)
	return TRUE

/datum/research_design/proc/attempt_create(mob/user, obj/machinery/machine)
	if(user.next_move < world.time)
		return
	user.changeNext_move(CLICK_CD_RAPID)

	var/datum/component/remote_materials/remote_materials = machine.GetComponent(/datum/component/remote_materials)
	if(!remote_materials)
		to_chat(user, span_warning("[machine] does not appear to contain any materials."))
		return FALSE
	if(remote_materials.on_hold())
		machine.say("Material access is currently suspended; contact your nearest Board Member.")
		return FALSE
	if(!use_inputs(remote_materials, get_input_modifier(user, machine)))
		to_chat(user, span_warning("Not enough materials to process that design."))
		return FALSE
	make_output(machine.drop_location())
	return TRUE

/datum/research_design/proc/get_input_modifier(mob/user, obj/machinery/machine)
	return 1

/datum/research_design/engineering
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING

/datum/research_design/science
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/research_design/security
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/research_design/service
	departmental_flags = DEPARTMENTAL_FLAG_SERVICE

/datum/research_design/cargo
	departmental_flags = DEPARTMENTAL_FLAG_CARGO

/datum/research_design/medical
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL
