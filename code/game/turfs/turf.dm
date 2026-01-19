GLOBAL_LIST_EMPTY(created_baseturf_lists)

/turf
	icon = 'icons/turf/floors.dmi'
	flags_1 = CAN_BE_DIRTY_1
	vis_flags = VIS_INHERIT_ID|VIS_INHERIT_PLANE // Important for interaction with and visualization of openspace.
	luminosity = 1

	var/intact = 1

	// baseturfs can be either a list or a single turf type.
	// In class definition like here it should always be a single type.
	// A list will be created in initialization that figures out the baseturf's baseturf etc.
	// In the case of a list it is sorted from bottom layer to top.
	// This shouldn't be modified directly; use the helper procs, as many baseturf lists are shared between turfs.
	var/list/baseturfs = /turf/baseturf_bottom

	/// Used for fire, if a melting temperature was reached, it will be destroyed
	var/to_be_destroyed = 0
	var/max_fire_temperature_sustained = 0 //The max temperature of the fire which it was subjected to

	var/blocks_air = FALSE

	var/list/image/blueprint_data //for the station blueprints, images of objects eg: pipes

	var/explosion_level = 0	//for preventing explosion dodging
	var/explosion_id = 0
	var/list/explosion_throw_details

	var/requires_activation	//add to air processing after initialize?
	var/changing_turf = FALSE

	var/list/bullet_bounce_sound = list('sound/weapons/gun/general/bulletcasing_bounce1.ogg', 'sound/weapons/gun/general/bulletcasing_bounce2.ogg', 'sound/weapons/gun/general/bulletcasing_bounce3.ogg')
	var/bullet_sizzle = FALSE //used by ammo_casing/bounce_away() to determine if the shell casing should make a sizzle sound when it's ejected over the turf
							//IE if the turf is supposed to be water, set TRUE.

	var/tiled_dirt = FALSE // use smooth tiled dirt decal

	///Icon-smoothing variable to map a diagonal wall corner with a fixed underlay.
	var/list/fixed_underlay = null

	/// The underlay generated and applied when a chisel makes a turf diagonal. Stored here for removal on un-diagonalizing
	var/mutable_appearance/smooth_underlay

	///Lumcount added by sources other than lighting datum objects, such as the overlay lighting component.
	var/dynamic_lumcount = 0

	var/dynamic_lighting = TRUE

	var/tmp/lighting_corners_initialised = FALSE

	///Our lighting object.
	var/tmp/atom/movable/lighting_object/lighting_object
	///Lighting Corner datums.
	var/tmp/datum/lighting_corner/lighting_corner_NE
	var/tmp/datum/lighting_corner/lighting_corner_SE
	var/tmp/datum/lighting_corner/lighting_corner_SW
	var/tmp/datum/lighting_corner/lighting_corner_NW


	///Which directions does this turf block the vision of, taking into account both the turf's opacity and the movable opacity_sources.
	var/directional_opacity = NONE
	///Lazylist of movable atoms providing opacity sources.
	var/list/atom/movable/opacity_sources

	// ID of the virtual level we're in
	var/virtual_z = 0

	/// If TRUE, radiation waves will qdelete if they step forwards into this turf, and stop propagating sideways if they encounter it.
	/// Used to stop radiation from travelling across virtual z-levels such as transit zones and planetary encounters.
	var/rad_fullblocker = FALSE

	hitsound_volume = 90

/turf/vv_edit_var(var_name, new_value)
	var/static/list/banned_edits = list("x", "y", "z")
	if(var_name in banned_edits)
		return FALSE
	. = ..()

/**
 * Turf Initialize
 *
 * Doesn't call parent, see [/atom/proc/Initialize]
 */
