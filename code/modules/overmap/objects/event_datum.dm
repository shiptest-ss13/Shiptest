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
	/// Override the mountain value of the mapgen to this value.
	var/mountain_height_override

/datum/overmap/event/Initialize(position, datum/overmap_star_system/system_spawned_in, set_lifespan,...)
	. = ..()
	SSovermap.events += src
	current_overmap.events += src
	alter_token_appearance()

	if(lifespan || set_lifespan)
		if(set_lifespan)
			lifespan = set_lifespan
		death_time = world.time + lifespan
		token.countdown = new /obj/effect/countdown/overmap_event(token)
		token.countdown.color = current_overmap.hazard_secondary_color

		token.countdown.start()
		START_PROCESSING(SSfastprocess, src)

/datum/overmap/event/Destroy()
	. = ..()
	SSovermap.events -= src
	current_overmap.events -= src
	if(lifespan)
		STOP_PROCESSING(SSfastprocess, src)

/datum/overmap/event/alter_token_appearance()
	token_icon_state = "[base_icon_state][icon_suffix]"
	return ..()

/datum/overmap/event/process()
	if(death_time < world.time && lifespan)
		qdel(src)

/**
 * The main proc for calling other procs. Called by SSovermap.
 */
/datum/overmap/event/proc/apply_effect()
	for(var/datum/overmap/ship/controlled/Ship in get_nearby_overmap_objects())
		if(prob(chance_to_affect))
			affect_ship(Ship)
	if(death_time < world.time && lifespan)
		qdel(src)

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
	interference_power = 15

	empty_space_mapgen = /datum/map_generator/planet_generator/asteroid

	var/safe_speed = 3
	var/list/meteor_types = list(
		/obj/effect/meteor/dust=3,
		/obj/effect/meteor/medium=8,
		/obj/effect/meteor/big=1,
		/obj/effect/meteor/irradiated=3
	)
	var/primary_ores = list(\
		/obj/item/stack/ore/plasma,
		/obj/item/stack/ore/iron,
		)

/datum/overmap/event/meteor/alter_token_appearance()
	icon_suffix = "[rand(1, 4)]"
	..()

	var/orestext
	if(primary_ores)
		orestext += span_boldnotice("\nInitial scans show a high concentration of the following ores:\n")
		for(var/obj/ore as anything in primary_ores)
			var/hex = ORES_TO_COLORS_LIST[ore]
			orestext += "<font color='[hex]'>	- [ore.name]\n</font>"
		desc += orestext

		token.desc += span_notice("\nYou could land within the [src] if you were to [span_bold("Dock to Empty Space")] while flying over...\n")

	if(safe_speed)
		token.desc += span_notice("\nYou can safely navigate through this if your ship is travelling under [span_bold("[safe_speed] Gm/s")].")

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
	spawn_meteor(meteor_types, Ship.shuttle_port.get_virtual_level(), 0, Ship.shuttle_port)

/datum/overmap/event/meteor/minor
	name = "asteroid field (minor)"
	base_icon_state = "meteor_light_"
	chain_rate = 3
	interference_power = 10

	mountain_height_override = 0.85

	meteor_types = list(
		/obj/effect/meteor/dust=12,
		/obj/effect/meteor/medium=4,
	)

	safe_speed = 5

/datum/overmap/event/meteor/major
	name = "asteroid field (major)"
	base_icon_state = "meteor_major_"
	spread_chance = 25
	chain_rate = 6
	interference_power = 20

	mountain_height_override = 0.5

	meteor_types = list(
		/obj/effect/meteor/medium=50,
		/obj/effect/meteor/big=25,
		/obj/effect/meteor/flaming=10,
	)

///Electromagnetic - explodes your IPCs
/datum/overmap/event/emp
	name = "electromagnetic storm (moderate)"
	desc = "A heavily ionized area of space, prone to causing electromagnetic pulses in ships"
	base_icon_state = "emp_medium_"
	default_color = "#4066ff"
	spread_chance = 20
	chain_rate = 2
	chance_to_affect = 30
	interference_power = 100
	var/strength = 4

