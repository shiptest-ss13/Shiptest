/turf/closed/wall/mineral
	name = "mineral wall"
	desc = "This shouldn't exist"
	icon_state = ""
	smoothing_flags = SMOOTH_BITMASK
	canSmoothWith = null
	var/last_event = 0
	var/active = null

	hitsound_type = PROJECTILE_HITSOUND_METAL

/turf/closed/wall/mineral/gold
	name = "gold wall"
	desc = "A wall with gold plating. Swag!"
	icon = 'icons/turf/walls/gold_wall.dmi'
	icon_state = "gold_wall-0"
	base_icon_state = "gold_wall"
	sheet_type = /obj/item/stack/sheet/mineral/gold
	explosion_block = 0 //gold is a soft metal you dingus.
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_CONNECTORS
	smoothing_groups = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_WALLS, SMOOTH_GROUP_GOLD_WALLS)
	canSmoothWith = list(SMOOTH_GROUP_GOLD_WALLS, SMOOTH_GROUP_WALLS,SMOOTH_GROUP_AIRLOCK)
	connector_icon = 'icons/turf/connectors/gold_wall_connector.dmi'
	connector_icon_state = "gold_wall_connector"
	no_connector_typecache = list(/turf/closed/wall/mineral/gold, /obj/structure/falsewall/gold)
	max_integrity = 150
	brute_mod = 1.5

/turf/closed/wall/mineral/gold/yesdiag
	icon_state = "gold_wall-255"
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_DIAGONAL_CORNERS

/turf/closed/wall/mineral/silver
	name = "silver wall"
	desc = "A wall with silver plating. Shiny!"
	icon = 'icons/turf/walls/silver_wall.dmi'
	icon_state = "silver_wall-0"
	base_icon_state = "silver_wall"
	sheet_type = /obj/item/stack/sheet/mineral/silver
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_CONNECTORS
	smoothing_groups = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_WALLS, SMOOTH_GROUP_SILVER_WALLS)
	canSmoothWith = list(SMOOTH_GROUP_SILVER_WALLS, SMOOTH_GROUP_WALLS,SMOOTH_GROUP_AIRLOCK)
	connector_icon = 'icons/turf/connectors/silver_wall_connector.dmi'
	connector_icon_state = "silver_wall_connector"
	no_connector_typecache = list(/turf/closed/wall/mineral/silver, /obj/structure/falsewall/silver)
	max_integrity = 150
	brute_mod = 1.5

/turf/closed/wall/mineral/silver/yesdiag
	icon_state = "silver_wall-255"
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_DIAGONAL_CORNERS

/turf/closed/wall/mineral/diamond
	name = "diamond wall"
	desc = "A wall with diamond plating. You monster."
	icon = 'icons/turf/walls/diamond_wall.dmi'
	icon_state = "diamond_wall-0"
	base_icon_state = "diamond_wall"
	sheet_type = /obj/item/stack/sheet/mineral/diamond
	breakdown_duration = 50
	explosion_block = 3
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_CONNECTORS
	smoothing_groups = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_WALLS, SMOOTH_GROUP_DIAMOND_WALLS)
	canSmoothWith = list(SMOOTH_GROUP_DIAMOND_WALLS, SMOOTH_GROUP_WALLS,SMOOTH_GROUP_AIRLOCK)
	connector_icon = 'icons/turf/connectors/diamond_wall_connector.dmi'
	connector_icon_state = "diamond_wall_connector"
	no_connector_typecache = list(/turf/closed/wall/mineral/diamond, /obj/structure/falsewall/diamond)

	hitsound_type = PROJECTILE_HITSOUND_GLASS
	max_integrity = 800

/turf/closed/wall/mineral/diamond/yesdiag
	icon_state = "diamond_wall-255"
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_DIAGONAL_CORNERS

/turf/closed/wall/mineral/sandstone
	name = "sandstone wall"
	desc = "A wall with sandstone plating. Rough."
	icon = 'icons/turf/walls/sandstone_wall.dmi'
	icon_state = "sandstone_wall-0"
	base_icon_state = "sandstone_wall"
	sheet_type = /obj/item/stack/sheet/mineral/sandstone
	explosion_block = 0
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_CONNECTORS
	smoothing_groups = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_WALLS, SMOOTH_GROUP_SANDSTONE_WALLS)
	canSmoothWith = list(SMOOTH_GROUP_SANDSTONE_WALLS, SMOOTH_GROUP_WALLS,SMOOTH_GROUP_AIRLOCK)
	connector_icon = 'icons/turf/connectors/sandstone_wall_connector.dmi'
	connector_icon_state = "sandstone_wall_connector"
	no_connector_typecache = list(/turf/closed/wall/mineral/sandstone, /obj/structure/falsewall/sandstone)

	hitsound_type = PROJECTILE_HITSOUND_NON_LIVING
	max_integrity = 150
	min_dam = 5

