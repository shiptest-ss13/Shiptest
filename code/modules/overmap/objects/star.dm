/datum/overmap/star
	name = "star"
	var/token_desc = "A star."
	var/spectral_type = STAR_G
	var/color_vary = 0

/datum/overmap/star/Initialize(position, ...)
	var/name = gen_star_name()
	Rename(name)
	set_station_name(name)
	token.desc = token_desc
	alter_token_appearance()


/datum/overmap/star/proc/gen_star_name()
	return "[pick(GLOB.star_names)] [pick(GLOB.greek_letters)]"

/datum/overmap/star/proc/alter_token_appearance()
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
	token_icon_state = "star1"
	token_desc = "A red dwarf. Smallest and most numerous of the main-sequence stars, some red dwarves boast trillion-year lifespans; none have yet died of old age."
	spectral_type = STAR_M
	color_vary = 0.5

/datum/overmap/star/dwarf/orange
	token_desc = "One of the main sequence stars, this orange dwarf star emits a steady glow, as it has for billions of years."
	spectral_type = STAR_K
	color_vary = 0.25

/datum/overmap/star/dwarf/brown
	token_desc = "Clocking in at only several dozen septillion tons, this body is much lighter than true stars. " +\
				"Known as a \"brown dwarf\", it is unable to sustain hydrogen fusion, and is warmed by deuterium fusion instead."
	spectral_type = STAR_T
	color_vary = 1

/datum/overmap/star/dwarf/white
	token_desc = "The incredibly dense corpse of a former star. Still white-hot, it slowly radiates its remaining heat into space."
	spectral_type = STAR_B
	color_vary = 1

/*
		Mid-size stars
*/

/datum/overmap/star/medium
	token_icon_state = "star2"
	token_desc = "A yellow main-sequence star. Deep beneath the surface, its core churns violently in fusion, so dense as to be utterly impenetrable to light or sound." // or Say It Ain't So
	spectral_type = STAR_G
	color_vary = 0.25

/datum/overmap/star/medium/alter_token_appearance()
	token.icon = 'icons/misc/overmap_large.dmi'
	token.bound_height = 64
	token.bound_width = 64
	token.pixel_x = -16
	token.pixel_y = -16
	..()

/datum/overmap/star/medium/blue
	token_desc = "A young, blue, massive main-sequence star. The reactions at its core are so intense as to whip the entire star into convection waves."
	spectral_type = STAR_B

/datum/overmap/star/medium/bluewhite
	token_desc = "This main-sequence star is young and large; it burns hot and fast. Though not as blindingly bright as a giant, its glare is still harsh."
	spectral_type = STAR_A

/datum/overmap/star/medium/white
	token_desc = "A bright white main-sequence star, with a surface temperature of 6,000 to 7,000 Kelvin. The core is much, much hotter."
	spectral_type = STAR_F

/datum/overmap/star/medium/orange
	token_desc = "One of the main sequence stars, this orange dwarf star emits a steady glow, as it has for billions of years."
	spectral_type = STAR_K

/*
		Giant stars
*/

/datum/overmap/star/giant
	token_icon_state = "star3"
	token_desc = "A blue giant star. Though massive and incredibly hot, it can only sustain its intense luminosity for so long."
	spectral_type = STAR_B
	color_vary = 1

/datum/overmap/star/giant/alter_token_appearance()
	token.icon = 'icons/misc/overmap_larger.dmi'
	token.bound_height = 96
	token.bound_width = 96
	token.pixel_x = -32
	token.pixel_y = -32
	..()

/datum/overmap/star/giant/yellow
	token_desc = "Like many other yellow giants, this dying star \"pulsates\" as its brightness fluctuates rhythmically."
	spectral_type = STAR_G
	color_vary = 0.25

/datum/overmap/star/giant/yellow/alter_token_appearance()
	..()
	// adds a slight, slow flicker
	// this took me far too long to get working right
	var/half_duration = rand(7 SECONDS, 15 SECONDS)
	animate(token, color = token.color, time = half_duration, loop = -1, easing = SINE_EASING, flags = ANIMATION_PARALLEL)
	animate(color = get_rand_spectral_color(STAR_G - 0.5, 0.125), time = half_duration, easing = SINE_EASING)

/datum/overmap/star/giant/red
	token_desc = "Huge and imposing, this red giant has exhausted the hydrogen within its core, and has expanded and brightened as a result. It has begun to die."
	spectral_type = STAR_M

/*
		Binary stars
*/

/datum/overmap/star/binary
	token_icon_state = "binaryswoosh"
	token_desc = "Two stars, each locked in the other's orbit. These systems form at stellar birth, and may persist long after one or both stars die."
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
	star_1.color = get_rand_spectral_color(pick(spectral_types), color_vary)
	token.add_overlay(star_1)

	star_2 = mutable_appearance(icon_state = "binary2")
	star_2.color = get_rand_spectral_color(pick(spectral_types), color_vary)
	token.add_overlay(star_2)

/*
		Special stars
*/
/datum/overmap/star/singularity
	name = "black hole"
	token_desc = "An incredibly dense astral body, so massive even light cannot escape its gravitational pull past the event horizon."
	token_icon_state = "eventhorizon"

/datum/overmap/star/singularity/alter_token_appearance()
	var/mutable_appearance/AD = mutable_appearance(icon_state = "accretiondisk")
	AD.color = "#f9c429"
	token.add_overlay(AD)
	token.icon = 'icons/misc/overmap_larger.dmi'
	token.bound_height = 96
	token.bound_width = 96
	token.pixel_x = -32
	token.pixel_y = -32
