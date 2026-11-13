/obj/structure/closet/secure_closet/freezer
	icon_state = "freezer"
	drag_slowdown = 3
	storage_capacity = 50
	var/jones = FALSE

/obj/structure/closet/secure_closet/freezer/Destroy()
	recursive_organ_check(src)
	return ..()

/obj/structure/closet/secure_closet/freezer/Initialize()
	. = ..()
	recursive_organ_check(src)

/obj/structure/closet/secure_closet/freezer/open(mob/living/user, force = TRUE)
	if(opened || !can_open(user, force))	//dupe check just so we don't let the organs decay when someone fails to open the locker
		return FALSE
	recursive_organ_check(src)
	return ..()

/obj/structure/closet/secure_closet/freezer/close(mob/living/user)
	if(..())	//if we actually closed the locker
		recursive_organ_check(src)

/obj/structure/closet/secure_closet/freezer/ex_act()
	if(!jones)
		jones = TRUE
	else
		..()

/obj/structure/closet/secure_closet/freezer/kitchen
	name = "kitchen cabinet"
	req_access = list(ACCESS_KITCHEN)

/obj/structure/closet/secure_closet/freezer/kitchen/PopulateContents()
	..()
	for(var/i = 0, i < 3, i++)
		new /obj/item/reagent_containers/condiment/flour(src)
	new /obj/item/reagent_containers/condiment/rice(src)
	new /obj/item/reagent_containers/condiment/sugar(src)

/obj/structure/closet/secure_closet/freezer/meat
	name = "meat fridge"
	req_access = list(ACCESS_KITCHEN)

/obj/structure/closet/secure_closet/freezer/meat/PopulateContents()
	..()
	for(var/i = 0, i < 4, i++)
		new /obj/item/food/meat/slab/monkey(src)

/obj/structure/closet/secure_closet/freezer/meat/open
	req_access = null
	locked = FALSE

/obj/structure/closet/secure_closet/freezer/gulag_fridge
	name = "refrigerator"

/obj/structure/closet/secure_closet/freezer/gulag_fridge/PopulateContents()
	..()
	for(var/i in 1 to 3)
		new /obj/item/reagent_containers/food/drinks/beer(src)

/obj/structure/closet/secure_closet/freezer/fridge
	name = "refrigerator"
	req_access = list(ACCESS_KITCHEN)

/obj/structure/closet/secure_closet/freezer/fridge/PopulateContents()
	..()
	for(var/i = 0, i < 5, i++)
		new /obj/item/reagent_containers/condiment/milk(src)
	for(var/i = 0, i < 5, i++)
		new /obj/item/reagent_containers/condiment/soymilk(src)
	for(var/i = 0, i < 2, i++)
		new /obj/item/storage/fancy/egg_box(src)

/obj/structure/closet/secure_closet/freezer/fridge/open
	req_access = null
	locked = FALSE
