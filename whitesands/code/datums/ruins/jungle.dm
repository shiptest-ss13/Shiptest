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

/datum/map_template/ruin/jungle/outpost
	name = "Nanotrasen Core Mining Outpost"
	id = "jungle-outpost"
	description = "A quickly made, skeleton crewed outpost to harvest the deepcore materials of this planet, although the local wildlife does not take nicely to this rapid industrialization."
	suffix = "jungle_outpost.dmm"
