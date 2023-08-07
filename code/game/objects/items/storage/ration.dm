/obj/item/storage/ration
	name = "empty ration pack"
	desc = "standerd issue ration"
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
		/obj/item/reagent_containers/food/snacks/ration/vegan_crackers = 1,
		/obj/item/reagent_containers/food/snacks/ration/cornbread = 1,
		/obj/item/reagent_containers/food/snacks/ration/pizza_crackers = 1,
		/obj/item/reagent_containers/food/condiment/pack/cheese_spread = 1,
		/obj/item/reagent_containers/food/condiment/pack/grape_powder = 1,
		/obj/item/reagent_containers/food/drinks/ration/beverage_bag = 1
		)
	generate_items_inside(items_inside,src)

/obj/item/storage/ration/shredded_beef
	name = "shredded beef in barbecue sauce ration"

/obj/item/storage/ration/shredded_beef/PopulateContents()
	var/static/items_inside = list(
		/obj/item/reagent_containers/food/snacks/ration/shredded_beef = 1,
		/obj/item/reagent_containers/food/snacks/ration/fruit_puree = 1,
		/obj/item/reagent_containers/food/snacks/ration/jerky_wrap = 1,
		/obj/item/reagent_containers/food/snacks/ration/cinnamon_bun = 1,
		/obj/item/reagent_containers/food/condiment/pack/hot_cheese_spread = 1,
		/obj/item/reagent_containers/food/condiment/pack/chocolate_protein_powder = 1,
		/obj/item/reagent_containers/food/drinks/ration/beverage_bag = 1
		)
	generate_items_inside(items_inside,src)

/obj/item/storage/ration/pork_spaghetti
	name = "spaghetti with pork and sauce ration"

/obj/item/storage/ration/pork_spaghetti/PopulateContents()
	var/static/items_inside = list(
		/obj/item/reagent_containers/food/snacks/ration/pork_spaghetti = 1,
		/obj/item/reagent_containers/food/snacks/ration/toaster_pastry = 1,
		/obj/item/reagent_containers/food/snacks/ration/bread_sticks = 1,
		/obj/item/reagent_containers/food/snacks/ration/dried_raisins = 1,
		/obj/item/reagent_containers/food/condiment/pack/cheese_spread = 1,
		/obj/item/reagent_containers/food/condiment/pack/lemonade_powder = 1,
		/obj/item/reagent_containers/food/drinks/ration/beverage_bag = 1
		)
	generate_items_inside(items_inside,src)

/obj/item/storage/ration/fried_fish
	name = "fried fish chunks ration"

/obj/item/storage/ration/fried_fish/PopulateContents()
	var/static/items_inside = list(
		/obj/item/reagent_containers/food/snacks/ration/fried_fish = 1,
		/obj/item/reagent_containers/food/snacks/ration/energy_bar = 1,
		/obj/item/reagent_containers/food/snacks/ration/tortilla = 1,
		/obj/item/reagent_containers/food/snacks/ration/corn_kernels = 1,
		/obj/item/reagent_containers/food/snacks/ration/beef_sticks = 1,
		/obj/item/reagent_containers/food/condiment/pack/cheese_spread = 1,
		/obj/item/reagent_containers/food/condiment/pack/fruit_powder = 1,
		/obj/item/reagent_containers/food/drinks/ration/beverage_bag = 1
		)
	generate_items_inside(items_inside,src)

/obj/item/storage/ration/beef_strips
	name = "beef strips in tomato sauce ration"

/obj/item/storage/ration/beef_strips/PopulateContents()
	var/static/items_inside = list(
		/obj/item/reagent_containers/food/snacks/ration/beef_strips = 1,
		/obj/item/reagent_containers/food/snacks/ration/chocolate_pudding = 1,
		/obj/item/reagent_containers/food/snacks/ration/wheat_bread = 1,
		/obj/item/reagent_containers/food/snacks/ration/blackberry_preserves = 1,
		/obj/item/reagent_containers/food/snacks/ration/candy_rings = 1,
		/obj/item/reagent_containers/food/condiment/pack/peanut_butter = 1,
		/obj/item/reagent_containers/food/condiment/pack/fruit_smoothie_powder = 1,
		/obj/item/reagent_containers/food/drinks/ration/beverage_bag = 1
		)
	generate_items_inside(items_inside,src)