/datum/overmap/event/emp/alter_token_appearance()
	icon_suffix = "[rand(1, 4)]"
	..()
	if(current_overmap.override_object_colors)
		token.color = current_overmap.hazard_primary_color
	current_overmap.post_edit_token_state(src)

/datum/overmap/event/emp/affect_ship(datum/overmap/ship/controlled/ship)
	if(!(COOLDOWN_FINISHED(ship, event_cooldown)))
		return
	priority_announce("WARNING: Brace for inbound magnetic pulse.", "[src]", 'sound/effects/overmap/telegraph.ogg', sender_override = name, zlevel = ship.shuttle_port.virtual_z())

	addtimer(CALLBACK(src, PROC_REF(affect_ship_2), ship), 2 SECONDS)
	COOLDOWN_START(ship, event_cooldown, 5 SECONDS)

/datum/overmap/event/emp/proc/affect_ship_2(datum/overmap/ship/controlled/ship)
	if(!(locate(ship) in get_nearby_overmap_objects()))
		return

	var/area/source_area = pick(ship.shuttle_port.shuttle_areas)

	var/source_object = pick(source_area.contents)

	empulse(get_turf(source_object), round(rand(strength / 4, strength)), rand(strength, strength * 2))

	for(var/mob/living/carbon/affected_mob as anything in range(round(strength * 2), get_turf(source_object)))
		if(!istype(affected_mob))
			continue
		affected_mob.flash_act(1, 1)

	for(var/mob/affected_mob as anything in GLOB.player_list)
		if(ship.shuttle_port.is_in_shuttle_bounds(affected_mob))
			affected_mob.playsound_local(affected_mob, 'sound/effects/overmap/neutron_pulse.ogg', 100)

/datum/overmap/event/emp/modify_emptyspace_mapgen(datum/overmap/dynamic/our_planet)
	our_planet.weather_controller_type = /datum/weather_controller/shrouded
	return ..()

/datum/overmap/event/emp/minor
	name = "electromagnetic storm (minor)"
	base_icon_state = "emp_minor_"
	chain_rate = 1
	strength = 2
	chance_to_affect = 20
	interference_power = 80

/datum/overmap/event/emp/major
	name = "electromagnetic storm (major)"
	base_icon_state = "emp_major_"
	chance_to_affect = 40
	chain_rate = 4
	strength = 8
	interference_power = 200

///SOLAR FLARE - Explodes your organics and IPCs
/datum/overmap/event/flare
	name = "solar flare (moderate)"
	desc = "A area with very high level of the local ejected mass from the sun, causing fires in ships"
	base_icon_state = "flare_medium_"
	default_color = "#f65f00"
	spread_chance = 20
	chain_rate = 2
	chance_to_affect = 20
	interference_power = 20
	var/strength = 4

/datum/overmap/event/flare/alter_token_appearance()
	icon_suffix = "[rand(1, 4)]"
	..()
	if(current_overmap.override_object_colors)
		token.color = current_overmap.hazard_primary_color
	current_overmap.post_edit_token_state(src)

/datum/overmap/event/flare/affect_ship(datum/overmap/ship/controlled/ship)
	if(!(COOLDOWN_FINISHED(ship, event_cooldown)))
		return
	priority_announce("WARNING: Brace for inbound solar flare.", "[src]", 'sound/effects/overmap/telegraph.ogg', sender_override = name, zlevel = ship.shuttle_port.virtual_z())

	addtimer(CALLBACK(src, PROC_REF(affect_ship_2), ship), 2 SECONDS)
	COOLDOWN_START(ship, event_cooldown, 5 SECONDS)

/datum/overmap/event/flare/proc/affect_ship_2(datum/overmap/ship/controlled/ship)
	if(!(locate(ship) in get_nearby_overmap_objects()))
		return

	var/area/source_area = pick(ship.shuttle_port.shuttle_areas)

	var/source_object = pick(source_area.contents)

	flame_radius(get_turf(source_object), round(rand(strength / 2, strength)), rand(strength, strength * 2))

	for(var/mob/living/carbon/affected_mob as anything in range(round(strength * 2), get_turf(source_object)))
		if(!istype(affected_mob))
			continue
		affected_mob.flash_act(1, 1)

	for(var/mob/affected_mob as anything in GLOB.player_list)
		if(ship.shuttle_port.is_in_shuttle_bounds(affected_mob))
			affected_mob.playsound_local(affected_mob, 'sound/effects/overmap/solar_flare.ogg', 100)

