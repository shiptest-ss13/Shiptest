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
	desc += "\nIt's been opened. Let's get this out onto a tray."

/obj/item/storage/ration/attack_self(mob/user)
	var/locked = SEND_SIGNAL(src, COMSIG_IS_STORAGE_LOCKED)
	if(locked)
		open_ration(user)
		icon_state = "[icon_state]_open"
	return ..()

/obj/item/storage/ration/vegan_chili
	name = "vegan chili with beans ration"
	desc = "A complete meal package containing a hearty vegan chili with beans, complemented by vegetable crackers, savory cornbread, flavorful pizza crackers, and more. A perfect choice for plant-based nourishment."

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
	desc = "Enjoy the rich and savory flavors of shredded beef in smoky barbecue sauce with this satisfying ration. Accompanied by a fruit puree, jerky wrap, cinnamon bun, and additional condiments, this ration is perfect for meat lovers."

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
	desc = "Indulge in a comforting meal of spaghetti with tender pork and savory sauce with this ration. Complemented by a toaster pastry, seasoned bread sticks, dried raisins, and other accompaniments, this ration offers a flavorful experience."

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
	desc = "Experience the crispy delight of fried fish chunks with this ration. Accompanied by an energy bar, tortillas, toasted corn kernels, and more, this ration provides a satisfying combination of flavors and textures."

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
	desc = "Savor the deliciousness of tender beef strips in a flavorful tomato sauce with this ration. Enjoy a chocolate pudding, white wheat snack bread, blackberry preserves, and peppermint candy rings as delightful accompaniments."

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


/obj/item/storage/ration/chili_macaroni
	name = "Chili and Macaroni Ration"
	desc = "Indulge in the comforting combination of chili and macaroni in this flavorful ration. Satisfy your taste buds with a mix of sweet and savory treats."

/obj/item/storage/ration/chili_macaroni/PopulateContents()
	var/static/items_inside = list(
		/obj/item/reagent_containers/food/snacks/ration/chili_macaroni = 1,
		/obj/item/reagent_containers/food/snacks/ration/lemon_pound_cake = 1,
		/obj/item/reagent_containers/food/snacks/ration/vegan_crackers = 1,
		/obj/item/reagent_containers/food/snacks/ration/beef_sticks = 1,
		/obj/item/reagent_containers/food/snacks/ration/cherry_snackers = 1,
		//obj/item/reagent_containers/food/condiment/pack/jalapeno_cheese_spread = 1,
		//obj/item/reagent_containers/food/condiment/ration/orange_beverage_powder = 1,
		/obj/item/reagent_containers/food/drinks/ration/beverage_bag = 1
		)
	generate_items_inside(items_inside, src)

/obj/item/storage/ration/chicken_wings_hot_sauce
	name = "Chicken Wings in Hot Sauce Ration"
	desc = "Experience the bold and spicy flavors of chicken wings drenched in hot sauce. This ration also includes a mix of delightful snacks for a well-rounded meal."

/obj/item/storage/ration/chicken_wings_hot_sauce/PopulateContents()
	var/static/items_inside = list(
		/obj/item/reagent_containers/food/snacks/ration/chicken_wings_hot_sauce = 1,
		/obj/item/reagent_containers/food/snacks/ration/garlic_mashed_potatoes = 1,
		/obj/item/reagent_containers/food/snacks/ration/mint_chocolate_snack_cake = 1,
		/obj/item/reagent_containers/food/snacks/ration/strawberry_preserves = 1,
		/obj/item/reagent_containers/food/condiment/pack/peanut_butter = 1,
		//obj/item/reagent_containers/food/condiment/ration/cherry_beverage_powder = 1,
		/obj/item/reagent_containers/food/drinks/ration/beverage_bag = 1
		)
	generate_items_inside(items_inside, src)

/obj/item/storage/ration/fish_stew
	name = "Fish Stew Ration"
	desc = "Dive into the depths of flavor with this fish stew ration. Enjoy a hearty blend of seafood and vegetables, complemented by a selection of tasty accompaniments."

/obj/item/storage/ration/fish_stew/PopulateContents()
	var/static/items_inside = list(
		/obj/item/reagent_containers/food/snacks/ration/fish_stew = 1,
		/obj/item/reagent_containers/food/snacks/ration/soup_crackers = 1,
		/obj/item/reagent_containers/food/snacks/ration/griddled_mushrooms_chili = 1,
		/obj/item/reagent_containers/food/snacks/ration/sour_gummy_worms = 1,
		/obj/item/reagent_containers/food/snacks/ration/wheat_bread = 1,
		//obj/item/reagent_containers/food/condiment/pack/garlic_cheese_spread = 1,
		//obj/item/reagent_containers/food/condiment/ration/freeze_dried_orange_powder = 1,
		/obj/item/reagent_containers/food/drinks/ration/beverage_bag = 1
		)
	generate_items_inside(items_inside, src)

