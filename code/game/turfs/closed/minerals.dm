/**********************Mineral deposits**************************/

/turf/closed/mineral //wall piece
	name = "rock"
	icon = 'icons/turf/walls/smoothrocks.dmi'
	icon_state = "smoothrocks-0"
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_BORDER | SMOOTH_CONNECTORS
	smoothing_groups = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_MINERAL_WALLS)
	canSmoothWith = list(SMOOTH_GROUP_MINERAL_WALLS)
	connector_icon = 'icons/turf/connectors/smoothrocks_connector.dmi'
	connector_icon_state = "smoothrocks_connector"
	no_connector_typecache = list(/turf/closed/mineral)
	baseturfs = /turf/open/floor/plating/asteroid/smoothed/airless
	initial_gas_mix = AIRLESS_ATMOS
	opacity = TRUE
	density = TRUE
	layer = EDGED_TURF_LAYER
	base_icon_state = "smoothrocks"
	var/smooth_icon = 'icons/turf/walls/smoothrocks.dmi'
	var/environment_type = "asteroid"
	var/turf/open/floor/plating/turf_type = /turf/open/floor/plating/asteroid/smoothed/airless
	var/obj/item/stack/ore/mineralType = null
	var/mineralAmt = 3
	var/last_act = 0
	var/scan_state = "" //Holder for the image we display when we're pinged by a mining scanner
	var/defer_change = 0
	var/has_borders = TRUE
	/// these vars set how much the pixels translate. This is meant for turfs that are bigger than 32x32
	var/x_offset = -4
	var/y_offset = -4

	MAP_SWITCH(pixel_x = 0, pixel_x = -4)
	MAP_SWITCH(pixel_y = 0, pixel_y = -4)

	attack_hitsound = 'sound/effects/break_stone.ogg'
	break_sound = 'sound/effects/break_stone.ogg'
	hitsound_type = PROJECTILE_HITSOUND_STONE

	min_dam = 5
	max_integrity = MINERAL_WALL_INTEGRITY
	brute_mod = 1
	burn_mod = 1

	mob_smash_flags = ENVIRONMENT_SMASH_MINERALS
	proj_bonus_damage_flags = PROJECTILE_BONUS_DAMAGE_MINERALS

	overlay_layer = ON_EDGED_TURF_LAYER

/turf/closed/mineral/Initialize(mapload, inherited_virtual_z)
	. = ..()
	if(has_borders)
		var/matrix/M = new
		M.Translate(x_offset, y_offset)
		transform = M
		icon = smooth_icon

	var/area/overmap_encounter/selected_area = get_area(src)
	if(!istype(selected_area))
		return

	RegisterSignal(src, COMSIG_OVERMAPTURF_UPDATE_LIGHT, PROC_REF(get_light))
	if(istype(selected_area))
		light_range = selected_area.light_range
		light_range = selected_area.light_range
		light_power = selected_area.light_power
		update_light()

/turf/closed/mineral/Destroy()
	. = ..()
	UnregisterSignal(src, COMSIG_OVERMAPTURF_UPDATE_LIGHT)

/turf/closed/mineral/proc/get_light(obj/item/source, target_light, target_power, target_color,)
	light_range = target_light
	light_power = target_power
	light_color = target_color
	update_light()

/turf/closed/mineral/proc/Spread_Vein()
	var/spreadChance = initial(mineralType.spreadChance)
	if(spreadChance)
		for(var/dir in GLOB.cardinals)
			if(prob(spreadChance))
				var/turf/T = get_step(src, dir)
				var/turf/closed/mineral/random/M = T
				if(istype(M) && !M.mineralType)
					M.Change_Ore(mineralType)

/turf/closed/mineral/proc/Change_Ore(ore_type, random = 0)
	if(random)
		mineralAmt = rand(1, 5)
	if(ispath(ore_type, /obj/item/stack/ore)) //If it has a scan_state, switch to it
		var/obj/item/stack/ore/the_ore = ore_type
		scan_state = initial(the_ore.scan_state) // I SAID. SWITCH. TO. IT.
		mineralType = ore_type // Everything else assumes that this is typed correctly so don't set it to non-ores thanks.

/turf/closed/mineral/get_smooth_underlay_icon(mutable_appearance/underlay_appearance, turf/asking_turf, adjacency_dir)
	if(turf_type)
		underlay_appearance.icon = initial(turf_type.icon)
		underlay_appearance.icon_state = initial(turf_type.icon_state)
		return TRUE
	return ..()

/turf/closed/mineral/try_decon(obj/item/I, mob/user, turf/T)
	var/act_duration = breakdown_duration
	if(I.tool_behaviour == TOOL_MINING)
		if(!I.tool_start_check(user, src, amount=0))
			return FALSE

		to_chat(user, span_notice("You begin breaking through the rock..."))
		while(I.use_tool(src, user, act_duration, volume=50))
			if(ismineralturf(src))
				to_chat(user, span_notice("You break through some of the stone..."))
				SSblackbox.record_feedback("tally", "pick_used_mining", 1, I.type)
				if(!alter_integrity(-(I.wall_decon_damage),user,FALSE,TRUE))
					return TRUE
			else
				break

	return FALSE

/turf/closed/mineral/dismantle_wall(devastate = FALSE,mob/user)
	var/slagged = 0
	if(devastate == TRUE)
		slagged = 100
	if(ismineralturf(src))
		gets_drilled(user, TRUE, slagged)
	else
		return FALSE

