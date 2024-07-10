//Used by spraybottles.
/obj/effect/decal/chempuff
	name = "chemicals"
	icon = 'icons/obj/chempuff.dmi'
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF //for use in terraforming a
	pass_flags = PASSTABLE | PASSGRILLE
	layer = FLY_LAYER

/obj/effect/decal/chempuff/CanPassThrough(atom/blocker, movement_dir, blocker_opinion)
	. = ..()
	if(istype(blocker, /obj/structure/flora))
		return TRUE
	if(istype(blocker, /obj/machinery))
		return TRUE



/obj/effect/decal/chempuff/blob_act(obj/structure/blob/B)
	return

/obj/effect/decal/fakelattice
	name = "lattice"
	desc = "A lightweight support lattice."
	icon = 'icons/obj/smooth_structures/lattice.dmi'
	icon_state = "lattice-255"
	density = FALSE
