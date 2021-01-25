/obj/effect/spawner/structure/window/shutters
	icon = 'whitesands/icons/obj/structures_spawners.dmi'
	icon_state = "shwindow_spawner"
	name = "shutter window spawner"
	spawn_list = list(/obj/structure/grille, /obj/structure/window/fulltile, /obj/machinery/door/firedoor/window)
	dir = SOUTH
	FASTDMM_PROP(\
		pipe_astar_cost = 2\
	)

/obj/effect/spawner/structure/window/reinforced/shutters
	icon = 'whitesands/icons/obj/structures_spawners.dmi'
	name = "reinforced shutter window spawner"
	icon = 'whitesands/icons/obj/structures_spawners.dmi'
	icon_state = "shrwindow_spawner"
	spawn_list = list(/obj/structure/grille, /obj/structure/window/reinforced/fulltile, /obj/machinery/door/firedoor/window)

/obj/effect/spawner/structure/window/reinforced/tinted/shutters
	icon = 'whitesands/icons/obj/structures_spawners.dmi'
	name = "tinted reinforced shutter window spawner"
	icon = 'whitesands/icons/obj/structures_spawners.dmi'
	icon_state = "shtwindow_spawner"
	spawn_list = list(/obj/structure/grille, /obj/structure/window/reinforced/tinted/fulltile, /obj/machinery/door/firedoor/window)

/obj/effect/spawner/structure/window/plasma/reinforced/shutters
	icon = 'whitesands/icons/obj/structures_spawners.dmi'
	name = "reinforced plasma shutter window spawner"
	icon = 'whitesands/icons/obj/structures_spawners.dmi'
	icon_state = "shprwindow_spawner"
	spawn_list = list(/obj/structure/grille, /obj/structure/window/plasma/reinforced/fulltile, /obj/machinery/door/firedoor/window)