/turf/closed/mineral/proc/gets_drilled(user, give_exp = FALSE, slag_chance = 0)
	if (mineralType && (mineralAmt > 0))
		//oops, you ruined the ore
		if(prob(slag_chance))
			new /obj/item/stack/ore/slag(src,mineralAmt)
			visible_message(span_warning("The ore was completely ruined!"))
		else
			new mineralType(src, mineralAmt)
			if(ishuman(user))
				SSblackbox.record_feedback("tally", "ore_mined", mineralAmt, mineralType)
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(give_exp)
			if (mineralType && (mineralAmt > 0))
				H.mind.adjust_experience(/datum/skill/mining, initial(mineralType.mine_experience) * mineralAmt)
			else
				H.mind.adjust_experience(/datum/skill/mining, 4)

	for(var/obj/effect/temp_visual/mining_overlay/M in src)
		qdel(M)
	var/flags = NONE
	if(defer_change) // TODO: make the defer change var a var for any changeturf flag
		flags = CHANGETURF_DEFER_CHANGE
	playsound(src, break_sound, 50, TRUE) //beautiful destruction
	ScrapeAway(null, flags)
	addtimer(CALLBACK(src, PROC_REF(AfterChange)), 1, TIMER_UNIQUE)


/turf/closed/mineral/attack_animal(mob/living/simple_animal/user)
	if((!(user.environment_smash & ENVIRONMENT_SMASH_WALLS) || (user.environment_smash & ENVIRONMENT_SMASH_RWALLS) || (user.environment_smash & ENVIRONMENT_SMASH_MINERALS)))
		return ..()

	//This scrapes us away and turns us into a floor, so don't call parent.
	user.changeNext_move(CLICK_CD_MELEE)
	user.do_attack_animation(src)
	gets_drilled(user)

/turf/closed/mineral/attack_alien(mob/living/carbon/alien/M)
	balloon_alert(M, "digging...")
	playsound(src, 'sound/effects/break_stone.ogg', 50, TRUE)
	if(do_after(M, 40, target = src))
		to_chat(M, span_notice("You tunnel into the rock."))
		gets_drilled(M)

/turf/closed/mineral/Bumped(atom/movable/AM)
	..()
	if(ishuman(AM))
		var/mob/living/carbon/human/H = AM
		var/obj/item/I = H.is_holding_tool_quality(TOOL_MINING)
		if(I)
			if(last_act + (40 * I.toolspeed) > world.time)//prevents message spam
				return
			last_act = world.time
			try_decon(I, H)
		return
	else if(iscyborg(AM))
		var/mob/living/silicon/robot/R = AM
		if(R.module_active && R.module_active.tool_behaviour == TOOL_MINING)
			attackby(R.module_active, R)
			return
	else
		return

/turf/closed/mineral/acid_melt()
	ScrapeAway()

/turf/closed/mineral/ex_act(severity, target)
	switch(severity)
		if(3)
			if (prob(75))
				gets_drilled(null, FALSE)
		if(2)
			if (prob(90))
				gets_drilled(null, FALSE)
		if(1)
			gets_drilled(null, FALSE)
	return ..()

/turf/closed/mineral/random
	var/list/mineralSpawnChanceList = list(/obj/item/stack/ore/uranium = 3, /obj/item/stack/ore/gold = 4,
		/obj/item/stack/ore/plasma = 40, /obj/item/stack/ore/iron = 65, /obj/item/stack/ore/titanium = 5,
		/obj/item/stack/ore/bluespace_crystal = 1)
		//Currently, Adamantine won't spawn as it has no uses. -Durandan
	var/mineralChance = 10

/turf/closed/mineral/ship
	baseturfs = /turf/open/floor/plating/asteroid/ship
	turf_type = /turf/open/floor/plating/asteroid/ship


/turf/closed/mineral/random/Initialize(mapload, inherited_virtual_z)

	mineralSpawnChanceList = typelist("mineralSpawnChanceList", mineralSpawnChanceList)

	. = ..()
	if (prob(mineralChance))
		var/path = pick_weight(mineralSpawnChanceList)
		if(ispath(path, /turf))
			var/turf/T = ChangeTurf(path,null,CHANGETURF_IGNORE_AIR)

			T.baseturfs = src.baseturfs
			if(ismineralturf(T))
				var/turf/closed/mineral/M = T
				M.turf_type = src.turf_type
				M.mineralAmt = rand(1, 5)
				M.environment_type = src.environment_type
				src = M
				M.levelupdate()
			else
				src = T
				T.levelupdate()

		else
			Change_Ore(path, 1)
			Spread_Vein(path)

/turf/closed/mineral/random/high_chance
	mineralChance = 13
	mineralSpawnChanceList = list(
		/obj/item/stack/ore/uranium = 35, /obj/item/stack/ore/diamond = 30, /obj/item/stack/ore/gold = 45, /obj/item/stack/ore/titanium = 45,
		/obj/item/stack/ore/plasma = 50, /obj/item/stack/ore/bluespace_crystal = 20)

/turf/closed/mineral/random/high_chance/volcanic
	environment_type = "basalt"
	turf_type = /turf/open/floor/plating/asteroid/basalt/lava_land_surface
	baseturfs = /turf/open/floor/plating/asteroid/basalt/lava_land_surface
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS
	defer_change = 1
	mineralSpawnChanceList = list(
		/obj/item/stack/ore/uranium = 35, /obj/item/stack/ore/diamond = 30, /obj/item/stack/ore/gold = 45, /obj/item/stack/ore/titanium = 45,
		/obj/item/stack/ore/plasma = 50, /obj/item/stack/ore/bluespace_crystal)

/turf/closed/mineral/random/low_chance
	mineralChance = 3
	mineralSpawnChanceList = list(
		/obj/item/stack/ore/uranium = 2, /obj/item/stack/ore/diamond = 1, /obj/item/stack/ore/gold = 4, /obj/item/stack/ore/titanium = 4,
		/obj/item/stack/ore/plasma = 15, /obj/item/stack/ore/iron = 40,
		/obj/item/stack/ore/bluespace_crystal = 1)


