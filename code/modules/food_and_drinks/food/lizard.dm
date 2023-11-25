//Lizard Foods, for lizards (and weird humans!)

//Meat Dishes

/obj/item/reagent_containers/food/snacks/raw_kalixcian_sausage
	name = "raw Kalixcian blood sausage"
	desc = "A raw Kalixcian blood sausage, ready to be cured on a drying rack."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "raw_lizard_sausage"
	list_reagents = list(
		/datum/reagent/consumable/cooking_oil = 5,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/blood = 3,
	)
	tastes = list("meat" = 1, "black pudding" = 1)
	foodtype = MEAT
	w_class = WEIGHT_CLASS_SMALL
	dried_type = /obj/item/reagent_containers/food/snacks/kalixcian_sausage

/obj/item/reagent_containers/food/snacks/kalixcian_sausage
	name = "\improper Kalixcian blood sausage"
	desc = "A coarse dry-cured blood sausage, traditionally made by farmers in the farmlands of the Central Plateau region in former Switzerland. Similar in texture to chorizo."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "lizard_sausage"
	list_reagents = list(
		/datum/reagent/consumable/cooking_oil = 6,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("meat" = 1, "black pudding" = 1)
	foodtype = MEAT
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/raw_headcheese
	name = "raw headcheese block"
	desc = "A common staple in Zalish food culture, headcheese is traditionally made of an animal’s head, with the organs removed, boiled until it falls apart, at which point it is collected, strained of moisture, salted heavily, packed into blocks, and left to dry and age for several months. The resulting hard block tastes similar to cheese."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "raw_lizard_cheese"
	list_reagents = list(
		/datum/reagent/consumable/cooking_oil = 15,
		/datum/reagent/consumable/sodiumchloride = 5,
	)
	tastes = list("meat" = 1, "salt" = 1)
	foodtype = MEAT | GORE
	w_class = WEIGHT_CLASS_SMALL
	dried_type = /obj/item/reagent_containers/food/snacks/headcheese

/obj/item/reagent_containers/food/snacks/headcheese
	name = "headcheese block"
	desc = "A cured block of headcheese. Delicious, if you're a lizard."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "lizard_cheese"
	list_reagents = list(
		/datum/reagent/consumable/cooking_oil = 15,
		/datum/reagent/consumable/sodiumchloride = 5,
	)
	tastes = list("cheese" = 1, "salt" = 1)
	foodtype = MEAT | GORE
	w_class = WEIGHT_CLASS_SMALL
	slice_path = /obj/item/reagent_containers/food/snacks/headcheese_slice
	slices_num = 5

/obj/item/reagent_containers/food/snacks/headcheese_slice
	name = "headcheese slice"
	desc = "A slice of headcheese, useful for making sandwiches and snacks. Or surviving the cold Kalixcis' winters."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "lizard_cheese_slice"
	list_reagents = list(
		/datum/reagent/consumable/cooking_oil = 3,
		/datum/reagent/consumable/sodiumchloride = 1,
	)
	tastes = list("cheese" = 1, "salt" = 1)
	foodtype = MEAT | GORE
	w_class = WEIGHT_CLASS_TINY

/obj/item/reagent_containers/food/snacks/shredded_lungs
	name = "crispy shredded lung stirfry"
	desc = "Crispy lung strips, with veggies and a spicy sauce. Delicious, if you like lungs."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "lung_stirfry"
	list_reagents = list(
		/datum/reagent/consumable/cooking_oil = 6,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/capsaicin = 2,
	)
	tastes = list("meat" = 1, "heat" = 1, "veggies" = 1)
	foodtype = MEAT | VEGETABLES | GORE
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/tsatsikh
	name = "stlakis"
	desc = "A Kalixcian dish consisting of spiced ground offal, stuffed into a stomach and boiled. Pretty foul to anyone who's not used to the taste"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "tsatsikh"
	list_reagents = list(/datum/reagent/consumable/cooking_oil = 10)
	tastes = list("assorted minced organs" = 1)
	foodtype = MEAT | GORE
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/liver_pate
	name = "liver pate"
	desc = "A rich, meaty paste made from liver, meat, and a few additions for extra flavour."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "pate"
	list_reagents = list(/datum/reagent/consumable/cooking_oil = 5)
	tastes = list("liver" = 1)
	foodtype = MEAT
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/moonfish_eggs
	name = "moonfish eggs"
	desc = "The moonfish lays large, transparent white eggs which are prized in lizard cooking. Their flavour is similar to caviar, but generally is described as deeper and more complex."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "moonfish_eggs"
	list_reagents = list(
		/datum/reagent/consumable/cooking_oil = 5,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("caviar" = 1)
	foodtype = SEAFOOD
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/moonfish_caviar
	name = "moonfish caviar paste"
	desc = "A rich paste made from moonfish eggs. Generally the only way most lizards can get them, and used fairly heavily in coastal cooking."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "moonfish_caviar"
	list_reagents = list(
		/datum/reagent/consumable/cooking_oil = 6,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("caviar" = 1)
	foodtype = SEAFOOD
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/lizard_escargot
	name = "desert snail cocleas"
	desc = "Another example of cultural crossover between Sarathi and humans, desert snail escargot is closer to the Roman dish cocleas than the contemporary escargot. It's a common street food in arid cities."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "lizard_escargot"
	list_reagents = list(
		/datum/reagent/consumable/cooking_oil = 6,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/garlic = 2,
	)
	tastes = list("snails" = 1, "garlic" = 1, "oil" = 1)
	foodtype = MEAT | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/fried_blood_sausage
	name = "fried blood sausage"
	desc = "A blood sausage, battered and deep fried. Commonly served with fries as a quick and simple snack as street food."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "fried_blood_sausage"
	list_reagents = list(
		/datum/reagent/consumable/cooking_oil = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/consumable/sodiumchloride = 1,
		/datum/reagent/consumable/cooking_oil = 1,
	)
	tastes = list("black pudding" = 1, "batter" = 1, "oil" = 1)
	foodtype = MEAT | FRIED
	w_class = WEIGHT_CLASS_SMALL

//Why does like, every language on the planet besides English call them pommes? Who knows, who cares- the lizards call them it too, because funny.
/obj/item/reagent_containers/food/snacks/lizard_fries
	name = "loaded poms-franzisks"
	desc = "One of the many human foods to make its way to Kalixcis shortly after first contact was french fries, which are called pommes-embreis in Kalixcian Common. When topped with barbecued meat and sauce, they make a hearty meal."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "lizard_fries"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/cooking_oil = 6,
		/datum/reagent/consumable/sodiumchloride = 1,
		/datum/reagent/consumable/bbqsauce = 2,
	)
	tastes = list("fries" = 2, "bbq sauce" = 1, "barbecued meat" = 1)
	foodtype = MEAT | VEGETABLES | FRIED
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/brain_pate
	name = "eyeball-and-brain pate"
	desc = "A thick pink puree made from finely chopped poached eyeballs and brains, fried onions, and fat. Lizards swear it's delicious!"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "brain_pate"
	list_reagents = list(
		/datum/reagent/consumable/cooking_oil = 8,
		/datum/reagent/liquidgibs = 2,
	)
	tastes = list("brains" = 2)
	foodtype = MEAT | VEGETABLES | GORE
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/crispy_headcheese
	name = "crispy breaded headcheese"
	desc = "A delicious snack from the streets of Fenistrad in the Antechannel League, consisting of headcheese coated in rootbread breadcrumbs. Commonly served with fries."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "crispy_headcheese"
	list_reagents = list(
		/datum/reagent/consumable/cooking_oil = 5,
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/cooking_oil = 2,
	)
	tastes = list("cheese" = 1, "oil" = 1)
	foodtype = MEAT | VEGETABLES | NUTS | GORE
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/kebab/picoss_skewers
	name = "armada skewer"
	desc = "A popular Ring streetfood consisting of vinegar-marinated armorfish on a skewer with onion and chillis."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "picoss_skewer"
	list_reagents = list(
		/datum/reagent/consumable/cooking_oil = 8,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/vinegar = 1,
		/datum/reagent/consumable/capsaicin = 1,
	)
	tastes = list("fish" = 1, "acid" = 1, "onion" = 1, "heat" = 1)
	foodtype = SEAFOOD | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/nectar_larvae
	name = "nectar larvae"
	desc = "Little crispy larvae in a korta nectar based sweet and spicy sauce. Bugtastic!"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "nectar_larvae"
	list_reagents = list(
		/datum/reagent/consumable/cooking_oil = 7,
		/datum/reagent/consumable/korta_nectar = 3,
		/datum/reagent/consumable/capsaicin = 1,
	)
	tastes = list("meat" = 1, "sweet" = 1, "heat" = 1)
	foodtype = GORE | MEAT | BUGS
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/mushroomy_stirfry
	name = "mushroomy stirfry"
	desc = "A medley of mushrooms, made to meet your monstrous munchies. Marvelous!"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "mushroomy_stirfry"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("marvelous mushrooms" = 1, "sublime shrooms" = 1)
	foodtype = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

//Fish Dishes, commented until fishing implementation (hope this happens)
/obj/item/reagent_containers/food/snacks/grilled_moonfish
	name = "grilled moonfish"
	desc = "A slab of grilled moonfish. Traditionally served over scalloped roots with a wine-based sauce."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "grilled_moonfish"
	list_reagents = list(
		/datum/reagent/consumable/cooking_oil = 8,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("fish" = 1)
	foodtype = SEAFOOD
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/moonfish_demiglace
	name = "moonfish demiglace"
	desc = "A slab of beautifully seared moonfish on a bed of potatoes and carrots, with a wine and demiglace reduction on top. Simply marvelous."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "moonfish_demiglace"
	list_reagents = list(
		/datum/reagent/consumable/cooking_oil = 8,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/nutriment = 2,
	)
	tastes = list("fish" = 2, "potatoes" = 1, "carrots" = 1)
	foodtype = SEAFOOD
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/lizard_surf_n_turf
	name = "\improper Channeler surf 'n' turf smorgasbord"
	desc = "A massive platter of Kalixcis' finest meat and seafood, typically shared by groups on the river beaches. Of course, nothing's stopping you eating it on your own…"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "surf_n_turf"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 15,
		/datum/reagent/consumable/cooking_oil = 10,
		/datum/reagent/consumable/nutriment/vitamin = 10,
	)
	tastes = list("surf" = 1, "turf" = 1)
	foodtype = MEAT | SEAFOOD | VEGETABLES
	w_class = WEIGHT_CLASS_BULKY

//Spaghetti Dishes

/obj/item/reagent_containers/food/snacks/spaghetti/nizaya
	name = "rustic pasta"
	desc = "A form of root and nut pasta originally native to the oceanside regions of Kalixcis. It's similar in texture and appearance to gnocchi."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "nizaya"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("gnocchi" = 1)
	foodtype = VEGETABLES | NUTS

/obj/item/reagent_containers/food/snacks/spaghetti/snail_nizaya
	name = "desert snail rustic pasta"
	desc = "A high class pasta dish adopted by Solarian chefs based on Kalixcian pasta traditions. Traditionally made with only the finest Solarian wine… but box will do, in a pinch."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "snail_nizaya"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/cooking_oil = 4,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("snails" = 1, "wine" = 1, "gnocchi" = 1)
	foodtype = VEGETABLES | MEAT | NUTS

/obj/item/reagent_containers/food/snacks/spaghetti/garlic_nizaya
	name = "garlic-and-oil nizaya"
	desc = "A lizard adaptation of the Italian pasta dish, aglio e olio, made with nizaya pasta."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "garlic_nizaya"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/vitamin = 10,
	)
	tastes = list("garlic" = 1, "oil" = 1, "gnocchi" = 1)
	foodtype = VEGETABLES | NUTS

/obj/item/reagent_containers/food/snacks/spaghetti/demit_nizaya
	name = "demit nizaya"
	desc = "A sweet, creamy nizaya pasta dish made with korta milk and nectar."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "demit_nizaya"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/korta_nectar = 4,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("peppery sweet" = 1, "veggies" = 1, "gnocchi" = 1)
	foodtype = VEGETABLES | SUGAR | NUTS

/obj/item/reagent_containers/food/snacks/spaghetti/mushroom_nizaya
	name = "mushroom nizaya"
	desc = "A nizaya pasta dish made with seraka mushrooms and quality oil. Has a pronounced nutty flavour."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "mushroom_nizaya"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/vitamin = 10,
	)
	tastes = list("savouriness" = 1, "nuttiness" = 1, "gnocchi" = 1)
	foodtype = VEGETABLES

