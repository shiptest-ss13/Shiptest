/* OVERMAP TURFS */
/turf/open/overmap
	icon = 'whitesands/icons/turf/overmap.dmi'
	icon_state = "overmap"
	initial_gas_mix = AIRLESS_ATMOS

/turf/open/overmap/edge
	opacity = 1
	density = 1

//this is completely unnecessary but it looks nice
/turf/open/overmap/Initialize()
	. = ..()
	name = "[x]-[y]"
	var/list/numbers = list()

	if(x == 1 || x == SSovermap.size)
		numbers += list("[round(y/10)]","[round(y%10)]")
		if(y == 1 || y == SSovermap.size)
			numbers += "-"
	if(y == 1 || y == SSovermap.size)
		numbers += list("[round(x/10)]","[round(x%10)]")

	for(var/i = 1 to numbers.len)
		var/image/I = image('whitesands/icons/effects/numbers.dmi',numbers[i])
		I.pixel_x = 5*i - 2
		I.pixel_y = world.icon_size/2 - 3
		if(y == 1)
			I.pixel_y = 3
			I.pixel_x = 5*i + 4
		if(y == SSovermap.size)
			I.pixel_y = world.icon_size - 9
			I.pixel_x = 5*i + 4
		if(x == 1)
			I.pixel_x = 5*i - 2
		if(x == SSovermap.size)
			I.pixel_x = 5*i + 2
		overlays += I

/** # Overmap area
  * Area that all overmap objects will spawn in at roundstart.
  */
/area/overmap
	name = "Overmap"
	icon_state = "yellow"
	requires_power = FALSE
	area_flags = NOTELEPORT
	flags_1 = NONE

/**
  * # Overmap objects
  *
  * Everything visible on the overmap: stations, ships, ruins, events, and more.
  *
  * This base class should be the parent of all objects present on the overmap.
  * For the control counterparts, see [/obj/machinery/computer/helm].
  * For the shuttle counterparts (ONLY USED FOR SHIPS), see [/obj/docking_port/mobile].
  *
  */
/obj/structure/overmap
	name = "overmap object"
	desc = "An unknown celestial object."
	icon = 'whitesands/icons/effects/overmap.dmi'
	icon_state = "object"

	///~~If we need to render a map for cameras and helms for this object~~ basically can you look at and use this as a ship or station
	var/render_map = FALSE
	///The range of the view shown to helms and viewscreens (subject to be relegated to something else)
	var/sensor_range = 4
	///Integrity percentage, do NOT modify. Use [/obj/structure/overmap/proc/receive_damage] instead.
	var/integrity = 100
	///Armor value, reduces integrity damage taken
	var/overmap_armor = 1
	///List of other overmap objects in the same tile
	var/list/close_overmap_objects
	///Vessel approximate mass
	var/mass

	// Stuff needed to render the map
	var/map_name
	var/atom/movable/screen/map_view/cam_screen
	var/atom/movable/screen/plane_master/lighting/cam_plane_master
	var/atom/movable/screen/background/cam_background

/obj/structure/overmap/Initialize(mapload)
	. = ..()
	SSovermap.overmap_objects += src
	if(render_map)	// Initialize map objects
		map_name = "overmap_[REF(src)]_map"
		cam_screen = new
		cam_screen.name = "screen"
		cam_screen.assigned_map = map_name
		cam_screen.del_on_map_removal = FALSE
		cam_screen.screen_loc = "[map_name]:1,1"
		cam_plane_master = new
		cam_plane_master.name = "plane_master"
		cam_plane_master.assigned_map = map_name
		cam_plane_master.del_on_map_removal = FALSE
		cam_plane_master.screen_loc = "[map_name]:CENTER"
		cam_background = new
		cam_background.assigned_map = map_name
		cam_background.del_on_map_removal = FALSE
		update_screen()

/obj/structure/overmap/Destroy()
	. = ..()
	for(var/obj/structure/overmap/O as anything in close_overmap_objects)
		LAZYREMOVE(O.close_overmap_objects, src)
	SSovermap.overmap_objects -= src
	if(render_map)
		QDEL_NULL(cam_screen)
		QDEL_NULL(cam_plane_master)
		QDEL_NULL(cam_background)

/**
  * Done to ensure the connected helms are updated appropriately
  */
/obj/structure/overmap/Move(atom/newloc, direct)
	. = ..()
	update_screen()

/**
  * Updates the screen object, which is displayed on all connected helms
  */
/obj/structure/overmap/proc/update_screen()
	if(render_map)
		var/list/visible_turfs = list()
		for(var/turf/T in view(sensor_range, get_turf(src)))
			visible_turfs += T

		var/list/bbox = get_bbox_of_atoms(visible_turfs)
		var/size_x = bbox[3] - bbox[1] + 1
		var/size_y = bbox[4] - bbox[2] + 1

		cam_screen?.vis_contents = visible_turfs
		cam_background.icon_state = "clear"
		cam_background.fill_rect(1, 1, size_x, size_y)
		return TRUE

