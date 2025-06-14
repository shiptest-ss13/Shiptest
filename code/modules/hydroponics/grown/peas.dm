// Finally, peas. Base plant.
/obj/item/seeds/peas
	name = "pack of pea pods"
	desc = "These seeds grows into vitamin rich peas!"
	icon_state = "seed-peas"
	species = "peas"
	plantname = "Pea Vines"
	product = /obj/item/food/grown/peas
	maturation = 3
	potency = 25
	growthstages = 3
	growing_icon = 'icons/obj/hydroponics/growing_vegetables.dmi'
	icon_grow = "peas-grow"
	icon_dead = "peas-dead"
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	mutatelist = list(/obj/item/seeds/peas/laugh)
	reagents_add = list (/datum/reagent/consumable/nutriment/vitamin = 0.1, /datum/reagent/consumable/nutriment = 0.05, /datum/reagent/water = 0.05)

/obj/item/food/grown/peas
	seed = /obj/item/seeds/peas
	name = "peapod"
	desc = "Finally... peas."
	icon_state = "peas"
	bite_consumption_mod = 1
	foodtypes = VEGETABLES
	tastes = list ("peas" = 1, "chalky saltiness" = 1)
	distill_reagent = /datum/reagent/saltpetre

// Laughin' Peas
/obj/item/seeds/peas/laugh
	name = "pack of laughin' peas"
	desc = "These seeds give off a very soft purple glow.. they should grow into Laughin' Peas."
	icon_state = "seed-laughpeas"
	species = "laughpeas"
	plantname = "Laughin' Peas"
	product = /obj/item/food/grown/laugh
	maturation = 7
	potency = 15
	yield = 7
	production = 5
	growthstages = 3
	growing_icon = 'icons/obj/hydroponics/growing_vegetables.dmi'
	icon_grow = "laughpeas-grow"
	icon_dead = "laughpeas-dead"
	genes = list (/datum/plant_gene/trait/repeated_harvest, /datum/plant_gene/trait/glow/purple)
	mutatelist = list (/obj/item/seeds/peas/laugh/peace)
	reagents_add = list (/datum/reagent/consumable/sugar = 0.05, /datum/reagent/consumable/nutriment = 0.07)
	rarity = 25 //It actually might make Central Command Officials loosen up a smidge, eh?
	research = PLANT_RESEARCH_TIER_2

/obj/item/food/grown/laugh
	seed = /obj/item/seeds/peas/laugh
	name = "pod of laughin' peas"
	desc = "Ridens Cicer, guaranteed to improve your mood dramatically upon consumption!"
	icon_state = "laughpeas"
	bite_consumption_mod = 2
	foodtypes = VEGETABLES
	//WS edit - Adds Juice Reagent for recipes
	juice_results = list(/datum/reagent/consumable/laughsyrup = 0)
	tastes = list ("a prancing rabbit" = 1) //Vib Ribbon sends her regards.. wherever she is.
	wine_power = 90
	wine_flavor = "a vector-graphic rabbit dancing on your tongue"


// World Peas - Peace at last, peace at last...
/obj/item/seeds/peas/laugh/peace
	name = "pack of world peas"
	desc = "These rather large seeds give off a soothing blue glow..."
	icon_state = "seed-worldpeas"
	species = "worldpeas"
	plantname = "World Peas"
	product = /obj/item/food/grown/peace
	maturation = 20
	potency = 75
	yield = 1
	production = 10
	growthstages = 3
	growing_icon = 'icons/obj/hydroponics/growing_vegetables.dmi'
	icon_grow = "worldpeas-grow"
	icon_dead = "worldpeas-dead"
	genes = list (/datum/plant_gene/trait/glow/blue)
	reagents_add = list (/datum/reagent/pax = 0.15, /datum/reagent/drug/happiness = 0.1, /datum/reagent/consumable/nutriment = 0.15, /datum/reagent/genesis = 0.20)
	rarity = 50
	research = PLANT_RESEARCH_TIER_4

/obj/item/food/grown/peace
	seed = /obj/item/seeds/peas/laugh/peace
	name = "cluster of world peas"
	desc = "A plant discovered through extensive genetic engineering, and iterative graft work. It's rumored to bring peace to any who consume it. In the wider AgSci community, it's attained the nickname of 'Pax Mundi'." //at last... world peas. I'm not sorry.
	icon_state = "worldpeas"
	bite_consumption_mod = 4
	foodtypes = VEGETABLES
	tastes = list ("numbing tranquility" = 2, "warmth" = 1)
	wine_power = 100
	wine_flavor = "mind-numbing peace and warmth"