/turf/closed/mineral/random/volcanic
	name = "basalt"
	desc = "Eruptions stack like layer-cake, forming vast oceans of dried magma."
	icon_state = "smoothrocks-0"
	environment_type = "basalt"
	turf_type = /turf/open/floor/plating/asteroid/basalt/lava_land_surface
	baseturfs = /turf/open/floor/plating/asteroid/basalt/lava_land_surface
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS
	defer_change = 1

	mineralChance = 10
	mineralSpawnChanceList = list(
		/obj/item/stack/ore/uranium = 5, /obj/item/stack/ore/diamond = 1, /obj/item/stack/ore/silver = 11,
		/obj/item/stack/ore/plasma = 20, /obj/item/stack/ore/iron = 20,
		/obj/item/stack/ore/bluespace_crystal = 1, /obj/item/stack/ore/gold = 2
		)

/turf/closed/mineral/random/snow
	name = "schist"
	desc = "Say it fives times fast."
	icon = 'icons/turf/walls/rockwall_icemoon.dmi'
	smooth_icon = 'icons/turf/walls/rockwall_icemoon.dmi'
	icon_state = "rockwall_icemoon-0"
	base_icon_state = "rockwall_icemoon"
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_BORDER
	canSmoothWith = list(SMOOTH_GROUP_MINERAL_WALLS)
	environment_type = "snow_cavern"
	turf_type = /turf/open/floor/plating/asteroid/icerock
	baseturfs = /turf/open/floor/plating/asteroid/icerock
	initial_gas_mix = ICEMOON_DEFAULT_ATMOS
	defer_change = TRUE
	mineralChance = 20 //as most caves is snowy, might as well bump up the chance
	mineralSpawnChanceList = list(
		/obj/item/stack/ore/uranium = 10, /obj/item/stack/ore/diamond = 2, /obj/item/stack/ore/gold = 20, /obj/item/stack/ore/titanium = 15,
		/obj/item/stack/ore/plasma = 10, /obj/item/stack/ore/iron = 20,
		/obj/item/stack/ore/bluespace_crystal = 1, /obj/item/stack/ore/silver = 10)

/turf/closed/mineral/ice
	name = "icy wall"
	desc = "Frozen water forms wavy patterns, an ocean frozen in pantomime."
	icon = 'icons/turf/walls/icewall.dmi'
	smooth_icon = 'icons/turf/walls/icewall.dmi'
	icon_state = "icewall-0"
	base_icon_state = "icewall"
	defer_change = TRUE
	environment_type = "snow_cavern"
	turf_type = /turf/open/floor/plating/asteroid/iceberg/lit
	baseturfs = /turf/open/floor/plating/asteroid/iceberg/lit
	initial_gas_mix = ICEMOON_DEFAULT_ATMOS
	opacity = FALSE
	light_range = 2
	light_power = 1
	mineralType = /obj/item/stack/ore/ice

/turf/closed/mineral/random/snow/underground
	baseturfs = /turf/open/floor/plating/asteroid/snow/icemoon
	// abundant ore
	mineralChance = 10
	mineralSpawnChanceList = list(
		/obj/item/stack/ore/uranium = 10, /obj/item/stack/ore/diamond = 4, /obj/item/stack/ore/gold = 20, /obj/item/stack/ore/titanium = 22,
		/obj/item/stack/ore/plasma = 20, /obj/item/stack/ore/iron = 20,
		/obj/item/stack/ore/bluespace_crystal = 2)

/turf/closed/mineral/random/snow/high_chance
	mineralSpawnChanceList = list(
		/obj/item/stack/ore/uranium = 35, /obj/item/stack/ore/diamond  = 30, /obj/item/stack/ore/gold = 45, /obj/item/stack/ore/titanium = 45,
		/obj/item/stack/ore/plasma = 50, /obj/item/stack/ore/bluespace_crystal = 20)

/turf/closed/mineral/random/labormineral
	mineralSpawnChanceList = list(
		/obj/item/stack/ore/uranium = 3, /obj/item/stack/ore/diamond = 1, /obj/item/stack/ore/gold = 8, /obj/item/stack/ore/titanium = 8,
		/obj/item/stack/ore/plasma = 30, /obj/item/stack/ore/iron = 95)


/turf/closed/mineral/random/labormineral/volcanic
	environment_type = "basalt"
	turf_type = /turf/open/floor/plating/asteroid/basalt/lava_land_surface
	baseturfs = /turf/open/floor/plating/asteroid/basalt/lava_land_surface
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS
	defer_change = 1
	mineralSpawnChanceList = list(
		/obj/item/stack/ore/uranium = 3, /obj/item/stack/ore/diamond = 1, /obj/item/stack/ore/gold = 8, /obj/item/stack/ore/titanium = 8,
		/obj/item/stack/ore/plasma = 30, /obj/item/stack/ore/bluespace_crystal = 1,
		/obj/item/stack/ore/iron = 95)

// Subtypes for mappers placing ores manually.
/turf/closed/mineral/random/labormineral/ice
	name = "snowy mountainside"
	smooth_icon = 'icons/turf/walls/mountain_wall.dmi'
	base_icon_state = "mountain_wall"
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_BORDER | SMOOTH_CONNECTORS
	connector_icon = 'icons/turf/connectors/mountain_wall_connector.dmi'
	connector_icon_state = "mountain_wall_connector"
	no_connector_typecache = list(/turf/closed/mineral/random/labormineral/ice)
	defer_change = TRUE
	environment_type = "snow"
	turf_type = /turf/open/floor/plating/asteroid/snow/icemoon
	baseturfs = /turf/open/floor/plating/asteroid/snow/icemoon
	initial_gas_mix = ICEMOON_DEFAULT_ATMOS
	defer_change = TRUE
	mineralSpawnChanceList = list(
		/obj/item/stack/ore/uranium = 3, /obj/item/stack/ore/diamond = 1, /obj/item/stack/ore/gold = 8, /obj/item/stack/ore/titanium = 8,
		/obj/item/stack/ore/plasma = 30, /obj/item/stack/ore/bluespace_crystal = 1,
		/obj/item/stack/ore/iron = 95)

