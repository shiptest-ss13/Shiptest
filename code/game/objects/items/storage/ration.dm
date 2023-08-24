/obj/item/storage/ration
	name = "empty ration pack"
	desc = "standerd issue ration"
	icon = 'icons/obj/food/ration.dmi'
	icon_state = "ration_package"
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
		/obj/item/reagent_containers/food/snacks/ration/entree/vegan_chili = 1,
		/obj/item/reagent_containers/food/snacks/ration/side/vegan_crackers = 1,
		/obj/item/reagent_containers/food/snacks/ration/side/cornbread = 1,
		/obj/item/reagent_containers/food/snacks/ration/snack/pizza_crackers = 1,
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
		/obj/item/reagent_containers/food/snacks/ration/entree/shredded_beef = 1,
		/obj/item/reagent_containers/food/snacks/ration/side/jerky_wrap = 1,
		/obj/item/reagent_containers/food/snacks/ration/snack/fruit_puree = 1,
		/obj/item/reagent_containers/food/snacks/ration/snack/cinnamon_bun = 1,
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
		/obj/item/reagent_containers/food/snacks/ration/entree/pork_spaghetti = 1,
		/obj/item/reagent_containers/food/snacks/ration/snack/toaster_pastry = 1,
		/obj/item/reagent_containers/food/snacks/ration/snack/dried_raisins = 1,
		/obj/item/reagent_containers/food/snacks/ration/side/bread_sticks = 1,
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
		/obj/item/reagent_containers/food/snacks/ration/entree/fried_fish = 1,
		/obj/item/reagent_containers/food/snacks/ration/side/tortilla = 1,
		/obj/item/reagent_containers/food/snacks/ration/side/beef_sticks = 1,
		/obj/item/reagent_containers/food/snacks/ration/snack/corn_kernels = 1,
		/obj/item/reagent_containers/food/snacks/ration/bar/energy_bar = 1,
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
		/obj/item/reagent_containers/food/snacks/ration/entree/beef_strips = 1,
		/obj/item/reagent_containers/food/snacks/ration/side/wheat_bread = 1,
		/obj/item/reagent_containers/food/snacks/ration/snack/chocolate_pudding = 1,
		/obj/item/reagent_containers/food/snacks/ration/snack/blackberry_preserves = 1,
		/obj/item/reagent_containers/food/snacks/ration/snack/candy_rings = 1,
		/obj/item/reagent_containers/food/condiment/pack/peanut_butter = 1,
		/obj/item/reagent_containers/food/condiment/pack/fruit_smoothie_powder = 1,
		/obj/item/reagent_containers/food/drinks/ration/beverage_bag = 1
		)
	generate_items_inside(items_inside,src)


/obj/item/storage/ration/chili_macaroni
	name = "chili and macaroni ration"
	desc = "Indulge in the comforting combination of chili and macaroni in this flavorful ration. Satisfy your taste buds with a mix of sweet and savory treats."

/obj/item/storage/ration/chili_macaroni/PopulateContents()
	var/static/items_inside = list(
		/obj/item/reagent_containers/food/snacks/ration/entree/chili_macaroni = 1,
		/obj/item/reagent_containers/food/snacks/ration/side/vegan_crackers = 1,
		/obj/item/reagent_containers/food/snacks/ration/side/beef_sticks = 1,
		/obj/item/reagent_containers/food/snacks/ration/snack/lemon_pound_cake = 1,
		/obj/item/reagent_containers/food/snacks/ration/snack/cherry_snackers = 1,
		/obj/item/reagent_containers/food/condiment/pack/hot_cheese_spread = 1,
		//obj/item/reagent_containers/food/condiment/ration/orange_beverage_powder = 1,
		/obj/item/reagent_containers/food/drinks/ration/beverage_bag = 1
		)
	generate_items_inside(items_inside, src)

/obj/item/storage/ration/chicken_wings_hot_sauce
	name = "chicken wings in hot sauce ration"
	desc = "Experience the bold and spicy flavors of chicken wings drenched in hot sauce. This ration also includes a mix of delightful snacks for a well-rounded meal."

