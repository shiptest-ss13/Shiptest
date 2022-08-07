/**
 * # Overmap Events
 *
 * These are events that have some sort of effect on overmap ships that are on the same tile.
 */
/datum/overmap/event
	name = "generic overmap event"
	///If prob(this), call affect_ship when processed
	var/chance_to_affect = 0
	///Chance to spread to nearby tiles if spawned
	var/spread_chance = 0
	///How many additional tiles to spawn at once in the selected orbit. Used with OVERMAP_GENERATOR_SOLAR.
	var/chain_rate = 0

/datum/overmap/event/Initialize(position, ...)
	. = ..()
	SSovermap.events += src

/datum/overmap/event/Destroy()
	. = ..()
	SSovermap.events -= src

/**
 * The main proc for calling other procs. Called by SSovermap.
 */
/datum/overmap/event/proc/apply_effect()
	for(var/datum/overmap/ship/controlled/S in get_nearby_overmap_objects())
		if(prob(chance_to_affect))
			affect_ship(S)

/**
 * The proc called on all ships that are currently being affected.
 */
/datum/overmap/event/proc/affect_ship(datum/overmap/ship/controlled/S)
	return


///METEOR STORMS - Bounces harmlessly off the shield... unless your shield is breached
/datum/overmap/event/meteor
	name = "asteroid storm (moderate)"
	token_icon_state = "meteor1"
	chance_to_affect = 15
	spread_chance = 50
	chain_rate = 4
	var/list/meteor_types = list(
		/obj/effect/meteor/dust=3,
		/obj/effect/meteor/medium=8,
		/obj/effect/meteor/big=3,
		/obj/effect/meteor/flaming=1,
		/obj/effect/meteor/irradiated=3
	)

/datum/overmap/event/meteor/Initialize(position, ...)
	. = ..()
	token.icon_state = "meteor[rand(1, 4)]"

/datum/overmap/event/meteor/affect_ship(datum/overmap/ship/controlled/S)
	spawn_meteor(meteor_types, S.shuttle_port.get_virtual_level(), 0)

/datum/overmap/event/meteor/minor
	name = "asteroid storm (minor)"
	chain_rate = 3
	meteor_types = list(
		/obj/effect/meteor/medium=4,
		/obj/effect/meteor/big=8,
		/obj/effect/meteor/flaming=3,
		/obj/effect/meteor/irradiated=3
	)

/datum/overmap/event/meteor/major
	name = "asteroid storm (major)"
	spread_chance = 25
	chain_rate = 6
	meteor_types = list(
		/obj/effect/meteor/medium=5,
		/obj/effect/meteor/big=75,
		/obj/effect/meteor/flaming=10,
		/obj/effect/meteor/irradiated=10,
		/obj/effect/meteor/tunguska = 1
	)

///ION STORM - Causes EMP pulses on the shuttle, wreaking havoc on the shields
/datum/overmap/event/emp
	name = "ion storm (moderate)"
	token_icon_state = "ion1"
	spread_chance = 20
	chain_rate = 2
	var/strength = 3

/datum/overmap/event/emp/Initialize(position, ...)
	. = ..()
	token.icon_state = "ion[rand(1, 4)]"

/datum/overmap/event/emp/affect_ship(datum/overmap/ship/controlled/S)
	var/area/source_area = pick(S.shuttle_port.shuttle_areas)
	source_area.set_fire_alarm_effect()
	var/source_object = pick(source_area.contents)
	empulse(get_turf(source_object), round(rand(strength / 2, strength)), rand(strength, strength * 2))
	for(var/mob/M as anything in GLOB.player_list)
		if(S.shuttle_port.is_in_shuttle_bounds(M))
			M.playsound_local(S.shuttle_port, 'sound/weapons/ionrifle.ogg', strength)
			shake_camera(M, 10, strength)

/datum/overmap/event/emp/minor
	name = "ion storm (minor)"
	chain_rate = 1
	strength = 1

