/obj/item/reagent_containers/food/snacks/soup
	w_class = WEIGHT_CLASS_NORMAL
	icon = 'icons/obj/food/soupsalad.dmi'
	trash = /obj/item/reagent_containers/glass/bowl
	bitesize = 5
	volume = 80
	list_reagents = list(/datum/reagent/consumable/nutriment = 8, /datum/reagent/water = 5, /datum/reagent/consumable/nutriment/vitamin = 4)
	tastes = list("tasteless soup" = 1)
	foodtype = VEGETABLES

/obj/item/reagent_containers/food/snacks/soup/Initialize()
	. = ..()
	eatverb = pick("slurp","sip","inhale","drink")

/obj/item/reagent_containers/food/snacks/soup/wish
	name = "wish soup"
	desc = "I wish this was soup."
	icon_state = "wishsoup"
	list_reagents = list(/datum/reagent/water = 10)
	tastes = list("wishes" = 1)

/obj/item/reagent_containers/food/snacks/soup/wish/Initialize()
	. = ..()
	var/wish_true = prob(25)
	if(wish_true)
		desc = "A wish come true!"
		bonus_reagents = list(/datum/reagent/consumable/nutriment = 9, /datum/reagent/consumable/nutriment/vitamin = 1)
	if(wish_true)
		reagents.add_reagent(/datum/reagent/consumable/nutriment, 9)
		reagents.add_reagent(/datum/reagent/consumable/nutriment/vitamin, 1)
		foodtype = VEGETABLES

/obj/item/reagent_containers/food/snacks/soup/meatball
	name = "meatball soup"
	desc = "You've got balls kid, BALLS!"
	icon_state = "meatballsoup"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 5)
	tastes = list("meat" = 1)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/soup/slime
	name = "slime soup"
	desc = "If no water is available, you may substitute tears."
	icon_state = "slimesoup"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/toxin/slimejelly = 5, /datum/reagent/consumable/nutriment/vitamin = 5)
	list_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/toxin/slimejelly = 5, /datum/reagent/water = 5, /datum/reagent/consumable/nutriment/vitamin = 4)
	tastes = list("slime" = 1)
	foodtype = TOXIC | SUGAR

/obj/item/reagent_containers/food/snacks/soup/blood
	name = "tomato soup"
	desc = "Smells like copper."
	icon_state = "tomatosoup"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 6)
	list_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/blood = 10, /datum/reagent/water = 5, /datum/reagent/consumable/nutriment/vitamin = 4)
	tastes = list("iron" = 1)
	foodtype = GORE //its literally blood

/obj/item/reagent_containers/food/snacks/soup/wingfangchu
	name = "wing fang chu"
	desc = "A savory dish of alien wing wang in soy."
	icon_state = "wingfangchu"
	trash = /obj/item/reagent_containers/glass/bowl
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 2)
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/soysauce = 5, /datum/reagent/consumable/nutriment/vitamin = 2)
	tastes = list("soy" = 1)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/soup/clownstears
	name = "clown's tears"
	desc = "Not very funny."
	icon_state = "clownstears"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/banana = 5, /datum/reagent/consumable/nutriment/vitamin = 8, /datum/reagent/consumable/clownstears = 10)
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/banana = 5, /datum/reagent/water = 5, /datum/reagent/consumable/nutriment/vitamin = 8, /datum/reagent/consumable/clownstears = 10)
	tastes = list("a bad joke" = 1)
	foodtype = FRUIT | SUGAR

/obj/item/reagent_containers/food/snacks/soup/vegetable
	name = "vegetable soup"
	desc = "A true vegan meal."
	icon_state = "vegetablesoup"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 4)
	tastes = list("vegetables" = 1)
	foodtype = VEGETABLES

/obj/item/reagent_containers/food/snacks/soup/nettle
	name = "nettle soup"
	desc = "To think, the botanist would've beat you to death with one of these."
	icon_state = "nettlesoup"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/medicine/omnizine = 5, /datum/reagent/consumable/nutriment/vitamin = 5)
	tastes = list("nettles" = 1)
	foodtype = VEGETABLES

