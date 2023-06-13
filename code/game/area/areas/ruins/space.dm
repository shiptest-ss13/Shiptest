//Space Ruin Parents

/area/ruin/space
	has_gravity = FALSE
	area_flags = NONE

/area/ruin/space/has_grav
	has_gravity = STANDARD_GRAVITY

/area/ruin/space/has_grav/powered
	requires_power = FALSE

/////////////

/area/ruin/space/way_home
	name = "\improper Salvation"
	icon_state = "away"
	always_unpowered = FALSE

// Onehalf Ruin

/area/ruin/space/has_grav/onehalf
	name = "Station Fragment"
	icon_state = "away"

//Dinner For Two

/area/ruin/space/has_grav/powered/dinner_for_two
	name = "Dinner for Two"

//Aesthetic

/area/ruin/space/has_grav/powered/aesthetic
	name = "Aesthetic"
	ambientsounds = list('sound/ambience/ambivapor1.ogg')

//Ruin of Derelict Oupost

/area/ruin/space/has_grav/derelictoutpost
	name = "Derelict Outpost"
	icon_state = "green"

/area/ruin/space/has_grav/derelictoutpost/cargostorage
	name = "Derelict Outpost Cargo Storage"
	icon_state = "storage"

/area/ruin/space/has_grav/derelictoutpost/cargobay
	name = "Derelict Outpost Cargo Bay"
	icon_state = "quartstorage"

/area/ruin/space/has_grav/derelictoutpost/powerstorage
	name = "Derelict Outpost Power Storage"
	icon_state = "engine_smes"

/area/ruin/space/has_grav/derelictoutpost/dockedship
	name = "Derelict Outpost Docked Ship"
	icon_state = "red"

//Ruin of mech transport

/area/ruin/space/has_grav/powered/mechtransport
	name = "Mech Transport"
	icon_state = "green"


//Ruin of gas the lizard

/area/ruin/space/has_grav/gasthelizard
	name = "Gas the lizard"


//Ruin of Deep Storage

/area/ruin/space/has_grav/deepstorage
	name = "Deep Storage"
	icon_state = "storage"

/area/ruin/space/has_grav/deepstorage/airlock
	name = "Deep Storage Airlock"
	icon_state = "quart"

/area/ruin/space/has_grav/deepstorage/power
	name = "Deep Storage Power and Atmospherics Room"
	icon_state = "engi_storage"

/area/ruin/space/has_grav/deepstorage/hydroponics
	name = "Deep Storage Hydroponics"
	icon_state = "garden"

/area/ruin/space/has_grav/deepstorage/armory
	name = "Deep Storage Secure Storage"
	icon_state = "armory"

/area/ruin/space/has_grav/deepstorage/storage
	name = "Deep Storage Storage"
	icon_state = "storage_wing"

/area/ruin/space/has_grav/deepstorage/dorm
	name = "Deep Storage Dormitory"
	icon_state = "crew_quarters"

/area/ruin/space/has_grav/deepstorage/kitchen
	name = "Deep Storage Kitchen"
	icon_state = "kitchen"

/area/ruin/space/has_grav/deepstorage/crusher
	name = "Deep Storage Recycler"
	icon_state = "storage"


//Ruin of ancient Space Station

/area/ruin/space/has_grav/ancientstation
	name = "Charlie Station Main Corridor"
	icon_state = "green"

/area/ruin/space/has_grav/ancientstation/powered
	name = "Powered Tile"
	icon_state = "teleporter"
	requires_power = FALSE

/area/ruin/space/has_grav/ancientstation/space
	name = "Exposed To Space"
	icon_state = "teleporter"
	has_gravity = FALSE

/area/ruin/space/has_grav/ancientstation/atmo
	name = "Beta Station Atmospherics"
	icon_state = "red"
	ambientsounds = ENGINEERING
	has_gravity = TRUE

/area/ruin/space/has_grav/ancientstation/betacorridor
	name = "Beta Station Main Corridor"
	icon_state = "bluenew"

/area/ruin/space/has_grav/ancientstation/engi
	name = "Charlie Station Engineering"
	icon_state = "engine"
	ambientsounds = ENGINEERING

/area/ruin/space/has_grav/ancientstation/comm
	name = "Charlie Station Command"
	icon_state = "captain"

/area/ruin/space/has_grav/ancientstation/hydroponics
	name = "Charlie Station Hydroponics"
	icon_state = "garden"

/area/ruin/space/has_grav/ancientstation/kitchen
	name = "Charlie Station Kitchen"
	icon_state = "kitchen"

/area/ruin/space/has_grav/ancientstation/sec
	name = "Charlie Station Security"
	icon_state = "red"

