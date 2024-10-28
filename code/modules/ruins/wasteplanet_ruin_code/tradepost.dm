/obj/item/tape/random/preset/tradepost/one
	ruined = 1
	used_capacity = 120

/obj/item/tape/random/preset/tradepost/one/Initialize()
	. = ..()
	storedinfo = list(
		"\[00:00\] Recording started.",
		"\[00:06\] [span_name("firm elzousa")] drawls \"Now I figure that... give or take a few months a' tradin out here, I'll 'ave enough money t' pay you boys forra 'nother year.\"",
		"\[00:14\] [span_name("muffled rachnid woman")] declares \"Caelum. If you don't have payment rendered soon we this contract is called.\"",
		"\[00:23\] [span_name("firm elzousa")] drawls \"I know. I know. I gotcha few more weeks of pay annif I don' make any trades, then 's done.\"",
		"\[00:32\] [span_name("firm elzousa")] drawls \"Don'tcha wave those things at me.\"",
		"\[00:37\] [span_name("muffled rachnid woman")] declares \"You have two weeks. My enforcers are reporting that the area is drawing the attention of scrapbots.\"",
		"\[00:46\] [span_name("muffled rachnid woman")] declares \"If we don't have the money to buy more ammo, I don't need to tell you what'll happen.\"",
		"\[00:50\] [span_name("firm elzousa")] lets out a sigh.",
		"\[00:53\] [span_name("firm elzousa")] drawls \" Cour ma'am. Cour. \"",
	)
	timestamp = list(
		0,
		6,
		14,
		23,
		32,
		37,
		46,
		50,
		53
	)

/obj/effect/mob_spawn/human/corpse/inteq/medic/tradepost
	mob_name = "Jenny Amasatsu"
	brute_damage = 140
	burn_damage = 78
	mob_gender = FEMALE
	outfit = /datum/outfit/job/inteq/paramedic/tradepost

/obj/effect/mob_spawn/human/corpse/inteq/vanguard/tradepost
	outfit = /datum/outfit/job/inteq/captain/tradepost
	mob_species = /datum/species/spider
	gender = FEMALE

/obj/effect/mob_spawn/human/corpse/indie/engineer
	outfit = /datum/outfit/job/independent/engineer

/obj/effect/mob_spawn/human/corpse/indie/manager
	outfit = /datum/outfit/job/independent/captain/manager
	mob_species = /datum/species/elzuose
	backpack_contents = null


/datum/outfit/job/inteq/paramedic/tradepost
	name = "Trade Post Corpsman"
	belt = /obj/item/storage/belt/medical/webbing

/datum/outfit/job/inteq/captain/tradepost
	name = "Trade Post Vanguard"

	r_pocket = null
	l_pocket = null

	backpack_contents = null
