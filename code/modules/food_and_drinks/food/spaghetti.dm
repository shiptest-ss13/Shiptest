
/obj/item/reagent_containers/food/snacks/spaghetti
	name = "spaghetti"
	desc = "Now that's a nic'e pasta!"
	icon = 'icons/obj/food/spaghetti.dmi'
	icon_state = "spaghetti"
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 1)
	cooked_type = /obj/item/reagent_containers/food/snacks/spaghetti/boiledspaghetti
	filling_color = "#F0E68C"
	tastes = list("pasta" = 1)
	foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/spaghetti/Initialize()
	. = ..()
	if(!cooked_type) // This isn't cooked, why would you put uncooked spaghetti in your pocket?
		var/list/display_message = list(
			"<span class='notice'>Something wet falls out of their pocket and hits the ground. Is that... [name]?</span>",
			"<span class='warning'>Oh shit! All your pocket [name] fell out!</span>")
		AddComponent(/datum/component/spill, display_message, 'sound/effects/splat.ogg')

/obj/item/reagent_containers/food/snacks/spaghetti/boiledspaghetti
	name = "boiled spaghetti"
	desc = "A plain dish of noodles, this needs more ingredients."
	icon_state = "spaghettiboiled"
	trash = /obj/item/trash/plate
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 2)
	list_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/nutriment/vitamin = 1)
	cooked_type = null
	custom_food_type = /obj/item/reagent_containers/food/snacks/customizable/pasta

/obj/item/reagent_containers/food/snacks/spaghetti/pastatomato
	name = "spaghetti"
	desc = "Spaghetti and crushed tomatoes. Just like your abusive father used to make!"
	icon_state = "pastatomato"
	trash = /obj/item/trash/plate
	bitesize = 4
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/tomatojuice = 10, /datum/reagent/consumable/nutriment/vitamin = 4)
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/tomatojuice = 10, /datum/reagent/consumable/nutriment/vitamin = 4)
	cooked_type = null
	filling_color = "#DC143C"
	tastes = list("pasta" = 1, "tomato" = 1)
	foodtype = GRAIN | VEGETABLES

/obj/item/reagent_containers/food/snacks/spaghetti/copypasta
	name = "copypasta"
	desc = "You probably shouldn't try this, you always hear people talking about how bad it is..."
	icon_state = "copypasta"
	trash = /obj/item/trash/plate
	bitesize = 4
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 4)
	list_reagents = list(/datum/reagent/consumable/nutriment = 12, /datum/reagent/consumable/tomatojuice = 20, /datum/reagent/consumable/nutriment/vitamin = 8)
	cooked_type = null
	filling_color = "#DC143C"
	tastes = list("pasta" = 1, "tomato" = 1)
	foodtype = GRAIN | VEGETABLES

/obj/item/reagent_containers/food/snacks/spaghetti/meatballspaghetti
	name = "spaghetti and meatballs"
	desc = "Now that's a nic'e meatball!"
	icon_state = "meatballspaghetti"
	trash = /obj/item/trash/plate
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 4)
	list_reagents = list(/datum/reagent/consumable/nutriment = 8, /datum/reagent/consumable/nutriment/vitamin = 4)
	cooked_type = null
	tastes = list("pasta" = 1, "tomato" = 1, "meat" = 1)
	foodtype = GRAIN | MEAT

/obj/item/reagent_containers/food/snacks/spaghetti/spesslaw
	name = "spesslaw"
	desc = "A lawyers favourite."
	icon_state = "spesslaw"
	trash = /obj/item/trash/plate
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 6)
	list_reagents = list(/datum/reagent/consumable/nutriment = 8, /datum/reagent/consumable/nutriment/vitamin = 6)
	cooked_type = null
	tastes = list("pasta" = 1, "tomato" = 1, "meat" = 1)

