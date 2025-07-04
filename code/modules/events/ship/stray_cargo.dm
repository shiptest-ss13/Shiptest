///Spawns a cargo pod containing a random cargo supply pack on a random area of the station
/datum/round_event_control/ship/stray_cargo
	name = "Stray Cargo Pod"
	typepath = /datum/round_event/ship/stray_cargo
	weight = 1
	max_occurrences = 2
	min_players = 10
	earliest_start = 10 MINUTES
	category = EVENT_CATEGORY_BUREAUCRATIC
	description = "A pod containing a random supply crate lands on the station."
	admin_setup = list(/datum/event_admin_setup/listed_options/ship, /datum/event_admin_setup/set_location/stray_cargo, /datum/event_admin_setup/listed_options/stray_cargo)

///Spawns a cargo pod containing a random cargo supply pack on a random area of the station
/datum/round_event/ship/stray_cargo
	var/area/impact_area ///Randomly picked area
	announce_chance = 95
	var/list/possible_pack_types = list() ///List of possible supply packs dropped in the pod, if empty picks from the cargo list
	var/static/list/stray_spawnable_supply_packs = list() ///List of default spawnable supply packs, filtered from the cargo list
	///Admin setable override that is used instead of selecting a random location
	var/atom/admin_override_turf
	///Admin setable override to spawn a specific cargo pack type
	var/admin_override_contents

/datum/round_event/ship/stray_cargo/announce(fake)
	if(fake)
		impact_area = find_event_area()
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
	if(admin_override_turf)
		impact_area = get_area(admin_override_turf)
	else
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
	if(admin_override_contents)
		pack_type = admin_override_contents
	else
		if(possible_pack_types.len)
			pack_type = pick(possible_pack_types)
		else
			var/datum/overmap/outpost/supplier = pick(SSovermap.outposts)
			if(!supplier)
				return
			pack_type = pick(supplier.market.supply_packs)
	var/datum/supply_pack/supply_pack
	if(ispath(pack_type, /datum/supply_pack))
		supply_pack = new pack_type
	else
		supply_pack = pack_type
	var/obj/structure/closet/crate/crate = supply_pack.generate(null)
	crate.locked = FALSE //Unlock secure crates
	crate.update_appearance()
	var/obj/structure/closet/supplypod/pod = make_pod()
	pod.explosionSize = list(0,0,1,2)
	var/obj/effect/pod_landingzone/landing_marker = new(LZ, pod, crate)
	notify_ghosts("[control.name] has summoned a supply crate!", source = get_turf(landing_marker), header = "Cargo Inbound")

///Handles the creation of the pod, in case it needs to be modified beforehand
/datum/round_event/ship/stray_cargo/proc/make_pod()
	var/obj/structure/closet/supplypod/stray_pod = new
	return stray_pod

/datum/event_admin_setup/set_location/stray_cargo
	input_text = "Aim pod at turf we're on?"

/datum/event_admin_setup/set_location/stray_cargo/apply_to_event(datum/round_event/ship/stray_cargo/event)
	event.admin_override_turf = chosen_turf

/datum/event_admin_setup/listed_options/stray_cargo
	input_text = "Choose a cargo crate to drop."
	normal_run_option = "Random Crate"

/datum/event_admin_setup/listed_options/stray_cargo/get_list()
	return sortList(subtypesof(/datum/supply_pack), /proc/cmp_typepaths_asc)

/datum/event_admin_setup/listed_options/stray_cargo/apply_to_event(datum/round_event/ship/stray_cargo/event)
	event.admin_override_contents = chosen
	var/log_message = "[key_name_admin(usr)] has aimed a stray cargo pod at [event.admin_override_turf ? AREACOORD(event.admin_override_turf) : "a random location"]. The pod contents are [chosen ? chosen : "random"]."
	message_admins(log_message)
	log_admin(log_message)
