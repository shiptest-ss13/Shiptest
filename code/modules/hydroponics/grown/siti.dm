// siti leaves
/* ough
/obj/item/seeds/sososi
	name = "pack of siti seeds"
	desc = "These seeds grow into siti plants."
	icon_state = ""
	species = "sososi"
	plantname = "sososi plant"
	product = /obj/item/reagent_containers/food/snacks/grown/siti
	lifespan = 20
	maturation = 5
	production = 5
	yield = 2
	growing_icon = 'icons/obj/hydroponics/growing_fruits.dmi'
	icon_grow = ""
	icon_dead = ""
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	reagents_add = list(/datum/reagent/consumable/nutriment/vitamin = 0.04, /datum/reagent/consumable/nutriment = 0.1)
*/

/obj/item/reagent_containers/food/snacks/grown/siti
	seed = null
	name = "siti leaf"
	desc = "The leaves of a Siti plant have a strong structure, giving them an extremely pleasant (if somewhat lacking in flavor) crunch."
	icon_state = "siti"
	gender = PLURAL
	filling_color = "#FF00FF"
	bitesize_mod = 2
	foodtype = FRUIT
	juice_results = null
	tastes = list("vegetable crunch" = 1)
	distill_reagent = null
