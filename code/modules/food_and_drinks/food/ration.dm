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

/obj/item/reagent_containers/food/snacks/ration/examine_more(mob/user)
	. = ..()
	var/list/tags = bitfield_to_list(foodtype, FOOD_FLAGS_IC)
	. += span_notice("This ration pack contains the following food groups:")
	for(var/tag in tags)
		. += " - [tag]"

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
	to_chat(user, span_notice("You tear open \the [src]."))
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
		to_chat(user, span_warning("The [src] is sealed shut!"))
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
		. += span_notice("It can be cooked in a microwave or warmed using a flameless ration heater.")

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
		to_chat(user, span_warning("[src] is sealed shut!"))
		return 0
	else
		to_chat(user, span_warning("[src] cant be eaten like that!"))
		return 0

/obj/item/reagent_containers/food/snacks/ration/condiment/afterattack(obj/target, mob/user , proximity)
	. = ..()
	if(!is_drainable())
		to_chat(user, span_warning("[src] is sealed shut!"))
		return
	if(!proximity)
		return
	//You can tear the bag open above food to put the condiments on it, obviously.
	if(istype(target, /obj/item/reagent_containers/food/snacks))
		if(target.reagents.total_volume >= target.reagents.maximum_volume)
			to_chat(user, span_warning("[target] is too full!") )
			return
		else
			to_chat(user, span_notice("You tear open [src] above [target] and the condiments drip onto it."))
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
		to_chat(user, span_warning("[src] is sealed shut!"))
		return 0
	else
		to_chat(user, span_warning("[src] cant be eaten like that!"))
		return 0

/obj/item/reagent_containers/food/snacks/ration/pack/afterattack(obj/target, mob/user , proximity)
	. = ..()
	if(!is_drainable())
		to_chat(user, span_warning("[src] is sealed shut!"))
		return
	if(!proximity)
		return
	if(istype(target, /obj/item/reagent_containers))
		if(target.reagents.total_volume >= target.reagents.maximum_volume)
			to_chat(user, span_warning("[target] is too full!") )
			return
		else
			to_chat(user, span_notice("You pour the [src] into [target] and shake."))
			src.reagents.trans_to(target, amount_per_transfer_from_this, transfered_by = user)
			qdel(src)

/obj/item/reagent_containers/food/snacks/ration/entree/vegan_chili
	name = "vegan chili with beans"
	desc = "A vegan chili made with shelf-stable beans, onions, and peppers of a mushy consistency."
	filling_color = "#B22222"
	tastes = list("mushy beans" = 1, "soft onions" = 1)
	foodtype = VEGETABLES

/obj/item/reagent_containers/food/snacks/ration/entree/shredded_beef
	name = "shredded beef in barbecue sauce"
	desc = "Stiff shredded beef, coated in a watery barbecue sauce. It's very filling, and the flavor lingers in your mouth."
	filling_color = "#7a3c19"
	tastes = list("tough beef" = 1, "barbeque aftertaste" = 1)
	foodtype = MEAT | SUGAR

/obj/item/reagent_containers/food/snacks/ration/entree/pork_spaghetti
	name = "spaghetti with pork and marinara sauce"
	desc = "A watery dish of reconstituted spaghetti with ground pork and marinara sauce."
	filling_color = "#b82121"
	tastes = list("pork" = 1, "soft spaghetti" = 1, "thin tomato sauce" = 1)
	foodtype = MEAT | GRAIN | VEGETABLES

/obj/item/reagent_containers/food/snacks/ration/entree/fried_fish
	name = "fried fish chunks"
	desc = "Breaded, fried chunks of fish. While crisp at one point, the breading has gone soft after some time."
	filling_color = "#f08934"
	tastes = list("warm fish" = 1, "soggy breading" = 1)
	foodtype = FRIED

/obj/item/reagent_containers/food/snacks/ration/entree/beef_strips
	name = "beef strips in tomato sauce"
	desc = "Strips of lean beef cooked in a tomato-based sauce, served at a chili-esque consistency."
	filling_color = "#644815"
	tastes = list("lean beef" = 1, "heavily spiced tomato" = 1)
	foodtype = MEAT | VEGETABLES