/area/ruin/space/has_grav/ancientstation/deltacorridor
	name = "Delta Station Main Corridor"
	icon_state = "green"

/area/ruin/space/has_grav/ancientstation/proto
	name = "Delta Station Prototype Lab"
	icon_state = "toxlab"

/area/ruin/space/has_grav/ancientstation/rnd
	name = "Delta Station Research and Development"
	icon_state = "toxlab"

/area/ruin/space/has_grav/ancientstation/deltaai
	name = "Delta Station AI Core"
	icon_state = "ai"
	ambientsounds = list('sound/ambience/ambimalf.ogg', 'sound/ambience/ambitech.ogg', 'sound/ambience/ambitech2.ogg', 'sound/ambience/ambiatmos.ogg', 'sound/ambience/ambiatmos2.ogg')

/area/ruin/space/has_grav/ancientstation/mining
	name = "Beta Station Mining Equipment"
	icon_state = "mining"

/area/ruin/space/has_grav/ancientstation/medbay
	name = "Beta Station Medbay"
	icon_state = "medbay"

/area/ruin/space/has_grav/ancientstation/betastorage
	name = "Beta Station Storage"
	icon_state = "storage"

/area/solar/ancientstation
	name = "Charlie Station Solar Array"
	icon_state = "panelsP"

//DERELICT

/area/ruin/space/derelict
	name = "Derelict Station"
	icon_state = "storage"

/area/ruin/space/derelict/hallway/primary
	name = "Derelict Primary Hallway"
	icon_state = "hallP"

/area/ruin/space/derelict/hallway/secondary
	name = "Derelict Secondary Hallway"
	icon_state = "hallS"

/area/ruin/space/derelict/hallway/primary/port
	name = "Derelict Port Hallway"
	icon_state = "hallFP"

/area/ruin/space/derelict/arrival
	name = "Derelict Arrival Centre"
	icon_state = "yellow"

/area/ruin/space/derelict/storage/equipment
	name = "Derelict Equipment Storage"

/area/ruin/space/derelict/bridge
	name = "Derelict Control Room"
	icon_state = "bridge"

/area/ruin/space/derelict/bridge/access
	name = "Derelict Control Room Access"
	icon_state = "auxstorage"

/area/ruin/space/derelict/bridge/ai_upload
	name = "Derelict Computer Core"
	icon_state = "ai"

/area/ruin/space/derelict/solar_control
	name = "Derelict Solar Control"
	icon_state = "engine"

/area/ruin/space/derelict/se_solar
	name = "South East Solars"
	icon_state = "engine"

/area/ruin/space/derelict/medical
	name = "Derelict Medbay"
	icon_state = "medbay"

/area/ruin/space/derelict/medical/chapel
	name = "Derelict Chapel"
	icon_state = "chapel"

/area/solar/derelict_starboard
	name = "Derelict Starboard Solar Array"
	icon_state = "panelsS"

/area/solar/derelict_aft
	name = "Derelict Aft Solar Array"
	icon_state = "yellow"

/area/ruin/space/derelict/singularity_engine
	name = "Derelict Singularity Engine"
	icon_state = "engine"

/area/ruin/space/derelict/gravity_generator
	name = "Derelict Gravity Generator Room"
	icon_state = "red"

/area/ruin/space/derelict/atmospherics
	name = "Derelict Atmospherics"
	icon_state = "red"

//DJSTATION

/area/ruin/space/djstation
	name = "Ruskie DJ Station"
	icon_state = "DJ"
	has_gravity = STANDARD_GRAVITY

/area/ruin/space/djstation/solars
	name = "DJ Station Solars"
	icon_state = "DJ"
	has_gravity = STANDARD_GRAVITY

//OLD AI SAT

/area/tcommsat/oldaisat
	name = "Abandoned Satellite"
	icon_state = "tcomsatcham"

//ABANDONED BOX WHITESHIP

/area/ruin/space/has_grav/whiteship/box

	name = "Abandoned Ship"
	icon_state = "red"


//SYNDICATE LISTENING POST STATION

/area/ruin/space/has_grav/listeningstation
	name = "Listening Post"
	icon_state = "yellow"

/area/ruin/space/has_grav/powered/ancient_shuttle
	name = "Ancient Shuttle"
	icon_state = "yellow"

//HELL'S FACTORY OPERATING FACILITY

/area/ruin/space/has_grav/hellfactory
	name = "Hell Factory"
	icon_state = "yellow"