/turf/Initialize(mapload, inherited_virtual_z)
	SHOULD_CALL_PARENT(FALSE)
	if(flags_1 & INITIALIZED_1)
		stack_trace("Warning: [src]([type]) initialized multiple times!")
	flags_1 |= INITIALIZED_1

	if(inherited_virtual_z)
		virtual_z = inherited_virtual_z

	assemble_baseturfs()

	levelupdate()

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

	if (smoothing_flags & (SMOOTH_CORNERS|SMOOTH_BITMASK))
		QUEUE_SMOOTH(src)

	for(var/atom/movable/content as anything in src)
		Entered(content, null)

	var/area/A = loc
	if(!IS_DYNAMIC_LIGHTING(src) && IS_DYNAMIC_LIGHTING(A))
		add_overlay(/obj/effect/fullbright)

	if(requires_activation)
		ImmediateCalculateAdjacentTurfs()

	if (light_power && light_range)
		update_light()

	var/turf/T = above()
	if(T)
		T.multiz_turf_new(src, DOWN)
	T = below()
	if(T)
		T.multiz_turf_new(src, UP)


	if (opacity)
		directional_opacity = ALL_CARDINALS

	if(custom_materials)

		var/temp_list = list()
		for(var/i in custom_materials)
			temp_list[SSmaterials.GetMaterialRef(i)] = custom_materials[i] //Get the proper instanced version

		custom_materials = null //Null the list to prepare for applying the materials properly
		set_custom_materials(temp_list)

	ComponentInitialize()
	if(isopenturf(src))
		var/turf/open/O = src
		__auxtools_update_turf_temp_info(isspaceturf(get_z_base_turf()) && !O.planetary_atmos)
	else
		update_air_ref(AIR_REF_CLOSED_TURF)
		__auxtools_update_turf_temp_info(isspaceturf(get_z_base_turf()))

	return INITIALIZE_HINT_NORMAL

/turf/proc/__auxtools_update_turf_temp_info()

/turf/return_temperature()

/turf/proc/set_temperature()

/turf/proc/Initalize_Atmos(times_fired)
	ImmediateCalculateAdjacentTurfs()

/turf/Destroy(force)
	. = QDEL_HINT_IWILLGC
	if(!changing_turf)
		stack_trace("Incorrect turf deletion")
	changing_turf = FALSE
	var/turf/T = above()
	if(T)
		T.multiz_turf_del(src, DOWN)
	T = below()
	if(T)
		T.multiz_turf_del(src, UP)
	if(force)
		..()
		//this will completely wipe turf state
		var/turf/B = new world.turf(src)
		for(var/A in B.contents)
			qdel(A)
		return
	QDEL_LIST(blueprint_data)
	flags_1 &= ~INITIALIZED_1
	requires_activation = FALSE
	..()

	vis_contents.Cut()

/// WARNING WARNING
/// Turfs DO NOT lose their signals when they get replaced, REMEMBER THIS
/// It's possible because turfs are fucked, and if you have one in a list and it's replaced with another one, the list ref points to the new turf
/// We do it because moving signals over was needlessly expensive, and bloated a very commonly used bit of code
/turf/clear_signal_refs()
	return

/turf/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	user.Move_Pulled(src)

/turf/proc/multiz_turf_del(turf/T, dir)
	SEND_SIGNAL(src, COMSIG_TURF_MULTIZ_DEL, T, dir)

/turf/proc/multiz_turf_new(turf/T, dir)
	SEND_SIGNAL(src, COMSIG_TURF_MULTIZ_NEW, T, dir)

/**
 * Check whether the specified turf is blocked by something dense inside it with respect to a specific atom.
 *
 * Returns truthy value TURF_BLOCKED_TURF_DENSE if the turf is blocked because the turf itself is dense.
 * Returns truthy value TURF_BLOCKED_CONTENT_DENSE if one of the turf's contents is dense and would block
 * a source atom's movement.
 * Returns falsey value TURF_NOT_BLOCKED if the turf is not blocked.
 *
 * Arguments:
 * * exclude_mobs - If TRUE, ignores dense mobs on the turf.
 * * source_atom - If this is not null, will check whether any contents on the turf can block this atom specifically. Also ignores itself on the turf.
 * * ignore_atoms - Check will ignore any atoms in this list. Useful to prevent an atom from blocking itself on the turf.
 */