/obj/item/reagent_containers/food/snacks/spaghetti/chowmein
	name = "chow mein"
	desc = "A nice mix of noodles and fried vegetables."
	icon_state = "chowmein"
	trash = /obj/item/trash/plate
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/vitamin = 4)
	list_reagents = list(/datum/reagent/consumable/nutriment = 7, /datum/reagent/consumable/nutriment/vitamin = 6)
	cooked_type = null
	tastes = list("noodle" = 1, "tomato" = 1)

/obj/item/reagent_containers/food/snacks/spaghetti/beefnoodle
	name = "beef noodle"
	desc = "Nutritious, beefy and noodly."
	icon_state = "beefnoodle"
	trash = /obj/item/reagent_containers/glass/bowl
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/consumable/nutriment/vitamin = 6, /datum/reagent/liquidgibs = 3)
	cooked_type = null
	tastes = list("noodle" = 1, "meat" = 1)
	foodtype = GRAIN | MEAT

/obj/item/reagent_containers/food/snacks/spaghetti/butternoodles
	name = "butter noodles"
	desc = "Noodles covered in savory butter. Simple and slippery, but delicious."
	icon_state = "butternoodles"
	trash = /obj/item/trash/plate
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 8, /datum/reagent/consumable/nutriment/vitamin = 1)
	cooked_type = null
	tastes = list("noodle" = 1, "butter" = 1)
	foodtype = GRAIN | DAIRY

/obj/item/reagent_containers/food/snacks/spaghetti/mac_n_cheese
	name = "mac n' cheese"
	desc = "Made the proper way with only the finest cheese and breadcrumbs. And yet, it can't scratch the same itch as Ready-Donk."
	icon_state = "mac_n_cheese"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 9, /datum/reagent/consumable/nutriment/vitamin = 2)
	tastes = list("cheese" = 1, "breadcrumbs" = 1, "pasta" = 1)
	foodtype = GRAIN | DAIRY

/obj/item/reagent_containers/food/snacks/spaghetti/nizaya
	name = "rustic pasta"
	desc = "A form of root and nut pasta originally native to the oceanside regions of Kalixcis. It's similar in texture and appearance to gnocchi."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "nizaya"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("gnocchi" = 1)
	foodtype = VEGETABLES | NUTS

/obj/item/reagent_containers/food/snacks/spaghetti/snail_nizaya
	name = "desert snail rustic pasta"
	desc = "A high class pasta dish adopted by Solarian chefs based on Kalixcian pasta traditions. Traditionally made with only the finest Solarian wine… but box will do, in a pinch."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "snail_nizaya"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/cooking_oil = 4,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("snails" = 1, "wine" = 1, "gnocchi" = 1)
	foodtype = VEGETABLES | MEAT | NUTS

/obj/item/reagent_containers/food/snacks/spaghetti/garlic_nizaya
	name = "garlic-and-oil nizaya"
	desc = "A lizard adaptation of the Italian pasta dish, aglio e olio, made with nizaya pasta."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "garlic_nizaya"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/vitamin = 10,
	)
	tastes = list("garlic" = 1, "oil" = 1, "gnocchi" = 1)
	foodtype = VEGETABLES | NUTS

/obj/item/reagent_containers/food/snacks/spaghetti/demit_nizaya
	name = "demit nizaya"
	desc = "A sweet, creamy nizaya pasta dish made with korta milk and nectar."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "demit_nizaya"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/korta_nectar = 4,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("peppery sweet" = 1, "veggies" = 1, "gnocchi" = 1)
	foodtype = VEGETABLES | SUGAR | NUTS

/obj/item/reagent_containers/food/snacks/spaghetti/mushroom_nizaya
	name = "mushroom nizaya"
	desc = "A nizaya pasta dish made with seraka mushrooms and quality oil. Has a pronounced nutty flavour."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "mushroom_nizaya"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/vitamin = 10,
	)
	tastes = list("savouriness" = 1, "nuttiness" = 1, "gnocchi" = 1)
	foodtype = VEGETABLES