/turf/closed/wall/mineral/sandstone/yesdiag
	icon_state = "sandstone_wall-255"
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_DIAGONAL_CORNERS

/turf/closed/wall/mineral/uranium
	article = "a"
	name = "uranium wall"
	desc = "A wall with uranium plating. This is probably a bad idea."
	icon = 'icons/turf/walls/uranium_wall.dmi'
	icon_state = "uranium_wall-0"
	base_icon_state = "uranium_wall"
	sheet_type = /obj/item/stack/sheet/mineral/uranium
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_CONNECTORS
	smoothing_groups = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_WALLS, SMOOTH_GROUP_URANIUM_WALLS)
	canSmoothWith = list(SMOOTH_GROUP_URANIUM_WALLS, SMOOTH_GROUP_WALLS,SMOOTH_GROUP_AIRLOCK)
	connector_icon = 'icons/turf/connectors/uranium_wall_connector.dmi'
	connector_icon_state = "uranium_wall_connector"
	no_connector_typecache = list(/turf/closed/wall/mineral/uranium, /obj/structure/falsewall/uranium)
	max_integrity = 600

/turf/closed/wall/mineral/uranium/yesdiag
	icon_state = "uranium_wall-255"
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_DIAGONAL_CORNERS

/turf/closed/wall/mineral/uranium/proc/radiate()
	if(!active)
		if(world.time > last_event+15)
			active = 1
			radiation_pulse(src, 40)
			for(var/turf/closed/wall/mineral/uranium/T in orange(1,src))
				T.radiate()
			last_event = world.time
			active = null
			return
	return

/turf/closed/wall/mineral/uranium/attack_hand(mob/user)
	radiate()
	. = ..()

/turf/closed/wall/mineral/uranium/attackby(obj/item/W, mob/user, params)
	radiate()
	..()

/turf/closed/wall/mineral/uranium/Bumped(atom/movable/AM)
	radiate()
	..()

/turf/closed/wall/mineral/uranium/safe
	article = "a"
	name = "wall"
	desc = "A wall with uranium plating. Seems completely safe."
	icon = 'icons/turf/walls/uranium_wall.dmi'
	icon_state = "uranium_wall-0"
	base_icon_state = "uranium_wall"
	sheet_type = /obj/item/stack/sheet/mineral/uranium
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_CONNECTORS
	smoothing_groups = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_WALLS, SMOOTH_GROUP_URANIUM_WALLS)
	canSmoothWith = list(SMOOTH_GROUP_URANIUM_WALLS, SMOOTH_GROUP_WALLS,SMOOTH_GROUP_AIRLOCK)
	connector_icon = 'icons/turf/connectors/uranium_wall_connector.dmi'
	connector_icon_state = "uranium_wall_connector"
	no_connector_typecache = list(/turf/closed/wall/mineral/uranium, /obj/structure/falsewall/uranium)

/turf/closed/wall/mineral/uranium/safe/radiate()
	return

/turf/closed/wall/mineral/uranium/safe/yesdiag
	icon_state = "uranium_wall-255"
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_DIAGONAL_CORNERS

/turf/closed/wall/mineral/plasma
	name = "plasma wall"
	desc = "A wall with plasma plating. This is definitely a bad idea."
	icon = 'icons/turf/walls/plasma_wall.dmi'
	icon_state = "plasma_wall-0"
	base_icon_state = "plasma_wall"
	sheet_type = /obj/item/stack/sheet/mineral/plasma
	thermal_conductivity = 0.04
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_CONNECTORS
	smoothing_groups = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_WALLS, SMOOTH_GROUP_PLASMA_WALLS)
	canSmoothWith = list(SMOOTH_GROUP_PLASMA_WALLS, SMOOTH_GROUP_WALLS,SMOOTH_GROUP_AIRLOCK)
	connector_icon = 'icons/turf/connectors/plasma_wall_connector.dmi'
	connector_icon_state = "plasma_wall_connector"
	no_connector_typecache = list(/turf/closed/wall/mineral/plasma, /obj/structure/falsewall/plasma)

	hitsound_type = PROJECTILE_HITSOUND_GLASS
	max_integrity = 300
	burn_mod = 3

/turf/closed/wall/mineral/plasma/yesdiag
	icon_state = "plasma_wall-255"
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_DIAGONAL_CORNERS

