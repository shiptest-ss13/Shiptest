/obj/item/reagent_containers/food/snacks/salad/edensalad
	name = "\improper Salad of Eden"
	desc = "A salad brimming with untapped potential."
	icon_state = "eden_salad"
	trash = /obj/item/reagent_containers/glass/bowl
	list_reagents = list(/datum/reagent/consumable/nutriment = 7, /datum/reagent/consumable/nutriment/vitamin = 5, /datum/reagent/medicine/earthsblood = 3, /datum/reagent/medicine/omnizine = 5, /datum/reagent/drug/happiness = 2)
	tastes = list("hope" = 1)
	foodtype = VEGETABLES

/obj/item/reagent_containers/food/snacks/salad/gumbo
	name = "black eyed gumbo"
	desc = "A spicy and savory meat and rice dish."
	icon_state = "gumbo"
	trash = /obj/item/reagent_containers/glass/bowl
	list_reagents = list(/datum/reagent/consumable/capsaicin = 2, /datum/reagent/consumable/nutriment/vitamin = 3, /datum/reagent/consumable/nutriment = 5)
	tastes = list("building heat" = 2, "savory meat and vegtables" = 1)
	foodtype = GRAIN | MEAT | VEGETABLES