/turf/proc/is_blocked_turf(exclude_mobs = FALSE, source_atom = null, list/ignore_atoms)
	if(density)
		return TRUE

	for(var/atom/movable/movable_content as anything in contents)
		// We don't want to block ourselves or consider any ignored atoms.
		if((movable_content == source_atom) || (movable_content in ignore_atoms))
			continue
		// If the thing is dense AND we're including mobs or the thing isn't a mob AND if there's a source atom and
		// it cannot pass through the thing on the turf,  we consider the turf blocked.
		if(movable_content.density && (!exclude_mobs || !ismob(movable_content)))
			if(source_atom && movable_content.CanPass(source_atom, get_dir(src, source_atom)))
				continue
			return TRUE
	return FALSE

//zPassIn doesn't necessarily pass an atom!
//direction is direction of travel of air
/turf/proc/zPassIn(atom/movable/A, direction, turf/source)
	return FALSE

//direction is direction of travel of air
/turf/proc/zPassOut(atom/movable/A, direction, turf/destination)
	return FALSE

//direction is direction of travel of air
/turf/proc/zAirIn(direction, turf/source)
	return FALSE

//direction is direction of travel of air
/turf/proc/zAirOut(direction, turf/source)
	return FALSE

/turf/proc/zImpact(atom/movable/A, levels = 1, turf/prev_turf)
	var/flags = NONE
	var/mov_name = A.name
	for(var/atom/movable/thing as anything in contents)
		flags |= thing.intercept_zImpact(A, levels)
		if(flags & FALL_STOP_INTERCEPTING)
			break
	if(prev_turf && !(flags & FALL_NO_MESSAGE))
		prev_turf.visible_message(span_danger("[mov_name] falls through [prev_turf]!"))
	if(flags & FALL_INTERCEPTED)
		return
	if(zFall(A, ++levels))
		return FALSE
	A.visible_message(span_danger("[A] crashes into [src]!"))
	A.onZImpact(src, levels)
	return TRUE

/turf/proc/can_zFall(atom/movable/A, levels = 1, turf/target)
	SHOULD_BE_PURE(TRUE)
	return zPassOut(A, DOWN, target) && target.zPassIn(A, DOWN, src)

/turf/proc/zFall(atom/movable/A, levels = 1, force = FALSE)
	var/turf/target = get_step_multiz(src, DOWN)
	if(!target || (!isobj(A) && !ismob(A)))
		return FALSE
	if(!force && (!can_zFall(A, levels, target) || !A.can_zFall(src, levels, target, DOWN)))
		return FALSE
	var/atom/movable/AM = null	//WS Start - Dragging down stairs works now
	var/was_pulling = FALSE
	if(ismob(A))
		var/mob/M = A
		if(A.pulling)
			AM = M.pulling
			AM.forceMove(target)
			was_pulling = TRUE	//WS End
	A.zfalling = TRUE
	A.forceMove(target)
	A.zfalling = FALSE
	if(ismob(A) && was_pulling)	//WS Start - Dragging down stairs works now
		var/mob/M = A
		M.start_pulling(AM)		//WS End
	target.zImpact(A, levels, src)
	return TRUE

/turf/proc/handleRCL(obj/item/rcl/C, mob/user)
	if(C.loaded)
		for(var/obj/structure/cable/LC in src)
			if(!LC.d1 || !LC.d2)
				LC.handlecable(C, user)
				return
		C.loaded.place_turf(src, user)
		if(C.wiring_gui_menu)
			C.wiringGuiUpdate(user)
		C.is_empty(user)

/turf/attackby(obj/item/C, mob/user, params)
	if(..())
		return TRUE
	if(can_lay_cable() && istype(C, /obj/item/stack/cable_coil))
		var/obj/item/stack/cable_coil/coil = C
		for(var/obj/structure/cable/LC in src)
			if(!LC.d1 || !LC.d2)
				LC.attackby(C,user)
				return
		coil.place_turf(src, user)
		return TRUE

	else if(istype(C, /obj/item/rcl))
		handleRCL(C, user)

	return FALSE

