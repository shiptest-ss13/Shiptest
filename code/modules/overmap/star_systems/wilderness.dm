//default shiptest overmap
/datum/overmap_star_system/wilderness
	has_outpost = FALSE
	encounters_refresh = TRUE

	entry_quotes = list(
		"..into the breach..",
		"..return to the garden..",
		"..treasure and riches untold..",
		"..back in the saddle..",
		"..tearing through the ashes..",
		"..burn bright, burn fast..",
	)

	///Bool for if the system is unique, and should only be spawned once during overmap gen
	var/unique_system = FALSE

/datum/overmap_star_system/wilderness/create_map()
	max_overmap_dynamic_events = CONFIG_GET(number/max_overmap_dynamic_events)
	. = ..()

/* to-do: heat signature
/datum/overmap_star_system/wilderness/acid_nebula
	event_probabilities = list(
		/datum/overmap/event/acid_cloud = 10,
		/datum/overmap/event/nebula = 60,
		/datum/overmap/event/electric/minor = 45,
		/datum/overmap/event/electric = 40,
		/datum/overmap/event/electric/major = 35,
		/datum/overmap/event/meteor/dust = 50,
		/datum/overmap/event/anomaly = 10
	)

	entry_quotes = list(
	)
*/

/datum/overmap_star_system/wilderness/regular_nebula
	event_probabilities = list(
		/datum/overmap/event/nebula = 60,
		/datum/overmap/event/meteor/dust = 30,
		/datum/overmap/event/emp = 20
	)
	entry_quotes = list(
		"..Somewhere in the heavens..",
		"..Check scanners and burn..",
		"..find some coffee..",
		"..least its not acid..",
		"..check the comms..",
		"..did you see that?"
	)

	fluff_amount = 3

	fluff_probabilities = list(
		/datum/overmap/fluff/observatory = 10,
		/datum/overmap/fluff/commsat/abandoned = 5,
		/datum/overmap/fluff/sensorsat/abandoned = 4,
		/datum/overmap/fluff/fakeplanet/gas_giant = 1
	)

/datum/overmap_star_system/wilderness/electric_nebula
	event_probabilities = list(
		/datum/overmap/event/wormhole = 5,
		/datum/overmap/event/nebula = 60,
		/datum/overmap/event/electric/minor = 45,
		/datum/overmap/event/electric = 40,
		/datum/overmap/event/electric/major = 20,
		/datum/overmap/event/meteor/dust = 50,
		/datum/overmap/event/anomaly = 5
	)
	entry_quotes = list(
		"..a dark and hidden place..",
		"..was that a sensor fluke?..",
		"..all I see is lightning..",
		"..something's out there..",
		"..radio's cutting out..",
		"..just follow the buoys..",
	)

	fluff_amount = 3

	fluff_probabilities = list(
		/datum/overmap/fluff/satellite/abandoned = 10,
		/datum/overmap/fluff/commsat/abandoned = 5,
		/datum/overmap/fluff/sensorsat/abandoned = 4,
		/datum/overmap/fluff/sensorsat/abandoned/madai = 1,
		/datum/overmap/fluff/fakeplanet/gas_giant = 1
	)

/datum/overmap_star_system/wilderness/singularity
	startype = /datum/overmap/star/singularity
	dynamic_probabilities = list(
		DYNAMIC_WORLD_LAVA = 15,
		DYNAMIC_WORLD_ICE = 40,
		DYNAMIC_WORLD_SAND = 30,
		DYNAMIC_WORLD_JUNGLE = 10,
		DYNAMIC_WORLD_ROCKPLANET = 10,
		DYNAMIC_WORLD_BEACHPLANET = 5,
		DYNAMIC_WORLD_WASTEPLANET = 5,
		DYNAMIC_WORLD_SPACERUIN = 20,
		DYNAMIC_WORLD_MOON = 25
	)
	event_probabilities = list(
		/datum/overmap/event/nebula = 60,
		/datum/overmap/event/meteor/minor = 45,
		/datum/overmap/event/meteor = 40,
		/datum/overmap/event/meteor/major = 35,
		/datum/overmap/event/meteor/dust = 50,
		/datum/overmap/event/anomaly = 10
	)
	entry_quotes = list(
		"..the corpse of a giant..",
		"..the great devourer..",
		"..mind the event horizon..",
		"..time diliation is an awful thing..",
		"..a dark splotch in the cosmos..",
		"..an abyss where light dies..",
	)

	fluff_amount = 1

	fluff_probabilities = list(
		/datum/overmap/fluff/observatory = 1,
		/datum/overmap/fluff/commsat/abandoned = 1
	)

