/obj/item/storage/box/coffeepack/robusta
	name = "robusta beans"
	desc = "A bag containing fresh, dried coffee robusta beans."
	illustration = null
	icon = 'icons/obj/item/coffee.dmi'
	icon_state = "robusta_beans"

/obj/item/storage/box/coffeepack/robusta/PopulateContents()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 5
	var/static/list/can_hold = typecacheof(list(/obj/item/food/grown/coffee))
	STR.can_hold = can_hold
	for(var/i in 1 to 5)
		var/obj/item/food/grown/coffee/robusta/bean = new(src)
		ADD_TRAIT(bean, TRAIT_DRIED, type)
		bean.add_atom_colour("#ad7257", FIXED_COLOUR_PRIORITY)

/obj/item/storage/box/coffeepack/arabica
	name = "arabica beans"
	desc = "A bag containing fresh, dried coffee arabica beans."
	illustration = null
	icon = 'icons/obj/item/coffee.dmi'
	icon_state = "arabica_beans"

/obj/item/storage/box/coffeepack/arabica/PopulateContents()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 5
	var/static/list/can_hold = typecacheof(list(/obj/item/food/grown/coffee))
	STR.can_hold = can_hold
	for(var/i in 1 to 5)
		var/obj/item/food/grown/coffee/bean = new(src)
		ADD_TRAIT(bean, TRAIT_DRIED, type)
		bean.add_atom_colour("#ad7257", FIXED_COLOUR_PRIORITY)
