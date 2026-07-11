/*
 * Sandbags
 */

/obj/item/stack/sandbags
	name = "sandbags"
	icon_state = "sandbags"
	singular_name = "sandbag"
	layer = LOW_ITEM_LAYER
	merge_type = /obj/item/stack/sandbags
	max_amount = 15
	full_w_class = WEIGHT_CLASS_HUGE

GLOBAL_LIST_INIT(sandbag_recipes, list ( \
	new/datum/stack_recipe("sandbag wall", /obj/structure/barricade/sandbags, 5, time = 25, one_per_turf = 1, on_floor = 1), \
	new/datum/stack_recipe("empty sandbag", /obj/item/stack/empty_sandbag, 1, time = 5)
	))

/obj/item/stack/sandbags/get_main_recipes()
	. = ..()
	. += GLOB.sandbag_recipes

/obj/item/stack/empty_sandbag
	name = "empty sandbags"
	desc = "A bag to be filled with sand."
	icon_state = "empty_sandbags"
	singular_name = "empty sandbag"
	full_w_class = WEIGHT_CLASS_BULKY
	max+_amount = 60

/obj/item/stack/empty_sandbag/attackby(obj/item/attacking_item, mob/user, params)
	if(istype(attacking_item, /obj/item/stack/ore/glass))
		var/obj/item/stack/ore/glass/filling = attacking_item
		visible_message(user, span_notice("[user] starts filling sandbags!"), span_notice("You start filling sandbags."))
		while(filling.amount > 0)
			if(do_after(user, 20, src))
				var/obj/item/stack/sandbags/filled_bag = new /obj/item/stack/sandbags(drop_location())
				to_chat(user, span_notice("You fill an [singular_name]!"))
				if (Adjacent(user) && !issilicon(user))
					user.put_in_hands(filled_bag)
				filling.use(1)
				use(1)
			else
				break
	else
		return ..()

/obj/item/stack/empty_sandbag/half
	amount = 30

/obj/item/stack/empty_sandbag/full
	amount = 60
