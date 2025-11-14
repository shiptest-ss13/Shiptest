/turf/open/floor/concrete
	name = "concrete floor"
	desc = "Cold, bare concrete flooring."
	icon = 'icons/turf/floors/concrete.dmi'
	icon_state = "conc_smooth_1"
	base_icon_state = "conc_smooth"
	broken_states = list("concdam_1", "concdam_2", "concdam_3", "concdam_4")
	floor_tile = null
	tiled_dirt = FALSE
	footstep = FOOTSTEP_CONCRETE
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY

	var/smash_time = 3 SECONDS
	var/time_to_harden = 20 SECONDS
	// fraction ranging from 0 to 1 -- 0 is fully soft, 1 is fully hardened
	// don't change this in subtypes unless you want them to spawn in soft on maps
	var/harden_lvl = 1
	var/has_variation = TRUE

	var/shape_types = list(
		/turf/open/floor/concrete,
		/turf/open/floor/concrete/slab_1,
		/turf/open/floor/concrete/slab_2,
		/turf/open/floor/concrete/slab_3,
		/turf/open/floor/concrete/slab_4,
		/turf/open/floor/concrete/tiles
	)

	// footprint vars
	var/entered_dirs
	var/exited_dirs

	smoothing_groups = list(SMOOTH_GROUP_TURF_OPEN, SMOOTH_GROUP_FLOOR_PLASTEEL)
	canSmoothWith = list(SMOOTH_GROUP_OPEN_FLOOR, SMOOTH_GROUP_TURF_OPEN, SMOOTH_GROUP_FLOOR_PLASTEEL)

/turf/open/floor/concrete/Initialize()
	. = ..()
	if(has_variation)
		icon_state = "[base_icon_state]_[rand(1,4)]"
	check_harden()
	update_appearance()

/turf/open/floor/concrete/examine(mob/user)
	. = ..()
	. += span_notice("[p_they(TRUE)] look[p_s()] like you could <b>smash</b> [p_them()].")
	switch(harden_lvl)
		if(0.8 to 0.99)
			. += "[p_they(TRUE)] look[p_s()] nearly dry."
		if(0.4 to 0.8)
			. += "[p_they(TRUE)] look[p_s()] a little wet."
		if(0 to 0.4)
			. += "[p_they(TRUE)] look[p_s()] freshly poured."
	return

/turf/open/floor/concrete/attackby(obj/item/C, mob/user, params)
	. = ..()
	if(.)
		return
	if(C.tool_behaviour == TOOL_MINING)
		to_chat(user, span_notice("You start smashing [src]..."))
		var/adj_time = (broken || burnt) ? smash_time/2 : smash_time
		if(C.use_tool(src, user, adj_time, volume=30))
			to_chat(user, span_notice("You break [src]."))
			playsound(src, 'sound/effects/break_stone.ogg', 30, TRUE)
			remove_tile()
			return TRUE
	return FALSE

/turf/open/floor/concrete/proc/handle_shape(mob/user)
	if(harden_lvl >= 0.8)
		return FALSE
	var/list/opts = list()

	for(var/turf/open/floor/concrete/conc as anything in shape_types)
		opts[conc] = image(icon = initial(conc.icon), icon_state = initial(conc.icon_state))

	var/choice = show_radial_menu(
		user,
		src,
		opts,
		// test this
		uniqueid = "concmenu_[REF(user)]",
		radius = 48,
		custom_check = CALLBACK(src, PROC_REF(check_menu), user),
		require_near = TRUE
	)
	if(!choice)
		return FALSE
	to_chat(user, "You reshape [src].")
	var/old_harden = harden_lvl
	// todo: copy over other vars here too??? maybe?? ugh
	var/turf/open/floor/concrete/newconc = ChangeTurf(choice, flags = CHANGETURF_INHERIT_AIR)
	newconc.harden_lvl = old_harden
	newconc.check_harden()
	newconc.update_appearance()
	return TRUE