/obj/item/reagent_containers/food/snacks/ration/entree/chili_macaroni
	name = "chili macaroni"
	desc = "A bag of shelf-stable macaroni, served in chili."
	filling_color = "#994d00"
	tastes = list("mild chili" = 1, "soggy macaroni" = 1)
	foodtype = MEAT | GRAIN

/obj/item/reagent_containers/food/snacks/ration/entree/chicken_wings_hot_sauce
	name = "chicken wings with hot sauce"
	desc = "Chicken wings and thighs, coated in a hot sauce. The chicken is a bit tough."
	filling_color = "#ff3300"
	tastes = list("tough chicken" = 1, "thin hot sauce" = 1)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/ration/entree/fish_stew
	name = "fish stew"
	desc = "A ration pack of fish stew, with thickened broth and chunks of fish."
	filling_color = "#336699"
	tastes = list("fish" = 1, "gritty broth" = 1)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/ration/entree/lemon_pepper_chicken
	name = "lemon pepper chicken"
	desc = "A hunk of chicken, cooked and seasoned with lemon flavoring and ground pepper."
	filling_color = "#ffff66"
	tastes = list("lemon flavoring" = 1, "pepper" = 1, "chicken" = 1)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/ration/entree/sausage_peppers_onions
	name = "sausage with peppers and onions"
	desc = "Cubes of sausage, served with sautéed peppers and onions, mushy after being prepared."
	filling_color = "#cc3300"
	tastes = list("sausage" = 1, "soft peppers" = 1, "mushy onions" = 1)
	foodtype = MEAT | VEGETABLES

/obj/item/reagent_containers/food/snacks/ration/entree/dumplings_chili_sauce
	name = "dumplings with chili sauce"
	desc = "Small buckwheat dumplings, served in a heavily flavored chili sauce."
	filling_color = "#b8711b"
	tastes = list("heavy dumplings" = 1, "overspiced chili sauce" = 1)
	foodtype = GRAIN | MEAT

/obj/item/reagent_containers/food/snacks/ration/entree/battered_fish_sticks
	name = "battered fish sticks"
	desc = "Battered fish sticks, deep-fried before being dehydrated."
	filling_color = "#336699"
	tastes = list("dry fish" = 1, "breading" = 2)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/ration/entree/assorted_salted_offal
	name = "assorted salted offal"
	desc = "A ration pack filled with various slabs of offal, salted heavily."
	filling_color = "#cc3300"
	tastes = list("assorted offal" = 1, "salt" = 1)
	foodtype = MEAT | GORE //its literally entrails

/obj/item/reagent_containers/food/snacks/ration/entree/maple_pork_sausage_patty
	name = "maple pork sausage patty"
	desc = "A pork sausage puck flavored with a maple-based syrup. It's cloyingly sweet."
	filling_color = "#b8711b"
	tastes = list("maple" = 2, "pork sausage" = 1)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/ration/entree/pepper_jack_beef_patty
	name = "jalapeno pepper jack beef patty"
	desc = "A jalapeno and pepper jack-smothered beef puck with a layer of cheap cheese."
	filling_color = "#ff9900"
	tastes = list("mild jalapeno" = 1, "pepper jack" = 1, "beef patty" = 1)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/ration/entree/beef_goulash
	name = "beef goulash"
	desc = "A hearty and flavorful beef goulash, combining tender pieces of beef with savory spices for a satisfying meal."
	filling_color = "#b82121"
	tastes = list("beef" = 1)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/ration/entree/pepperoni_pizza_slice
	name = "pepperoni pizza slice"
	desc = "A small pizza slice topped with surprisingly high quality melted cheese and pepperoni. It's kept its own consistency and flavor."
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
	desc = "A packet of plain elbow macaroni. It's your decision to mix it with something or eat it straight."
	filling_color = "#ffcc00"
	tastes = list("soft macaroni" = 1)
	foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/ration/entree/cheese_pizza_slice
	name = "cheese pizza slice"
	desc = "A small pizza slice, topped with melted cheese. It lacks the pepperoni of its better-liked cousin."
	filling_color = "#ffcc00"
	tastes = list("cheese" = 1, "pizza" = 1)
	foodtype = GRAIN | DAIRY

