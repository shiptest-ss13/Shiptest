/obj/item/seeds/cocaleaf
	name = "pack of coca leaf seeds"
	desc = "These seeds grow into coca shrubs. They make you feel energized just looking at them..."
	icon_state = "seed-cocoleaf"
	species = "cocoleaf"
	plantname = "Coca Leaves"
	maturation = 8
	potency = 20
	growthstages = 1
	growing_icon = 'icons/obj/hydroponics/growing.dmi'
	product = /obj/item/reagent_containers/food/snacks/grown/cocaleaf
	mutatelist = list()
	reagents_add = list(/datum/reagent/drug/cocaine = 0.3, /datum/reagent/consumable/nutriment = 0.15)

/obj/item/reagent_containers/food/snacks/grown/cocaleaf
	seed = /obj/item/seeds/cocaleaf
	name = "coca leaf"
	desc = "A leaf of the coca shrub, which contains a potent psychoactive alkaloid known as 'cocaine'."
	icon_state = "cocoleaf"
	foodtype = FRUIT //i guess? i mean it grows on trees...
	tastes = list("leaves" = 1)
