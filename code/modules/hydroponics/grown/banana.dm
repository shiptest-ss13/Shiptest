// Banana
/obj/item/seeds/banana
	name = "pack of banana seeds"
	desc = "A fruit tree native to Sol. The fruits are rich in potassium and flavor!"
	icon_state = "seed-banana"
	species = "banana"
	plantname = "Banana Tree"
	product = /obj/item/food/grown/banana
	lifespan = 50
	endurance = 30
	growing_icon = 'icons/obj/hydroponics/growing_fruits.dmi'
	icon_dead = "banana-dead"
	genes = list(/datum/plant_gene/trait/slip, /datum/plant_gene/trait/repeated_harvest)
	mutatelist = list(/obj/item/seeds/banana/bluespace)
	reagents_add = list(/datum/reagent/consumable/banana = 0.1, /datum/reagent/potassium = 0.1, /datum/reagent/consumable/nutriment/vitamin = 0.04, /datum/reagent/consumable/nutriment = 0.02)

/obj/item/food/grown/banana
	seed = /obj/item/seeds/banana
	name = "banana"
	desc = "A small, tasty fruit rich in potassium."
	icon_state = "banana"
	item_state = "banana"
	trash_type = /obj/item/grown/bananapeel
	bite_consumption_mod = 3
	foodtypes = FRUIT
	juice_results = list(/datum/reagent/consumable/banana = 0)
	distill_reagent = /datum/reagent/consumable/ethanol/bananahonk

//Banana Peel
/obj/item/grown/bananapeel
	seed = /obj/item/seeds/banana
	name = "banana peel"
	desc = "A peel from a banana."
	lefthand_file = 'icons/mob/inhands/misc/food_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/food_righthand.dmi'
	icon_state = "banana_peel"
	item_state = "banana_peel"
	w_class = WEIGHT_CLASS_TINY
	throwforce = 0
	throw_speed = 3
	throw_range = 7

/obj/item/grown/bananapeel/Initialize(mapload)
	. = ..()
	if(prob(40))
		if(prob(60))
			icon_state = "[icon_state]_2"
		else
			icon_state = "[icon_state]_3"

// Bluespace Banana
/obj/item/seeds/banana/bluespace
	name = "pack of bluespace banana seeds"
	desc = "They're seeds that grow into bluespace banana trees."
	icon_state = "seed-banana-blue"
	species = "bluespacebanana"
	icon_grow = "banana-grow"
	plantname = "Bluespace Banana Tree"
	product = /obj/item/food/grown/banana/bluespace
	mutatelist = list()
	genes = list(/datum/plant_gene/trait/slip, /datum/plant_gene/trait/teleport, /datum/plant_gene/trait/repeated_harvest)
	reagents_add = list(/datum/reagent/bluespace = 0.2, /datum/reagent/consumable/banana = 0.1, /datum/reagent/consumable/nutriment/vitamin = 0.04, /datum/reagent/consumable/nutriment = 0.02)
	rarity = 30
	research = PLANT_RESEARCH_TIER_3

/obj/item/food/grown/banana/bluespace
	seed = /obj/item/seeds/banana/bluespace
	name = "bluespace banana"
	icon_state = "bluenana"
	item_state = "bluespace_peel"
	trash_type = /obj/item/grown/bananapeel/bluespace
	tastes = list("banana" = 1)
	wine_power = 60
	wine_flavor = "slippery hypercubes"

/obj/item/grown/bananapeel/bluespace
	seed = /obj/item/seeds/banana/bluespace
	name = "bluespace banana peel"
	desc = "A peel from a bluespace banana."
	icon_state = "bluenana_peel"
