/obj/item/reagent_containers/food/snacks/ration
	name = "nutriment ration"
	desc = "standard issue ration"
	filling_color = "#664330"
	list_reagents = list(/datum/reagent/consumable/nutriment = 4)
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/nutriment/vitamin = 2)
	icon = 'icons/obj/food/ration.dmi'
	icon_state = "ration_side"
	in_container = TRUE
	reagent_flags = NONE
	spillable = FALSE
	w_class = WEIGHT_CLASS_SMALL
	volume = 50
	var/cookable = FALSE
	var/cooked = FALSE

/obj/item/reagent_containers/food/snacks/ration/Initialize(mapload)
	. = ..()
	update_overlays()

/obj/item/reagent_containers/food/snacks/ration/update_overlays()
	. = ..()
	var/mutable_appearance/ration_overlay
	if(icon_exists(icon, "[icon_state]_filling"))
		ration_overlay = mutable_appearance(icon, "[icon_state]_filling")
	else if(icon_exists(icon, "[initial(icon_state)]_filling"))
		ration_overlay = mutable_appearance(icon, "[initial(icon_state)]_filling")
	else
		return
	ration_overlay.color = filling_color
	add_overlay(ration_overlay)

/obj/item/reagent_containers/food/snacks/ration/proc/open_ration(mob/user)
	to_chat(user, "<span class='notice'>You tear open \the [src].</span>")
	playsound(user.loc, 'sound/effects/rip3.ogg', 50)
	reagents.flags |= OPENCONTAINER
	desc += "\nIt's been opened."
	update_overlays()

/obj/item/reagent_containers/food/snacks/ration/attack_self(mob/user)
	if(!is_drainable())
		icon_state = "[icon_state]_open"
		open_ration(user)
	return ..()

/obj/item/reagent_containers/food/snacks/ration/attack(mob/living/M, mob/user, def_zone)
	if (!is_drainable())
		to_chat(user, "<span class='warning'>The [src] is sealed shut!</span>")
		return 0
	return ..()

/obj/item/reagent_containers/food/snacks/ration/microwave_act(obj/machinery/microwave/Heater)
	if (cookable == FALSE)
		..()
	else if (cooked == TRUE)
		..()
	else
		name = "warm [initial(name)]"
		var/cooking_efficiency = 1
		if(istype(Heater))
			cooking_efficiency = Heater.efficiency
		if(length(bonus_reagents))
			for(var/r_id in bonus_reagents)
				var/amount = bonus_reagents[r_id] * cooking_efficiency
				if(ispath(r_id, /datum/reagent/consumable/nutriment))
					reagents.add_reagent(r_id, amount, tastes)
				else
					reagents.add_reagent(r_id, amount)
		cooked = TRUE

/obj/item/reagent_containers/food/snacks/ration/examine(mob/user)
	. = ..()
	if(cookable && !cooked)
		. += "<span class='notice'>It can be cooked in a microwave or warmed using a flameless ration heater.</span>"

/obj/item/reagent_containers/food/snacks/ration/entree
	icon_state = "ration_main"
	list_reagents = list(/datum/reagent/consumable/nutriment = 6)
	cookable = TRUE

/obj/item/reagent_containers/food/snacks/ration/side
	icon_state = "ration_side"
	list_reagents = list(/datum/reagent/consumable/nutriment = 4)

/obj/item/reagent_containers/food/snacks/ration/snack
	icon_state = "ration_snack"
	list_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/sugar = 3)

/obj/item/reagent_containers/food/snacks/ration/bar
	icon_state = "ration_bar"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/sugar = 2)

/obj/item/reagent_containers/food/snacks/ration/condiment
	name = "condiment pack"
	desc = "Just your average condiment pack."
	icon_state = "ration_condi"
	volume = 10
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list()

/obj/item/reagent_containers/food/snacks/ration/condiment/attack(mob/living/M, mob/user, def_zone)
	if (!is_drainable())
		to_chat(user, "<span class='warning'>[src] is sealed shut!</span>")
		return 0
	else
		to_chat(user, "<span class='warning'>[src] cant be eaten like that!</span>")
		return 0

/obj/item/reagent_containers/food/snacks/ration/condiment/afterattack(obj/target, mob/user , proximity)
	. = ..()
	if(!is_drainable())
		to_chat(user, "<span class='warning'>[src] is sealed shut!</span>")
		return
	if(!proximity)
		return
	//You can tear the bag open above food to put the condiments on it, obviously.
	if(istype(target, /obj/item/reagent_containers/food/snacks))
		if(target.reagents.total_volume >= target.reagents.maximum_volume)
			to_chat(user, "<span class='warning'>[target] is too full!</span>" )
			return
		else
			to_chat(user, "<span class='notice'>You tear open [src] above [target] and the condiments drip onto it.</span>")
			src.reagents.trans_to(target, amount_per_transfer_from_this, transfered_by = user)
			qdel(src)

/obj/item/reagent_containers/food/snacks/ration/pack
	name = "powder pack"
	desc = "Mix into a bottle of water and shake."
	icon_state = "ration_pack"
	volume = 10
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list()