/turf/closed/wall/mineral/plasma/attackby(obj/item/W, mob/user, params)
	if(W.get_temperature() > 300)//If the temperature of the object is over 300, then ignite
		message_admins("Plasma wall ignited by [ADMIN_LOOKUPFLW(user)] in [ADMIN_VERBOSEJMP(src)]")
		log_game("Plasma wall ignited by [key_name(user)] in [AREACOORD(src)]")
		ignite(W.get_temperature())
		return
	..()

/turf/closed/wall/mineral/plasma/proc/PlasmaBurn(temperature)
	create_girder()
	ScrapeAway()
	var/turf/open/T = src
	T.atmos_spawn_air("plasma=400;TEMP=[temperature]")

/turf/closed/wall/mineral/plasma/temperature_expose(datum/gas_mixture/air, exposed_temperature, exposed_volume)//Doesn't fucking work because walls don't interact with air :(
	if(exposed_temperature > 300)
		PlasmaBurn(exposed_temperature)

/turf/closed/wall/mineral/plasma/proc/ignite(exposed_temperature)
	if(exposed_temperature > 300)
		PlasmaBurn(exposed_temperature)

/turf/closed/wall/mineral/plasma/bullet_act(obj/projectile/Proj)
	if(istype(Proj, /obj/projectile/beam))
		PlasmaBurn(2500)
	else if(istype(Proj, /obj/projectile/ion))
		PlasmaBurn(500)
	. = ..()

/turf/closed/wall/mineral/wood
	name = "wooden wall"
	desc = "A wall with wooden plating. Stiff."
	icon = 'icons/turf/walls/wood_wall.dmi'
	icon_state = "wood_wall-0"
	base_icon_state = "wood_wall"
	sheet_type = /obj/item/stack/sheet/mineral/wood
	hardness = 70
	explosion_block = 0
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_CONNECTORS
	smoothing_groups = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_WALLS, SMOOTH_GROUP_WOOD_WALLS)
	canSmoothWith = list(SMOOTH_GROUP_WOOD_WALLS, SMOOTH_GROUP_WALLS,SMOOTH_GROUP_AIRLOCK)
	connector_icon = 'icons/turf/connectors/wood_wall_connector.dmi'
	connector_icon_state = "wood_wall_connector"
	no_connector_typecache = list(/turf/closed/wall/mineral/wood, /obj/structure/falsewall/wood)

	hitsound_type = PROJECTILE_HITSOUND_WOOD
	max_integrity = 75
	burn_mod = 3
	min_dam = 3

/turf/closed/wall/mineral/wood/yesdiag
	icon_state = "wood_wall-255"
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_DIAGONAL_CORNERS | SMOOTH_CONNECTORS


/turf/closed/wall/mineral/wood/attackby(obj/item/W, mob/user)
	if(W.get_sharpness() && W.force)
		var/duration = (48/W.force) * 2 //In seconds, for now.
		if(istype(W, /obj/item/hatchet) || istype(W, /obj/item/melee/axe/fire))
			duration /= 4 //Much better with hatchets and axes.
		if(do_after(user, duration*10, target=src)) //Into deciseconds.
			dismantle_wall(devastated = FALSE)
			return
	return ..()

/turf/closed/wall/mineral/wood/nonmetal
	desc = "A solidly wooden wall. It's a bit weaker than a wall made with metal."
	girder_type = /obj/structure/barricade/wooden
	hardness = 50

/turf/closed/wall/mineral/wood/nonmetal/yesdiag
	icon_state = "wood_wall-255"
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_DIAGONAL_CORNERS

/turf/closed/wall/mineral/iron
	name = "rough metal wall"
	desc = "A wall with rough metal plating."
	icon = 'icons/turf/walls/iron_wall.dmi'
	icon_state = "iron_wall-0"
	base_icon_state = "iron_wall"
	sheet_type = /obj/item/stack/rods
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_CONNECTORS
	smoothing_groups = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_WALLS, SMOOTH_GROUP_IRON_WALLS)
	canSmoothWith = list(SMOOTH_GROUP_IRON_WALLS, SMOOTH_GROUP_WALLS,SMOOTH_GROUP_AIRLOCK)
	connector_icon = 'icons/turf/connectors/iron_wall_connector.dmi'
	connector_icon_state = "iron_wall_connector"
	no_connector_typecache = list(/turf/closed/wall/mineral/iron, /obj/structure/falsewall/iron)

	max_integrity = 300

