// dotu-fime
// needs - icon state for the plant

/obj/item/seeds/dotu_fime
	name = "pack of dotu-fime seeds"
	desc = "These seeds grow into dotu-fime trees. Remember to keep them watered!"
	icon_state = "seed-dotu"
	species = "dotu"
	plantname = "dotu-fime tree"
	product = /obj/item/food/grown/dotu_fime
	lifespan = 30
	maturation = 8
	production = 6
	yield = 3
	potency = 20
	growing_icon = 'icons/obj/hydroponics/growing_fruits.dmi'
	icon_grow = "apple-grow"
	icon_dead = "apple-dead"
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	reagents_add = list(/datum/reagent/consumable/dotu_juice = 0.25, /datum/reagent/consumable/nutriment/vitamin = 0.04, /datum/reagent/consumable/nutriment = 0.04)

/obj/item/food/grown/dotu_fime
	seed = /obj/item/seeds/dotu_fime
	name = "dotu-fime"
	desc = "A small plump fruit typically found growing on trees near sources of water. The flavor is somewhat bitter, but excels when processed, or fermented."
	icon_state = "dotu-fime"
	filling_color = "#FF0000"
	bite_consumption_mod = 2
	foodtypes = FRUIT
	juice_results = list(/datum/reagent/consumable/dotu_juice = 0)
	distill_reagent = /datum/reagent/consumable/ethanol/dotusira
	tastes = list("bitter fruit" = 1)
