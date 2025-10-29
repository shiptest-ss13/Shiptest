//this category is very little but I think that it has great potential to grow
////////////////////////////////////////////SALAD////////////////////////////////////////////
/obj/item/food/salad
	icon = 'icons/obj/food/soupsalad.dmi'
	trash_type = /obj/item/reagent_containers/glass/bowl
	bite_consumption = 3
	w_class = WEIGHT_CLASS_NORMAL
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 7,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("leaves" = 1)
	foodtypes = VEGETABLES
	eatverbs = list("devour","nibble","gnaw","gobble","chomp") //who the fuck gnaws and devours on a salad //me i do

/obj/item/food/salad/aesirsalad
	name = "\improper Aesir salad"
	desc = "A salad consisting of the botanical experiment known as ambrosia vulgaris. Primarily made for its medicinal use, though it's rather bitter."
	icon_state = "aesirsalad"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/medicine/panacea = 10,
		/datum/reagent/consumable/nutriment/vitamin = 12,
	)
	tastes = list("leaves" = 1)
	foodtypes = VEGETABLES | FRUIT

/obj/item/food/salad/herbsalad
	name = "herb salad"
	desc = "A tossed salad with apple slices atop it."
	icon_state = "herbsalad"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("leaves" = 1, "apple" = 1)
	foodtypes = VEGETABLES | FRUIT

/obj/item/food/salad/validsalad
	name = "full salad"
	desc = "A salad consisting of a traditional caesar salad, with the inclusion of meatballs and fried potato chunks."
	icon_state = "validsalad"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/doctor_delight = 8,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("leaves" = 1, "potato" = 1, "meat" = 1, "valids" = 1)
	foodtypes = VEGETABLES | MEAT | FRIED | FRUIT

/obj/item/food/salad/fruit
	name = "fruit salad"
	desc = "A bowl of tossed fruits without their peels and skins."
	icon_state = "fruitsalad"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 9,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("fruit" = 1)
	foodtypes = FRUIT

/obj/item/food/salad/jungle
	name = "jungle salad"
	desc = "A tropical-focused fruit salad, noticeably sweet and tart."
	icon_state = "junglesalad"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 11,
		/datum/reagent/consumable/banana = 5,
		/datum/reagent/consumable/nutriment/vitamin = 7,
	)
	tastes = list("fruit" = 1, "the jungle" = 1)
	foodtypes = FRUIT

/obj/item/food/salad/citrusdelight
	name = "citrus delight"
	desc = "A bowl full of various slices of citrus, resulting in an incredibly tart fruit salad."
	icon_state = "citrusdelight"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 11,
		/datum/reagent/consumable/nutriment/vitamin = 7,
	)
	tastes = list("sourness" = 1, "leaves" = 1)
	foodtypes = FRUIT

/obj/item/food/uncooked_rice
	name = "uncooked rice"
	desc = "A clump of raw rice."
	icon = 'icons/obj/food/soupsalad.dmi'
	icon_state = "ricebowl"
	food_reagents = list(/datum/reagent/consumable/nutriment = 4)
	tastes = list("rice" = 1)
	foodtypes = GRAIN | RAW

/obj/item/food/uncooked_rice/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/boiled_rice, rand(15 SECONDS, 20 SECONDS), TRUE, TRUE)

/obj/item/food/boiled_rice
	name = "boiled rice"
	desc = "A warm bowl of steamed white rice."
	icon = 'icons/obj/food/soupsalad.dmi'
	icon_state = "boiledrice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("rice" = 1)
	foodtypes = GRAIN | BREAKFAST

/obj/item/food/salad/ricepudding
	name = "rice pudding"
	desc = "A bowl of rice mixed with milk into a thick pudding, usually mixed with nuts and spices."
	icon_state = "ricepudding"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/sugar = 3,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("rice" = 1, "sweetness" = 1)
	foodtypes = GRAIN | DAIRY | SUGAR

/obj/item/food/salad/ricepork
	name = "rice and pork"
	desc = "A bowl of steamed rice and pieces of fried pork."
	icon_state = "riceporkbowl"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("rice" = 1, "meat" = 1)
	foodtypes = GRAIN | MEAT

/obj/item/food/salad/eggbowl
	name = "egg bowl"
	desc = "A bowl of steamed rice, topped with a fried egg."
	icon_state = "eggbowl"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("rice" = 1, "egg" = 1)
	foodtypes = GRAIN | MEAT

/obj/item/reagent_containers/glass/bowl
	name = "bowl"
	desc = "A simple bowl, used for soups and salads."
	icon = 'icons/obj/food/soupsalad.dmi'
	icon_state = "bowl"
	reagent_flags = OPENCONTAINER
	custom_materials = list(/datum/material/glass = 500)
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/reagent_containers/glass/bowl/Initialize()
	. = ..()
	AddComponent(/datum/component/customizable_reagent_holder, /obj/item/food/salad/empty, CUSTOM_INGREDIENT_ICON_FILL, max_ingredients = 6)

// empty salad for custom salads
/obj/item/food/salad/empty
	name = "salad"
	desc = "A delicious customized salad."
	icon_state = "bowl"
	foodtypes = NONE
	tastes = list()