/obj/item/reagent_containers/food/snacks/ration/side/vegan_crackers
	name = "vegetable 'crackers'"
	desc = "Vegetable-based, dry crackers. A couple are broken to pieces."
	filling_color = "#9ED41B"
	tastes = list("tough cracker" = 1)
	foodtype = VEGETABLES

/obj/item/reagent_containers/food/snacks/ration/side/vegan_crackers/open_ration(mob/user)
	.=..()
	to_chat(user, span_notice("\the [src] makes a nice hiss."))

/obj/item/reagent_containers/food/snacks/ration/side/cornbread
	name = "cornbread"
	desc = "Crumbly cornbread, which has since been flattened and dried in the package."
	filling_color = "#DDB63B"
	tastes = list("dry cornbread" = 1)
	foodtype = VEGETABLES | GRAIN

/obj/item/reagent_containers/food/snacks/ration/side/jerky_wrap
	name = "jerky wraps"
	desc = "Thin slices of beef-based, heavily-spiced jerky, not too disimilar to convenience store brands."
	filling_color = "#532d0e"
	tastes = list("thick spices" = 1, "tough, chewy beef" = 1)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/ration/side/bread_sticks
	name = "seasoned bread sticks"
	desc = "Crunchy, seasoned bread sticks, often softened with being dipped in the entree."
	filling_color = "#e2904d"
	tastes = list("dry bread" = 1, "mild seasonings" = 1)
	foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/ration/side/tortilla
	name = "tortillas"
	desc = "Flour tortillas, a versatile staple that complements various fillings and flavors. A great choice for a quick meal."
	filling_color = "#f3ac69"
	tastes = list("tortilla" = 1)
	foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/ration/side/wheat_bread
	name = "white wheat snack bread"
	desc = "A dense rectangle of white bread, with perforation lines for you to tear along. You'll want to serve it with something else."
	filling_color = "#8d5a30"
	tastes = list("dense bread" = 1)
	foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/ration/side/beef_sticks
	name = "teriyaki beef sticks"
	desc = "Beef sticks, coated in a teriyaki-based flavoring. The flavoring coats the interior of the packet it's served in."
	filling_color = "#664a20"
	tastes = list("beef" = 1, "powdery teriyaki" = 1)
	foodtype = MEAT | SUGAR

/obj/item/reagent_containers/food/snacks/ration/side/garlic_mashed_potatoes
	name = "garlic mashed potatoes"
	desc = "Silty mashed potatoes, mixed with garlic flavoring."
	filling_color = "#e6e600"
	tastes = list("garlic powder" = 1, "silty potatoes" = 1)
	foodtype = GRAIN | VEGETABLES
	cookable = TRUE

/obj/item/reagent_containers/food/snacks/ration/side/soup_crackers
	name = "soup crackers"
	desc = "Dry, hard soda crackers for dipping in an entree."
	filling_color = "#663300"
	tastes = list("crackers" = 1)
	foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/ration/side/griddled_mushrooms_chili
	name = "griddled mushrooms with chili"
	desc = "Little pieces of grilled mushrooms mixed in a very mild chili. It's closer to being chili with mushrooms in it than vice versa."
	filling_color = "#b82121"
	tastes = list("mushrooms" = 1, "chili" = 2)
	foodtype = VEGETABLES | MEAT
	cookable = TRUE

/obj/item/reagent_containers/food/snacks/ration/side/white_sandwich_bread
	name = "white sandwich bread"
	desc = "Small white bread slabs, intended to be made into sandwiches or have a spread placed across them."
	filling_color = "#ffffff"
	tastes = list("bread" = 1)
	foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/ration/side/baked_cheddarcheese_chips
	name = "baked cheddar cheese chips"
	desc = "A small packet of thin cheddar cheese chips, some gone soft."
	filling_color = "#ffcc00"
	tastes = list("artificial cheddar cheese" = 1, "chips" = 1)
	foodtype = DAIRY

/obj/item/reagent_containers/food/snacks/ration/side/fried_potato_curls
	name = "fried potato curls"
	desc = "A packet of fried potato curls, coated in salt and sealed."
	filling_color = "#ffcc00"
	tastes = list("potato" = 1)
	foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/ration/side/stewed_asparagus_butter
	name = "stewed asparagus with butter"
	desc = "Stewed asparagus served with melted butter, of a soft consistency."
	filling_color = "#99cc00"
	tastes = list("soft asparagus" = 1, "butter" = 1)
	foodtype = VEGETABLES
	cookable = TRUE

