SUBSYSTEM_DEF(icon_smooth)
	name = "Icon Smoothing"
	init_order = INIT_ORDER_ICON_SMOOTHING
	wait = 1
	priority = FIRE_PRIOTITY_SMOOTHING
	flags = SS_TICKER

	///Blueprints assemble an image of what pipes/manifolds/wires look like on initialization, and thus should be taken after everything's been smoothed
	var/list/smooth_queue = list()
	var/list/deferred = list()

	/// An associative list matching atom types to their typecaches of connector exceptions. Their no_connector_typecache var is overridden to the
	/// element in this list associated with their type; if no such element exists, and their no_connector_typecache is nonempty, the typecache is created
	/// according to the type's default value for no_connector_typecache, that typecache is added to this list, and the variable is set to that typecache.
	var/list/type_no_connector_typecaches = list()

/datum/controller/subsystem/icon_smooth/fire()
	var/list/cached = smooth_queue
	while(cached.len)
		var/atom/smoothing_atom = cached[length(cached)]
		cached.len--
		if(QDELETED(smoothing_atom) || !(smoothing_atom.smoothing_flags & SMOOTH_QUEUED))
			continue
		if(smoothing_atom.flags_1 & INITIALIZED_1)
			smoothing_atom.smooth_icon()
		else
			deferred += smoothing_atom
		if (MC_TICK_CHECK)
			return

	if (!cached.len)
		if (deferred.len)
			smooth_queue = deferred
			deferred = cached
		else
			can_fire = FALSE

/datum/controller/subsystem/icon_smooth/Initialize()
	smooth_zlevel(1, TRUE)
	smooth_zlevel(2, TRUE)

	var/list/queue = smooth_queue
	smooth_queue = list()

	while(queue.len)
		var/atom/smoothing_atom = queue[length(queue)]
		queue.len--
		if(QDELETED(smoothing_atom) || !(smoothing_atom.smoothing_flags & SMOOTH_QUEUED) || smoothing_atom.z <= 2)
			continue
		smoothing_atom.smooth_icon()
		CHECK_TICK

	return ..()


/datum/controller/subsystem/icon_smooth/proc/add_to_queue(atom/thing)
	if(thing.smoothing_flags & SMOOTH_QUEUED)
		return
	thing.smoothing_flags |= SMOOTH_QUEUED
	smooth_queue += thing
	if(!can_fire)
		can_fire = TRUE

/datum/controller/subsystem/icon_smooth/proc/remove_from_queues(atom/thing)
	thing.smoothing_flags &= ~SMOOTH_QUEUED
	smooth_queue -= thing
	deferred -= thing

/datum/controller/subsystem/icon_smooth/proc/get_no_connector_typecache(cache_key, list/no_connector_types, connector_strict_typing)
	var/list/cached_typecache = type_no_connector_typecaches[cache_key]
	if(cached_typecache)
		return cached_typecache

	var/list/new_typecache = typecacheof(no_connector_types, only_root_path = connector_strict_typing)
	type_no_connector_typecaches[cache_key] = new_typecache
	return new_typecache
