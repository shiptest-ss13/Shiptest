//Space Ruin Parents

/area/ruin/space
	has_gravity = FALSE
	area_flags = NONE

/area/ruin/space/has_grav
	has_gravity = STANDARD_GRAVITY

/area/ruin/space/has_grav/powered
	requires_power = FALSE

/////////////
// Onehalf Ruin

/area/ruin/space/has_grav/onehalf
	name = "Station Fragment"
	icon_state = "away"

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

///Radioactive Waste Disposal Site/station

/area/ruin/space/has_grav/powered/nuclearwaste
	name = "Waste Disposal Station Bathroom"
	icon_state = "restrooms"
	sound_environment = SOUND_ENVIRONMENT_BATHROOM

/area/ruin/space/has_grav/powered/nuclearwaste/dorms
	name = "Waste Disposal Station Dorms"
	icon_state = "Lounge"

/area/ruin/space/has_grav/powered/nuclearwaste/radioactive_1
	name = "Radioactive Storage Site 01"
	icon_state = "amaint"
	sound_environment = SOUND_AREA_SMALL_ENCLOSED

/area/ruin/space/has_grav/powered/nuclearwaste/radioactive_2
	name = "Radioactive Storage Site 02"
	icon_state = "fmaint"
	sound_environment = SOUND_AREA_SMALL_ENCLOSED

/area/ruin/space/has_grav/powered/nuclearwaste/radioactive_3
	name = "Radioactive Storage Site 03"
	icon_state = "smaint"
	sound_environment = SOUND_AREA_SMALL_ENCLOSED

/area/ruin/space/has_grav/powered/nuclearwaste/radioactive_4
	name = "Radioactive Storage Site 04"
	icon_state = "pmaint"
	sound_environment = SOUND_AREA_SMALL_ENCLOSED

/area/ruin/space/has_grav/powered/nuclearwaste/radioactive_north_outer
	name = "Radioactive Storage Site Outer Hall 01"
	icon_state = "hallA"
	sound_environment = SOUND_AREA_SMALL_ENCLOSED

/area/ruin/space/has_grav/powered/nuclearwaste/radioactive_south_outer
	name = "Radioactive Storage Site Outer Hall 02"
	icon_state = "hallF"
	sound_environment = SOUND_AREA_SMALL_ENCLOSED

/area/ruin/space/has_grav/powered/nuclearwaste/radioactive_north_inner
	name = "Radioactive Storage Site Outer Hall 03"
	icon_state = "hallS"
	sound_environment = SOUND_AREA_SMALL_ENCLOSED

/area/ruin/space/has_grav/powered/nuclearwaste/radioactive_south_inner
	name = "Radioactive Storage Site Outer Hall 04"
	icon_state = "hallP"
	sound_environment = SOUND_AREA_SMALL_ENCLOSED

/area/ruin/space/has_grav/powered/nuclearwaste/medbay
	name = "Waste Disposal Station Medbay"
	icon_state = "medbay3"

/area/ruin/space/has_grav/powered/nuclearwaste/navcom
	name = "Waste Disposal Station NavCom"
	icon_state = "bridge"

/area/ruin/space/has_grav/powered/nuclearwaste/shuttle
	name = "Waste Supply Shuttle"
	icon_state = "bridge"

/area/ruin/space/has_grav/powered/nuclearwaste/north_hall
	name = "Waste Disposal Station Northern section"
	icon_state = "blue"

/area/ruin/space/has_grav/powered/nuclearwaste/south_hall
	name = "Waste Disposal Station Northern section"
	icon_state = ""

/area/ruin/space/has_grav/powered/nuclearwaste/this_is_not_a_place_of_honor
	name "Long-term Nuclear Waste Warning Marker Room"
	icon_state "yellow"
	sound_environment = SOUND_AREA_LARGE_ENCLOSED

/area/ruin/space/has_grav/powered/nuclearwaste/recreation
	name = "Waste Disposal Station Crew-room"
	icon_state = "maintcentral"

/area/ruin/space/has_grav/powered/nuclearwaste/engineering
	name = "Waste Disposal Station Engineering" //engi-nearing my limits ami  right  guysz
	icon_state "yellow"

/area/ruin/space/has_grav/powered/nuclearwaste/cargo_left
	name = "Waste Disposal Station Leftside Shuttle Side"
	icon_state = "storage"

/area/ruin/space/has_grav/powered/nuclearwaste/cargo_right
	name = "Waste Disposal Station Rightside Shuttle Side"
	icon_state = "storage"