/obj/item/reagent_containers/food/snacks/ration/pack/attack(mob/living/M, mob/user, def_zone)
	if (!is_drainable())
		to_chat(user, "<span class='warning'>[src] is sealed shut!</span>")
		return 0
	else
		to_chat(user, "<span class='warning'>[src] cant be eaten like that!</span>")
		return 0

/obj/item/reagent_containers/food/snacks/ration/pack/afterattack(obj/target, mob/user , proximity)
	. = ..()
	if(!is_drainable())
		to_chat(user, "<span class='warning'>[src] is sealed shut!</span>")
		return
	if(!proximity)
		return
	if(istype(target, /obj/item/reagent_containers))
		if(target.reagents.total_volume >= target.reagents.maximum_volume)
			to_chat(user, "<span class='warning'>[target] is too full!</span>" )
			return
		else
			to_chat(user, "<span class='notice'>You pour the [src] into [target] and shake.</span>")
			src.reagents.trans_to(target, amount_per_transfer_from_this, transfered_by = user)
			qdel(src)

/obj/item/reagent_containers/food/snacks/ration/entree/vegan_chili
	name = "vegan chili with beans"
	desc = "A hearty and flavorful vegan chili made with beans. It's so delicious, you won't believe it's not meat!"
	filling_color = "#B22222"
	tastes = list("beans" = 1, "off" = 1)
	foodtype = VEGETABLES

/obj/item/reagent_containers/food/snacks/ration/entree/shredded_beef
	name = "shredded beef in barbecue sauce"
	desc = "Tender, juicy shredded beef coated in smoky barbecue sauce. A savory treat that satisfies your hunger."
	filling_color = "#7a3c19"
	tastes = list("beef" = 1)
	foodtype = MEAT | SUGAR

/obj/item/reagent_containers/food/snacks/ration/entree/pork_spaghetti
	name = "spaghetti with pork and sauce"
	desc = "A hearty dish of spaghetti with tender pork and a savory sauce. A ration_overlay and delicious meal to satisfy your hunger."
	filling_color = "#b82121"
	tastes = list("pork" = 1, "spaghetti" = 1, "sauce" = 1)
	foodtype = MEAT | GRAIN | VEGETABLES

/obj/item/reagent_containers/food/snacks/ration/entree/fried_fish
	name = "fried fish chunks"
	desc = "Crispy and delicious fried fish chunks, perfect for seafood lovers. Satisfy your cravings with this delightful fried treat."
	filling_color = "#f08934"
	tastes = list("fish" = 1, "fried" = 1)
	foodtype = FRIED

/obj/item/reagent_containers/food/snacks/ration/entree/beef_strips
	name = "beef strips in tomato sauce"
	desc = "Tender beef strips cooked in a rich tomato sauce, creating a delightful and comforting combination. A hearty and delicious meal to enjoy."
	filling_color = "#644815"
	tastes = list("beef" = 1, "tomato" = 1)
	foodtype = MEAT | VEGETABLES

/obj/item/reagent_containers/food/snacks/ration/entree/chili_macaroni
	name = "chili macaroni"
	desc = "A comforting dish of macaroni combined with flavorful chili, providing a hearty and satisfying meal."
	filling_color = "#994d00"
	tastes = list("chili" = 1, "macaroni" = 1)
	foodtype = MEAT | GRAIN

/obj/item/reagent_containers/food/snacks/ration/entree/chicken_wings_hot_sauce
	name = "chicken wings with hot sauce"
	desc = "Crispy and flavorful chicken wings tossed in a spicy hot sauce, delivering a bold and satisfying taste."
	filling_color = "#ff3300"
	tastes = list("chicken" = 1, "hot sauce" = 1)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/ration/entree/fish_stew
	name = "fish stew"
	desc = "A hearty fish stew featuring a rich broth and tender pieces of fish, creating a flavorful and comforting meal."
	filling_color = "#336699"
	tastes = list("fish" = 1)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/ration/entree/lemon_pepper_chicken
	name = "lemon pepper chicken"
	desc = "Tender chicken seasoned with zesty lemon and fragrant pepper, offering a flavorful and satisfying dish."
	filling_color = "#ffff66"
	tastes = list("lemon" = 1, "pepper" = 1, "chicken" = 1)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/ration/entree/sausage_peppers_onions
	name = "sausage with peppers and onions"
	desc = "Grilled sausage served with sautéed peppers and onions, creating a flavorful and satisfying dish."
	filling_color = "#cc3300"
	tastes = list("sausage" = 1, "peppers" = 1, "onions" = 1)
	foodtype = MEAT | VEGETABLES

/obj/item/reagent_containers/food/snacks/ration/entree/dumplings_chili_sauce
	name = "dumplings with chili sauce"
	desc = "Delicious dumplings served with a flavorful chili sauce, providing a hearty and satisfying meal."
	filling_color = "#b8711b"
	tastes = list("dumplings" = 1, "chili sauce" = 1)
	foodtype = GRAIN | MEAT