/obj/item/reagent_containers/food/snacks/soup/mystery
	name = "mystery soup"
	desc = "The mystery is, why aren't you eating it?"
	icon_state = "mysterysoup"
	var/extra_reagent = null
	list_reagents = list(/datum/reagent/consumable/nutriment = 6)
	tastes = list("chaos" = 1)

/obj/item/reagent_containers/food/snacks/soup/mystery/Initialize()
	. = ..()
	extra_reagent = pick(/datum/reagent/consumable/capsaicin, /datum/reagent/consumable/frostoil, /datum/reagent/medicine/omnizine, /datum/reagent/consumable/banana, /datum/reagent/blood, /datum/reagent/toxin/slimejelly, /datum/reagent/toxin, /datum/reagent/consumable/banana, /datum/reagent/carbon, /datum/reagent/medicine/oculine)
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 6)
	bonus_reagents[extra_reagent] = 5
	reagents.add_reagent(extra_reagent, 5)

/obj/item/reagent_containers/food/snacks/soup/hotchili
	name = "hot chili"
	desc = "A five alarm Texan Chili!"
	icon_state = "hotchili"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/tomatojuice = 2, /datum/reagent/consumable/nutriment/vitamin = 2)
	list_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/consumable/capsaicin = 1, /datum/reagent/consumable/tomatojuice = 2, /datum/reagent/consumable/nutriment/vitamin = 2)
	tastes = list("hot peppers" = 1)
	foodtype = VEGETABLES | MEAT

/obj/item/reagent_containers/food/snacks/soup/coldchili
	name = "cold chili"
	desc = "This slush is barely a liquid!"
	icon_state = "coldchili"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/tomatojuice = 2, /datum/reagent/consumable/nutriment/vitamin = 2)
	list_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/consumable/frostoil = 1, /datum/reagent/consumable/tomatojuice = 2, /datum/reagent/consumable/nutriment/vitamin = 2)
	tastes = list("tomato" = 1, "mint" = 1)
	foodtype = VEGETABLES | MEAT

/obj/item/reagent_containers/food/snacks/soup/clownchili
	name = "chili con carnival"
	desc = "A delicious stew of meat, chiles, and salty, salty clown tears."
	icon_state = "clownchili"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/tomatojuice = 2, /datum/reagent/consumable/nutriment/vitamin = 2, /datum/reagent/consumable/laughter = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/consumable/capsaicin = 1, /datum/reagent/consumable/tomatojuice = 2, /datum/reagent/consumable/nutriment/vitamin = 2, /datum/reagent/consumable/banana = 1)
	tastes = list("tomato" = 1, "hot peppers" = 2, "clown feet" = 2, "kind of funny" = 2, "someone's parents" = 2)
	foodtype = VEGETABLES | MEAT

/obj/item/reagent_containers/food/snacks/soup/monkeysdelight
	name = "monkey's delight"
	desc = "A delicious soup with dumplings and hunks of monkey meat simmered to perfection, in a broth that tastes faintly of bananas."
	icon_state = "monkeysdelight"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 5)
	list_reagents = list(/datum/reagent/consumable/nutriment = 10, /datum/reagent/consumable/banana = 5, /datum/reagent/consumable/nutriment/vitamin = 5)
	tastes = list("the jungle" = 1, "banana" = 1)
	foodtype = FRUIT

/obj/item/reagent_containers/food/snacks/soup/tomato
	name = "tomato soup"
	desc = "Drinking this feels like being a vampire! A tomato vampire..."
	icon_state = "tomatosoup"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/tomatojuice = 10, /datum/reagent/consumable/nutriment/vitamin = 3)
	list_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/consumable/tomatojuice = 10, /datum/reagent/consumable/nutriment/vitamin = 3)
	tastes = list("tomato" = 1)
	foodtype = VEGETABLES

/obj/item/reagent_containers/food/snacks/soup/tomato/eyeball
	name = "eyeball soup"
	desc = "It looks back at you..."
	icon_state = "eyeballsoup"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/liquidgibs = 3)
	tastes = list("tomato" = 1, "squirming" = 1)
	foodtype = MEAT | GORE

