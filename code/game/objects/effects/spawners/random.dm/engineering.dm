/obj/effect/spawner/random/engineering
	name = "engineering loot spawner"
	desc = "All engineering related spawners go here"
	icon_state = "toolbox"

/obj/effect/spawner/random/engineering/tool
	loot = list(
			/obj/effect/spawner/random/engineering/tool/common = 120,
			/obj/effect/spawner/random/engineering/tool/sydnie = 20,
			/obj/effect/spawner/random/engineering/tool/adv = 5,
		)

/obj/effect/spawner/random/engineering/tool/common
	loot = list(
			/obj/item/wrench/crescent = 1,
			/obj/item/screwdriver = 1,
			/obj/item/weldingtool = 1,
			/obj/item/crowbar = 1,
			/obj/item/wirecutters = 1,
			/obj/item/multitool = 1,
		)

/obj/effect/spawner/random/engineering/tool/sydnie
	loot = list(
			/obj/item/wrench/syndie = 1,
			/obj/item/screwdriver/nuke = 1,
			/obj/item/weldingtool/largetank = 1,
			/obj/item/crowbar/syndie = 1,
			/obj/item/wirecutters/syndie = 1,
			/obj/item/multitool/syndie = 1,
		)

/obj/effect/spawner/random/engineering/tool/adv
	loot = list(
			/obj/item/screwdriver/power = 1,
			/obj/item/weldingtool/experimental = 1,
			/obj/item/crowbar/power = 1,
		)

/obj/effect/spawner/random/stockparts
	name = "random good stock parts"
	spawn_loot_count = 6
	loot = list(
		/obj/item/stock_parts/capacitor/adv,
		/obj/item/stock_parts/capacitor/quadratic,
		/obj/item/stock_parts/capacitor/super,
		/obj/item/stock_parts/cell/hyper,
		/obj/item/stock_parts/cell/super,
		/obj/item/stock_parts/cell/bluespace,
		/obj/item/stock_parts/matter_bin/bluespace,
		/obj/item/stock_parts/matter_bin/super,
		/obj/item/stock_parts/matter_bin/adv,
		/obj/item/stock_parts/micro_laser/ultra,
		/obj/item/stock_parts/micro_laser/quadultra,
		/obj/item/stock_parts/micro_laser/high,
		/obj/item/stock_parts/scanning_module/triphasic,
		/obj/item/stock_parts/scanning_module/phasic,
		/obj/item/stock_parts/scanning_module/adv,
		/obj/item/reagent_containers/glass/beaker/bluespace,
		/obj/item/reagent_containers/glass/beaker/plastic,
		/obj/item/reagent_containers/glass/beaker/large,
		/obj/item/stock_parts/manipulator/nano,
		/obj/item/stock_parts/manipulator/pico,
		/obj/item/stock_parts/manipulator/femto
	)

/obj/effect/spawner/random/materials
	name = "random bulk materials"
	spawn_loot_count = 2
	loot = list(
		/obj/item/stack/sheet/plastic/fifty,
		/obj/item/stack/sheet/bluespace_crystal/twenty,
		/obj/item/stack/sheet/cardboard/fifty,
		/obj/item/stack/sheet/glass/fifty,
		/obj/item/stack/sheet/metal/fifty,
		/obj/item/stack/sheet/plasteel/twenty,
		/obj/item/stack/sheet/mineral/plasma/fifty,
		/obj/item/stack/sheet/mineral/silver/fifty,
		/obj/item/stack/sheet/mineral/titanium/fifty,
		/obj/item/stack/sheet/mineral/uranium/fifty,
		/obj/item/stack/sheet/mineral/wood/fifty,
		/obj/item/stack/sheet/mineral/diamond/twenty,
		/obj/item/stack/sheet/mineral/gold/fifty,
		/obj/item/stack/cable_coil/red,
		/obj/item/stack/rods/fifty
	)

/obj/effect/spawner/random/stockparts
	name = "random good stock parts"
	spawn_loot_count = 5
	loot = list(
		/obj/item/stock_parts/capacitor/adv,
		/obj/item/stock_parts/capacitor/quadratic,
		/obj/item/stock_parts/capacitor/super,
		/obj/item/stock_parts/cell/hyper,
		/obj/item/stock_parts/cell/super,
		/obj/item/stock_parts/cell/bluespace,
		/obj/item/stock_parts/matter_bin/bluespace,
		/obj/item/stock_parts/matter_bin/super,
		/obj/item/stock_parts/matter_bin/adv,
		/obj/item/stock_parts/micro_laser/ultra,
		/obj/item/stock_parts/micro_laser/quadultra,
		/obj/item/stock_parts/micro_laser/high,
		/obj/item/stock_parts/scanning_module/triphasic,
		/obj/item/stock_parts/scanning_module/phasic,
		/obj/item/stock_parts/scanning_module/adv,
		/obj/item/reagent_containers/glass/beaker/bluespace,
		/obj/item/reagent_containers/glass/beaker/plastic,
		/obj/item/reagent_containers/glass/beaker/large,
		/obj/item/stock_parts/manipulator/nano,
		/obj/item/stock_parts/manipulator/pico,
		/obj/item/stock_parts/manipulator/femto
	)

/obj/effect/spawner/random/materials
	name = "random materials"
	spawn_loot_count = 3
	loot = list(
		/obj/item/stack/sheet/plastic/fifty,
		/obj/item/stack/sheet/plastic/five,
		/obj/item/stack/sheet/bluespace_crystal/twenty,
		/obj/item/stack/sheet/bluespace_crystal/five,
		/obj/item/stack/sheet/cardboard/fifty,
		/obj/item/stack/sheet/glass/fifty,
		/obj/item/stack/sheet/metal/fifty,
		/obj/item/stack/sheet/metal/twenty,
		/obj/item/stack/sheet/plasteel/twenty,
		/obj/item/stack/sheet/mineral/plasma/fifty,
		/obj/item/stack/sheet/mineral/plasma/twenty,
		/obj/item/stack/sheet/mineral/silver/fifty,
		/obj/item/stack/sheet/mineral/titanium/twenty,
		/obj/item/stack/sheet/mineral/uranium/twenty,
		/obj/item/stack/sheet/mineral/wood/fifty,
		/obj/item/stack/sheet/mineral/diamond/twenty,
		/obj/item/stack/sheet/mineral/gold/fifty,
		/obj/item/stack/cable_coil/red,
		/obj/item/stack/rods/fifty
	)
