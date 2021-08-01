/obj/structure/window/fulltile
	icon = 'goon/icons/obj/window_pyro.dmi'
	icon_state = "window"
	color = "#94bbd1"
	canSmoothWith = list(SMOOTH_GROUP_WINDOW_FULLTILE, SMOOTH_GROUP_WALLS, SMOOTH_GROUP_AIRLOCK)

/obj/structure/window/reinforced/fulltile
	icon = 'goon/icons/obj/window_pyro.dmi'
	color = "#94bbd1"
	icon_state = "rwindow"
	alpha = 200
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_WINDOW_FULLTILE)
	canSmoothWith = list(SMOOTH_GROUP_WINDOW_FULLTILE, SMOOTH_GROUP_WALLS, SMOOTH_GROUP_AIRLOCK)


/obj/structure/window/reinforced/tinted/fulltile
	icon = 'goon/icons/obj/window_pyro.dmi'
	color = "#94bbd13b"
	icon_state = "window"
	alpha = 200
	canSmoothWith = list(SMOOTH_GROUP_WINDOW_FULLTILE, SMOOTH_GROUP_WALLS, SMOOTH_GROUP_AIRLOCK)


/obj/structure/window/plasma/fulltile
	icon = 'goon/icons/obj/window_pyro.dmi'
	color = "#EE82EE"
	icon_state = "window"
	base_icon_state = "window"
	alpha = 200
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_WINDOW_FULLTILE)
	canSmoothWith = list(SMOOTH_GROUP_WINDOW_FULLTILE, SMOOTH_GROUP_WALLS, SMOOTH_GROUP_AIRLOCK)

/obj/structure/window/plasma/reinforced/fulltile
	icon = 'goon/icons/obj/window_pyro.dmi'
	color = "#EE82EE"
	icon_state = "rwindow"
	base_icon_state = "reinforced_window"
	alpha = 200
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_WINDOW_FULLTILE)
	canSmoothWith = list(SMOOTH_GROUP_WINDOW_FULLTILE, SMOOTH_GROUP_WALLS, SMOOTH_GROUP_AIRLOCK)
