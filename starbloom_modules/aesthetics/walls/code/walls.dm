/turf/closed/wall
	icon = 'starbloom_modules/aesthetics/walls/icons/wall.dmi'
	canSmoothWith = list(SMOOTH_GROUP_WALLS, SMOOTH_GROUP_WINDOW_FULLTILE, SMOOTH_GROUP_AIRLOCK)

/turf/closed/wall/r_wall
	icon = 'starbloom_modules/aesthetics/walls/icons/reinforced_wall.dmi'

/turf/closed/wall/rust
	icon = 'starbloom_modules/aesthetics/walls/icons/wall.dmi'
	icon_state = "wall-0"
	base_icon_state = "wall"

/turf/closed/wall/r_wall/rust
	icon = 'starbloom_modules/aesthetics/walls/icons/reinforced_wall.dmi'
	icon_state = "reinforced_wall-0"
	base_icon_state = "reinforced_wall"

/turf/closed/wall/rust/New(loc, ...)
	. = ..()
	var/mutable_appearance/rust = mutable_appearance(icon, "rust")
	add_overlay(rust)

/turf/closed/wall/r_wall/rust/New(loc, ...)
	. = ..()
	var/mutable_appearance/rust = mutable_appearance(icon, "rust")
	add_overlay(rust)
