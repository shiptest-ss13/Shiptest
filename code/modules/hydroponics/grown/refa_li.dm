// refa-li
// needs - REAL icon state for the plant i am SHIT SPRITING one RIGHT NOW

/obj/item/seeds/refa_li
	name = "pack of refa-li seeds"
	desc = "These seeds grow into a refa-li vine. Feel the heat!"
	icon_state = "seed-refa"
	species = "chilirefa"
	plantname = "refa-li vine"
	product = /obj/item/food/grown/refa_li
	lifespan = 12
	maturation = 4
	production = 6
	yield = 6
	potency = 10
	growing_icon = 'icons/obj/hydroponics/growing_vegetables.dmi'
	icon_grow = "chili-grow"
	icon_dead = "chili-dead"
	reagents_add = list(/datum/reagent/consumable/refa_li = 0.25, /datum/reagent/consumable/nutriment/vitamin = 0.04, /datum/reagent/consumable/nutriment = 0.04)

/obj/item/food/grown/refa_li
	seed = /obj/item/seeds/refa_li
	name = "refa-li"
	desc = "the fruit of a small flowering vine common within Tecetian caves. As a defense mechanism, the fruit evolved a pungent sort of heat."
	icon_state = "refa-li"
	filling_color = "#FF0000"
	bite_consumption_mod = 2
	foodtypes = FRUIT
	juice_results = list(/datum/reagent/consumable/refa_li = 0)
