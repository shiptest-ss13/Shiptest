/datum/blackmarket_item/emergency
	category = "Emergency"

/datum/blackmarket_item/emergency/plasma
	name = "Plasma Sheet"
	desc = "Low on fuel? We can part with some plasma... for a reasonable cost."
	item = /obj/item/stack/sheet/mineral/plasma/

	cost_min = 175
	cost_max = 225
	availability_prob = 100
	stock = INFINITY

/datum/blackmarket_item/emergency/uranium
	name = "Uranium Sheet"
	desc = "Fuel? Dirty Bomb? Fancy nightlight? Doesn't matter, we'll supply."
	item = /obj/item/stack/sheet/mineral/uranium

	cost_min = 200
	cost_max = 250
	availability_prob = 100
	stock = INFINITY

/datum/blackmarket_item/emergency/ion_thruster
	name = "Ion Thruster"
	desc = "Need a boost? We have a leftover engine board or two from a ship we happened to find. If you're lucky, you won't be the next."
	item = /obj/item/circuitboard/machine/shuttle/engine/electric

	cost_min = 2000
	cost_max = 3000
	stock_max = 5
	availability_prob = 100

/datum/blackmarket_item/emergency/oyxgen
	name = "Oxygen Canister"
	desc = "What keeps us all breathing. It'll keep you breathing too, if you know what's good for you."
	item = /obj/machinery/portable_atmospherics/canister/oxygen

	cost_min = 2000
	cost_max = 3000
	stock_max = 3
	availability_prob = 100

/datum/blackmarket_item/emergency/metal_foam
	name = "Metal Foam Grenade"
	desc = "Poor piloting blow a hole in the side of your hull? These metal foam grenades should keep everything important in."
	item = /obj/item/grenade/chem_grenade/metalfoam

	cost_min = 300
	cost_max = 750
	availability_prob = 100
	stock = INFINITY