/datum/overmap/event/flare/modify_emptyspace_mapgen(datum/overmap/dynamic/our_planet)
	our_planet.weather_controller_type = /datum/weather_controller/lavaland
	return ..()

/datum/overmap/event/flare/minor
	name = "solar flare (minor)"
	base_icon_state = "flare_minor_"
	chain_rate = 1
	strength = 2
	chance_to_affect = 15
	interference_power = 15

/datum/overmap/event/flare/major
	name = "solar flare (major)"
	base_icon_state = "flare_major_"
	chance_to_affect = 60
	interference_power = 60
	chain_rate = 4
	strength = 8

///ELECTRICAL STORM - explodes your computer and IPCs
/datum/overmap/event/electric
	name = "electrical storm (moderate)"
	desc = "A buildup of static electrity, an unfortunately common sight on the frontier. Disturbing it tends to lead to intense electrical discharges"
	base_icon_state = "electrical_medium_"
	default_color = "#e8e85c"
	chance_to_affect = 15
	spread_chance = 30
	chain_rate = 3
	interference_power = 15
	var/zap_flag = ZAP_STORM_FLAGS
	var/max_damage = 3000
	var/min_damage = 1000

/datum/overmap/event/electric/alter_token_appearance()
	icon_suffix = "[rand(1, 4)]"
	..()
	if(current_overmap.override_object_colors)
		token.color = current_overmap.hazard_primary_color
	current_overmap.post_edit_token_state(src)

/datum/overmap/event/electric/affect_ship(datum/overmap/ship/controlled/S)
	var/datum/virtual_level/ship_vlevel = S.shuttle_port.get_virtual_level()
	var/turf/source = ship_vlevel.get_side_turf(pick(GLOB.cardinals))
	tesla_zap(source, 32, rand(min_damage, max_damage), zap_flag)

	for(var/mob/poor_crew as anything in GLOB.player_list)
		if(S.shuttle_port.is_in_shuttle_bounds(poor_crew))
			poor_crew.playsound_local(poor_crew, THUNDER_SOUND, rand(min_damage, max_damage))

	var/obj/machinery/power/cloak/cloaking_system = S.ship_modules[SHIPMODULE_CLOAKING]
	if(cloaking_system?.cloak_active)
		cloaking_system.set_cloak(FALSE)
		cloaking_system.visible_message("[src] is overloaded by the electrical storm and shuts off!")

/datum/overmap/event/electric/modify_emptyspace_mapgen(datum/overmap/dynamic/our_planet)
	our_planet.weather_controller_type = /datum/weather_controller/shrouded
	return ..()

/datum/overmap/event/electric/minor
	name = "electrical storm (minor)"
	base_icon_state = "electrical_minor_"
	interference_power = 5
	spread_chance = 40
	chain_rate = 2
	max_damage = 1000
	min_damage = 500

/datum/overmap/event/electric/major
	name = "electrical storm (major)"
	base_icon_state = "electrical_major_"
	interference_power = 30
	spread_chance = 15
	chain_rate = 6
	max_damage = 5000
	min_damage = 3000
	zap_flag = ZAP_DEFAULT_FLAGS

/datum/overmap/event/nebula
	name = "nebula"
	desc = "Beware of modular code."
	base_icon_state = "nebula"
	default_color = "#c053f3"
	chain_rate = 8
	spread_chance = 75
	chance_to_affect = 85

	interference_power = 50

	//list of ships we are currently affecting so we can stop flicking the lights when they leave
	var/list/affected_ships = list()

/datum/overmap/event/nebula/alter_token_appearance()
	. = ..()
	if(current_overmap.override_object_colors)
		token.color = current_overmap.hazard_secondary_color
	token.opacity = TRUE
	current_overmap.post_edit_token_state(src)