/turf/closed/mineral/iron
	mineralType = /obj/item/stack/ore/iron
	scan_state = "rock_Iron"

/turf/closed/mineral/iron/ice
	environment_type = "snow_cavern"
	icon = 'icons/turf/walls/icerock_wall.dmi'
	icon_state = "icerock_wall-0"
	smooth_icon = 'icons/turf/walls/icerock_wall.dmi'
	base_icon_state = "icerock_wall"
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_BORDER | SMOOTH_CONNECTORS
	connector_icon = 'icons/turf/connectors/icerock_wall_connector.dmi'
	connector_icon_state = "icerock_wall_connector"
	no_connector_typecache = list(/turf/closed/mineral/iron/ice, /turf/closed/mineral/plasma/ice)
	turf_type = /turf/open/floor/plating/asteroid/snow/ice
	baseturfs = /turf/open/floor/plating/asteroid/snow/ice
	initial_gas_mix = FROZEN_ATMOS
	defer_change = TRUE

/turf/closed/mineral/uranium
	mineralType = /obj/item/stack/ore/uranium
	scan_state = "rock_Uranium"

/turf/closed/mineral/diamond
	mineralType = /obj/item/stack/ore/diamond
	scan_state = "rock_Diamond"

/turf/closed/mineral/gold
	mineralType = /obj/item/stack/ore/gold
	scan_state = "rock_Gold"

/turf/closed/mineral/gold/volcanic
	environment_type = "basalt"
	turf_type = /turf/open/floor/plating/asteroid/basalt/lava_land_surface
	baseturfs = /turf/open/floor/plating/asteroid/basalt/lava_land_surface
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS
	defer_change = TRUE

/turf/closed/mineral/silver
	mineralType = /obj/item/stack/ore/silver
	scan_state = "rock_Silver"

/turf/closed/mineral/silver/ice/icemoon
	turf_type = /turf/open/floor/plating/asteroid/snow/ice/icemoon
	baseturfs = /turf/open/floor/plating/asteroid/snow/ice/icemoon
	initial_gas_mix = ICEMOON_DEFAULT_ATMOS

/turf/closed/mineral/titanium
	mineralType = /obj/item/stack/ore/titanium
	scan_state = "rock_Titanium"

/turf/closed/mineral/plasma
	mineralType = /obj/item/stack/ore/plasma
	scan_state = "rock_Plasma"

/turf/closed/mineral/plasma/ice
	environment_type = "snow_cavern"
	icon = 'icons/turf/walls/icerock_wall.dmi'
	icon_state = "icerock_wall-0"
	smooth_icon = 'icons/turf/walls/icerock_wall.dmi'
	base_icon_state = "icerock_wall"
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_BORDER | SMOOTH_CONNECTORS
	connector_icon = 'icons/turf/connectors/icerock_wall_connector.dmi'
	connector_icon_state = "icerock_wall_connector"
	no_connector_typecache = list(/turf/closed/mineral/plasma/ice, /turf/closed/mineral/iron/ice)
	turf_type = /turf/open/floor/plating/asteroid/snow/ice
	baseturfs = /turf/open/floor/plating/asteroid/snow/ice
	initial_gas_mix = FROZEN_ATMOS
	defer_change = TRUE

/turf/closed/mineral/bscrystal
	mineralType = /obj/item/stack/ore/bluespace_crystal
	mineralAmt = 1
	scan_state = "rock_BScrystal"

/turf/closed/mineral/bscrystal/volcanic
	environment_type = "basalt"
	turf_type = /turf/open/floor/plating/asteroid/basalt/lava_land_surface
	baseturfs = /turf/open/floor/plating/asteroid/basalt/lava_land_surface
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS
	defer_change = TRUE

/turf/closed/mineral/volcanic
	environment_type = "basalt"
	turf_type = /turf/open/floor/plating/asteroid/basalt
	baseturfs = /turf/open/floor/plating/asteroid/basalt
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS

/turf/closed/mineral/volcanic/lava_land_surface
	environment_type = "basalt"
	turf_type = /turf/open/floor/plating/asteroid/basalt/lava_land_surface
	baseturfs = /turf/open/floor/plating/asteroid/basalt/lava_land_surface
	defer_change = TRUE

/turf/closed/mineral/ash_rock //wall piece
	name = "rock"
	icon = 'icons/turf/mining.dmi'
	smooth_icon = 'icons/turf/walls/rock_wall.dmi'
	icon_state = "rock2"
	base_icon_state = "rock_wall"
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_BORDER
	canSmoothWith = list(SMOOTH_GROUP_CLOSED_TURFS)
	baseturfs = /turf/open/floor/plating/ashplanet/wateryrock
	initial_gas_mix = OPENTURF_LOW_PRESSURE
	environment_type = "waste"
	turf_type = /turf/open/floor/plating/ashplanet/rocky
	defer_change = TRUE

/turf/closed/mineral/snowmountain
	name = "snowy mountainside"
	icon = 'icons/turf/mining.dmi'
	smooth_icon = 'icons/turf/walls/mountain_wall.dmi'
	icon_state = "mountainrock"
	base_icon_state = "mountain_wall"
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_BORDER
	canSmoothWith = list(SMOOTH_GROUP_CLOSED_TURFS)
	baseturfs = /turf/open/floor/plating/asteroid/icerock
	initial_gas_mix = FROZEN_ATMOS
	environment_type = "snow"
	turf_type = /turf/open/floor/plating/asteroid/icerock
	defer_change = TRUE

/turf/closed/mineral/snowmountain/icemoon
	turf_type = /turf/open/floor/plating/asteroid/snow/icemoon
	baseturfs = /turf/open/floor/plating/asteroid/snow/icemoon
	initial_gas_mix = ICEMOON_DEFAULT_ATMOS

