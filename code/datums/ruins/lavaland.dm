// Hey! Listen! Update \config\lavaruinblacklist.txt with your new ruins!

/datum/map_template/ruin/lavaland
	prefix = "_maps/RandomRuins/LavaRuins/"
	ruin_type = RUINTYPE_LAVA

/datum/map_template/ruin/lavaland/biodome
	cost = 5
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/biodome/beach
	name = "Biodome Beach"
	id = "biodome-beach"
	description = "Seemingly plucked from a tropical destination, this beach is calm and cool, with the salty waves roaring softly in the background. \
	Comes with a rustic wooden bar and suicidal bartender."
	suffix = "lavaland_biodome_beach.dmm"

/datum/map_template/ruin/lavaland/biodome/winter
	name = "Biodome Winter"
	id = "biodome-winter"
	description = "For those getaways where you want to get back to nature, but you don't want to leave the fortified military compound where you spend your days. \
	Includes a unique(*) laser pistol display case, and the recently introduced I.C.E(tm)."
	suffix = "lavaland_surface_biodome_winter.dmm"

/datum/map_template/ruin/lavaland/syndicate_base
	name = "Syndicate Lava Base"
	id = "lava-base"
	description = "A secret base researching illegal bioweapons, it is closely guarded by an elite team of syndicate agents."
	suffix = "lavaland_surface_syndicate_base1.dmm"
	cost = 20
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/free_golem
	name = "Free Golem Ship"
	id = "golem-ship"
	description = "Lumbering humanoids, made out of precious metals, move inside this ship. They frequently leave to mine more minerals, which they somehow turn into more of them. \
	Seem very intent on research and individual liberty, and also geology-based naming?"
	cost = 20
	suffix = "lavaland_surface_golem_ship.dmm"
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/sin
	cost = 10
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/sin/sloth
	name = "Ruin of Sloth"
	id = "sloth"
	description = "..."
	suffix = "lavaland_surface_sloth.dmm"
	// Generates nothing but atmos runtimes and salt
	cost = 0

/datum/map_template/ruin/lavaland/hierophant
	name = "Hierophant's Arena"
	id = "hierophant"
	description = "A strange, square chunk of metal of massive size. Inside awaits only death and many, many squares."
	suffix = "lavaland_surface_hierophant.dmm"
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/xeno_nest
	name = "Xenomorph Nest"
	id = "xeno-nest"
	description = "These xenomorphs got bored of horrifically slaughtering people on space stations, and have settled down on a nice lava-filled hellscape to focus on what's really important in life. \
	Quality memes."
	suffix = "lavaland_surface_xeno_nest.dmm"
	cost = 20

/datum/map_template/ruin/lavaland/survivalcapsule
	name = "Survival Capsule Ruins"
	id = "survivalcapsule"
	description = "What was once sanctuary to the common miner, is now their tomb."
	suffix = "lavaland_surface_survivalpod.dmm"
	cost = 5

/datum/map_template/ruin/lavaland/pizza
	name = "Ruined Pizza Party"
	id = "pizza"
	description = "Little Timmy's birthday pizza bash took a turn for the worse when a bluespace anomaly passed by."
	suffix = "lavaland_surface_pizzaparty.dmm"
	allow_duplicates = FALSE
	cost = 5

/datum/map_template/ruin/lavaland/cultaltar
	name = "Summoning Ritual"
	id = "cultaltar"
	description = "A place of vile worship, the scrawling of blood in the middle glowing eerily. A demonic laugh echoes throughout the caverns."
	suffix = "lavaland_surface_cultaltar.dmm"
	allow_duplicates = FALSE
	cost = 10

/datum/map_template/ruin/lavaland/hermit
	name = "Makeshift Shelter"
	id = "hermitcave"
	description = "A place of shelter for a lone hermit, scraping by to live another day."
	suffix = "lavaland_surface_hermit.dmm"
	allow_duplicates = FALSE
	cost = 10

/datum/map_template/ruin/lavaland/miningripley
	name = "Ripley"
	id = "ripley"
	description = "A heavily-damaged mining ripley, property of a very unfortunate miner. You might have to do a bit of work to fix this thing up."
	suffix = "lavaland_surface_random_ripley.dmm"
	allow_duplicates = FALSE
	cost = 5

/datum/map_template/ruin/lavaland/elephant_graveyard
	name = "Elephant Graveyard"
	id = "Graveyard"
	description = "An abandoned graveyard, calling to those unable to continue."
	suffix = "lavaland_surface_elephant_graveyard.dmm"
	allow_duplicates = FALSE
	cost = 10

/datum/map_template/ruin/lavaland/comm_outpost
	name = "Syndicate Comm Outpost"
	id = "commoutpost"
	description = "A forgotten outpost home to only a tragic tale."
	suffix = "lavaland_surface_comm_outpost.dmm"
	allow_duplicates = FALSE
	cost = 5

/datum/map_template/ruin/lavaland/dwarffortress
	name = "Legion infested Dwarf Fortress"
	id = "dwarffortress"
	description = "A forgotten fortress home to only a tragic tale and infested corpses."
	suffix = "lavaland_surface_dwarffortress.dmm"
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/ashwalker_shrine
	name = "Ashwalker shrine"
	id = "ashwalker_shrine"
	description = "A destroyed ashwalker village. What even happened here?"
	suffix = "lavaland_surface_ashwalker_shrine.dmm"

/datum/map_template/ruin/lavaland/fuckedupandevilclub
	name = "Evil Club"
	id = "evil_club"
	description = "A truly fucked up and evil club."
	suffix = "lavaland_surface_fuckedupandevilclub.dmm"

/datum/map_template/ruin/lavaland/spookycrash
	name = "Spooky Crash"
	id = "spooky_crash"
	description = "A spooky looking crash."
	suffix = "lavaland_surface_SPOOKYCRASH.dmm"

/datum/map_template/ruin/lavaland/crashedpinnance
	name = "Crashed Research Pinnance"
	id = "crashed_pinnance"
	description = "A crashed shuttlecraft, looks like the pilot didn't make it."
	suffix = "lavaland_surface_crashed_pinnance.dmm"

/datum/map_template/ruin/lavaland/codelab
	name = "Nanotrasen Genetic Research Facility"
	id = "codelab"
	description = "A Nanotrasen genetic research facility, abandoned and ripe for looting. Whats that goo over there?"
	suffix = "lavaland_surface_codelab.dmm"
