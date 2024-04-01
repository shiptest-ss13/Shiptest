#define STARLIGHT_RANGE_NOT_EMITTING 0
#define STARLIGHT_RANGE_EMITTING 2

/turf/open/space
	icon = 'icons/turf/space.dmi'
	icon_state = "0"
	name = "\proper space"
	intact = 0

	initial_temperature = TCMB
	thermal_conductivity = 0
	heat_capacity = 700000
	initial_gas_mix = AIRLESS_ATMOS

	FASTDMM_PROP(\
		pipe_astar_cost = 5\
	)

	var/static/datum/gas_mixture/immutable/space/space_gas
	plane = PLANE_SPACE
	layer = SPACE_LAYER
	light_power = 0.25
	dynamic_lighting = DYNAMIC_LIGHTING_DISABLED
	bullet_bounce_sound = null

	vis_flags = VIS_INHERIT_ID	//when this be added to vis_contents of something it be associated with something on clicking, important for visualisation of turf in openspace and interraction with openspace that show you turf.

/turf/open/space/basic/New()	//Do not convert to Initialize
	//This is used to optimize the map loader
	return

/**
 * Space Initialize
 *
 * Doesn't call parent, see [/atom/proc/Initialize]
 */
/turf/open/space/Initialize(mapload, inherited_virtual_z)
	SHOULD_CALL_PARENT(FALSE)
	icon_state = SPACE_ICON_STATE
	if(!space_gas)
		space_gas = new
	air = space_gas
	update_air_ref(AIR_REF_SPACE_TURF)
	vis_contents.Cut() //removes inherited overlays
	visibilityChanged()

	if(flags_1 & INITIALIZED_1)
		stack_trace("Warning: [src]([type]) initialized multiple times!")
	flags_1 |= INITIALIZED_1

	if(inherited_virtual_z)
		virtual_z = inherited_virtual_z

	if (length(smoothing_groups))
		// There used to be a sort here to prevent duplicate bitflag signatures
		// in the bitflag list cache; the cost of always timsorting every group list every time added up.
		// The sort now only happens if the initial key isn't found. This leads to some duplicate keys.
		// /tg/ has a better approach; a unit test to see if any atoms have mis-sorted smoothing_groups
		// or canSmoothWith. This is a better idea than what I do, and should be done instead.
		SET_BITFLAG_LIST(smoothing_groups)
	if (length(canSmoothWith))
		// If the last element is higher than the maximum turf-only value, then it must scan turf contents for smoothing targets.
		if(canSmoothWith[length(canSmoothWith)] > MAX_S_TURF)
			smoothing_flags |= SMOOTH_OBJ
		SET_BITFLAG_LIST(canSmoothWith)
	if (length(no_connector_typecache))
		no_connector_typecache = SSicon_smooth.get_no_connector_typecache(src.type, no_connector_typecache, connector_strict_typing)

	var/area/A = loc
	if(!IS_DYNAMIC_LIGHTING(src) && IS_DYNAMIC_LIGHTING(A))
		add_overlay(/obj/effect/fullbright)

	if (light_system == STATIC_LIGHT && light_power && light_range)
		update_light()

	if (opacity)
		directional_opacity = ALL_CARDINALS

	var/turf/T = above()
	if(T)
		T.multiz_turf_new(src, DOWN)
	T = below()
	if(T)
		T.multiz_turf_new(src, UP)

	ComponentInitialize()

	return INITIALIZE_HINT_NORMAL

/turf/open/space/Initalize_Atmos(times_fired)
	return

/turf/open/space/TakeTemperature(temp)

/turf/open/space/RemoveLattice()
	return

/turf/open/space/AfterChange()
	..()
	atmos_overlay_types = null

/turf/open/space/Assimilate_Air()
	return

//IT SHOULD RETURN NULL YOU MONKEY, WHY IN TARNATION WHAT THE FUCKING FUCK
/turf/open/space/remove_air(amount)
	return null

/turf/open/space/remove_air_ratio(amount)
	return null

/// Checks if the turf's starlight should change, given a turf within 1 tile (including itself) that has changed since starlight was last valid.
/turf/open/space/proc/check_starlight(turf/changed_turf)
	// Non-space turfs cause us to start emitting or update our light.
	if(!isspaceturf(changed_turf) && CONFIG_GET(flag/starlight))
		set_light(STARLIGHT_RANGE_EMITTING)
		return
	// Either a turf changed TO space and we WERE emitting,
	// or the turf ITSELF changed to space; in both cases we must recalculate
	if(light_range != STARLIGHT_RANGE_NOT_EMITTING || changed_turf == src)
		recalculate_starlight() // check starlight from scratch

