//GREEBLES

/obj/effect/spawner/random/greeble/random_ruin_greeble
	name = "random planet greeble chance"
	loot = list(
			/obj/effect/greeble_spawner/moon/crater1 = 5,
			/obj/effect/greeble_spawner/moon/crater2 = 5,
			/obj/effect/greeble_spawner/moon/crater3 = 5,
			/obj/effect/greeble_spawner/moon/crater4 = 5,
			/obj/effect/greeble_spawner/moon/crater5 = 5,
			/obj/effect/greeble_spawner/moon/crater6 = 5,
		)

/obj/effect/spawner/random/greeble/random_ruin_greeble/spawn_loot(lootcount_override)
	var/lootspawn = pick_weight_recursive(loot)
	if(!can_spawn(lootspawn))
		return
	make_item(get_turf(src), lootspawn)

/obj/effect/greeble_spawner
	name = "planet greeble spawner"
	icon = 'icons/effects/mapping/landmarks_static.dmi'
	icon_state = "x"
	var/datum/map_template/greeble/template = /datum/map_template/greeble/moon/crater1
	/// Amount of time before the mapgen gives up on loading this greeble.
	var/timeout = 8 SECONDS

/obj/effect/greeble_spawner/Destroy()
	template = null // without this, capsules would be one use. per round.
	. = ..()

/obj/effect/greeble_spawner/Initialize()
	. = ..()
	if(isnull(loc))
		return INITIALIZE_HINT_QDEL

/obj/effect/greeble_spawner/proc/start_load()
	template = new template()
	if(!template)
		WARNING("Greeble template not found!")
		qdel(src)
		return

	var/turf/deploy_location = get_turf(src)
	var/status = template.check_deploy(deploy_location)

	if(status != SHELTER_DEPLOY_ALLOWED)
		qdel(src)
		return

	template.load(deploy_location, centered = TRUE, show_oob_error = FALSE, timeout = timeout)
	qdel(src)

/datum/map_template/greeble
	var/description
	var/blacklisted_turfs
	var/whitelisted_turfs
	var/banned_areas
	var/banned_objects
	var/clear_everything = FALSE

/datum/map_template/greeble/New()
	. = ..()
	banned_areas = typecacheof(/area/ship, /area/overmap_encounter/planetoid/cave, /area/ruin)
	blacklisted_turfs = typecacheof(list(/turf/closed, /turf/open/indestructible))
	whitelisted_turfs = typecacheof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)

/datum/map_template/greeble/proc/check_deploy(turf/deploy_location)
	if(isnull(deploy_location))
		return SHELTER_DEPLOY_BAD_TURFS

	var/affected = get_affected_turfs(deploy_location, centered=TRUE)
	for(var/turf/T in affected)
		var/area/A = get_area(T)
		if(is_type_in_typecache(A, banned_areas))
			return SHELTER_DEPLOY_BAD_AREA

		var/banned = is_type_in_typecache(T, blacklisted_turfs)
		var/permitted = is_type_in_typecache(T, whitelisted_turfs)
		if(banned && !permitted)
			return SHELTER_DEPLOY_BAD_TURFS

		for(var/obj/O in T)
			if((O.density && O.anchored) || is_type_in_typecache(O, banned_objects))
				return SHELTER_DEPLOY_ANCHORED_OBJECTS


	if(clear_everything)
		for(var/turf/T in affected)
			for(var/obj/O in T)
				if(istype(O, /obj/effect/greeble_spawner))
					continue
				qdel(O)
			for(var/mob/M in T)
				qdel(M)

	return SHELTER_DEPLOY_ALLOWED


/obj/effect/greeble_spawner/grass_patch_spawner
	name = "grass patch spawner"
	///what turf are we spreading
	var/turf/open/floor/turf_to_spread
	///do we only spread on the same turf we spawned on, or do we spread to any turf? Might smoothen out biome transitions?
	var/only_spread_on_spawning_turf = FALSE
	///generates in a + 3x3 shape if true
	var/big_brush = FALSE
	///how many turfs is this patch capped at?
	var/max_turfs_to_spread = 8
	///minimum amount of turfs to spread?
	var/min_turfs_to_spread = 3
	///if true, the patch will not "move" backwards from the first direction it creatse in
	var/patch_direction_locked = TRUE
	///the % chance every "move" to return early before we hit max_turfs_to_spread
	var/chance_to_terminate = 20
	///adds this number to chance_to_terminate every time we generate a tile
	var/terminate_chance_add = 6


