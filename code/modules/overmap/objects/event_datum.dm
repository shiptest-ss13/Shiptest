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
	var/desc

/datum/overmap/event/Initialize(position, ...)
	. = ..()
	SSovermap.events += src
	token.desc = desc

/datum/overmap/event/Destroy()
	. = ..()
	SSovermap.events -= src

/**
 * The main proc for calling other procs. Called by SSovermap.
 */
/datum/overmap/event/proc/apply_effect()
	for(var/datum/overmap/ship/controlled/Ship in get_nearby_overmap_objects())
		if(prob(chance_to_affect))
			affect_ship(Ship)

/**
 * The proc called on all ships that are currently being affected.
 */
/datum/overmap/event/proc/affect_ship(datum/overmap/ship/controlled/Ship)
	return


///METEOR STORMS - explodes your ship if you go too fast
/datum/overmap/event/meteor
	name = "asteroid field (moderate)"
	desc = "An area of space rich with asteroids, going fast through here could prove dangerous"
	token_icon_state = "meteor1"
	chance_to_affect = 15
	spread_chance = 50
	chain_rate = 4
	var/safe_speed = 3
	var/list/meteor_types = list(
		/obj/effect/meteor/dust=3,
		/obj/effect/meteor/medium=8,
		/obj/effect/meteor/big=1,
		/obj/effect/meteor/irradiated=3
	)

/datum/overmap/event/meteor/Initialize(position, ...)
	. = ..()
	token.icon_state = "meteor[rand(1, 4)]"
	token.color = "#a08444"
	token.light_color = "#a08444"
	token.update_appearance()

/datum/overmap/event/meteor/apply_effect()
	for(var/datum/overmap/ship/controlled/Ship in get_nearby_overmap_objects())
		if(Ship.get_speed() > safe_speed)
			var/how_fast =  (Ship.get_speed() - safe_speed)
			if(prob(chance_to_affect + how_fast))
				affect_ship(Ship)

/datum/overmap/event/meteor/affect_ship(datum/overmap/ship/controlled/Ship)
	spawn_meteor(meteor_types, Ship.shuttle_port.get_virtual_level(), 0)

/datum/overmap/event/meteor/minor
	name = "asteroid field (minor)"
	chain_rate = 3
	meteor_types = list(
		/obj/effect/meteor/dust=12,
		/obj/effect/meteor/medium=4,
		/obj/effect/meteor/irradiated=2
	)

/datum/overmap/event/meteor/major
	name = "asteroid field (major)"
	spread_chance = 25
	chain_rate = 6
	meteor_types = list(
		/obj/effect/meteor/medium=50,
		/obj/effect/meteor/big=25,
		/obj/effect/meteor/flaming=10,
		/obj/effect/meteor/irradiated=10,
		/obj/effect/meteor/tunguska = 1
	)

///ION STORM - explodes your IPCs
/datum/overmap/event/emp
	name = "ion storm (moderate)"
	desc = "A heavily ionized area of space, prone to causing electromagnetic pulses in ships"
	token_icon_state = "ion1"
	spread_chance = 20
	chain_rate = 2
	chance_to_affect = 20
	var/strength = 4

/datum/overmap/event/emp/Initialize(position, ...)
	. = ..()
	token.icon_state = "ion[rand(1, 4)]"
	token.color = "#7cb4d4"
	token.light_color = "#7cb4d4"
	token.update_appearance()

/datum/overmap/event/emp/affect_ship(datum/overmap/ship/controlled/S)
	var/area/source_area = pick(S.shuttle_port.shuttle_areas)
	source_area.set_fire_alarm_effect()
	var/source_object = pick(source_area.contents)
	empulse(get_turf(source_object), round(rand(strength / 2, strength)), rand(strength, strength * 2))
	for(var/mob/M as anything in GLOB.player_list)
		if(S.shuttle_port.is_in_shuttle_bounds(M))
			M.playsound_local(S.shuttle_port, 'sound/weapons/ionrifle.ogg', strength)

/datum/overmap/event/emp/minor
	name = "ion storm (minor)"
	chain_rate = 1
	strength = 1
	chance_to_affect = 15

/datum/overmap/event/emp/major
	name = "ion storm (major)"
	chance_to_affect = 25
	chain_rate = 4
	strength = 6

///ELECTRICAL STORM - explodes your computer and IPCs
/datum/overmap/event/electric
	name = "electrical storm (moderate)"
	desc = "A spatial anomaly, an unfortunately common sight on the frontier. Disturbing it tends to lead to intense electrical discharges"
	token_icon_state = "electrical1"
	chance_to_affect = 15
	spread_chance = 30
	chain_rate = 3
	var/zap_flag = ZAP_STORM_FLAGS
	var/max_damage = 15
	var/min_damage = 5

/datum/overmap/event/electric/Initialize(position, ...)
	. = ..()
	token.icon_state = "electrical[rand(1, 4)]"
	token.color = "#e8e85c"
	token.light_color = "#e8e85c"
	token.update_appearance()

