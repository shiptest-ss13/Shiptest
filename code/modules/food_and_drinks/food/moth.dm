//Base ingredients and miscellany, generally not served on their own
/obj/item/reagent_containers/food/snacks/herby_cheese
	name = "herby cheese"
	desc = "As a staple of spacer cuisine, cheese is often augmented with various flavours to keep variety in their diet whilst traveling without reliable access to refrigeration. \
		Herbs are one such addition, and are particularly beloved."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "herby_cheese"
	list_reagents = list(/datum/reagent/consumable/cooking_oil = 6)
	tastes = list("cheese" = 1, "herbs" = 1)
	foodtype = DAIRY | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/grilled_cheese
	name = "grilled cheese"
	desc = "A staple sandwich, the classic grilled cheese consists simply of griddled bread and cheese. Anything else, *and it's a melt*."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "grilled_cheese"
	list_reagents = list(
		/datum/reagent/consumable/cooking_oil = 8,
		/datum/reagent/consumable/char = 1,
	)
	tastes = list("cheese" = 1, "char" = 1)
	foodtype = DAIRY
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/mothic_salad
	name = "basic salad"
	desc = "A basic salad of cabbage, red onion and tomato. Can serve as a perfect base for a million different salads."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "mothic_salad"
	list_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 6)
	tastes = list("salad" = 1)
	foodtype = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/toasted_seeds
	name = "toasted seeds"
	desc = "While they're far from filling, toasted seeds are a popular snack amongst travelers. \
		Salt, sugar, or even some more exotic flavours may be added for some extra pep."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "toasted_seeds"
	list_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 5)
	tastes = list("seeds" = 1)
	foodtype = GRAIN
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/engine_fodder
	name = "comet trail"
	desc = "A common snack for engineers on modern military vessels, made of seeds, nuts, chocolate, popcorn, and potato chips- \
		designed to be dense with calories and easy to snack on when an extra boost is needed."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "engine_fodder"
	list_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/sugar = 4,
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/sodiumchloride = 2,
	)
	tastes = list("seeds" = 1, "nuts" = 1, "chocolate" = 1, "salt" = 1, "popcorn" = 1, "potato" = 1)
	foodtype = GRAIN | NUTS | VEGETABLES | SUGAR
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/mothic_pizza_dough
	name = "Solar pizza dough"
	desc = "A strong, glutenous dough, made with cornmeal and flour, designed to hold up to cheese and sauce."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "mothic_pizza_dough"
	list_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 6)
	tastes = list("raw flour" = 1)
	foodtype = GRAIN
	w_class = WEIGHT_CLASS_SMALL

//Entrees: categorising food that is 90% cheese and salad is not easy
/obj/item/reagent_containers/food/snacks/squeaking_stir_fry
	name = "squeaking stir fry"
	desc = "A Solarian classic made with cheese curds and tofu (amongst other things). \
		It gets its name from the distinctive squeak of the proteins."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "squeaking_stir_fry"
	list_reagents = list(
		/datum/reagent/consumable/cooking_oil = 8,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("cheese" = 1, "tofu" = 1, "veggies" = 1)
	foodtype = DAIRY | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/sweet_chili_cabbage_wrap
	name = "sweet chili cabbage wrap"
	desc = "Grilled cheese and salad in a cabbage wrap, topped with delicious sweet chili sauce."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "sweet_chili_cabbage_wrap"
	list_reagents = list(
		/datum/reagent/consumable/cooking_oil = 8,
		/datum/reagent/consumable/nutriment/vitamin = 8,
		/datum/reagent/consumable/capsaicin = 1,
	)
	tastes = list("cheese" = 1, "salad" = 1, "sweet chili" = 1)
	foodtype = DAIRY | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/loaded_curds
	name = "chili poutine"
	desc = "What's better than cheese curds? Deep fried cheese curds! What's better than deep fried cheese curds? \
		Deep fried cheese curds with chili (and more cheese) on top! And what's better than that? Putting it on fries!"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "loaded_curds"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/cooking_oil = 10,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/capsaicin = 1,
	)
	tastes = list("cheese" = 1, "oil" = 1, "chili" = 1, "fries" = 1)
	foodtype = DAIRY | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/baked_cheese
	name = "baked cheese wheel"
	desc = "A baked cheese wheel, melty and delicious."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "baked_cheese"
	list_reagents = list(
		/datum/reagent/consumable/cooking_oil = 10,
		/datum/reagent/consumable/nutriment/vitamin = 5,
		/datum/reagent/consumable/nutriment = 5,
	)
	tastes = list("cheese" = 1)
	foodtype = DAIRY
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/baked_cheese_platter
	name = "oven-baked cheese"
	desc = "A baked cheese wheel: a Solarian favourite for sharing. Usually served with crispy bread slices for dipping, \
		because the only thing better than good cheese is good cheese on bread. A popular fixture at SolGov office parties."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "baked_cheese_platter"
	list_reagents = list(
		/datum/reagent/consumable/cooking_oil = 12,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/nutriment = 8,
	)
	tastes = list("cheese" = 1, "bread" = 1)
	foodtype = DAIRY | GRAIN
	w_class = WEIGHT_CLASS_SMALL