/turf/CanAllowThrough(atom/movable/mover, turf/target)
	. = ..()
	if(!target)
		return FALSE
	if(istype(mover)) // turf/Enter(...) will perform more advanced checks
		return !density
	stack_trace("Non movable passed to turf CanPass : [mover]")
	return FALSE

//There's a lot of QDELETED() calls here if someone can figure out how to optimize this but not runtime when something gets deleted by a Bump/CanPass/Cross call, lemme know or go ahead and fix this mess - kevinz000
// Test if a movable can enter this turf. Send no_side_effects = TRUE to prevent bumping.
/turf/Enter(atom/movable/mover, atom/oldloc, no_side_effects = FALSE)
	// Do not call ..()
	// Byond's default turf/Enter() doesn't have the behaviour we want with Bump()
	// By default byond will call Bump() on the first dense object in contents
	// Here's hoping it doesn't stay like this for years before we finish conversion to step_
	var/atom/firstbump
	var/canPassSelf = CanPass(mover, get_dir(src, mover))
	if(canPassSelf || (mover.movement_type & PHASING) || (mover.pass_flags & pass_flags_self))
		for(var/atom/movable/thing as anything in contents)
			if(QDELETED(mover))
				return FALSE //We were deleted, do not attempt to proceed with movement.
			if(thing == mover || thing == mover.loc) // Multi tile objects and moving out of other objects
				continue
			if(!thing.Cross(mover))
				if(no_side_effects)
					return FALSE
				if(QDELETED(mover))		//Mover deleted from Cross/CanPass, do not proceed.
					return FALSE
				if((mover.movement_type & PHASING))
					mover.Bump(thing)
					continue
				else
					if(!firstbump || ((thing.layer > firstbump.layer || thing.flags_1 & ON_BORDER_1) && !(firstbump.flags_1 & ON_BORDER_1)))
						firstbump = thing
	if(QDELETED(mover))					//Mover deleted from Cross/CanPass/Bump, do not proceed.
		return FALSE
	if(!canPassSelf)	//Even if mover is unstoppable they need to bump us.
		firstbump = src
	if(firstbump)
		mover.Bump(firstbump)
		return (mover.movement_type & PHASING) || (mover.pass_flags & pass_flags_self) // If they can phase through us, let them in. If not, don't.
	return TRUE

/turf/open/Entered(atom/movable/AM)
	. =..()
	//melting
	if(isobj(AM) && air?.return_temperature() > T0C)
		var/obj/O = AM
		if(O.obj_flags & FROZEN)
			O.make_unfrozen()
	if(!AM.zfalling)
		zFall(AM)

