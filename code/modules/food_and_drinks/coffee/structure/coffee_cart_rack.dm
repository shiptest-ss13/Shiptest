//now, how do you store coffee carts? well, in a rack, of course!
/obj/item/storage/fancy/coffee_cart_rack
	name = "coffeemaker cartridge rack"
	desc = "A small rack for storing coffeemaker cartridges."
	icon = 'icons/obj/item/coffee.dmi'
	icon_state = "coffee_cartrack"
	base_icon_state = "coffee_cartrack"
	//icon_type = "coffee cartridge"
	spawn_type = /obj/item/coffee_cartridge
	contents_tag = "cartridge"

/obj/item/storage/fancy/coffee_cart_rack/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 4
	var/static/list/can_hold = typecacheof(list(/obj/item/coffee_cartridge))
	STR.can_hold = can_hold

/obj/item/storage/fancy/coffee_cart_rack/update_icon_state()
	if(!contents.len)
		icon_state = initial(icon_state)
	else
		icon_state = "[initial(icon_state)][contents.len]"
	return ..()