//Baked Green Lasagna at the Whistlestop Cafe
/obj/item/reagent_containers/food/snacks/raw_green_lasagne
	name = "raw green lasagne al forno"
	desc = "A fine lasagne made with pesto and a herby white sauce, ready to bake. Good for multiple servings."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "raw_green_lasagne"
	list_reagents = list(
		/datum/reagent/consumable/cooking_oil = 6,
		/datum/reagent/consumable/nutriment/vitamin = 10,
	)
	tastes = list("cheese" = 1, "pesto" = 1, "pasta" = 1)
	foodtype = VEGETABLES | GRAIN | NUTS | RAW
	w_class = WEIGHT_CLASS_NORMAL
	cooked_type = /obj/item/reagent_containers/food/snacks/green_lasagne

/obj/item/reagent_containers/food/snacks/green_lasagne
	name = "green lasagne al forno"
	desc = "A fine lasagne made with pesto and a herby white sauce. Good for multiple servings."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "green_lasagne"
	list_reagents = list(
		/datum/reagent/consumable/cooking_oil = 24,
		/datum/reagent/consumable/nutriment/vitamin = 18,
	)
	tastes = list("cheese" = 1, "pesto" = 1, "pasta" = 1)
	foodtype = VEGETABLES | GRAIN | NUTS
	w_class = WEIGHT_CLASS_NORMAL
	slice_path = /obj/item/reagent_containers/food/snacks/green_lasagne_slice
	slices_num = 6

/obj/item/reagent_containers/food/snacks/green_lasagne_slice
	name = "green lasagne al forno slice"
	desc = "A slice of herby, pesto-y lasagne."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "green_lasagne_slice"
	list_reagents = list(
		/datum/reagent/consumable/cooking_oil = 4,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("cheese" = 1, "pesto" = 1, "pasta" = 1)
	foodtype = VEGETABLES | GRAIN | NUTS
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/raw_baked_rice
	name = "big rice pan"
	desc = "A big pan of layered potatoes topped with rice and vegetable stock, ready to be baked into a delicious sharing meal."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "raw_baked_rice"
	list_reagents = list(
		/datum/reagent/consumable/cooking_oil = 4,
		/datum/reagent/consumable/nutriment/vitamin = 10,
	)
	tastes = list("rice" = 1, "potato" = 1, "veggies" = 1)
	foodtype = VEGETABLES | GRAIN | RAW
	w_class = WEIGHT_CLASS_NORMAL
	cooked_type = /obj/item/reagent_containers/food/snacks/big_baked_rice

/obj/item/reagent_containers/food/snacks/big_baked_rice
	name = "big baked rice"
	desc = "A Solarian favourite, baked rice can be filled with a variety of vegetable fillings to make a delicious meal to share. \
		Potatoes are also often layered on the bottom of the cooking vessel to create a flavourful crust which is hotly contested amongst diners. Originates from the flotillas formed in Polynesia after the Night of Fire."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "big_baked_rice"
	list_reagents = list(
		/datum/reagent/consumable/cooking_oil = 18,
		/datum/reagent/consumable/nutriment/vitamin = 42,
	)
	tastes = list("rice" = 1, "potato" = 1, "veggies" = 1)
	foodtype = VEGETABLES | GRAIN
	w_class = WEIGHT_CLASS_NORMAL
	slice_path = /obj/item/reagent_containers/food/snacks/lil_baked_rice
	slices_num = 6

/obj/item/reagent_containers/food/snacks/lil_baked_rice
	name = "lil baked rice"
	desc = "A single portion of baked rice, perfect as a side dish, or even as a full meal."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "lil_baked_rice"
	list_reagents = list(
		/datum/reagent/consumable/cooking_oil = 3,
		/datum/reagent/consumable/nutriment/vitamin = 7,
	)
	tastes = list("rice" = 1, "potato" = 1, "veggies" = 1)
	foodtype = VEGETABLES | GRAIN
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/oven_baked_corn
	name = "oven-baked corn"
	desc = "A cob of corn, baked in the roasting heat of an oven until it blisters and blackens. \
		Beloved as a quick yet flavourful and filling component for dishes on the Fleet."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "oven_baked_corn"
	list_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/char = 1,
	)
	tastes = list("corn" = 1, "char" = 1)
	foodtype = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/buttered_baked_corn
	name = "buttered baked corn"
	desc = "What's better than baked corn? Baked corn with butter!"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "buttered_baked_corn"
	list_reagents = list(
		/datum/reagent/consumable/cooking_oil = 4,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/char = 1,
	)
	tastes = list("corn" = 1, "char" = 1)
	foodtype = VEGETABLES | DAIRY
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/fiesta_corn_skillet
	name = "fiesta corn skillet"
	desc = "Sweet, spicy, saucy, and all kinds of corny."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "fiesta_corn_skillet"
	list_reagents = list(
		/datum/reagent/consumable/cooking_oil = 5,
		/datum/reagent/consumable/nutriment/vitamin = 10,
		/datum/reagent/consumable/char = 1,
	)
	tastes = list("corn" = 1, "chili" = 1, "char" = 1)
	foodtype = VEGETABLES | DAIRY
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/raw_ratatouille
	name = "raw ratatouille" //rawtatouille?
	desc = "Sliced vegetables with a roasted pepper sauce. Delicious, for such a simple food."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "raw_ratatouille"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 8,
		/datum/reagent/consumable/char = 1,
	)
	tastes = list("veggies" = 1, "roasted peppers" = 1)
	foodtype = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	cooked_type = /obj/item/reagent_containers/food/snacks/ratatouille

