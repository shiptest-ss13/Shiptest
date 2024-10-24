/**
 * # Overmap Events
 *
 * These are events that have some sort of effect on overmap ships that are on the same tile.
 */
/datum/overmap/event
	name = "generic overmap event"
	///determines the icon of the event
	var/base_icon_state
	///suffix of base_icon_state generated on init, usually 1-4
	var/icon_suffix
	///If prob(this), call affect_ship when processed
	var/chance_to_affect = 0
	///Chance to spread to nearby tiles if spawned
	var/spread_chance = 0
	///How many additional tiles to spawn at once in the selected orbit. Used with OVERMAP_GENERATOR_SOLAR.
	var/chain_rate = 0
	///The mapgen we set ourself to when a ship docks to empty space over us
	var/datum/map_generator/empty_space_mapgen
	/// override the mountain value to this value
	var/mountain_height_override


/datum/overmap/event/Initialize(position, ...)
	. = ..()
	SSovermap.events += src
	current_overmap.events += src
	alter_token_appearance()

/datum/overmap/event/Destroy()
	. = ..()
	SSovermap.events -= src
	current_overmap.events -= src

/datum/overmap/event/alter_token_appearance()
	token_icon_state = "[base_icon_state][icon_suffix]"
	return ..()

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

/**
 * The proc called to modify the empty space generation when it is spawned.
 */
/datum/overmap/event/proc/modify_emptyspace_mapgen(datum/overmap/dynamic/our_planet)
	if(!empty_space_mapgen)
		return
	our_planet.mapgen = empty_space_mapgen

///METEOR STORMS - explodes your ship if you go too fast
/datum/overmap/event/meteor
	name = "asteroid field (moderate)"
	desc = "An area of space rich with asteroids, going fast through here could prove dangerous"
	base_icon_state = "meteor_medium_"
	default_color = "#a08444"
	chance_to_affect = 15
	spread_chance = 50
	chain_rate = 4

	empty_space_mapgen = /datum/map_generator/planet_generator/asteroid

	var/safe_speed = 3
	var/list/meteor_types = list(
		/obj/effect/meteor/dust=3,
		/obj/effect/meteor/medium=8,
		/obj/effect/meteor/big=1,
		/obj/effect/meteor/irradiated=3
	)

/datum/overmap/event/meteor/alter_token_appearance()
	icon_suffix = "[rand(1, 4)]"
	..()
	if(current_overmap.override_object_colors)
		token.color = current_overmap.hazard_primary_color
	current_overmap.post_edit_token_state(src)

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
	base_icon_state = "meteor_light_"
	chain_rate = 3

	mountain_height_override = 0.85

	meteor_types = list(
		/obj/effect/meteor/dust=12,
		/obj/effect/meteor/medium=4,
		/obj/effect/meteor/irradiated=2
	)

/datum/overmap/event/meteor/major
	name = "asteroid field (major)"
	base_icon_state = "meteor_major_"
	spread_chance = 25
	chain_rate = 6

	mountain_height_override = 0.5

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
	base_icon_state = "ion"
	default_color = "#7cb4d4"
	spread_chance = 20
	chain_rate = 2
	chance_to_affect = 20
	var/strength = 4

/datum/overmap/event/emp/alter_token_appearance()
	icon_suffix = "[rand(1, 4)]"
	..()
	if(current_overmap.override_object_colors)
		token.color = current_overmap.hazard_primary_color
	current_overmap.post_edit_token_state(src)

/datum/overmap/event/emp/affect_ship(datum/overmap/ship/controlled/S)
	var/area/source_area = pick(S.shuttle_port.shuttle_areas)
	source_area.set_fire_alarm_effect()
	var/source_object = pick(source_area.contents)
	empulse(get_turf(source_object), round(rand(strength / 2, strength)), rand(strength, strength * 2))
	for(var/mob/M as anything in GLOB.player_list)
		if(S.shuttle_port.is_in_shuttle_bounds(M))
			M.playsound_local(S.shuttle_port, 'sound/weapons/ionrifle.ogg', strength)

/datum/overmap/event/emp/modify_emptyspace_mapgen(datum/overmap/dynamic/our_planet)
	our_planet.weather_controller_type = /datum/weather_controller/shrouded
	return ..()

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
	base_icon_state = "electrical_medium_"
	default_color = "#e8e85c"
	chance_to_affect = 15
	spread_chance = 30
	chain_rate = 3
	var/zap_flag = ZAP_STORM_FLAGS
	var/max_damage = 15
	var/min_damage = 5

/datum/overmap/event/electric/alter_token_appearance()
	icon_suffix = "[rand(1, 4)]"
	..()
	if(current_overmap.override_object_colors)
		token.color = current_overmap.hazard_primary_color
	current_overmap.post_edit_token_state(src)

/datum/overmap/event/electric/affect_ship(datum/overmap/ship/controlled/S)
	var/datum/virtual_level/ship_vlevel = S.shuttle_port.get_virtual_level()
	var/turf/source = ship_vlevel.get_side_turf(pick(GLOB.cardinals))
	tesla_zap(source, 10, TESLA_DEFAULT_POWER, zap_flag)
	for(var/mob/M as anything in GLOB.player_list)
		if(S.shuttle_port.is_in_shuttle_bounds(M))
			M.playsound_local(source, 'sound/magic/lightningshock.ogg', rand(min_damage / 10, max_damage / 10))


