// seaweed
/obj/item/seeds/seaweed
	name = "pack of seaweed seeds" //dude, i pinkypromise! of course seaweed has seeds :)
	desc = "These seeds grow into seaweed."
	icon_state = "seed-seaweed"
	species = "seaweed"
	plantname = "seaweeds"
	product = /obj/item/reagent_containers/food/snacks/grown/seaweed
	maturation = 8
	yield = 4
	growing_icon = 'icons/obj/hydroponics/growing.dmi'
	icon_grow = "seaweed-grow"
	icon_dead = "seaweed-dead"
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	reagents_add = list(/datum/reagent/water = 0.1, /datum/reagent/consumable/nutriment/vitamin = 0.04, /datum/reagent/consumable/nutriment = 0.2)

/obj/item/reagent_containers/food/snacks/grown/seaweed
	seed = /obj/item/seeds/seaweed
	name = "seaweed"
	desc = "It's so rubbery... is this safe to eat?"
	icon_state = "seaweed"
	filling_color = "#4a7244"
	bitesize_mod = 3
	foodtype = VEGETABLES
	grind_results = list(/datum/reagent/water = 1)