/datum/overmap/event/nebula/process()
	. = ..()
	var/list/nearby_objects = get_nearby_overmap_objects(include_docked = TRUE)
	var/datum/virtual_level/ship_vlevel

	for(var/datum/overmap/ship/controlled/ship as anything in affected_ships)
		if(!(ship in nearby_objects))

			ship_vlevel = ship.shuttle_port.get_virtual_level()
			affected_ships -= ship
			REMOVE_TRAIT(ship, TRAIT_CLOAKED, REF(src))

			for(var/obj/machinery/light/light_to_mess in GLOB.machines)
				if(light_to_mess.virtual_z() != ship_vlevel.id)
					continue
				light_to_mess.stop_flickering()

	if(affected_ships.len == 0)
		STOP_PROCESSING(SSfastprocess, src)

/datum/overmap/event/nebula/affect_ship(datum/overmap/ship/controlled/ship)
	var/datum/virtual_level/ship_vlevel = ship.shuttle_port.get_virtual_level()

	if(ship in affected_ships)
		return

	if(affected_ships.len == 0)
		START_PROCESSING(SSfastprocess, src)
	affected_ships += ship
	ADD_TRAIT(ship, TRAIT_CLOAKED, REF(src))


	for(var/obj/machinery/light/light_to_mess in GLOB.machines)
		if(light_to_mess.virtual_z() != ship_vlevel.id)
			continue
		light_to_mess.start_flickering()


/datum/overmap/event/wormhole
	name = "wormhole"
	desc = "A hole through space. If you go through here, you might end up anywhere."
	base_icon_state = "wormhole"
	token_icon_state = "wormhole"
	spread_chance = 0
	chain_rate = 0
	chance_to_affect = 100
	interference_power = 40
	///The currently linked wormhole
	var/datum/overmap/event/wormhole/other_wormhole

/datum/overmap/event/wormhole/Initialize(position, datum/overmap_star_system/system_spawned_in, set_lifespan, _other_wormhole, ...)
	. = ..()
	if(_other_wormhole)
		other_wormhole = _other_wormhole
	if(!other_wormhole)
		other_wormhole = new(null, current_overmap, set_lifespan, src) //Create a new wormhole at a random location
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
	base_icon_state = "carp_medium_"
	default_color = "#7b1ca8"
	chance_to_affect = 15
	spread_chance = 50
	chain_rate = 4
	safe_speed = 5
	interference_power = 0
	meteor_types = list(
		/obj/effect/meteor/carp=16,
		/obj/effect/meteor/carp/big=1, //numbers I pulled out of my ass
	)
	primary_ores = null

/datum/overmap/event/meteor/carp/alter_token_appearance()
	icon_suffix = "[rand(1, 4)]"
	..()
	if(current_overmap.override_object_colors)
		token.color = current_overmap.hazard_primary_color
	current_overmap.post_edit_token_state(src)

/datum/overmap/event/meteor/carp/minor
	name = "carp migration (minor)"
	base_icon_state = "carp_minor_"
	chance_to_affect = 5
	spread_chance = 25
	chain_rate = 4
	meteor_types = list(
		/obj/effect/meteor/carp=8
	)


/datum/overmap/event/meteor/carp/major
	name = "carp migration (major)"
	base_icon_state = "carp_major_"
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
	default_color = "#506469"
	chance_to_affect = 90
	spread_chance = 50
	chain_rate = 4
	safe_speed = 7
	interference_power = 0
	meteor_types = list(
		/obj/effect/meteor/dust=3,
	)
	primary_ores = null

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
	default_color = "#d6c633"
	chance_to_affect = 10
	spread_chance = 35
	chain_rate = 6

/datum/overmap/event/anomaly/Initialize(position, datum/overmap_star_system/system_spawned_in, set_lifespan, ...)
	. = ..()
	if(prob(50)) //only 50% chance of having interference
		interference_power = rand(20,60)

/datum/overmap/event/anomaly/alter_token_appearance()
	icon_suffix = "[rand(1, 4)]"
	..()
	if(current_overmap.override_object_colors)
		token.color = current_overmap.hazard_secondary_color
	current_overmap.post_edit_token_state(src)

