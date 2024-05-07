// Hey! Listen! Update _maps\map_catalogue.txt with your new ruins!

/datum/map_template/ruin/jungle
	prefix = "_maps/RandomRuins/JungleRuins/"
	ruin_type = RUINTYPE_JUNGLE

/datum/map_template/ruin/jungle/jungle_botany_ruin
	id = "jungle_botany-ruin"
	suffix = "jungle_botany.dmm"
	name = "Ruined Botany Research Facility"
	description = "A research facility of great botany discoveries. Long since abandoned, willingly or not..."
	ruin_tags = list(RUIN_TAG_MINOR_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_LIVEABLE)

/datum/map_template/ruin/jungle/ai_ikea
	name = "Space Ikea AI Shipment"
	id = "ikea-ai"
	description = "A Space Ikea Brand AI Core and Necessities Crate, it seems to have missed its intended target."
	suffix = "jungle_surface_ikea_ai.dmm"
	ruin_tags = list(RUIN_TAG_NO_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_LIVEABLE)

/datum/map_template/ruin/jungle/coffinpirate
	name = "Coffin-Shaped Pirate Hut"
	id = "coffinpirate"
	description = "An odd coffin shaped pirate hut that the inhabitant of died in."
	suffix = "jungle_surface_coffinpirate.dmm"

//far more tasteful than its predecessor...
/datum/map_template/ruin/jungle/lessonintrickery
	name = "Bombmaker's Cabin"
	id = "bombmakers-cabin"
	description = "Playing with bombs again, are we?"
	suffix = "jungle_surface_bombmakers_cabin.dmm"
	ruin_tags = list(RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_MAJOR_LOOT, RUIN_TAG_LIVEABLE, RUIN_TAG_ANTAG_GEAR)

/datum/map_template/ruin/jungle/weedshack
	name = "Stoner's Cabin"
	id = "weed-shack"
	description = "The Industrial Revolution and its consequences have been a disaster for the human race."
	suffix = "jungle_surface_weed_shack.dmm"
	ruin_tags = list(RUIN_TAG_NO_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_LIVEABLE)

//vae's jungle ruins from bungalowstation
/datum/map_template/ruin/jungle/pizzawave
	name = "Jungle Pizzawave"
	id = "pizzawave"
	description = "Get some pizza my dude."
	suffix = "jungle_pizzawave.dmm"
	ruin_tags = list(RUIN_TAG_NO_COMBAT, RUIN_TAG_MINOR_LOOT, RUIN_TAG_LIVEABLE)

/datum/map_template/ruin/jungle/nest
	name = "Jungle Xenonest"
	id = "xenonestjungle"
	description = "A Xeno nest crammed into the Jungle."
	suffix = "jungle_nest.dmm"
	ruin_tags = list(RUIN_TAG_BOSS_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_LIVEABLE)

/datum/map_template/ruin/jungle/seedling
	name = "Seedling ruin"
	id = "seedling"
	description = "A rare seedling plant."
	suffix = "jungle_seedling.dmm"
	ruin_tags = list(RUIN_TAG_MEDIUM_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_LIVEABLE)

/datum/map_template/ruin/jungle/hangar
	name = "Abandoned Hangar"
	id = "hangar"
	description = "An abandoned hangar containing exosuits."
	suffix = "jungle_hangar.dmm"

/datum/map_template/ruin/jungle/pirate
	name = "Jungle Pirates"
	id = "piratejungle"
	description = "A group of pirates on a small ship in the jungle."
	suffix = "jungle_pirate.dmm"
	ruin_tags = list(RUIN_TAG_BOSS_COMBAT, RUIN_TAG_MAJOR_LOOT, RUIN_TAG_LIVEABLE, RUIN_TAG_ANTAG_GEAR)

/datum/map_template/ruin/jungle/syndicate
	name = "Jungle Syndicate Bunker"
	id = "syndicatebunkerjungle"
	description = "A small bunker owned by the Syndicate."
	suffix = "jungle_syndicate.dmm"
	ruin_tags = list(RUIN_TAG_MEDIUM_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_LIVEABLE, RUIN_TAG_ANTAG_GEAR)

/datum/map_template/ruin/jungle/village
	name = "Monkey Village"
	id = "monkeyvillage"
	description = "A small village of monkeys."
	suffix = "jungle_village.dmm"
	ruin_tags = list(RUIN_TAG_NO_COMBAT, RUIN_TAG_MINOR_LOOT, RUIN_TAG_LIVEABLE)

/datum/map_template/ruin/jungle/roommates
	name = "Roommates"
	id = "roommates"
	description = "A shack once inhabited by a clown and a mime... and they were roommates."
	suffix = "jungle_surface_roommates.dmm"
	ruin_tags = list(RUIN_TAG_NO_COMBAT, RUIN_TAG_MINOR_LOOT, RUIN_TAG_LIVEABLE)

/datum/map_template/ruin/jungle/ninjashrine
	name = "Ninja Shrine"
	id = "ninjashrine"
	description = "A ninja shrine."
	suffix = "jungle_surface_ninjashrine.dmm"
	ruin_tags = list(RUIN_TAG_BOSS_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_LIVEABLE, RUIN_TAG_ANTAG_GEAR)

/datum/map_template/ruin/jungle/interceptor
	name = "Old Crashed Interceptor"
	id = "crashedcondor"
	description = "An overgrown crashed Condor Class, a forgotten remnant of the Corporate Wars."
	suffix = "jungle_interceptor.dmm"
	ruin_tags = list(RUIN_TAG_NO_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_LIVEABLE)

/datum/map_template/ruin/jungle/paradise
	name = "Hidden paradise"
	id = "paradise"
	description = "a crashed shuttle, and a hidden beautiful lake."
	suffix = "jungle_paradise.dmm"
	ruin_tags = list(RUIN_TAG_MEDIUM_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_LIVEABLE, RUIN_TAG_HAZARDOUS)

/datum/map_template/ruin/jungle/airbase
	name = "Bombed Airbase"
	id = "airbase"
	description = "A bombed out airbase from the ICW, taken back over by nature"
	suffix = "jungle_bombed_starport.dmm"
	ruin_tags = list(RUIN_TAG_MEDIUM_COMBAT, RUIN_TAG_MAJOR_LOOT, RUIN_TAG_HAZARDOUS, RUIN_TAG_LIVEABLE)

/datum/map_template/ruin/jungle/medtech
	name = "MedTech facility"
	id = "medtech-facility"
	description = "A MedTech pharmaceutical manufacturing plant where something went terribly wrong."
	suffix = "jungle_medtech_outbreak.dmm"
	ruin_tags = list(RUIN_TAG_MEDIUM_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_LIVEABLE)

/datum/map_template/ruin/jungle/cavecrew
	name = "Frontiersmen Cave"
	id = "cavecrew"
	description = "A frontiersmen base, hidden within a cave. They don't seem friendly"
	suffix = "jungle_cavecrew.dmm"
	ruin_tags = list(RUIN_TAG_MEDIUM_COMBAT, RUIN_TAG_HAZARDOUS, RUIN_TAG_LIVEABLE, RUIN_TAG_MAJOR_LOOT)

/datum/map_template/ruin/jungle/library
	name = "Abandoned Library"
	id = "abandoned-library"
	description = "A forgotten library, with a few angry monkeys."
	suffix = "jungle_abandoned_library.dmm"
	ruin_tags = list(RUIN_TAG_MEDIUM_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_ANTAG_GEAR, RUIN_TAG_NECROPOLIS_LOOT, RUIN_TAG_LIVEABLE)