/obj/item/reagent_containers/food/snacks/ration/entree/battered_fish_sticks
	name = "battered fish sticks"
	desc = "Crispy battered fish sticks, deep-fried to perfection and offering a delicious seafood snack."
	filling_color = "#336699"
	tastes = list("fish" = 1)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/ration/entree/assorted_salted_offal
	name = "assorted salted offal"
	desc = "A mix of various salted offal, providing a unique and flavorful snack for those with adventurous tastes."
	filling_color = "#cc3300"
	tastes = list("assorted offal" = 1)
	foodtype = MEAT | GORE //its literally entrails

/obj/item/reagent_containers/food/snacks/ration/entree/maple_pork_sausage_patty
	name = "maple pork sausage patty"
	desc = "Juicy pork sausage patty infused with the sweetness of maple, offering a hearty and flavorful snack."
	filling_color = "#b8711b"
	tastes = list("maple" = 1, "pork sausage" = 1)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/ration/entree/pepper_jack_beef_patty
	name = "jalapeno pepper jack beef patty"
	desc = "Spicy jalapeno and pepper jack-infused beef patty, offering a bold and flavorful snack option."
	filling_color = "#ff9900"
	tastes = list("jalapeno" = 1, "pepper jack" = 1, "beef patty" = 1)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/ration/entree/beef_goulash
	name = "beef goulash"
	desc = "A hearty and flavorful beef goulash, combining tender pieces of beef with savory spices for a satisfying meal."
	filling_color = "#b82121"
	tastes = list("beef" = 1)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/ration/entree/pepperoni_pizza_slice
	name = "pepperoni pizza slice"
	desc = "A classic pepperoni pizza slice topped with melted cheese and savory pepperoni, offering a delicious snack."
	filling_color = "#cc3300"
	tastes = list("pepperoni" = 1, "pizza" = 1)
	foodtype = GRAIN | DAIRY | MEAT

/obj/item/reagent_containers/food/snacks/ration/entree/blackened_calamari
	name = "blackened calamari"
	desc = "Tender calamari coated in a savory blackened seasoning, creating a flavorful and satisfying seafood dish."
	filling_color = "#336699"
	tastes = list("calamari" = 1)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/ration/entree/elbow_macaroni
	name = "elbow macaroni"
	desc = "A classic dish of elbow macaroni, offering a simple and satisfying meal."
	filling_color = "#ffcc00"
	tastes = list("macaroni" = 1)
	foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/ration/entree/cheese_pizza_slice
	name = "cheese pizza slice"
	desc = "A classic cheese pizza slice topped with melted cheese, offering a simple and satisfying snack."
	filling_color = "#ffcc00"
	tastes = list("cheese" = 1, "pizza" = 1)
	foodtype = GRAIN | DAIRY

/obj/item/reagent_containers/food/snacks/ration/side/vegan_crackers
	name = "vegetable 'crackers'"
	desc = "Delicious vegetable-based crackers that are the perfect crunchy and nutritious snack."
	filling_color = "#9ED41B"
	tastes = list("cracker" = 1)
	foodtype = VEGETABLES

/obj/item/reagent_containers/food/snacks/ration/side/vegan_crackers/open_ration(mob/user)
	.=..()
	to_chat(user, "<span class='notice'>\the [src] makes a nice hiss.</span>")

/obj/item/reagent_containers/food/snacks/ration/side/cornbread
	name = "cornbread"
	desc = "Deliciously crumbly cornbread, a delightful blend of sweet and savory flavors."
	filling_color = "#DDB63B"
	tastes = list("corn" = 1)
	foodtype = VEGETABLES | GRAIN

/obj/item/reagent_containers/food/snacks/ration/side/jerky_wrap
	name = "jerky wraps"
	desc = "Thin slices of flavorful beef jerky, carefully wrapped to create a portable and protein-packed snack. Ideal for satisfying your hunger on the go."
	filling_color = "#532d0e"
	tastes = list("dry" = 1, "jerky" = 1, "beef" = 1)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/ration/side/bread_sticks
	name = "seasoned bread sticks"
	desc = "Crunchy and flavorful seasoned bread sticks, a delightful accompaniment to your meal or a satisfying snack on their own."
	filling_color = "#e2904d"
	tastes = list("bread" = 1, "seasoned" = 1)
	foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/ration/side/tortilla
	name = "tortillas"
	desc = "Soft and pliable tortillas, a versatile staple that complements various fillings and flavors. A great choice for a quick and satisfying meal."
	filling_color = "#f3ac69"
	tastes = list("tortilla" = 1)
	foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/ration/side/wheat_bread
	name = "white wheat snack bread"
	desc = "Soft and fluffy white wheat snack bread, a versatile snack or accompaniment to your meals. Enjoy the wholesome goodness of wheat."
	filling_color = "#8d5a30"
	tastes = list("wheat" = 1, "bread" = 1)
	foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/ration/side/beef_sticks
	name = "teriyaki beef sticks"
	desc = "Savory teriyaki-flavored beef sticks, a protein-packed snack that satisfies your taste buds. Ideal for meat lovers."
	filling_color = "#664a20"
	tastes = list("beef" = 1, "teriyaki" = 1)
	foodtype = MEAT | SUGAR

/obj/item/reagent_containers/food/snacks/ration/side/garlic_mashed_potatoes
	name = "garlic mashed potatoes"
	desc = "Creamy mashed potatoes infused with aromatic garlic, creating a comforting and savory side dish."
	filling_color = "#e6e600"
	tastes = list("garlic" = 1, "potatoes" = 1)
	foodtype = GRAIN | VEGETABLES
	cookable = TRUE

