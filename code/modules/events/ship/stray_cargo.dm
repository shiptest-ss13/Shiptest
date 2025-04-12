///Spawns a cargo pod containing a random cargo supply pack on a random area of the station
/datum/round_event_control/ship/stray_cargo
	name = "Stray Cargo Pod"
	typepath = /datum/round_event/ship/stray_cargo
	weight = 0
	max_occurrences = 2
	min_players = 10
	earliest_start = 10 MINUTES

///Spawns a cargo pod containing a random cargo supply pack on a random area of the station
/datum/round_event/ship/stray_cargo
	var/area/impact_area ///Randomly picked area
	announce_chance = 95
	var/list/possible_pack_types = list() ///List of possible supply packs dropped in the pod, if empty picks from the cargo list
	var/static/list/stray_spawnable_supply_packs = list() ///List of default spawnable supply packs, filtered from the cargo list

/datum/round_event/ship/stray_cargo/announce(fake)
	if(!impact_area)
		return
	if(prob(announce_chance) || fake)
		priority_announce("Stray cargo pod detected on long-range scanners. Expected location of impact: [impact_area.name].",
			"Collision Alert",
			null,
			sender_override = "[target_ship] Radar",
			zlevel = impact_area.virtual_z()
		)

/**
* Tries to find a valid area, throws an error if none are found
* Also randomizes the start timer
*/
/datum/round_event/ship/stray_cargo/setup()
	if(!..())
		return
	start_when = rand(10, 20)
	impact_area = find_event_area()
	if(!impact_area)
		CRASH("No valid areas for cargo pod found.")
	var/list/turf_test = get_area_turfs(impact_area)
	if(!turf_test.len)
		CRASH("Stray Cargo Pod : No valid turfs found for [impact_area] - [impact_area.type]")

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
		var/datum/overmap/outpost/supplier = pick(SSovermap.outposts)
		if(!supplier)
			return
		pack_type = pick(supplier.supply_packs)
	var/datum/supply_pack/SP = pack_type
	var/obj/structure/closet/crate/crate = SP.generate(null)
	crate.locked = FALSE //Unlock secure crates
	crate.update_appearance()
	var/obj/structure/closet/supplypod/pod = make_pod()
	pod.explosionSize = list(0,0,1,2)
	new /obj/effect/pod_landingzone(LZ, pod, crate)

///Handles the creation of the pod, in case it needs to be modified beforehand
/datum/round_event/ship/stray_cargo/proc/make_pod()
	var/obj/structure/closet/supplypod/S = new
	return S
