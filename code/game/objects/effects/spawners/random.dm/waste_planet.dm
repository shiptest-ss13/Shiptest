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
		/obj/item/reagent_containers/food/snacks/deadmouse = 1,
		/obj/item/trash/pistachios = 1,
		/obj/item/trash/plate = 1,
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
		/obj/structure/radioactive = 6,
		/obj/structure/radioactive/stack = 6,
		/obj/structure/radioactive/waste = 6
	)

/obj/effect/spawner/random/waste/radiation/more_rads
	loot = list(
		/obj/structure/radioactive = 3,
		/obj/structure/radioactive/stack = 12,
		/obj/structure/radioactive/waste = 12
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
		/obj/structure/girder,
		/obj/structure/girder/displaced,
		/obj/structure/girder/reinforced
	)
/obj/effect/spawner/random/waste/hivebot
	loot = list(
		/obj/effect/spawner/random/salvage/metal,
		/obj/effect/spawner/random/salvage/metal,
		/obj/effect/spawner/random/salvage/metal,
		/obj/effect/spawner/random/salvage/gold,
		/obj/effect/spawner/random/salvage/plasma,
		/obj/effect/spawner/random/salvage/silver,
		/obj/effect/spawner/random/salvage/titanium,
		/obj/item/stack/ore/salvage/scrapbluespace,
		/obj/item/stack/ore/salvage/scrapbluespace,
		/obj/item/stack/ore/salvage/scrapuranium
	)
	spawn_loot_count = 2

/obj/effect/spawner/random/waste/hivebot/beacon
	spawn_loot_count = 6
