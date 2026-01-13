/datum/overmap/star
	name = "star"
	desc = "A star."

	interference_power = 30

	var/spectral_type = STAR_G
	var/color_vary = 0
	/// Do we randomly have a color? If FALSE we take the spectral_type and use that color
	var/custom_color = TRUE

	///Do we randomy spawn events around this star? If FALSE then this star doesn't spawn anything
	var/enable_event_spawning = TRUE

	///List of events this star can spawn
	var/list/events_to_spawn = list(\
		/datum/overmap/event/flare/minor = 40,
		/datum/overmap/event/flare = 20,
		/datum/overmap/event/flare/major = 5,
/*
		/datum/overmap/event/emp/minor = 20,
		/datum/overmap/event/emp = 10,
		/datum/overmap/event/emp/major = 5,
*/
		/datum/overmap/event/rad/minor = 40,
		/datum/overmap/event/rad = 20,
		/datum/overmap/event/rad/major = 5,
	)

	///The minimum lifespan of the random events
	var/event_lifespan_min = (20 SECONDS)
	///The maximum lifespan of the random events
	var/event_lifespan_max = (80 SECONDS)

	///The minimum spawn range of the random events.
	var/eventspawn_min_range = 1
	///The maximum spawn range of the random events.
	var/eventspawn_max_range = 2


	///The minimum lifespan of the random events
	var/eventspawn_cooldown_min = (5 SECONDS)
	///The maximum lifespan of the random events
	var/eventspawn_cooldown_max = (15 SECONDS)
	///cooldown declare to store this value
	COOLDOWN_DECLARE(event_spawn_cd)


/datum/overmap/star/Initialize(position, datum/overmap_star_system/system_spawned_in, ...)
	var/name = gen_star_name()
	SSpoints_of_interest.make_point_of_interest(token)
	Rename(name)
	alter_token_appearance()
	START_PROCESSING(SSprocessing, src)

/datum/overmap/star/Destroy(force, ...)
	SSpoints_of_interest.remove_point_of_interest(token)
	. = ..()
	STOP_PROCESSING(SSprocessing, src)

/datum/overmap/star/process()
	var/datum/overmap/event/picked_event_to_spawn
	var/list/directions_to_spawn_event = GLOB.alldirs
	var/spawndir
	var/spawn_sametile = FALSE
	//First off if we outlived our usefulness then we self destrutct


	if(!enable_event_spawning || !(COOLDOWN_FINISHED(src, event_spawn_cd)))
		return

	if(spawn_sametile)
		directions_to_spawn_event += NONE
	picked_event_to_spawn = pick_weight(events_to_spawn)
	if(!picked_event_to_spawn)
		return
	spawndir = pick(directions_to_spawn_event)

	var/list/new_cords = get_overmap_step(spawndir, rand(eventspawn_min_range, eventspawn_max_range))
	for(var/datum/overmap/current_event as anything in current_overmap.overmap_container[new_cords["x"]][new_cords["y"]])
		if(istype(current_event, /datum/overmap/event))
			return

	var/datum/overmap/event/newvent = new picked_event_to_spawn(list("x" = x, "y" = y), current_overmap, rand(event_lifespan_min, event_lifespan_max))
	newvent.overmap_move(new_cords["x"],new_cords["y"])
	COOLDOWN_START(src, event_spawn_cd, rand(eventspawn_cooldown_min, eventspawn_cooldown_max))

/datum/overmap/star/proc/gen_star_name()
	return "[pick(GLOB.star_names)] [pick(GLOB.greek_letters)]"

/datum/overmap/star/alter_token_appearance()
	. = ..()
	if(!custom_color)
		token.add_atom_colour(current_overmap.hazard_primary_color, FIXED_COLOUR_PRIORITY)
		return
	token.add_atom_colour(get_rand_spectral_color(spectral_type, color_vary), FIXED_COLOUR_PRIORITY)

/datum/overmap/star/proc/get_rand_spectral_color(base_spec, vary_amt = 0)
	var/adj_spec = base_spec + LERP(-vary_amt, vary_amt, rand())
	var/result = gradient(
		STAR_O, "#a6c4ff",
		STAR_B, "#d9f9ff",
		STAR_A, "#f0ffff",
		STAR_F, "#ffffff",
		STAR_G, "#ffff60",
		STAR_K, "#ffb060",
		STAR_M, "#f24f18",
		STAR_L, "#e50b0b",
		STAR_T, "#a60347",
		STAR_Y, "#4a3059",
		index = adj_spec
	)
	return result

/*
		Dwarf stars
*/

