// Eating stuff
///From datum/component/edible/proc/TakeBite: (mob/living/eater, mob/feeder, bitecount, bitesize)
#define COMSIG_FOOD_EATEN "food_eaten"
///From base of datum/component/edible/on_entered: (mob/crosser, bitecount)
#define COMSIG_FOOD_CROSSED "food_crossed"
/// From base of Component/edible/On_Consume: (mob/living/eater, mob/living/feeder)
#define COMSIG_FOOD_CONSUMED "food_consumed"
///Called when an atom with /datum/component/customizable_reagent_holder is customized (obj/item/I)
#define COMSIG_ATOM_CUSTOMIZED "atom_customized"
///Called when an item is used as an ingredient: (atom/customized)
#define COMSIG_ITEM_USED_AS_INGREDIENT "item_used_as_ingredient"
///Called when an edible ingredient is added: (datum/component/edible/ingredient)
#define COMSIG_FOOD_INGREDIENT_ADDED "edible_ingredient_added"

// Deep frying foods
///An item becomes fried - From /datum/element/fried_item/Attach: (fry_time)
#define COMSIG_ITEM_FRIED "item_fried"
	#define COMSIG_FRYING_HANDLED (1<<0)

// Microwaving foods
///Called on item when microwaved (): (obj/machinery/microwave/M)
#define COMSIG_ITEM_MICROWAVE_ACT "microwave_act"
	#define COMPONENT_SUCCESFUL_MICROWAVE (1<<0)
///Called on item when created through microwaving (): (obj/machinery/microwave/M, cooking_efficiency)
#define COMSIG_ITEM_MICROWAVE_COOKED "microwave_cooked"

///From /datum/component/edible/on_compost(source, /mob/living/user)
#define COMSIG_EDIBLE_ON_COMPOST "on_compost"
	///Used to stop food from being composted.
	#define COMPONENT_EDIBLE_BLOCK_COMPOST 1

// Grilling foods (griddle, grill, and bonfire)
///Called when an object is placed onto a griddle
#define COMSIG_ITEM_GRILL_PLACED "item_placed_on_griddle"
///Called when an object is grilled ontop of a griddle
#define COMSIG_ITEM_GRILL_PROCESS "item_griddled"
	///Return to not burn the item
	#define COMPONENT_HANDLED_GRILLING (1<<0)
///Called when an object is turned into another item through grilling ontop of a griddle
#define COMSIG_ITEM_GRILLED "item_grill_completed"

#define COMSIG_GRILL_COMPLETED "grill_completed"
///Called when an object is meant to be grilled through a grill: (atom/fry_object, grill_time)
#define COMSIG_GRILL_FOOD "item_grill_food"

// Baking foods (oven)
//Called when an object is in an oven
#define COMSIG_ITEM_BAKED "item_baked"
	#define COMPONENT_HANDLED_BAKING (1<<0)
	#define COMPONENT_BAKING_GOOD_RESULT (1<<1)
	#define COMPONENT_BAKING_BAD_RESULT (1<<2)
///Called when an object is turned into another item through baking in an oven
#define COMSIG_BAKE_COMPLETED "item_bake_completed"