/datum/overmap_star_system/wilderness/singularity/nonoriri
	startype = /datum/overmap/star/singularity
	starname = "Nonoriri"
	event_probabilities = list(
		/datum/overmap/event/nebula = 60,
		/datum/overmap/event/meteor/minor = 45,
		/datum/overmap/event/meteor/debris = 40,
		/datum/overmap/event/meteor/debris/minor = 35,
		/datum/overmap/event/meteor/dust = 50,
		/datum/overmap/event/anomaly = 10
	)
	entry_quotes = list(
		"..hard work and guts..",
		"..birth of a new world..",
		"..power in your heart..",
		"..nothing lasts forever..",
		"..aim for the top..",
		"..remember us.."
	)

	fluff_amount = 1

	fluff_probabilities = list(
		/datum/overmap/fluff/memorial_beacon/nori
	)
	unique_system = TRUE

/datum/overmap_star_system/wilderness/temperate
	startype = /datum/overmap/star/medium
	dynamic_probabilities = list(
		DYNAMIC_WORLD_LAVA = 30,
		DYNAMIC_WORLD_ICE = 20,
		DYNAMIC_WORLD_SAND = 30,
		DYNAMIC_WORLD_JUNGLE = 30,
		DYNAMIC_WORLD_ROCKPLANET = 20,
		DYNAMIC_WORLD_BEACHPLANET = 40,
		DYNAMIC_WORLD_WASTEPLANET = 5,
		DYNAMIC_WORLD_SPACERUIN = 20,
		DYNAMIC_WORLD_MOON = 20
	)
	event_probabilities = list(
		/datum/overmap/event/wormhole = 10,
		/datum/overmap/event/electric/minor = 45,
		/datum/overmap/event/electric = 40,
		/datum/overmap/event/electric/major = 20,
		/datum/overmap/event/meteor/minor = 45,
		/datum/overmap/event/meteor = 40,
		/datum/overmap/event/meteor/major = 20,
		/datum/overmap/event/meteor/carp/minor = 45,
		/datum/overmap/event/meteor/carp = 35,
		/datum/overmap/event/meteor/carp/major = 20,
		/datum/overmap/event/meteor/dust = 50,
		/datum/overmap/event/anomaly = 10
	)
	entry_quotes = list(
		"..quiet, too quiet..",
		"..another calm sun..",
		"..the Greenbelt's triumph..",
		"..its life, but not ours..",
		"..breathable air, bad water..",
	)

	fluff_amount = 5

	//to-do: get someone to sprite orbital terraforming equipment tokens.
	fluff_probabilities = list(
		/datum/overmap/fluff/satellite/abandoned = 10,
		/datum/overmap/fluff/solarmirror/abandoned = 5,
		/datum/overmap/fluff/commsat/abandoned = 3,
		/datum/overmap/fluff/solars/abandoned = 2,
		/datum/overmap/fluff/spacecolony/abandoned = 1,
		/datum/overmap/fluff/refinery/abandoned = 1
	)

/datum/overmap_star_system/wilderness/temperate/solar_farm
	event_probabilities = list(
		/datum/overmap/event/meteor/minor = 45,
		/datum/overmap/event/meteor = 40,
		/datum/overmap/event/meteor/carp/minor = 45,
		/datum/overmap/event/meteor/dust = 50,
		/datum/overmap/event/meteor/debris = 35,

	)
	entry_quotes = list(
		"..solar pumped..",
		"..panels upon panels ..",
		"..power for all..",
		"..imagine the future..",
	)

	fluff_amount = 12

	//to-do: get someone to sprite orbital terraforming equipment tokens.
	fluff_probabilities = list(
		/datum/overmap/fluff/solars/abandoned = 10,
		/datum/overmap/fluff/satellite/abandoned = 5,
		/datum/overmap/fluff/solarmirror/abandoned = 5,
		/datum/overmap/fluff/spacecolony/abandoned = 1,
	)

