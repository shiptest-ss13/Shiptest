/datum/mission/dynamic/simple/blackbox
	setpiece_item = /obj/item/blackbox

/datum/mission/dynamic/kill/generate_mission_details()
	. = ..()
	if(!name)
		name = "[setpiece_item::name] recovery"
	if(!desc)
		desc = "Recover one of our lost [setpiece_item::name] from the location at this planet. We've pinged its location to a local ruin."

/obj/effect/landmark/mission_poi/recovery
	icon_state = "main_blackbox"