/**
  * When something crosses another overmap object, add it to the nearby objects list, which are used by events and docking
  */
/obj/structure/overmap/Crossed(atom/movable/AM, oldloc)
	. = ..()
	if(istype(loc, /turf/) && istype(AM, /obj/structure/overmap))
		var/obj/structure/overmap/other = AM
		if(other == src)
			return
		LAZYOR(other.close_overmap_objects, src)
		LAZYOR(close_overmap_objects, other)

/**
  * See [/obj/structure/overmap/Crossed]
  */
/obj/structure/overmap/Uncrossed(atom/movable/AM, atom/newloc)
	. = ..()
	if(istype(loc, /turf/) && istype(AM, /obj/structure/overmap))
		var/obj/structure/overmap/other = AM
		if(other == src)
			return
		LAZYREMOVE(other.close_overmap_objects, src)
		LAZYREMOVE(close_overmap_objects, other)

/**
  * Reduces overmap object integrity by X amount, divided by armor
  * * amount - amount of damage to apply to the ship
  */
/obj/structure/overmap/proc/recieve_damage(amount)
	integrity = max(integrity - (amount / overmap_armor), 0)

/**
  * The action performed by a ship on this when the helm button is pressed. Returns nothing on success, an error string if one occurs.
  * * acting - The ship acting on the event
  */
/obj/structure/overmap/proc/ship_act(mob/user, obj/structure/overmap/ship/simulated/acting)
	return "Unknown error!"

/obj/structure/overmap/star
	name = "Star"
	desc = "A star."
	icon = 'whitesands/icons/effects/overmap.dmi'
	icon_state = "star1"
	var/class //what kind of star will you be?
	var/star_classes = list(\
		STARK,
		STARM,
		STARL,
		START,
		STARY,
		STARD
	)

/obj/structure/overmap/star/Initialize(mapload)
	. = ..()
	name = "[pick(GLOB.star_names)] [pick(GLOB.greek_letters)]"
	class = pick(star_classes)
	var/c = "#ffffff"
	if(class == STARO)
		c = "#75ffff"
		desc = "A blue giant"
	if(class == STARB)
		c = "#c0ffff"
	if(class == STARG)
		c = "#ffff00"
	if(class == STARK)
		c = "#ff7f00"
	if(class == STARM)
		c = "#d50000"
	if(class == STARL) //Take the L
		c = "#a31300"
	if(class == START)
		c = "#a60347"
		desc = "A brown dwarf"
	if(class == STARY)
		c = "#4a3059"
		desc = "A brown dwarf"
	if(class == STARD)
		c = pick("#75ffff", "#c0ffff", "#ffffff")
		desc = "A white dwarf"
	add_atom_colour(c, FIXED_COLOUR_PRIORITY)

/obj/structure/overmap/star/medium
	icon = 'whitesands/icons/effects/overmap_large.dmi'
	bound_height = 64
	bound_width = 64
	pixel_x = -16
	pixel_y = -16
	icon_state = "star2"
	star_classes = list(\
		STARB,
		STARA,
		STARF,
		STARG,
		STARK
	)

/obj/structure/overmap/star/big
	icon = 'whitesands/icons/effects/overmap_larger.dmi'
	icon_state = "star3"
	bound_height = 96
	bound_width = 96
	pixel_z = -32
	pixel_w = -32
	star_classes = list(\
		STARO,
		STARB,
		STARG,
		STARM
	)

/obj/structure/overmap/star/big/binary
	icon_state = "binaryswoosh"
	var/class2 //because this one has two!
	star_classes = list(\
		STARK,
		STARM,
		STARL,
		START,
		STARY,
		STARD
	)

/obj/structure/overmap/star/big/binary/Initialize(mapload)
	. = ..()
	name = "[pick(GLOB.greek_letters)] [pick(GLOB.star_names)] AB"
	class = pick(star_classes)
	color = "#ffffff"
	add_star_overlay()

/obj/structure/overmap/star/big/binary/proc/add_star_overlay()
	cut_overlays()
	var/mutable_appearance/s1 = mutable_appearance(icon_state = "binary1")
	var/mutable_appearance/s2 = mutable_appearance(icon_state = "binary2")
	if(class == STARK)
		s1.color = "#ff7f00"
		s2.color = "#ffff00"
	if(class == STARM)
		s1.color = "#d50000"
		s2.color = "#a31300"
	if(class == STARL)
		s1.color = "#a31300"
		s2.color = "#ff7f00"
	if(class == START)
		s1.color = "#a60347"
		s2.color = pick("#75ffff", "#c0ffff", "#ffffff")
	if(class == STARY)
		s1.color = "#4a3059"
		s2.color = pick("#75ffff", "#c0ffff", "#ffffff")
	if(class == STARD)
		s1.color = pick("#75ffff", "#c0ffff", "#ffffff")
		s2.color = pick("#4a3059", "#a60347", "#a31300")
	add_overlay(s1)
	add_overlay(s2)