/obj/item/reagent_containers/food/snacks/ration/side/broth_tuna_rice
	name = "bone broth with tuna and rice"
	desc = "A watery broth with pieces of tuna and a helping of rice."
	filling_color = "#669999"
	tastes = list("watery broth" = 2, "tuna" = 1, "rice" = 1)
	foodtype = MEAT | GRAIN
	cookable = TRUE

/obj/item/reagent_containers/food/snacks/ration/side/trail_crackers
	name = "trail crackers"
	desc = "Crackers baked with dried fruit and seeds, tough to chew."
	filling_color = "#ffcc00"
	tastes = list("tough crackers" = 1, "fruit raisins" = 1)
	foodtype = GRAIN | FRUIT

/obj/item/reagent_containers/food/snacks/ration/side/hash_brown_bacon
	name = "hash brown potatoes with bacon, peppers and onions"
	desc = "Dry hash browns paired with equally dry strips of bacon, salted heavily."
	filling_color = "#ffcc00"
	tastes = list("stiff hash brown" = 1, "crumbly bacon" = 1)
	foodtype = GRAIN | MEAT | VEGETABLES
	cookable = TRUE

/obj/item/reagent_containers/food/snacks/ration/side/granola_milk_blueberries
	name = "granola with milk and blueberries"
	desc = "Dense granola served with milk powder and blueberry raisins."
	filling_color = "#6699ff"
	tastes = list("granola" = 1, "milk powder" = 1, "blueberry raisins" = 1)
	foodtype = GRAIN | DAIRY

/obj/item/reagent_containers/food/snacks/ration/side/maple_muffin
	name = "maple muffin"
	desc = "A shelf-stable, maple-flavored muffin."
	filling_color = "#b8711b"
	tastes = list("maple" = 1, "tough muffin" = 1)
	foodtype = SUGAR | GRAIN

/obj/item/reagent_containers/food/snacks/ration/side/au_gratin_potatoes
	name = "au gratin potatoes"
	desc = "A shallow bowl of au gratin potatoes with a crust of melted cheese."
	filling_color = "#ffcc00"
	tastes = list("potatoes" = 1, "thick cheeses" = 1)
	foodtype = GRAIN | DAIRY | VEGETABLES
	cookable = TRUE

/obj/item/reagent_containers/food/snacks/ration/side/applesauce_carb_enhanced
	name = "carb-enhanced applesauce"
	desc = "A grainy, starchy applesauce, reinforced with carbohydrates to keep the consumer going."
	filling_color = "#ff9900"
	tastes = list("starchy applesauce" = 1)
	foodtype = FRUIT | SUGAR

/obj/item/reagent_containers/food/snacks/ration/side/white_bread_mini_loaf
	name = "mini loaf of white bread"
	desc = "A miniature loaf of dense, compressed white bread with perforation lines for you to tear along."
	filling_color = "#ffffff"
	tastes = list("bread" = 1)
	foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/ration/side/apples_in_spiced_sauce
	name = "apples in spiced sauce"
	desc = "Mushy apple slices in a spiced sauce."
	filling_color = "#ff3300"
	tastes = list("mushy apples" = 1, "cinnamon-esque sauce" = 1)
	foodtype = FRUIT

/obj/item/reagent_containers/food/snacks/ration/side/pretzel_sticks_honey_mustard
	name = "pretzel sticks with honey mustard"
	desc = "Pretzel sticks served with packet of honey mustard sauce."
	filling_color = "#996633"
	tastes = list("pretzel" = 1, "honey mustard" = 1)
	foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/ration/side/jellied_eels
	name = "jellied eels"
	desc = "A plastic tin of jellied eels, usually found in PGF rations."
	filling_color = "#669999"
	tastes = list("jellied eels" = 1, "salty jelly" = 1)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/ration/side/trail_mix_beef_jerky
	name = "trail mix with beef jerky"
	desc = "A dry trail mix consisting of various nuts, seeds, fruit raisins, and sparse beef jerky."
	filling_color = "#996633"
	tastes = list("slightly meaty trail mix" = 1, "tough beef jerky" = 1)
	foodtype = MEAT | FRUIT