//Dough Dishes

/obj/item/reagent_containers/food/snacks/rootdough
	name = "root dough"
	desc = "A root based dough, made with nuts and tubers. Used in a wide range of Kalixcian cooking."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "rootdough"
	list_reagents = list(/datum/reagent/consumable/nutriment = 6)
	w_class = WEIGHT_CLASS_SMALL
	tastes = list("potato" = 1, "earthy heat" = 1)
	foodtype = VEGETABLES | NUTS
	cooked_type = /obj/item/reagent_containers/food/snacks/bread/root

/obj/item/reagent_containers/food/snacks/rootdough/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/kitchen/rollingpin))
		if(isturf(loc))
			new /obj/item/reagent_containers/food/snacks/flatrootdough(loc)
			to_chat(user, "<span class='notice'>You flatten [src].</span>")
			qdel(src)
		else
			to_chat(user, "<span class='warning'>You need to put [src] on a surface to roll it out!</span>")
	else
		..()

/obj/item/reagent_containers/food/snacks/flatrootdough
	name = "flat rootdough"
	desc = "Flattened rootdough, ready to be made into a flatbread, or cut into segments."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "flat_rootdough"
	list_reagents = list(/datum/reagent/consumable/nutriment = 6)
	tastes = list("potato" = 1, "earthy heat" = 1)
	foodtype = VEGETABLES | NUTS
	cooked_type = /obj/item/reagent_containers/food/snacks/root_flatbread
	slice_path = /obj/item/reagent_containers/food/snacks/rootdoughslice
	slices_num = 3