/obj/item/reagent_containers/food/snacks/ratatouille
	name = "ratatouille"
	desc = "The perfect dish to save your restaurant from a vindictive food critic. Bonus points if you've got a rat in your hat."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "ratatouille"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 10,
		/datum/reagent/consumable/char = 1,
	)
	tastes = list("veggies" = 1, "roasted peppers" = 1, "char" = 1)
	foodtype = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/mozzarella_sticks
	name = "mozzarella sticks"
	desc = "Little sticks of mozzarella, breaded and fried."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "mozzarella_sticks"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/cooking_oil = 6,
	)
	tastes = list("creamy cheese" = 1, "breading" = 1, "oil" = 1)
	foodtype = DAIRY | GRAIN | FRIED
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/raw_stuffed_peppers
	name = "raw stuffed pepper"
	desc = "A pepper with the top removed and a herby cheese and onion mix stuffed inside. Probably shouldn't be eaten raw."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "raw_stuffed_pepper"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/cooking_oil = 6,
	)
	tastes = list("creamy cheese" = 1, "herbs" = 1, "onion" = 1, "bell pepper" = 1)
	foodtype = DAIRY | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	cooked_type = /obj/item/reagent_containers/food/snacks/stuffed_peppers

/obj/item/reagent_containers/food/snacks/stuffed_peppers
	name = "baked stuffed pepper"
	desc = "A soft yet still crisp bell pepper, with a wonderful melty cheesy interior."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "stuffed_pepper"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/cooking_oil = 8,
	)
	tastes = list("creamy cheese" = 1, "herbs" = 1, "onion" = 1, "bell pepper" = 1)
	foodtype = DAIRY | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/fueljacks_lunch
	name = "Astrengi's lunch"
	desc = "A dish made from fried vegetables, popular amongst astrengis - the brave technicans who repair damaged hulls from asteroid impacts or ship-to-ship weapons whilst in transit. \
		Given the constant need for repair during protracted conflict, and the limited windows in which a lull in the fields or fire provides time for patching, \
		they'll often take packed meals to save on trips to the mess, which they heat using their welding torches."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "fueljacks_lunch"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/cooking_oil = 8,
	)
	tastes = list("cabbage" = 1, "potato" = 1, "onion" = 1, "chili" = 1, "cheese" = 1)
	foodtype = DAIRY | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/mac_balls
	name = "macheronirölen"
	desc = "Fried balls of macaroni cheese dipped in corn batter, served with tomato sauce. \
		A popular snack across the galaxy, and especially on ex-Syndicate-majority Inteq vessels - where they tend to use Ready-Donk as the base, as a holdover from their ICW days."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "mac_balls"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/cooking_oil = 10,
	)
	tastes = list("pasta" = 1, "cornbread" = 1, "cheese" = 1)
	foodtype = DAIRY | VEGETABLES | FRIED | GRAIN
	w_class = WEIGHT_CLASS_SMALL