/turf/closed/wall/mineral/iron/yesdiag
	icon_state = "iron_wall-255"
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_DIAGONAL_CORNERS

/turf/closed/wall/mineral/snow
	name = "packed snow wall"
	desc = "A wall made of densely packed snow blocks."
	icon = 'icons/turf/walls/snow_wall.dmi'
	icon_state = "snow_wall-0"
	base_icon_state = "snow_wall"
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_CONNECTORS
	smoothing_groups = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_WALLS, SMOOTH_GROUP_SNOW_WALLS)
	canSmoothWith = list(SMOOTH_GROUP_SNOW_WALLS,SMOOTH_GROUP_AIRLOCK)
	connector_icon = 'icons/turf/connectors/snow_wall_connector.dmi'
	connector_icon_state = "snow_wall_connector"
	no_connector_typecache = list(/turf/closed/wall/mineral/snow)
	hardness = 80
	explosion_block = 0
	breakdown_duration = 30
	sheet_type = /obj/item/stack/sheet/mineral/snow
	canSmoothWith = null
	girder_type = null
	bullet_sizzle = TRUE
	bullet_bounce_sound = null

	hitsound_type = PROJECTILE_HITSOUND_SNOW

	max_integrity = 50
	burn_mod = 3
	brute_mod = 1.5
	min_dam = 1

/turf/closed/wall/mineral/snow/yesdiag
	icon_state = "snow_wall-255"
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_DIAGONAL_CORNERS

/turf/closed/wall/mineral/abductor
	name = "alien wall"
	desc = "A wall with alien alloy plating."
	icon = 'icons/turf/walls/abductor_wall.dmi'
	icon_state = "abductor_wall-0"
	base_icon_state = "abductor_wall"
	sheet_type = /obj/item/stack/sheet/mineral/abductor
	breakdown_duration = 100   //alien wall takes twice as much time to slice
	explosion_block = 3
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_DIAGONAL_CORNERS
	smoothing_groups = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_WALLS, SMOOTH_GROUP_ABDUCTOR_WALLS)
	canSmoothWith = list(SMOOTH_GROUP_ABDUCTOR_WALLS,SMOOTH_GROUP_AIRLOCK)

	max_integrity = 1000

/////////////////////Titanium walls/////////////////////

/turf/closed/wall/mineral/titanium //has to use this path due to how building walls works
	name = "wall"
	desc = "A light-weight titanium wall used in shuttles."
	icon = 'icons/turf/walls/shuttle_wall.dmi'
	icon_state = "shuttle_wall-0"
	base_icon_state = "shuttle_wall"
	explosion_block = 3
	flags_1 = CAN_BE_DIRTY_1
	flags_ricochet = RICOCHET_SHINY | RICOCHET_HARD
	sheet_type = /obj/item/stack/sheet/mineral/titanium
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_DIAGONAL_CORNERS
	smoothing_groups = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_WALLS, SMOOTH_GROUP_TITANIUM_WALLS)
	canSmoothWith = list(SMOOTH_GROUP_TITANIUM_WALLS, SMOOTH_GROUP_AIRLOCK, SMOOTH_GROUP_SHUTTLE_PARTS, SMOOTH_GROUP_WALLS, SMOOTH_GROUP_WINDOW_FULLTILE)

	hitsound_type = PROJECTILE_HITSOUND_NON_LIVING

	max_integrity = 450

/turf/closed/wall/mineral/titanium/exterior
	smoothing_groups = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_WALLS, SMOOTH_GROUP_TITANIUM_WALLS_EXTERIOR)
	canSmoothWith = list(SMOOTH_GROUP_TITANIUM_WALLS_EXTERIOR, SMOOTH_GROUP_AIRLOCK, SMOOTH_GROUP_SHUTTLE_PARTS, SMOOTH_GROUP_WALLS, SMOOTH_GROUP_WINDOW_FULLTILE)

/turf/closed/wall/mineral/titanium/nodiagonal
	icon = 'icons/turf/walls/shuttle_wall.dmi'
	icon_state = "map-shuttle_nd"
	base_icon_state = "shuttle_wall"
	smoothing_flags = SMOOTH_BITMASK

/turf/closed/wall/mineral/titanium/nosmooth
	icon = 'icons/turf/shuttle.dmi'
	icon_state = "wall"
	smoothing_flags = NONE

/turf/closed/wall/mineral/titanium/overspace
	icon_state = "map-overspace"
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_DIAGONAL_CORNERS
	fixed_underlay = list("space" = TRUE)