// Initializes the baseturfs list, given an optional "fake_baseturf_type".
// If "fake_baseturf_type" is a list, then this turf's baseturfs are set to that list.
// Otherwise, if "fake_baseturf_type" is non-null, it is used as the top of the baseturf stack.
// If no fake_baseturf_type is passed, and the current turf's baseturfs variable is not a list,
// baseturfs are initialized using the intial baseturfs variable as the top of the baseturf stack.
/turf/proc/assemble_baseturfs(turf/fake_baseturf_type)
	var/turf/current_target
	if(fake_baseturf_type)
		if(length(fake_baseturf_type)) // We were given a list, just apply it and move on
			baseturfs = baseturfs_string_list(fake_baseturf_type, src)
			return
		current_target = fake_baseturf_type
	else
		if(length(baseturfs))
			return // No replacement baseturf has been given and the current baseturfs value is already a list/assembled
		if(!baseturfs)
			current_target = initial(baseturfs) || type // This should never happen but just in case...
			stack_trace("baseturfs var was null for [type]. Failsafe activated and it has been given a new baseturfs value of [current_target].")
		else
			current_target = baseturfs

	// If we've made the output before we don't need to regenerate it
	if(GLOB.created_baseturf_lists[current_target])
		var/list/premade_baseturfs = GLOB.created_baseturf_lists[current_target]
		if(length(premade_baseturfs))
			baseturfs = baseturfs_string_list(premade_baseturfs.Copy(), src)
		else
			baseturfs = baseturfs_string_list(premade_baseturfs, src)
		return baseturfs

	var/turf/next_target = initial(current_target.baseturfs)
	//Most things only have 1 baseturf so this loop won't run in most cases
	if(current_target == next_target)
		baseturfs = current_target
		GLOB.created_baseturf_lists[current_target] = current_target
		return current_target
	var/list/new_baseturfs = list(current_target)
	for(var/i=0;current_target != next_target;i++)
		if(i > 100)
			// A baseturfs list over 100 members long is silly
			// Because of how this is all structured it will only runtime/message once per type
			stack_trace("A turf <[type]> created a baseturfs list over 100 members long. This is most likely an infinite loop.")
			message_admins("A turf <[type]> created a baseturfs list over 100 members long. This is most likely an infinite loop.")
			break
		new_baseturfs.Insert(1, next_target)
		current_target = next_target
		next_target = initial(current_target.baseturfs)

	baseturfs = baseturfs_string_list(new_baseturfs, src)
	GLOB.created_baseturf_lists[new_baseturfs[new_baseturfs.len]] = new_baseturfs.Copy()
	return new_baseturfs

/turf/proc/levelupdate()
	for(var/obj/O in src)
		if(O.flags_1 & INITIALIZED_1)
			SEND_SIGNAL(O, COMSIG_OBJ_HIDE, intact)

// override for space turfs, since they should never hide anything
/turf/open/space/levelupdate()
	return

// Removes all signs of lattice on the pos of the turf -Donkieyo
/turf/proc/RemoveLattice()
	var/obj/structure/lattice/L = locate(/obj/structure/lattice, src)
	if(L && (L.flags_1 & INITIALIZED_1))
		qdel(L)

/turf/proc/Bless()
	new /obj/effect/blessing(src)

/turf/storage_contents_dump_act(datum/component/storage/src_object, mob/user)
	. = ..()
	if(.)
		return
	if(length(src_object.contents()))
		to_chat(usr, span_notice("You start dumping out the contents..."))
		if(!do_after(usr, 20, target=src_object.parent))
			return FALSE

	var/list/things = src_object.contents()
	var/datum/progressbar/progress = new(user, things.len, src)
	while (do_after(usr, 10, src, TRUE, FALSE, CALLBACK(src_object, TYPE_PROC_REF(/datum/component/storage, mass_remove_from_storage), src, things, progress)))
		stoplag(1)
	progress.end_progress()

	return TRUE

//////////////////////////////
//Distance procs
//////////////////////////////

//Distance associates with all directions movement
/turf/proc/Distance(turf/T)
	return get_dist(src,T)

//  This Distance proc assumes that only cardinal movement is
//  possible. It results in more efficient (CPU-wise) pathing
//  for bots and anything else that only moves in cardinal dirs.
/turf/proc/Distance_cardinal(turf/T)
	if(!src || !T)
		return FALSE
	return abs(x - T.x) + abs(y - T.y)

////////////////////////////////////////////////////

/turf/singularity_act()
	if(intact)
		for(var/obj/O in contents) //this is for deleting things like wires contained in the turf
			if(HAS_TRAIT(O, TRAIT_T_RAY_VISIBLE))
				O.singularity_act()
	ScrapeAway(flags = CHANGETURF_INHERIT_AIR)
	return(2)

/turf/proc/can_have_cabling()
	return TRUE

/turf/proc/can_lay_cable()
	return can_have_cabling() & !intact

