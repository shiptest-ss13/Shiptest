/obj/structure/hazard/electrical/electrified_water
	name = "electrified water"
	desc = "hazardous water!"
	icon_state = "electrified"
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF | HYPERSPACE_PROOF
	move_resist = INFINITY
	obj_flags = 0
	density = FALSE
	random_sparks = TRUE
	random_zap = TRUE
	contact_damage = 10
	random_min = 3 SECONDS //should result in the whole pool pulsing at almost the same time.
	random_max = 3 SECONDS
	slowdown = 0.5