/turf/closed/mineral/snowmountain/cavern
	name = "ice cavern rock"
	icon = 'icons/turf/mining.dmi'
	smooth_icon = 'icons/turf/walls/icerock_wall.dmi'
	icon_state = "icerock"
	base_icon_state = "icerock_wall"
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_BORDER
	baseturfs = /turf/open/floor/plating/asteroid/icerock
	environment_type = "snow_cavern"
	turf_type = /turf/open/floor/plating/asteroid/icerock

/turf/closed/mineral/snowmountain/cavern/icemoon
	baseturfs = /turf/open/floor/plating/asteroid/icerock
	turf_type = /turf/open/floor/plating/asteroid/icerock
	initial_gas_mix = ICEMOON_DEFAULT_ATMOS

//yoo RED ROCK RED ROCK

/turf/closed/mineral/asteroid
	name = "iron rock"
	icon = 'icons/turf/mining.dmi'
	icon_state = "redrock"
	smooth_icon = 'icons/turf/walls/red_wall.dmi'
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_BORDER | SMOOTH_CONNECTORS
	connector_icon = 'icons/turf/connectors/red_wall_connector.dmi'
	connector_icon_state = "red_wall_connector"
	no_connector_typecache = list(/turf/closed/mineral/asteroid)
	base_icon_state = "red_wall"
//GIBTONITE


/turf/closed/mineral/gibtonite
	mineralAmt = 1
	scan_state = "rock_Gibtonite"
	var/det_time = 8 //Countdown till explosion, but also rewards the player for how close you were to detonation when you defuse it
	var/stage = GIBTONITE_UNSTRUCK //How far into the lifecycle of gibtonite we are
	var/activated_ckey = null //These are to track who triggered the gibtonite deposit for logging purposes
	var/activated_name = null
	var/mutable_appearance/activated_overlay

/turf/closed/mineral/gibtonite/Initialize(mapload, inherited_virtual_z)
	det_time = rand(8,10) //So you don't know exactly when the hot potato will explode
	. = ..()

/turf/closed/mineral/gibtonite/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/mining_scanner) || istype(I, /obj/item/t_scanner/adv_mining_scanner) && stage == 1)
		user.visible_message(span_notice("[user] holds [I] to [src]..."), span_notice("You use [I] to locate where to cut off the chain reaction and attempt to stop it..."))
		defuse()
	..()

/turf/closed/mineral/gibtonite/proc/explosive_reaction(mob/user = null, triggered_by_explosion = 0)
	if(stage == GIBTONITE_UNSTRUCK)
		activated_overlay = mutable_appearance('icons/turf/walls/smoothrocks.dmi', "rock_Gibtonite_active", ON_EDGED_TURF_LAYER)
		add_overlay(activated_overlay)
		name = "gibtonite deposit"
		desc = "An active gibtonite reserve. Run!"
		stage = GIBTONITE_ACTIVE
		visible_message(span_danger("There's gibtonite inside! It's going to explode!"))

		var/notify_admins = 0
		if(z != 5)
			notify_admins = TRUE

		if(!triggered_by_explosion)
			log_bomber(user, "has trigged a gibtonite deposit reaction via", src, null, notify_admins)
		else
			log_bomber(null, "An explosion has triggered a gibtonite deposit reaction via", src, null, notify_admins)

		countdown(notify_admins)

/turf/closed/mineral/gibtonite/proc/countdown(notify_admins = 0)
	set waitfor = 0
	while(istype(src, /turf/closed/mineral/gibtonite) && stage == GIBTONITE_ACTIVE && det_time > 0 && mineralAmt >= 1)
		det_time--
		sleep(5)
	if(istype(src, /turf/closed/mineral/gibtonite))
		if(stage == GIBTONITE_ACTIVE && det_time <= 0 && mineralAmt >= 1)
			var/turf/bombturf = get_turf(src)
			mineralAmt = 0
			stage = GIBTONITE_DETONATE
			explosion(bombturf,1,2,5, adminlog = notify_admins)

/turf/closed/mineral/gibtonite/proc/defuse()
	if(stage == GIBTONITE_ACTIVE)
		cut_overlay(activated_overlay)
		activated_overlay.icon_state = "rock_Gibtonite_inactive"
		add_overlay(activated_overlay)
		desc = "An inactive gibtonite reserve. The ore can be extracted."
		stage = GIBTONITE_STABLE
		if(det_time < 0)
			det_time = 0
		visible_message(span_notice("The chain reaction stopped! The gibtonite had [det_time] reactions left till the explosion!"))

/turf/closed/mineral/gibtonite/gets_drilled(mob/user, triggered_by_explosion = 0)
	if(stage == GIBTONITE_UNSTRUCK && mineralAmt >= 1) //Gibtonite deposit is activated
		playsound(src,'sound/effects/hit_on_shattered_glass.ogg',50,TRUE)
		explosive_reaction(user, triggered_by_explosion)
		return
	if(stage == GIBTONITE_ACTIVE && mineralAmt >= 1) //Gibtonite deposit goes kaboom
		var/turf/bombturf = get_turf(src)
		mineralAmt = 0
		stage = GIBTONITE_DETONATE
		explosion(bombturf,0,1,3, adminlog = 0) //If detonated prematuraly, does very little damage
	if(stage == GIBTONITE_STABLE) //Gibtonite deposit is now benign and extractable. Depending on how close you were to it blowing up before defusing, you get better quality ore.
		var/obj/item/gibtonite/G = new (src)
		if(det_time <= 0)
			G.quality = 3
			G.icon_state = "Gibtonite ore 3"
		if(det_time >= 1 && det_time <= 2)
			G.quality = 2
			G.icon_state = "Gibtonite ore 2"

	var/flags = NONE
	if(defer_change)
		flags = CHANGETURF_DEFER_CHANGE
	ScrapeAway(null, flags)
	addtimer(CALLBACK(src, PROC_REF(AfterChange)), 1, TIMER_UNIQUE)


