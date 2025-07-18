/obj/item/food/soup
	w_class = WEIGHT_CLASS_NORMAL
	icon = 'icons/obj/food/soupsalad.dmi'
	trash_type = /obj/item/reagent_containers/glass/bowl
	bite_consumption = 5
	max_volume = 80
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/water = 5,
		/datum/reagent/consumable/nutriment/vitamin = 4
	)
	tastes = list("tasteless soup" = 1)
	foodtypes = VEGETABLES
	eatverbs = list("slurp", "sip", "inhale", "drink")

/obj/item/food/soup/wish
	name = "wish soup"
	desc = "A bowl of water. Usually served as a joke, desperation, or out of a lack of cups."
	icon_state = "wishsoup"
	food_reagents = list(
		/datum/reagent/water = 10
	)
	tastes = list("wishes" = 1)

/obj/item/food/soup/wish/Initialize(mapload)
	. = ..()
	var/wish_true = prob(25)
	if(wish_true)
		desc = "This mouthful is strikingly filling."
		reagents.add_reagent(/datum/reagent/consumable/nutriment, 9)
		reagents.add_reagent(/datum/reagent/consumable/nutriment/vitamin, 1)

/obj/item/food/soup/meatball
	name = "meatball soup"
	desc = "A bowl of soup, primarily consisting of broth and meatballs."
	icon_state = "meatballsoup"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 8,
		/datum/reagent/water = 5
	)
	tastes = list("meat" = 1)
	foodtypes = MEAT

/obj/item/food/soup/slime
	name = "slime soup"
	desc = "A bowl of oddly thick broth, almost like a thin fruit jelly. Something about it smells odd, and it seems to try and take ahold of any utensils with its surface tension..."
	icon_state = "slimesoup"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/toxin/slimejelly = 10,
		/datum/reagent/consumable/nutriment/vitamin = 9,
		/datum/reagent/water = 5
	)
	tastes = list("slime" = 1)
	foodtypes = TOXIC | SUGAR

/obj/item/food/soup/blood
	name = "tomato soup"
	desc = "A bowl of tomato soup, which smells incredibly oversalted and strangely metallic."
	icon_state = "tomatosoup"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/blood = 10,
		/datum/reagent/water = 5,
		/datum/reagent/consumable/nutriment/vitamin = 10
	)
	tastes = list("iron" = 1)
	foodtypes = GORE //its literally blood

/obj/item/food/soup/wingfangchu
	name = "incubator soup"
	desc = "A culinary experiment involving xenomorph incubator lifeforms that have been marinated and stewed in soy sauce. It's not a successful experiment."
	icon_state = "wingfangchu"
	trash_type = /obj/item/reagent_containers/glass/bowl
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 9,
		/datum/reagent/consumable/soysauce = 10,
		/datum/reagent/consumable/nutriment/vitamin = 7
	)
	tastes = list("soy" = 1)
	foodtypes = MEAT

/obj/item/food/soup/vegetable
	name = "vegetable soup"
	desc = "A bowl of soup, consisting of vegetable broth and cooked vegetables."
	icon_state = "vegetablesoup"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 9,
		/datum/reagent/water = 5,
		/datum/reagent/consumable/nutriment/vitamin = 8
	)
	tastes = list("vegetables" = 1)
	foodtypes = VEGETABLES

/obj/item/food/soup/nettle
	name = "nettle soup"
	desc = "A traditional soup made primarily from stinging nettles, originally eaten as an ancient form of medicine by ancient humans."
	icon_state = "nettlesoup"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/water = 5,
		/datum/reagent/consumable/nutriment/vitamin = 9,
		/datum/reagent/medicine/omnizine = 5
	)
	tastes = list("nettles" = 1)
	foodtypes = VEGETABLES

/obj/item/food/soup/mystery
	name = "mystery soup"
	desc = "A soup consisting of enough ingredients to make it completely unidentifiable."
	icon_state = "mysterysoup"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 5
	)
	tastes = list("chaos" = 1)

/obj/item/food/soup/mystery/Initialize(mapload)
	. = ..()
	var/extra_reagent = null
	extra_reagent = pick(
		/datum/reagent/blood,
		/datum/reagent/carbon,
		/datum/reagent/consumable/banana,
		/datum/reagent/consumable/capsaicin,
		/datum/reagent/consumable/frostoil,
		/datum/reagent/medicine/oculine,
		/datum/reagent/medicine/omnizine,
		/datum/reagent/toxin,
		/datum/reagent/toxin/slimejelly,
		)
	reagents.add_reagent(extra_reagent, 10)
	reagents.add_reagent(/datum/reagent/consumable/nutriment, 6)

