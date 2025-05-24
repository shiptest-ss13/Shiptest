//Whole
/obj/item/food/pizza
	icon = 'icons/obj/food/pizza.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	max_volume = 80
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 28,
		/datum/reagent/consumable/nutriment/protein = 3,
		/datum/reagent/consumable/tomatojuice = 6,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1)
	foodtypes = GRAIN | DAIRY | VEGETABLES
	//burns_in_oven = TRUE
	///Type is spawned 6 at a time and replaces this pizza when processed by cutting tool
	var/obj/item/food/pizzaslice/slice_type

/obj/item/food/pizza/make_processable()
	if(slice_type)
		AddElement(/datum/element/processable, TOOL_KNIFE, slice_type, 6, 3 SECONDS, table_required = TRUE, /*screentip_verb = "Slice"*/)
		AddElement(/datum/element/processable, TOOL_SAW, slice_type, 6, 4.5 SECONDS, table_required = TRUE, /*screentip_verb = "Slice"*/)
		AddElement(/datum/element/processable, TOOL_SCALPEL, slice_type, 6, 6 SECONDS, table_required = TRUE, /*screentip_verb = "Slice"*/)

//Slices
/obj/item/food/pizzaslice
	icon = 'icons/obj/food/pizza.dmi'
	food_reagents = list(/datum/reagent/consumable/nutriment = 5)
	foodtypes = GRAIN | DAIRY | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/pizzaslice/make_processable()
	AddElement(/datum/element/processable, TOOL_ROLLINGPIN, 1, 1 SECONDS, table_required = TRUE)

/obj/item/food/pizza/margherita
	name = "pizza margherita"
	desc = "The most cheezy pizza in galaxy."
	icon_state = "pizzamargherita"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 25,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/tomatojuice = 6,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY
	slice_type = /obj/item/food/pizzaslice/margherita

/obj/item/food/pizza/margherita/robo
	food_reagents = list(
		/datum/reagent/nanomachines = 70,
		/datum/reagent/consumable/nutriment = 25,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/tomatojuice = 6,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)

/obj/item/food/pizzaslice/margherita
	name = "margherita slice"
	desc = "A slice of the most cheezy pizza in galaxy."
	icon_state = "pizzamargheritaslice"
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY

/* Customfood
/obj/item/food/pizzaslice/margherita/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/customizable_reagent_holder, null, CUSTOM_INGREDIENT_ICON_FILL, max_ingredients = 12)
*/

/obj/item/food/pizza/meat
	name = "meatpizza"
	desc = "Greasy pizza with delicious meat."
	icon_state = "meatpizza"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 25,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/tomatojuice = 6,
		/datum/reagent/consumable/nutriment/vitamin = 8,
	)
	foodtypes = GRAIN | VEGETABLES| DAIRY | MEAT
	slice_type = /obj/item/food/pizzaslice/meat

/obj/item/food/pizzaslice/meat
	name = "meatpizza slice"
	desc = "A nutritious slice of meatpizza."
	icon_state = "meatpizzaslice"
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "meat" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY | MEAT

/obj/item/food/pizza/mushroom
	name = "mushroom pizza"
	desc = "Very special pizza."
	icon_state = "mushroompizza"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 28,
		/datum/reagent/consumable/nutriment/protein = 3,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "mushroom" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY
	slice_type = /obj/item/food/pizzaslice/mushroom

/obj/item/food/pizzaslice/mushroom
	name = "mushroom pizza slice"
	desc = "Maybe it is the last slice of pizza in your life."
	icon_state = "mushroompizzaslice"
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "mushroom" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY

/obj/item/food/pizza/vegetable
	name = "vegetable pizza"
	desc = "Not one of the Tomatos Sapiens were harmed during the making of this pizza."
	icon_state = "vegetablepizza"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 25,
		/datum/reagent/consumable/tomatojuice = 6,
		/datum/reagent/medicine/oculine = 12,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("crust" = 1, "tomato" = 2, "cheese" = 1, "carrot" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY
	slice_type = /obj/item/food/pizzaslice/vegetable

/obj/item/food/pizzaslice/vegetable
	name = "vegetable pizza slice"
	desc = "A slice of the most green pizza of all pizzas not containing green ingredients."
	icon_state = "vegetablepizzaslice"
	tastes = list("crust" = 1, "tomato" = 2, "cheese" = 1, "carrot" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY

/obj/item/food/pizza/donkpocket
	name = "donkpocket pizza"
	desc = "Who thought this would be a good idea?"
	icon_state = "donkpocketpizza"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 20,
		/datum/reagent/consumable/nutriment/protein = 15,
		/datum/reagent/consumable/tomatojuice = 6,
		/datum/reagent/medicine/omnizine = 10,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "meat" = 1, "laziness" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY | MEAT | JUNKFOOD
	slice_type = /obj/item/food/pizzaslice/donkpocket

/obj/item/food/pizzaslice/donkpocket
	name = "donkpocket pizza slice"
	desc = "Smells like donkpocket."
	icon_state = "donkpocketpizzaslice"
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "meat" = 1, "laziness" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY | MEAT | JUNKFOOD

/obj/item/food/pizza/dank
	name = "dank pizza"
	desc = "The hippie's pizza of choice."
	icon_state = "dankpizza"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 25,
		/datum/reagent/consumable/doctor_delight = 5,
		/datum/reagent/consumable/tomatojuice = 6,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "meat" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY
	slice_type = /obj/item/food/pizzaslice/dank

/obj/item/food/pizzaslice/dank
	name = "dank pizza slice"
	desc = "So good, man..."
	icon_state = "dankpizzaslice"
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "meat" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY

/obj/item/food/pizza/sassysage
	name = "sassysage pizza"
	desc = "You can really smell the sassiness."
	icon_state = "sassysagepizza"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 20,
		/datum/reagent/consumable/nutriment/protein = 15,
		/datum/reagent/consumable/tomatojuice = 6,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "meat" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY
	slice_type = /obj/item/food/pizzaslice/sassysage

/obj/item/food/pizzaslice/sassysage
	name = "sassysage pizza slice"
	desc = "Deliciously sassy."
	icon_state = "sassysagepizzaslice"
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "meat" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY

/obj/item/food/pizza/pineapple
	name = "\improper Hawaiian pizza"
	desc = "The pizza equivalent of Einstein's riddle."
	icon_state = "pineapplepizza"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 20,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/tomatojuice = 6,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/pineapplejuice = 8,
	)
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "pineapple" = 2, "ham" = 2)
	foodtypes = GRAIN | VEGETABLES | DAIRY | MEAT | FRUIT | PINEAPPLE
	slice_type = /obj/item/food/pizzaslice/pineapple

/obj/item/food/pizzaslice/pineapple
	name = "\improper Hawaiian pizza slice"
	desc = "A slice of delicious controversy."
	icon_state = "pineapplepizzaslice"
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "pineapple" = 2, "ham" = 2)
	foodtypes = GRAIN | VEGETABLES | DAIRY | MEAT | FRUIT | PINEAPPLE