/turf/closed/mineral/gibtonite/volcanic
	environment_type = "basalt"
	turf_type = /turf/open/floor/plating/asteroid/basalt/lava_land_surface
	baseturfs = /turf/open/floor/plating/asteroid/basalt/lava_land_surface
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS
	defer_change = TRUE

/turf/closed/mineral/gibtonite/ice
	environment_type = "snow_cavern"
	icon = 'icons/turf/walls/rockwall_icemoon.dmi'
	smooth_icon = 'icons/turf/walls/rockwall_icemoon.dmi'
	icon_state = "rockwall_icemoon-0"
	base_icon_state = "rockwall_icemoon"
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_BORDER
	turf_type = /turf/open/floor/plating/asteroid/snow/ice
	baseturfs = /turf/open/floor/plating/asteroid/snow/ice
	initial_gas_mix = FROZEN_ATMOS
	defer_change = TRUE

/turf/closed/mineral/gibtonite/ice/icemoon
	turf_type = /turf/open/floor/plating/asteroid/icerock
	baseturfs = /turf/open/floor/plating/asteroid/icerock
	initial_gas_mix = ICEMOON_DEFAULT_ATMOS
	defer_change = TRUE

/turf/closed/mineral/strong
	name = "Very strong rock"
	desc = "Seems to be stronger than the other rocks in the area. Only a master of mining techniques could destroy this."
	environment_type = "basalt"
	turf_type = /turf/open/floor/plating/asteroid/basalt/lava_land_surface
	baseturfs = /turf/open/floor/plating/asteroid/basalt/lava_land_surface
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS
	defer_change = 1
	smooth_icon = 'icons/turf/walls/rock_wall.dmi'
	base_icon_state = "rock_wall"
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_BORDER

/turf/closed/mineral/strong/attackby(obj/item/I, mob/user, params)
	if(!ishuman(user))
		to_chat(usr, span_warning("Only a more advanced species could break a rock such as this one!"))
		return FALSE
	var/mob/living/carbon/human/H = user
	if(H.mind.get_skill_level(/datum/skill/mining) >= SKILL_LEVEL_MASTER)
		. = ..()
	else
		to_chat(usr, span_warning("The rock seems to be too strong to destroy. Maybe I can break it once I become a master miner."))


/turf/closed/mineral/strong/gets_drilled(mob/user)
	if(!ishuman(user))
		return // see attackby
	var/mob/living/carbon/human/H = user
	if(!(H.mind.get_skill_level(/datum/skill/mining) >= SKILL_LEVEL_MASTER))
		return
	drop_ores()
	H.client.give_award(/datum/award/achievement/skill/legendary_miner, H)
	var/flags = NONE
	if(defer_change) // TODO: make the defer change var a var for any changeturf flag
		flags = CHANGETURF_DEFER_CHANGE
	ScrapeAway(flags=flags)
	addtimer(CALLBACK(src, PROC_REF(AfterChange)), 1, TIMER_UNIQUE)
	playsound(src, 'sound/effects/break_stone.ogg', 50, TRUE) //beautiful destruction
	H.mind.adjust_experience(/datum/skill/mining, 100) //yay!

/turf/closed/mineral/strong/proc/drop_ores()
	new /obj/item/stack/sheet/mineral/hidden/hellstone(src, 5)

/turf/closed/mineral/strong/acid_melt()
	return

/turf/closed/mineral/strong/ex_act(severity, target)
	return


/turf/closed/mineral/iron/whitesands
	icon = 'icons/turf/walls/ws_walls.dmi'
	smooth_icon = 'icons/turf/walls/ws_walls.dmi'
	environment_type = WHITESANDS_WALL_ENV
	turf_type = /turf/open/floor/plating/asteroid/whitesands
	baseturfs = /turf/open/floor/plating/asteroid/whitesands/dried
	initial_gas_mix = SANDPLANET_DEFAULT_ATMOS
	defer_change = TRUE
	has_borders = TRUE

/turf/closed/mineral/uranium/whitesands
	icon = 'icons/turf/walls/ws_walls.dmi'
	smooth_icon = 'icons/turf/walls/ws_walls.dmi'
	environment_type = WHITESANDS_WALL_ENV
	turf_type = /turf/open/floor/plating/asteroid/whitesands
	baseturfs = /turf/open/floor/plating/asteroid/whitesands/dried
	initial_gas_mix = SANDPLANET_DEFAULT_ATMOS
	defer_change = TRUE
	has_borders = TRUE

/turf/closed/mineral/diamond/whitesands
	icon = 'icons/turf/walls/ws_walls.dmi'
	smooth_icon = 'icons/turf/walls/ws_walls.dmi'
	environment_type = WHITESANDS_WALL_ENV
	turf_type = /turf/open/floor/plating/asteroid/whitesands
	baseturfs = /turf/open/floor/plating/asteroid/whitesands/dried
	initial_gas_mix = SANDPLANET_DEFAULT_ATMOS
	defer_change = TRUE
	has_borders = TRUE

/turf/closed/mineral/plasma/whitesands
	icon = 'icons/turf/walls/ws_walls.dmi'
	smooth_icon = 'icons/turf/walls/ws_walls.dmi'
	environment_type = WHITESANDS_WALL_ENV
	turf_type = /turf/open/floor/plating/asteroid/whitesands
	baseturfs = /turf/open/floor/plating/asteroid/whitesands/dried
	initial_gas_mix = SANDPLANET_DEFAULT_ATMOS
	defer_change = TRUE
	has_borders = TRUE

