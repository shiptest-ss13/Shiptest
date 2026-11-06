/*

id = list(
list(sounds),
base volume,
extra range addition
)


*/

//default (shoe) footstep sounds
GLOBAL_LIST_INIT(footstep_default, list(
	FOOTSTEP_WOOD = list(list(
		'sound/effects/footstep/wood1.ogg',
		'sound/effects/footstep/wood2.ogg',
		'sound/effects/footstep/wood3.ogg',
		'sound/effects/footstep/wood4.ogg',
		'sound/effects/footstep/wood5.ogg'), 100, 0),
	FOOTSTEP_FLOOR = list(list(
		'sound/effects/footstep/floor1.ogg',
		'sound/effects/footstep/floor2.ogg',
		'sound/effects/footstep/floor3.ogg',
		'sound/effects/footstep/floor4.ogg',
		'sound/effects/footstep/floor5.ogg'), 75, -1),
	FOOTSTEP_PLATING = list(list(
		'sound/effects/footstep/plating1.ogg',
		'sound/effects/footstep/plating2.ogg',
		'sound/effects/footstep/plating3.ogg',
		'sound/effects/footstep/plating4.ogg',
		'sound/effects/footstep/plating5.ogg'), 100, 1),
	FOOTSTEP_CARPET = list(list(
		'sound/effects/footstep/carpet1.ogg',
		'sound/effects/footstep/carpet2.ogg',
		'sound/effects/footstep/carpet3.ogg',
		'sound/effects/footstep/carpet4.ogg',
		'sound/effects/footstep/carpet5.ogg'), 75, -1),
	FOOTSTEP_ASTEROID = list(list(
		'sound/effects/footstep/asteroid1.ogg',
		'sound/effects/footstep/asteroid2.ogg',
		'sound/effects/footstep/asteroid3.ogg',
		'sound/effects/footstep/asteroid4.ogg',
		'sound/effects/footstep/asteroid5.ogg'), 75, 0),
	FOOTSTEP_GRASS = list(list(
		'sound/effects/footstep/grass1.ogg',
		'sound/effects/footstep/grass2.ogg',
		'sound/effects/footstep/grass3.ogg',
		'sound/effects/footstep/grass4.ogg'), 75, 0),
	FOOTSTEP_WATER = list(list(
		'sound/effects/footstep/water1.ogg',
		'sound/effects/footstep/water2.ogg',
		'sound/effects/footstep/water3.ogg',
		'sound/effects/footstep/water4.ogg'), 100, 1),
	FOOTSTEP_LAVA = list(list(
		'sound/effects/footstep/lava1.ogg',
		'sound/effects/footstep/lava2.ogg',
		'sound/effects/footstep/lava3.ogg'), 100, 0),
	FOOTSTEP_MEAT = list(list(
		'sound/effects/meatslap.ogg'), 100, 0),
	FOOTSTEP_CATWALK = list(list(
		'sound/effects/footstep/catwalk1.ogg',
		'sound/effects/footstep/catwalk2.ogg',
		'sound/effects/footstep/catwalk3.ogg',
		'sound/effects/footstep/catwalk4.ogg',
		'sound/effects/footstep/catwalk5.ogg'), 100, 1),
	FOOTSTEP_SNOW = list(list(
		'sound/effects/footstep/snow1.ogg',
		'sound/effects/footstep/snow2.ogg',
		'sound/effects/footstep/snow3.ogg',
		'sound/effects/footstep/snow4.ogg',
		'sound/effects/footstep/snow5.ogg'), 100, 1),
	FOOTSTEP_ICE = list(list(
		'sound/effects/footstep/ice1.ogg',
		'sound/effects/footstep/ice2.ogg',
		'sound/effects/footstep/ice3.ogg',
		'sound/effects/footstep/ice4.ogg',
		'sound/effects/footstep/ice5.ogg'), 60, 1),
	FOOTSTEP_CONCRETE = list(list(
		'sound/effects/footstep/concrete1.ogg',
		'sound/effects/footstep/concrete2.ogg',
		'sound/effects/footstep/concrete3.ogg',
		'sound/effects/footstep/concrete4.ogg',
		'sound/effects/footstep/concrete5.ogg'), 100, 1),
	FOOTSTEP_SAND = list(list(
		'sound/effects/footstep/sand1.ogg',
		'sound/effects/footstep/sand2.ogg',
		'sound/effects/footstep/sand3.ogg',
		'sound/effects/footstep/sand4.ogg'), 75, 0),
	FOOTSTEP_MUD = list(list(
		'sound/effects/footstep/mud1.ogg',
		'sound/effects/footstep/mud2.ogg',
		'sound/effects/footstep/mud3.ogg',
		'sound/effects/footstep/mud4.ogg'), 100, 1),
))

