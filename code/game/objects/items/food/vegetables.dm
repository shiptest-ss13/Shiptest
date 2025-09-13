/obj/item/food/eggplantparm
	name = "eggplant parmigiana"
	desc = "Sliced and breaded eggplant, baked in cheese and marinara sauce."
	icon_state = "eggplantparm"

	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("eggplant" = 3, "cheese" = 1)
	foodtypes = VEGETABLES | DAIRY
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/yakiimo
	name = "yaki imo"
	desc = "A popular winter street food, this is a whole roasted sweet potato."
	icon_state = "yakiimo"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("sweet potato" = 1)
	foodtypes = VEGETABLES | SUGAR
	w_class = WEIGHT_CLASS_SMALL
	//burns_in_oven = TRUE

/obj/item/food/roastparsnip
	name = "roast parsnip"
	desc = "An entire roasted parsnip."
	icon_state = "roastparsnip"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("parsnip" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

// Potatoes
/obj/item/food/loaded_baked_potato
	name = "loaded baked potato"
	desc = "A potato that's been cut and spread down the middle, then filled with toppings and baked."
	icon_state = "loadedbakedpotato"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/nutriment/protein = 4,
	)
	tastes = list("baked potato" = 1, "bacon" = 1, "cheese" = 1, "cabbage" = 1)
	foodtypes = VEGETABLES | DAIRY | MEAT
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/loaded_miras_potato
	name = "loaded miras potato"
	desc = "A Lanchester classic, Miras is baked over a potato, and then topped with Luna-Town cheese and sour cream."
	icon_state = "miras-potato"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/nutriment/protein = 4,
	)
	tastes = list("potato" = 2, "sweet meat" = 1, "cheese" = 1, "sour cream" = 1)
	foodtypes = MEAT | SUGAR | VEGETABLES | DAIRY

// Fries
/obj/item/food/fries
	name = "space fries"
	desc = "A form of fried potato sticks. While there are many shapes and seasonings available, the original is considered straight, thinly cut, and salted."
	icon_state = "fries"
	food_reagents = list(/datum/reagent/consumable/nutriment = 4)
	tastes = list("fries" = 3, "salt" = 1)
	foodtypes = VEGETABLES | FRIED
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/fries/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/dunkable, 10)

/obj/item/food/cheesyfries
	name = "cheesy fries"
	desc = "Fried potato sicks smothered in cheese."
	icon_state = "cheesyfries"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("fries" = 3, "cheese" = 1)
	foodtypes = VEGETABLES | DAIRY
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/cheesyfries/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/dunkable, 10)

/obj/item/food/carrotfries
	name = "carrot fries"
	desc = "Thinly sliced sticks of carrots, salted and fried."
	icon_state = "carrotfries"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/medicine/oculine = 3,
		/datum/reagent/consumable/nutriment/vitamin = 2
	)
	tastes = list("carrots" = 3, "salt" = 1)
	foodtypes = VEGETABLES
	food_flags = FOOD_FINGER_FOOD

/obj/item/food/carrotfries/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/dunkable, 10)
