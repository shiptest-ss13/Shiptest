/obj/item/food/ration/condiment
	name = "condiment pack"
	desc = "Just your average condiment pack."
	icon_state = "ration_condi"
	max_volume = 10
	amount_per_transfer = 10

/obj/item/food/ration/condiment/attack(mob/living/M, mob/user, def_zone)
	if(!is_drainable())
		to_chat(user, span_warning("[src] is sealed shut!"))
		return 0
	else
		to_chat(user, span_warning("[src] cant be eaten like that!"))
		return 0

/obj/item/food/ration/condiment/afterattack(obj/target, mob/user , proximity)
	. = ..()
	if(!is_drainable())
		to_chat(user, span_warning("[src] is sealed shut!"))
		return

	if(!proximity)
		return
	//You can tear the bag open above food to put the condiments on it, obviously.
	if(IS_EDIBLE(target))
		if(target.reagents.total_volume >= target.reagents.maximum_volume)
			to_chat(user, span_warning("[target] is too full!") )
			return
		else
			to_chat(user, span_notice("You tear open [src] above [target] and the condiments drip onto it."))
			src.reagents.trans_to(target, amount_per_transfer, transfered_by = user)
			qdel(src)

/obj/item/food/ration/condiment/cheese_spread
	name = "cheese spread pack"
	filling_color = "#ffcc00"
	food_reagents = list(/datum/reagent/consumable/cheese_spread = 8)

/obj/item/food/ration/condiment/hot_cheese_spread
	name = "jalapeno cheddar cheese spread pack"
	filling_color = "#ffaa00"
	food_reagents = list(/datum/reagent/consumable/cheese_spread = 5 , /datum/reagent/consumable/capsaicin = 3)

/obj/item/food/ration/condiment/garlic_cheese_spread
	name = "garlic parmesan cheese spread pack"
	filling_color = "#ffff00"
	food_reagents = list(/datum/reagent/consumable/cheese_spread = 8)

/obj/item/food/ration/condiment/bacon_cheddar_cheese_spread
	name = "bacon cheddar cheese spread pack"
	filling_color = "#ff9900"
	food_reagents = list(/datum/reagent/consumable/cheese_spread = 8)

/obj/item/food/ration/condiment/peanut_butter
	name = "peanut butter pack"
	filling_color = "#664400"
	food_reagents = list(/datum/reagent/consumable/sugar = 5, /datum/reagent/consumable/peanut_butter = 5)

/obj/item/food/ration/condiment/chunky_peanut_butter
	name = "chunky peanut butter pack"
	filling_color = "#663300"
	food_reagents = list(/datum/reagent/consumable/peanut_butter = 10)

/obj/item/food/ration/condiment/maple_syrup
	name = "maple syrup pack"
	filling_color = "#661100"
	food_reagents = list(/datum/reagent/consumable/sugar = 10)

/obj/item/food/ration/pack/chocolate_protein_beverage
	name = "chocolate hazelnut protein drink powder pack"
	filling_color = "#664400"
	food_reagents = list(/datum/reagent/consumable/coco = 5, /datum/reagent/consumable/eggyolk = 5)

/obj/item/food/ration/pack/fruit_beverage
	name = "fruit punch beverage powder, carb-electrolyte pack"
	filling_color = "#ff4400"
	food_reagents = list(/datum/reagent/consumable/sugar = 5, /datum/reagent/consumable/applejuice = 2, /datum/reagent/consumable/orangejuice = 2)

/obj/item/food/ration/pack/fruit_smoothie_beverage
	name = "tropical blend fruit and vegetable smoothie powder pack"
	filling_color = "#ffaa00"
	food_reagents = list(/datum/reagent/consumable/pineapplejuice = 3, /datum/reagent/consumable/orangejuice = 3, /datum/reagent/consumable/eggyolk = 3)

/obj/item/food/ration/pack/grape_beverage
	name = "grape beverage powder, carb-fortified pack"
	filling_color = "#9900ff"
	food_reagents = list(/datum/reagent/consumable/sugar = 5, /datum/reagent/consumable/grapejuice = 5)

/obj/item/food/ration/pack/grape_beverage_sugar_free
	name = "sugar-free grape beverage base powder"
	filling_color = "#9900ff"
	food_reagents = list(/datum/reagent/consumable/grapejuice = 10)

/obj/item/food/ration/pack/lemonade_beverage
	name = "lemonade drink powder pack"
	filling_color = "#ffff80"
	food_reagents = list(/datum/reagent/consumable/sugar = 5, /datum/reagent/consumable/lemonjuice = 5)

/obj/item/food/ration/pack/lemonade_beverage_suger_free
	name = "lemonade sugar-free beverage base pack"
	filling_color = "#ffff00"
	food_reagents = list(/datum/reagent/consumable/lemonjuice = 10)

/obj/item/food/ration/pack/orange_beverage
	name = "orange beverage powder, carb-fortified pack"
	filling_color = "#ffbb00"
	food_reagents = list(/datum/reagent/consumable/sugar = 5, /datum/reagent/consumable/orangejuice = 5)

/obj/item/food/ration/pack/orange_beverage_sugar_free
	name = "orange beverage base, sugar-free pack"
	filling_color = "#ff9900"
	food_reagents = list(/datum/reagent/consumable/orangejuice = 10)

/obj/item/food/ration/pack/cherry_beverage
	name = "cherry high-energy beverage powder pack"
	filling_color = "#ff5555"
	food_reagents = list(/datum/reagent/consumable/sugar = 5, /datum/reagent/consumable/cherryjelly = 5)

/obj/item/food/ration/pack/pineapple_beverage
	name = "pinapple fruit beverage base pack"
	filling_color = "#fff111"
	food_reagents = list(/datum/reagent/consumable/pineapplejuice = 10)

/obj/item/food/ration/pack/freeze_dried_coffee_orange
	name = "freeze-dried coffee flavored with orange pack"
	filling_color = "#cc7400"
	food_reagents = list(/datum/reagent/consumable/coffee = 5, /datum/reagent/consumable/orangejuice = 3)

/obj/item/food/ration/pack/freeze_dried_coffee_chocolate
	name = "freeze-dried coffee flavored with chocolate pack"
	filling_color = "#803300"
	food_reagents = list(/datum/reagent/consumable/coffee = 5, /datum/reagent/consumable/coco = 3)

/obj/item/food/ration/pack/freeze_dried_coffee_hazelnut
	name = "freeze-dried coffee flavored with hazelnut pack"
	filling_color = "#553300"
	food_reagents = list(/datum/reagent/consumable/coffee = 5, /datum/reagent/consumable/coco = 3)