/obj/item/reagent_containers/food/snacks/rootdoughslice
	name = "rootdough ball"
	desc = "A ball of root dough. Perfect for making pasta or rolls."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "rootdough_slice"
	list_reagents = list(/datum/reagent/consumable/nutriment = 2)
	w_class = WEIGHT_CLASS_SMALL
	tastes = list("potato" = 1, "earthy heat" = 1)
	foodtype = VEGETABLES | NUTS
	slice_path = /obj/item/reagent_containers/food/snacks/spaghetti/nizaya
	slices_num = 1
	cooked_type = /obj/item/reagent_containers/food/snacks/rootroll

/obj/item/reagent_containers/food/snacks/root_flatbread
	name = "root flatbread"
	desc = "A plain grilled root flatbread. Can be topped with a variety of foods that lizards like to eat."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "root_flatbread"
	list_reagents = list(/datum/reagent/consumable/nutriment = 8)
	tastes = list("bread" = 1, "earthy heat" = 1)
	foodtype = VEGETABLES | NUTS

/obj/item/reagent_containers/food/snacks/rootroll
	name = "rootroll"
	desc = "A dense, chewy roll, made from roots. A nice companion to a bowl of soup."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "rootroll"
	list_reagents = list(/datum/reagent/consumable/nutriment = 4)
	w_class = WEIGHT_CLASS_SMALL
	tastes = list("roll" = 1) // the roll tastes of roll.
	foodtype = VEGETABLES | NUTS

