/obj/structure/hazard/fire
	name = "fire hazard"
	desc = "tell a maptainer if you see this. BZZT!"
	icon_state = "hazardb"
	cooldown_time = 3 SECONDS
	var/fire_power = 100
	var/fire_color = "red"
	var/light_fire = TRUE
	var/random_sparks = TRUE
	disable_text = "cutting the wires."

/obj/structure/hazard/fire/do_random_effect()
	if(random_sparks)
		do_sparks(2, TRUE, src)
	if(light_fire)
		var/turf/to_burn = get_turf(src)
		to_burn.hotspot_expose(700,50,1)
		to_burn.ignite_turf(fire_power,fire_color)
		visible_message(span_danger("A sudden burst of sparks bursts out, falling onto the ground and igniting something flammable!"))
