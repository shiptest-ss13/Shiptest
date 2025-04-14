// refa-li
// needs - icon state for the plant
/*
/obj/item/seeds/dotu_fime
	name = "pack of refa-li seeds"
	desc = "These seeds grow into a refa-li vine. Feel the heat!"
	icon_state = ""
	species = "refa-li"
	plantname = "refa-li vine"
	product = /obj/item/reagent_containers/food/snacks/grown/refa-li
	lifespan = 12
	maturation = 4
	production = 6
	yield = 6
	potency = 10
	growing_icon = 'icons/obj/hydroponics/growing_vegetables.dmi'
	icon_grow = ""
	icon_dead = ""
	reagents_add = list(/datum/reagent/consumable/refa_li = 0.25, /datum/reagent/consumable/nutriment/vitamin = 0.04, /datum/reagent/consumable/nutriment = 0.04)
*/

/obj/item/reagent_containers/food/snacks/grown/refa-li
	seed = null
	name = "refa-li"
	desc = "the fruit of a small flowering vine common within Tecetian caves. As a defense mechanism, the fruit evolved a pungent sort of heat."
	icon_state = ""
	filling_color = "#FF0000"
	bitesize_mod = 2
	foodtype = FRUIT
	juice_results = list(/datum/reagent/consumable/refa_li = 0)
	distill_reagent = /datum/reagent/consumable/ethanol/dotusira