//Bread Dishes

/obj/item/reagent_containers/food/snacks/bread/root
	name = "rootbread"
	desc = "The lizard equivalent to bread, made from tubers like potatoes and yams mixed with ground nuts and seeds. Noticably denser than regular bread."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "lizard_bread"
	list_reagents = list(/datum/reagent/consumable/nutriment = 20)
	tastes = list("bread" = 8, "nuts" = 2)
	foodtype = VEGETABLES | NUTS
	w_class = WEIGHT_CLASS_SMALL
	slice_path = /obj/item/reagent_containers/food/snacks/breadslice/root
	custom_food_type = /obj/item/reagent_containers/food/snacks/customizable/bread

/obj/item/reagent_containers/food/snacks/breadslice/root
	name = "rootbread slice"
	desc = "A slice of dense, chewy rootbread."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "lizard_breadslice"
	list_reagents = list(/datum/reagent/consumable/nutriment = 4)
	tastes = list("bread" = 8, "nuts" = 2)
	foodtype = VEGETABLES | NUTS
	customfoodfilling = 1

//Pizza Dishes
/obj/item/reagent_containers/food/snacks/pizza/flatbread
	icon = 'icons/obj/food/lizard.dmi'
	slice_path = null

/obj/item/reagent_containers/food/snacks/pizza/flatbread/rustic
	name = "rustic flatbread"
	desc = "A simple Zohilian country dish, popular as a side to meat or fish dishes. Topped with herbs and oil"
	icon_state = "rustic_flatbread"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 15,
		/datum/reagent/consumable/nutriment/vitamin = 15,
		/datum/reagent/consumable/garlic = 2,
	)
	tastes = list("bread" = 1, "herb" = 1, "oil" = 1, "garlic" = 1)
	foodtype = VEGETABLES | NUTS

