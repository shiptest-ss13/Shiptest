
/obj/item/food/spaghetti
	icon = 'icons/obj/food/spaghetti.dmi'
	food_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 1)
	foodtypes = GRAIN

/obj/item/food/spaghetti/Initialize()
	. = ..()
	if(!microwaved_type) // This isn't cooked, why would you put uncooked spaghetti in your pocket?
		var/list/display_message = list(
			span_notice("Something wet falls out of their pocket and hits the ground. Is that... [name]?"),
			span_warning("Oh shit! All your pocket [name] fell out!"))
		AddComponent(/datum/component/spill, display_message, 'sound/effects/splat.ogg')

/obj/item/food/spaghetti/raw
	name = "spaghetti"
	desc = "Dried noodles, ready to be boiled."
	icon_state = "spaghetti"
	tastes = list("pasta" = 1)
	microwaved_type = /obj/item/food/spaghetti/boiledspaghetti

/obj/item/food/spaghetti/boiledspaghetti
	name = "boiled spaghetti"
	desc = "A plain dish of noodles, this needs more ingredients."
	icon_state = "spaghettiboiled"
	trash_type = /obj/item/trash/plate
	food_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/nutriment/vitamin = 1)
	microwaved_type = null

/obj/item/food/spaghetti/pastatomato
	name = "spaghetti"
	desc = "Spaghetti and crushed tomatoes, almost as tangled as Miskilamo's wiring!"
	icon_state = "pastatomato"
	trash_type = /obj/item/trash/plate
	bite_consumption = 4
	food_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/tomatojuice = 10, /datum/reagent/consumable/nutriment/vitamin = 4)
	microwaved_type = null
	tastes = list("pasta" = 1, "tomato" = 1)
	foodtypes = GRAIN | FRUIT

/obj/item/food/spaghetti/meatballspaghetti
	name = "spaghetti and meatballs"
	desc = "A dish of boiled noodles with hearty meatballs."
	icon_state = "meatballspaghetti"
	trash_type = /obj/item/trash/plate
	food_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/nutriment/vitamin = 2)
	microwaved_type = null
	tastes = list("pasta" = 1, "meat" = 1)
	foodtypes = GRAIN | MEAT

/obj/item/food/spaghetti/chowmein
	name = "chow mein"
	desc = "A nice mix of noodles and fried vegetables."
	icon_state = "chowmein"
	trash_type = /obj/item/trash/plate
	food_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/nutriment/vitamin = 6)
	microwaved_type = null
	tastes = list("noodle" = 1, "tomato" = 1)

/obj/item/food/spaghetti/beefnoodle
	name = "beef noodle"
	desc = "Nutritious, beefy and noodly."
	icon_state = "beefnoodle"
	trash_type = /obj/item/reagent_containers/glass/bowl
	food_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/nutriment/vitamin = 6, /datum/reagent/liquidgibs = 3)
	microwaved_type = null
	tastes = list("noodle" = 1, "meat" = 1)
	foodtypes = GRAIN | MEAT

/obj/item/food/spaghetti/butternoodles
	name = "butter noodles"
	desc = "Noodles covered in savory butter. Simple and slippery, but delicious."
	icon_state = "butternoodles"
	trash_type = /obj/item/trash/plate
	food_reagents = list(/datum/reagent/consumable/nutriment = 9, /datum/reagent/consumable/nutriment/vitamin = 2)
	microwaved_type = null
	tastes = list("noodle" = 1, "butter" = 1)
	foodtypes = GRAIN | DAIRY