/turf/open/floor/concrete/proc/check_menu(mob/living/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated() || !user.Adjacent(src))
		return FALSE
	return TRUE

/turf/open/floor/concrete/Entered(atom/movable/AM)
	. = ..()
	if(!iscarbon(AM) || (AM.movement_type & (FLYING|VENTCRAWLING|FLOATING|PHASING)) || (harden_lvl >= 0.4))
		return
	if(!(entered_dirs & AM.dir))
		entered_dirs |= AM.dir
		update_appearance()

/turf/open/floor/concrete/Exited(atom/movable/AM)
	. = ..()
	if(!iscarbon(AM) || (AM.movement_type & (FLYING|VENTCRAWLING|FLOATING|PHASING)) || (harden_lvl >= 0.4))
		return
	if(!(exited_dirs & AM.dir))
		exited_dirs |= AM.dir
		update_appearance()

/turf/open/floor/concrete/update_icon()
	. = ..()
	if(!.)
		return
	remove_filter("harden")
	if(harden_lvl == 1)
		return

	var/offset = (1 - harden_lvl) * 0.3
	var/base = 1 - offset
	var/col_filter = list(base,0,0, 0,base,0, 0,0,base, offset, offset, offset)
	add_filter("harden", 1, color_matrix_filter(col_filter, FILTER_COLOR_RGB))
	return

// adapted version of footprints' update_icon code
/turf/open/floor/concrete/update_overlays()
	. = ..()
	for(var/Ddir in GLOB.cardinals)
		if(entered_dirs & Ddir)
			var/image/print = GLOB.bloody_footprints_cache["entered-conc-[Ddir]"]
			if(!print)
				print = image('icons/effects/footprints.dmi', "conc1", layer = TURF_DECAL_LAYER, dir = Ddir)
				GLOB.bloody_footprints_cache["entered-conc-[Ddir]"] = print
			. += print
		if(exited_dirs & Ddir)
			var/image/print = GLOB.bloody_footprints_cache["exited-conc-[Ddir]"]
			if(!print)
				print = image('icons/effects/footprints.dmi', "conc2", layer = TURF_DECAL_LAYER, dir = Ddir)
				GLOB.bloody_footprints_cache["exited-conc-[Ddir]"] = print
			. += print

// pretty much ripped wholesale from footprints' version of this proc
/turf/open/floor/concrete/setDir(newdir)
	if(dir == newdir)
		return ..()

	var/ang_change = dir2angle(newdir) - dir2angle(dir)
	var/old_entered_dirs = entered_dirs
	var/old_exited_dirs = exited_dirs
	entered_dirs = 0
	exited_dirs = 0

	for(var/Ddir in GLOB.cardinals)
		var/NDir = angle2dir_cardinal(dir2angle(Ddir) + ang_change)
		if(old_entered_dirs & Ddir)
			entered_dirs |= NDir
		if(old_exited_dirs & Ddir)
			exited_dirs |= NDir

	update_appearance()
	return ..()

/turf/open/floor/concrete/proc/check_harden()
	harden_lvl = clamp(harden_lvl, 0, 1)
	if(harden_lvl < 1)
		START_PROCESSING(SSobj, src)

/turf/open/floor/concrete/process(wait)
	harden_lvl = min(harden_lvl + (wait/time_to_harden), 1)
	if(harden_lvl == 1)
		STOP_PROCESSING(SSobj, src)
	update_appearance()

/turf/open/floor/concrete/break_tile()
	if(harden_lvl < 0.8)
		make_plating() // if unhardened, it breaks completely
		return
	return ..()

/turf/open/floor/concrete/burn_tile()
	if(harden_lvl == 1)
		return
	harden_lvl = 1 // burning while soft instantly hardens
	STOP_PROCESSING(SSobj, src)
	update_appearance()
	return

/turf/open/floor/concrete/try_replace_tile(obj/item/stack/tile/T, mob/user, params)
	return // can't be easily replaced

