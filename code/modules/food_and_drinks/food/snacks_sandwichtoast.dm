/obj/item/reagent_containers/food/snacks/sandwich
	name = "sandwich"
	desc = "A sandwich consisting of meat, cheese, and lettuce of the creator's choice."
	icon = 'icons/obj/food/burgerbread.dmi'
	icon_state = "sandwich"
	trash = /obj/item/trash/plate
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 7, /datum/reagent/consumable/nutriment/vitamin = 1)
	cooked_type = /obj/item/reagent_containers/food/snacks/toastedsandwich
	tastes = list("meat" = 2, "cheese" = 1, "bread" = 2, "lettuce" = 1)
	foodtype = GRAIN | VEGETABLES
	/*food_flags = FOOD_FINGER_FOOD*/
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/toastedsandwich
	name = "toasted sandwich"
	desc = "A toasted sandwich consisting of meat, cheese, and lettuce."
	icon = 'icons/obj/food/burgerbread.dmi'
	icon_state = "toastedsandwich"
	trash = /obj/item/trash/plate
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/carbon = 2)
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/carbon = 2)
	tastes = list("toast" = 1)
	foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/grilledcheese
	name = "cheese sandwich"
	desc = "A sandwich consisting of cheddar or solarian emulsified cheese between two slices of bread. Commonly grilled in a pan."
	icon = 'icons/obj/food/burgerbread.dmi'
	icon_state = "toastedsandwich"
	trash = /obj/item/trash/plate
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/nutriment/vitamin = 1)
	tastes = list("toast" = 1, "cheese" = 1)
	foodtype = GRAIN | DAIRY
	/*food_flags = FOOD_FINGER_FOOD*/
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/jellysandwich
	name = "jelly sandwich"
	desc = "A sandwich consisting of primarily spread jelly or jam."
	icon = 'icons/obj/food/burgerbread.dmi'
	icon_state = "jellysandwich"
	trash = /obj/item/trash/plate
	bitesize = 3
	tastes = list("bread" = 1, "jelly" = 1)
	foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/jellysandwich/slime
	bonus_reagents = list(/datum/reagent/toxin/slimejelly = 5, /datum/reagent/consumable/nutriment/vitamin = 2)
	list_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/toxin/slimejelly = 5, /datum/reagent/consumable/nutriment/vitamin = 2)
	foodtype  = GRAIN | TOXIC

/obj/item/reagent_containers/food/snacks/jellysandwich/cherry
	bonus_reagents = list(/datum/reagent/consumable/cherryjelly = 5, /datum/reagent/consumable/nutriment/vitamin = 2)
	list_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/cherryjelly = 5, /datum/reagent/consumable/nutriment/vitamin = 2)
	foodtype = GRAIN | FRUIT | SUGAR

/obj/item/reagent_containers/food/snacks/jelliedtoast
	name = "jellied toast"
	desc = "A slice of toast coated with fruit jelly."
	icon = 'icons/obj/food/burgerbread.dmi'
	icon_state = "jellytoast"
	trash = /obj/item/trash/plate
	bitesize = 3
	tastes = list("toast" = 1, "jelly" = 1)
	foodtype = GRAIN | BREAKFAST

/obj/item/reagent_containers/food/snacks/jelliedtoast/cherry
	bonus_reagents = list(/datum/reagent/consumable/cherryjelly = 5, /datum/reagent/consumable/nutriment/vitamin = 2)
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/cherryjelly = 5, /datum/reagent/consumable/nutriment/vitamin = 2)
	foodtype = GRAIN | FRUIT | SUGAR | BREAKFAST

/obj/item/reagent_containers/food/snacks/jelliedtoast/slime
	bonus_reagents = list(/datum/reagent/toxin/slimejelly = 5, /datum/reagent/consumable/nutriment/vitamin = 2)
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/toxin/slimejelly = 5, /datum/reagent/consumable/nutriment/vitamin = 2)
	foodtype = GRAIN | TOXIC | SUGAR | BREAKFAST

/obj/item/reagent_containers/food/snacks/butteredtoast
	name = "buttered toast"
	desc = "Butter lightly spread over a piece of toast."
	icon = 'icons/obj/food/food.dmi'
	icon_state = "butteredtoast"
	bitesize = 3
	filling_color = "#FFA500"
	list_reagents = list(/datum/reagent/consumable/nutriment = 4)
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 1)
	tastes = list("butter" = 1, "toast" = 1)
	foodtype = GRAIN | BREAKFAST

/obj/item/reagent_containers/food/snacks/twobread
	name = "two bread"
	desc = "Two pieces of bread loosely placed atop of each other. You're not sure why this is considered a separate meal."
	icon = 'icons/obj/food/burgerbread.dmi'
	icon_state = "twobread"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 2)
	list_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/nutriment/vitamin = 2)
	tastes = list("bread" = 2)
	foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/blt
	name = "BLT"
	desc = "A bacon, lettuce, and tomato sandwich. Usually served with mayo, this sandwich is a staple."
	icon = 'icons/obj/food/burgerbread.dmi'
	icon_state = "blt"
	bitesize = 4
	list_reagents = list(/datum/reagent/consumable/nutriment = 7, /datum/reagent/consumable/nutriment/vitamin = 3)
	tastes = list("meat" = 1, "cabbage" = 1, "bread" = 2)
	foodtype = MEAT | VEGETABLES | GRAIN | BREAKFAST
