//Baystation, a server I haven't played on but they look cool. These were a pain in the ass to get workina dnd as of typing don't work.
//These use the "3/4" perspective, which is used by goonstation, and looks like you are looking from above and at a angle.atom
//soul level: low

/turf/closed/wall
	icon_state = "wall-0"
	base_icon_state = "wall"
	icon = 'goon/icons/turf/bay-wall.dmi'

	canSmoothWith = list(SMOOTH_GROUP_WINDOW_FULLTILE, SMOOTH_GROUP_WALLS, SMOOTH_GROUP_AIRLOCK)
/*
	var/list/wall_connections = list("0", "0", "0", "0")
	var/list/other_connections = list("0", "0", "0", "0")
	var/image/texture = null //EG: Concrete. Lets you texture a wall with one texture tile rather than making a new wall..every..single...time
	var/texture_state = null
*/
	color = "#787878"
/*
/atom/proc/legacy_smooth() //janky stuff?
	return

/turf/closed/wall/Initialize()
	. = ..()
	legacy_smooth()
	update_connections()
	update_icon()
*/

/turf/closed/wall/steel
	color = "#787878"

/turf/closed/wall/r_wall
//	icon_state = "reinf"
//	texture = "reinf_over"
	icon = 'goon/icons/turf/bay-rwall.dmi'
	color = "#787878"

/turf/closed/wall/mineral
	icon = 'goon/icons/turf/bay-wall.dmi'
	icon_state = "wall-0"
	base_icon_state = "wall"
	icon = 'goon/icons/turf/bay-wall.dmi'

/turf/closed/wall/mineral/cult
	color = "#4C4343"
	icon = 'goon/icons/turf/bay-wall.dmi'

/turf/closed/wall/mineral/gold
	color = "#FFD700"
	icon = 'goon/icons/turf/bay-wall.dmi'

/turf/closed/wall/mineral/silver
	icon = 'goon/icons/turf/bay-wall.dmi'

/turf/closed/wall/mineral/snow
	icon = 'goon/icons/turf/bay-wall.dmi'

/*
/turf/closed/wall/mineral/copper
	icon_state = "metal"
	color = "#b87333"
	icon = 'nsv13/icons/turf/wall_masks.dmi'
*/
/turf/closed/wall/mineral/diamond
	color = "#b9f2ff"
	icon = 'goon/icons/turf/bay-wall.dmi'

/turf/closed/wall/mineral/sandstone
	color = "#AA9F91"
	icon = 'goon/icons/turf/bay-wall.dmi'

/turf/closed/wall/mineral/bananium
	color = "#FFFF33"
	icon = 'goon/icons/turf/bay-wall.dmi'

/turf/closed/wall/mineral/uranium
	color = "#228B22"
	icon = 'goon/icons/turf/bay-wall.dmi'

/turf/closed/wall/mineral/plasma
	color = "#EE82EE"
	icon = 'goon/icons/turf/bay-wall.dmi'

/turf/closed/wall/mineral/iron
	color = "#808080"
	icon = 'goon/icons/turf/bay-wall.dmi'

/turf/closed/wall/mineral/wood
	icon = 'goon/icons/turf/bay-wall.dmi'
	color = "#654D31"

/turf/closed/wall/mineral/titanium
	icon_state = "wall-0"
	base_icon_state = "wall"
	icon = 'goon/icons/turf/bay-wall.dmi'
	color = null
	smoothing_flags = SMOOTH_BITMASK

/turf/closed/wall/mineral/titanium/nodiagonal
	icon_state = "wall-0"
	base_icon_state = "wall"
	icon = 'goon/icons/turf/bay-wall.dmi'
	color = null

/turf/closed/wall/mineral/plastitanium
	color = null
/*
/obj/machinery/firealarm
	icon = 'ModularTegustation/Teguicons/skyrat_cool_walls/firealarm.dmi'
	alarm_sound = 'ModularTegustation/Tegusounds/tegu_cool_airlocks/alarm.ogg'
*/

/obj/machinery/door/firedoor/open()
	playsound(loc, door_open_sound, 90, TRUE)
	. = ..()

/obj/machinery/door/firedoor/close()
	playsound(loc, door_close_sound, 90, TRUE)
	. = ..()

/obj/machinery/door/firedoor
	icon = 'goon/icons/obj/firedoor.dmi'
	var/door_open_sound = 'whitesands/sound/effects/airlocks/firedoor_open.ogg'
	var/door_close_sound = 'whitesands/sound/effects/airlocks/firedoor_open.ogg'
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_WINDOW_FULLTILE)
	canSmoothWith = list(SMOOTH_GROUP_WINDOW_FULLTILE, SMOOTH_GROUP_WALLS, SMOOTH_GROUP_AIRLOCK)
//	layer = 4