/obj/item/reagent_containers/food/snacks/ration/side/crackers
	name = "crackers"
	desc = "Semi-crushed crackers, intended to be eaten with a spread or with an entree."
	filling_color = "#663300"
	tastes = list("crackers" = 1)
	foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/ration/side/barbecue_fried_pork_rinds
	name = "barbecue fried pork rinds"
	desc = "Dry pork rinds coated in a barbecue-flavored seasoning."
	filling_color = "#b82121"
	tastes = list("pork rinds" = 1, "powdery barbecue" = 1)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/ration/side/applesauce_mango_peach_puree
	name = "applesauce with mango and peach puree"
	desc = "A packet of applesauce with dried-out mango and peach puree-flavored powder."
	filling_color = "#ff9900"
	tastes = list("applesauce" = 1, "powdered mango" = 1, "powdered peach" = 1)
	foodtype = FRUIT | SUGAR

/obj/item/reagent_containers/food/snacks/ration/snack/pizza_crackers
	name = "pepperoni pizza cheese filled crackers"
	desc = "Cheese-filled crackers, flavored with marinara sauce and pepperoni."
	filling_color = "#b82121"
	tastes = list("cheese crackers" = 3, "pepperoni" = 1, "marinara flavoring" = 1)
	foodtype = MEAT | DAIRY | GRAIN | JUNKFOOD

/obj/item/reagent_containers/food/snacks/ration/snack/fruit_puree
	name = "apple, strawberry, and carrot fruit puree squeeze"
	desc = "A plastic pack with a straw neck, dispensing a puree of various fruits and bits of carrot."
	filling_color = "#cc3131"
	tastes = list("apple" = 1, "strawberry" = 1, "carrot" = 3)
	foodtype = VEGETABLES | FRUIT | SUGAR

/obj/item/reagent_containers/food/snacks/ration/snack/cinnamon_bun
	name = "cinnamon bun"
	desc = "A plastic-shrouded cinnamon bun, kept shelf stable but left dry."
	filling_color = "#b18d40"
	tastes = list("cinnamon" = 3, "dense, sweet bread" = 1)
	foodtype = GRAIN | SUGAR

/obj/item/reagent_containers/food/snacks/ration/snack/toaster_pastry
	name = "chocolate chip toaster pastry"
	desc = "A dry chocolate chip-flavored toaster pastry. The front-facing side has a thin layer of icing."
	filling_color = "#e2a054"
	tastes = list("chocolate" = 1, "dry pastry" = 1, "sweet" = 1)
	foodtype = SUGAR | GRAIN | JUNKFOOD | BREAKFAST
	cookable = TRUE

/obj/item/reagent_containers/food/snacks/ration/snack/dried_raisins
	name = "dried raisins"
	desc = "A small plastic packet containing a handful of dried raisins."
	filling_color = "#1b1146"
	tastes = list("raisins" = 1, "sweet" = 1)
	foodtype = FRUIT | SUGAR

/obj/item/reagent_containers/food/snacks/ration/snack/corn_kernels
	name = "toasted corn kernels, barbecue"
	desc = "Toasted corn kernels, coated in a dusting of barbecue flavor."
	filling_color = "#836b1d"
	tastes = list("corn" = 1, "barbecue" = 1, "something getting stuck between your teeth" = 1)
	foodtype = SUGAR | VEGETABLES | JUNKFOOD

/obj/item/reagent_containers/food/snacks/ration/snack/chocolate_pudding
	name = "chocolate pudding"
	desc = "A packet of shelf-stable chocolate pudding, with a chemical aftertaste."
	filling_color = "#3b2406"
	tastes = list("chocolate" = 2, "pudding" = 1, "chemical-y taste" = 3)
	foodtype = SUGAR | JUNKFOOD

/obj/item/reagent_containers/food/snacks/ration/snack/blackberry_preserves
	name = "blackberry preserves"
	desc = "Thick blackberry preserves in a sealed bag, intended to be spread across another component of the MRE."
	filling_color = "#26133b"
	tastes = list("blackberry" = 1, "sugar" = 1)
	foodtype = FRUIT