/obj/item/storage/ration/chicken_wings_hot_sauce/PopulateContents()
	var/static/items_inside = list(
		/obj/item/reagent_containers/food/snacks/ration/entree/chicken_wings_hot_sauce = 1,
		/obj/item/reagent_containers/food/snacks/ration/side/garlic_mashed_potatoes = 1,
		/obj/item/reagent_containers/food/snacks/ration/snack/strawberry_preserves = 1,
		/obj/item/reagent_containers/food/snacks/ration/snack/mint_chocolate_snack_cake = 1,
		/obj/item/reagent_containers/food/condiment/pack/peanut_butter = 1,
		//obj/item/reagent_containers/food/condiment/ration/cherry_beverage_powder = 1,
		/obj/item/reagent_containers/food/drinks/ration/beverage_bag = 1
		)
	generate_items_inside(items_inside, src)

/obj/item/storage/ration/fish_stew
	name = "fish stew ration"
	desc = "Dive into the depths of flavor with this fish stew ration. Enjoy a hearty blend of seafood and vegetables, complemented by a selection of tasty accompaniments."

/obj/item/storage/ration/fish_stew/PopulateContents()
	var/static/items_inside = list(
		/obj/item/reagent_containers/food/snacks/ration/entree/fish_stew = 1,
		/obj/item/reagent_containers/food/snacks/ration/side/soup_crackers = 1,
		/obj/item/reagent_containers/food/snacks/ration/side/griddled_mushrooms_chili = 1,
		/obj/item/reagent_containers/food/snacks/ration/side/wheat_bread = 1,
		/obj/item/reagent_containers/food/snacks/ration/snack/sour_gummy_worms = 1,
		//obj/item/reagent_containers/food/condiment/pack/garlic_cheese_spread = 1,
		//obj/item/reagent_containers/food/condiment/ration/freeze_dried_orange_powder = 1,
		/obj/item/reagent_containers/food/drinks/ration/beverage_bag = 1
		)
	generate_items_inside(items_inside, src)

/obj/item/storage/ration/lemon_pepper_chicken
	name = "lemon pepper chicken ration"
	desc = "A tasty Lemon Pepper Chicken ration that combines the flavors of fruit and meat. Perfect for a satisfying meal."

/obj/item/storage/ration/lemon_pepper_chicken/PopulateContents()
	var/static/items_inside = list(
		/obj/item/reagent_containers/food/snacks/ration/entree/lemon_pepper_chicken = 1,
		/obj/item/reagent_containers/food/snacks/ration/side/jellied_eels = 1,
		/obj/item/reagent_containers/food/snacks/ration/side/pretzel_sticks_honey_mustard = 1,
		/obj/item/reagent_containers/food/snacks/ration/snack/blue_raspberry_candies = 1,
		/obj/item/reagent_containers/food/snacks/ration/snack/peanut_cranberry_mix = 1,
		//obj/item/reagent_containers/food/condiment/ration/freeze_dried_coffee_powder = 1,
		/obj/item/reagent_containers/food/drinks/ration/beverage_bag = 1
		)
	generate_items_inside(items_inside, src)

/obj/item/storage/ration/sausage_peppers_onions
	name = "sausage, peppers and onions ration"
	desc = "Indulge in the delightful combination of juicy sausage, peppers, and onions in this hearty ration."

/obj/item/storage/ration/sausage_peppers_onions/PopulateContents()
	var/static/items_inside = list(
		/obj/item/reagent_containers/food/snacks/ration/entree/sausage_peppers_onions = 1,
		/obj/item/reagent_containers/food/snacks/ration/side/white_sandwich_bread = 1,
		/obj/item/reagent_containers/food/snacks/ration/side/baked_cheddarcheese_chips = 1,
		/obj/item/reagent_containers/food/snacks/ration/snack/channeler_meat_candy = 1,
		/obj/item/reagent_containers/food/snacks/ration/snack/chocolate_orange_snack_cake = 1,
		//obj/item/reagent_containers/food/drinks/ration/pan_genezan_vodka_ration = 1,
		/obj/item/reagent_containers/food/drinks/ration/beverage_bag = 1
		)
	generate_items_inside(items_inside, src)