/datum/overmap/event/emp/major
	name = "ion storm (major)"
	chain_rate = 4
	strength = 5

///ELECTRICAL STORM - Zaps places in the shuttle
/datum/overmap/event/electric
	name = "electrical storm (moderate)"
	token_icon_state = "electrical1"
	chance_to_affect = 15
	spread_chance = 30
	chain_rate = 3
	var/max_damage = 15
	var/min_damage = 5

/datum/overmap/event/electric/Initialize(position, ...)
	. = ..()
	token.icon_state = "electrical[rand(1, 4)]"

/datum/overmap/event/electric/affect_ship(datum/overmap/ship/controlled/S)
	var/datum/virtual_level/ship_vlevel = S.shuttle_port.get_virtual_level()
	var/turf/source = ship_vlevel.get_side_turf(pick(GLOB.cardinals))
	tesla_zap(source, 10, TESLA_DEFAULT_POWER)
	for(var/mob/M as anything in GLOB.player_list)
		if(S.shuttle_port.is_in_shuttle_bounds(M))
			M.playsound_local(source, 'sound/magic/lightningshock.ogg', rand(min_damage / 10, max_damage / 10))
			shake_camera(M, 10, rand(min_damage / 10, max_damage / 10))

/datum/overmap/event/electric/minor
	name = "electrical storm (minor)"
	spread_chance = 40
	chain_rate = 2
	max_damage = 10
	min_damage = 3

/datum/overmap/event/electric/major
	name = "electrical storm (major)"
	spread_chance = 15
	chain_rate = 6
	max_damage = 20
	min_damage = 10

/datum/overmap/event/nebula
	name = "nebula"
	token_icon_state = "nebula"
	chain_rate = 8
	spread_chance = 75

/datum/overmap/event/nebula/Initialize(position, ...)
	. = ..()
	token.opacity = TRUE

/datum/overmap/event/wormhole
	name = "wormhole"
	token_icon_state = "wormhole"
	spread_chance = 0
	chain_rate = 0
	chance_to_affect = 100
	///The currently linked wormhole
	var/datum/overmap/event/wormhole/other_wormhole
	///Amount of times a ship can pass through before it collapses
	var/stability

/datum/overmap/event/wormhole/Initialize(position, _other_wormhole, ...)
	. = ..()
	stability = rand(1, 5)
	if(_other_wormhole)
		other_wormhole = _other_wormhole
	if(!other_wormhole)
		other_wormhole = new(null, src) //Create a new wormhole at a random location

/datum/overmap/event/wormhole/affect_ship(datum/overmap/ship/controlled/S)
	if(!other_wormhole)
		qdel(src)
	if(--stability <= 0)
		var/list/results = SSovermap.get_unused_overmap_square()
		S.overmap_move(results["x"], results["y"])
		QDEL_NULL(other_wormhole)
		for(var/MN in GLOB.player_list)
			var/mob/M = MN
			if(S.shuttle_port.is_in_shuttle_bounds(M))
				M.playsound_local(S.shuttle_port, 'sound/effects/explosionfar.ogg', 100)
				shake_camera(M, 10, 10)

		return qdel(src)
	other_wormhole.stability = stability

	S.overmap_move(other_wormhole.x, other_wormhole.y)
	S.overmap_step(S.get_heading())

GLOBAL_LIST_INIT(overmap_event_pick_list, list(
	/datum/overmap/event/wormhole = 10,
	/datum/overmap/event/nebula = 60,
	/datum/overmap/event/electric/minor = 45,
	/datum/overmap/event/electric = 40,
	/datum/overmap/event/electric/major = 35,
	/datum/overmap/event/emp/minor = 45,
	/datum/overmap/event/emp = 40,
	/datum/overmap/event/emp/major = 45,
	/datum/overmap/event/meteor/minor = 45,
	/datum/overmap/event/meteor = 40,
	/datum/overmap/event/meteor/major = 35
))

