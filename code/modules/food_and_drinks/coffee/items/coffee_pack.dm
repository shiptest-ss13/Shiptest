/obj/item/storage/box/coffeepack/robusta
	name = "robusta beans"
	desc = "A bag containing fresh, undried coffee robusta beans."
	illustration = null
	icon = 'icons/obj/item/coffee.dmi'
	icon_state = "robusta_beans"

/obj/item/storage/box/coffeepack/robusta/PopulateContents()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 5
	var/static/list/can_hold = typecacheof(list(/obj/item/food/grown/coffee))
	STR.can_hold = can_hold

/obj/item/storage/box/coffeepack/arabica
	name = "arabica beans"
	desc = "A bag containing fresh, undried coffee arabica beans."
	illustration = null
	icon = 'icons/obj/item/coffee.dmi'
	icon_state = "arabica_beans"

/obj/item/storage/box/coffeepack/arabica/PopulateContents()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 5
	var/static/list/can_hold = typecacheof(list(/obj/item/food/grown/coffee))
	STR.can_hold = can_hold