/// Recalculates the turf's starlight by checking nearby turfs.
/// Note that if all nearby turfs are space and no starlight was being emitted, the light is not updated.
/turf/open/space/proc/recalculate_starlight()
	if(!(CONFIG_GET(flag/starlight)))
		return

	for(var/t in RANGE_TURFS(1,src)) // RANGE_TURFS is in code\__HELPERS\game.dm
		// Adjacent non-space turfs mean we stay emitting.
		if(!isspaceturf(t))
			set_light(STARLIGHT_RANGE_EMITTING)
			return

	// No adjacent non-space turfs; stop emitting starlight if we were before.
	// set_light(0) doesn't actually change anything if our range is 0, but it has minor overhead
	if(light_range != STARLIGHT_RANGE_NOT_EMITTING)
		set_light(STARLIGHT_RANGE_NOT_EMITTING)

/turf/open/space/attack_paw(mob/user)
	return attack_hand(user)

/turf/open/space/proc/CanBuildHere()
	return TRUE

/turf/open/space/handle_slip()
	return

/turf/open/space/attackby(obj/item/C, mob/user, params)
	..()
	if(!CanBuildHere())
		return
	if(istype(C, /obj/item/stack/rods))
		var/obj/item/stack/rods/R = C
		var/obj/structure/lattice/L = locate(/obj/structure/lattice, src)
		var/obj/structure/catwalk/W = locate(/obj/structure/catwalk, src)
		if(W)
			to_chat(user, "<span class='warning'>There is already a catwalk here!</span>")
			return
		if(L)
			if(R.use(2))
				to_chat(user, "<span class='notice'>You construct a catwalk.</span>")
				playsound(src, 'sound/weapons/genhit.ogg', 50, TRUE)
				new/obj/structure/catwalk(src)
			else
				to_chat(user, "<span class='warning'>You need two rods to build a catwalk!</span>")
			return
		if(R.use(1))
			to_chat(user, "<span class='notice'>You construct a lattice.</span>")
			playsound(src, 'sound/weapons/genhit.ogg', 50, TRUE)
			ReplaceWithLattice()
		else
			to_chat(user, "<span class='warning'>You need one rod to build a lattice.</span>")
		return
	if(istype(C, /obj/item/stack/tile/plasteel))
		var/obj/structure/lattice/L = locate(/obj/structure/lattice, src)
		if(L)
			var/obj/item/stack/tile/plasteel/S = C
			if(S.use(1))
				qdel(L)
				playsound(src, 'sound/weapons/genhit.ogg', 50, TRUE)
				to_chat(user, "<span class='notice'>You build a floor.</span>")
				PlaceOnTop(/turf/open/floor/plating, flags = CHANGETURF_INHERIT_AIR)
			else
				to_chat(user, "<span class='warning'>You need one floor tile to build a floor!</span>")
		else
			to_chat(user, "<span class='warning'>The plating is going to need some support! Place metal rods first.</span>")

/turf/open/space/MakeSlippery(wet_setting, min_wet_time, wet_time_to_add, max_wet_time, permanent)
	return

/turf/open/space/singularity_act()
	return

/turf/open/space/can_have_cabling()
	if(locate(/obj/structure/catwalk, src))
		return 1
	return 0

/turf/open/space/acid_act(acidpwr, acid_volume)
	return 0

/turf/open/space/get_smooth_underlay_icon(mutable_appearance/underlay_appearance, turf/asking_turf, adjacency_dir)
	underlay_appearance.icon = 'icons/turf/space.dmi'
	underlay_appearance.icon_state = SPACE_ICON_STATE
	underlay_appearance.plane = PLANE_SPACE
	return TRUE


/turf/open/space/rcd_vals(mob/user, obj/item/construction/rcd/the_rcd)
	if(!CanBuildHere())
		return FALSE

	switch(the_rcd.mode)
		if(RCD_FLOORWALL)
			var/obj/structure/lattice/L = locate(/obj/structure/lattice, src)
			if(L)
				return list("mode" = RCD_FLOORWALL, "delay" = 0, "cost" = 1)
			else
				return list("mode" = RCD_FLOORWALL, "delay" = 0, "cost" = 3)
	return FALSE

/turf/open/space/rcd_act(mob/user, obj/item/construction/rcd/the_rcd, passed_mode)
	switch(passed_mode)
		if(RCD_FLOORWALL)
			to_chat(user, "<span class='notice'>You build a floor.</span>")
			PlaceOnTop(/turf/open/floor/plating, flags = CHANGETURF_INHERIT_AIR)
			return TRUE
	return FALSE

#undef STARLIGHT_RANGE_NOT_EMITTING
#undef STARLIGHT_RANGE_EMITTING