/obj/item/storage/ration/lemon_pepper_chicken
	name = "Lemon Pepper Chicken Ration"
	desc = "A tasty Lemon Pepper Chicken ration that combines the flavors of fruit and meat. Perfect for a satisfying meal."

/obj/item/storage/ration/lemon_pepper_chicken/PopulateContents()
	var/static/items_inside = list(
		/obj/item/reagent_containers/food/snacks/ration/lemon_pepper_chicken = 1,
		/obj/item/reagent_containers/food/snacks/ration/jellied_eels = 1,
		/obj/item/reagent_containers/food/snacks/ration/pretzel_sticks_honey_mustard = 1,
		/obj/item/reagent_containers/food/snacks/ration/blue_raspberry_candies = 1,
		/obj/item/reagent_containers/food/snacks/ration/peanut_cranberry_mix = 1,
		//obj/item/reagent_containers/food/condiment/ration/freeze_dried_coffee_powder = 1,
		/obj/item/reagent_containers/food/drinks/ration/beverage_bag = 1
		)
	generate_items_inside(items_inside, src)

/obj/item/storage/ration/sausage_peppers_onions
	name = "Sausage, Peppers and Onions Ration"
	desc = "Indulge in the delightful combination of juicy sausage, peppers, and onions in this hearty ration."

/obj/item/storage/ration/sausage_peppers_onions/PopulateContents()
	var/static/items_inside = list(
		/obj/item/reagent_containers/food/snacks/ration/sausage_peppers_onions = 1,
		/obj/item/reagent_containers/food/snacks/ration/white_sandwich_bread = 1,
		/obj/item/reagent_containers/food/snacks/ration/channeler_meat_candy = 1,
		/obj/item/reagent_containers/food/snacks/ration/baked_cheddarcheese_chips = 1,
		/obj/item/reagent_containers/food/snacks/ration/chocolate_orange_snack_cake = 1,
		//obj/item/reagent_containers/food/drinks/ration/pan_genezan_vodka_ration = 1,
		/obj/item/reagent_containers/food/drinks/ration/beverage_bag = 1
		)
	generate_items_inside(items_inside, src)

/obj/item/storage/ration/pork_dumplings_chili_sauce
	name = "Pork Dumplings in Chili Sauce Ration"
	desc = "Savor the rich flavors of pork dumplings in a spicy chili sauce, accompanied by a variety of complementary snacks."

/obj/item/storage/ration/pork_dumplings_chili_sauce/PopulateContents()
	var/static/items_inside = list(
		/obj/item/reagent_containers/food/snacks/ration/dumplings_chili_sauce = 1,
		/obj/item/reagent_containers/food/snacks/ration/fried_potato_curls = 1,
		/obj/item/reagent_containers/food/snacks/ration/pretzel_sticks_honey_mustard = 1,
		/obj/item/reagent_containers/food/snacks/ration/rationers_guild_chocolate_bar = 1,
		/obj/item/reagent_containers/food/snacks/ration/pick_me_up_energy_gum = 1,
		//obj/item/reagent_containers/food/condiment/ration/coffee_beverage_powder = 1,
		/obj/item/reagent_containers/food/drinks/ration/beverage_bag = 1
		)
	generate_items_inside(items_inside, src)

/obj/item/storage/ration/battered_fish_sticks
	name = "Battered Fish Sticks Ration"
	desc = "Enjoy the crispy goodness of battered fish sticks, along with a selection of sides and a delectable dessert."

/obj/item/storage/ration/battered_fish_sticks/PopulateContents()
	var/static/items_inside = list(
		/obj/item/reagent_containers/food/snacks/ration/battered_fish_sticks = 1,
		/obj/item/reagent_containers/food/snacks/ration/stewed_asparagus_butter = 1,
		/obj/item/reagent_containers/food/snacks/ration/fried_potato_curls = 1,
		/obj/item/reagent_containers/food/snacks/ration/chocolate_orange_cake = 1,
		/obj/item/reagent_containers/food/snacks/ration/apple_slices = 1,
		//obj/item/reagent_containers/food/condiment/ration/pineapple_beverage_base = 1,
		/obj/item/reagent_containers/food/drinks/ration/beverage_bag = 1
		)
	generate_items_inside(items_inside, src)

/obj/item/storage/ration/assorted_salted_offal
	name = "Assorted Salted Offal Ration"
	desc = "An adventurous choice, this ration offers an assortment of salted offal, providing a unique culinary experience."


/obj/item/storage/ration/assorted_salted_offal/PopulateContents()
	var/static/items_inside = list(
		/obj/item/reagent_containers/food/snacks/ration/assorted_salted_offal = 1,
		/obj/item/reagent_containers/food/snacks/ration/broth_tuna_rice = 1,
		/obj/item/reagent_containers/food/snacks/ration/trail_crackers = 1,
		/obj/item/reagent_containers/food/snacks/ration/tropical_energy_bar = 1,
		/obj/item/reagent_containers/food/snacks/ration/candied_pineapple_chunks = 1,
		//obj/item/reagent_containers/food/drinks/ration/pan_genezan_vodka_ration = 1,
		/obj/item/reagent_containers/food/drinks/ration/beverage_bag = 1
		)
	generate_items_inside(items_inside, src)