/turf/closed/mineral/bscrystal/whitesands
	icon = 'icons/turf/walls/ws_walls.dmi'
	smooth_icon = 'icons/turf/walls/ws_walls.dmi'
	environment_type = WHITESANDS_WALL_ENV
	turf_type = /turf/open/floor/plating/asteroid/whitesands
	baseturfs = /turf/open/floor/plating/asteroid/whitesands/dried
	initial_gas_mix = SANDPLANET_DEFAULT_ATMOS
	defer_change = TRUE
	has_borders = TRUE

/turf/closed/mineral/gibtonite/whitesands
	icon = 'icons/turf/walls/ws_walls.dmi'
	smooth_icon = 'icons/turf/walls/ws_walls.dmi'
	environment_type = WHITESANDS_WALL_ENV
	turf_type = /turf/open/floor/plating/asteroid/whitesands
	baseturfs = /turf/open/floor/plating/asteroid/whitesands/dried
	initial_gas_mix = SANDPLANET_DEFAULT_ATMOS
	defer_change = TRUE
	has_borders = TRUE

/turf/closed/mineral/random/whitesands
	name = "limestone"
	desc = "The powdered remains of what once lived here, under the endless sea."
	icon = 'icons/turf/walls/ws_walls.dmi'
	icon_state = "smoothrocks-0"
	smooth_icon = 'icons/turf/walls/ws_walls.dmi'
	environment_type = WHITESANDS_WALL_ENV
	turf_type = /turf/open/floor/plating/asteroid/whitesands
	baseturfs = /turf/open/floor/plating/asteroid/whitesands/dried
	mineralSpawnChanceList = list(/obj/item/stack/ore/uranium = 5, /obj/item/stack/ore/diamond = 3,
		/obj/item/stack/ore/plasma = 10, /obj/item/stack/ore/iron = 45, /obj/item/stack/ore/titanium = 20,
		/turf/open/floor/plating/asteroid/whitesands = 2, /obj/item/stack/ore/bluespace_crystal = 4)
	initial_gas_mix = SANDPLANET_DEFAULT_ATMOS
	defer_change = TRUE
	has_borders = TRUE

/turf/closed/mineral/random/whitesands/lit
	light_range = 2
	light_power = 0.6
	light_color = COLOR_VERY_LIGHT_GRAY
	turf_type = /turf/open/floor/plating/asteroid/whitesands/lit
	baseturfs = /turf/open/floor/plating/asteroid/whitesands/dried/lit

/turf/closed/mineral/random/high_chance/whitesands
	icon = 'icons/turf/walls/ws_walls.dmi'
	icon_state = "smoothrocks-0"
	smooth_icon = 'icons/turf/walls/ws_walls.dmi'
	environment_type = WHITESANDS_WALL_ENV
	turf_type = /turf/open/floor/plating/asteroid/whitesands
	baseturfs = /turf/open/floor/plating/asteroid/whitesands/dried
	initial_gas_mix = SANDPLANET_DEFAULT_ATMOS
	defer_change = TRUE
	has_borders = TRUE

/turf/closed/mineral/random/labormineral/whitesands
	icon = 'icons/turf/walls/ws_walls.dmi'
	smooth_icon = 'icons/turf/walls/ws_walls.dmi'
	environment_type = WHITESANDS_WALL_ENV
	turf_type = /turf/open/floor/plating/asteroid/whitesands
	baseturfs = /turf/open/floor/plating/asteroid/whitesands/dried
	initial_gas_mix = SANDPLANET_DEFAULT_ATMOS
	defer_change = TRUE
	has_borders = TRUE

/turf/closed/mineral/random/low_chance
	icon = 'icons/turf/walls/ws_walls.dmi'
	smooth_icon = 'icons/turf/walls/ws_walls.dmi'
	environment_type = WHITESANDS_WALL_ENV
	turf_type = /turf/open/floor/plating/asteroid/whitesands
	baseturfs = /turf/open/floor/plating/asteroid/whitesands/dried
	initial_gas_mix = SANDPLANET_DEFAULT_ATMOS
	defer_change = TRUE
	has_borders = TRUE

/turf/closed/mineral/random/jungle
	name = "bauxite"
	desc = "Silt and mud are mummified, taking a rigid shape in the morning sun."
	icon = 'icons/turf/walls/jungle_wall.dmi'
	smooth_icon = 'icons/turf/walls/jungle_wall.dmi'
	icon_state = "jungle_wall-0"
	base_icon_state = "jungle_wall"
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_BORDER
	canSmoothWith = list(SMOOTH_GROUP_MINERAL_WALLS)
	turf_type = /turf/open/floor/plating/asteroid/dirt/jungle
	baseturfs = /turf/open/floor/plating/asteroid/dirt/jungle

	mineralChance = 16

	mineralSpawnChanceList = list(/obj/item/stack/ore/uranium = 2, /obj/item/stack/ore/diamond = 10, /obj/item/stack/ore/gold = 30,
		/obj/item/stack/ore/silver = 20, /obj/item/stack/ore/iron = 20, /obj/item/stack/ore/titanium = 4
		)

/turf/closed/mineral/random/beach
	name = "coastal marl"
	desc = "Water eats away at the shoreline, forming rippling scars in softening stone."
	baseturfs = /turf/open/floor/plating/asteroid/sand/dense
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS

/turf/closed/mineral/random/rockplanet
	name = "hematite"
	desc = "Iron grit rusts softly, bringing forth a crimson hue."
	icon = 'icons/turf/walls/red_wall.dmi'
	icon_state = "red_wall-0"
	smooth_icon = 'icons/turf/walls/red_wall.dmi'
	base_icon_state = "red_wall"
	initial_gas_mix = ROCKPLANET_DEFAULT_ATMOS
	baseturfs = /turf/open/floor/plating/asteroid/rockplanet
	turf_type = /turf/open/floor/plating/asteroid/rockplanet
	mineralSpawnChanceList = list(
		/obj/item/stack/ore/uranium = 5, /obj/item/stack/ore/diamond = 1, /obj/item/stack/ore/gold = 4,
		/obj/item/stack/ore/iron = 80,
		/obj/item/stack/ore/bluespace_crystal = 1)

