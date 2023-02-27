/datum/map_generator/single_biome
	var/use_cellautomata = TRUE
	/// Chance for a cell in the cavegen cellular automaton to start closed
	var/initial_closed_chance = 45
	/// # of steps that the cellular automaton is run for
	var/smoothing_iterations = 20
	/// If an open (dead) cell has greater than this many neighbors, it become closed (alive).
	var/birth_limit = 4
	/// If a closed (alive) cell has fewer than this many neighbors, it will become open (dead).
	var/death_limit = 3

	/// The type of biome to use for turf generation and population.
	var/datum/biome/biome_type
	/// Stored reference to the biome, 'cause why not.
	var/datum/biome/biome

	/// The type of area to use for generated turfs.
	var/area/area_type
	/// The area instance used for generated turfs.
	var/area/used_area

	// temporary internal var used during planet generation to store the output of the cave-automaton
	var/string_gen

	// temporary internal lists, storing created features / mobs to speedup spawning
	// it takes too long to look at nearby turfs, so we just store them and then
	// iterate through the list when we want to see if there is anything nearby.
	// yes, this does mean that creatures / features can spawn adjacent to ones mapped into ruins
	// this is unfortunate, but mostly irrelevant
	var/list/created_features
	var/list/created_mobs

/datum/map_generator/single_biome/New(...)
	used_area = GLOB.areas_by_type[area_type] || new area_type
	if(use_cellautomata)
		string_gen = rustg_cnoise_generate("[initial_closed_chance]", "[smoothing_iterations]", "[birth_limit]", "[death_limit]", "[world.maxx]", "[world.maxy]")
	biome = SSmapping.biomes[biome_type]

	return ..()

/datum/map_generator/single_biome/generate_turf(turf/gen_turf, changeturf_flags)
	var/area/A = get_area(gen_turf)
	if(!(A.area_flags & CAVES_ALLOWED))
		return

	biome.generate_turf(gen_turf, used_area, changeturf_flags, string_gen)

/datum/map_generator/single_biome/populate_turfs()
	created_features = list()
	created_mobs = list()
	. = ..()
	// clear the lists, so we don't get harddels
	created_features = null
	created_mobs = null

/datum/map_generator/single_biome/populate_turf(turf/gen_turf)
	var/area/A = gen_turf.loc
	if(!(A.area_flags & CAVES_ALLOWED))
		return

	biome.populate_turf(gen_turf, created_features, created_mobs)
