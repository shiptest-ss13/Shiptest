/datum/radiation_wave
	/// The thing that spawned this radiation wave
	var/source
	/// The center of the wave
	var/turf/master_turf
	/// How far we've moved
	var/steps=0
	/// How strong it was originaly
	var/intensity
	/// How much contaminated material it still has
	var/remaining_contam
	/// Higher than 1 makes it drop off faster, 0.5 makes it drop off half etc
	var/range_modifier
	/// The direction of movement
	var/move_dir
	/// The directions to the side of the wave, stored for easy looping
	var/list/__dirs
	/// Whether or not this radiation wave can create contaminated objects
	var/can_contaminate

/datum/radiation_wave/New(atom/_source, dir, _intensity=0, _range_modifier=RAD_DISTANCE_COEFFICIENT, _can_contaminate=TRUE)

	source = "[_source] \[[REF(_source)]\]"

	master_turf = get_turf(_source)

	move_dir = dir
	__dirs = list()
	__dirs+=turn(dir, 90)
	__dirs+=turn(dir, -90)

	intensity = _intensity
	remaining_contam = intensity
	range_modifier = _range_modifier
	can_contaminate = _can_contaminate

	START_PROCESSING(SSradiation, src)

/datum/radiation_wave/Destroy()
	. = QDEL_HINT_IWILLGC
	STOP_PROCESSING(SSradiation, src)
	..()

/datum/radiation_wave/process()
	master_turf = get_step(master_turf, move_dir)
	if(!master_turf)
		qdel(src)
		return
	steps++
	var/list/atoms = get_rad_atoms()

	var/strength
	if(steps>1)
		strength = INVERSE_SQUARE(intensity, max(range_modifier*steps, 1), 1)
	else
		strength = intensity

	if(strength<RAD_BACKGROUND_RADIATION)
		qdel(src)
		return

	if(radiate(atoms, FLOOR(min(strength,remaining_contam), 1)))
		//oof ow ouch
		remaining_contam = max(0,remaining_contam-((min(strength,remaining_contam)-RAD_MINIMUM_CONTAMINATION) * RAD_CONTAMINATION_STR_COEFFICIENT))
	check_obstructions(atoms) // reduce our overall strength if there are radiation insulators

/datum/radiation_wave/proc/get_rad_atoms()
	var/list/atoms = list()
	var/distance = steps
	var/cmove_dir = move_dir
	var/cmaster_turf = master_turf

	if(cmove_dir == NORTH || cmove_dir == SOUTH)
		distance-- //otherwise corners overlap

	atoms += get_rad_contents(cmaster_turf)

	var/turf/place
	for(var/dir in __dirs) //There should be just 2 dirs in here, left and right of the direction of movement
		place = cmaster_turf
		for(var/i in 1 to distance)
			place = get_step(place, dir)
			if(!place)
				break
			atoms += get_rad_contents(place)

	return atoms

/datum/radiation_wave/proc/check_obstructions(list/atoms)
	var/width = steps
	var/cmove_dir = move_dir
	if(cmove_dir == NORTH || cmove_dir == SOUTH)
		width--
	width = 1+(2*width)

	for(var/k in 1 to atoms.len)
		var/atom/thing = atoms[k]
		if(!thing)
			continue
		if (SEND_SIGNAL(thing, COMSIG_ATOM_RAD_WAVE_PASSING, src, width) & COMPONENT_RAD_WAVE_HANDLED)
			continue
		if (thing.rad_insulation != RAD_NO_INSULATION)
			intensity *= (1-((1-thing.rad_insulation)/width))

/datum/radiation_wave/proc/radiate(list/atoms, strength)
	var/can_contam = strength >= RAD_MINIMUM_CONTAMINATION
	var/contamination_strength = (strength-RAD_MINIMUM_CONTAMINATION) * RAD_CONTAMINATION_STR_COEFFICIENT
	contamination_strength = max(contamination_strength, RAD_BACKGROUND_RADIATION)
	var/list/contam_atoms = list()
	for(var/k in 1 to atoms.len)
		var/atom/thing = atoms[k]
		if(!thing)
			continue
		thing.rad_act(strength)

		// This list should only be for types which don't get contaminated but you want to look in their contents
		// If you don't want to look in their contents and you don't want to rad_act them:
		// modify the ignored_things list in __HELPERS/radiation.dm instead
		var/static/list/blacklisted = typecacheof(list(
			/turf,
			/obj/structure/cable,
			/obj/machinery/atmospherics,
			/obj/item/ammo_casing,
			/obj/item/implant,
			/obj/singularity
			))
		if(!can_contaminate || !can_contam || blacklisted[thing.type])
			continue
		if(thing.flags_1 & RAD_NO_CONTAMINATE_1 || SEND_SIGNAL(thing, COMSIG_ATOM_RAD_CONTAMINATING, strength) & COMPONENT_BLOCK_CONTAMINATION)
			continue

		if(contamination_strength > remaining_contam)
			contamination_strength = remaining_contam
		if(SEND_SIGNAL(thing, COMSIG_ATOM_RAD_CONTAMINATING, strength) & COMPONENT_BLOCK_CONTAMINATION)
			continue
		if(thing.flags_1 & RAD_NO_CONTAMINATE_1 || SEND_SIGNAL(thing, COMSIG_ATOM_RAD_CONTAMINATING, strength) & COMPONENT_BLOCK_CONTAMINATION)
			continue
		contam_atoms += thing
	var/did_contam = 0
	if(can_contam)
		var/num_targets = contam_atoms.len		// Waspstation Edit Begin - Fix radiation runtime
		if(num_targets)			// Check that theres something to contaminate
			var/rad_strength = ((strength-RAD_MINIMUM_CONTAMINATION) * RAD_CONTAMINATION_STR_COEFFICIENT)/ num_targets
			for(var/k in 1 to num_targets)
				var/atom/thing = contam_atoms[k]
				thing.AddComponent(/datum/component/radioactive, rad_strength, source)
				did_contam = 1			// Waspstation Edit End
	return did_contam
