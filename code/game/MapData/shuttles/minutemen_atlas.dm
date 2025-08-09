/obj/structure/fluff/overhead
	name = "overhead prop"
	layer = RIPPLE_LAYER
	deconstructible = FALSE
	mouse_opacity = FALSE

/obj/structure/fluff/overhead/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/largetransparency, _x_offset = -1, _y_offset = -1, _x_size = 2, _y_size = 2)

/obj/structure/fluff/overhead/lattice
	name = "lattice"
	desc = "A lightweight support lattice."
	icon = 'icons/obj/smooth_structures/lattice.dmi'
	icon_state = "lattice-255"

/obj/structure/fluff/overhead/pipe
	name = "overhead pipe segment"
	desc = "A pipe that carries water and other miscellaneous fluids throughout a ship or stucture."
	icon = 'icons/obj/atmospherics/pipes/simple.dmi'
	icon_state = "pipe11-1"
