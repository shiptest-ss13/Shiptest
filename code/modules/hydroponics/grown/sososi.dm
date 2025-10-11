// sososi leaves

/obj/item/seeds/sososi
	name = "pack of sososi seeds"
	desc = "These seeds grow into sososi plants."
	icon_state = "seed-sososi"
	species = "sososi"
	plantname = "sososi plant"
	product = /obj/item/food/grown/sososi
	lifespan = 20
	maturation = 5
	production = 5
	yield = 2
	growthstages = 5
	growing_icon = 'icons/obj/hydroponics/growing_vegetables.dmi'
	//this fills me with a sense of dread. im sorry everyone.
	icon_grow = "aloe-grow"
	icon_dead = "aloe-dead"
	reagents_add = list(/datum/reagent/consumable/nutriment/vitamin = 0.04, /datum/reagent/consumable/nutriment = 0.1)

/obj/item/food/grown/sososi
	seed = /obj/item/seeds/sososi
	name = "sososi leaf"
	desc = "A thick leaf from a Tecetian succulent. It contains a gel-like concentration in its leaves, which while alive stored water and sugars."
	icon_state = "sososi"
	gender = PLURAL
	filling_color = "#FF00FF"
	bite_consumption_mod = 2
	foodtypes = FRUIT
	juice_results = null
	tastes = list("crisp gel" = 1)
	distill_reagent = /datum/reagent/consumable/ethanol/sososeta
