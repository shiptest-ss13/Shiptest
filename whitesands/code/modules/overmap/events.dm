/obj/structure/overmap/event
	name = "generic overmap event"
	integrity = 0
	///Should the affect_ship() proc be called more than once?
	var/affect_multiple_times = FALSE
	///If prob(this), call affect_ship when processed
	var/chance_to_affect = 0
	///Chance to spread to nearby tiles if spawned
	var/spread_chance = 0
	///How many additional tiles to spawn at once in the selected orbit. Used with OVERMAP_GENERATOR_SOLAR.
	var/chain_rate = 0
	///The event to run when the station gets hit by an event
	var/datum/round_event_control/station_event

/obj/structure/overmap/event/Initialize(mapload, _id)
	. = ..()
	LAZYADD(SSovermap.events, src)

/obj/structure/overmap/event/Destroy()
	. = ..()
	LAZYREMOVE(SSovermap.events, src)

/**
  * The action performed by a ship on this when the helm button is pressed.
  * * acting - The ship acting on the event
  */
/obj/structure/overmap/event/proc/ship_act(mob/user, obj/structure/overmap/ship/simulated/acting)
	return

/**
  * The main proc for calling other procs. Called by SSovermap.
  */
/obj/structure/overmap/event/proc/apply_effect()
	if(affect_multiple_times)
		for(var/obj/structure/overmap/ship/simulated/S in close_overmap_objects)
			if(prob(chance_to_affect))
				affect_ship(S)

/**
  * The proc called on all ships that are currently being affected.
  */
/obj/structure/overmap/event/proc/affect_ship(obj/structure/overmap/ship/simulated/S)
	return

/obj/structure/overmap/event/Crossed(atom/movable/AM, oldloc)
	. = ..()
	if(istype(AM, /obj/structure/overmap/ship))
		affect_ship(AM)
	else if(istype(AM, /obj/structure/overmap/level/main))
		var/datum/round_event_control/E = new station_event()
		E.runEvent()

///METEOR STORMS - Bounces harmlessly off the shield... unless your shield is breached
/obj/structure/overmap/event/meteor
	name = "asteroid storm (moderate)"
	icon_state = "meteor1"
	affect_multiple_times = TRUE
	chance_to_affect = 5
	spread_chance = 50
	chain_rate = 4
	station_event = /datum/round_event_control/meteor_wave/threatening
	var/max_damage = 15
	var/min_damage = 5

/obj/structure/overmap/event/meteor/Initialize(mapload, _id)
	. = ..()
	icon_state = "meteor[rand(1, 4)]"

/obj/structure/overmap/event/meteor/affect_ship(obj/structure/overmap/ship/simulated/S)
	var/area/source_area = pick(S.shuttle.shuttle_areas)
	source_area?.set_fire_alarm_effect()
	S.recieve_damage(rand(min_damage, max_damage))
	if(S.integrity <= 0 && source_area)
		var/source_object = pick(source_area.contents)
		dyn_explosion(source_object, rand(min_damage, max_damage) / 2)
	else
		for(var/MN in GLOB.player_list)
			var/mob/M = MN
			if(S.shuttle.is_in_shuttle_bounds(M))
				var/strength = abs(S.integrity - initial(S.integrity))
				M.playsound_local(S.shuttle, 'sound/effects/explosionfar.ogg', strength)
				shake_camera(M, 10, strength / 10)

/obj/structure/overmap/event/meteor/minor
	name = "asteroid storm (minor)"
	station_event = /datum/round_event_control/meteor_wave
	chain_rate = 3
	max_damage = 10
	min_damage = 3

/obj/structure/overmap/event/meteor/major
	name = "asteroid storm (major)"
	spread_chance = 25
	chain_rate = 6
	station_event = /datum/round_event_control/meteor_wave/catastrophic
	max_damage = 25
	min_damage = 10

///ION STORM - Causes EMP pulses on the shuttle, wreaking havoc on the shields
/obj/structure/overmap/event/emp
	name = "ion storm (moderate)"
	icon_state = "ion1"
	spread_chance = 20
	chain_rate = 2
	station_event = /datum/round_event_control/ion_storm
	var/strength = 3

/obj/structure/overmap/event/emp/Initialize(mapload, _id)
	. = ..()
	icon_state = "ion[rand(1, 4)]"

/obj/structure/overmap/event/emp/affect_ship(obj/structure/overmap/ship/simulated/S)
	var/area/source_area = pick(S.shuttle.shuttle_areas)
	source_area.set_fire_alarm_effect()
	S.recieve_damage(rand(strength * 5, strength * 10))
	if(S.integrity <= 0)
		var/source_object = pick(source_area.contents)
		empulse(get_turf(source_object), round(rand(strength / 2, strength)), rand(strength, strength * 2))
	else
		for(var/MN in GLOB.player_list)
			var/mob/M = MN
			if(S.shuttle.is_in_shuttle_bounds(M))
				var/strength = abs(S.integrity - initial(S.integrity))
				M.playsound_local(S.shuttle, 'sound/weapons/ionrifle.ogg', strength)
				shake_camera(M, 10, strength / 10)