/datum/overmap/event/electric/modify_emptyspace_mapgen(datum/overmap/dynamic/our_planet)
	our_planet.weather_controller_type = /datum/weather_controller/shrouded
	return ..()

/datum/overmap/event/electric/minor
	name = "electrical storm (minor)"
	base_icon_state = "electrical_minor_"
	spread_chance = 40
	chain_rate = 2
	max_damage = 10
	min_damage = 3

/datum/overmap/event/electric/major
	name = "electrical storm (major)"
	base_icon_state = "electrical_major_"
	spread_chance = 15
	chain_rate = 6
	max_damage = 20
	min_damage = 10
	zap_flag = ZAP_TESLA_FLAGS

/datum/overmap/event/nebula
	name = "nebula"
	desc = "There's coffee in here"
	base_icon_state = "nebula"
	default_color = "#c053f3"
	chain_rate = 8
	spread_chance = 75

/datum/overmap/event/nebula/alter_token_appearance()
	. = ..()
	if(current_overmap.override_object_colors)
		token.color = current_overmap.hazard_secondary_color
	token.opacity = TRUE
	current_overmap.post_edit_token_state(src)


/datum/overmap/event/wormhole
	name = "wormhole"
	desc = "A hole through space. If you go through here, you might end up anywhere."
	base_icon_state = "wormhole"
	token_icon_state = "wormhole"
	spread_chance = 0
	chain_rate = 0
	chance_to_affect = 100
	///The currently linked wormhole
	var/datum/overmap/event/wormhole/other_wormhole

/datum/overmap/event/wormhole/Initialize(position, _other_wormhole, ...)
	. = ..()
	if(_other_wormhole)
		other_wormhole = _other_wormhole
	if(!other_wormhole)
		other_wormhole = new(null, src) //Create a new wormhole at a random location
	alter_token_appearance()

/datum/overmap/event/wormhole/alter_token_appearance()
	token.color = "#6d80c7"
	token.light_color = "#6d80c7"
	..()
	if(current_overmap.override_object_colors)
		token.color = current_overmap.hazard_primary_color
	current_overmap.post_edit_token_state(src)

/datum/overmap/event/wormhole/affect_ship(datum/overmap/ship/controlled/S)
	if(!other_wormhole)
		qdel(src)
		return

	S.overmap_move(other_wormhole.x, other_wormhole.y)
	S.overmap_step(S.get_heading())

//Carp "meteors" - throws carp at the ship

/datum/overmap/event/meteor/carp
	name = "carp migration (moderate)"
	desc = "A migratory school of space carp. They travel at high speeds, and flying through them may cause them to impact your ship"
	base_icon_state = "carp"
	default_color = "#7b1ca8"
	chance_to_affect = 15
	spread_chance = 50
	chain_rate = 4
	safe_speed = 2
	meteor_types = list(
		/obj/effect/meteor/carp=16,
		/obj/effect/meteor/carp/big=1, //numbers I pulled out of my ass
	)

/datum/overmap/event/meteor/carp/alter_token_appearance()
	icon_suffix = "[rand(1, 4)]"
	..()
	if(current_overmap.override_object_colors)
		token.color = current_overmap.hazard_primary_color
	current_overmap.post_edit_token_state(src)

/datum/overmap/event/meteor/carp/minor
	name = "carp migration (minor)"
	chance_to_affect = 5
	spread_chance = 25
	chain_rate = 4
	meteor_types = list(
		/obj/effect/meteor/carp=8
	)


/datum/overmap/event/meteor/carp/major
	name = "carp migration (major)"
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
	base_icon_state = "dust"
	default_color = "#506469" //we should make these defines
	chance_to_affect = 30
	spread_chance = 50
	chain_rate = 4
	safe_speed = 7
	meteor_types = list(
		/obj/effect/meteor/dust=3,
	)

/datum/overmap/event/meteor/dust/alter_token_appearance()
	icon_suffix = "[rand(1, 4)]"
	..()
	if(current_overmap.override_object_colors)
		token.color = current_overmap.hazard_secondary_color
	current_overmap.post_edit_token_state(src)

/datum/overmap/event/anomaly
	name = "anomaly field"
	desc = "A highly anomalous area of space, disturbing it leads to the manifestation of odd spatial phenomena"
	base_icon_state = "anomaly"
	default_color = "#c46a24"
	chance_to_affect = 10
	spread_chance = 35
	chain_rate = 6

/datum/overmap/event/anomaly/alter_token_appearance()
	icon_suffix = "[rand(1, 4)]"
	..()
	if(current_overmap.override_object_colors)
		token.color = current_overmap.hazard_secondary_color
	current_overmap.post_edit_token_state(src)

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
	/* commented out until ion storms aren't literal torture
	/datum/overmap/event/emp/minor = 45,
	/datum/overmap/event/emp = 40,
	/datum/overmap/event/emp/major = 45,
	*/
	/datum/overmap/event/meteor/minor = 45,
	/datum/overmap/event/meteor = 40,
	/datum/overmap/event/meteor/major = 35,
	/datum/overmap/event/meteor/carp/minor = 45,
	/datum/overmap/event/meteor/carp = 35,
	/datum/overmap/event/meteor/carp/major = 20,
	/datum/overmap/event/meteor/dust = 50,
	/datum/overmap/event/anomaly = 10
))

