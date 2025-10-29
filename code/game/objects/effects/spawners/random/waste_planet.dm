/obj/effect/spawner/random/waste/grille_or_trash
	icon_state = "grille"
	name = "wasteplanet loot spawner"
	loot = list(
		/obj/structure/grille/broken = 5,
		/obj/structure/grille = 5,
		/obj/item/cigbutt = 1,
		/obj/item/trash/cheesie = 1,
		/obj/item/trash/candy = 1,
		/obj/item/trash/chips = 1,
		/obj/item/food/deadmouse = 1,
		/obj/item/trash/pistachios = 1,
		/obj/item/trash/popcorn = 1,
		/obj/item/trash/raisins = 1,
		/obj/item/trash/sosjerky = 1,
		/obj/item/trash/syndi_cakes = 1
	)

/obj/effect/spawner/random/waste/mechwreck
	icon_state = "ripley"
	name = "wasteplanet exosuit wreckage"
	loot = list(
		/obj/structure/mecha_wreckage/ripley = 15,
		/obj/structure/mecha_wreckage/ripley/firefighter = 9,
		/obj/structure/mecha_wreckage/ripley/mkii = 9,
		/obj/structure/mecha_wreckage/ripley/clip = 9
		)

/obj/effect/spawner/random/waste/mechwreck/rare
	loot = list(
		/obj/structure/mecha_wreckage/durand = 12.5,
		/obj/structure/mecha_wreckage/durand/clip = 12.5,
		/obj/structure/mecha_wreckage/odysseus = 25,
		/obj/structure/mecha_wreckage/gygax = 25
		)

/obj/effect/spawner/random/waste/radiation
	loot = list(
		/obj/structure/hazard/radioactive = 6,
		/obj/structure/hazard/radioactive/stack = 6,
		/obj/structure/hazard/radioactive/waste = 6
	)

/obj/effect/spawner/random/waste/radiation/more_rads
	loot = list(
		/obj/structure/hazard/radioactive = 3,
		/obj/structure/hazard/radioactive/stack = 12,
		/obj/structure/hazard/radioactive/waste = 12
	)

/obj/effect/spawner/random/waste/atmos_can
	loot = list(
		/obj/machinery/portable_atmospherics/canister/toxins = 3,
		/obj/machinery/portable_atmospherics/canister/carbon_dioxide = 3,
		/obj/machinery/portable_atmospherics/canister/nitrogen = 3,
		/obj/machinery/portable_atmospherics/canister/oxygen = 3,
		/obj/machinery/portable_atmospherics/canister/nitrous_oxide = 1,
		/obj/machinery/portable_atmospherics/canister/water_vapor = 1
	)

/obj/effect/spawner/random/waste/atmos_can/rare
	loot = list(
		/obj/machinery/portable_atmospherics/canister/tritium = 3,
		/obj/machinery/portable_atmospherics/canister/methane = 3
	)

/obj/effect/spawner/random/waste/salvageable
	loot = list(
		/obj/structure/salvageable/machine = 20,
		/obj/structure/salvageable/autolathe = 15,
		/obj/structure/salvageable/computer = 10,
		/obj/structure/salvageable/protolathe = 10,
		/obj/structure/salvageable/circuit_imprinter = 8,
		/obj/structure/salvageable/destructive_analyzer = 8,
		/obj/structure/salvageable/server = 8
	)

/obj/effect/spawner/random/waste/girder
	loot = list(
		/obj/structure/girder/wasteworld,
		/obj/structure/girder/wasteworld,
		/obj/structure/girder/wasteworld,
		/obj/structure/girder,
		/obj/structure/girder/displaced,
		/obj/structure/girder/reinforced
	)

/obj/effect/spawner/random/waste/hivebot
	loot = list(
		/obj/effect/spawner/random/salvage/ore/metal,
		/obj/effect/spawner/random/salvage/ore/metal,
		/obj/effect/spawner/random/salvage/ore/metal,
		/obj/effect/spawner/random/salvage/ore/gold,
		/obj/effect/spawner/random/salvage/ore/plasma,
		/obj/effect/spawner/random/salvage/ore/silver,
		/obj/effect/spawner/random/salvage/ore/titanium,
		/obj/item/stack/ore/salvage/scrapbluespace,
		/obj/item/stack/ore/salvage/scrapbluespace,
		/obj/item/stack/ore/salvage/scrapuranium
	)
	spawn_loot_count = 2

/obj/effect/spawner/random/waste/hivebot/more
	spawn_loot_count = 4

/obj/effect/spawner/random/waste/hivebot/part
	loot = list(
		/obj/item/stock_parts/capacitor,
		/obj/item/stock_parts/scanning_module,
		/obj/item/stock_parts/manipulator,
		/obj/item/stock_parts/micro_laser,
		/obj/item/stock_parts/matter_bin,
		/obj/item/stock_parts/capacitor/adv,
		/obj/item/stock_parts/scanning_module/adv,
		/obj/item/stock_parts/manipulator/nano,
		/obj/item/stock_parts/micro_laser/high,
		/obj/item/stock_parts/matter_bin/adv,
		/obj/item/stock_parts/cell/super/empty,
	)
	spawn_loot_count = 1
	spawn_loot_chance = 100

/obj/effect/spawner/random/waste/hivebot/part/heavy
	loot = list(
		/obj/item/stock_parts/capacitor/super,
		/obj/item/stock_parts/scanning_module/phasic,
		/obj/item/stock_parts/manipulator/pico,
		/obj/item/stock_parts/micro_laser/ultra,
		/obj/item/stock_parts/matter_bin/super,
		/obj/item/stock_parts/cell/hyper/empty,
	)


/obj/effect/spawner/random/waste/hivebot/part/superheavy
	loot = list(
		/obj/item/stock_parts/capacitor/quadratic,
		/obj/item/stock_parts/scanning_module/triphasic,
		/obj/item/stock_parts/manipulator/femto,
		/obj/item/stock_parts/micro_laser/quadultra,
		/obj/item/stock_parts/matter_bin/bluespace,
		/obj/item/stock_parts/cell/bluespace/empty,
	)


/obj/effect/spawner/random/waste/hivebot/beacon
	spawn_loot_count = 6
