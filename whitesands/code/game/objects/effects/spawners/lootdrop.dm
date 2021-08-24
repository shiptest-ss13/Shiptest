/obj/effect/spawner/lootdrop/spacegym
	name = "spacegym loot spawner"
	lootdoubles = FALSE

	loot = list(
			/obj/item/dnainjector/hulkmut = 1,
			/obj/item/dnainjector/dwarf = 1,
			/obj/item/dnainjector/gigantism = 1,
			/obj/item/reagent_containers/food/snacks/meat/cutlet/chicken = 1,
			/obj/item/clothing/under/shorts/black = 1,
			/obj/item/clothing/under/shorts/blue = 1,
			/obj/item/clothing/under/shorts/red = 1,
			/obj/item/restraints/handcuffs = 1,
			/obj/item/storage/pill_bottle/stimulant = 1,
			/obj/item/storage/firstaid/regular = 1,
			/obj/item/storage/box/handcuffs = 1,
		)

/obj/effect/spawner/lootdrop/singularitygen
	name = "Tesla or Singulo spawner"
	lootdoubles = FALSE

	loot = list(
		/obj/machinery/the_singularitygen/tesla = 1,
		/obj/machinery/the_singularitygen = 1,
	)

GLOBAL_LIST_INIT(ws_survivor_default_loot, list(
	/obj/item/stack/sheet/animalhide/goliath_hide = 0.7,
	/obj/item/stack/sheet/bone = 0.8,
	/obj/item/reagent_containers/food/drinks/waterbottle = 0.2,
	/obj/item/reagent_containers/food/drinks/waterbottle/empty = 0.8,
	/obj/item/storage/firstaid/ancient/heirloom = 0.2,
	/obj/item/kitchen/knife/combat/survival = 0.2,
	/obj/item/reagent_containers/food/snacks/rationpack = 0.2
))

/obj/effect/spawner/lootdrop/whitesands
	name = "Whitesands Default loot spawner"
	lootdoubles = FALSE

/obj/effect/spawner/lootdrop/whitesands/survivor
	name = "Whitesands Survivior loot spawner"
	lootdoubles = TRUE
	fan_out_items = TRUE
	loot = list()

/obj/effect/spawner/lootdrop/whitesands/survivor/Initialize()
	loot += GLOB.ws_survivor_default_loot
	lootcount = pick(list(1, 2, 3))
	return ..()

/obj/effect/spawner/lootdrop/whitesands/survivor/hunter
	name = "Whitesands Hunter loot spawner"
	loot = list(
		/obj/item/gun/ballistic/rifle/boltaction/polymer = 0.3,
		/obj/item/ammo_box/aac_300blk_stripper = 0.4
	)
/obj/effect/spawner/lootdrop/whitesands/survivor/gunslinger
	name = "Whitesands Gunslinger loot spawner"
	loot = list(
		/obj/item/gun/ballistic/automatic/aks74u = 0.1,
		/obj/item/ammo_box/magazine/aks74u = 0.4
	)
