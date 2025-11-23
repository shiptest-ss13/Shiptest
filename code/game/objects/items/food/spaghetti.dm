
/obj/item/food/spaghetti
	icon = 'icons/obj/food/spaghetti.dmi'
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	foodtypes = GRAIN

/obj/item/food/spaghetti/raw
	name = "spaghetti"
	desc = "Dried noodles, ready to be boiled."
	icon_state = "spaghetti"
	tastes = list("pasta" = 1)

/obj/item/food/spaghetti/raw/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/spaghetti/boiledspaghetti, rand(15 SECONDS, 20 SECONDS), TRUE, TRUE)

/obj/item/food/spaghetti/boiledspaghetti
	name = "boiled spaghetti"
	desc = "A plain dish of noodles, this needs more ingredients."
	icon_state = "spaghettiboiled"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)

/obj/item/food/spaghetti/boiledspaghetti/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/customizable_reagent_holder, null, CUSTOM_INGREDIENT_ICON_SCATTER, max_ingredients = 6)

/obj/item/food/spaghetti/pastatomato
	name = "spaghetti"
	desc = "Spaghetti and crushed tomatoes, almost as tangled as Miskilamo's wiring!"
	icon_state = "pastatomato"
	bite_consumption = 4
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/tomatojuice = 10,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("pasta" = 1, "tomato" = 1)
	foodtypes = GRAIN | FRUIT

/obj/item/food/spaghetti/meatballspaghetti
	name = "spaghetti and meatballs"
	desc = "A dish of boiled noodles with hearty meatballs."
	icon_state = "meatballspaghetti"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("pasta" = 1, "meat" = 1)
	foodtypes = GRAIN | MEAT

/obj/item/food/spaghetti/chowmein
	name = "chow mein"
	desc = "A nice mix of noodles and fried vegetables."
	icon_state = "chowmein"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("noodle" = 1, "tomato" = 1)

/obj/item/food/spaghetti/beefnoodle
	name = "beef noodle"
	desc = "Nutritious, beefy and noodly."
	icon_state = "beefnoodle"
	trash_type = /obj/item/reagent_containers/glass/bowl
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/liquidgibs = 3,
	)
	tastes = list("noodle" = 1, "meat" = 1)
	foodtypes = GRAIN | MEAT

/obj/item/food/spaghetti/butternoodles
	name = "butter noodles"
	desc = "Noodles covered in savory butter. Simple and slippery, but delicious."
	icon_state = "butternoodles"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 9,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("noodle" = 1, "butter" = 1)
	foodtypes = GRAIN | DAIRY
