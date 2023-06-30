
/obj/vehicle/ridden/lavaboat/plasma
	name = "plasma boat"
	desc = "A boat used for traversing the streams of plasma without turning into an icecube."
	icon_state = "goliath_boat"
	icon = 'icons/obj/lavaland/dragonboat.dmi'
	resistance_flags = FREEZE_PROOF
	can_buckle = TRUE


//lootspawners//--

/obj/effect/spawner/lootdrop/snowdin
	name = "why are you using this dummy"
	lootdoubles = 0
	lootcount = 1
	loot = list(/obj/item/bikehorn = 100)

/obj/effect/spawner/lootdrop/snowdin/dungeonlite
	name = "dungeon lite"
	loot = list(/obj/item/melee/classic_baton = 11,
				/obj/item/melee/classic_baton/telescopic = 12,
				/obj/item/book/granter/spell/smoke = 10,
				/obj/item/book/granter/spell/blind = 10,
				/obj/item/storage/firstaid/regular = 45,
				/obj/item/storage/firstaid/toxin = 35,
				/obj/item/storage/firstaid/brute = 27,
				/obj/item/storage/firstaid/fire = 27,
				/obj/item/storage/toolbox/syndicate = 12,
				/obj/item/grenade/c4 = 7,
				/obj/item/grenade/clusterbuster/smoke = 15,
				/obj/item/clothing/under/chameleon = 13,
				/obj/item/clothing/shoes/chameleon/noslip = 10,
				/obj/item/borg/upgrade/ddrill = 3,
				/obj/item/borg/upgrade/soh = 3)

/obj/effect/spawner/lootdrop/snowdin/dungeonmid
	name = "dungeon mid"
	loot = list(/obj/item/defibrillator/compact = 6,
				/obj/item/storage/firstaid/tactical = 35,
				/obj/item/shield/energy = 6,
				/obj/item/shield/riot/tele = 12,
				/obj/item/dnainjector/lasereyesmut = 7,
				/obj/item/gun/magic/wand/fireball/inert = 3,
				/obj/item/pneumatic_cannon = 15,
				/obj/item/melee/transforming/energy/sword = 7,
				/obj/item/book/granter/spell/knock = 15,
				/obj/item/book/granter/spell/summonitem = 20,
				/obj/item/book/granter/spell/forcewall = 17,
				/obj/item/storage/backpack/holding = 12,
				/obj/item/grenade/spawnergrenade/manhacks = 6,
				/obj/item/grenade/spawnergrenade/spesscarp = 7,
				/obj/item/grenade/clusterbuster/inferno = 3,
				/obj/item/stack/sheet/mineral/diamond{amount = 15} = 10,
				/obj/item/stack/sheet/mineral/uranium{amount = 15} = 10,
				/obj/item/stack/sheet/mineral/plasma{amount = 15} = 10,
				/obj/item/stack/sheet/mineral/gold{amount = 15} = 10,
				/obj/item/book/granter/spell/barnyard = 4,
				/obj/item/pickaxe/drill/diamonddrill = 6,
				/obj/item/borg/upgrade/disablercooler = 7)


/obj/effect/spawner/lootdrop/snowdin/dungeonheavy
	name = "dungeon heavy"
	loot = list(/obj/item/singularityhammer = 25,
				/obj/item/mjollnir = 10,
				/obj/item/fireaxe = 25,
				/obj/item/organ/brain/alien = 17,
				/obj/item/dualsaber = 15,
				/obj/item/organ/heart/demon = 7,
				/obj/item/gun/ballistic/automatic/smg/c20r/unrestricted = 16,
				/obj/item/gun/magic/wand/resurrection/inert = 15,
				/obj/item/gun/magic/wand/resurrection = 10,
				/obj/item/uplink/old = 2,
				/obj/item/book/granter/spell/charge = 12,
				/obj/item/grenade/clusterbuster/spawner_manhacks = 15,
				/obj/item/book/granter/spell/fireball = 10,
				/obj/item/pickaxe/drill/jackhammer = 30,
				/obj/item/borg/upgrade/syndicate = 13,
				/obj/item/borg/upgrade/selfrepair = 17)

