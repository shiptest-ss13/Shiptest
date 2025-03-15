
/////////////////////////////////////////////////PIZZA////////////////////////////////////////

/obj/item/reagent_containers/food/snacks/pizza
	icon = 'icons/obj/food/pizzaspaghetti.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	slices_num = 6
	volume = 80
	list_reagents = list(/datum/reagent/consumable/nutriment = 30, /datum/reagent/consumable/tomatojuice = 6, /datum/reagent/consumable/nutriment/vitamin = 5)
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1)
	foodtype = GRAIN | DAIRY | VEGETABLES

/obj/item/reagent_containers/food/snacks/pizzaslice
	icon = 'icons/obj/food/pizzaspaghetti.dmi'
	list_reagents = list(/datum/reagent/consumable/nutriment = 5)
	foodtype = GRAIN | DAIRY | VEGETABLES

/obj/item/reagent_containers/food/snacks/pizza/margherita
	name = "pizza margherita"
	desc = "A Neapolitan pizza, consisting of crushed tomatoes, mozzarella, and basil leaves. Known for being very cheese-focused and its softer crust."
	icon_state = "pizzamargherita"
	slice_path = /obj/item/reagent_containers/food/snacks/pizzaslice/margherita
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/consumable/nutriment/vitamin = 5)
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1)
	foodtype = GRAIN | VEGETABLES | DAIRY

/obj/item/reagent_containers/food/snacks/pizza/margherita/robo/Initialize()
	bonus_reagents += list(/datum/reagent/nanomachines = 70)
	return ..()

/obj/item/reagent_containers/food/snacks/pizzaslice/margherita
	name = "margherita slice"
	desc = "A slice of margherita pizza. It's quite cheese-heavy."
	icon_state = "pizzamargheritaslice"
	filling_color = "#FFA500"
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1)
	foodtype = GRAIN | VEGETABLES | DAIRY

/obj/item/reagent_containers/food/snacks/pizza/meat
	name = "meatpizza"
	desc = "A cheese pizza, primarily topped with various meats."
	icon_state = "meatpizza"
	slice_path = /obj/item/reagent_containers/food/snacks/pizzaslice/meat
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/consumable/nutriment/vitamin = 8)
	list_reagents = list(/datum/reagent/consumable/nutriment = 30, /datum/reagent/consumable/tomatojuice = 6, /datum/reagent/consumable/nutriment/vitamin = 8)
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "meat" = 1)
	foodtype = GRAIN | VEGETABLES| DAIRY | MEAT

/obj/item/reagent_containers/food/snacks/pizzaslice/meat
	name = "meatpizza slice"
	desc = "A slice of a meat-topped pizza."
	icon_state = "meatpizzaslice"
	filling_color = "#A52A2A"
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "meat" = 1)
	foodtype = GRAIN | VEGETABLES | DAIRY | MEAT

/obj/item/reagent_containers/food/snacks/pizza/mushroom
	name = "mushroom pizza"
	desc = "A cheese pizza, coated in baked, domestic mushrooms."
	icon_state = "mushroompizza"
	slice_path = /obj/item/reagent_containers/food/snacks/pizzaslice/mushroom
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/consumable/nutriment/vitamin = 5)
	list_reagents = list(/datum/reagent/consumable/nutriment = 30, /datum/reagent/consumable/nutriment/vitamin = 5)
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "mushroom" = 1)
	foodtype = GRAIN | VEGETABLES | DAIRY

/obj/item/reagent_containers/food/snacks/pizzaslice/mushroom
	name = "mushroom pizza slice"
	desc = "A slice of a mushroom-coated cheese pizza."
	icon_state = "mushroompizzaslice"
	filling_color = "#FFE4C4"
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "mushroom" = 1)
	foodtype = GRAIN | VEGETABLES | DAIRY

/obj/item/reagent_containers/food/snacks/pizza/vegetable
	name = "vegetable pizza"
	desc = "A cheese pizza that's been topped with multiple traditional vegetable toppings... and carrot."
	icon_state = "vegetablepizza"
	slice_path = /obj/item/reagent_containers/food/snacks/pizzaslice/vegetable
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/consumable/nutriment/vitamin = 5)
	list_reagents = list(/datum/reagent/consumable/nutriment = 25, /datum/reagent/consumable/tomatojuice = 6, /datum/reagent/medicine/oculine = 12, /datum/reagent/consumable/nutriment/vitamin = 5)
	tastes = list("crust" = 1, "tomato" = 2, "cheese" = 1, "carrot" = 1)
	foodtype = GRAIN | VEGETABLES | DAIRY

