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
	desc = "Wash away the opposition with sudstastic grenade!"
	item = /obj/item/grenade/clusterbuster/soap

	price_min = 500
	price_max = 1500
	stock = 1
	availability_prob = 10

/datum/blackmarket_item/explosive/rusted_mine
	name = "Landmine"
	desc = "Recovered from a decades old ICW battlefield by our best EOD tech, Nicky Nine Fingers."
	item = /obj/item/mine/pressure/explosive/rusty

	price_min = 250
	price_max = 500
	stock_max = 7
	availability_prob = 50

/datum/blackmarket_item/explosive/rpg
	name = "PML-9 RPG"
	desc = "Offically, it's an anti-armor RPG launcher. Technically, it's anti-everything. Most things don't enjoy being hit in the face with high explosives."
	item = /obj/item/gun/ballistic/rocketlauncher/mako

	price_min = 3500
	price_max = 6500
	stock_min = 2
	stock_max = 5
	availability_prob = 20

