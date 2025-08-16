// Hey! Listen! Update _maps\map_catalogue.txt with your new ruins!

/datum/map_template/ruin/jungle
	prefix = "_maps/RandomRuins/JungleRuins/"
	ruin_type = RUINTYPE_JUNGLE

/datum/map_template/ruin/jungle/syndicate
	name = "Jungle Syndicate Bunker"
	id = "syndicatebunkerjungle"
	description = "A small bunker owned by the Syndicate."
	suffix = "jungle_syndicate.dmm"
	ruin_tags = list(RUIN_TAG_MEDIUM_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_LIVEABLE)
	ruin_mission_types = list(
		/datum/mission/ruin/nt_files,
		/datum/mission/ruin/signaled/kill/jerry
	)

/datum/mission/ruin/nt_files
	name = "Discrete Asset Recovery"
	desc = "Look- long story short, I need this folder retrieved. You don't ask why, I make sure you get paid."
	value = 1500
	mission_limit = 1
	mission_reward = list(
		/obj/item/gun/energy/laser/retro,
	)
	faction = /datum/faction/nt
	setpiece_item = /obj/item/documents/nanotrasen

/datum/mission/ruin/nt_files/generate_mission_details()
	. = ..()
	author = "Captain [random_species_name()]"

/datum/mission/ruin/signaled/kill/jerry
	name = "Re: Jerry"
	desc = "THIS MOTHERFUCKING WEASEL BOY TOOK MY LIMITED EDITION RILENA PLUSH. THAT THING WAS FUCKING EXPENSIVE. I WANT IT BACK. I WANT HIM BLOWN UP. I WANT YOU TO DO IT."
	author = "SHOOT HIM IN THE DICK"
	mission_limit = 1
	faction = /datum/faction/independent
	mission_reward = /obj/item/poster/random_rilena
	registered_type = /mob/living/simple_animal/hostile/human/ramzi
	value = 750
	setpiece_item = list(
		/obj/item/toy/plush/rilena,
		/obj/item/toy/plush/tali,
		/obj/item/toy/plush/sharai,
		/obj/item/toy/plush/xader,
		/obj/item/toy/plush/mora,
		/obj/item/toy/plush/kari
	)


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
	name = "Abandoned Airbase"
	id = "airbase"
	description = "An abandoned airbase dating back to the ICW, partially scuttled, and moved right back into by the Ramzi Clique."
	suffix = "jungle_bombed_starport.dmm"
	ruin_tags = list(RUIN_TAG_HARD_COMBAT, RUIN_TAG_MAJOR_LOOT, RUIN_TAG_HAZARDOUS, RUIN_TAG_LIVEABLE)
/*	ruin_mission_types = list(
		/datum/mission/ruin/signaled/kill/ramzi/airbase,
		/datum/mission/ruin/icw_documents
	)
*/

/datum/mission/ruin/signaled/kill/ramzi/airbase
	mission_limit = 1
	registered_type = /mob/living/simple_animal/hostile/human/ramzi/ranged/space/shotgun/incendiary

/datum/mission/ruin/icw_documents
	name = "Syndicate Battleplans Retrieval"
	desc = "Our Final Project for the ICW-Era Preservation is to find a new piece of ICW history and preserve it. My group has gotten word that Syndicate Battleplans can be found at this site. Please see if they're there, and retrieve them for us."
	faction = /datum/faction/syndicate/suns
	author = "HIS455 \"ICW-era Preservation\""
	mission_limit = 1
	setpiece_item = /obj/item/folder/documents/syndicate/red
	value = 1500

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
	ruin_mission_types = list(
		/datum/mission/ruin/signaled/kill/frontiersmen,
		/datum/mission/ruin/data_retrieval
	)
