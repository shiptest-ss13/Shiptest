///Spawns a cargo pod containing a random cargo supply pack on a random area of the station
/datum/round_event_control/stray_cargo
	name = "Stray Cargo Pod"
	typepath = /datum/round_event/ship/stray_cargo
	weight = 20
	max_occurrences = 4
	earliest_start = 0

/datum/round_event_control/stray_cargo/canSpawnEvent(players, allow_magic = FALSE)
	if(!(length(SSovermap.controlled_ships)))
		return FALSE
	return ..()

///Spawns a cargo pod containing a random cargo supply pack on a random area of the station
/datum/round_event/ship/stray_cargo
	var/area/impact_area ///Randomly picked area
	announceChance = 75
	var/list/possible_pack_types = list() ///List of possible supply packs dropped in the pod, if empty picks from the cargo list
	var/static/list/stray_spawnable_supply_packs = list() ///List of default spawnable supply packs, filtered from the cargo list

///datum/round_event/ship/stray_cargo/announce(fake)
	//priority_announce("Stray cargo pod detected on long-range scanners. Expected location of impact: [impact_area.name].", "Collision Alert", zlevel = impact_area.virtual_z())

/**
* Tries to find a valid area, throws an error if none are found
* Also randomizes the start timer
*/
/datum/round_event/ship/stray_cargo/setup()
	if(!..())
		return
	startWhen = rand(20, 40)
	impact_area = find_event_area()
	if(!impact_area)
		CRASH("No valid areas for cargo pod found.")
	var/list/turf_test = get_area_turfs(impact_area)
	if(!turf_test.len)
		CRASH("Stray Cargo Pod : No valid turfs found for [impact_area] - [impact_area.type]")

	if(!stray_spawnable_supply_packs.len)
		stray_spawnable_supply_packs = SSshuttle.supply_packs.Copy()

///Spawns a random supply pack, puts it in a pod, and spawns it on a random tile of the selected area
/datum/round_event/ship/stray_cargo/start()
	if(!target_ship)
		return
	var/list/turf/valid_turfs = get_area_turfs(impact_area)
	//Only target non-dense turfs to prevent wall-embedded pods
	for(var/i in valid_turfs)
		var/turf/T = i
		if(T.density)
			valid_turfs -= T
	var/turf/LZ = pick(valid_turfs)
	var/pack_type
	if(possible_pack_types.len)
		pack_type = pick(possible_pack_types)
	else
		pack_type = pick(stray_spawnable_supply_packs)
	var/datum/supply_pack/SP = new pack_type
	var/obj/structure/closet/crate/crate = SP.generate(null)
	crate.locked = FALSE //Unlock secure crates
	crate.update_appearance()
	var/obj/structure/closet/supplypod/pod = make_pod()
	new /obj/effect/pod_landingzone(LZ, pod, crate)

///Handles the creation of the pod, in case it needs to be modified beforehand
/datum/round_event/ship/stray_cargo/proc/make_pod()
	var/obj/structure/closet/supplypod/S = new
	return S

///Picks an area that wouldn't risk critical damage if hit by a pod explosion
/datum/round_event/ship/stray_cargo/proc/find_event_area()
	if (length(target_ship.shuttle_port.shuttle_areas))
		return pick(target_ship.shuttle_port.shuttle_areas)