/obj/item/reagent_containers/food/snacks/ration/snack/candy_rings
	name = "peppermint candy rings"
	desc = "Red and white candy rings that are peppermint-flavored. They're difficult to crunch into."
	filling_color = "#ecafaf"
	tastes = list("peppermint" = 3, "sugar" = 1)
	foodtype = SUGAR | JUNKFOOD

/obj/item/reagent_containers/food/snacks/ration/snack/lemon_pound_cake
	name = "lemon pound cake"
	desc = "A square of lemon-flavored dense pound cake."
	filling_color = "#ffff99"
	tastes = list("lemon" = 1, "drying cake" = 1)
	foodtype = SUGAR

/obj/item/reagent_containers/food/snacks/ration/snack/cherry_snackers
	name = "cherry snackers"
	desc = "Preserved cherries with their seeds removed beforehand, mildly coated in with a sticky syrup."
	filling_color = "#ff0066"
	tastes = list("cherry" = 1)
	foodtype = FRUIT

/obj/item/reagent_containers/food/snacks/ration/snack/mint_chocolate_snack_cake
	name = "mint chocolate snack cake"
	desc = "A small chocolate snack cake square, imparted with an artificial mint flavoring."
	filling_color = "#00cc66"
	tastes = list("mint" = 1, "chocolate" = 1, "cake" = 1)
	foodtype = SUGAR | GRAIN

/obj/item/reagent_containers/food/snacks/ration/snack/strawberry_preserves
	name = "strawberry preserves"
	desc = "A packet of strawberry preserves intended to be used as a spread for another portion of the MRE, or eaten straight."
	filling_color = "#ff3300"
	tastes = list("strawberry" = 1)
	foodtype = SUGAR | FRUIT

/obj/item/reagent_containers/food/snacks/ration/snack/sour_gummy_worms
	name = "sour gummy worms"
	desc = "Lengths of colored, slightly stiff gummy strips, coated in a mildly sour powder."
	filling_color = "#ff9900"
	tastes = list("slight sourness" = 1, "stiff gummy" = 1)
	foodtype = SUGAR

/obj/item/reagent_containers/food/snacks/ration/snack/blue_raspberry_candies
	name = "blue raspberry candies"
	desc = "Blue raspberry-flavored candies, individually wrapped and partially reduced to smaller fragments."
	filling_color = "#3399ff"
	tastes = list("blue raspberry shards" = 1)
	foodtype = SUGAR

/obj/item/reagent_containers/food/snacks/ration/snack/peanut_cranberry_mix
	name = "peanut cranberry mix"
	desc = "A simple trailmix of salted peanuts and dried cranberries."
	filling_color = "#cc3300"
	tastes = list("peanut" = 1, "cranberry" = 1)
	foodtype = FRUIT

/obj/item/reagent_containers/food/snacks/ration/snack/channeler_meat_candy
	name = "channeler meat candy"
	desc = "A traditional sugary meat confection from the Antechannel League. Each piece of candied channeler is thoroughly wrapped to preserve it for longer."
	filling_color = "#9933ff"
	tastes = list("channeler meat" = 1, "candy" = 1)
	foodtype = MEAT | SUGAR

/obj/item/reagent_containers/food/snacks/ration/snack/chocolate_orange_snack_cake
	name = "chocolate orange snack cake"
	desc = "A small chocolate snack cake square of orange flavoring."
	filling_color = "#ff6600"
	tastes = list("chocolate" = 1, "orange" = 1, "cake" = 1)
	foodtype = SUGAR

/obj/item/reagent_containers/food/snacks/ration/snack/pick_me_up_energy_gum
	name = "Pick-Me-Up energy gum"
	desc = "Individually wrapped sticks of energy gum, leaving your mouth coated with sour flavorings. Not nicotine!"
	filling_color = "#00cc66"
	tastes = list("energy gum" = 1)
	foodtype = SUGAR

/obj/item/reagent_containers/food/snacks/ration/snack/apple_slices
	name = "apple slices"
	desc = "A packet of shrink-wrapped apple slices."
	filling_color = "#ff3300"
	tastes = list("apple" = 1)
	foodtype = FRUIT

/obj/item/reagent_containers/food/snacks/ration/snack/candied_pineapple_chunks
	name = "candied pineapple chunks"
	desc = "A small bag of candied pineapple chunks."
	filling_color = "#ff6600"
	tastes = list("candied pineapple" = 1)
	foodtype = SUGAR | FRUIT