//sub-type to be used for interior shuttle walls
//won't get an underlay of the destination turf on shuttle move
/turf/closed/wall/mineral/titanium/interior/copyTurf(turf/T, copy_air, flags)
	if(T.type != type)
		T.ChangeTurf(type, null, flags)
		if(underlays.len)
			T.underlays = underlays
	if(T.icon_state != icon_state)
		T.icon_state = icon_state
	if(T.icon != icon)
		T.icon = icon
	if(color)
		T.atom_colours = atom_colours.Copy()
		T.update_atom_colour()
	if(T.dir != dir)
		T.setDir(dir)
	T.transform = transform
	return T

/turf/closed/wall/mineral/titanium/copyTurf(turf/T)
	. = ..()
	T.transform = transform

/turf/closed/wall/mineral/titanium/survival
	name = "pod wall"
	desc = "An easily-compressable wall used for temporary shelter."
	icon = 'icons/turf/walls/survival_pod_walls.dmi'
	icon_state = "survival_pod_walls-0"
	base_icon_state = "survival_pod_walls"
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_DIAGONAL_CORNERS
	canSmoothWith = list(SMOOTH_GROUP_TITANIUM_WALLS, SMOOTH_GROUP_AIRLOCK, SMOOTH_GROUP_WINDOW_FULLTILE, SMOOTH_GROUP_SHUTTLE_PARTS, SMOOTH_GROUP_WALLS, SMOOTH_GROUP_WINDOW_FULLTILE)

/turf/closed/wall/mineral/titanium/survival/nodiagonal
	icon = 'icons/turf/walls/survival_pod_walls.dmi'
	icon_state = "survival_pod_walls-0"
	base_icon_state = "survival_pod_walls"
	smoothing_flags = SMOOTH_BITMASK

/turf/closed/wall/mineral/titanium/survival/pod
	smoothing_groups = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_WALLS, SMOOTH_GROUP_TITANIUM_WALLS, SMOOTH_GROUP_SURVIVAL_TIANIUM_POD)
	canSmoothWith = list(SMOOTH_GROUP_SURVIVAL_TIANIUM_POD)

/////////////////////Plastitanium walls/////////////////////

/turf/closed/wall/mineral/plastitanium
	name = "wall"
	desc = "A durable wall made of an alloy of plasma and titanium."
	icon = 'icons/turf/walls/plastitanium_wall.dmi'
	icon_state = "plastitanium_wall-0"
	base_icon_state = "plastitanium_wall"
	explosion_block = 4
	sheet_type = /obj/item/stack/sheet/mineral/plastitanium
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_DIAGONAL_CORNERS
	smoothing_groups = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_WALLS, SMOOTH_GROUP_PLASTITANIUM_WALLS)
	canSmoothWith = list(SMOOTH_GROUP_PLASTITANIUM_WALLS, SMOOTH_GROUP_AIRLOCK, SMOOTH_GROUP_SHUTTLE_PARTS, SMOOTH_GROUP_WALLS, SMOOTH_GROUP_WINDOW_FULLTILE)

	hitsound_type = PROJECTILE_HITSOUND_NON_LIVING

	max_integrity = 500

/turf/closed/wall/mineral/plastitanium/nodiagonal
	icon = 'icons/turf/walls/plastitanium_wall.dmi'
	icon_state = "map-shuttle_nd"
	base_icon_state = "plastitanium_wall"
	smoothing_flags = SMOOTH_BITMASK

/turf/closed/wall/mineral/plastitanium/nosmooth
	icon = 'icons/turf/shuttle.dmi'
	icon_state = "wall"
	smoothing_flags = NONE

/turf/closed/wall/mineral/plastitanium/overspace
	icon_state = "map-overspace"
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_DIAGONAL_CORNERS
	fixed_underlay = list("space" = TRUE)


/turf/closed/wall/mineral/plastitanium/explosive/ex_act(severity)
	var/obj/item/bombcore/large/bombcore = new(get_turf(src))
	bombcore.detonate()
	..()

//have to copypaste this code
/turf/closed/wall/mineral/plastitanium/interior/copyTurf(turf/T, copy_air, flags)
	if(T.type != type)
		T.ChangeTurf(type, null, flags)
		if(underlays.len)
			T.underlays = underlays
	if(T.icon_state != icon_state)
		T.icon_state = icon_state
	if(T.icon != icon)
		T.icon = icon
	if(color)
		T.atom_colours = atom_colours.Copy()
		T.update_atom_colour()
	if(T.dir != dir)
		T.setDir(dir)
	T.transform = transform
	return T

/turf/closed/wall/mineral/plastitanium/copyTurf(turf/T)
	. = ..()
	T.transform = transform