/datum/overmap/event/electric/affect_ship(datum/overmap/ship/controlled/S)
	var/datum/virtual_level/ship_vlevel = S.shuttle_port.get_virtual_level()
	var/turf/source = ship_vlevel.get_side_turf(pick(GLOB.cardinals))
	tesla_zap(source, 10, TESLA_DEFAULT_POWER, zap_flag)
	for(var/mob/M as anything in GLOB.player_list)
		if(S.shuttle_port.is_in_shuttle_bounds(M))
			M.playsound_local(source, 'sound/magic/lightningshock.ogg', rand(min_damage / 10, max_damage / 10))

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
	zap_flag = ZAP_TESLA_FLAGS

/datum/overmap/event/nebula
	name = "nebula"
	desc = "There's coffee in here"
	token_icon_state = "nebula"
	chain_rate = 8
	spread_chance = 75

/datum/overmap/event/nebula/Initialize(position, ...)
	. = ..()
	token.opacity = TRUE
	token.color = "#c053f3"
	token.light_color = "#c053f3"
	token.update_appearance()

/datum/overmap/event/wormhole
	name = "wormhole"
	desc = "A hole through space. If you go through here, you might end up anywhere."
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
	token.color = adjust_colors()
	token.light_color = adjust_colors()
	token.update_appearance()

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

	token.color = adjust_colors()
	token.light_color = adjust_colors()

/datum/overmap/event/wormhole/proc/adjust_colors()
	switch(stability)
		if(1)
			return "#753214"
		if(2)
			return "#642f19"
		if(3)
			return"#654650"
		if(4)
			return"#5c5d8b"
		if(5)
			return"#6d80c7"

//Carp "meteors" - throws carp at the ship

/datum/overmap/event/meteor/carp
	name = "carp migration (moderate)"
	desc = "A migratory school of space carp. They travel at high speeds, and flying through them may cause them to impact your ship"
	token_icon_state = "carp1"
	chance_to_affect = 15
	spread_chance = 50
	chain_rate = 4
	safe_speed = 2
	meteor_types = list(
		/obj/effect/meteor/carp=16,
		/obj/effect/meteor/carp/big=1, //numbers I pulled out of my ass
	)

/datum/overmap/event/meteor/carp/Initialize(position, ...)
	. = ..()
	token.icon_state = "carp[rand(1, 4)]"
	token.color = "#7b1ca8"
	token.light_color = "#7b1ca8"
	token.update_icon()


/datum/overmap/event/meteor/carp/minor
	name = "carp migration (minor)"
	token_icon_state = "carp1"
	chance_to_affect = 5
	spread_chance = 25
	chain_rate = 4
	meteor_types = list(
		/obj/effect/meteor/carp=8
	)


/datum/overmap/event/meteor/carp/major
	name = "carp migration (major)"
	token_icon_state = "carp1"
	chance_to_affect = 25
	spread_chance = 25
	chain_rate = 4
	meteor_types = list(
		/obj/effect/meteor/carp=7,
		/obj/effect/meteor/carp/big=1,
	)

// dust clouds throw dust if you go Way Fast

/datum/overmap/event/meteor/dust
	name = "dust cloud"
	desc = "A cloud of spaceborne dust. Relatively harmless, unless you're travelling at relative speeds"
	token_icon_state = "carp1"
	chance_to_affect = 30
	spread_chance = 50
	chain_rate = 4
	safe_speed = 7
	meteor_types = list(
		/obj/effect/meteor/dust=3,
	)

/datum/overmap/event/meteor/dust/Initialize(position, ...)
	. = ..()
	token.icon_state = "dust[rand(1, 4)]"
	token.color = "#506469" //we should make these defines
	token.light_color = "#506469"
	token.update_icon()

/datum/overmap/event/anomaly
	name = "anomaly field"
	desc = "A highly anomalous area of space, disturbing it leads to the manifestation of odd spatial phenomena"
	token_icon_state = "anomaly1"
	chance_to_affect = 10
	spread_chance = 35
	chain_rate = 6

/datum/overmap/event/anomaly/Initialize(position, ...)
	. = ..()
	token.icon_state = "anomaly[rand(1, 4)]"
	token.color = "#c46a24"
	token.light_color = "#c46a24"
	token.update_icon()

/datum/overmap/event/anomaly/affect_ship(datum/overmap/ship/controlled/S)
	var/area/source_area = pick(S.shuttle_port.shuttle_areas)
	var/source_object = pick(source_area.contents)
	new /obj/effect/spawner/lootdrop/anomaly/storm(get_turf(source_object))
	for(var/mob/M as anything in GLOB.player_list)
		if(S.shuttle_port.is_in_shuttle_bounds(M))
			M.playsound_local(S.shuttle_port, 'sound/effects/bamf.ogg', 100)

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
	/datum/overmap/event/meteor/major = 35,
	/datum/overmap/event/meteor/carp/minor = 45,
	/datum/overmap/event/meteor/carp = 35,
	/datum/overmap/event/meteor/carp/major = 20,
	/datum/overmap/event/meteor/dust = 50,
	/datum/overmap/event/anomaly = 10
))