/obj/item/reagent_containers/food/snacks/pizza/flatbread/italic
	name = "\improper Mediterranean flatbread"
	desc = "The introduction of Solarian foods to Kalixcis led to an advancement in Sarathi cooking - the Mediterranean flatbread is now a common sight on the menus of takeout stores on the planet"
	icon_state = "italic_flatbread"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 15,
		/datum/reagent/consumable/cooking_oil = 10,
		/datum/reagent/consumable/nutriment/vitamin = 15,
	)
	tastes = list("bread" = 1, "herb" = 1, "oil" = 1, "garlic" = 1, "tomato" = 1, "meat" = 1)
	foodtype = VEGETABLES | NUTS | MEAT

/obj/item/reagent_containers/food/snacks/pizza/flatbread/imperial
	name = "\improper Royal flatbread"
	desc = "A flatbread topped with pate, pickled vegetables, and cubed headcheese, named in honor of the Zalish royals. Not very suited to anyone's tastes but the Sarathi."
	icon_state = "imperial_flatbread"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 15,
		/datum/reagent/consumable/cooking_oil = 15,
		/datum/reagent/consumable/nutriment/vitamin = 10,
	)
	tastes = list("bread" = 1, "herb" = 1, "oil" = 1, "garlic" = 1, "tomato" = 1, "meat" = 1)
	foodtype = VEGETABLES | MEAT | NUTS | GORE

/obj/item/reagent_containers/food/snacks/pizza/flatbread/rawmeat
	name = "meatlovers flatbread"
	desc = "Oddly enough, this Pan-Genezan dish is actually a favorite of some health-minded humans."
	icon_state = "rawmeat_flatbread"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 15,
		/datum/reagent/consumable/cooking_oil = 10,
	)
	tastes = list("bread" = 1, "meat" = 1)
	foodtype = MEAT | NUTS | RAW | GORE

