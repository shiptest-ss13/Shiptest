/datum/design/maint_drone
	name = "Maintenance Drone"
	desc = "\"Repairs the station without bothering you!\" is what the marketing says."
	id = "maint_drone"
	build_type = MECHFAB
	materials = list(/datum/material/iron = 800, /datum/material/glass = 350)
	construction_time = 150
	build_path = /obj/effect/mob_spawn/drone
	category = list("Misc")
