/obj/machinery/porta_turret/ship/nt/light/mining_base
	req_ship_access = FALSE
	mode = 1
	turret_flags = TURRET_FLAG_SHOOT_ANOMALOUS

/obj/machinery/porta_turret/ship/nt/light/mining_base/Initialize()
	. = ..()
	take_damage(rand(120, 150),BRUTE)

/obj/effect/mob_spawn/human/corpse/ruin/ns_mine_manager
	mob_name = "gruff sarathi man"
	mob_gender = MALE
	mob_species = /datum/species/lizard
	icon_state = "corpsehuman"
	outfit = /datum/outfit/job/nanotrasen/quartermaster
	brute_damage = 120

/obj/effect/mob_spawn/human/corpse/ruin/ns_mine_miner
	outfit = /datum/outfit/job/nanotrasen/miner

/obj/effect/mob_spawn/human/corpse/ruin/ns_mine_miner/armored
	outfit = /datum/outfit/job/nanotrasen/miner/armored

/datum/outfit/job/nanotrasen/miner/armored
	name = "Nanotrasen - Armored Miner"
	suit = /obj/item/clothing/suit/hooded/explorer
	mask = /obj/item/clothing/mask/gas/explorer

/obj/effect/mob_spawn/human/corpse/ruin/ns_mine_miner/Initialize()
	. = ..()
	mob_species = pick_weight(list(
			/datum/species/human = 50,
			/datum/species/lizard = 20,
			/datum/species/ipc = 10,
			/datum/species/elzuose = 10,
			/datum/species/moth = 5,
			/datum/species/spider = 5
		)
	)

/obj/item/taperecorder/preset/mining_base
	starting_tape_type = /obj/item/tape/random/preset/mining_base/one

/obj/item/tape/random/preset/mining_base/one
	ruined = 1
	used_capacity = 120

/obj/item/tape/random/preset/mining_base/one/Initialize()
	. = ..()
	storedinfo = list(
		"\[00:00\] Recording started.",
		"\[00:02\] [span_name("gruff sarathi man")] firmly declares \"-urn in hell for thisss.\"",
		"\[00:05\] [span_name("stern human woman")] retorts \"A hell of my own making.\"",
		"\[00:08\] [span_name("gruff sarathi man")] states \"And we'll sssend you-\"",
		"\[00:11\] [span_name("gruff sarathi man")] suddenly gasps",
		"\[00:12\] [span_name("stern human woman")] confidently delivers \"If you're so sure, why aren't you the one with the gun?\"",
		"\[00:17\] [span_name("gruff sarathi man")] stammers \"y-you won't get away with thisss\"",
		"\[00:20\] [span_name("stern human woman")] says \"The last Nanotrasen cuck I killed said that too~\"",
		"\[00:25\] sudden clattering and a dull thump.",
		"\[00:26\] [span_name("gruff sarathi man")] gasps for breath!",
		"\[00:27\] [span_name("stern human woman")] contemptously declares \"Different boot. Same pathetic people.\"",
		"\[00:30\] A pistol's slide is racked.",
		"\[00:32\] [span_name("stern human woman")] says \"Burn in hell.\"",
		"\[00:33\] A pistol is fired!",
		"\[00:36\] [span_name("stern human woman")] states \"Get moving. I want us out and a garrison deployed within the hour.\"",
		"\[00:38\] armored footsteps thump against a metal floor",
		"\[00:44\] an airlock hisses open.",
		"\[00:45\] [span_name("stern human woman")] taunts \"tchuss, tovai.\"",
		"\[00:50\] an airlock suddenly closes!",
		"\[02:00\] Recording ended.",
	)
	timestamp = list(
		0,
		2,
		5,
		8,
		11,
		12,
		17,
		20,
		25,
		26,
		27,
		30,
		32,
		33,
		36,
		38,
		44,
		45,
		50,
		120
	)
