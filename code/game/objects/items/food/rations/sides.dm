/obj/item/food/ration/side
	icon_state = "ration_side"
	food_reagents = list(/datum/reagent/consumable/nutriment = 4)

/obj/item/food/ration/side/vegan_crackers
	name = "vegetable 'crackers'"
	desc = "Vegetable-based, dry crackers. A couple are broken to pieces."
	filling_color = "#9ED41B"
	tastes = list("tough cracker" = 1)
	foodtypes = VEGETABLES

/obj/item/food/ration/side/vegan_crackers/open_ration(mob/user)
	.=..()
	to_chat(user, span_notice("\the [src] makes a nice hiss."))

/obj/item/food/ration/side/cornbread
	name = "cornbread"
	desc = "Crumbly cornbread, which has since been flattened and dried in the package."
	filling_color = "#DDB63B"
	tastes = list("dry cornbread" = 1)
	foodtypes = VEGETABLES | GRAIN

/obj/item/food/ration/side/jerky_wrap
	name = "jerky wraps"
	desc = "Thin slices of beef-based, heavily-spiced jerky, not too disimilar to convenience store brands."
	filling_color = "#532d0e"
	tastes = list("thick spices" = 1, "tough, chewy beef" = 1)
	foodtypes = MEAT

/obj/item/food/ration/side/bread_sticks
	name = "seasoned bread sticks"
	desc = "Crunchy, seasoned bread sticks, often softened with being dipped in the entree."
	filling_color = "#e2904d"
	tastes = list("dry bread" = 1, "mild seasonings" = 1)
	foodtypes = GRAIN

/obj/item/food/ration/side/tortilla
	name = "tortillas"
	desc = "Flour tortillas, a versatile staple that complements various fillings and flavors. A great choice for a quick meal."
	filling_color = "#f3ac69"
	tastes = list("tortilla" = 1)
	foodtypes = GRAIN

/obj/item/food/ration/side/wheat_bread
	name = "white wheat snack bread"
	desc = "A dense rectangle of white bread, with perforation lines for you to tear along. You'll want to serve it with something else."
	filling_color = "#8d5a30"
	tastes = list("dense bread" = 1)
	foodtypes = GRAIN

/obj/item/food/ration/side/beef_sticks
	name = "teriyaki beef sticks"
	desc = "Beef sticks, coated in a teriyaki-based flavoring. The flavoring coats the interior of the packet it's served in."
	filling_color = "#664a20"
	tastes = list("beef" = 1, "powdery teriyaki" = 1)
	foodtypes = MEAT | SUGAR

/obj/item/food/ration/side/garlic_mashed_potatoes
	name = "garlic mashed potatoes"
	desc = "Silty mashed potatoes, mixed with garlic flavoring."
	filling_color = "#e6e600"
	tastes = list("garlic powder" = 1, "silty potatoes" = 1)
	foodtypes = GRAIN | VEGETABLES
	cookable = TRUE

/obj/item/food/ration/side/soup_crackers
	name = "soup crackers"
	desc = "Dry, hard soda crackers for dipping in an entree."
	filling_color = "#663300"
	tastes = list("crackers" = 1)
	foodtypes = GRAIN

/obj/item/food/ration/side/griddled_mushrooms_chili
	name = "griddled mushrooms with chili"
	desc = "Little pieces of grilled mushrooms mixed in a very mild chili. It's closer to being chili with mushrooms in it than vice versa."
	filling_color = "#b82121"
	tastes = list("mushrooms" = 1, "chili" = 2)
	foodtypes = VEGETABLES | MEAT
	cookable = TRUE

/obj/item/food/ration/side/white_sandwich_bread
	name = "white sandwich bread"
	desc = "Small white bread slabs, intended to be made into sandwiches or have a spread placed across them."
	filling_color = "#ffffff"
	tastes = list("bread" = 1)
	foodtypes = GRAIN