/obj/item/reagent_containers/food/snacks/pizzaslice/vegetable
	name = "vegetable pizza slice"
	desc = "A slice of a cheese and vegetable (and carrot?) pizza."
	icon_state = "vegetablepizzaslice"
	filling_color = "#FFA500"
	tastes = list("crust" = 1, "tomato" = 2, "cheese" = 1, "carrot" = 1)
	foodtype = GRAIN | VEGETABLES | DAIRY

/obj/item/reagent_containers/food/snacks/pizza/donkpocket
	name = "donkpocket pizza"
	desc = "A cheese pizza that's been topped with slices of Donk! Co.'s trademark shelf-stable microwaveable turnovers. It's unwieldy."
	icon_state = "donkpocketpizza"
	slice_path = /obj/item/reagent_containers/food/snacks/pizzaslice/donkpocket
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/consumable/nutriment/vitamin = 5)
	list_reagents = list(/datum/reagent/consumable/nutriment = 25, /datum/reagent/consumable/tomatojuice = 6, /datum/reagent/medicine/omnizine = 10, /datum/reagent/consumable/nutriment/vitamin = 5)
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "meat" = 1, "laziness" = 1)
	foodtype = GRAIN | VEGETABLES | DAIRY | MEAT | JUNKFOOD

/obj/item/reagent_containers/food/snacks/pizzaslice/donkpocket
	name = "donkpocket pizza slice"
	desc = "A cheese pizza slice, topped with slices of Donk! Co.'s trademark shelf-stable microwaveable turnovers."
	icon_state = "donkpocketpizzaslice"
	filling_color = "#FFA500"
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "meat" = 1, "laziness" = 1)
	foodtype = GRAIN | VEGETABLES | DAIRY | MEAT | JUNKFOOD

/obj/item/reagent_containers/food/snacks/pizza/dank
	name = "dank pizza"
	desc = "A cheese pizza topped with ambrosia vulgaris. While baking it has not made it any less bitter, some swear by its medicinal (and psychogenic) effects."
	icon_state = "dankpizza"
	slice_path = /obj/item/reagent_containers/food/snacks/pizzaslice/dank
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/nutriment/vitamin = 6)
	list_reagents = list(/datum/reagent/consumable/nutriment = 25, /datum/reagent/consumable/doctor_delight = 5, /datum/reagent/consumable/tomatojuice = 6, /datum/reagent/consumable/nutriment/vitamin = 5)
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "meat" = 1)
	foodtype = GRAIN | VEGETABLES | DAIRY

/obj/item/reagent_containers/food/snacks/pizzaslice/dank
	name = "dank pizza slice"
	desc = "A slice of cheese pizza that's been topped with ambrosia vulgaris."
	icon_state = "dankpizzaslice"
	filling_color = "#2E8B57"
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "meat" = 1)
	foodtype = GRAIN | VEGETABLES | DAIRY

/obj/item/reagent_containers/food/snacks/pizza/sassysage
	name = "sausage pizza"
	desc = "A cheese pizza that's been topped with slices of sausage."
	icon_state = "sassysagepizza"
	slice_path = /obj/item/reagent_containers/food/snacks/pizzaslice/sassysage
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/nutriment/vitamin = 6)
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "meat" = 1)
	foodtype = GRAIN | VEGETABLES | DAIRY

/obj/item/reagent_containers/food/snacks/pizzaslice/sassysage
	name = "sausage pizza slice"
	desc = "A slice of cheese pizza, topped with slices of sausage."
	icon_state = "sassysagepizzaslice"
	filling_color = "#FF4500"
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "meat" = 1)
	foodtype = GRAIN | VEGETABLES | DAIRY

/obj/item/reagent_containers/food/snacks/pizza/pineapple
	name = "\improper Hawaiian pizza"
	desc = "A cheese pizza that's been topped with pineapple squares and ham."
	icon_state = "pineapplepizza"
	slice_path = /obj/item/reagent_containers/food/snacks/pizzaslice/pineapple
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/nutriment/vitamin = 6)
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "pineapple" = 2, "ham" = 2)
	foodtype = GRAIN | VEGETABLES | DAIRY | MEAT | FRUIT | PINEAPPLE

/obj/item/reagent_containers/food/snacks/pizzaslice/pineapple
	name = "\improper Hawaiian pizza slice"
	desc = "A slice of cheese pizza, topped with ham and pineapple squares."
	icon_state = "pineapplepizzaslice"
	filling_color = "#FF4500"
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "pineapple" = 2, "ham" = 2)
	foodtype = GRAIN | VEGETABLES | DAIRY | MEAT | FRUIT | PINEAPPLE

/obj/item/reagent_containers/food/snacks/pizzaslice/custom
	name = "pizza slice"
	icon_state = "pizzamargheritaslice"
	filling_color = "#FFFFFF"
	foodtype = GRAIN | VEGETABLES
