/obj/item/seeds/poppy/opium
	name = "pack of opium poppy seeds"
	desc = "These seeds grow into opium poppies."
	icon_state = "seed-opiumpoppy"
	species = "opiumpoppy"
	plantname = "Opium Poppy Plants"
	product = /obj/item/reagent_containers/food/snacks/grown/poppy/opium
	growing_icon = 'icons/obj/hydroponics/growing.dmi'
	icon_grow = "opiumpoppy-grow"
	icon_dead = "opiumpoppy-dead"
	mutatelist = list()
	reagents_add = list(/datum/reagent/drug/opium = 0.3, /datum/reagent/toxin/fentanyl = 0.05, /datum/reagent/consumable/nutriment = 0.05)

/obj/item/reagent_containers/food/snacks/grown/poppy/opium
	seed = /obj/item/seeds/poppy/opium
	name = "opium poppy pod"
	desc = "A pod from an opium poppy flower. Contains opium, a powerful painkiller."
	icon_state = "opiumpoppy"
	slot_flags = NONE