/turf/closed/mineral/gibtonite/rockplanet
	name = "hematite"
	desc = "Iron grit rusts softly, bringing forth a crimson hue."
	icon = 'icons/turf/walls/red_wall.dmi'
	icon_state = "red_wall-0"
	smooth_icon = 'icons/turf/walls/red_wall.dmi'
	base_icon_state = "red_wall"

/turf/closed/mineral/random/wasteplanet
	name = "polluted rock"
	desc = "Whatever once held sway, the poison is all that remains."
	icon = 'icons/turf/walls/wasteplanet.dmi'
	icon_state = "wasteplanet-0"
	smooth_icon = 'icons/turf/walls/wasteplanet.dmi'
	base_icon_state = "wasteplanet"
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	baseturfs = /turf/open/floor/plating/asteroid/wasteplanet
	mineralSpawnChanceList = list(
		/obj/item/stack/ore/uranium = 30, /obj/item/stack/ore/diamond = 0.5, /obj/item/stack/ore/gold = 4, /obj/item/stack/ore/silver = 5,
		/obj/item/stack/ore/iron = 40, /obj/item/stack/ore/plasma = 35,
		)

	mineralChance = 20

/turf/closed/mineral/random/desert
	name = "canyon wall"
	icon = 'icons/turf/walls/desert.dmi'
	smooth_icon = 'icons/turf/walls/desert.dmi'
	icon_state = "desert-0"
	base_icon_state = "desert"
	initial_gas_mix = DESERT_DEFAULT_ATMOS
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_BORDER
	canSmoothWith = list(SMOOTH_GROUP_CLOSED_TURFS)
	turf_type = /turf/open/floor/plating/asteroid/dry_seafloor
	baseturfs = /turf/open/floor/plating/asteroid/dry_seafloor
	mineralSpawnChanceList = list(/obj/item/stack/ore/uranium = 10, /obj/item/stack/ore/diamond = 5, /obj/item/stack/ore/gold = 20,
		/obj/item/stack/ore/plasma = 5, /obj/item/stack/ore/iron = 20, /obj/item/stack/ore/titanium = 4
		)

/turf/closed/mineral/random/shrouded
	name = "shrouded wall"
	icon = 'icons/turf/walls/shroudedwall.dmi'
	smooth_icon = 'icons/turf/walls/shroudedwall.dmi'
	icon_state = "shrouded-0"
	base_icon_state = "shrouded"
	initial_gas_mix = SHROUDED_DEFAULT_ATMOS
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_BORDER
	canSmoothWith = list(SMOOTH_GROUP_CLOSED_TURFS)
	turf_type = /turf/open/floor/plating/asteroid/shrouded
	baseturfs = /turf/open/floor/plating/asteroid/shrouded
	mineralSpawnChanceList = list(/obj/item/stack/ore/uranium = 30, /obj/item/stack/ore/diamond = 1, /obj/item/stack/ore/gold = 5,
		/obj/item/stack/ore/plasma = 25, /obj/item/stack/ore/iron = 20, /obj/item/stack/ore/titanium = 6,
		/obj/item/stack/ore/bluespace_crystal = 10)

/turf/closed/mineral/random/waterplanet
	environment_type = "water"
	turf_type = /turf/open/floor/plating/asteroid/waterplanet
	baseturfs = /turf/open/floor/plating/asteroid/waterplanet
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS
	defer_change = 1
	mineralChance = 10
	mineralSpawnChanceList = list(
		/obj/item/stack/ore/diamond = 5, /obj/item/stack/ore/silver = 11,
		/obj/item/stack/ore/plasma = 5, /obj/item/stack/ore/iron = 30, /obj/item/stack/ore/ice = 10,
		/obj/item/stack/ore/gold = 2,
		)


/turf/closed/mineral/snowmountain/cavern/shipside
	name = "ice cavern rock"
	icon = 'icons/turf/mining.dmi'
	smooth_icon = 'icons/turf/walls/icerock_wall.dmi'
	icon_state = "icerock"
	base_icon_state = "icerock_wall"
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_BORDER
	baseturfs = /turf/open/floor/plating
	environment_type = "snow_cavern"
	turf_type = /turf/open/floor/plating

/turf/closed/mineral/random/moon
	name = "moonrock"
	desc = "A great portal conductor, supposedly."
	icon = 'icons/turf/walls/moon.dmi'
	smooth_icon = 'icons/turf/walls/moon.dmi'
	icon_state = "moon-0"
	base_icon_state = "moon"
	initial_gas_mix = AIRLESS_ATMOS
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_BORDER
	canSmoothWith = list(SMOOTH_GROUP_CLOSED_TURFS)
	turf_type = /turf/open/floor/plating/asteroid/moon_coarse/dark
	baseturfs = /turf/open/floor/plating/asteroid/moon_coarse/dark
	mineralSpawnChanceList = list(/obj/item/stack/ore/uranium = 2, /obj/item/stack/ore/diamond = 1, /obj/item/stack/ore/gold = 5,
		/obj/item/stack/ore/plasma = 1, /obj/item/stack/ore/iron = 40, /obj/item/stack/ore/titanium = 20,
		/obj/item/stack/ore/bluespace_crystal = 5)

/turf/closed/mineral/random/moon/safe

	initial_gas_mix = "o2=22;n2=82;TEMP=293.15"
	baseturfs = /turf/open/floor/plating/asteroid/moon/safe

/turf/closed/mineral/random/moon/lit
	turf_type = /turf/open/floor/plating/asteroid/moon_coarse/dark/lit
	baseturfs = /turf/open/floor/plating/asteroid/moon_coarse/dark/lit
