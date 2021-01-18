// Used to define "camps" of surviviors, nests of mobs, or other templates primarily geared towards creating tendril-like locations.
/datum/map_template/ruin/camp/whitesands
	prefix = "_maps/RandomRuins/SandCamps/"
	// Used to associate the mobs generated in the area with eachother.
	var/camp_id = "error_contact_coder"

/datum/map_template/ruin/camp/whitesands/New()
	. = ..()
	//In the event this collides, it's a feature, not a bug.
	camp_id = "[id]:[rand(1, 128)]"

/datum/map_template/ruin/camp/whitesands/load(turf/T, centered = FALSE)
	if(centered)
		T = locate(T.x - round(width/2) , T.y - round(height/2) , T.z)
	if(!T)
		return
	if(T.x+width > world.maxx)
		return
	if(T.y+height > world.maxy)
		return

	var/list/border = block(locate(max(T.x-1, 1),			max(T.y-1, 1),			 T.z),
							locate(min(T.x+width+1, world.maxx),	min(T.y+height+1, world.maxy), T.z))
	for(var/L in border)
		var/turf/turf_to_disable = L
		SSair.remove_from_active(turf_to_disable) //stop processing turfs along the border to prevent runtimes, we return it in initTemplateBounds()
		turf_to_disable.atmos_adjacent_turfs?.Cut()

	// Accept cached maps, but don't save them automatically - we don't want
	// ruins clogging up memory for the whole round.
	var/datum/parsed_map/camp/parsed = cached_map || new(file(mappath))
	cached_map = keep_cached_map ? parsed : null
	if(!parsed.load(T.x, T.y, T.z, cropMap=TRUE, no_changeturf=(SSatoms.initialized == INITIALIZATION_INSSATOMS), placeOnTop=TRUE))
		return
	var/list/bounds = parsed.bounds
	if(!bounds)
		return

	if(!SSmapping.loading_ruins) //Will be done manually during mapping ss init
		repopulate_sorted_areas()

	//initialize things that are normally initialized after map load
	parsed.initTemplateBounds(src.camp_id)

	log_game("[name] loaded at [T.x],[T.y],[T.z]")
	return bounds

/datum/parsed_map/camp

/datum/parsed_map/camp/initTemplateBounds(camp_id)
	var/list/obj/machinery/atmospherics/atmos_machines = list()
	var/list/obj/structure/cable/cables = list()
	var/list/atom/atoms = list()
	var/list/area/areas = list()

	var/list/turfs = block(	locate(bounds[MAP_MINX], bounds[MAP_MINY], bounds[MAP_MINZ]),
							locate(bounds[MAP_MAXX], bounds[MAP_MAXY], bounds[MAP_MAXZ]))
	var/list/border = block(locate(max(bounds[MAP_MINX]-1, 1),			max(bounds[MAP_MINY]-1, 1),			 bounds[MAP_MINZ]),
							locate(min(bounds[MAP_MAXX]+1, world.maxx),	min(bounds[MAP_MAXY]+1, world.maxy), bounds[MAP_MAXZ])) - turfs
	for(var/L in turfs)
		var/turf/B = L
		atoms += B
		areas |= B.loc
		for(var/A in B)
			atoms += A
			if(istype(A, /obj/structure/cable))
				cables += A
				continue
			if(istype(A, /obj/machinery/atmospherics))
				atmos_machines += A
			if(istype(A, /mob/living/simple_animal/hostile))
				var/mob/living/simple_animal/hostile/M = A
				M.set_camp_faction(camp_id)
	for(var/L in border)
		var/turf/T = L
		T.air_update_turf(TRUE) //calculate adjacent turfs along the border to prevent runtimes

	SSmapping.reg_in_areas_in_z(areas)
	SSatoms.InitializeAtoms(atoms)
	SSmachines.setup_template_powernets(cables)
	SSair.setup_template_machinery(atmos_machines)