/obj/effect/greeble_spawner/grass_patch_spawner/start_load()
	var/current_turfs_spawned = 0
	var/turf/open/current_turf = get_turf(src)
	var/turf/open/initial_turf_type
	var/list/previous_turfs = list()
	var/forbidden_spread_dir
	var/list/possible_dirs

	if(!istype(current_turf))
		qdel(src)
		return FALSE

	initial_turf_type = current_turf.type

	//scans and replaces turfs
	for(current_turfs_spawned in 1 to max_turfs_to_spread)
		if(current_turfs_spawned >= max_turfs_to_spread)
			qdel(src)
			return TRUE

		if(!current_turfs_spawned || current_turfs_spawned < min_turfs_to_spread || !prob(chance_to_terminate))
			current_turf.ChangeTurf(turf_to_spread, turf_to_spread::baseturfs, CHANGETURF_IGNORE_AIR|CHANGETURF_DEFER_CHANGE|CHANGETURF_DEFER_BATCH)
			if(big_brush)
				for(var/direction in GLOB.cardinals)
					var/turf/open/turf_to_change = get_step(current_turf, direction)
					if(!istype(turf_to_change) || !isopenturf(turf_to_change))
						continue
					turf_to_change.ChangeTurf(turf_to_spread, turf_to_spread::baseturfs, CHANGETURF_IGNORE_AIR|CHANGETURF_DEFER_CHANGE|CHANGETURF_DEFER_BATCH)
			current_turfs_spawned++
		else
			qdel(src)
			return TRUE

		possible_dirs = GLOB.cardinals.Copy()

		if(forbidden_spread_dir)
			possible_dirs -= forbidden_spread_dir

		//check next turfs to see if their valid or not
		for(var/checked_dir in possible_dirs)
			var/turf/open/checked_turf = get_step(current_turf, checked_dir)
			if(!istype(checked_turf))
				possible_dirs -= checked_dir
				continue
			if(!isopenturf(checked_turf))
				possible_dirs -= checked_dir
				continue
			if(!big_brush && istype(checked_turf, turf_to_spread))
				possible_dirs -= checked_dir
				continue
			if(big_brush && (checked_turf in previous_turfs))
				possible_dirs -= checked_dir
				continue
			if(only_spread_on_spawning_turf && !big_brush && !istype(checked_turf, initial_turf_type))
				possible_dirs -= checked_dir
				continue

		if(possible_dirs.len == 0)
			qdel(src)
			return TRUE
		var/next_dir = pick(possible_dirs)

		//if we dont have a forbiden dir and we are set to direction lock ourselves, we pick the opposite of the picked direction to forbid
		if(forbidden_spread_dir && patch_direction_locked)
			forbidden_spread_dir = REVERSE_DIR(next_dir)

		previous_turfs += current_turf
		current_turf = get_step(current_turf, next_dir)
		chance_to_terminate += terminate_chance_add

/obj/effect/greeble_spawner/grass_patch_spawner/dark_jungle
	name = "dark jungle grass patch spawner"
	turf_to_spread = /turf/open/floor/plating/asteroid/dirt/grass/jungle/dark
	big_brush = TRUE
	only_spread_on_spawning_turf = TRUE
	max_turfs_to_spread = 16
	min_turfs_to_spread = 3
	patch_direction_locked = FALSE
	chance_to_terminate = 0
	terminate_chance_add = 3

/obj/effect/greeble_spawner/grass_patch_spawner/yellow_jungle
	name = "yellow jungle grass patch spawner"
	turf_to_spread = /turf/open/floor/plating/asteroid/dirt/grass/jungle/yellow
	big_brush = FALSE
	only_spread_on_spawning_turf = FALSE
	max_turfs_to_spread = 5
	min_turfs_to_spread = 2
	chance_to_terminate = 5
	terminate_chance_add = 8

/obj/effect/greeble_spawner/grass_patch_spawner/dark
	name = "dark grass patch spawner"
	turf_to_spread = /turf/open/floor/plating/asteroid/dirt/grass/dark
	big_brush = TRUE
	only_spread_on_spawning_turf = TRUE
	max_turfs_to_spread = 8
	min_turfs_to_spread = 3
	patch_direction_locked = TRUE
	chance_to_terminate = 0
	terminate_chance_add = 5

/obj/effect/greeble_spawner/grass_patch_spawner/dark_jungle/thin
	big_brush = FALSE
	patch_direction_locked = TRUE
