/datum/objective/hack_apc
	name = "hack multiple apcs"
	explanation_text = "Hack a specified number of APCs by the end of the round. You may still spend the processing power as normal."
	martyr_compatible = 0
	var/target_count

/datum/objective/hack_apc/New(var/text)
	target_count = rand(10, CONFIG_GET(number/max_malf_apc_hack_obj))
	explanation_text = "Hack [target_count] APCs by the end of the round. You may still spend the processing power as normal."
	..()

/datum/objective/hack_apc/check_completion()
	var/list/datum/mind/owners = get_owners()
	var/datum/mind/aiOwner = null
	for(var/datum/mind/M in owners)
		if(M.assigned_role == "AI")
			aiOwner = M

	if(aiOwner == null)
		return FALSE
	var/count = 0
	for(var/obj/machinery/power/apc/C in GLOB.apcs_list)
		if(C.cell && is_station_level(C.z))
			if(C.malfai == aiOwner.current)
				count++;

	return count >= target_count