/obj/item/food/ration/side/baked_cheddarcheese_chips
	name = "baked cheddar cheese chips"
	desc = "A small packet of thin cheddar cheese chips, some gone soft."
	filling_color = "#ffcc00"
	tastes = list("artificial cheddar cheese" = 1, "chips" = 1)
	foodtypes = DAIRY

/obj/item/food/ration/side/fried_potato_curls
	name = "fried potato curls"
	desc = "A packet of fried potato curls, coated in salt and sealed."
	filling_color = "#ffcc00"
	tastes = list("potato" = 1)
	foodtypes = GRAIN

/obj/item/food/ration/side/stewed_asparagus_butter
	name = "stewed asparagus with butter"
	desc = "Stewed asparagus served with melted butter, of a soft consistency."
	filling_color = "#99cc00"
	tastes = list("soft asparagus" = 1, "butter" = 1)
	foodtypes = VEGETABLES
	cookable = TRUE

/obj/item/food/ration/side/broth_tuna_rice
	name = "bone broth with tuna and rice"
	desc = "A watery broth with pieces of tuna and a helping of rice."
	filling_color = "#669999"
	tastes = list("watery broth" = 2, "tuna" = 1, "rice" = 1)
	foodtypes = MEAT | GRAIN
	cookable = TRUE

/obj/item/food/ration/side/trail_crackers
	name = "trail crackers"
	desc = "Crackers baked with dried fruit and seeds, tough to chew."
	filling_color = "#ffcc00"
	tastes = list("tough crackers" = 1, "fruit raisins" = 1)
	foodtypes = GRAIN | FRUIT

/obj/item/food/ration/side/hash_brown_bacon
	name = "hash brown potatoes with bacon, peppers and onions"
	desc = "Dry hash browns paired with equally dry strips of bacon, salted heavily."
	filling_color = "#ffcc00"
	tastes = list("stiff hash brown" = 1, "crumbly bacon" = 1)
	foodtypes = GRAIN | MEAT | VEGETABLES
	cookable = TRUE

/obj/item/food/ration/side/granola_milk_blueberries
	name = "granola with milk and blueberries"
	desc = "Dense granola served with milk powder and blueberry raisins."
	filling_color = "#6699ff"
	tastes = list("granola" = 1, "milk powder" = 1, "blueberry raisins" = 1)
	foodtypes = GRAIN | DAIRY

/obj/item/food/ration/side/maple_muffin
	name = "maple muffin"
	desc = "A shelf-stable, maple-flavored muffin."
	filling_color = "#b8711b"
	tastes = list("maple" = 1, "tough muffin" = 1)
	foodtypes = SUGAR | GRAIN

/obj/item/food/ration/side/au_gratin_potatoes
	name = "au gratin potatoes"
	desc = "A shallow bowl of au gratin potatoes with a crust of melted cheese."
	filling_color = "#ffcc00"
	tastes = list("potatoes" = 1, "thick cheeses" = 1)
	foodtypes = GRAIN | DAIRY | VEGETABLES
	cookable = TRUE

/obj/item/food/ration/side/applesauce_carb_enhanced
	name = "carb-enhanced applesauce"
	desc = "A grainy, starchy applesauce, reinforced with carbohydrates to keep the consumer going."
	filling_color = "#ff9900"
	tastes = list("starchy applesauce" = 1)
	foodtypes = FRUIT | SUGAR

/obj/item/food/ration/side/white_bread_mini_loaf
	name = "mini loaf of white bread"
	desc = "A miniature loaf of dense, compressed white bread with perforation lines for you to tear along."
	filling_color = "#ffffff"
	tastes = list("bread" = 1)
	foodtypes = GRAIN

/obj/item/food/ration/side/apples_in_spiced_sauce
	name = "apples in spiced sauce"
	desc = "Mushy apple slices in a spiced sauce."
	filling_color = "#ff3300"
	tastes = list("mushy apples" = 1, "cinnamon-esque sauce" = 1)
	foodtypes = FRUIT

