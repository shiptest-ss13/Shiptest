// DEBUG: separate "skin" from outpost map; multiple maps should be able to use same skin
/datum/map_template/outpost
	var/skin
	var/suffix

/datum/map_template/outpost/New()
	var/new_name = "outpost_[skin]_[suffix]"
	. = ..(path = "_maps/outpost/[new_name].dmm", rename = new_name)


/datum/map_template/outpost_elevator
	var/skin

/datum/map_template/outpost_elevator/New()
	var/new_name = "elevator_[skin]"
	. = ..(path = "_maps/outpost/elevators/[new_name].dmm", rename = new_name)


/datum/map_template/hangar
	var/skin
	var/port_width
	var/port_height

/datum/map_template/hangar/New()
	var/new_name = "hangar_[skin]_[port_width]x[port_height]"
	. = ..(path = "_maps/outpost/hangars/[new_name].dmm", rename = new_name)
