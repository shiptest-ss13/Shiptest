// Hey! Listen! Update \config\iceruinblacklist.txt with your new ruins!

/datum/map_template/ruin/icemoon
	prefix = "_maps/RandomRuins/IceRuins/"
	allow_duplicates = FALSE
	cost = 5

// above ground only

/datum/map_template/ruin/icemoon/lust
	name = "Ruin of Lust"
	id = "lust"
	description = "Not exactly what you expected."
	suffix = "icemoon_surface_lust.dmm"

/datum/map_template/ruin/icemoon/asteroid
	name = "Asteroid Site"
	id = "asteroidsite"
	description = "Surprised to see us here?"
	suffix = "icemoon_surface_asteroid.dmm"

/datum/map_template/ruin/icemoon/hotsprings
	name = "Hot Springs"
	id = "hotsprings"
	description = "Just relax and take a dip, nothing will go wrong, I swear!"
	suffix = "icemoon_surface_hotsprings.dmm"

/datum/map_template/ruin/icemoon/engioutpost
	name = "Engineer Outpost"
	id = "engioutpost"
	description = "Blown up by an unfortunate accident."
	suffix = "icemoon_surface_engioutpost.dmm"

/datum/map_template/ruin/icemoon/fountain
	name = "Fountain Hall"
	id = "fountain"
	description = "The fountain has a warning on the side. DANGER: May have undeclared side effects that only become obvious when implemented."
	prefix = "_maps/RandomRuins/AnywhereRuins/"
	suffix = "fountain_hall.dmm"

/datum/map_template/ruin/icemoon/slimerancher //Shiptest edit
	name = "Slime Ranch"
	id = "slimerancher"
	description = "Slime ranchin with the bud."
	suffix = "icemoon_surface_slimerancher.dmm"

// above and below ground together

/datum/map_template/ruin/icemoon/mining_site
	name = "Mining Site"
	id = "miningsite"
	description = "Ruins of a site where people once mined with primitive tools for ore."
	suffix = "icemoon_surface_mining_site.dmm"
	always_place = TRUE
// below ground only

/datum/map_template/ruin/icemoon
	name = "underground ruin"

/datum/map_template/ruin/icemoon/abandonedvillage
	name = "Abandoned Village"
	id = "abandonedvillage"
	description = "Who knows what lies within?"
	suffix = "icemoon_underground_abandoned_village.dmm"

/datum/map_template/ruin/icemoon/library
	name = "Buried Library"
	id = "buriedlibrary"
	description = "A once grand library, now lost to the confines of the Ice Moon."
	suffix = "icemoon_underground_library.dmm"

/datum/map_template/ruin/icemoon/wrath
	name = "Ruin of Wrath"
	id = "wrath"
	description = "You'll fight and fight and just keep fighting."
	suffix = "icemoon_underground_wrath.dmm"

/datum/map_template/ruin/icemoon/hermit
	name = "Frozen Shack"
	id = "hermitshack"
	description = "A place of shelter for a lone hermit, scraping by to live another day."
	suffix = "icemoon_underground_hermit.dmm"

/datum/map_template/ruin/icemoon/lavaland
	name = "Lavaland Site"
	id = "lavalandsite"
	description = "I guess we never really left you huh?"
	suffix = "icemoon_underground_lavaland.dmm"

/datum/map_template/ruin/icemoon/puzzle
	name = "Ancient Puzzle"
	id = "puzzle"
	description = "Mystery to be solved."
	suffix = "icemoon_underground_puzzle.dmm"

/datum/map_template/ruin/icemoon/bathhouse
	name = "Bath House"
	id = "bathhouse"
	description = "A warm, safe place."
	suffix = "icemoon_underground_bathhouse.dmm"

/datum/map_template/ruin/icemoon/wendigo_cave
	name = "Wendigo Cave"
	id = "wendigocave"
	description = "Into the jaws of the beast."
	suffix = "icemoon_underground_wendigo_cave.dmm"

/datum/map_template/ruin/icemoon/free_golem
	name = "Free Golem Ship"
	id = "golem-ship"
	description = "Lumbering humanoids, made out of precious metals, move inside this ship. They frequently leave to mine more minerals, which they somehow turn into more of them. \
	Seem very intent on research and individual liberty, and also geology-based naming?"
	prefix = "_maps/RandomRuins/AnywhereRuins/"
	suffix = "golem_ship.dmm"

