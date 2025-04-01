/datum/blackmarket_item/explosive
	category = "Explosives"

/datum/blackmarket_item/explosive/emp_grenade
	name = "EMP Grenade"
	desc = "Use this grenade for SHOCKING results!"
	item = /obj/item/grenade/empgrenade

	price_min = 100
	price_max = 400
	stock_max = 5
	availability_prob = 50

/datum/blackmarket_item/explosive/smoke_grenade
	name = "Smoke Grenade"
	desc = "Too much heat on your back? This handy smoke grenade is perfect for a hasty getaway."
	item = /obj/item/grenade/smokebomb

	price_min = 100
	price_max = 400
	stock_max = 5
	availability_prob = 50

/datum/blackmarket_item/explosive/h_e
	name = "HE Grenade"
	desc = "These high explosive grenades are sure to get some bang for your buck."
	item = /obj/item/grenade/syndieminibomb/concussion

	price_min = 100
	price_max = 500
	stock_min = 2
	stock_max = 5
	availability_prob = 25

/datum/blackmarket_item/explosive/frag
	name = "Fragmentation Grenade"
	desc = "Pull the pin, count to three, and throw for best results."
	item = /obj/item/grenade/frag

	price_min = 100
	price_max = 500
	stock_min = 3
	stock_max = 5
	availability_prob = 40

/datum/blackmarket_item/explosive/c4
	name = "C4"
	desc = "Looking to make an explosive entrance? These plastic explosives are perfect for the job."
	item = /obj/item/grenade/c4

	price_min = 100
	price_max = 400
	stock_min = 5
	stock_max = 10
	availability_prob = 50

/datum/blackmarket_item/explosive/x4
	name = "X4"
	desc = "X4 Plastic Explosives! Better than W4, worse than Y4."
	item = /obj/item/grenade/c4/x4

	price_min = 400
	price_max = 700
	stock_min = 2
	stock_max = 4
	availability_prob = 25

/datum/blackmarket_item/explosive/slipocalypse
	name = "Slipocalyse Cluster Bomb"
	desc = "Wash away the opposition with this sudstastic grenade!"
	item = /obj/item/grenade/clusterbuster/soap

	price_min = 500
	price_max = 1500
	stock = 1
	availability_prob = 10

/datum/blackmarket_item/explosive/disco_grenade
	name = "Portable Disco Grenade"
	desc = "Become the life of the party with this groovy grenade!"
	item = /obj/item/grenade/discogrenade

	price_min = 500
	price_max = 750
	stock_min = 2
	stock_max = 3
	availability_prob = 10
	spawn_weighting = FALSE

/datum/blackmarket_item/explosive/rusted_mine
	name = "Landmine"
	desc = "Recovered from a decade old ICW battlefield by our best EOD tech, Nicky Nine Fingers."
	item = /obj/item/mine/pressure/explosive/rusty

	price_min = 250
	price_max = 500
	stock_max = 7
	availability_prob = 50

/datum/blackmarket_item/explosive/live_bomb
	name = "Active ICW Era Ordinance"
	desc = "Look, I won't mince words. This thing is counting down and I don't want to be the next causualty of ICW after it's already ended. I'll sell it to you real cheap."
	item = /obj/machinery/syndicatebomb

	price_min = 500
	price_max = 1000
	stock = 1
	availability_prob = 5
	spawn_weighting = FALSE

/datum/blackmarket_item/explosive/live_bomb/spawn_item(loc)
	var/obj/machinery/syndicatebomb/bomb = ..()
	bomb.activate()
	return new bomb(loc)

/datum/blackmarket_item/explosive/firecrackers
	name = "Firecracker"
	desc = "Nuclear Bomb brand extra strength firecrackers, painted in the signature blood red of the Gorlex Marauders. Enjoyed a successful, albeit short run in PGF space due to a certain event in 492 FS made selling them somewhat in poor taste."
	item = /obj/item/grenade/firecracker

	price_min = 50
	price_max = 250
	stock_min = 5
	stock_max = 10
	availability_prob = 50