/datum/overmap/star/dwarf
	token_icon_state = "star_new"
	desc = "A red dwarf. Smallest and most numerous of the main-sequence stars, some red dwarves boast trillion-year lifespans; none have yet died of old age."
	interference_power = 10
	spectral_type = STAR_M
	color_vary = 0.5

	eventspawn_max_range = 1

	eventspawn_cooldown_min = (20 SECONDS)
	eventspawn_cooldown_max = (30 SECONDS)

/datum/overmap/star/dwarf/orange
	desc = "One of the main sequence stars, this orange dwarf star emits a steady glow, as it has for billions of years."
	spectral_type = STAR_K
	color_vary = 0.25

/datum/overmap/star/dwarf/brown
	token_icon_state = "giant"
	desc = "Clocking in at only several dozen septillion tons, this body is much lighter than true stars. " +\
				"Known as a \"brown dwarf\", it is unable to sustain hydrogen fusion, and is warmed by deuterium fusion instead."
	spectral_type = STAR_T
	color_vary = 1
	events_to_spawn = list(\
	/*
		/datum/overmap/event/emp/minor = 40,
		/datum/overmap/event/emp = 20,
		/datum/overmap/event/emp/major = 5,
*/
		/datum/overmap/event/rad/minor = 40,
		/datum/overmap/event/rad = 20,
		/datum/overmap/event/rad/major = 5,
	)

/datum/overmap/star/dwarf/white
	desc = "The incredibly dense corpse of a former star. Still white-hot, it slowly radiates its remaining heat into space."
	spectral_type = STAR_B
	color_vary = 1

	events_to_spawn = list(\
		/datum/overmap/event/electric/minor = 50,
		/datum/overmap/event/electric = 40,
		/datum/overmap/event/electric/major = 3,
/*
		/datum/overmap/event/emp/minor = 80,
		/datum/overmap/event/emp = 100,
		/datum/overmap/event/emp/major = 120,
*/
		/datum/overmap/event/rad/minor = 20,
		/datum/overmap/event/rad = 10,
		/datum/overmap/event/rad/major = 5,
	)
	eventspawn_cooldown_min = (4 SECONDS)
	eventspawn_cooldown_max = (8 SECONDS)

/*
		Mid-size stars
*/

/datum/overmap/star/medium
	token_icon_state = "star2"
	desc = "A yellow main-sequence star. Deep beneath the surface, its core churns violently in fusion, so dense as to be utterly impenetrable to light or sound." // or Say It Ain't So
	spectral_type = STAR_G
	color_vary = 0.25

/datum/overmap/star/medium/alter_token_appearance()
	. = ..()
	token.icon = 'icons/misc/overmap_large.dmi'
	token.bound_height = 64
	token.bound_width = 64
	token.pixel_x = -16
	token.pixel_y = -16
	current_overmap.post_edit_token_state(src)

/datum/overmap/star/medium/blue
	desc = "A young, blue, massive main-sequence star. The reactions at its core are so intense as to whip the entire star into convection waves."
	spectral_type = STAR_B

/datum/overmap/star/medium/bluewhite
	desc = "This main-sequence star is young and large; it burns hot and fast. Though not as blindingly bright as a giant, its glare is still harsh."
	spectral_type = STAR_A

/datum/overmap/star/medium/white
	desc = "A bright white main-sequence star, with a surface temperature of 6,000 to 7,000 Kelvin. The core is much, much hotter."
	spectral_type = STAR_F

/datum/overmap/star/medium/orange
	desc = "One of the main sequence stars, this orange dwarf star emits a steady glow, as it has for billions of years."
	spectral_type = STAR_K

/*
		Giant stars
*/

/datum/overmap/star/giant
	token_icon_state = "star3"
	desc = "A blue giant star. Though massive and incredibly hot, it can only sustain its intense luminosity for so long."
	spectral_type = STAR_B
	color_vary = 1

/datum/overmap/star/giant/alter_token_appearance()
	. = ..()
	token.icon = 'icons/misc/overmap_larger.dmi'
	token.bound_height = 96
	token.bound_width = 96
	token.pixel_x = -32
	token.pixel_y = -32
	current_overmap.post_edit_token_state(src)

/datum/overmap/star/giant/yellow
	desc = "Like many other yellow giants, this dying star \"pulsates\" as its brightness fluctuates rhythmically."
	spectral_type = STAR_G
	color_vary = 0.25

/datum/overmap/star/giant/yellow/alter_token_appearance()
	. = ..()
	// adds a slight, slow flicker
	// this took me far too long to get working right
	var/half_duration = rand(7 SECONDS, 15 SECONDS)
	animate(token, color = token.color, time = half_duration, loop = -1, easing = SINE_EASING, flags = ANIMATION_PARALLEL)
	animate(color = get_rand_spectral_color(STAR_G - 0.5, 0.125), time = half_duration, easing = SINE_EASING)