/obj/item/reagent_containers/food/snacks/ration/side/soup_crackers
	name = "soup crackers"
	desc = "Crunchy and satisfying crackers, perfect for dipping into a warm bowl of soup or enjoying on their own."
	filling_color = "#663300"
	tastes = list("crackers" = 1)
	foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/ration/side/griddled_mushrooms_chili
	name = "griddled mushrooms with chili"
	desc = "Savory mushrooms griddled to perfection and topped with a spicy chili sauce, offering a delightful burst of flavors."
	filling_color = "#b82121"
	tastes = list("mushrooms" = 1, "chili" = 1)
	foodtype = VEGETABLES | MEAT
	cookable = TRUE

/obj/item/reagent_containers/food/snacks/ration/side/white_sandwich_bread
	name = "white sandwich bread"
	desc = "Soft and fluffy white bread, perfect for making sandwiches or enjoying as a quick and simple snack."
	filling_color = "#ffffff"
	tastes = list("bread" = 1)
	foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/ration/side/baked_cheddarcheese_chips
	name = "baked cheddar cheese chips"
	desc = "Crispy and savory cheddar cheese chips, baked to perfection for a flavorful and satisfying snack."
	filling_color = "#ffcc00"
	tastes = list("cheddar cheese" = 1, "chips" = 1)
	foodtype = DAIRY

/obj/item/reagent_containers/food/snacks/ration/side/fried_potato_curls
	name = "fried potato curls"
	desc = "Crispy and golden potato curls, fried to perfection and seasoned for a delightful and savory snack."
	filling_color = "#ffcc00"
	tastes = list("potato" = 1)
	foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/ration/side/stewed_asparagus_butter
	name = "stewed asparagus with butter"
	desc = "Tender stewed asparagus served with a generous drizzle of melted butter, creating a delightful and savory side."
	filling_color = "#99cc00"
	tastes = list("asparagus" = 1, "butter" = 1)
	foodtype = VEGETABLES
	cookable = TRUE

/obj/item/reagent_containers/food/snacks/ration/side/broth_tuna_rice
	name = "bone broth with tuna and rice"
	desc = "A warm and comforting broth with tender tuna and rice, offering a nourishing and satisfying meal."
	filling_color = "#669999"
	tastes = list("broth" = 1, "tuna" = 1, "rice" = 1)
	foodtype = MEAT | GRAIN
	cookable = TRUE

/obj/item/reagent_containers/food/snacks/ration/side/trail_crackers
	name = "trail crackers"
	desc = "Nutritious and energy-packed crackers, perfect for on-the-go snacking during outdoor adventures."
	filling_color = "#ffcc00"
	tastes = list("crackers" = 1)
	foodtype = GRAIN | FRUIT

/obj/item/reagent_containers/food/snacks/ration/side/hash_brown_bacon
	name = "hash brown potatoes with bacon, peppers and onions"
	desc = "Crispy hash brown paired with savory bacon, creating a satisfying and indulgent snack option."
	filling_color = "#ffcc00"
	tastes = list("hash brown" = 1, "bacon" = 1)
	foodtype = GRAIN | MEAT
	cookable = TRUE

/obj/item/reagent_containers/food/snacks/ration/side/granola_milk_blueberries
	name = "granola with milk and blueberries"
	desc = "Nutrient-rich granola served with creamy milk and plump blueberries, providing a wholesome and delicious snack."
	filling_color = "#6699ff"
	tastes = list("granola" = 1, "milk" = 1, "blueberries" = 1)
	foodtype = GRAIN | DAIRY

/obj/item/reagent_containers/food/snacks/ration/side/maple_muffin
	name = "maple muffin"
	desc = "A delightful muffin infused with the rich flavor of maple, offering a sweet and satisfying treat."
	filling_color = "#b8711b"
	tastes = list("maple" = 1, "muffin" = 1)
	foodtype = SUGAR | GRAIN

/obj/item/reagent_containers/food/snacks/ration/side/au_gratin_potatoes
	name = "au gratin potatoes"
	desc = "Creamy au gratin potatoes topped with a golden cheesy crust, providing a comforting and satisfying side dish."
	filling_color = "#ffcc00"
	tastes = list("au gratin potatoes" = 1)
	foodtype = GRAIN | DAIRY | VEGETABLES
	cookable = TRUE

/obj/item/reagent_containers/food/snacks/ration/side/applesauce_carb_enhanced
	name = "carb-enhanced applesauce"
	desc = "Applesauce enriched with carbohydrates, providing a quick and energy-boosting snack option."
	filling_color = "#ff9900"
	tastes = list("applesauce" = 1)
	foodtype = FRUIT | SUGAR

/obj/item/reagent_containers/food/snacks/ration/side/white_bread_mini_loaf
	name = "mini loaf of white bread"
	desc = "A small loaf of soft and fluffy white bread, perfect for making sandwiches or enjoying as a simple snack."
	filling_color = "#ffffff"
	tastes = list("bread" = 1)
	foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/ration/side/apples_in_spiced_sauce
	name = "apples in spiced sauce"
	desc = "Tender apple slices coated in a spiced sauce, creating a flavorful and comforting snack option."
	filling_color = "#ff3300"
	tastes = list("apples" = 1, "spiced sauce" = 1)
	foodtype = FRUIT