GLOBAL_LIST_INIT(footstep_overrides, list(
	FOOTSTEP_MOB_BAREFOOT = list(
		FOOTSTEP_WOOD = list(list(
			'sound/effects/footstep/woodbarefoot1.ogg',
			'sound/effects/footstep/woodbarefoot2.ogg',
			'sound/effects/footstep/woodbarefoot3.ogg',
			'sound/effects/footstep/woodbarefoot4.ogg',
			'sound/effects/footstep/woodbarefoot5.ogg'), 80, -1),
		FOOTSTEP_FLOOR = list(list(
			'sound/effects/footstep/hardbarefoot1.ogg',
			'sound/effects/footstep/hardbarefoot2.ogg',
			'sound/effects/footstep/hardbarefoot3.ogg',
			'sound/effects/footstep/hardbarefoot4.ogg',
			'sound/effects/footstep/hardbarefoot5.ogg'), 80, -1),
		FOOTSTEP_PLATING = list(list(
			'sound/effects/footstep/hardbarefoot1.ogg',
			'sound/effects/footstep/hardbarefoot2.ogg',
			'sound/effects/footstep/hardbarefoot3.ogg',
			'sound/effects/footstep/hardbarefoot4.ogg',
			'sound/effects/footstep/hardbarefoot5.ogg'), 80, -1),
		FOOTSTEP_CARPET = list(list(
			'sound/effects/footstep/carpetbarefoot1.ogg',
			'sound/effects/footstep/carpetbarefoot2.ogg',
			'sound/effects/footstep/carpetbarefoot3.ogg',
			'sound/effects/footstep/carpetbarefoot4.ogg',
			'sound/effects/footstep/carpetbarefoot5.ogg'), 75, -2),
		FOOTSTEP_CATWALK = list(list(
			'sound/effects/footstep/hardbarefoot1.ogg',
			'sound/effects/footstep/hardbarefoot2.ogg',
			'sound/effects/footstep/hardbarefoot3.ogg',
			'sound/effects/footstep/hardbarefoot4.ogg',
			'sound/effects/footstep/hardbarefoot5.ogg'), 80, -1)
	),
	FOOTSTEP_MOB_CLAW = list(
		FOOTSTEP_WOOD = list(list(
			'sound/effects/footstep/woodclaw1.ogg',
			'sound/effects/footstep/woodclaw2.ogg',
			'sound/effects/footstep/woodclaw3.ogg',
			'sound/effects/footstep/woodclaw2.ogg',
			'sound/effects/footstep/woodclaw1.ogg'), 90, 1),
		FOOTSTEP_FLOOR = list(list(
			'sound/effects/footstep/hardclaw1.ogg',
			'sound/effects/footstep/hardclaw2.ogg',
			'sound/effects/footstep/hardclaw3.ogg',
			'sound/effects/footstep/hardclaw4.ogg',
			'sound/effects/footstep/hardclaw1.ogg'), 90, 1),
		FOOTSTEP_PLATING = list(list(
			'sound/effects/footstep/hardclaw1.ogg',
			'sound/effects/footstep/hardclaw2.ogg',
			'sound/effects/footstep/hardclaw3.ogg',
			'sound/effects/footstep/hardclaw4.ogg',
			'sound/effects/footstep/hardclaw1.ogg'), 90, 1),
		FOOTSTEP_CARPET = list(list(
			'sound/effects/footstep/carpetbarefoot1.ogg',
			'sound/effects/footstep/carpetbarefoot2.ogg',
			'sound/effects/footstep/carpetbarefoot3.ogg',
			'sound/effects/footstep/carpetbarefoot4.ogg',
			'sound/effects/footstep/carpetbarefoot5.ogg'), 75, -2),
		FOOTSTEP_CATWALK = list(list(
			'sound/effects/footstep/hardclaw1.ogg',
			'sound/effects/footstep/hardclaw2.ogg',
			'sound/effects/footstep/hardclaw3.ogg',
			'sound/effects/footstep/hardclaw4.ogg',
			'sound/effects/footstep/hardclaw1.ogg'), 90, 1)
	),
	FOOTSTEP_MOB_HEAVY = list(
		FOOTSTEP_WOOD = list(list(
			'sound/effects/footstep/heavy1.ogg',
			'sound/effects/footstep/heavy2.ogg'), 100, 2),
		FOOTSTEP_FLOOR = list(list(
			'sound/effects/footstep/heavy1.ogg',
			'sound/effects/footstep/heavy2.ogg'), 100, 2),
		FOOTSTEP_PLATING = list(list(
			'sound/effects/footstep/heavy1.ogg',
			'sound/effects/footstep/heavy2.ogg'), 100, 2),
		FOOTSTEP_CARPET = list(list(
			'sound/effects/footstep/heavy1.ogg',
			'sound/effects/footstep/heavy2.ogg'), 100, 2),
		FOOTSTEP_ASTEROID = list(list(
			'sound/effects/footstep/heavy1.ogg',
			'sound/effects/footstep/heavy2.ogg'), 100, 2),
		FOOTSTEP_GRASS = list(list(
			'sound/effects/footstep/heavy1.ogg',
			'sound/effects/footstep/heavy2.ogg'), 100, 2),
		FOOTSTEP_CATWALK = list(list(
			'sound/effects/footstep/heavy1.ogg',
			'sound/effects/footstep/heavy2.ogg'), 100, 2),
		FOOTSTEP_SNOW = list(list(
			'sound/effects/footstep/heavy1.ogg',
			'sound/effects/footstep/heavy2.ogg'), 100, 2),
		FOOTSTEP_ICE = list(list(
			'sound/effects/footstep/heavy1.ogg',
			'sound/effects/footstep/heavy2.ogg'), 100, 2),
		FOOTSTEP_CONCRETE = list(list(
			'sound/effects/footstep/heavy1.ogg',
			'sound/effects/footstep/heavy2.ogg'), 100, 2),
		FOOTSTEP_SAND = list(list(
			'sound/effects/footstep/heavy1.ogg',
			'sound/effects/footstep/heavy2.ogg'), 100, 2),
		FOOTSTEP_MUD = list(list(
			'sound/effects/footstep/heavy1.ogg',
			'sound/effects/footstep/heavy2.ogg'), 100, 2)
	)
))

/proc/get_footsteps_list()
	var/list/footsteps = list()
	for(var/footstep_type in GLOB.footstep_mob_types)
		footsteps[footstep_type] = GLOB.footstep_default.Copy()
	for(var/override_step in GLOB.footstep_overrides)
		for(var/override_turf in GLOB.footstep_overrides[override_step])
			footsteps[override_step][override_turf] = GLOB.footstep_overrides[override_step][override_turf]

	return footsteps

GLOBAL_LIST_INIT(footstep, get_footsteps_list())