/datum/overmap/star/giant/red
	desc = "Huge and imposing, this red giant has exhausted the hydrogen within its core, and has expanded and brightened as a result. It has begun to die."
	spectral_type = STAR_M

/*
		Binary stars
*/

/datum/overmap/star/binary
	token_icon_state = "binaryswoosh"
	desc = "Two stars, each locked in the other's orbit. These systems form at stellar birth, and may persist long after one or both stars die."
	interference_power = 40
	color_vary = 0.75

/datum/overmap/star/binary/gen_star_name()
	return (..() + " AB")

/datum/overmap/star/binary/alter_token_appearance()
	// we don't call the parent proc, since we do colors our own way

	var/mutable_appearance/star_1
	var/mutable_appearance/star_2
	var/static/list/spectral_types = list(
		STAR_B,
		STAR_F,
		STAR_G,
		STAR_K,
		STAR_M,
		STAR_L,
		STAR_T,
	)
	token.cut_overlays()
	token.icon = 'icons/misc/overmap_larger.dmi'
	token.bound_height = 96
	token.bound_width = 96
	token.pixel_x = -32
	token.pixel_y = -32

	star_1 = mutable_appearance(icon_state = "binary1")
	star_2 = mutable_appearance(icon_state = "binary2")

	star_1.color = current_overmap.hazard_primary_color
	star_2.color = current_overmap.hazard_primary_color

	if(custom_color)
		star_1.color = get_rand_spectral_color(pick(spectral_types), color_vary)
		star_2.color = get_rand_spectral_color(pick(spectral_types), color_vary)

	token.add_overlay(star_1)
	token.add_overlay(star_2)

	token.name = name
	token.desc = desc

/*
		Special stars
*/
/datum/overmap/star/singularity
	name = "black hole"
	desc = "An incredibly dense astral body, so massive even light cannot escape its gravitational pull past the event horizon."
	interference_power = 60
	token_icon_state = "accretiondisk"
	spectral_type = STAR_K
	color_vary = 1

	events_to_spawn = list(\
		/datum/overmap/event/nebula = 40,
/*
		/datum/overmap/event/emp/minor = 20,
		/datum/overmap/event/emp = 30,
		/datum/overmap/event/emp/major = 40,
*/
		/datum/overmap/event/rad/minor = 60,
		/datum/overmap/event/rad = 70,
		/datum/overmap/event/rad/major = 80,
	)
	event_lifespan_min = (30 SECONDS)
	event_lifespan_max = (100 SECONDS)

	eventspawn_cooldown_min = (4 SECONDS)
	eventspawn_cooldown_max = (8 SECONDS)

/datum/overmap/star/singularity/alter_token_appearance()
	. = ..()
	token.icon = 'icons/misc/overmap_larger.dmi'
	token.bound_height = 96
	token.bound_width = 96
	token.pixel_x = -32
	token.pixel_y = -32

/datum/overmap/star/pulsar
	name = "Pulsar"
	desc = "An incredibly dense star that spins incredibly fast, shooting out radiation out of both it's poles. it is mainly made of neutrons as it's intense gravity causes other particles to combine into more neutrons."
	interference_power = 300
	spectral_type = STAR_F
	color_vary = 0.5
	token_icon_state = "pulsar"

	color_vary = 1

	events_to_spawn = list(\
		/datum/overmap/event/electric/minor = 50,
		/datum/overmap/event/electric = 40,
		/datum/overmap/event/electric/major = 3,
/*
		/datum/overmap/event/emp/minor = 80,
		/datum/overmap/event/emp = 100,
		/datum/overmap/event/emp/major = 120,
*/
		/datum/overmap/event/rad/minor = 20,
		/datum/overmap/event/rad = 10,
		/datum/overmap/event/rad/major = 5,
	)
	event_lifespan_min = (30 SECONDS)
	event_lifespan_max = (100 SECONDS)

	eventspawn_cooldown_min = (4 SECONDS)
	eventspawn_cooldown_max = (8 SECONDS)

/datum/overmap/star/pulsar/alter_token_appearance()
	. = ..()
	token.icon = 'icons/misc/overmap_larger.dmi'
	token.bound_height = 96
	token.bound_width = 96
	token.pixel_x = -32
	token.pixel_y = -32

	var/half_duration = rand(7 SECONDS, 15 SECONDS)
	animate(token, color = token.color, time = half_duration, loop = -1, easing = SINE_EASING, flags = ANIMATION_PARALLEL)
	animate(color = get_rand_spectral_color(STAR_F - 0.5, 0.125), time = half_duration, easing = SINE_EASING)
