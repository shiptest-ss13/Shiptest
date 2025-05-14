//this category is very little but I think that it has great potential to grow
////////////////////////////////////////////SALAD////////////////////////////////////////////
/obj/item/reagent_containers/food/snacks/salad
	icon = 'icons/obj/food/soupsalad.dmi'
	trash = /obj/item/reagent_containers/glass/bowl
	bitesize = 3
	w_class = WEIGHT_CLASS_NORMAL
	list_reagents = list(/datum/reagent/consumable/nutriment = 7, /datum/reagent/consumable/nutriment/vitamin = 2)
	tastes = list("leaves" = 1)
	foodtype = VEGETABLES

/obj/item/reagent_containers/food/snacks/salad/Initialize()
	. = ..()
	eatverb = pick("devour","nibble","gnaw","gobble","chomp") //who the fuck gnaws and devours on a salad

/obj/item/reagent_containers/food/snacks/salad/aesirsalad
	name = "\improper Aesir salad"
	desc = "A salad consisting of the botanical experiment known as ambrosia vulgaris. Primarily made for its medicinal use, though it's rather bitter."
	icon_state = "aesirsalad"
	bonus_reagents = list(/datum/reagent/medicine/omnizine = 2, /datum/reagent/consumable/nutriment/vitamin = 6)
	list_reagents = list(/datum/reagent/consumable/nutriment = 8, /datum/reagent/medicine/omnizine = 8, /datum/reagent/consumable/nutriment/vitamin = 6)
	tastes = list("bitter leaves" = 1)
	foodtype = VEGETABLES | FRUIT

/obj/item/reagent_containers/food/snacks/salad/herbsalad
	name = "herb salad"
	desc = "A tossed salad with apple slices atop it."
	icon_state = "herbsalad"
	bonus_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 4)
	list_reagents = list(/datum/reagent/consumable/nutriment = 8, /datum/reagent/consumable/nutriment/vitamin = 2)
	tastes = list("leaves" = 1, "apple" = 1)
	foodtype = VEGETABLES | FRUIT

/obj/item/reagent_containers/food/snacks/salad/validsalad
	name = "full salad"
	desc = "A salad consisting of a traditional caesar salad, with the inclusion of meatballs and fried potato chunks."
	icon_state = "validsalad"
	bonus_reagents = list(/datum/reagent/consumable/doctor_delight = 5, /datum/reagent/consumable/nutriment/vitamin = 4)
	list_reagents = list(/datum/reagent/consumable/nutriment = 8, /datum/reagent/consumable/doctor_delight = 5, /datum/reagent/consumable/nutriment/vitamin = 2)
	tastes = list("lettuce" = 1, "potato" = 1, "meat" = 1, "croutons" = 1)
	foodtype = VEGETABLES | MEAT | FRIED | JUNKFOOD | FRUIT

/obj/item/reagent_containers/food/snacks/salad/oatmeal
	name = "oatmeal"
	desc = "A bowl of sweetened oatmeal."
	icon_state = "oatmeal"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/nutriment/vitamin = 4)
	list_reagents = list(/datum/reagent/consumable/nutriment = 7, /datum/reagent/consumable/milk = 10, /datum/reagent/consumable/nutriment/vitamin = 2)
	tastes = list("oats" = 1, "milk" = 1)
	foodtype = DAIRY | GRAIN | BREAKFAST

/obj/item/reagent_containers/food/snacks/salad/fruit
	name = "fruit salad"
	desc = "A bowl of tossed fruits without their peels and skins."
	icon_state = "fruitsalad"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/nutriment/vitamin = 4)
	tastes = list("fruit" = 1)
	foodtype = FRUIT