/datum/overmap_star_system/wilderness/warzone
	startype = /datum/overmap/star/medium/orange
	dynamic_probabilities = list(
		DYNAMIC_WORLD_LAVA = 20,
		DYNAMIC_WORLD_ICE = 20,
		DYNAMIC_WORLD_SAND = 30,
		DYNAMIC_WORLD_JUNGLE = 30,
		DYNAMIC_WORLD_ROCKPLANET = 15,
		DYNAMIC_WORLD_BEACHPLANET = 15,
		DYNAMIC_WORLD_WASTEPLANET = 30,
		DYNAMIC_WORLD_SPACERUIN = 20,
		DYNAMIC_WORLD_MOON = 20
	)
	event_probabilities = list(
		/datum/overmap/event/nebula = 60,
		/datum/overmap/event/electric/minor = 45,
		/datum/overmap/event/electric = 40,
		/datum/overmap/event/electric/major = 35,
		/datum/overmap/event/meteor/debris/minor = 45,
		/datum/overmap/event/meteor/debris = 40,
		/datum/overmap/event/meteor/debris/major = 35,
		/datum/overmap/event/meteor/carp/minor = 45,
		/datum/overmap/event/meteor/carp = 35,
		/datum/overmap/event/meteor/dust = 50,
	)
	entry_quotes = list(
		"..incoming sector 392..",
		"..standby for engagement..",
		"..in contact, good luck..",
		"..brace for impact..",
		"..will it be enough?..",
		"..the fire is spreading.."
	)

	fluff_amount = 9
	//to-do: get someone to sprite orbital terraforming equipment tokens.
	fluff_probabilities = list(
		/datum/overmap/fluff/dud = 5,
		/datum/overmap/fluff/satellite/abandoned = 10,
		/datum/overmap/fluff/sensorsat/abandoned = 9,
		/datum/overmap/fluff/sensorsat/abandoned/madai = 1,
		/datum/overmap/fluff/commsat/abandoned = 10,
		/datum/overmap/fluff/fakeplanet/plasma_giant = 3,
		/datum/overmap/fluff/orbitalworks/abandoned = 3,
		/datum/overmap/fluff/spacecolony/abandoned = 3
	)

/datum/overmap_star_system/wilderness/warzone/wenli
	startype = /datum/overmap/star/medium/blue
	starname = "Wen Li"

	event_probabilities = list(
		/datum/overmap/event/nebula = 60,
		/datum/overmap/event/meteor/debris/minor = 45,
		/datum/overmap/event/meteor/debris = 40,
		/datum/overmap/event/meteor/debris/major = 35,
		/datum/overmap/event/meteor/dust = 10,
		/datum/overmap/event/meteor = 30,
		/datum/overmap/event/meteor/minor = 40,
		/datum/overmap/event/meteor/major = 10
	)
	entry_quotes = list(
		"..break my commandments..",
		"..foppery and whim..",
		"..your vision narrows..",
		"..the magic lamp..",
		"..deny the value of fire..",
		"..no such thing as predetermined.."
	)

	fluff_amount = 9
	fluff_probabilities = list(
		/datum/overmap/fluff/dud = 5,
		/datum/overmap/fluff/satellite/abandoned = 10,
		/datum/overmap/fluff/sensorsat/abandoned = 9,
		/datum/overmap/fluff/commsat/abandoned = 10,
		/datum/overmap/fluff/orbitalworks/abandoned = 3,
		/datum/overmap/fluff/spacecolony/abandoned = 3
	)
	unique_system = TRUE

/datum/overmap_star_system/wilderness/anomaly
	dynamic_probabilities = list(
		DYNAMIC_WORLD_LAVA = 40,
		DYNAMIC_WORLD_ICE = 25,
		DYNAMIC_WORLD_SAND = 25,
		DYNAMIC_WORLD_JUNGLE = 25,
		DYNAMIC_WORLD_ROCKPLANET = 40,
		DYNAMIC_WORLD_BEACHPLANET = 5,
		DYNAMIC_WORLD_WASTEPLANET = 5,
		DYNAMIC_WORLD_SPACERUIN = 15,
		DYNAMIC_WORLD_MOON = 5
	)
	event_probabilities = list(
		/datum/overmap/event/nebula = 60,
		/datum/overmap/event/electric/minor = 45,
		/datum/overmap/event/electric = 40,
		/datum/overmap/event/electric/major = 35,
		/datum/overmap/event/anomaly = 10,
		/datum/overmap/event/meteor/dust = 50
	)
	entry_quotes = list(
		"..something from outside..",
		"..the stars love you..",
		"..don't leave us here..",
		"..millions of hands all reaching out..",
		"..don't look..",
		"..I don't want to forget.."
	)

	fluff_amount = 1
	fluff_probabilities = list(
		/datum/overmap/fluff/observatory = 4,
		/datum/overmap/fluff/observatory/losingit = 1,
		/datum/overmap/fluff/observatory/insane = 1
	)

/datum/overmap_star_system/wilderness/terraforming
	dynamic_probabilities = list(
		DYNAMIC_WORLD_LAVA = 30,
		DYNAMIC_WORLD_ICE = 20,
		DYNAMIC_WORLD_SAND = 30,
		DYNAMIC_WORLD_JUNGLE = 25,
		DYNAMIC_WORLD_ROCKPLANET = 40,
		DYNAMIC_WORLD_BEACHPLANET = 10,
		DYNAMIC_WORLD_WASTEPLANET = 5,
		DYNAMIC_WORLD_SPACERUIN = 15,
		DYNAMIC_WORLD_MOON = 15
	)
	entry_quotes = list(
		"..just a few more years..",
		"..progress interrupted..",
		"..one day flowers will bloom..",
		"..natural wonders paved over with science..",
		"..Teceti's ultimate folly..",
		"..pick a flower..",
	)

	fluff_amount = 4
	fluff_probabilities = list(
		/datum/overmap/fluff/satellite/abandoned = 10,
		/datum/overmap/fluff/commsat/abandoned = 3,
		/datum/overmap/fluff/sensorsat/abandoned = 3,
		/datum/overmap/fluff/solarmirror/abandoned = 3,
		/datum/overmap/fluff/spacecolony/abandoned = 1
	)


