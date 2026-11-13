//Causes fire damage to anyone not standing on a dense object.
/datum/weather/floor_is_lava
	name = "the floor is lava"
	desc = "The ground turns into surprisingly cool lava, lightly damaging anything on the floor."

	telegraph_message = span_warning("You feel the ground beneath you getting hot. Waves of heat distort the air.")
	telegraph_duration = 150

	weather_message = span_userdanger("The floor is lava! Get on top of something!")
	weather_duration_lower = 300
	weather_duration_upper = 600
	weather_overlay = "lava"

	end_message = span_danger("The ground cools and returns to its usual form.")
	end_duration = 0

	area_type = /area
	protected_areas = list(/area/space)

	overlay_layer = ABOVE_OPEN_TURF_LAYER //Covers floors only
	overlay_plane = FLOOR_PLANE
	immunity_type = "lava"
	harmful = TRUE
	multiply_blend_on_main_stage = TRUE


/datum/weather/floor_is_lava/affects(mob/living/victim)
	if(issilicon(victim))
		return FALSE
	if(istype(victim.buckled, /obj/structure/bed))
		return FALSE
	for(var/obj/structure/structure in victim.loc)
		if(structure.density)
			return FALSE
	if(victim.loc.density)
		return FALSE
	if(!victim.client) //Only sentient people are going along with it!
		return FALSE
	if(victim.movement_type & FLYING)
		return FALSE
	return TRUE

/datum/weather/floor_is_lava/weather_act(mob/living/victim)
	victim.adjustFireLoss(3)
