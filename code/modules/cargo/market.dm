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
		supply_packs[P.type] = P

/obj/machinery/computer/cargo2
	var/atom/cargo_lz
	var/datum/cargo_market/market

/obj/machinery/computer/cargo2/LateInitialize()
	. = ..()
	find_landing_zone()

/obj/machinery/computer/cargo2/proc/find_landing_zone()
	if(landing_zone)
		return TRUE
	for(var/atom/landing_zone in GLOB.cargo_landing_zones)
		if(landing_zone.virtual_z == src.virtual_z)
			cargo_lz = landing_zone
			return TRUE
	return FALSE

/obj/machinery/computer/cargo2/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "OutpostCommunications2", name)
		ui.open()

/obj/effect/landmark/cargo
	name = "cargo_lz"

/obj/effect/landmark/cargo/Initialize()
	. = ..()
	GLOB.cargo_landing_zones += src