/obj/item/storage/ration/maple_pork_sausage_patty
	name = "Maple Pork Sausage Patty Ration"
	desc = "Start your day with a satisfying breakfast featuring a maple-infused pork sausage patty and a variety of treats."

/obj/item/storage/ration/maple_pork_sausage_patty/PopulateContents()
	var/static/items_inside = list(
		/obj/item/reagent_containers/food/snacks/ration/maple_pork_sausage_patty = 1,
		/obj/item/reagent_containers/food/snacks/ration/hash_brown_bacon = 1,
		/obj/item/reagent_containers/food/snacks/ration/granola_milk_blueberries = 1,
		/obj/item/reagent_containers/food/snacks/ration/maple_muffin = 1,
		/obj/item/reagent_containers/food/snacks/ration/smoked_almonds = 1,
		//obj/item/reagent_containers/food/condiment/ration/maple_syrup = 1,
		//obj/item/reagent_containers/food/condiment/ration/grape_beverage_powder = 1,
		/obj/item/reagent_containers/food/drinks/ration/beverage_bag = 1
		)
	generate_items_inside(items_inside, src)

/obj/item/storage/ration/jalapeno_pepper_jack_beef_patty
	name = "Jalapeno Pepper Jack Beef Patty Ration"
	desc = "Experience a flavorful fusion of jalapeno, pepper jack cheese, and beef in this grilled beef patty ration."

/obj/item/storage/ration/jalapeno_pepper_jack_beef_patty/PopulateContents()
	var/static/items_inside = list(
		/obj/item/reagent_containers/food/snacks/ration/jalapeno_pepper_jack_beef_patty = 1,
		/obj/item/reagent_containers/food/snacks/ration/au_gratin_potatoes = 1,
		/obj/item/reagent_containers/food/snacks/ration/chocolate_chunk_oatmeal_cookie = 1,
		/obj/item/reagent_containers/food/snacks/ration/jerky_wraps = 1,
		/obj/item/reagent_containers/food/snacks/ration/peanut_candies = 1,
		//obj/item/reagent_containers/food/condiment/ration/bacon_cheddar_cheese_spread = 1,
		//obj/item/reagent_containers/food/condiment/ration/orange_beverage_base_sugar_free = 1,
		/obj/item/reagent_containers/food/drinks/ration/beverage_bag = 1
		)
	generate_items_inside(items_inside, src)

/obj/item/storage/ration/beef_goulash
	name = "Beef Goulash Ration"
	desc = "Delight in the rich flavors of beef goulash, accompanied by a selection of sides and a sweet treat."

/obj/item/storage/ration/beef_goulash/PopulateContents()
	var/static/items_inside = list(
		/obj/item/reagent_containers/food/snacks/ration/beef_goulash = 1,
		/obj/item/reagent_containers/food/snacks/ration/applesauce_carb_enhanced = 1,
		/obj/item/reagent_containers/food/snacks/ration/strawberry_preserves = 1,
		/obj/item/reagent_containers/food/snacks/ration/white_bread_mini_loaf = 1,
		/obj/item/reagent_containers/food/snacks/ration/patriotic_sugar_cookies = 1,
		//obj/item/reagent_containers/food/condiment/ration/chunky_peanut_butter = 1,
		//obj/item/reagent_containers/food/condiment/ration/orange_beverage_powder = 1,
		/obj/item/reagent_containers/food/drinks/ration/beverage_bag = 1
		)
	generate_items_inside(items_inside, src)

/obj/item/storage/ration/pepperoni_pizza_slice
	name = "Pepperoni Pizza Slice Ration"
	desc = "Indulge in the classic taste of pepperoni pizza with this ration, complete with sides and a refreshing beverage."

/obj/item/storage/ration/pepperoni_pizza_slice/PopulateContents()
	var/static/items_inside = list(
		/obj/item/reagent_containers/food/snacks/ration/pepperoni_pizza_slice = 1,
		/obj/item/reagent_containers/food/snacks/ration/apples_in_spiced_sauce = 1,
		/obj/item/reagent_containers/food/snacks/ration/vegan_crackers = 1,
		/obj/item/reagent_containers/food/snacks/ration/oatmeal_cookie = 1,
		//obj/item/reagent_containers/food/condiment/ration/jalapeno_cheese_spread = 1,
		//obj/item/reagent_containers/food/condiment/ration/lemonade_beverage_powder = 1,
		/obj/item/reagent_containers/food/drinks/ration/beverage_bag = 1
	)
	generate_items_inside(items_inside, src)

/obj/item/storage/ration/calamari_red_sauce
	name = "Blackened Calamari in Red Sauce"

/obj/item/storage/ration/macaroni_tomato_sauce
	name = "Elbow Macaroni in Tomato Sauce"

/obj/item/storage/ration/cheese_pizza_slice
	name = "Cheese Pizza Slice"
