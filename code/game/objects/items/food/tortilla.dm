/obj/item/food/tortilla
	name = "tortilla"
	desc = "A thin, unleavened flatbread used for dozens of dishes. Or eaten as is, if you want."
	icon = 'icons/obj/food/food_ingredients.dmi'
	icon_state = "tortilla"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("tortilla" = 1)
	foodtypes = GRAIN
	w_class = WEIGHT_CLASS_TINY

/obj/item/food/burrito
	name = "burrito"
	desc = "A tortilla filled with ground meat and cooked."
	icon = 'icons/obj/food/tortilla.dmi'
	icon_state = "burrito"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("tortilla" = 2, "beans" = 3)
	foodtypes = GRAIN
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/cheesyburrito
	name = "cheesy burrito"
	desc = "A tortilla filled with meat and cheese."
	icon = 'icons/obj/food/tortilla.dmi'
	icon_state = "cheesyburrito"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("tortilla" = 2, "beans" = 3, "cheese" = 1)
	foodtypes = GRAIN | DAIRY
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/carneburrito
	name = "carne asada burrito"
	desc = "A tortilla filled with thin strips of grilled steak."
	icon = 'icons/obj/food/tortilla.dmi'
	icon_state = "carneburrito"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("tortilla" = 2, "meat" = 4)
	foodtypes = GRAIN | MEAT
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/fuegoburrito
	name = "fuego plasma burrito"
	desc = "A tortilla filled with meat and chili peppers."
	icon = 'icons/obj/food/tortilla.dmi'
	icon_state = "fuegoburrito"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/capsaicin = 5,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("tortilla" = 2, "beans" = 3, "hot peppers" = 1)
	foodtypes = GRAIN
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/nachos
	name = "nachos"
	desc = "A tortilla shredded into pieces and fried."
	icon = 'icons/obj/food/tortilla.dmi'
	icon_state = "nachos"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("nachos" = 1)
	foodtypes = GRAIN | FRIED
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/cheesynachos
	name = "cheesy nachos"
	desc = "A tortilla shredded into pieces and fried, and served with a coating of queso cheese."
	icon = 'icons/obj/food/tortilla.dmi'
	icon_state = "cheesynachos"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 1,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("nachos" = 2, "cheese" = 1)
	foodtypes = GRAIN | FRIED | DAIRY
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/cubannachos
	name = "Cuban nachos"
	desc = "A tortilla shredded into pieces, fried, and served with hot peppers and cheese."
	icon = 'icons/obj/food/tortilla.dmi'
	icon_state = "cubannachos"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 7,
		/datum/reagent/consumable/capsaicin = 8,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("nachos" = 2, "hot pepper" = 1)
	foodtypes = VEGETABLES | FRIED | DAIRY
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/taco
	name = "classic taco"
	desc = "A taco shell filled with meat, cheese, and lettuce."
	icon = 'icons/obj/food/tortilla.dmi'
	icon_state = "taco"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 3,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("taco" = 4, "meat" = 2, "cheese" = 2, "lettuce" = 1)
	foodtypes = MEAT | DAIRY | GRAIN | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/taco/plain
	name = "plain taco"
	desc = "A taco filled with meat and cheese."
	icon_state = "taco_plain"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("taco" = 4, "meat" = 2, "cheese" = 2)
	foodtypes = MEAT | DAIRY | GRAIN

/obj/item/food/enchiladas
	name = "enchiladas"
	desc = "A warm meal of filled corn tortillas and coated in a savory, chili-based sauce."
	icon = 'icons/obj/food/tortilla.dmi'
	icon_state = "enchiladas"
	bite_consumption = 4
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 7,
		/datum/reagent/consumable/capsaicin = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2
	)
	tastes = list("hot peppers" = 1, "meat" = 3, "cheese" = 1, "sour cream" = 1)
	foodtypes = MEAT | GRAIN
	w_class = WEIGHT_CLASS_SMALL
