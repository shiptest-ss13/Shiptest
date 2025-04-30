// dotu-fime
// needs - icon state for the plant, unique plant stats i guess
/*
/obj/item/seeds/fara_li
	name = "pack of fara-li seeds"
	desc = "These seeds grow into fara-li bushes. Remember to keep them watered!"
	icon_state = ""
	species = "dotu-fime"
	plantname = "dotu-fime tree"
	product = /obj/item/reagent_containers/food/snacks/grown/dotu_fime
	lifespan = 30
	maturation = 8
	production = 6
	yield = 3
	potency = 20
	growing_icon = 'icons/obj/hydroponics/growing_vegetables.dmi'
	icon_grow = ""
	icon_dead = ""
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	reagents_add = list/datum/reagent/consumable/nutriment/vitamin = 0.04, /datum/reagent/consumable/nutriment = 0.04)
*/

/obj/item/reagent_containers/food/snacks/grown/fara_li
	seed = null
	name = "fara-li"
	desc = "A neutral-hot fruit grown in orchards on Teceti, and tecetiformed worlds. "
	icon_state = "fara-li"
	filling_color = "#FF0000"
	bitesize_mod = 2
	foodtype = FRUIT
	juice_results = null
	distill_reagent = /datum/reagent/consumable/ethanol/faraseta
