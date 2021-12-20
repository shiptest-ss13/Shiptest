SUBSYSTEM_DEF(overmap)
	name = "Overmap"
	wait = 10
	init_order = INIT_ORDER_OVERMAP
	flags = SS_NO_FIRE|SS_KEEP_TIMING|SS_NO_TICK_CHECK
	runlevels = RUNLEVEL_SETUP | RUNLEVEL_GAME

	// DEBUG FIX -- modularize this to a list
	var/datum/overmap_system/primary_system

	var/list/datum/component/overmap/spawn_location/spawn_comps

/datum/controller/subsystem/overmap/Initialize()
	primary_system = new /datum/overmap_system()
	spawn_initial_ships()
	return ..()

/datum/controller/subsystem/overmap/proc/spawn_initial_ships()
	var/datum/map_template/shuttle/selected_template = SSmapping.maplist[pick(SSmapping.maplist)]
	INIT_ANNOUNCE("Loading [selected_template.name]...")
	spawn_ship_from_template(selected_template)
	if(SSdbcore.Connect())
		var/datum/DBQuery/query_round_map_name = SSdbcore.NewQuery({"
			UPDATE [format_table_name("round")] SET map_name = :map_name WHERE id = :round_id
		"}, list("map_name" = selected_template.name, "round_id" = GLOB.round_id))
		query_round_map_name.Execute()
		qdel(query_round_map_name)

// DEBUG FIX -- this needs to be turned into a unified system for spawning overmap entities
/datum/controller/subsystem/overmap/proc/spawn_ship_from_template(datum/map_template/shuttle/ship_template)
	var/datum/overmap_ent/ship_ent = new(list(0, 0))
	// DEBUG FIX -- name assignment
	ship_ent.name = "TEST"

	ship_ent.AddComponent(/datum/component/overmap/circle_vis, 0.02*DIST_AU, "#FF2020")
	ship_ent.AddComponent(/datum/component/overmap/damageable, 100, 100)
	ship_ent.AddComponent(/datum/component/overmap/physics)
	ship_ent.AddComponent(/datum/component/overmap/spawn_location, "[ship_ent.name] ([ship_template.short_name])", ship_template.job_slots.Copy())
	var/datum/component/overmap/ship/ship_comp = ship_ent.AddComponent(/datum/component/overmap/ship)

	// DEBUG FIX -- action_load sucks, make a different proc and use that instead
	SSshuttle.action_load(ship_template, new_ship_comp = ship_comp)

	ship_comp.update_mass()

	SSovermap.primary_system.entities.Add(ship_ent)

	return ship_ent

// DEBUG FIX -- remove all below this line

/obj/structure/overmap

/obj/structure/overmap/ship

/obj/structure/overmap/ship/simulated
	var/obj/docking_port/mobile/shuttle
	var/state

/obj/structure/overmap/ship/simulated/proc/manifest_inject()
	return

/obj/structure/overmap/ship/simulated/proc/get_eta()
	return