/obj/item/reagent_containers/food/snacks/ration/side/pretzel_sticks_honey_mustard
	name = "pretzel sticks with honey mustard"
	desc = "Crunchy pretzel sticks served with a delectable honey mustard dipping sauce, creating a delightful snack."
	filling_color = "#996633"
	tastes = list("pretzel" = 1, "honey mustard" = 1)
	foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/ration/side/jellied_eels
	name = "jellied eels"
	desc = "A classic dish of jellied eels, offering a unique combination of flavors and textures for a nostalgic treat."
	filling_color = "#669999"
	tastes = list("jellied eels" = 1)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/ration/side/trail_mix_beef_jerky
	name = "trail mix with beef jerky"
	desc = "A hearty trail mix featuring a blend of nuts, seeds, and dried fruit, with savory beef jerky for a protein-packed snack."
	filling_color = "#996633"
	tastes = list("trail mix" = 1, "beef jerky" = 1)
	foodtype = MEAT | FRUIT

/obj/item/reagent_containers/food/snacks/ration/side/crackers
	name = "crackers"
	desc = "Crunchy and satisfying crackers, perfect for dipping into a warm bowl of soup or enjoying on their own."
	filling_color = "#663300"
	tastes = list("crackers" = 1)
	foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/ration/side/barbecue_fried_pork_rinds
	name = "barbecue fried pork rinds"
	desc = "Crispy and flavorful fried pork rinds coated in a savory barbecue seasoning, creating a satisfying snack option."
	filling_color = "#b82121"
	tastes = list("pork rinds" = 1, "barbecue" = 1)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/ration/side/applesauce_mango_peach_puree
	name = "applesauce with mango and peach puree"
	desc = "A delightful blend of applesauce with mango and peach puree, creating a sweet and satisfying snack option."
	filling_color = "#ff9900"
	tastes = list("applesauce" = 1, "mango" = 1, "peach" = 1)
	foodtype = FRUIT | SUGAR

/obj/item/reagent_containers/food/snacks/ration/snack/pizza_crackers
	name = "pepperoni pizza cheese filled crackers"
	desc = "Irresistible cheese-filled crackers with a savory pepperoni pizza flavor. A delicious and addictive snack."
	filling_color = "#b82121"
	tastes = list("pizza" = 3, "pepperoni" = 1, "cheese" = 1)
	foodtype = MEAT | DAIRY | GRAIN | JUNKFOOD

/obj/item/reagent_containers/food/snacks/ration/snack/fruit_puree
	name = "apple, strawberry, and carrot fruit puree squeeze"
	desc = "A delightful blend of fresh apple, succulent strawberry, and nutritious carrot, all pureed into a convenient squeeze pouch. A burst of fruity goodness in every bite."
	filling_color = "#cc3131"
	tastes = list("apple" = 1, "strawberry" = 1, "carrot" = 1)
	foodtype = VEGETABLES | FRUIT | SUGAR

/obj/item/reagent_containers/food/snacks/ration/snack/cinnamon_bun
	name = "cinnamon bun"
	desc = "A delectable pastry swirled with cinnamon and drizzled with a sweet glaze. Warm and fluffy, this cinnamon bun is a delightful treat to enjoy with your favorite beverage."
	filling_color = "#b18d40"
	tastes = list("cinnamon" = 3, "airy" = 1, "sweet" = 1)
	foodtype = GRAIN | SUGAR

/obj/item/reagent_containers/food/snacks/ration/snack/toaster_pastry
	name = "chocolate chip toaster pastry"
	desc = "A delicious chocolate chip toaster pastry, perfect for a quick breakfast or a tasty snack. Indulge in the delightful blend of chocolate and pastry."
	filling_color = "#e2a054"
	tastes = list("chocolate" = 1, "pastry" = 1, "sweet" = 1)
	foodtype = SUGAR | GRAIN | JUNKFOOD | BREAKFAST
	cookable = TRUE

/obj/item/reagent_containers/food/snacks/ration/snack/dried_raisins
	name = "dried raisins"
	desc = "Sweet and chewy dried raisins, a natural and healthy snack option. Packed with natural sugars and nutrients for a burst of energy."
	filling_color = "#1b1146"
	tastes = list("raisins" = 1, "sweet" = 1)
	foodtype = FRUIT | SUGAR

/obj/item/reagent_containers/food/snacks/ration/snack/corn_kernels
	name = "toasted corn kernels, barbecue"
	desc = "Toasted corn kernels with a savory barbecue flavor. A crunchy and flavorful snack to enjoy anytime."
	filling_color = "#836b1d"
	tastes = list("corn" = 1, "barbecue" = 1)
	foodtype = SUGAR | VEGETABLES | JUNKFOOD

/obj/item/reagent_containers/food/snacks/ration/snack/chocolate_pudding
	name = "chocolate pudding"
	desc = "Creamy and decadent chocolate pudding, a delightful dessert to indulge your sweet tooth."
	filling_color = "#3b2406"
	tastes = list("chocolate" = 3, "pudding" = 1, "sweet" = 1)
	foodtype = SUGAR | JUNKFOOD

