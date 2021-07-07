// Hey! Listen! Update \config\jungleruinblacklist.txt with your new ruins!

/datum/map_template/ruin/jungle
	prefix = "_maps/RandomRuins/JungleRuins/"

/datum/map_template/ruin/jungle/solgov_crash
	name = "Abandoned SolGov Exploration Pod"
	id = "jungle-solgov-explorer"
	description = "A recently abandoned standard SolGov exploration pod. It may not be powerful or resilient, but it can fly in a pinch."
	suffix = "jungle_surface_abandonedsolgov.dmm"

/datum/map_template/ruin/jungle/solgov_crash
	name = "Enlightenment"
	id = "jungle-monkies"
	description = "Ook. Ooh Ooh Aah. AAH. OOK OOK OOK. OOK OOK AAH AAAH AAAAAAAAAAAAAAAH!"
	suffix = "jungle_surface_monkies.dmm"

/datum/map_template/ruin/jungle/ai_ikea
	name = "Space Ikea AI Shipment"
	id = "ikea-ai"
	description = "A Space Ikea Brand AI Core and Necessities Crate, it seems to have missed its intended target."
	suffix = "jungle_surface_ikea_ai.dmm"

///how bad can i possibly be?
/datum/map_template/ruin/jungle/onceler
	name = "Thneed Factory"
	id = "tumblr-sexyman"
	description = "After a logging incident gone wrong, the Syndicate invade this factory to stop the beast."
	suffix = "jungle_surface_tumblr_sexyman.dmm"

//putting this area here until i make jungle areas.dm in another PR that i am totally making
/area/ruin/jungle/onceler/main
	requires_power = FALSE
	name = "Thneed Factory"
	icon_state = "engine"

//thneedville end

//industrial society blah blah blah
/datum/map_template/ruin/jungle/unabomber
	name = "Bombmaker's Cabin"
	id = "unabomber-cabin"
	description = "The Industrial Revolution and its consequences have been a disaster for the human race."
	suffix = "jungle_surface_unabomber_cabin.dmm"
	
//Arachnid Funky Cave
/datum/map_template/ruin/jungle/bigspidercave
	name = "Megaaracnid Cave"
	id = "bigspider-cave"
	description = "A cave full of giant alien spiders, it seems a syndicate expedition met a poor fate here first."
	suffix = "jungle_arachnid_cave.dmm"
	
//The Hall of the Skeleton King
/datum/map_template/ruin/jungle/skeletonhall
	name = "Hall of the Skeleton King"
	id = "skele-hall"
	description = "No cost too great."
	suffix = "jungle_challenge.dmm"
	
//Tribe of the Sun God
/datum/map_template/ruin/jungle/suntribe
	name= "Tribe of the Sun God"
	id = "suntribe"
	description = "A small village overun with the rampant followers of the sun god."
	suffix = "jungle_encampment.dmm"	