/obj/item/reagent_containers/food/snacks/ration/snack/smoked_almonds
	name = "smoked almonds"
	desc = "A packet of smoked almonds with a slightly sticky coating of seasoning and salt crystals."
	filling_color = "#663300"
	tastes = list("smoked almonds" = 1)
	foodtype = FRUIT

/obj/item/reagent_containers/food/snacks/ration/snack/chocolate_chunk_oatmeal_cookie
	name = "chocolate chunk oatmeal cookie"
	desc = "A dry, shelf-stable oatmeal cookie with dark chocolate chips."
	filling_color = "#663300"
	tastes = list("chocolate" = 1, "sweet oatmeal" = 1)
	foodtype = SUGAR | GRAIN

/obj/item/reagent_containers/food/snacks/ration/snack/peanut_candies
	name = "peanut candies"
	desc = "A packet of sticky, candied peanuts. They tend to get everywhere."
	filling_color = "#ff9900"
	tastes = list("peanut" = 1)
	foodtype = SUGAR | FRUIT

/obj/item/reagent_containers/food/snacks/ration/snack/patriotic_sugar_cookies
	name = "patriotic sugar cookies"
	desc = "Sugar cookies with patriotic designs, of which are dependent on their manufacturer's country of origin."
	filling_color = "#ffcc00"
	tastes = list("sugar cookies" = 1)
	foodtype = SUGAR

/obj/item/reagent_containers/food/snacks/ration/snack/oatmeal_cookie
	name = "oatmeal cookie"
	desc = "A small sleeve of equally small oatmeal cookies."
	filling_color = "#663300"
	tastes = list("dry, sweet oatmeal" = 1)
	foodtype = SUGAR | GRAIN

/obj/item/reagent_containers/food/snacks/ration/snack/dried_cranberries
	name = "dried cranberries"
	desc = "A packet of dried cranberries."
	filling_color = "#cc3300"
	tastes = list("cranberries" = 1)
	foodtype = FRUIT

/obj/item/reagent_containers/food/snacks/ration/snack/dry_roasted_peanuts
	name = "dry roasted peanuts"
	desc = "A packet of dried, roasted peanuts."
	filling_color = "#663300"
	tastes = list("peanuts" = 1)
	foodtype = FRUIT

/obj/item/reagent_containers/food/snacks/ration/snack/jalapeno_cashews
	name = "jalapeno cashews"
	desc = "A baggie of cashews coated in a jalapeno-based seasoning."
	filling_color = "#663300"
	tastes = list("jalapeno" = 1, "cashews" = 1)
	foodtype = FRUIT

/obj/item/reagent_containers/food/snacks/ration/bar/energy_bar
	name = "quik-energy bar, apple-cinnamon"
	desc = "A thick, grainy energy bar, flavored with nigh-unbearably artificial apple and cinnamon flavorings."
	filling_color = "#ee3e1f"
	tastes = list("artificial apple" = 1, "cloying cinnamon" = 1)
	foodtype = FRUIT | GRAIN

/obj/item/reagent_containers/food/snacks/ration/bar/tropical_energy_bar
	name = "tropical energy bar"
	desc = "A sugar and caffeine-laced jelly bar with tropical fruit flavorings. It offers a good bit of chew."
	filling_color = "#ff9900"
	tastes = list("tropical" = 1, "energy bar" = 1)
	foodtype = SUGAR | FRUIT

/obj/item/reagent_containers/food/snacks/ration/bar/rationers_guild_chocolate_bar
	name = "Rationer's Guild chocolate bar"
	desc = "A shelf-stable chocolate bar made by the Rationer's Guild, often considered the supreme bar option out of all the MRE options."
	filling_color = "#663300"
	tastes = list("chocolate" = 1)
	foodtype = SUGAR

/obj/item/reagent_containers/food/snacks/ration/bar/quik_energy_bar_chocolate
	name = "quik-energy bar chocolate"
	desc = "A thick, grainy energy bar, flavored with nigh-unbearably artificial chocolate flavoring."
	filling_color = "#663300"
	tastes = list("artificial chocolate" = 1)
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
