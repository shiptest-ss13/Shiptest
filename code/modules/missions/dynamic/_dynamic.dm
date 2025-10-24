/datum/mission/ruin
	value = 1500
	duration = null
	desc = "Find my pages. (Please report if you cannot locate pages)"
	location_specific = TRUE
	blackbox_prefix = "ruin_"
	/// Which landmark we will search for in spawned_mission_pois of the planet
	var/setpiece_poi = /obj/effect/landmark/mission_poi/main
	/// Item that will be spawned at the setpiece_poi
	var/obj/setpiece_item
	/// Specific item uses an exact item, if false it will allow type or any subtype
	var/specific_item = TRUE
	/// The item that you can turn in to complete the mission. If specific_item is false it uses the type of the item.
	var/atom/movable/required_item
	var/dibs_string

/datum/mission/ruin/generate_mission_details()
	. = ..()
	setpiece_item = pick(setpiece_item)

/datum/mission/ruin/mission_regexs(mission_string)
	mission_string = ..()
	if(ispath(setpiece_item))
		var/atom/target = setpiece_item
		mission_string = replacetext(mission_string, "%MISSION_REQUIRED", "[target::name]")
	return mission_string

/datum/mission/ruin/spawn_mission_details(datum/overmap/dynamic/planet)
	if(isnull(mission_index))
		stack_trace("[src] does not have a mission index!")
	for(var/datum/weakref/poi_ref in planet.spawned_mission_pois)
		var/obj/effect/landmark/mission_poi/mission_poi = poi_ref.resolve()
		use_poi(mission_poi, planet)
		if(QDELETED(mission_poi))
			planet.spawned_mission_pois -= poi_ref

	spawn_custom_details(planet)

/datum/mission/ruin/proc/use_poi(obj/effect/landmark/mission_poi/mission_poi, datum/overmap/dynamic/planet)
	if(mission_poi.use_count <= 0)
		qdel(mission_poi)
		return
	if(isnull(mission_poi.mission_index) || (mission_index != mission_poi.mission_index))
		return

	var/main = FALSE
	if(istype(mission_poi, /obj/effect/landmark/mission_poi/main))
		main = TRUE
		if(required_item)
			return

	if(main)
		if(istype(mission_poi, setpiece_poi))
			//Spawns the item or gets it via use_poi then sets it as bound so the mission fails if its deleted
			spawn_main_piece(mission_poi, planet)
	else
		var/atom/poi_result = mission_poi.use_poi(FALSE, src)
		if(isatom(poi_result))
			poi_result.AddComponent(/datum/component/mission_important, MISSION_IMPORTANCE_RELEVENT, src)

/datum/mission/ruin/on_planet_load(datum/overmap/dynamic/planet)
	. = ..()
	if(!length(bound_atoms))
		if(specific_item)
			stack_trace("Somehow [src] ran on_planet_load and has no bound atoms still, this likely means its failed to find any valid pois to spawn? Contact Fallcon.")

/datum/mission/ruin/proc/spawn_main_piece(obj/effect/landmark/mission_poi/mission_poi, datum/overmap/dynamic/planet)
	required_item =	mission_poi.use_poi(setpiece_item, src)
	if(isatom(required_item))
		set_bound(required_item, null, TRUE, TRUE)
	else
		stack_trace("[src] did not generate a required item.")
		qdel(src)

/// For handling logic outside of main piece thats too complex for the basic reiteration or you want to not require indexs to match.
/datum/mission/ruin/proc/spawn_custom_details(datum/overmap/dynamic/planet)
	return

/datum/mission/ruin/remove_bound(atom/movable/bound)
	if(bound == required_item)
		required_item = null
	return ..()

/datum/mission/ruin/can_turn_in(atom/movable/item_to_check)
	if(specific_item)
		if(!isatom(required_item))
			return FALSE
		if(item_to_check == required_item)
			return TRUE
	else
		if(istype(item_to_check, setpiece_item))
			return TRUE
		else if(istype(required_item) && istype(item_to_check, required_item.type))
			return TRUE

/datum/mission/ruin/get_tgui_info(list/items_on_pad = list())
	. = ..()
	var/time_remaining = max(dur_timer ? timeleft(dur_timer) : duration, 0)

	var/act_str = get_act_string()

	var/can_turn_in = FALSE
	var/list/acceptable_items = list()
	for(var/atom/movable/item_on_pad in items_on_pad)
		if(can_turn_in(item_on_pad))
			acceptable_items += list(item_on_pad.name)
			can_turn_in = TRUE
			break

	var/datum/overmap/mission_location = mission_local_weakref.resolve()
	if(mission_location)
		update_mission_info(mission_location)

	. += list(
		"ref" = REF(src),
		"name" = src.name,
		"author" = src.author,
		"desc" = src.desc,
		"reward" = src.reward_flavortext(),
		"faction" = SSfactions.faction_name(src.faction),
		"location" = "X[local_x]/Y[local_y]: [local_name]",
		"x" = local_x,
		"y" = local_y,
		"timeIssued" = time2text(station_time() - time_issued, "mm"),
		"duration" = src.duration,
		"remaining" = time_remaining,
		"timeStr" = time2text(time_remaining, "mm:ss"),
		"progressStr" = get_progress_string(),
		"actStr" = act_str,
		"canTurnIn" = can_turn_in,
		"validItems" = acceptable_items,
		"claim" = dibs_string
	)

/datum/mission/ruin/proc/get_act_string()
	return "Turn in"

/datum/mission/ruin/vv_edit_var(var_name, var_value)
	if(var_name == NAMEOF(src, required_item))
		remove_bound(required_item)
		set_bound(var_value)
	return ..()