/area/ruin/space/has_grav/hellfactoryoffice
	name = "Hell Factory Office"
	icon_state = "red"
	area_flags = VALID_TERRITORY | BLOBS_ALLOWED | NOTELEPORT

//Ruin of Transport 18

/area/ruin/space/has_grav/transport18fore
	name = "Booze Cruise Fore"
	icon_state = "crew_quarters"

/area/ruin/space/has_grav/transport18mid
	name = "Booze Cruise Hold"
	icon_state = "cargo_bay"

/area/ruin/space/transport18aft
	name = "Booze Cruise Aft"
	icon_state = "engine"

//Ruin of the rad ship. It's pretty rad.

/area/ruin/space/has_grav/radship/Cargo1
	name = "Cargo Bay 1"
	icon_state = "cargo_bay"

/area/ruin/space/has_grav/radship/Cargo2
	name = "Cargo Bay 2"
	icon_state = "cargo_bay"

/area/ruin/space/has_grav/radship/Cargo3
	name = "Cargo Bay 3"
	icon_state = "cargo_bay"

/area/ruin/space/has_grav/radship/Cargo4
	name = "Cargo Bay 4"
	icon_state = "cargo_bay"

/area/ruin/space/has_grav/radship/EngineRoom
	name = "Engine Room"
	icon_state = "yellow"

/area/ruin/space/has_grav/radship/Engineering
	name = "Engineering"
	icon_state = "engine"

/area/ruin/space/has_grav/radship/MethLab
	name = "Storage"
	icon_state = "red"

/area/ruin/space/has_grav/radship/CrewQuarters
	name = "Crew Quarters"
	icon_state = "green"

/area/ruin/space/has_grav/radship/Hallway
	name = "Hallway"
	icon_state = "away"

//MACSPACE

/area/ruin/space/has_grav/powered/macspace
	name = "Mac Space Restaurant"
	icon_state = "yellow"

//NUCLEAR DUMP -- this ruin uses an area from power puzzle, for whatever reason. added new areas, for now.

/area/ruin/space/has_grav/nucleardump
	name = "Hallway"
	icon_state = "hallC"

/area/ruin/space/has_grav/nucleardump/supermatter
	name = "Supermatter Chamber"
	icon_state = "red"

//POWER PUZZLE

/area/ruin/space/has_grav/powerpuzzle
	name = "Central Storage"
	icon_state = "hallC"

/area/ruin/space/has_grav/powerpuzzle/secure
	name = "Security Wing"
	icon_state = "red"

/area/ruin/space/has_grav/powerpuzzle/engineering
	name = "Engineering Wing"
	icon_state = "yellow"

//Space Gym

/area/ruin/space/has_grav/spacegym
	name = "Space Gym"
	icon_state = "firingrange"

//scav_mining

/area/ruin/space/has_grav/scav_mining/entrance
	name = "Asteroid mine entrance"
	icon_state = "red"

/area/ruin/space/has_grav/scav_mining/core
	name = "Asteroid mine core"
	icon_state = "yellow"

/area/ruin/space/has_grav/scav_mining/dorm
	name = "Asteroid mine dorm"
	icon_state = "blue"

//astraeus

/area/ruin/space/has_grav/astraeus/hallway
	name = "Hallway"
	icon_state = "hallC"

/area/ruin/space/has_grav/astraeus/munitions
	name = "Munitions Bay"
	icon_state = "engine"

/area/ruin/space/has_grav/astraeus/dorms_med
	name = "Conference Room"
	icon_state = "Sleep"

/area/ruin/space/has_grav/astraeus/bridge
	name = "Bridge"
	icon_state = "bridge"

/area/ruin/space/has_grav/astraeus/disposals
	name = "Disposals"
	icon_state = "yellow"

/area/ruin/space/has_grav/astraeus/custodial
	name = "Custodial Closet"
	icon_state = "green"

/area/ruin/space/has_grav/glade
	name = "\improper Dark Glade"
	icon_state = "away"
	always_unpowered = FALSE

//Syndie battle sphere

/area/ruin/space/has_grav/syndicircle/halls
	name = "Syndicate Battle Sphere Primary Hallway"
	icon_state = "dk_yellow"
	color = "#a5131388"

/area/ruin/space/has_grav/syndicircle/spacewalk
	name = "Syndicate Battle Sphere Shuttle Launch Site"
	icon_state = "dk_yellow"
	color = "#663cb488"

/area/ruin/space/has_grav/syndicircle/research
	name = "Syndicate Battle Sphere Laboratory"
	icon_state = "dk_yellow"
	color = "#228a2b88"

/area/ruin/space/has_grav/syndicircle/escape
	name = "Syndicate Battle Sphere Escape Shuttle"
	icon_state = "dk_yellow"
	color = "#92bb3388"