/obj/item/reagent_containers/food/snacks/pizza/flatbread/stinging
	name = "\improper Stinging flatbread"
	desc = "The electric mix of jellyfish and bee larva makes for a flavor sensation that leaves you asking for more!"
	icon_state = "stinging_flatbread"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 15,
		/datum/reagent/consumable/cooking_oil = 20,
		/datum/reagent/consumable/honey = 2,
	)
	tastes = list("bread" = 1, "sweetness" = 1, "stinging" = 1, "slime" = 1)
	foodtype = BUGS | NUTS | SEAFOOD | GORE

/obj/item/reagent_containers/food/snacks/pizza/flatbread/zmorgast  // Name is based off of the Swedish dish Smörgåstårta
	name = "\improper Swedish flatbread"
	desc = "A Pan-Genezan spin on the original Swedish sandwich cake inherited by the Solarians, the 'swedeflat' is a common dish at family gatherings."
	icon_state = "zmorgast_flatbread"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 16,
		/datum/reagent/consumable/cooking_oil = 6,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("bread" = 1, "liver" = 1, "family" = 1)
	foodtype = VEGETABLES | NUTS | MEAT

/obj/item/reagent_containers/food/snacks/pizza/flatbread/fish
	name = "\improper BBQ fish flatbread"
	desc = "Superengine delamination, nuclear operatives, too cold outside, I just want to grill for Fangs' sake!"
	icon_state = "fish_flatbread"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 20,
		/datum/reagent/consumable/cooking_oil = 15,
		/datum/reagent/consumable/bbqsauce = 2,
	)
	tastes = list("bread" = 1, "fish" = 1)
	foodtype = SEAFOOD | NUTS

/obj/item/reagent_containers/food/snacks/pizza/flatbread/mushroom
	name = "mushroom and tomato flatbread"
	desc = "A simple alternative to the Italic flatbread, for when you've already filled up on meat elsewhere."
	icon_state = "mushroom_flatbread"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 18,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes =  list("bread" = 1, "mushroom" = 1, "tomatoes" = 1)
	foodtype = VEGETABLES | NUTS

/obj/item/reagent_containers/food/snacks/pizza/flatbread/nutty
	name = "nut paste flatbread"
	desc = "Modern advances in cuisine now allow for a double helping of the delicious taste of korta nuts, both as the base and as a topping on this flatbread."
	icon_state = "nutty_flatbread"
	list_reagents = list(/datum/reagent/consumable/nutriment = 20)
	tastes =  list("bread" = 1, "nuts" = 2)
	foodtype = NUTS

//Sandwiches/Toast Dishes
/obj/item/reagent_containers/food/snacks/emperor_roll
	name = "emperor roll"
	desc = "A popular sandwich on Kalixcis, named in honour of the Zale families."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "emperor_roll"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/cooking_oil = 8,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("bread" = 1, "cheese" = 1, "liver" = 1, "caviar" = 1)
	foodtype = VEGETABLES | NUTS | MEAT | GORE | SEAFOOD
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/honey_roll
	name = "honey sweetroll"
	desc = "A sweetened rootroll with sliced fruit, enjoyed as a seasonal dessert on Kalixcis."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "honey_roll"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 8,
		/datum/reagent/consumable/honey = 2,
	)
	tastes = list("bread" = 1, "honey" = 1, "fruit" = 1)
	foodtype = VEGETABLES | NUTS | FRUIT
	w_class = WEIGHT_CLASS_SMALL

//Soup Dishes
/obj/item/reagent_containers/food/snacks/soup/atrakor_dumplings
	name = "\improper Meat dumpling soup"
	desc = "A bowl of rich, meaty dumpling soup. Pleasant and hearty fare for holidays, especially during the winter"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "atrakor_dumplings"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/cooking_oil = 10,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/water = 5,
	)
	tastes = list("bone broth" = 1, "onion" = 1, "potato" = 1)
	foodtype = MEAT | VEGETABLES | NUTS