/datum/overmap_star_system/wilderness/lighthouse
	startype = /datum/overmap/star/pulsar
	starname = "Ahktichiki's Lighthouse"
	//You can always see the Lighthouse.
	can_jump_to = TRUE
	event_probabilities = list(
		/datum/overmap/event/emp = 10,
		/datum/overmap/event/rad/minor = 20,
		/datum/overmap/event/rad = 40,
		/datum/overmap/event/rad/major = 5,
		/datum/overmap/event/electric/minor = 20,
		/datum/overmap/event/electric = 40,
		/datum/overmap/event/electric/major = 35,
	)
	entry_quotes = list(
		"..a brilliant light in the heavens..",
		"..it'll guide every spacer..",
		"..watch the beams..",
		"..you'll always guide us home..",
	)

	fluff_amount = 1
	fluff_probabilities = list(
		/datum/overmap/fluff/observatory/grumpy = 1,
		/datum/overmap/fluff/commsat/abandoned = 1
	)
	unique_system = TRUE

/datum/overmap_star_system/wilderness/supergiant
	startype = /datum/overmap/star/giant
	dynamic_probabilities = list(
		DYNAMIC_WORLD_LAVA = 40,
		DYNAMIC_WORLD_ICE = 15,
		DYNAMIC_WORLD_SAND = 15,
		DYNAMIC_WORLD_JUNGLE = 25,
		DYNAMIC_WORLD_ROCKPLANET = 15,
		DYNAMIC_WORLD_BEACHPLANET = 20,
		DYNAMIC_WORLD_WASTEPLANET = 40,
		DYNAMIC_WORLD_SPACERUIN = 30,
		DYNAMIC_WORLD_MOON = 20
	)
	event_probabilities = list(
		/datum/overmap/event/nebula = 60,
		/datum/overmap/event/flare/minor = 20,
		/datum/overmap/event/flare = 40,
		/datum/overmap/event/flare/major = 5,
		/datum/overmap/event/electric/minor = 20,
		/datum/overmap/event/electric = 40,
		/datum/overmap/event/electric/major = 35,
	)
	entry_quotes = list(
		"..you're gonna burn alright..",
		"..intensity beyond reason..",
		"..always burning bright..",
		"..flames that lash and sear..",
	)

	fluff_amount = 1

	fluff_probabilities = list(
		/datum/overmap/fluff/observatory/grumpy = 1,
	)

/datum/overmap_star_system/wilderness/frozen
	startype = /datum/overmap/star/dwarf/white
	dynamic_probabilities = list(
		DYNAMIC_WORLD_LAVA = 5,
		DYNAMIC_WORLD_ICE = 40,
		DYNAMIC_WORLD_SAND = 30,
		DYNAMIC_WORLD_JUNGLE = 15,
		DYNAMIC_WORLD_ROCKPLANET = 30,
		DYNAMIC_WORLD_BEACHPLANET = 5,
		DYNAMIC_WORLD_WASTEPLANET = 15,
		DYNAMIC_WORLD_SPACERUIN = 15,
		DYNAMIC_WORLD_MOON = 15
	)

	event_probabilities = list(
		//ice field
		/datum/overmap/event/wormhole = 5,
		/datum/overmap/event/nebula = 60,
		/datum/overmap/event/meteor/minor = 45,
		/datum/overmap/event/meteor = 40,
		/datum/overmap/event/meteor/carp/minor = 45,
		/datum/overmap/event/meteor/dust = 50,
		/datum/overmap/event/anomaly = 10
	)
	entry_quotes = list(
		"..specks of ice in the stars..",
		"..something shimmering in the distance..",
		"..cold down to the bones..",
		"..peace only broken by tension..",
	)

	fluff_amount = 1
	fluff_probabilities = list(
		/datum/overmap/fluff/commsat/abandoned = 1,
	)

//for laughs
/datum/overmap_star_system/oldcolors
	override_object_colors = TRUE

/datum/overmap_star_system/oldgen //wouldnt it be funny to have this generate sometimes just for shits and giggles
	generator_type = OVERMAP_GENERATOR_RANDOM