/obj/item/food/ration/side/pretzel_sticks_honey_mustard
	name = "pretzel sticks with honey mustard"
	desc = "Pretzel sticks served with packet of honey mustard sauce."
	filling_color = "#996633"
	tastes = list("pretzel" = 1, "honey mustard" = 1)
	foodtypes = GRAIN

/obj/item/food/ration/side/jellied_eels
	name = "jellied eels"
	desc = "A plastic tin of jellied eels, usually found in PGF rations."
	filling_color = "#669999"
	tastes = list("jellied eels" = 1, "salty jelly" = 1)
	foodtypes = MEAT

/obj/item/food/ration/side/trail_mix_beef_jerky
	name = "trail mix with beef jerky"
	desc = "A dry trail mix consisting of various nuts, seeds, fruit raisins, and sparse beef jerky."
	filling_color = "#996633"
	tastes = list("slightly meaty trail mix" = 1, "tough beef jerky" = 1)
	foodtypes = MEAT | FRUIT

/obj/item/food/ration/side/crackers
	name = "crackers"
	desc = "Semi-crushed crackers, intended to be eaten with a spread or with an entree."
	filling_color = "#663300"
	tastes = list("crackers" = 1)
	foodtypes = GRAIN

/obj/item/food/ration/side/barbecue_fried_pork_rinds
	name = "barbecue fried pork rinds"
	desc = "Dry pork rinds coated in a barbecue-flavored seasoning."
	filling_color = "#b82121"
	tastes = list("pork rinds" = 1, "powdery barbecue" = 1)
	foodtypes = MEAT

/obj/item/food/ration/side/applesauce_mango_peach_puree
	name = "applesauce with mango and peach puree"
	desc = "A packet of applesauce with dried-out mango and peach puree-flavored powder."
	filling_color = "#ff9900"
	tastes = list("applesauce" = 1, "powdered mango" = 1, "powdered peach" = 1)
	foodtypes = FRUIT | SUGAR

//teceti stuff
/obj/item/food/ration/side/miras_reti
	name = "miras reti"
	desc = "Whole unfertiilzed Miras eggs. The shell has already been removed, so some of them are smushed up."
	filling_color = "#f4f4f4"
	tastes = list("egg" = 4, "savory yolk" = 1)
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 2,
	)
	foodtypes = BREAKFAST | MEAT

/obj/item/food/ration/side/tirila
	name = "tirila-li"
	desc = "An entire stick of Tirili-La, a cured meat sausage made with Refa Fruit and Tiris."
	filling_color = "#453e3b"
	tastes = list("spicy-savory meat" = 3, "bitter fruit" = 1)
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/capsaicin = 2,
	)
	foodtypes = MEAT | FRUIT

/obj/item/food/ration/side/lifosa
	name = "lifosa tiris"
	desc = "Pearls of Tiris cheese within a salty, air cured crust. The interior of the package is somewhat oily."
	filling_color = "#cac84e"
	tastes = list("rock salts" = 1, "cheese" = 2)
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
	)
	foodtypes = DAIRY

/obj/item/food/ration/side/cactus
	name = "cored cactus fruit"
	desc = "A Tecetian cactus fruit, cored out so that it can be stuffed full of other foods."
	filling_color = "#e2904d"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/vitfro = 1,
	)
	tastes = list("fruity mushroom" = 1)
	foodtypes = FRUIT

/obj/item/food/ration/side/dote_berry
	name = "dehydrated dote berries"
	desc = "Small crunchy berries that've been victim to a dusting of seasoning. The seeds tend to cluster at the bottom of the pack."
	filling_color = "#2359a0"
	tastes = list("concentrated fruit" = 4, "spice" = 1)
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	foodtypes = FRUIT

/obj/item/food/ration/side/dore
	name = "ready-to-go Dore"
	desc = "A Tecetian pastry typically stuffed with meat and fruit. These ones have been left plain for the consumer to alter."
	filling_color = "#e2904d"
	tastes = list("seedy bread")
	foodtypes = GRAIN