/obj/item/reagent_containers/food/snacks/soup/meatball_noodles //No growable peanuts. No recipe. No food.
	name = "meatball noodle soup"
	desc = "A hearty noodle soup made from meatballs and nizaya in a rich broth. Commonly topped with a handful of chopped nuts."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "meatball_noodles"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/cooking_oil = 8,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/water = 5,
	)
	tastes = list("bone broth" = 1, "meat" = 1, "gnocchi" = 1, "peanuts" = 1)
	foodtype = MEAT | VEGETABLES | NUTS

/obj/item/reagent_containers/food/snacks/soup/black_broth
	name = "\improper Kalixcian black broth"
	desc = "A bowl of sausage, onion, blood and vinegar, served ice cold. Every bit as rough as it sounds."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "black_broth"
	list_reagents = list(
		/datum/reagent/consumable/cooking_oil = 10,
		/datum/reagent/blood = 8,
		/datum/reagent/liquidgibs = 2,
	)
	tastes = list("vinegar" = 1, "metal" = 1)
	foodtype = MEAT | VEGETABLES | GORE

/obj/item/reagent_containers/food/snacks/soup/jellyfish
	name = "jellyfish stew"
	desc = "A slimy bowl of jellyfish stew. It jiggles if you shake it."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "jellyfish_stew"
	list_reagents = list(
		/datum/reagent/consumable/cooking_oil = 10,
		/datum/reagent/consumable/nutriment = 6,
	)
	tastes = list("slime" = 1)
	foodtype = MEAT | VEGETABLES | GORE

/obj/item/reagent_containers/food/snacks/soup/rootbread_soup
	name = "rootbread soup"
	desc = "A big bowl of spicy, savoury soup made with rootbread. Heavily seasoned, and very tasty."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "rootbread_soup"
	list_reagents = list(
		/datum/reagent/consumable/cooking_oil = 6,
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("bread" = 1, "egg" = 1, "chili" = 1, "garlic" = 1)
	foodtype = MEAT | VEGETABLES

//Egg Dishes
/obj/item/reagent_containers/food/snacks/black_eggs
	name = "black scrambled eggs"
	desc = "A country dish from rural Kalixcis. Made with eggs, animal blood, and foraged greens. Traditionally eaten with rootbread and a spicy sauce."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "black_eggs"
	list_reagents = list(
		/datum/reagent/consumable/cooking_oil = 8,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("eggs" = 1, "greens" = 1, "blood" = 1)
	foodtype = MEAT | BREAKFAST | GORE
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/patzikula
	name = "patzikula"
	desc = "A smooth and spicy tomato-based sauce topped with eggs and baked. Delicious."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "patzikula"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/cooking_oil = 8,
		/datum/reagent/consumable/nutriment/vitamin = 8,
		/datum/reagent/consumable/capsaicin = 2,
	)
	tastes = list("eggs" = 1, "tomato" = 1, "heat" = 1)
	foodtype = VEGETABLES | MEAT | BREAKFAST
	w_class = WEIGHT_CLASS_SMALL

//Cakes/Sweets

/obj/item/reagent_containers/food/snacks/cake/korta_brittle
	name = "korta brittle slab"
	desc = "A big slab of korta nut brittle. So sugary it should be a crime!"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "korta_brittle"
	list_reagents = list(
		/datum/reagent/consumable/sugar = 20,
		/datum/reagent/consumable/nutriment = 15,
		/datum/reagent/consumable/korta_nectar = 15,
	)
	tastes = list("peppery heat" = 1, "sweetness" = 1)
	foodtype = NUTS | SUGAR
	slice_path = /obj/item/reagent_containers/food/snacks/cakeslice/korta_brittle

/obj/item/reagent_containers/food/snacks/cakeslice/korta_brittle
	name = "korta brittle slice"
	desc = "A little slice of korta nut brittle. A diabetic's worst enemy."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "korta_brittle_slice"
	list_reagents = list(
		/datum/reagent/consumable/sugar = 4,
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/korta_nectar = 3,
	)
	tastes = list("peppery heat" = 1, "sweetness" = 1)
	foodtype = NUTS | SUGAR

/obj/item/reagent_containers/food/snacks/snowcones/korta_ice
	name = "korta ice"
	desc = "Shaved ice, korta nectar and berries. A sweet treat to eat to beat summer heat!"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "korta_ice"
	list_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 8,
		/datum/reagent/consumable/ice = 4,
		/datum/reagent/consumable/berryjuice = 6,
	)
	tastes = list("peppery sweet" = 1, "berry" = 1)
	foodtype = NUTS | SUGAR | FRUIT