/obj/item/reagent_containers/food/snacks/ration/snack/blackberry_preserves
	name = "blackberry preserves"
	desc = "Sweet and tangy blackberry preserves, perfect for spreading on toast or pairing with your favorite snacks."
	filling_color = "#26133b"
	tastes = list("blackberry" = 1, "sweet" = 1)
	foodtype = FRUIT

/obj/item/reagent_containers/food/snacks/ration/snack/candy_rings
	name = "peppermint candy rings"
	desc = "Colorful and refreshing peppermint candy rings, a sweet and delightful treat that brings a burst of coolness to your taste buds."
	filling_color = "#ecafaf"
	tastes = list("peppermint" = 3, "sweet" = 1)
	foodtype = SUGAR | JUNKFOOD

/obj/item/reagent_containers/food/snacks/ration/snack/lemon_pound_cake
	name = "lemon pound cake"
	desc = "A zesty and moist lemon pound cake that delivers a burst of citrus flavor in every bite. A delightful dessert to enjoy."
	filling_color = "#ffff99"
	tastes = list("lemon" = 1, "cake" = 1)
	foodtype = SUGAR

/obj/item/reagent_containers/food/snacks/ration/snack/cherry_snackers
	name = "cherry snackers"
	desc = "Juicy and plump cherries, perfectly preserved and packed for a delightful and refreshing snack."
	filling_color = "#ff0066"
	tastes = list("cherry" = 1)
	foodtype = FRUIT

/obj/item/reagent_containers/food/snacks/ration/snack/mint_chocolate_snack_cake
	name = "mint chocolate snack cake"
	desc = "A delectable snack cake featuring the perfect blend of refreshing mint and rich chocolate flavors."
	filling_color = "#00cc66"
	tastes = list("mint" = 1, "chocolate" = 1, "cake" = 1)
	foodtype = SUGAR

/obj/item/reagent_containers/food/snacks/ration/snack/strawberry_preserves
	name = "strawberry preserves"
	desc = "Sweet and luscious strawberry preserves, perfect for spreading on bread or enjoying as a tasty topping."
	filling_color = "#ff3300"
	tastes = list("strawberry" = 1)
	foodtype = SUGAR | FRUIT

/obj/item/reagent_containers/food/snacks/ration/snack/sour_gummy_worms
	name = "sour gummy worms"
	desc = "Tangy and chewy gummy worms coated in a sour sugar blend, providing a fun and flavorful snacking experience."
	filling_color = "#ff9900"
	tastes = list("sour" = 1, "gummy" = 1)
	foodtype = SUGAR

/obj/item/reagent_containers/food/snacks/ration/snack/blue_raspberry_candies
	name = "blue raspberry candies"
	desc = "Sweet and vibrant blue raspberry-flavored candies, perfect for indulging your sweet tooth."
	filling_color = "#3399ff"
	tastes = list("blue raspberry" = 1)
	foodtype = SUGAR

/obj/item/reagent_containers/food/snacks/ration/snack/peanut_cranberry_mix
	name = "peanut cranberry mix"
	desc = "A satisfying mix of crunchy peanuts and tangy dried cranberries, offering a balanced and flavorful snack."
	filling_color = "#cc3300"
	tastes = list("peanut" = 1, "cranberry" = 1)
	foodtype = FRUIT

/obj/item/reagent_containers/food/snacks/ration/snack/channeler_meat_candy
	name = "channeler meat candy"
	desc = "A traditional meat-candy from the Antechannel League on Kalixcis, offering an unusual and captivating flavor experience."
	filling_color = "#9933ff"
	tastes = list("channeler meat" = 1, "candy" = 1)
	foodtype = MEAT | SUGAR

/obj/item/reagent_containers/food/snacks/ration/snack/chocolate_orange_snack_cake
	name = "chocolate orange snack cake"
	desc = "A delightful snack cake combining rich chocolate and zesty orange flavors for a mouthwatering treat."
	filling_color = "#ff6600"
	tastes = list("chocolate" = 1, "orange" = 1, "cake" = 1)
	foodtype = SUGAR

/obj/item/reagent_containers/food/snacks/ration/snack/pick_me_up_energy_gum
	name = "Pick-Me-Up energy gum"
	desc = "Energy-boosting gum that provides a quick and refreshing burst of vitality when you need it the most."
	filling_color = "#00cc66"
	tastes = list("energy gum" = 1)
	foodtype = SUGAR

/obj/item/reagent_containers/food/snacks/ration/snack/apple_slices
	name = "apple slices"
	desc = "Fresh and crisp apple slices, perfect for a refreshing and healthy snack option."
	filling_color = "#ff3300"
	tastes = list("apple" = 1)
	foodtype = FRUIT

/obj/item/reagent_containers/food/snacks/ration/snack/candied_pineapple_chunks
	name = "candied pineapple chunks"
	desc = "Sweet and chewy candied pineapple chunks, offering a burst of tropical flavor in every bite."
	filling_color = "#ff6600"
	tastes = list("candied pineapple" = 1)
	foodtype = SUGAR | FRUIT

