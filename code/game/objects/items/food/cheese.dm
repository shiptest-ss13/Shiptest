/obj/item/food/cheese
	name = "the concept of cheese"
	desc = "This probably shouldn't exist."
	tastes = list("cheese" = 1)
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 3)
	foodtypes = DAIRY

/obj/item/food/cheese/wheel
	name = "cheese wheel"
	desc = "A wheel of yellow cheese, typically cut into wedges and slices."
	icon_state = "cheesewheel"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	) //Hard cheeses contain about 25% protein
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/food/cheese/wedge
	name = "cheese wedge"
	desc = "A wedge of cheese, originating from a wheel. You wonder where the original wheel is."
	icon_state = "cheesewedge"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 1,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/cheese/wheel/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/food_storage)

/obj/item/food/cheese/wheel/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/cheese/wedge, 5, 3 SECONDS, table_required = TRUE, /*screentip_verb = "Slice"*/)