/obj/item/food/soup/hotchili
	name = "hot chili"
	desc = "A spicy stew consisting of chili peppers, beef, tomatoes, and beans. Often prepared and eaten by colonists and other frontiersfolk out of tradition. This one's incredibly spicy!"
	icon_state = "hotchili"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/capsaicin = 3,
		/datum/reagent/consumable/tomatojuice = 4,
		/datum/reagent/consumable/nutriment/vitamin = 4
	)
	tastes = list("hot peppers" = 1)
	foodtypes = VEGETABLES | MEAT

/obj/item/food/soup/coldchili
	name = "cold chili"
	desc = "A spicy(?) stew consisting of genetically modified chili peppers (chillys?), beef, tomatoes, and beans. Not for those with sensitive teeth."
	icon_state = "coldchili"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/frostoil = 3,
		/datum/reagent/consumable/tomatojuice = 4,
		/datum/reagent/consumable/nutriment/vitamin = 4
	)
	tastes = list("tomato" = 1, "mint" = 1)
	foodtypes = VEGETABLES | MEAT

/obj/item/food/soup/monkeysdelight
	name = "monkey's delight"
	desc = "A sort of soup consisting of using a culinarily prepared monkey cube, of which it is selectively reconstituted into being the main contents of the soup. Don't eat any dry chunks!"
	icon_state = "monkeysdelight"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 9,
		/datum/reagent/consumable/banana = 5,
		/datum/reagent/consumable/nutriment/vitamin = 10
	)
	tastes = list("the jungle" = 1, "banana" = 1)
	foodtypes = FRUIT

/obj/item/food/soup/tomato
	name = "tomato soup"
	desc = "A soup consisting of pureed tomatoes, primarily used in modern cuisine as a medium to be dipped in."
	icon_state = "tomatosoup"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/tomatojuice = 10,
		/datum/reagent/consumable/nutriment/vitamin = 3
	)
	tastes = list("tomato" = 1)
	foodtypes = VEGETABLES

/obj/item/food/soup/tomato/eyeball
	name = "eyeball soup"
	desc = "An adaptation of tomato soup enjoyed by sarathi with the inclusion of raw organs and meat, most notably the eyes."
	icon_state = "eyeballsoup"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/tomatojuice = 10,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/liquidgibs = 3
	)
	tastes = list("tomato" = 1, "squirming" = 1)
	foodtypes = MEAT | GORE

/obj/item/food/soup/miso
	name = "miso soup"
	desc = "A soup consisting of miso paste and stock consisting of a specific mix of edible kelp and shaved fish. Often includes tofu, mushrooms, and other additions."
	icon_state = "misosoup"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/water = 5,
		/datum/reagent/consumable/nutriment/vitamin = 4
	)
	tastes = list("miso" = 1)
	foodtypes = VEGETABLES | BREAKFAST

/obj/item/food/soup/mushroom
	name = "chantrelle soup"
	desc = "A form of cream of mushroom soup consisting primarily of chanterelles, which are often found in untended hydropons."
	icon_state = "mushroomsoup"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 9,
		/datum/reagent/consumable/nutriment/vitamin = 6
	)
	tastes = list("mushroom" = 1)
	foodtypes = VEGETABLES | DAIRY

/obj/item/food/soup/beet
	name = "beet soup"
	desc = "A sour soup consisting of a meat stock with tomatoes and beetroots. Usually served hot or cold."
	icon_state = "beetsoup"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 9,
		/datum/reagent/water = 5,
		/datum/reagent/consumable/nutriment/vitamin = 6
	)
	foodtypes = VEGETABLES

/obj/item/food/soup/spacylibertyduff
	name = "libertycap duff"
	desc = "A thick gelatin that consists of specifically hallucinogenic mushrooms rendered within in order to allow it to permeate across the gelatin body."
	icon_state = "spacylibertyduff"
	bite_consumption = 3
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/drug/mushroomhallucinogen = 6,
		/datum/reagent/consumable/nutriment/vitamin = 5
	)
	tastes = list("jelly" = 1, "mushroom" = 1)
	foodtypes = VEGETABLES

/obj/item/food/soup/amanitajelly
	name = "amanita jelly"
	desc = "A thick gelatin with the toxic fly agaric mushroom rendered within it. Still highly poisonous, despite being rendered in a sweet jelly."
	icon_state = "amanitajelly"
	bite_consumption = 3
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 7,
		/datum/reagent/drug/mushroomhallucinogen = 3,
		/datum/reagent/toxin/amatoxin = 6,
		/datum/reagent/consumable/nutriment/vitamin = 5
	)
	tastes = list("jelly" = 1, "mushroom" = 1)
	foodtypes = VEGETABLES | TOXIC

