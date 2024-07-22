GLOBAL_LIST_EMPTY(cargo_landing_zones)

/datum/cargo_market
	var/supply_blocked = FALSE
	/// Order number given to next cargo order
	var/ordernum = 1
	/// List of singleton supply pack instances
	var/list/datum/supply_pack/supply_packs = list()

/datum/cargo_market/New()
	SScargo.markets += src
	ordernum = rand(1, 9000)
	generate_supply_packs()

// Hopefully this can be used for custom markets for events and stuff.
/datum/cargo_market/proc/generate_supply_packs()
	for(var/pack in subtypesof(/datum/supply_pack))
		var/datum/supply_pack/P = new pack()
		if(!P.contains)
			continue
		supply_packs += P

/obj/machinery/computer/outpost_cargo
	var/atom/cargo_lz
	var/datum/cargo_market/market

/obj/machinery/computer/outpost_cargo/LateInitialize()
	. = ..()
	find_landing_zone()
	find_market()

/obj/machinery/computer/outpost_cargo/proc/find_landing_zone()
	if(cargo_lz)
		return TRUE
	for(var/atom/landing_zone in GLOB.cargo_landing_zones)
		if(landing_zone.virtual_z() == src.virtual_z())
			cargo_lz = landing_zone
			return TRUE
	return FALSE

/obj/machinery/computer/outpost_cargo/proc/find_outpost()
	for(var/datum/overmap/outpost/target_outpost in SSovermap.outposts)
		var/datum/map_zone/mapzone = target_outpost.mapzone
		for(var/datum/virtual_level/z_level in mapzone.virtual_levels)
			if (src.virtual_z() == z_level.id)
				return target_outpost

/obj/machinery/computer/outpost_cargo/proc/find_market()
	var/datum/overmap/outpost/target_outpost = find_outpost()
	market = target_outpost.market

/obj/machinery/computer/outpost_cargo/proc/get_cargo_packs()
	if(!market)
		return
	return market.supply_packs


/obj/machinery/computer/outpost_cargo/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "OutpostCargo", name)
		ui.open()

/obj/machinery/computer/outpost_cargo/ui_static_data(mob/user)
	var/list/data = list()
	data["supply_packs"] = list()
	for(var/datum/supply_pack/cargo_pack in get_cargo_packs())
		data["supply_packs"] += list(list(
			"ref" = REF(cargo_pack),
			"name" = cargo_pack.name,
			"group" = cargo_pack.group,
			"cost" = cargo_pack.cost,
			"id" = cargo_pack,
			"desc" = cargo_pack.desc || cargo_pack.name, // If there is a description, use it. Otherwise use the pack's name.
		))
	return data

/obj/effect/landmark/cargo
	name = "cargo_lz"
	icon_state = "cargo_landmark"
	invisibility = INVISIBILITY_OBSERVER

/obj/effect/landmark/cargo/Initialize()
	. = ..()
	GLOB.cargo_landing_zones += src
