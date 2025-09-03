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

//teceti stuff
/obj/item/food/ration/condiment/tiris_sele
	name = "tiris-sele"
	desc = "An incredibly rich sauce made with the blood of a Tiris"
	filling_color = "#c3bca0"
	food_reagents = list(/datum/reagent/consumable/tiris_sele = 8)

/obj/item/food/ration/condiment/powdered_dotu
	name = "powdered dotu"
	desc = "Powdered Dotu fruit makes an excellent topping when a more neutral flavor is desired."
	filling_color = "#c3bca0"
	food_reagents = list(/datum/reagent/consumable/dotu_juice = 8)

/obj/item/food/ration/condiment/tiris_cheese
	name = "tiris cheese spread pack"
	filling_color = "#cac84e"
	food_reagents = list(/datum/reagent/consumable/cheese_spread = 8) //guh