/turf/proc/visibilityChanged()
	GLOB.cameranet.updateVisibility(src)
	// The cameranet usually handles this for us, but if we've just been
	// recreated we should make sure we have the cameranet vis_contents.
	var/datum/camerachunk/C = GLOB.cameranet.chunkGenerated(x, y, z)
	if(C)
		if(C.obscuredTurfs[src])
			vis_contents += GLOB.cameranet.vis_contents_objects
		else
			vis_contents -= GLOB.cameranet.vis_contents_objects

/turf/proc/burn_tile()

/turf/proc/is_shielded()

/turf/contents_explosion(severity, target)

	for(var/atom/A as anything in contents)
		if(!QDELETED(A))
			if(ismovable(A))
				var/atom/movable/AM = A
				if(!AM.ex_check(explosion_id))
					continue
			switch(severity)
				if(EXPLODE_DEVASTATE)
					SSexplosions.highobj += A
				if(EXPLODE_HEAVY)
					SSexplosions.medobj += A
				if(EXPLODE_LIGHT)
					SSexplosions.lowobj += A

/turf/narsie_act(force, ignore_mobs, probability = 20)
	. = (force || prob(probability))
	var/individual_chance
	for(var/atom/movable/movable_contents as anything in src)
		individual_chance = ismob(movable_contents) ? !ignore_mobs : .
		if(individual_chance)
			movable_contents.narsie_act()

/turf/proc/get_smooth_underlay_icon(mutable_appearance/underlay_appearance, turf/asking_turf, adjacency_dir)
	underlay_appearance.icon = icon
	underlay_appearance.icon_state = icon_state
	underlay_appearance.dir = adjacency_dir
	return TRUE

/turf/proc/add_blueprints(atom/movable/AM)
	var/image/I = new
	I.appearance = AM.appearance
	I.appearance_flags = RESET_COLOR|RESET_ALPHA|RESET_TRANSFORM
	I.loc = src
	I.setDir(AM.dir)
	I.alpha = 128
	LAZYADD(blueprint_data, I)

/turf/proc/is_transition_turf()
	return

/turf/acid_act(acidpwr, acid_volume)
	. = 1
	var/acid_type = /obj/effect/acid
	if(acidpwr >= 200) //alien acid power
		acid_type = /obj/effect/acid/alien
	var/has_acid_effect = FALSE
	for(var/obj/O in src)
		if(intact && HAS_TRAIT(O, TRAIT_T_RAY_VISIBLE))
			return
		if(istype(O, acid_type))
			var/obj/effect/acid/A = O
			A.acid_level = min(acid_volume * acidpwr, 12000)//capping acid level to limit power of the acid
			has_acid_effect = 1
			continue
		O.acid_act(acidpwr, acid_volume)
	if(!has_acid_effect)
		new acid_type(src, acidpwr, acid_volume)

/turf/proc/acid_melt()
	return

/turf/handle_fall(mob/faller, fall_sound_played)
	if(has_gravity(src) && !fall_sound_played)
		playsound(src, "bodyfall", 50, TRUE)
	faller.drop_all_held_items()

/turf/proc/photograph(limit=20)
	var/image/I = new()
	I.add_overlay(src)
	for(var/atom/movable/A as anything in contents)
		if(A.invisibility)
			continue
		I.add_overlay(A)
		if(limit)
			limit--
		else
			return I
	return I

/turf/AllowDrop()
	return TRUE

/turf/proc/add_vomit_floor(mob/living/M, toxvomit = NONE, purge = FALSE)

	var/obj/effect/decal/cleanable/vomit/V = new /obj/effect/decal/cleanable/vomit(src, M.get_static_viruses())

	//if the vomit combined, apply toxicity and reagents to the old vomit
	if (QDELETED(V))
		V = locate() in src
	if(!V)
		return
	// Make toxins and blazaam vomit look different
	if(toxvomit == VOMIT_PURPLE)
		V.icon_state = "vomitpurp_[pick(1,4)]"
	else if (toxvomit == VOMIT_TOXIC)
		V.icon_state = "vomittox_[pick(1,4)]"
	if (iscarbon(M))
		var/mob/living/carbon/C = M
		if(C.reagents)
			clear_reagents_to_vomit_pool(C,V, purge)

