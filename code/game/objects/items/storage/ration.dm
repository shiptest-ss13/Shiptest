/obj/item/storage/ration
	name = "empty ration pack"
	desc = "No food..."
	icon = 'icons/obj/food/food.dmi'
	icon_state = "peachcan"
	item_state = "syringe_kit"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	resistance_flags = FLAMMABLE
	drop_sound = 'sound/items/handling/cardboardbox_drop.ogg'
	pickup_sound =  'sound/items/handling/cardboardbox_pickup.ogg'

/obj/item/storage/ration/Initialize(mapload)
	. = ..()
	update_icon()

/obj/item/storage/ration/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 7
	STR.set_holdable(list(/obj/item/reagent_containers/food))
	STR.locked = TRUE
	STR.locked_flavor = "sealed closed"

/obj/item/storage/ration/proc/open_ration(mob/user)
	to_chat(user, "<span class='notice'>You tear open \the [src].</span>")
	playsound(user.loc, 'sound/effects/rip3.ogg', 50)
	SEND_SIGNAL(src, COMSIG_TRY_STORAGE_SET_LOCKSTATE, FALSE)

/obj/item/storage/ration/attack_self(mob/user)
	var/locked = SEND_SIGNAL(src, COMSIG_IS_STORAGE_LOCKED)
	if(locked)
		open_ration(user)
		icon_state = "[icon_state]_open"
	return ..()

/obj/item/storage/ration/vegan_chili
	name = "vegan chili with beans ration"

/obj/item/storage/ration/vegan_chili/PopulateContents()
	var/static/items_inside = list(
		/obj/item/reagent_containers/food/snacks/ration/vegan_chili = 1,
		/obj/item/reagent_containers/food/condiment/pack/cheese_spread = 1,
		/obj/item/reagent_containers/food/snacks/ration/vegan_crackers = 1,
		/obj/item/reagent_containers/food/snacks/ration/cornbread = 1,
		/obj/item/reagent_containers/food/snacks/ration/pizza_crackers = 1,
		/obj/item/reagent_containers/food/condiment/pack/grape_powder = 1,
		/obj/item/reagent_containers/food/snacks/ration/beverage_bag = 1
		)
	generate_items_inside(items_inside,src)

