// Berries
/* needs plant icon state and some actual dev work i cannot tell you how much i wish i had bit less off here */

/obj/item/seeds/dote_berries
	name = "pack of dote berry seeds"
	desc = "These seeds grow into dote berry bushes."
	icon_state = "seed-dote"
	species = "berry"
	plantname = "dote bush"
	product = /obj/item/food/grown/dote_berries
	lifespan = 20
	maturation = 5
	production = 5
	yield = 2
	growing_icon = 'icons/obj/hydroponics/growing_fruits.dmi'
	icon_grow = "berry-grow"
	icon_dead = "berry-dead"
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	reagents_add = list(/datum/reagent/consumable/nutriment/vitamin = 0.04, /datum/reagent/consumable/nutriment = 0.1)

/obj/item/food/grown/dote_berries
	seed = /obj/item/seeds/dote_berries
	name = "dote berries"
	desc = "A small purple berry native to Teceti. It takes root in arid locations, and has a tendency to out-compete local species due to its method of propagation."
	icon_state = "dote"
	gender = PLURAL
	filling_color = "#FF00FF"
	bite_consumption_mod = 2
	foodtypes = FRUIT
	juice_results = list(/datum/reagent/consumable/dote_juice = 0)
	tastes = list("berry" = 1)
	distill_reagent = null

/obj/item/food/grown/dote_berries/make_dryable()
	AddElement(/datum/element/dryable, /obj/item/food/dote/homemade)