/obj/item/reagent_containers/food/snacks/ration/snack/smoked_almonds
	name = "smoked almonds"
	desc = "Savory smoked almonds, offering a flavorful and protein-packed snack option."
	filling_color = "#663300"
	tastes = list("smoked almonds" = 1)
	foodtype = FRUIT

/obj/item/reagent_containers/food/snacks/ration/snack/chocolate_chunk_oatmeal_cookie
	name = "chocolate chunk oatmeal cookie"
	desc = "A scrumptious oatmeal cookie studded with rich chocolate chunks for a delightful and indulgent treat."
	filling_color = "#663300"
	tastes = list("chocolate" = 1, "oatmeal cookie" = 1)
	foodtype = SUGAR | GRAIN

/obj/item/reagent_containers/food/snacks/ration/snack/peanut_candies
	name = "peanut candies"
	desc = "Sweet and nutty peanut candies, providing a delightful and energy-boosting snack."
	filling_color = "#ff9900"
	tastes = list("peanut" = 1)
	foodtype = SUGAR | FRUIT

/obj/item/reagent_containers/food/snacks/ration/snack/patriotic_sugar_cookies
	name = "patriotic sugar cookies"
	desc = "Colorful sugar cookies with patriotic designs, providing a festive and sweet treat for special occasions."
	filling_color = "#ffcc00"
	tastes = list("sugar cookies" = 1)
	foodtype = SUGAR

/obj/item/reagent_containers/food/snacks/ration/snack/oatmeal_cookie
	name = "oatmeal cookie"
	desc = "A delicious oatmeal cookie, offering a wholesome and satisfying treat for any time of day."
	filling_color = "#663300"
	tastes = list("oatmeal cookie" = 1)
	foodtype = SUGAR | GRAIN

/obj/item/reagent_containers/food/snacks/ration/snack/dried_cranberries
	name = "dried cranberries"
	desc = "Tangy and chewy dried cranberries, a healthy and nutritious snack option."
	filling_color = "#cc3300"
	tastes = list("cranberries" = 1)
	foodtype = FRUIT

/obj/item/reagent_containers/food/snacks/ration/snack/dry_roasted_peanuts
	name = "dry roasted peanuts"
	desc = "Crunchy and flavorful dry roasted peanuts, a satisfying and protein-packed snack option."
	filling_color = "#663300"
	tastes = list("peanuts" = 1)
	foodtype = FRUIT

/obj/item/reagent_containers/food/snacks/ration/snack/jalapeno_cashews
	name = "jalapeno cashews"
	desc = "Savory cashews coated in a spicy jalapeno seasoning, creating a flavorful and satisfying snack option."
	filling_color = "#663300"
	tastes = list("jalapeno" = 1, "cashews" = 1)
	foodtype = FRUIT

/obj/item/reagent_containers/food/snacks/ration/bar/energy_bar
	name = "quik-energy bar, apple-cinnamon"
	desc = "A power-packed quik-energy bar infused with the flavors of apple and cinnamon. Ideal for a quick energy boost on the go."
	filling_color = "#ee3e1f"
	tastes = list("apple" = 1, "cinnamon" = 1)
	foodtype = FRUIT | GRAIN

/obj/item/reagent_containers/food/snacks/ration/bar/tropical_energy_bar
	name = "tropical energy bar"
	desc = "An energy-boosting bar packed with tropical flavors and essential nutrients for sustained vitality."
	filling_color = "#ff9900"
	tastes = list("tropical" = 1, "energy bar" = 1)
	foodtype = SUGAR | FRUIT

/obj/item/reagent_containers/food/snacks/ration/bar/rationers_guild_chocolate_bar
	name = "Rationer's Guild chocolate bar"
	desc = "A chocolate bar made by the Rationer's Guild, offering a rich and indulgent treat for a quick pick-me-up."
	filling_color = "#663300"
	tastes = list("chocolate" = 1)
	foodtype = SUGAR

/obj/item/reagent_containers/food/snacks/ration/bar/quik_energy_bar_chocolate
	name = "quik-energy bar chocolate"
	desc = "A power-packed quik-energy bar infused with the rich flavor of chocolate. Ideal for a quick energy boost on the go."
	filling_color = "#663300"
	tastes = list("chocolate" = 1)
	foodtype = SUGAR

/obj/item/reagent_containers/food/snacks/ration/condiment/cheese_spread
	name = "cheese spread pack"
	filling_color = "#ffcc00"
	list_reagents = list(/datum/reagent/consumable/cheese_spread = 8)

/obj/item/reagent_containers/food/snacks/ration/condiment/hot_cheese_spread
	name = "jalapeno cheddar cheese spread pack"
	filling_color = "#ffaa00"
	list_reagents = list(/datum/reagent/consumable/cheese_spread = 5 , /datum/reagent/consumable/capsaicin = 3)

/obj/item/reagent_containers/food/snacks/ration/condiment/garlic_cheese_spread
	name = "garlic parmesan cheese spread pack"
	filling_color = "#ffff00"
	list_reagents = list(/datum/reagent/consumable/cheese_spread = 8)

