// siti leaves
/obj/item/seeds/siti
	name = "pack of siti seeds"
	desc = "These seeds grow into siti plants."
	icon_state = "seed-siti"
	species = "siti"
	plantname = "siti plant"
	product = /obj/item/food/grown/siti
	lifespan = 20
	maturation = 5
	production = 5
	growthstages = 1
	yield = 2
	growing_icon = 'icons/obj/hydroponics/growing_vegetables.dmi'
	icon_grow = "cabbage-grow"
	icon_dead = "cabbage-dead"
	reagents_add = list(/datum/reagent/consumable/nutriment/vitamin = 0.04, /datum/reagent/consumable/nutriment = 0.1)

/obj/item/food/grown/siti
	seed = /obj/item/seeds/siti
	name = "siti leaf"
	desc = "The leaves of a Siti plant have a strong structure, giving them an extremely pleasant (if somewhat lacking in flavor) crunch."
	icon_state = "siti"
	gender = PLURAL
	filling_color = "#FF00FF"
	bite_consumption_mod = 1
	foodtypes = FRUIT
	juice_results = null
	tastes = list("vegetable crunch" = 1)
	distill_reagent = null
	wine_flavor = "stiff leaf"