/turf/open/floor/concrete/crowbar_act(mob/living/user, obj/item/I)
	return SEND_SIGNAL(src, COMSIG_ATOM_CROWBAR_ACT, user, I) // can't be pried up


/turf/open/floor/concrete/slab_1
	icon_state = "conc_slab_1"
	has_variation = FALSE

/turf/open/floor/concrete/slab_2
	icon_state = "conc_slab_2"
	has_variation = FALSE

/turf/open/floor/concrete/slab_3
	icon_state = "conc_slab_3"
	has_variation = FALSE

/turf/open/floor/concrete/slab_4
	icon_state = "conc_slab_4"
	tiled_dirt = TRUE
	has_variation = FALSE

/turf/open/floor/concrete/tiles
	icon_state = "conc_tiles"
	has_variation = FALSE

/turf/open/floor/concrete/reinforced
	name = "hexacrete floor"
	desc = "Reinforced hexacrete tiling."
	icon = 'icons/turf/floors/hexacrete.dmi'
	icon_state = "hexacrete-0"
	base_icon_state = "hexacrete"
	has_variation = FALSE
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_TURF_OPEN, SMOOTH_GROUP_OPEN_FLOOR, SMOOTH_GROUP_FLOOR_PLASTEEL, SMOOTH_GROUP_FLOOR_HEXACRETE)
	canSmoothWith = list(SMOOTH_GROUP_FLOOR_HEXACRETE)

	smash_time = 8 SECONDS
	time_to_harden = 40 SECONDS
	// so that you can remove the overlays
	shape_types = list(/turf/open/floor/concrete/reinforced)

/turf/open/floor/concrete/reinforced/break_tile()
	// can only break if soft; if so, it breaks completely
	if(harden_lvl < 0.4)
		make_plating()
		return
	return

// modified from /turf/open/floor/engine/ex_act()
/turf/open/floor/concrete/reinforced/ex_act(severity,target)
	var/shielded = is_shielded()
	contents_explosion(severity, target)
	SEND_SIGNAL(src, COMSIG_ATOM_EX_ACT, severity, target)
	if(severity != EXPLODE_DEVASTATE && shielded && target != src)
		return
	if(target == src)
		ScrapeAway(flags = CHANGETURF_INHERIT_AIR)
		return
	switch(severity)
		if(EXPLODE_DEVASTATE)
			if(prob(80))
				if(!length(baseturfs) || !ispath(baseturfs[baseturfs.len-1], /turf/open/floor))
					ScrapeAway(flags = CHANGETURF_INHERIT_AIR)
					ReplaceWithLattice()
				else
					ScrapeAway(2, flags = CHANGETURF_INHERIT_AIR)
			else if(prob(50))
				ScrapeAway(2, flags = CHANGETURF_INHERIT_AIR)
			else
				ScrapeAway(flags = CHANGETURF_INHERIT_AIR)
		if(EXPLODE_HEAVY)
			if(prob(50))
				ScrapeAway(flags = CHANGETURF_INHERIT_AIR)
			else if(prob(50)) // extra chance to break unhardened
				break_tile()
		if(EXPLODE_LIGHT)
			if(prob(33)) // chance to break unhardened
				break_tile()

// lightly modified from /turf/open/floor/engine/acid_act()
/turf/open/floor/concrete/reinforced/acid_act(acidpwr, acid_volume)
	acidpwr = min(acidpwr, 50)
	return ..()

/turf/open/floor/concrete/pavement
	name = "pavement"
	desc = "The hot, coarse, and somewhat pavement. Vehicles driven on this are generally quiter than on traditional concrete, and is prefered for roadways."
	icon_state = "pavement_1"
	base_icon_state = "pavement"
	broken_states = null
	shape_types = list(
		/turf/open/floor/concrete/pavement,
	)


/turf/open/floor/concrete/pavement/airless
	initial_gas_mix = AIRLESS_ATMOS
