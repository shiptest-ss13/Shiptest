/turf/open/floor/plating/asteroid/shrouded
	name = "packed sand"
	desc = "Sand that has been packed into solid earth."
	icon = 'icons/turf/planetary/shrouded.dmi'
	icon_state = "shrouded0"
	base_icon_state = "shrouded"
	floor_variance = 20
	max_icon_states = 8
	slowdown = 1.5
	planetary_atmos = TRUE
	initial_gas_mix = SHROUDED_DEFAULT_ATMOS
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND

	// footprint vars
	var/entered_dirs
	var/exited_dirs

/turf/open/floor/plating/asteroid/shrouded/Entered(atom/movable/AM)
	. = ..()
	if(!iscarbon(AM) || (AM.movement_type & (FLYING|VENTCRAWLING|FLOATING|PHASING)))
		return
	if(!(entered_dirs & AM.dir))
		entered_dirs |= AM.dir
		update_icon()

/turf/open/floor/plating/asteroid/shrouded/Exited(atom/movable/AM)
	. = ..()
	if(!iscarbon(AM) || (AM.movement_type & (FLYING|VENTCRAWLING|FLOATING|PHASING)))
		return
	if(!(exited_dirs & AM.dir))
		exited_dirs |= AM.dir
		update_icon()

// adapted version of footprints' update_icon code
/turf/open/floor/plating/asteroid/shrouded/update_overlays()
	. = ..()
	for(var/Ddir in GLOB.cardinals)
		if(entered_dirs & Ddir)
			var/image/print = GLOB.bloody_footprints_cache["entered-conc-[Ddir]"]
			if(!print)
				print = image('icons/effects/footprints.dmi', "shrouded1", layer = TURF_DECAL_LAYER, dir = Ddir)
				GLOB.bloody_footprints_cache["entered-conc-[Ddir]"] = print
			. += print
		if(exited_dirs & Ddir)
			var/image/print = GLOB.bloody_footprints_cache["exited-conc-[Ddir]"]
			if(!print)
				print = image('icons/effects/footprints.dmi', "shrouded2", layer = TURF_DECAL_LAYER, dir = Ddir)
				GLOB.bloody_footprints_cache["exited-conc-[Ddir]"] = print
			. += print

// pretty much ripped wholesale from footprints' version of this proc
/turf/open/floor/plating/asteroid/shrouded/setDir(newdir)
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

/turf/open/floor/plating/asteroid/shrouded/getDug()
	. = ..()
	cut_overlays()