/obj/item/storage/ration/pork_dumplings_chili_sauce
	name = "pork dumplings in chili sauce ration"
	desc = "Savor the rich flavors of pork dumplings in a spicy chili sauce, accompanied by a variety of complementary snacks."

/obj/item/storage/ration/pork_dumplings_chili_sauce/PopulateContents()
	var/static/items_inside = list(
		/obj/item/reagent_containers/food/snacks/ration/entree/dumplings_chili_sauce = 1,
		/obj/item/reagent_containers/food/snacks/ration/side/fried_potato_curls = 1,
		/obj/item/reagent_containers/food/snacks/ration/side/pretzel_sticks_honey_mustard = 1,
		/obj/item/reagent_containers/food/snacks/ration/snack/pick_me_up_energy_gum = 1,
		/obj/item/reagent_containers/food/snacks/ration/bar/rationers_guild_chocolate_bar = 1,
		//obj/item/reagent_containers/food/condiment/ration/coffee_beverage_powder = 1,
		/obj/item/reagent_containers/food/drinks/ration/beverage_bag = 1
		)
	generate_items_inside(items_inside, src)

/obj/item/storage/ration/battered_fish_sticks
	name = "battered fish sticks ration"
	desc = "Enjoy the crispy goodness of battered fish sticks, along with a selection of sides and a delectable dessert."

/obj/item/storage/ration/battered_fish_sticks/PopulateContents()
	var/static/items_inside = list(
		/obj/item/reagent_containers/food/snacks/ration/entree/battered_fish_sticks = 1,
		/obj/item/reagent_containers/food/snacks/ration/side/stewed_asparagus_butter = 1,
		/obj/item/reagent_containers/food/snacks/ration/side/fried_potato_curls = 1,
		/obj/item/reagent_containers/food/snacks/ration/snack/chocolate_orange_snack_cake = 1,
		/obj/item/reagent_containers/food/snacks/ration/snack/apple_slices = 1,
		//obj/item/reagent_containers/food/condiment/ration/pineapple_beverage_base = 1,
		/obj/item/reagent_containers/food/drinks/ration/beverage_bag = 1
		)
	generate_items_inside(items_inside, src)

/obj/item/storage/ration/assorted_salted_offal
	name = "assorted salted offal ration"
	desc = "An adventurous choice, this ration offers an assortment of salted offal, providing a unique culinary experience."


/obj/item/storage/ration/assorted_salted_offal/PopulateContents()
	var/static/items_inside = list(
		/obj/item/reagent_containers/food/snacks/ration/entree/assorted_salted_offal = 1,
		/obj/item/reagent_containers/food/snacks/ration/side/broth_tuna_rice = 1,
		/obj/item/reagent_containers/food/snacks/ration/side/trail_crackers = 1,
		/obj/item/reagent_containers/food/snacks/ration/snack/candied_pineapple_chunks = 1,
		/obj/item/reagent_containers/food/snacks/ration/bar/tropical_energy_bar = 1,
		//obj/item/reagent_containers/food/drinks/ration/pan_genezan_vodka_ration = 1,
		/obj/item/reagent_containers/food/drinks/ration/beverage_bag = 1
		)
	generate_items_inside(items_inside, src)

/obj/item/storage/ration/maple_pork_sausage_patty
	name = "maple pork sausage patty ration"
	desc = "Start your day with a satisfying breakfast featuring a maple-infused pork sausage patty and a variety of treats."

/obj/item/storage/ration/maple_pork_sausage_patty/PopulateContents()
	var/static/items_inside = list(
		/obj/item/reagent_containers/food/snacks/ration/entree/maple_pork_sausage_patty = 1,
		/obj/item/reagent_containers/food/snacks/ration/side/hash_brown_bacon = 1,
		/obj/item/reagent_containers/food/snacks/ration/side/granola_milk_blueberries = 1,
		/obj/item/reagent_containers/food/snacks/ration/side/maple_muffin = 1,
		/obj/item/reagent_containers/food/snacks/ration/snack/smoked_almonds = 1,
		//obj/item/reagent_containers/food/condiment/ration/maple_syrup = 1,
		/obj/item/reagent_containers/food/condiment/pack/grape_powder = 1,
		/obj/item/reagent_containers/food/drinks/ration/beverage_bag = 1
		)
	generate_items_inside(items_inside, src)

