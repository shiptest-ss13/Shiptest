// sososi leaves
/* ough
/obj/item/seeds/sososi
	name = "pack of sososi seeds"
	desc = "These seeds grow into sososi plants."
	icon_state = ""
	species = "sososi"
	plantname = "sososi plant"
	product = /obj/item/reagent_containers/food/snacks/grown/sososi
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

/obj/item/reagent_containers/food/snacks/grown/sososi
	seed = null
	name = "sososi leaf"
	desc = "A thick leaf from a Tecetian succulent. It contains a gel-like concentration in its leaves, which while alive stored water and sugars."
	icon_state = "sososi"
	gender = PLURAL
	filling_color = "#FF00FF"
	bitesize_mod = 2
	foodtype = FRUIT
	juice_results = null
	tastes = list("crisp gel" = 1)
	distill_reagent = /datum/reagent/consumable/ethanol/sososeta
