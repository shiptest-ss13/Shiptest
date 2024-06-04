/datum/blackmarket_item/emergency
	category = "Emergency"

/datum/blackmarket_item/emergency/plasma
	name = "Ten Plasma Sheets"
	desc = "Low on fuel? We can part with some plasma... for a reasonable price."
	item = /obj/item/stack/sheet/mineral/plasma/ten

	price_min = 1750
	price_max = 2250
	availability_prob = 100
	unlimited = TRUE

/datum/blackmarket_item/emergency/uranium
	name = "Ten Uranium Sheets"
	desc = "Fuel? Dirty Bomb? Fancy nightlight? Doesn't matter, we'll supply."
	item = /obj/item/stack/sheet/mineral/uranium/ten

	price_min = 1750
	price_max = 2250
	availability_prob = 100
	unlimited = TRUE

/datum/blackmarket_item/emergency/ion_thruster
	name = "Ion Thruster"
	desc = "Need a boost? We have a leftover engine board or two from a ship we happened to find. If you're lucky, you won't be the next."
	item = /obj/item/circuitboard/machine/shuttle/engine/electric

	price_min = 2000
	price_max = 3000
	stock_max = 5
	availability_prob = 100

/datum/blackmarket_item/emergency/oyxgen
	name = "Oxygen Canister"
	desc = "What keeps us all breathing. It'll keep you breathing too, if you know what's good for you."
	item = /obj/machinery/portable_atmospherics/canister/oxygen

	price_min = 2000
	price_max = 3000
	stock_max = 3
	availability_prob = 100

/datum/blackmarket_item/emergency/metal_foam
	name = "Metal Foam Grenade"
	desc = "Poor piloting blow a hole in the side of your hull? These metal foam grenades should keep everything important in."
	item = /obj/item/grenade/chem_grenade/metalfoam

	price_min = 300
	price_max = 750
	availability_prob = 100
	unlimited = TRUE