/obj/item/food/soup/stew
	name = "stew"
	desc = "A vegetable stew with a thickened, well-seasoned broth and many vegetables."
	icon_state = "stew"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 11,
		/datum/reagent/consumable/tomatojuice = 10,
		/datum/reagent/consumable/nutriment/vitamin = 6
	)
	bite_consumption = 7
	max_volume = 100
	tastes = list("tomato" = 1, "carrot" = 1)
	foodtypes = VEGETABLES | MEAT

/obj/item/food/soup/sweetpotato
	name = "sweet potato soup"
	desc = "A soup consisting of sweet potatoes boiled for extended periods of time with ginger and crystal sugar."
	icon_state = "sweetpotatosoup"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 12,
		/datum/reagent/water = 5,
		/datum/reagent/consumable/nutriment/vitamin = 6
	)
	tastes = list("sweet potato" = 1)
	foodtypes = VEGETABLES | SUGAR

/obj/item/food/soup/redbeet
	name = "red beet soup"
	desc = "A simplified form of borscht soup, notably lacking the meat broth."
	icon_state = "redbeetsoup"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 12,
		/datum/reagent/water = 5,
		/datum/reagent/consumable/nutriment/vitamin = 3
	)
	tastes = list("beet" = 1)
	foodtypes = VEGETABLES

/obj/item/food/soup/onion
	name = "french onion soup"
	desc = "A soup consisting of fried onions that are cooked in a meat stock, then gratineed with bread and cheese at the top."
	icon_state = "onionsoup"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 12,
		/datum/reagent/water = 5,
		/datum/reagent/consumable/nutriment/vitamin = 5
	)
	tastes = list("caramelized onions" = 1)
	foodtypes = VEGETABLES

/obj/item/food/soup/bisque
	name = "bisque"
	desc = "A thick, creamy soup consisting of a broth from strained shellfish."
	icon_state = "bisque"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/water = 5,
		/datum/reagent/consumable/nutriment/vitamin = 6
	)
	tastes = list("creamy texture" = 1, "crab" = 4)
	foodtypes = MEAT

/obj/item/food/soup/electron
	name = "electron soup"
	desc = "A rare example of cuisine from elzuosa, this soup takes advantage of a local mushroom's ability to briefly create plasma when subjected to an electrical current to create a sort of advanced state broth."
	icon_state = "electronsoup"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/liquidelectricity = 12
	)
	tastes = list("mushroom" = 1, "electrons" = 4)
	foodtypes = VEGETABLES | TOXIC

/obj/item/food/soup/bungocurry
	name = "bungo curry"
	desc = "A form of vegetable and fruit curry, consisting of the recently mass-market produced experiment known as the bungo fruit. Roasted and curried, it's surprisingly good."
	icon_state = "bungocurry"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/bungojuice = 9,
		/datum/reagent/consumable/capsaicin = 5,
		/datum/reagent/consumable/nutriment/vitamin = 5
	)
	tastes = list("bungo" = 2, "hot curry" = 4, "tropical sweetness" = 1)
	foodtypes = VEGETABLES | FRUIT | DAIRY

/obj/item/food/soup/oatmeal
	name = "oatmeal"
	desc = "Thicker than a bowl of oatmeal."
	icon_state = "oatmeal"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 11,
		/datum/reagent/consumable/milk = 10,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("oats" = 1, "milk" = 1)
	foodtypes = DAIRY | GRAIN | BREAKFAST

/obj/item/food/soup/miras_dola
	name = "miras-dola"
	desc = "Miras stewed with the juices of a cactus until it has absorbed the flavors. The aroma is very prominent."
	icon_state = "miras-dola"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 3,
		/datum/reagent/consumable/sugar = 1,
		/datum/reagent/consumable/vitfro = 2,
	)
	tastes = list("sweet meat" = 3, "fruity mushroom" = 2)
	foodtypes = MEAT | SUGAR | FRUIT

/obj/item/food/soup/dotiri_la
	name = "dotiri-la"
	desc = "A soup made by boiling dote berries and dotu-fime together, before adding Tiris and allowing it to soak the flavors up."
	icon_state = "miras-dola"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 3,
		/datum/reagent/consumable/sugar = 1,
	)
	tastes = list("sweet berries" = 3, "fruity meat" = 2)
	foodtypes = MEAT | FRUIT
