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

/obj/effect/greeble_spawner
	name = "planet greeble spawner"
	icon = 'icons/effects/mapping/landmarks_static.dmi'
	icon_state = "x"
	var/datum/map_template/greeble/template = /datum/map_template/greeble/moon/crater1

/obj/effect/greeble_spawner/Destroy()
	template = null // without this, capsules would be one use. per round.
	. = ..()

/obj/effect/greeble_spawner/Initialize()
	. = ..()
	if(isnull(loc))
		return INITIALIZE_HINT_QDEL
	INVOKE_ASYNC(src, PROC_REF(start_load))

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

	template.load(deploy_location, centered = TRUE, show_oob_error = FALSE)
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