/obj/item/reagent_containers/food/snacks/ration/condiment/bacon_cheddar_cheese_spread
	name = "bacon cheddar cheese spread pack"
	filling_color = "#ff9900"
	list_reagents = list(/datum/reagent/consumable/cheese_spread = 8)

/obj/item/reagent_containers/food/snacks/ration/condiment/peanut_butter
	name = "peanut butter pack"
	filling_color = "#664400"
	list_reagents = list(/datum/reagent/consumable/sugar = 5, /datum/reagent/consumable/peanut_butter = 5)

/obj/item/reagent_containers/food/snacks/ration/condiment/chunky_peanut_butter
	name = "chunky peanut butter pack"
	filling_color = "#663300"
	list_reagents = list(/datum/reagent/consumable/peanut_butter = 10)

/obj/item/reagent_containers/food/snacks/ration/condiment/maple_syrup
	name = "maple syrup pack"
	filling_color = "#661100"
	list_reagents = list(/datum/reagent/consumable/sugar = 10)

/obj/item/reagent_containers/food/snacks/ration/pack/chocolate_protein_beverage
	name = "chocolate hazelnut protein drink powder pack"
	filling_color = "#664400"
	list_reagents = list(/datum/reagent/consumable/coco = 5, /datum/reagent/consumable/eggyolk = 5)

/obj/item/reagent_containers/food/snacks/ration/pack/fruit_beverage
	name = "fruit punch beverage powder, carb-electrolyte pack"
	filling_color = "#ff4400"
	list_reagents = list(/datum/reagent/consumable/sugar = 5, /datum/reagent/consumable/applejuice = 2, /datum/reagent/consumable/orangejuice = 2)

/obj/item/reagent_containers/food/snacks/ration/pack/fruit_smoothie_beverage
	name = "tropical blend fruit and vegetable smoothie powder pack"
	filling_color = "#ffaa00"
	list_reagents = list(/datum/reagent/consumable/pineapplejuice = 3, /datum/reagent/consumable/orangejuice = 3, /datum/reagent/consumable/eggyolk = 3)

/obj/item/reagent_containers/food/snacks/ration/pack/grape_beverage
	name = "grape beverage powder, carb-fortified pack"
	filling_color = "#9900ff"
	list_reagents = list(/datum/reagent/consumable/sugar = 5, /datum/reagent/consumable/grapejuice = 5)

/obj/item/reagent_containers/food/snacks/ration/pack/grape_beverage_sugar_free
	name = "sugar-free grape beverage base powder"
	filling_color = "#9900ff"
	list_reagents = list(/datum/reagent/consumable/grapejuice = 10)

/obj/item/reagent_containers/food/snacks/ration/pack/lemonade_beverage
	name = "lemonade drink powder pack"
	filling_color = "#ffff80"
	list_reagents = list(/datum/reagent/consumable/sugar = 5, /datum/reagent/consumable/lemonjuice = 5)

/obj/item/reagent_containers/food/snacks/ration/pack/lemonade_beverage_suger_free
	name = "lemonade sugar-free beverage base pack"
	filling_color = "#ffff00"
	list_reagents = list(/datum/reagent/consumable/lemonjuice = 10)

/obj/item/reagent_containers/food/snacks/ration/pack/orange_beverage
	name = "orange beverage powder, carb-fortified pack"
	filling_color = "#ffbb00"
	list_reagents = list(/datum/reagent/consumable/sugar = 5, /datum/reagent/consumable/orangejuice = 5)

/obj/item/reagent_containers/food/snacks/ration/pack/orange_beverage_sugar_free
	name = "orange beverage base, sugar-free pack"
	filling_color = "#ff9900"
	list_reagents = list(/datum/reagent/consumable/orangejuice = 10)

/obj/item/reagent_containers/food/snacks/ration/pack/cherry_beverage
	name = "cherry high-energy beverage powder pack"
	filling_color = "#ff5555"
	list_reagents = list(/datum/reagent/consumable/sugar = 5, /datum/reagent/consumable/cherryjelly = 5)

/obj/item/reagent_containers/food/snacks/ration/pack/pineapple_beverage
	name = "pinapple fruit beverage base pack"
	filling_color = "#fff111"
	list_reagents = list(/datum/reagent/consumable/pineapplejuice = 10)

/obj/item/reagent_containers/food/snacks/ration/pack/freeze_dried_coffee_orange
	name = "freeze-dried coffee flavored with orange pack"
	filling_color = "#cc7400"
	list_reagents = list(/datum/reagent/consumable/coffee = 5, /datum/reagent/consumable/orangejuice = 3)

/obj/item/reagent_containers/food/snacks/ration/pack/freeze_dried_coffee_chocolate
	name = "freeze-dried coffee flavored with chocolate pack"
	filling_color = "#803300"
	list_reagents = list(/datum/reagent/consumable/coffee = 5, /datum/reagent/consumable/coco = 3)

/obj/item/reagent_containers/food/snacks/ration/pack/freeze_dried_coffee_hazelnut
	name = "freeze-dried coffee flavored with hazelnut pack"
	filling_color = "#553300"
	list_reagents = list(/datum/reagent/consumable/coffee = 5, /datum/reagent/consumable/coco = 3)
