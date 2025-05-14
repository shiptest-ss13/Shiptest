/*
the way this works:
when a new hangar is spawned, the hangar zlevel finds the spawner landmark and converts it the real spawner
the real spawner is sent to the hangar dock.
when a ship orders a crate, the cargo computer asks the ship which asks its own docking port which asks the hangar port for the spawner.
and then spawns a crate at the spawner's turf
*/

/obj/effect/landmark/outpost/hangar_crate_spawner
	name = "hangar crate spawner"

/obj/effect/landmark/outpost/hangar_crate_spawner/proc/create_spawner()
	var/obj/hangar_crate_spawner/spawner = new /obj/hangar_crate_spawner(get_turf(src))
	qdel(src)
	return spawner

/obj/hangar_crate_spawner
	invisibility = INVISIBILITY_OBSERVER
	name = "crate delivery chute"
	icon = 'icons/effects/mapping/mapping_helpers.dmi'
	icon_state = "adder"
	anchored = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | LANDING_PROOF | HYPERSPACE_PROOF

/obj/hangar_crate_spawner/proc/handle_order(datum/supply_order/order)
	order.generate(get_turf(src))

