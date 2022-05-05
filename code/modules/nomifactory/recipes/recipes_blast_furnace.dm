/datum/nomi_recipe/blast_furnace
	abstract = /datum/nomi_recipe/blast_furnace
	machine_needed = /obj/structure/nomifactory/machinery/blast_furnace

/datum/nomi_recipe/blast_furnace/ingot_iron
	name = "Ingot Casting"
	inputs = list(
		/obj/item/stack/ore/iron = 1
	)
	outputs = list(
		/obj/item/nomi/ingot_iron = 2
	)

/datum/nomi_recipe/blast_furnace/ingot_gold
	name = "Ingot Casting"
	inputs = list(
		/obj/item/stack/ore/gold = 1
	)
	outputs = list(
		/obj/item/nomi/ingot_gold = 2
	)

/datum/nomi_recipe/blast_furnace/ingot_copper
	name = "Ingot Casting"
	inputs = list(
		/obj/item/stack/ore/iron = 1 // TODO: ADD COPPER ORE
	)
	outputs = list(
		/obj/item/nomi/ingot_copper = 2
	)

/datum/nomi_recipe/blast_furnace/ingot_glass
	name = "Ingot Casting"
	inputs = list(
		/obj/item/stack/ore/glass = 1
	)
	outputs = list(
		/obj/item/nomi/ingot_glass = 2
	)