/obj/effect/spawner/lootdrop/snowdin/dungeonmisc
	name = "dungeon misc"
	lootdoubles = 2
	lootcount = 1

	loot = list(/obj/item/stack/sheet/mineral/snow{amount = 25} = 10,
				/obj/item/toy/snowball = 15,
				/obj/item/shovel = 10,
				/obj/item/spear = 8,
				)

//special items//--

/obj/structure/barricade/wooden/snowed
	name = "crude plank barricade"
	desc = "This space is blocked off by a wooden barricade. It seems to be covered in a layer of snow."
	icon_state = "woodenbarricade-snow"
	max_integrity = 125

/obj/item/clothing/under/syndicate/coldres
	name = "insulated tactical turtleneck"
	desc = "A nondescript and slightly suspicious-looking turtleneck with digital camouflage cargo pants. The interior has been padded with special insulation for both warmth and protection."
	armor = list("melee" = 20, "bullet" = 10, "laser" = 0,"energy" = 5, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 25, "acid" = 25)
	cold_protection = CHEST|GROIN|ARMS|LEGS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT

/obj/item/clothing/shoes/combat/coldres
	name = "insulated combat boots"
	desc = "High speed, low drag combat boots, now with an added layer of insulation."
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT

/obj/item/gun/magic/wand/fireball/inert
	name = "weakened wand of fireball"
	desc = "This wand shoots scorching balls of fire that explode into destructive flames. The years of the cold have weakened the magic inside the wand."
	max_charges = 4

/obj/item/gun/magic/wand/resurrection/inert
	name = "weakened wand of healing"
	desc = "This wand uses healing magics to heal and revive. The years of the cold have weakened the magic inside the wand."
	max_charges = 5

//objs//--

/obj/structure/flora/rock/icy
	name = "icy rock"
	icon_state = "icemoonrock1"

/obj/structure/flora/rock/icy/Initialize()
	. = ..()
	icon_state = "icemoonrock[rand(1,3)]"

/obj/structure/flora/rock/pile/icy
	name = "icey rocks"
	icon_state = "icemoonrock4"

/obj/structure/flora/rock/pile/icy/Initialize()
	. = ..()
	icon_state = "icemoonrock4"

//decals//--
/obj/effect/turf_decal/snowdin_station_sign
	icon_state = "AOP1"

/obj/effect/turf_decal/snowdin_station_sign/two
	icon_state = "AOP2"

/obj/effect/turf_decal/snowdin_station_sign/three
	icon_state = "AOP3"

/obj/effect/turf_decal/snowdin_station_sign/four
	icon_state = "AOP4"

/obj/effect/turf_decal/snowdin_station_sign/five
	icon_state = "AOP5"

/obj/effect/turf_decal/snowdin_station_sign/six
	icon_state = "AOP6"

/obj/effect/turf_decal/snowdin_station_sign/seven
	icon_state = "AOP7"

/obj/effect/turf_decal/snowdin_station_sign/up
	icon_state = "AOPU1"

/obj/effect/turf_decal/snowdin_station_sign/up/two
	icon_state = "AOPU2"

/obj/effect/turf_decal/snowdin_station_sign/up/three
	icon_state = "AOPU3"

/obj/effect/turf_decal/snowdin_station_sign/up/four
	icon_state = "AOPU4"

/obj/effect/turf_decal/snowdin_station_sign/up/five
	icon_state = "AOPU5"

/obj/effect/turf_decal/snowdin_station_sign/up/six
	icon_state = "AOPU6"

/obj/effect/turf_decal/snowdin_station_sign/up/seven
	icon_state = "AOPU7"