/obj/item/reagent_containers/food/snacks/salad/jungle
	name = "jungle salad"
	desc = "A tropical-focused fruit salad, noticeably sweet and tart."
	icon_state = "junglesalad"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/nutriment/vitamin = 4)
	list_reagents = list(/datum/reagent/consumable/nutriment = 7, /datum/reagent/consumable/banana = 5, /datum/reagent/consumable/nutriment/vitamin = 4)
	tastes = list("fruit" = 1, "tropical earth fruits" = 1)
	foodtype = FRUIT

/obj/item/reagent_containers/food/snacks/salad/citrusdelight
	name = "citrus delight"
	desc = "A bowl full of various slices of citrus, resulting in an incredibly tart fruit salad."
	icon_state = "citrusdelight"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/nutriment/vitamin = 4)
	list_reagents = list(/datum/reagent/consumable/nutriment = 7, /datum/reagent/consumable/nutriment/vitamin = 5)
	tastes = list("sourness" = 1, "tartness" = 1)
	foodtype = FRUIT

/obj/item/reagent_containers/food/snacks/salad/ricebowl
	name = "ricebowl"
	desc = "A bowl of loose, pearled rice grains."
	icon_state = "ricebowl"
	cooked_type = /obj/item/reagent_containers/food/snacks/salad/boiledrice
	list_reagents = list(/datum/reagent/consumable/nutriment = 4)
	tastes = list("rice" = 1)
	foodtype = GRAIN | RAW

/obj/item/reagent_containers/food/snacks/salad/boiledrice
	name = "boiled rice"
	desc = "A warm bowl of steamed white rice."
	icon_state = "boiledrice"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/consumable/nutriment/vitamin = 1)
	tastes = list("rice" = 1)
	foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/salad/ricepudding
	name = "rice pudding"
	desc = "A bowl of rice mixed with milk into a thick pudding, usually mixed  with nuts and spices."
	icon_state = "ricepudding"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/nutriment/vitamin = 2)
	tastes = list("rice" = 1, "sweetness" = 1)
	foodtype = GRAIN | DAIRY

/obj/item/reagent_containers/food/snacks/salad/ricepork
	name = "rice and pork"
	desc = "A bowl of steamed rice and pieces of fried pork."
	icon_state = "riceporkbowl"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/nutriment/vitamin = 4)
	tastes = list("rice" = 1, "fried pork" = 1)
	foodtype = GRAIN | MEAT

/obj/item/reagent_containers/food/snacks/salad/eggbowl
	name = "egg bowl"
	desc = "A bowl of steamed rice, topped with a fried egg."
	icon_state = "eggbowl"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/nutriment/vitamin = 4)
	tastes = list("rice" = 1, "egg" = 1)
	foodtype = GRAIN | MEAT

/obj/item/reagent_containers/food/snacks/salad/edensalad
	name = "\improper Salad of Eden"
	desc = "A salad consisting of an experimentally modified cousin of ambrosia vulgaris."
	icon_state = "eden_salad"
	trash = /obj/item/reagent_containers/glass/bowl
	list_reagents = list(/datum/reagent/consumable/nutriment = 7, /datum/reagent/consumable/nutriment/vitamin = 5, /datum/reagent/medicine/earthsblood = 3, /datum/reagent/medicine/omnizine = 5, /datum/reagent/drug/happiness = 2)
	tastes = list("hope" = 1)
	foodtype = VEGETABLES

/obj/item/reagent_containers/food/snacks/salad/gumbo
	name = "black eyed gumbo"
	desc = "A specific form of stew consisting of a strongly flavored, thickened stock along with a celery, bell peppers, and onions. While gumbo also includes some specific inclusions for tradition, this one seems to lack both."
	icon_state = "gumbo"
	trash = /obj/item/reagent_containers/glass/bowl
	list_reagents = list(/datum/reagent/consumable/capsaicin = 2, /datum/reagent/consumable/nutriment/vitamin = 3, /datum/reagent/consumable/nutriment = 5)
	tastes = list("savory meat and vegtables" = 1)
	foodtype = GRAIN | MEAT | VEGETABLES
