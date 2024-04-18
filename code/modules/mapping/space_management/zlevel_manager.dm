// Populate the space level list and prepare space transitions
/datum/controller/subsystem/mapping/proc/InitializeDefaultZLevels()
	if (z_list)  // subsystem/Recover or badminnery, no need
		return

	z_list = list()
	var/list/default_map_traits = DEFAULT_MAP_TRAITS

	if (default_map_traits.len != world.maxz)
		WARNING("More or less map attributes pre-defined ([default_map_traits.len]) than existent z-levels ([world.maxz]). Ignoring the larger.")
		if (default_map_traits.len > world.maxz)
			default_map_traits.Cut(world.maxz + 1)

	for (var/I in 1 to default_map_traits.len)
		var/list/features = default_map_traits[I]
		var/name = features[DL_NAME]
		var/list/traits = features[DL_TRAITS]
		var/datum/space_level/S = new(I, name)
		z_list += S
		var/datum/map_zone/mapzone = new(name)
		new /datum/virtual_level(name, traits, mapzone, 1, 1, world.maxx, world.maxy, I)

/// Adds new physical space level. DO NOT USE THIS TO LOAD SOMETHING NEW. SSmapping.get_free_allocation() will create any levels nessecary and pass you coordinates to create a new virtual level
/datum/controller/subsystem/mapping/proc/add_new_zlevel(name, z_type = /datum/space_level, allocation_type = ALLOCATION_FREE)
	SHOULD_NOT_SLEEP(TRUE)
	// This proc used to sleep. It caused an infuriating desynchronization: new_z would calculate, the max z would be increased, and then the proc used CHECK_TICK.
	// As a result, two space_levels could be added to the z_list, each believing itself to reside at the same z-coodinate.
	// Watch your fucking race conditions.
	SEND_GLOBAL_SIGNAL(COMSIG_GLOB_NEW_Z, args)
	var/new_z = z_list.len + 1
	if (world.maxz < new_z)
		world.incrementMaxZ()
	var/datum/space_level/S = new z_type(new_z, name, allocation_type)
	z_list += S
	return S

/datum/controller/subsystem/mapping/proc/get_level(z)
	if (z_list && z >= 1 && z <= z_list.len)
		return z_list[z]
	CRASH("Unmanaged z-level [z]! maxz = [world.maxz], z_list.len = [z_list ? z_list.len : "null"]")