/area/ruin/space/has_grav/syndicircle/winter
	name = "Syndicate Battle Sphere Snow Outpost"
	icon_state = "dk_yellow"
	color = "#4341c488"

/area/ruin/space/has_grav/syndicircle/training
	name = "Syndicate Battle Sphere Training Grounds"
	icon_state = "dk_yellow"
	color = "#26773a88"

//Syndiecate chemlab

/area/ruin/space/has_grav/crazylab/airlock
	name = "Syndicate Laboratory 4071 Airlock"
	icon_state = "dk_yellow"
	color = "#eb7fac88"

/area/ruin/space/has_grav/crazylab/armory
	name = "Syndicate Laboratory 4071 Armory"
	icon_state = "dk_yellow"
	color = "#55384c88"

/area/ruin/space/has_grav/crazylab/hydro
	name = "Syndicate Laboratory 4071 Hydroponics Lab"
	icon_state = "dk_yellow"
	color = "#185d7288"

/area/ruin/space/has_grav/crazylab/bar
	name = "Syndicate Laboratory 4071 Kitchen"
	icon_state = "dk_yellow"
	color = "#75162e88"

/area/ruin/space/has_grav/crazylab/gamble
	name = "Syndicate Laboratory 4071 Break Room"
	icon_state = "dk_yellow"
	color = "#97632088"

/area/ruin/space/has_grav/crazylab/crew
	name = "Syndicate Laboratory 4071 Crew Quarters"
	icon_state = "dk_yellow"
	color = "#74c24f88"

/area/ruin/space/has_grav/crazylab/engi
	name = "Syndicate Laboratory 4071 Engineering"
	icon_state = "dk_yellow"
	color = "#0e1b3f88"

/area/ruin/space/has_grav/crazylab/chem
	name = "Syndicate Laboratory 4071 Chemistry Lab"
	icon_state = "dk_yellow"
	color = "#77265588"

/area/ruin/space/has_grav/crazylab/bomb
	name = "Syndicate Laboratory 4071 Bombing Range"
	icon_state = "dk_yellow"
	color = "#2b267788"

/area/ruin/space/has_grav/crazylab/watchpost
	name = "Syndicate Laboratory 4071 WatchPost"
	icon_state = "dk_yellow"
	color = "#77262688"

/area/ruin/space/has_grav/crazylab/outside
	name = "Syndicate Laboratory 4071 Surrounding Area"
	icon_state = "dk_yellow"
	color = "#26773a88"

//Singularity Lab

/area/ruin/space/has_grav/singularitylab
	name = "Asteroid Halls"
	icon_state = "hallC"

/area/ruin/space/has_grav/singularitylab/reactor
	name = "Singularity Reactor"
	icon_state = "engine"

/area/ruin/space/has_grav/singularitylab/engineering
	name = "Asteroid Engineering"
	icon_state = "blue"

/area/ruin/space/has_grav/singularitylab/lab
	name = "High Energy Applications Research Facility"
	icon_state = "green"

/area/ruin/space/has_grav/singularitylab/cargo
	name = "Asteroid Cargo"
	icon_state = "storage"

/area/ruin/space/has_grav/singularitylab/hangar
	name = "Asteroid Hangar"
	icon_state = "yellow"

/area/ruin/space/has_grav/singularitylab/civvie
	name = "Asteroid Housing"
	icon_state = "Sleep"

//Corporate Mining Ruin

/area/ruin/space/has_grav/corporatemine/crewquarters
	name = "Corporate Mine Crew Quarters"
	icon_state = "purple"

/area/ruin/space/has_grav/corporatemine/bridge
	name = "Corporate Mine Bridge"
	icon_state = "bridge"

/area/ruin/space/has_grav/corporatemine/hall
	name = "Corporate Mine Hall"
	icon_state = "hallC"

//Space Mall

/area/ruin/space/has_grav/spacemall
	name = "Hallway"
	icon_state = "hallC"

/area/ruin/space/has_grav/spacemall/shop
	name = "Space Mall Shop"
	icon_state = "red"

/area/ruin/space/has_grav/spacemall/shop2
	name = "Space Mall Shop"
	icon_state = "bluenew"

/area/ruin/space/has_grav/spacemall/maint
	name = "Space Mall Maintenance"
	icon_state = "yellow"

/area/ruin/space/has_grav/spacemall/dorms
	name = "Space Mall Dorms"
	icon_state = "green"

/area/ruin/space/has_grav/spacemall/shuttle
	name = "Space Mall Supply Shuttle"
	icon_state = "blue"
