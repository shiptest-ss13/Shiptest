/obj/effect/spawner/random/armory
	name = "generic armory spawner"
	spawn_loot_split = TRUE
	spawn_loot_count = 3
	spawn_loot_split_pixel_offsets = 4

	loot = list(
				/obj/item/gun/ballistic/automatic/pistol/ringneck = 8,
				/obj/item/gun/ballistic/shotgun/automatic/combat = 5,
				/obj/item/gun/ballistic/automatic/pistol/deagle,
				/obj/item/gun/ballistic/revolver/mateba
				)

/obj/effect/spawner/random/armory_contraband/metastation
	loot = list(/obj/item/gun/ballistic/automatic/pistol/ringneck = 5,
				/obj/item/gun/ballistic/shotgun/automatic/combat = 5,
				/obj/item/gun/ballistic/automatic/pistol/deagle,
				/obj/item/storage/box/syndie_kit/throwing_weapons = 3,
				/obj/item/gun/ballistic/revolver/mateba)

/obj/effect/spawner/random/armory_contraband/donutstation
	loot = list(/obj/item/grenade/clusterbuster/teargas = 5,
				/obj/item/gun/ballistic/shotgun/automatic/combat = 5,
				/obj/item/bikehorn/golden,
				/obj/item/grenade/clusterbuster,
				/obj/item/storage/box/syndie_kit/throwing_weapons = 3,
				/obj/item/gun/ballistic/revolver/mateba)