//BAY WALLS, i hope
/*
/turf/open/floor
	icon = 'modular_skyrat/modules/aesthetics/floors/icons/floors.dmi'
*/

/*
#define CAN_SMOOTH_FULL 1 //Able to fully smooth, no "connection" states.
#define CAN_SMOOTH_HALF 2 //Able to half smooth, will spawn "connector" states.

/turf/closed/wall/proc/update_connections()
	var/list/wall_dirs = list()
	var/list/other_dirs = list()

	for(var/atom/W in orange(src, 1))
		switch(can_join_with(W))
			if(FALSE)
				continue
			if(CAN_SMOOTH_FULL)
				wall_dirs += get_dir(src, W)
			if(CAN_SMOOTH_HALF)
				wall_dirs += get_dir(src, W)
				other_dirs += get_dir(src, W)

	wall_connections = dirs_to_corner_states(wall_dirs)
	other_connections = dirs_to_corner_states(other_dirs)
	return

/turf/closed/wall/proc/can_join_with(atom/movable/W)
	if(ismob(W) || istype(W, /obj/machinery/door/window) || istype(W, /turf/closed/wall/mineral/titanium)) //Just...trust me on this
		return FALSE
	if(istype(W, src.type))
		return CAN_SMOOTH_FULL
	for(var/_type in canSmoothWith)
		if(istype(W, _type))
			return CAN_SMOOTH_FULL
	return FALSE

/turf/closed/wall/update_icon()
	cut_overlays()
	var/image/I = null
	for(var/i = 1 to 4)
		I = image(icon, "[initial(icon_state)][wall_connections[i]]", dir = 1<<(i-1))
		add_overlay(I)
		if(other_connections[i] != "0")
			I = image(icon, "[initial(icon_state)]_other[wall_connections[i]]", dir = 1<<(i-1))
			add_overlay(I)

#define CORNER_NONE 0
#define CORNER_COUNTERCLOCKWISE 1
#define CORNER_DIAGONAL 2
#define CORNER_CLOCKWISE 4

/proc/dirs_to_corner_states(list/dirs)
	if(!istype(dirs)) return

	var/list/ret = list(NORTHWEST, SOUTHEAST, NORTHEAST, SOUTHWEST)

	for(var/i = 1 to ret.len)
		var/dir = ret[i]
		. = CORNER_NONE
		if(dir in dirs)
			. |= CORNER_DIAGONAL
		if(turn(dir,45) in dirs)
			. |= CORNER_COUNTERCLOCKWISE
		if(turn(dir,-45) in dirs)
			. |= CORNER_CLOCKWISE
		ret[i] = "[.]"

	return ret

#undef CORNER_NONE
#undef CORNER_COUNTERCLOCKWISE
#undef CORNER_DIAGONAL
#undef CORNER_CLOCKWISE
*/


// bay walls end

//now the goon file
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


/obj/machinery/door/airlock/
	icon = 'goon/icons/obj/airlocks/public.dmi'
	icon_state = "closed"
	overlays_file = 'goon/icons/obj/airlocks/overlays.dmi'
	/*
	doorOpen = 'goon/sound/machinery/sound_machines_airlock_swoosh_temp.ogg'
	doorClose = 'ModularTegustation/Tegusounds/tegu_cool_airlocks/skyrat_airlock_sounds/close.ogg'
	doorDeni = 'goon/sound/machinery/sound_machines_airlock_deny.ogg' // i'm thinkin' Deni's
	*/
/obj/machinery/door/airlock/Initialize()
	. = ..()
	set_smooth_dir()


/*

This proc looks like it makes no sense. Bear with me...


Assuming:

X = wall
[] = airlock:


X
[]
X
odir = SOUTH / NORTH. We need it to face sideways so you can get through

X[]X
odir = EAST / WEST. We need it to face forwards so you can get through


*/

/obj/machinery/door/proc/set_smooth_dir() //I fucking hate this code and so should you :)
//	for(var/atom/obstacle in view(1, src)) //Ghetto ass icon smooth
	var/odir = 0
	var/atom/found = null
	var/turf/north = get_turf(get_step(src,NORTH))
	if(north.density)
		found = north
		odir = NORTH
	var/turf/south = get_turf(get_step(src,SOUTH))
	if(south.density)
		found = south
		odir = SOUTH
	var/turf/east = get_turf(get_step(src,EAST))
	if(east.density)
		found = east
		odir = EAST
	var/turf/west = get_turf(get_step(src,WEST))
	if(west.density)
		found = west
		odir = WEST
	if(!found)
		for(var/atom/foo in get_step(src,NORTH))
			if(foo?.density)
				found = foo
				odir = NORTH
				break
		for(var/atom/foo in get_step(src,SOUTH))
			if(foo?.density)
				found = foo
				odir = SOUTH
				break
		for(var/atom/foo in get_step(src,EAST))
			if(foo?.density)
				found = foo
				odir = EAST
				break
		for(var/atom/foo in get_step(src,WEST))
			if(foo?.density)
				found = foo
				odir = WEST
				break
	if(odir == NORTH || odir == SOUTH)
		dir = EAST
	else
		dir = SOUTH
	return odir

