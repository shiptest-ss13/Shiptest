/datum/map_template/ruin
	//name = "A Chest of Doubloons"
	name = null
	var/id = null // For blacklisting purposes, all ruins need an id
	var/description = "In the middle of a clearing in the rockface, there's a chest filled with gold coins with Spanish engravings. \
	How is there a wooden container filled with 18th century coinage in the middle of a lavawracked hellscape? \
	It is clearly a mystery."

	var/placement_weight = 1
	var/cost = 0 //Cost in ruin budget placement system
	var/allow_duplicates = TRUE
	var/list/always_spawn_with = null //These ruin types will be spawned along with it (where dependent on the flag) eg list(/datum/map_template/ruin/space/teleporter_space = SPACERUIN_Z)
	var/list/never_spawn_with = null //If this ruin is spawned these will not eg list(/datum/map_template/ruin/base_alternate)

	var/prefix = null
	var/suffix = null

	/// The faction that used to own this before any current inhabitents (frontiersmen, spiders). Defaults to current_owner
	var/real_owner
	/// The current faction that controls the ruin, likely a hostile faction or unknown
	var/current_owner = /datum/faction/unknown

	var/ruin_type
	var/ruin_tags = list()

	var/ruin_mission_types

/datum/map_template/ruin/New()
	if(!name && id)
		name = id

	if(!real_owner)
		real_owner = current_owner

	mappath = prefix + suffix
	if(!findtext(mappath, ".dmm"))
		stack_trace("[src] has a mappath with no .dmm in it. Its mappath is: [mappath].")
	..(path = mappath)