/obj/item/reagent_containers/food/snacks/soup/milo
	name = "milosoup"
	desc = "The universes best soup! Yum!!!"
	icon_state = "milosoup"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 3)
	tastes = list("milo" = 1) // wtf is milo
	foodtype = VEGETABLES

/obj/item/reagent_containers/food/snacks/soup/mushroom
	name = "chantrelle soup"
	desc = "A delicious and hearty mushroom soup."
	icon_state = "mushroomsoup"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 5)
	list_reagents = list(/datum/reagent/consumable/nutriment = 8, /datum/reagent/consumable/nutriment/vitamin = 4)
	tastes = list("mushroom" = 1)
	foodtype = VEGETABLES

/obj/item/reagent_containers/food/snacks/soup/beet
	name = "beet soup"
	desc = "Wait, how do you spell it again..?"
	icon_state = "beetsoup"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 5)
	foodtype = VEGETABLES

/obj/item/reagent_containers/food/snacks/soup/beet/Initialize()
	. = ..()
	name = pick("borsch","bortsch","borstch","borsh","borshch","borscht")
	tastes = list(name = 1)


/obj/item/reagent_containers/food/snacks/soup/spacylibertyduff
	name = "spacy liberty duff"
	desc = "Jello gelatin, from Alfred Hubbard's cookbook."
	icon_state = "spacylibertyduff"
	bitesize = 3
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 5)
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/drug/mushroomhallucinogen = 6)
	tastes = list("jelly" = 1, "mushroom" = 1)
	foodtype = VEGETABLES

/obj/item/reagent_containers/food/snacks/soup/amanitajelly
	name = "amanita jelly"
	desc = "Looks curiously toxic."
	icon_state = "amanitajelly"
	bitesize = 3
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 5)
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/drug/mushroomhallucinogen = 3, /datum/reagent/toxin/amatoxin = 6)
	tastes = list("jelly" = 1, "mushroom" = 1)
	foodtype = VEGETABLES | TOXIC

/obj/item/reagent_containers/food/snacks/soup/stew
	name = "stew"
	desc = "A nice and warm stew. Healthy and strong."
	icon_state = "stew"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/tomatojuice = 5, /datum/reagent/consumable/nutriment/vitamin = 5)
	list_reagents = list(/datum/reagent/consumable/nutriment = 10, /datum/reagent/medicine/oculine = 5, /datum/reagent/consumable/tomatojuice = 5, /datum/reagent/consumable/nutriment/vitamin = 5)
	bitesize = 7
	volume = 100
	tastes = list("tomato" = 1, "carrot" = 1)
	foodtype = VEGETABLES

/obj/item/reagent_containers/food/snacks/soup/sweetpotato
	name = "sweet potato soup"
	desc = "Delicious sweet potato in soup form."
	icon_state = "sweetpotatosoup"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/nutriment/vitamin = 5)
	tastes = list("sweet potato" = 1)
	foodtype = VEGETABLES | SUGAR

/obj/item/reagent_containers/food/snacks/soup/beet/red
	name = "red beet soup"
	desc = "Quite a delicacy."
	icon_state = "redbeetsoup"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/nutriment/vitamin = 6)
	tastes = list("beet" = 1)
	foodtype = VEGETABLES

/obj/item/reagent_containers/food/snacks/soup/onion
	name = "french onion soup"
	desc = "Good enough to make a grown mime cry."
	icon_state = "onionsoup"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 5)
	tastes = list("caramelized onions" = 1)
	foodtype = VEGETABLES

/obj/item/reagent_containers/food/snacks/soup/bisque
	name = "bisque"
	desc = "A classic entree from Space-France."
	icon_state = "bisque"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/nutriment/vitamin = 6)
	tastes = list("creamy texture" = 1, "crab" = 4)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/soup/electron
	name = "electron soup"
	desc = "A gastronomic curiosity of ethereal origin. It is famed for the minature weather system formed over a properly prepared soup."
	icon_state = "electronsoup"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/liquidelectricity = 5)
	tastes = list("mushroom" = 1, "electrons" = 4)
	filling_color = "#CC2B52"
	foodtype = VEGETABLES | TOXIC

