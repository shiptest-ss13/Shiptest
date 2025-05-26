
/obj/structure/hazard/electrical/conduit
	name = "old power conduit"
	desc = "cheap industrial cable used to transfer large volumes of power."
	icon = 'icons/obj/hazard/conduit.dmi'
	icon_state = "conduit"
	density = FALSE
	time_to_disable = 10 SECONDS //only some subtypes can actually be disabled.
	slowdown = 0.5

/obj/structure/hazard/electrical/conduit/corner
	icon_state = "conduitcorner"

/obj/structure/hazard/electrical/conduit/manifold
	icon_state = "conduitmanifold"

/obj/structure/hazard/electrical/conduit/manifold4w
	icon_state = "conduitmanifold4w"

/obj/structure/hazard/electrical/conduit/frayed_sparks
	name = "frayed power conduit"
	desc = "cheap industrial cable used to transfer large volumes of power, which appears to be frayed."
	icon_state = "conduitfrayed"
	contact_sparks = TRUE
	random_sparks = TRUE
	cooldown_time = 10 SECONDS
	random_min = 30 SECONDS
	random_max = 90 SECONDS
	can_be_disabled = TRUE

/obj/structure/hazard/electrical/conduit/exposed_wires_stun
	name = "exposed power conduit"
	desc = "cheap industrial cable used to transfer large volumes of power, with the internal cable exposed."
	icon_state = "conduitexposed"
	contact_sparks = TRUE
	contact_stun = TRUE
	stun_time = 60
	contact_damage = 35
	shock_flags = SHOCK_NOGLOVES | SHOCK_NOSTUN
	can_be_disabled = TRUE

/obj/structure/hazard/electrical/conduit/tesla_arc_node
	name = "power conduit node"
	desc = "An exposed contact point for an old charging system, now highly dangerous due to its age."
	icon_state = "conduitnode"
	random_tesla = TRUE
	random_min = 5 SECONDS
	random_max = 10 SECONDS
	zap_range = 2
	zap_power = 1500
	zap_flags = ZAP_MOB_DAMAGE | ZAP_MOB_STUN
	can_be_disabled = TRUE //a fools errand, but we can let them try.
