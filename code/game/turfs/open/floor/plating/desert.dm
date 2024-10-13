/turf/open/floor/plating/asteroid/desert
	gender = PLURAL
	name = "desert sand"
	desc = "It's coarse and gets everywhere."
	baseturfs = /turf/open/floor/plating/asteroid/desert
	icon = 'icons/turf/planetary/desert.dmi'
	icon_state = "desert"
	base_icon_state = "desert"
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	planetary_atmos = TRUE
	initial_gas_mix = DESERT_DEFAULT_ATMOS
	slowdown = 1.5

	floor_variance = 0
	max_icon_states = 0

	// footprint vars
	var/entered_dirs
	var/exited_dirs

/turf/open/floor/plating/asteroid/desert/Entered(atom/movable/AM)
	. = ..()
	if(!iscarbon(AM) || (AM.movement_type & (FLYING|VENTCRAWLING|FLOATING|PHASING)))
		return
	if(!(entered_dirs & AM.dir))
		entered_dirs |= AM.dir
		update_icon()

/turf/open/floor/plating/asteroid/desert/Exited(atom/movable/AM)
	. = ..()
	if(!iscarbon(AM) || (AM.movement_type & (FLYING|VENTCRAWLING|FLOATING|PHASING)))
		return
	if(!(exited_dirs & AM.dir))
		exited_dirs |= AM.dir
		update_icon()

// adapted version of footprints' update_icon code
/turf/open/floor/plating/asteroid/desert/update_overlays()
	. = ..()
	for(var/Ddir in GLOB.cardinals)
		if(entered_dirs & Ddir)
			var/image/print = GLOB.bloody_footprints_cache["entered-desert-[Ddir]"]
			if(!print)
				print = image('icons/effects/footprints.dmi', "desert1", layer = TURF_DECAL_LAYER, dir = Ddir)
				GLOB.bloody_footprints_cache["entered-desert-[Ddir]"] = print
			. += print
		if(exited_dirs & Ddir)
			var/image/print = GLOB.bloody_footprints_cache["exited-desert-[Ddir]"]
			if(!print)
				print = image('icons/effects/footprints.dmi', "desert2", layer = TURF_DECAL_LAYER, dir = Ddir)
				GLOB.bloody_footprints_cache["exited-desert-[Ddir]"] = print
			. += print

// pretty much ripped wholesale from footprints' version of this proc
/turf/open/floor/plating/asteroid/desert/setDir(newdir)
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

/turf/open/floor/plating/asteroid/desert/getDug()
	. = ..()
	cut_overlays()

/turf/open/floor/plating/asteroid/desert/lit
	light_range = 2
	light_power = 0.6
	light_color = "#ffd2bd"
	baseturfs = /turf/open/floor/plating/asteroid/desert/lit

/turf/open/floor/plating/asteroid/dry_seafloor
	gender = PLURAL
	name = "dry seafloor"
	desc = "Should have stayed hydrated."
	icon = 'icons/turf/planetary/desert.dmi'
	baseturfs = /turf/open/floor/plating/asteroid/dry_seafloor
	icon_state = "drydesert"
	base_icon_state = "drydesert"
	footstep = FOOTSTEP_FLOOR
	barefootstep = FOOTSTEP_ASTEROID
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	floor_variance = 0
	max_icon_states = 0
	planetary_atmos = TRUE
	initial_gas_mix = DESERT_DEFAULT_ATMOS

/turf/open/floor/plating/asteroid/dry_seafloor/lit
	light_range = 2
	light_power = 0.6
	light_color = "#ffd2bd"
	baseturfs = /turf/open/floor/plating/asteroid/dry_seafloor/lit