/obj/machinery/door/poddoor/shutters
	icon = 'goon/icons/obj/airlocks/shutters.dmi'

/obj/machinery/door/airlock/station
	name = "Standard airlock"
	icon = 'goon/icons/obj/airlocks/station.dmi'

/obj/machinery/door/airlock/station/glass
	name = "Standard airlock"
	icon = 'goon/icons/obj/airlocks/station_glass.dmi'
	density = FALSE
	opacity = 0

/obj/machinery/door/airlock/station/mining
	name = "Mining airlock"
	color = "#b88a3d"

/obj/machinery/door/airlock/station/research
	name = "Research airlock"

/obj/machinery/door/airlock/hatch
	name = "airtight hatch"
	icon = 'goon/icons/obj/airlocks/hatch.dmi'

/obj/machinery/door/poddoor
	name = "Double blast door"
	icon = 'goon/icons/obj/airlocks/blastdoor.dmi'

/obj/machinery/door/poddoor/preopen
	icon_state = "open"
	density = FALSE
	opacity = 0

/obj/machinery/door/airlock/command
	name = "Command"
	icon = 'goon/icons/obj/airlocks/command.dmi'

obj/machinery/door/poddoor/Initialize()
	. = ..()
	set_smooth_dir()

/obj/machinery/door/airlock/highsecurity
	icon = 'goon/icons/obj/airlocks/vault.dmi'

/obj/machinery/door/airlock/highsecurity/Initialize()
	. = ..()
	set_smooth_dir()

/obj/machinery/door/airlock/wood
	icon = 'goon/icons/obj/airlocks/airlock_wood.dmi'

/obj/machinery/door/airlock/command/glass
	icon = 'goon/icons/obj/airlocks/command_glass.dmi'
	opacity = 0
	glass = TRUE

/obj/machinery/door/airlock/vault/
	icon = 'goon/icons/obj/airlocks/vault.dmi'
	icon_state = "closed"

/obj/machinery/door/airlock/vault/Initialize()
	. = ..()
	set_smooth_dir()

/obj/machinery/door/airlock/engineering
	icon = 'goon/icons/obj/airlocks/engineering.dmi'

/obj/machinery/door/airlock/engineering/glass
	icon = 'goon/icons/obj/airlocks/engineering_glass.dmi'
	opacity = 0
	glass = TRUE

/obj/machinery/door/airlock/external
	name = "External airlock"
	icon = 'goon/icons/obj/airlocks/external.dmi'

/obj/machinery/door/airlock/external/glass
	name = "External airlock"
	icon = 'goon/icons/obj/airlocks/external.dmi'
	opacity = 0
	glass = TRUE

/obj/machinery/door/airlock/maintenance
	icon = 'goon/icons/obj/airlocks/maintenance.dmi'

/obj/machinery/door/airlock/public
	name = "Public airlock"
	icon = 'goon/icons/obj/airlocks/public.dmi'

/obj/machinery/door/airlock/public/glass
	icon = 'goon/icons/obj/airlocks/airlock_glass.dmi'
	overlays_file = 'goon/icons/obj/airlocks/overlays.dmi'
	opacity = 0
	glass = TRUE
/*
/obj/machinery/door/airlock/glass_large/ship
	icon = 'nsv13/icons/obj/machinery/doors/double.dmi'
	overlays_file = 'nsv13/icons/obj/machinery/doors/overlays_large.dmi'
*/
/obj/machinery/door/airlock/medical
	icon = 'goon/icons/obj/airlocks/medical.dmi'

/obj/machinery/door/airlock/security
	icon = 'goon/icons/obj/airlocks/security.dmi'

/obj/machinery/door/airlock/security/glass
	opacity = 0
	glass = TRUE

/obj/effect/turf_decal/solgov //Credit to baystation for these sprites!
	alpha = 230
	icon = 'whitesands/icons/obj/solgov_floor.dmi'
	icon_state = "center"

/obj/structure/sign/solgov_seal
	name = "Seal of the solarian government"
	desc = "A seal emblazened with a gold trim depicting the star, sol."
	icon = 'whitesands/icons/obj/solgov_logos.dmi'
	icon_state = "solgovseal"
	pixel_y = 27

/obj/structure/sign/solgov_flag
	name = "solgov banner"
	desc = "A large flag displaying the logo of solgov, the local government of the sol system."
	icon = 'whitesands/icons/obj/solgov_logos.dmi'
	icon_state = "solgovflag-left"
	pixel_y = 26

/obj/structure/sign/solgov_flag/right
	icon_state = "solgovflag-right"