/obj/item/storage/ration/pepper_jack_beef_patty
	name = "jalapeno pepper jack beef patty ration"
	desc = "Experience a flavorful fusion of jalapeno, pepper jack cheese, and beef in this grilled beef patty ration."

/obj/item/storage/ration/pepper_jack_beef_patty/PopulateContents()
	var/static/items_inside = list(
		/obj/item/reagent_containers/food/snacks/ration/entree/pepper_jack_beef_patty = 1,
		/obj/item/reagent_containers/food/snacks/ration/side/au_gratin_potatoes = 1,
		/obj/item/reagent_containers/food/snacks/ration/side/jerky_wrap = 1,
		/obj/item/reagent_containers/food/snacks/ration/snack/chocolate_chunk_oatmeal_cookie = 1,
		/obj/item/reagent_containers/food/snacks/ration/snack/peanut_candies = 1,
		//obj/item/reagent_containers/food/condiment/ration/bacon_cheddar_cheese_spread = 1,
		//obj/item/reagent_containers/food/condiment/ration/orange_beverage_base_sugar_free = 1,
		/obj/item/reagent_containers/food/drinks/ration/beverage_bag = 1
		)
	generate_items_inside(items_inside, src)

/obj/item/storage/ration/beef_goulash
	name = "beef goulash ration"
	desc = "Delight in the rich flavors of beef goulash, accompanied by a selection of sides and a sweet treat."

/obj/item/storage/ration/beef_goulash/PopulateContents()
	var/static/items_inside = list(
		/obj/item/reagent_containers/food/snacks/ration/entree/beef_goulash = 1,
		/obj/item/reagent_containers/food/snacks/ration/side/applesauce_carb_enhanced = 1,
		/obj/item/reagent_containers/food/snacks/ration/side/white_bread_mini_loaf = 1,
		/obj/item/reagent_containers/food/snacks/ration/snack/strawberry_preserves = 1,
		/obj/item/reagent_containers/food/snacks/ration/snack/patriotic_sugar_cookies = 1,
		//obj/item/reagent_containers/food/condiment/ration/chunky_peanut_butter = 1,
		//obj/item/reagent_containers/food/condiment/ration/orange_beverage_powder = 1,
		/obj/item/reagent_containers/food/drinks/ration/beverage_bag = 1
		)
	generate_items_inside(items_inside, src)

/obj/item/storage/ration/pepperoni_pizza_slice
	name = "pepperoni pizza slice ration"
	desc = "Indulge in the classic taste of pepperoni pizza with this ration, complete with sides and a refreshing beverage."

/obj/item/storage/ration/pepperoni_pizza_slice/PopulateContents()
	var/static/items_inside = list(
		/obj/item/reagent_containers/food/snacks/ration/entree/pepperoni_pizza_slice = 1,
		/obj/item/reagent_containers/food/snacks/ration/side/apples_in_spiced_sauce = 1,
		/obj/item/reagent_containers/food/snacks/ration/side/vegan_crackers = 1,
		/obj/item/reagent_containers/food/snacks/ration/snack/oatmeal_cookie = 1,
		/obj/item/reagent_containers/food/condiment/pack/hot_cheese_spread = 1,
		/obj/item/reagent_containers/food/condiment/pack/lemonade_powder = 1,
		/obj/item/reagent_containers/food/drinks/ration/beverage_bag = 1
	)
	generate_items_inside(items_inside, src)

/obj/item/storage/ration/calamari_red_sauce
	name = "blackened calamari in red sauce ration"

/obj/item/storage/ration/macaroni_tomato_sauce
	name = "elbow macaroni in tomato sauce ration"

/obj/item/storage/ration/cheese_pizza_slice
	name = "cheese pizza slice ration"