/proc/clear_reagents_to_vomit_pool(mob/living/carbon/M, obj/effect/decal/cleanable/vomit/V, purge = FALSE)
	var/obj/item/organ/stomach/belly = M.getorganslot(ORGAN_SLOT_STOMACH)
	if(!belly)
		return
	var/chemicals_lost = belly.reagents.total_volume * 0.1
	if(purge)
		chemicals_lost = belly.reagents.total_volume * 0.67 //For detoxification surgery, we're manually pumping the stomach out of chemcials, so it's far more efficient.
	belly.reagents.trans_to(V, chemicals_lost, transfered_by = M)
	//clear the stomach of anything even not food
	for(var/bile in belly.reagents.reagent_list)
		var/datum/reagent/reagent = bile
		if(!belly.food_reagents[reagent.type])
			belly.reagents.remove_reagent(reagent.type, min(reagent.volume, 10))
		else
			var/bit_vol = reagent.volume - belly.food_reagents[reagent.type]
			if(bit_vol > 0)
				belly.reagents.remove_reagent(reagent.type, min(bit_vol, 10))

//Whatever happens after high temperature fire dies out or thermite reaction works.
//Should return new turf
/turf/proc/Melt()
	return ScrapeAway(flags = CHANGETURF_INHERIT_AIR)

/// Handles exposing a turf to reagents.
/turf/expose_reagents(list/reagents, datum/reagents/source, method=TOUCH, volume_modifier=1, show_message=TRUE)
	if((. = ..()) & COMPONENT_NO_EXPOSE_REAGENTS)
		return

	for(var/reagent in reagents)
		var/datum/reagent/R = reagent
		. |= R.expose_turf(src, reagents[R])

/**
 * Called when this turf is being washed. Washing a turf will also wash any mopable floor decals
 */
/turf/wash(clean_types)
	. = ..()

	for(var/atom/movable/content as anything in src)
		if(content == src)
			continue
		if(!ismopable(content))
			continue
		content.wash(clean_types)

/turf/proc/ignite_turf(power, fire_color = "red")
	return SEND_SIGNAL(src, COMSIG_TURF_IGNITED, power, fire_color)

/turf/proc/extinguish_turf()
	return

/turf/proc/on_turf_saved()
	// This is all we can do. I'm sorry mappers, but there's no way to get any more details.
	var/first = TRUE
	for(var/datum/element/decal/decal as anything in GetComponents(/datum/element/decal))
		if(!first)
			. += ",\n"
		. += "[/obj/effect/turf_decal]{\n\ticon = '[decal.pic.icon]';\n\ticon_state = \"[decal.pic.icon_state]\";\n\tdir = [decal.pic.dir];\n\tcolor = \"[decal.pic.color]\"\n\t}"
		first = FALSE
	return

/turf/bullet_act(obj/projectile/hitting_projectile)
	. = ..()
	bullet_hit_sfx(hitting_projectile)

/**
 * Returns adjacent turfs to this turf that are reachable, in all cardinal directions
 *
 * Arguments:
 * * requester: The movable, if one exists, being used for mobility checks to see what tiles it can reach
 * * ID: An ID card that decides if we can gain access to doors that would otherwise block a turf
 * * simulated_only: Do we only worry about turfs with simulated atmos, most notably things that aren't space?
*/
/turf/proc/reachableAdjacentTurfs(requester, ID, simulated_only)
	var/static/space_type_cache = typecacheof(/turf/open/space)
	. = list()

	for(var/iter_dir in GLOB.cardinals)
		var/turf/turf_to_check = get_step(src,iter_dir)
		if(!turf_to_check || (simulated_only && space_type_cache[turf_to_check.type]))
			continue
		if(turf_to_check.density || LinkBlockedWithAccess(turf_to_check, requester, ID))
			continue
		. += turf_to_check