/datum/overmap/event/anomaly/affect_ship(datum/overmap/ship/controlled/S)
	var/area/source_area = pick(S.shuttle_port.shuttle_areas)
	var/source_object = pick(source_area.contents)
	new /obj/effect/spawner/random/anomaly/storm(get_turf(source_object))
	for(var/mob/M as anything in GLOB.player_list)
		if(S.shuttle_port.is_in_shuttle_bounds(M))
			M.playsound_local(M, 'sound/effects/bamf.ogg', 100)

GLOBAL_LIST_INIT(overmap_event_pick_list, list(
	/datum/overmap/event/wormhole = 10,
	/datum/overmap/event/nebula = 60,
	/datum/overmap/event/electric/minor = 45,
	/datum/overmap/event/electric = 40,
	/datum/overmap/event/electric/major = 35,
	/datum/overmap/event/meteor/minor = 45,
	/datum/overmap/event/meteor = 40,
	/datum/overmap/event/meteor/major = 35,
	/datum/overmap/event/meteor/carp/minor = 45,
	/datum/overmap/event/meteor/carp = 35,
	/datum/overmap/event/meteor/carp/major = 20,
	/datum/overmap/event/meteor/dust = 50,
	/datum/overmap/event/anomaly = 10
))

///RADIATION STORM - explodes your organics
/datum/overmap/event/rad
	name = "radiation storm (moderate)"
	desc = "An area with a high concentration of gamma rays. Better not take long here."
	base_icon_state = "gamma_medium_"
	default_color = "#d651c2"
	spread_chance = 20
	chain_rate = 2
	chance_to_affect = 60
	interference_power = 40
	var/strength = 20

/datum/overmap/event/rad/alter_token_appearance()
	icon_suffix = "[rand(1, 4)]"
	..()
	if(current_overmap.override_object_colors)
		token.color = current_overmap.hazard_primary_color
	current_overmap.post_edit_token_state(src)

/datum/overmap/event/rad/affect_ship(datum/overmap/ship/controlled/ship)
	for(var/mob/affected_mob as anything in GLOB.player_list)
		if(!isliving(affected_mob))
			return
		if(ship.shuttle_port.is_in_shuttle_bounds(affected_mob))
			affected_mob.rad_act(strength)
			to_chat(affected_mob, span_notice("You taste metal."))


/datum/overmap/event/rad/modify_emptyspace_mapgen(datum/overmap/dynamic/our_planet)
	our_planet.weather_controller_type = /datum/weather_controller/fallout
	return ..()

/datum/overmap/event/rad/minor
	name = "radiation storm (minor)"
	base_icon_state = "gamma_minor_"
	chain_rate = 1
	strength = 5
	interference_power = 20
	chance_to_affect = 40

/datum/overmap/event/rad/major
	name = "radiation storm (major)"
	base_icon_state = "gamma_major_"
	chance_to_affect = 80
	interference_power = 60
	chain_rate = 4
	strength = 60



///METEOR STORMS - explodes your ship if you go too fast
/datum/overmap/event/meteor/debris
	name = "debris field (moderate)"
	desc = "An area full of scrap metal, going fast through here could prove dangerous"
	base_icon_state = "debris_medium_"
	default_color = "#b8ccbf"
	chance_to_affect = 15
	spread_chance = 50
	chain_rate = 4
	interference_power = 25
	var/blocks_sight = TRUE

	empty_space_mapgen = /datum/map_generator/planet_generator/asteroid

/datum/overmap/event/meteor/debris/alter_token_appearance()
	. = ..()
	if(blocks_sight)
		token.opacity = TRUE
	current_overmap.post_edit_token_state(src)


/datum/overmap/event/meteor/debris/minor
	name = "debris field (minor)"
	base_icon_state = "debris_light_"
	chain_rate = 3
	interference_power = 15

	mountain_height_override = 0.85

	blocks_sight = FALSE

	meteor_types = list(
		/obj/effect/meteor/dust=12,
		/obj/effect/meteor/medium=4,
	)

	safe_speed = 5

/datum/overmap/event/meteor/debris/major
	name = "debris field (major)"
	base_icon_state = "debris_major_"
	spread_chance = 25
	chain_rate = 6
	interference_power = 35

	mountain_height_override = 0.5

	meteor_types = list(
		/obj/effect/meteor/medium=50,
		/obj/effect/meteor/big=25,
		/obj/effect/meteor/flaming=10,
	)
