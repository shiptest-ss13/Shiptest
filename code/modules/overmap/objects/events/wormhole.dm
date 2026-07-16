/datum/overmap/event/wormhole
	name = "wormhole"
	desc = "A hole through space. If you go through here, you might end up anywhere."
	base_icon_state = "wormhole"
	token_icon_state = "wormhole"
	spread_chance = 0
	chance_to_affect = 100
	interference_power = 40

	//should never happen but no runtimes.
	spread_types = list(/datum/overmap/event/wormhole = 100)


	///The currently linked wormhole
	var/datum/overmap/event/wormhole/other_wormhole

/datum/overmap/event/wormhole/Initialize(position, datum/overmap_star_system/system_spawned_in, set_lifespan, _other_wormhole, ...)
	. = ..()
	if(_other_wormhole)
		other_wormhole = _other_wormhole
	if(!other_wormhole)
		other_wormhole = new(null, current_overmap, set_lifespan, src) //Create a new wormhole at a random location
	alter_token_appearance()

/datum/overmap/event/wormhole/alter_token_appearance()
	token.color = "#6d80c7"
	token.light_color = "#6d80c7"
	..()
	if(current_overmap.override_object_colors)
		token.color = current_overmap.hazard_primary_color
	current_overmap.post_edit_token_state(src)

/datum/overmap/event/wormhole/affect_ship(datum/overmap/ship/controlled/S)
	if(!other_wormhole)
		qdel(src)
		return
	if(current_overmap != other_wormhole.current_overmap)
		S.move_overmaps(other_wormhole.current_overmap, other_wormhole.x, other_wormhole.y)
	else
		S.overmap_move(other_wormhole.x, other_wormhole.y)
	S.overmap_step(S.get_heading())

/datum/overmap/event/wormhole/get_jump_to_turf()
	if(other_wormhole)
		return get_turf(other_wormhole.token)
	//go to the star.
	return