/obj/item/reagent_containers/food/snacks/soup/bungocurry
	name = "bungo curry"
	desc = "A spicy vegetable curry made with the humble bungo fruit, Exotic!"
	icon_state = "bungocurry"
	bonus_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 5, /datum/reagent/consumable/bungojuice = 6)
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/capsaicin = 5)
	tastes = list("bungo" = 2, "hot curry" = 4, "tropical sweetness" = 1)
	filling_color = "#E6A625"
	foodtype = VEGETABLES | FRUIT | DAIRY

/obj/item/reagent_containers/food/snacks/soup/peasoup
	name = "pea soup"
	desc = "A humble split pea soup."
	icon_state = "peasoup"
	bonus_reagents = list (/datum/reagent/consumable/nutriment/vitamin = 6, /datum/reagent/medicine/oculine = 2)
	list_reagents = list (/datum/reagent/consumable/nutriment = 8)
	tastes = list("creamy peas"= 2, "parsnip" = 1)
	filling_color = "#9dc530"
	foodtype = VEGETABLES

/obj/item/reagent_containers/food/snacks/soup/moth_cotton_soup
	name = "cotton ball soup"
	desc = "A soup made from raw cotton in a flavourful vegetable broth, originating from one of the largest Solarian moth-dominated conclaves from when they were first discovered. Enjoyed only by moths and the criminally tasteless."
	icon_state = "moth_cotton_soup"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 12,
		/datum/reagent/water = 5,
	)
	tastes = list("cotton" = 1, "broth" = 1)
	foodtype = VEGETABLES | CLOTH
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/soup/moth_cheese_soup
	name = "cheese melt soup"
	desc = "A simple and filling soup made from homemade cheese and sweet potato. \
		The curds provide texture while the whey provides volume- and they both provide deliciousness!"
	icon_state = "moth_cheese_soup"
	list_reagents = list(
		/datum/reagent/consumable/cooking_oil = 12,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/nutriment = 4,
	)
	tastes = list("cheese" = 1, "cream" = 1, "sweet potato" = 1)
	foodtype = DAIRY | GRAIN
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/soup/moth_seed_soup
	name = "seedy soup"
	desc = "A seed based soup, made by germinating seeds and then boiling them. \
		Produces a particularly bitter broth which is usually balanced by the addition of vinegar."
	icon_state = "moth_seed_soup"
	list_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 12,
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/water = 5,
	)
	tastes = list("bitterness" = 1, "sourness" = 1)
	foodtype = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/soup/vegetarian_chili
	name = "chili sin carne"
	desc = "For the hombres who don't want carne."
	icon_state = "hotchili"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/cooking_oil = 4,
		/datum/reagent/consumable/capsaicin = 3,
		/datum/reagent/consumable/tomatojuice = 4,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("bitterness" = 1, "sourness" = 1)
	foodtype = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/soup/moth_bean_stew
	name = "pickled bean stew"
	desc = "A spicy bean stew with lots of veggies, commonly served in Solarian homes as a filling and satisfying meal with rice or bread."
	icon_state = "moth_bean_stew"
	list_reagents = list(
		/datum/reagent/consumable/cooking_oil = 6,
		/datum/reagent/consumable/nutriment/vitamin = 14,
		/datum/reagent/consumable/nutriment = 4,
	)
	tastes = list("beans" = 1, "cabbage" = 1, "spicy sauce" = 1)
	foodtype = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/soup/moth_oat_stew
	name = "oat stew"
	desc = "A hearty oat stew, prepared with oats, sweet potatoes, and various winter vegetables."
	icon_state = "moth_oat_stew"
	list_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 14,
		/datum/reagent/consumable/nutriment = 8,
	)
	tastes = list("oats" = 1, "sweet potato" = 1, "carrot" = 1, "parsnip" = 1, "pumpkin" = 1)
	foodtype = VEGETABLES | GRAIN
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/soup/moth_fire_soup
	name = "fireball soup"
	desc = "Fireball soup, or heartburn soup, is a cold soup dish that originated amongst the South American elements of SolGov, \
		and is named for two things- its rosy pink colour, and its scorchingly hot chili heat."
	icon_state = "moth_fire_soup"
	list_reagents = list(
		/datum/reagent/consumable/cooking_oil = 10,
		/datum/reagent/consumable/nutriment/vitamin = 10,
	)
	tastes = list("love" = 1, "hate" = 1)
	foodtype = VEGETABLES | DAIRY
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/soup/rice_porridge
	name = "rice porridge"
	desc = "A plate of rice porridge. It's mostly flavourless, but it does fill a spot. \
		Solarians favor it on winter mornings when in a rush."
	icon_state = "rice_porridge"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 8,
	)
	tastes = list("nothing" = 1)
	foodtype = GRAIN
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/soup/hua_mulan_congee
	name = "\improper Hua Mulan congee"
	desc = "Nobody is quite sure why this smiley bowl of rice porridge with eggs and bacon is named after a mythological Chinese figure - \
		it's just sorta what it's always been called."
	icon_state = "hua_mulan_congee"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 10,
		/datum/reagent/consumable/cooking_oil = 6,
	)
	tastes = list("bacon" = 1, "eggs" = 1)
	foodtype = MEAT | GRAIN
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/soup/toechtauese_rice_porridge
	name = "töchtaüse rice porridge"
	desc = "Commonly served in Solarian homes, rice porridge with töchtaüse syrup is more palatable than the regular stuff, if even just because it's spicier than normal."
	icon_state = "toechtauese_rice_porridge"
	list_reagents = list(/datum/reagent/consumable/cooking_oil = 6, /datum/reagent/consumable/nutriment/vitamin = 12)
	tastes = list("sugar" = 1, "spice" = 1)
	foodtype = GRAIN | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/soup/cornmeal_porridge
	name = "cornmeal porridge"
	desc = "A plate of cornmeal porridge. It's more flavourful than most porridges, and makes a good base for other flavours, too."
	icon_state = "cornmeal_porridge"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("cornmeal" = 1)
	foodtype = GRAIN
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/soup/cheesy_porridge //milk, polenta, firm cheese, curd cheese, butter
	name = "cheesy porridge"
	desc = "A rich and creamy bowl of cheesy cornmeal porridge."
	icon_state = "cheesy_porridge"
	list_reagents = list(
		/datum/reagent/consumable/cooking_oil = 8,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/nutriment = 8,
	)
	tastes = list("cornmeal" = 1, "cheese" = 1, "more cheese" = 1, "lots of cheese" = 1)
	foodtype = DAIRY | GRAIN
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/soup/fried_eggplant_polenta
	name = "fried eggplant and polenta"
	desc = "Polenta loaded with cheese, served with a few discs of fried eggplant and some tomato sauce. Lække!"
	icon_state = "fried_eggplant_polenta"
	list_reagents = list(
		/datum/reagent/consumable/cooking_oil = 12,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/nutriment = 10,
	)
	tastes = list("cornmeal" = 1, "cheese" = 1, "eggplant" = 1, "tomato sauce" = 1)
	foodtype = DAIRY | GRAIN
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/soup/red_porridge
	name = "eltsløsk ül a priktæolk" //eltsløsk = red porridge, ül a = with, prikt = sour, æolk = cream
	desc = "Red porridge with yoghurt. The name and vegetable ingredients obscure the sweet nature of the dish, which is commonly served as a dessert aboard the fleet."
	icon_state = "red_porridge"
	list_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 8,
		/datum/reagent/consumable/cooking_oil = 8,
		/datum/reagent/consumable/sugar = 8,
	)
	tastes = list("sweet beets" = 1, "sugar" = 1, "sweetened yoghurt" = 1)
	foodtype = VEGETABLES | SUGAR | DAIRY

/obj/item/reagent_containers/food/snacks/soup/atrakor_dumplings
	name = "\improper Meat dumpling soup"
	desc = "A bowl of rich, meaty dumpling soup. Pleasant and hearty fare for holidays, especially during the winter"
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
	icon_state = "rootbread_soup"
	list_reagents = list(
		/datum/reagent/consumable/cooking_oil = 6,
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("bread" = 1, "egg" = 1, "chili" = 1, "garlic" = 1)
	foodtype = MEAT | VEGETABLES