/obj/item/reagent_containers/food/snacks/kebab/candied_mushrooms
	name = "candied mushrooms"
	desc = "A slightly bizarre dish from Kalixcis, consisting of seraka mushrooms coated with caramel on a skewer. Carries a pronounced 'sweet and savoury' kick."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "candied_mushrooms"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/caramel = 4,
	)
	tastes = list("savouriness" = 1, "sweetness" = 1)
	foodtype = SUGAR | VEGETABLES

//Misc Dishes
/obj/item/reagent_containers/food/snacks/sauerkraut
	name = "sauerkraut"
	desc = "Pickled cabbage, as made famous by Germans, and which has become common in lizard cooking, where it is known as Zauerkrat."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "sauerkraut"
	list_reagents = list(/datum/reagent/consumable/nutriment = 4)
	tastes = list("cabbage" = 1, "acid" = 1)
	foodtype = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/lizard_dumplings
	name = "\improper Kalixcian dumplings"
	desc = "Mashed root vegetables, mixed with korta flour and boiled to produce a large, round and slightly spicy dumpling. Commonly eaten in soup."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "lizard_dumplings"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("potato" = 1, "earthy heat" = 1)
	foodtype = VEGETABLES | NUTS
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/steeped_mushrooms
	name = "steeped seraka mushrooms"
	desc = "Seraka mushrooms that have been steeped in alkaline water to remove the extract, thereby making them completely safe to consume."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "steeped_mushrooms"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("savouriness" = 1, "nuttiness" = 1)
	foodtype = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/canned/jellyfish
	name = "canned gunner jellyfish"
	desc = "A can of gunner jellyfish packed in brine. Contains a mild hallucinogen which is destroyed by cooking."
	icon_state = "jellyfish"
	list_reagents = list(
		/datum/reagent/consumable/cooking_oil = 8,
		/datum/reagent/toxin/mindbreaker = 2,
		/datum/reagent/consumable/sodiumchloride = 1,
	)
	trash = /obj/item/trash/can/food/jellyfish
	tastes = list("slime" = 1, "burning" = 1, "salt" = 1)
	foodtype = SEAFOOD | GORE
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/canned/desert_snails
	name = "canned desert snails"
	desc = "Giant snails from the Kalixcis' oceanic environment, packaged in brine. Shells included. Probably best not eaten raw, unless you're a Kalixcian."
	icon_state = "snails"
	list_reagents = list(
		/datum/reagent/consumable/cooking_oil = 8,
		/datum/reagent/consumable/sodiumchloride = 2,
	)
	trash = /obj/item/trash/can/food/desert_snails
	tastes = list("snails" = 1)
	foodtype = MEAT | GORE
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/canned/larvae
	name = "canned bee larva"
	desc = "A can of bee larva packaged in honey. Probably appetizing to someone."
	icon_state = "larvae"
	list_reagents = list(
		/datum/reagent/consumable/cooking_oil = 8,
		/datum/reagent/consumable/honey = 2,
	)
	trash = /obj/item/trash/can/food/larvae
	tastes = list("sweet bugs" = 1)
	foodtype = MEAT | GORE | BUGS
	w_class = WEIGHT_CLASS_SMALL