//Sweets
/obj/item/reagent_containers/food/snacks/moth_cheese_cakes
	name = "\improper ælorölen" //ælo = cheese, rölen = balls
	desc = "Ælorölen (cheese balls) are a traditional Solar dessert, made of soft cheese, powdered sugar and flour, rolled into balls, battered and then deep fried. They're often served with either chocolate sauce or honey, or sometimes both!"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "moth_cheese_cakes"
	list_reagents = list(
		/datum/reagent/consumable/cooking_oil = 8,
		/datum/reagent/consumable/sugar = 12,
	)
	tastes = list("cheesecake" = 1, "chocolate" = 1, "honey" = 1)
	foodtype = SUGAR | FRIED | DAIRY | GRAIN
	w_class = WEIGHT_CLASS_SMALL

//misc food
/obj/item/reagent_containers/food/snacks/bubblegum/wake_up
	name = "wake-up gum"
	desc = "A rubbery strip of gum. It's stamped with the emblem of the Solar Fleet."
	list_reagents = list(
		/datum/reagent/consumable/sugar = 13,
		/datum/reagent/drug/methamphetamine = 2,
	)
	tastes = list("herbs" = 1)
	color = "#567D46"

/obj/item/storage/box/gum/wake_up
	name = "\improper Activin 12 Hour medicated gum packet"
	desc = "Stay awake during long shifts in the maintenance tunnels with Activin! The approval seal of the Solar Fleet \
		is emblazoned on the packaging, alongside a litany of health and safety disclaimers in both Solar and Galactic Common."
	icon_state = "bubblegum_wake_up"
	custom_premium_price = 50 * 1.5

/obj/item/storage/box/gum/wake_up/examine_more(mob/user)
	. = ..()
	. += span_notice("<i>You read some of the health and safety information...</i>")
	. += "\t[span_info("For the relief of tiredness and drowsiness while working.")]"
	. += "\t[span_info("Do not chew more than one strip every 12 hours. Do not use as a complete substitute for sleep.")]"
	. += "\t[span_info("Do not give to children under 16. Do not exceed the maximum dosage. Do not ingest. Do not take for more than 3 days consecutively. Do not take in conjunction with other medication. May cause adverse reactions in patients with pre-existing heart conditions.")]"
	. += "\t[span_info("Side effects of Activin use may include twitchy antennae, overactive wings, loss of keratin sheen, loss of setae coverage, arrythmia, blurred vision, and euphoria. Cease taking the medication if side effects occur.")]"
	. += "\t[span_info("Repeated use may cause addiction.")]"
	. += "\t[span_info("If the maximum dosage is exceeded, inform a member of your assigned vessel's medical staff immediately. Do not induce vomiting.")]"
	. += "\t[span_info("Ingredients: each strip contains 500mg of Activin (dextro-methamphetamine). Other ingredients include Green Dye 450 (Verdant Meadow) and artificial herb flavouring.")]"
	. += "\t[span_info("Storage: keep in a cool dry place. Do not use after the use-by date: 32/4/350.")]"
	return .

/obj/item/storage/box/gum/wake_up/PopulateContents()
	for(var/i in 1 to 4)
		new/obj/item/reagent_containers/food/snacks/bubblegum/wake_up(src)

/obj/item/reagent_containers/food/snacks/spacers_sidekick
	name = "\improper Spacer's Sidekick mints"
	desc = "Spacer's Sidekick: Breathe easy with a friend at your side!"
	icon_state = "spacers_sidekick"
	trash = /obj/item/trash/spacers_sidekick
	list_reagents = list(
		/datum/reagent/consumable/sugar = 1,
		/datum/reagent/consumable/menthol = 1,
		/datum/reagent/medicine/salbutamol = 1,
	)
	tastes = list("strong mint" = 1)
	junkiness = 15
	foodtype = JUNKFOOD
	w_class = WEIGHT_CLASS_SMALL