/obj/structure/overmap/event/emp/minor
	name = "ion storm (minor)"
	chain_rate = 1
	strength = 1

/obj/structure/overmap/event/emp/major
	name = "ion storm (major)"
	chain_rate = 4
	strength = 5

///ELECTRICAL STORM - Zaps places in the shuttle
/obj/structure/overmap/event/electric
	name = "electrical storm (moderate)"
	icon_state = "electrical1"
	spread_chance = 30
	chain_rate = 3
	station_event = /datum/round_event_control/grid_check
	var/max_damage = 15
	var/min_damage = 5

/obj/structure/overmap/event/electric/Initialize(mapload, _id)
	. = ..()
	icon_state = "electrical[rand(1, 4)]"

/obj/structure/overmap/event/electric/affect_ship(obj/structure/overmap/ship/simulated/S)
	var/area/source_area = pick(S.shuttle.shuttle_areas)
	source_area.set_fire_alarm_effect()
	S.recieve_damage(rand(min_damage, max_damage))
	if(S.integrity <= 0)
		var/source_object = pick(source_area.contents)
		tesla_zap(source_object, rand(min_damage, max_damage) / 2)
	else
		for(var/MN in GLOB.player_list)
			var/mob/M = MN
			if(S.shuttle.is_in_shuttle_bounds(M))
				var/strength = abs(S.integrity - initial(S.integrity))
				M.playsound_local(S.shuttle, 'sound/magic/lightningshock.ogg', strength)
				shake_camera(M, 10, strength / 10)

/obj/structure/overmap/event/electric/minor
	name = "electrical storm (minor)"
	spread_chance = 40
	chain_rate = 2
	max_damage = 10
	min_damage = 3

/obj/structure/overmap/event/electric/major
	name = "electrical storm (major)"
	spread_chance = 15
	chain_rate = 6
	max_damage = 20
	min_damage = 10

/obj/structure/overmap/event/nebula
	name = "nebula"
	icon_state = "nebula"
	chain_rate = 8
	spread_chance = 75
	opacity = TRUE

/obj/structure/overmap/event/wormhole
	name = "wormhole"
	icon_state = "wormhole"
	spread_chance = 0
	chain_rate = 0
	///The currently linked wormhole
	var/obj/structure/overmap/event/wormhole/other_wormhole
	///Amount of times a ship can pass through before it collapses
	var/stability

/obj/structure/overmap/event/wormhole/Initialize(mapload, _id, _other_wormhole)
	. = ..()
	stability = rand(1, 5)
	if(_other_wormhole)
		other_wormhole = _other_wormhole
	if(!other_wormhole)
		if(SSovermap.generator_type == OVERMAP_GENERATOR_SOLAR)
			var/list/L = list_keys(SSovermap.radius_tiles)
			L -= "unsorted"
			var/selected_radius = pick(L)
			var/turf/T = SSovermap.get_unused_overmap_square_in_radius(selected_radius)
			other_wormhole = new(T, "[id]_exit", src)
		else
			other_wormhole = new(SSovermap.get_unused_overmap_square(), "[id]_exit", src)

/obj/structure/overmap/event/wormhole/affect_ship(obj/structure/overmap/ship/simulated/S)
	if(!other_wormhole)
		qdel(src)
	if(--stability <= 0)
		S.recieve_damage(rand(20, 30))
		S.forceMove(SSovermap.get_unused_overmap_square())
		QDEL_NULL(other_wormhole)
		for(var/MN in GLOB.player_list)
			var/mob/M = MN
			if(S.shuttle.is_in_shuttle_bounds(M))
				var/strength = abs(S.integrity - initial(S.integrity))
				M.playsound_local(S.shuttle, 'sound/effects/explosionfar.ogg', strength)
				shake_camera(M, 10, strength / 10)

		return qdel(src)
	other_wormhole.stability = stability
	var/turf/potential_turf = get_step(other_wormhole, S.dir)
	if(potential_turf.density) //So people don't abuse it to escape the overmap
		potential_turf = get_turf(other_wormhole)
	S.forceMove(potential_turf)

GLOBAL_LIST_INIT(overmap_event_pick_list, list(
	/obj/structure/overmap/event/wormhole = 10,
	/obj/structure/overmap/event/nebula = 60,
	/obj/structure/overmap/event/electric/minor = 45,
	/obj/structure/overmap/event/electric = 40,
	/obj/structure/overmap/event/electric/major = 35,
	/obj/structure/overmap/event/emp/minor = 45,
	/obj/structure/overmap/event/emp = 40,
	/obj/structure/overmap/event/emp/major = 45,
	/obj/structure/overmap/event/meteor/minor = 45,
	/obj/structure/overmap/event/meteor = 40,
	/obj/structure/overmap/event/meteor/major = 35
))
