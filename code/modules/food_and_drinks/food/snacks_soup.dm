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
	desc = "A bowl of water. Usually served as a joke, desperation, or out of a lack of cups."
	icon_state = "wishsoup"
	list_reagents = list(/datum/reagent/water = 10)
	tastes = list("wishes" = 1)

/obj/item/reagent_containers/food/snacks/soup/wish/Initialize()
	. = ..()
	var/wish_true = prob(25)
	if(wish_true)
		desc = "This mouthful is strikingly filling."
		bonus_reagents = list(/datum/reagent/consumable/nutriment = 9, /datum/reagent/consumable/nutriment/vitamin = 1)
	if(wish_true)
		reagents.add_reagent(/datum/reagent/consumable/nutriment, 9)
		reagents.add_reagent(/datum/reagent/consumable/nutriment/vitamin, 1)
		foodtype = VEGETABLES

/obj/item/reagent_containers/food/snacks/soup/meatball
	name = "meatball soup"
	desc = "A bowl of soup, primarily consisting of broth and meatballs."
	icon_state = "meatballsoup"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 5)
	tastes = list("meat" = 1)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/soup/slime
	name = "slime soup"
	desc = "A bowl of oddly thick broth, almost like a thin fruit jelly. Something about it smells odd, and it seems to try and take ahold of any utensils with its surface tension..."
	icon_state = "slimesoup"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/toxin/slimejelly = 5, /datum/reagent/consumable/nutriment/vitamin = 5)
	list_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/toxin/slimejelly = 5, /datum/reagent/water = 5, /datum/reagent/consumable/nutriment/vitamin = 4)
	tastes = list("slime" = 1)
	foodtype = TOXIC | SUGAR

/obj/item/reagent_containers/food/snacks/soup/blood
	name = "tomato soup"
	desc = "A bowl of tomato soup, which smells incredibly oversalted and strangely metallic."
	icon_state = "tomatosoup"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 6)
	list_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/blood = 10, /datum/reagent/water = 5, /datum/reagent/consumable/nutriment/vitamin = 4)
	tastes = list("iron" = 1)
	foodtype = GORE //its literally blood

/obj/item/reagent_containers/food/snacks/soup/wingfangchu
	name = "incubator soup"
	desc = "A culinary experiment involving xenomorph incubator lifeforms that have been marinated and stewed in soy sauce. It's not a successful experiment."
	icon_state = "wingfangchu"
	trash = /obj/item/reagent_containers/glass/bowl
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 2)
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/soysauce = 5, /datum/reagent/consumable/nutriment/vitamin = 2)
	tastes = list("soy sauce and rubber" = 1)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/soup/vegetable
	name = "vegetable soup"
	desc = "A bowl of soup, consisting of vegetable broth and cooked vegetables."
	icon_state = "vegetablesoup"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 4)
	tastes = list("vegetables" = 1)
	foodtype = VEGETABLES

/obj/item/reagent_containers/food/snacks/soup/nettle
	name = "nettle soup"
	desc = "A traditional soup made primarily from stinging nettles, originally eaten as an ancient form of medicine by ancient humans."
	icon_state = "nettlesoup"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/medicine/omnizine = 5, /datum/reagent/consumable/nutriment/vitamin = 5)
	tastes = list("nettles" = 1)
	foodtype = VEGETABLES

/obj/item/reagent_containers/food/snacks/soup/mystery
	name = "mystery soup"
	desc = "A soup consisting of enough ingredients to make it completely unidentifiable."
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
	desc = "A spicy stew consisting of chili peppers, beef, tomatoes, and beans. Often prepared and eaten by colonists and other frontiersfolk out of tradition. This one's incredibly spicy!"
	icon_state = "hotchili"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/tomatojuice = 2, /datum/reagent/consumable/nutriment/vitamin = 2)
	list_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/consumable/capsaicin = 1, /datum/reagent/consumable/tomatojuice = 2, /datum/reagent/consumable/nutriment/vitamin = 2)
	tastes = list("hot peppers" = 1)
	foodtype = VEGETABLES | MEAT

/obj/item/reagent_containers/food/snacks/soup/coldchili
	name = "cold chili"
	desc = "A spicy(?) stew consisting of genetically modified chili peppers (chillys?), beef, tomatoes, and beans. Not for those with sensitive teeth."
	icon_state = "coldchili"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/tomatojuice = 2, /datum/reagent/consumable/nutriment/vitamin = 2)
	list_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/consumable/frostoil = 1, /datum/reagent/consumable/tomatojuice = 2, /datum/reagent/consumable/nutriment/vitamin = 2)
	tastes = list("tomato" = 1, "mint" = 1)
	foodtype = VEGETABLES | MEAT

/obj/item/reagent_containers/food/snacks/soup/meatchili
	name = "chili con carne"
	desc = "A spicy stew consisting of chili peppers, beef, tomatoes, and beans. Often prepared and eaten by colonists and other frontiersfolk out of tradition."
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/tomatojuice = 2, /datum/reagent/consumable/nutriment/vitamin = 2)
	list_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/consumable/capsaicin = 1, /datum/reagent/consumable/tomatojuice = 2, /datum/reagent/consumable/nutriment/vitamin = 2)
	tastes = list("tomato" = 1, "hot peppers" = 2, "meat" = 2, "spice" = 2)
	foodtype = VEGETABLES | MEAT

/obj/item/reagent_containers/food/snacks/soup/monkeysdelight
	name = "monkey's delight"
	desc = "A sort of soup consisting of using a culinarily prepared monkey cube, of which it is selectively reconstituted into being the main contents of the soup. Don't eat any dry chunks!"
	icon_state = "monkeysdelight"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 5)
	list_reagents = list(/datum/reagent/consumable/nutriment = 10, /datum/reagent/consumable/banana = 5, /datum/reagent/consumable/nutriment/vitamin = 5)
	tastes = list("odd broth" = 1, "furred meat" = 1)
	foodtype = FRUIT //???

/obj/item/reagent_containers/food/snacks/soup/tomato
	name = "tomato soup"
	desc = "A soup consisting of pureed tomatoes, primarily used in modern cuisine as a medium to be dipped in."
	icon_state = "tomatosoup"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/tomatojuice = 10, /datum/reagent/consumable/nutriment/vitamin = 3)
	list_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/consumable/tomatojuice = 10, /datum/reagent/consumable/nutriment/vitamin = 3)
	tastes = list("tomato" = 1)
	foodtype = VEGETABLES

/obj/item/reagent_containers/food/snacks/soup/tomato/eyeball
	name = "eyeball soup"
	desc = "An adaptation of tomato soup enjoyed by sarathi with the inclusion of raw organs and meat, most notably the eyes."
	icon_state = "eyeballsoup"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/liquidgibs = 3)
	tastes = list("tomato" = 1, "squish" = 1)
	foodtype = MEAT | GORE

/obj/item/reagent_containers/food/snacks/soup/miso
	name = "miso soup"
	desc = "A soup consisting of miso paste and stock consisting of a specific mix of edible kelp and shaved fish. Often includes tofu, mushrooms, and other additions."
	icon_state = "misosoup"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 3)
	tastes = list("miso" = 1)
	foodtype = VEGETABLES

/obj/item/reagent_containers/food/snacks/soup/mushroom
	name = "chantrelle soup"
	desc = "A form of cream of mushroom soup consisting primarily of chanterelles, which are often found in untended hydropons."
	icon_state = "mushroomsoup"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 5)
	list_reagents = list(/datum/reagent/consumable/nutriment = 8, /datum/reagent/consumable/nutriment/vitamin = 4)
	tastes = list("mushroom" = 1)
	foodtype = VEGETABLES

/obj/item/reagent_containers/food/snacks/soup/beet
	name = "borscht"
	desc = "A sour soup consisting of a meat stock with tomatoes and beetroots. Usually served hot or cold."
	icon_state = "beetsoup"
	tastes = list("sweet and tart beets" = 1, "rich broth" = 1)
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 5)
	foodtype = VEGETABLES

/obj/item/reagent_containers/food/snacks/soup/spacylibertyduff
	name = "libertycap duff"
	desc = "A thick gelatin that consists of specifically hallucinogenic mushrooms rendered within in order to allow it to permeate across the gelatin body."
	icon_state = "spacylibertyduff"
	bitesize = 3
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 5)
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/drug/mushroomhallucinogen = 6)
	tastes = list("jelly" = 1, "mushroom" = 1)
	foodtype = VEGETABLES

/obj/item/reagent_containers/food/snacks/soup/amanitajelly
	name = "amanita jelly"
	desc = "A thick gelatin with the toxic fly agaric mushroom rendered within it. Still highly poisonous, despite being rendered in a sweet jelly."
	icon_state = "amanitajelly"
	bitesize = 3
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 5)
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/drug/mushroomhallucinogen = 3, /datum/reagent/toxin/amatoxin = 6)
	tastes = list("jelly" = 1, "mushroom" = 1)
	foodtype = VEGETABLES | TOXIC

/obj/item/reagent_containers/food/snacks/soup/stew
	name = "stew"
	desc = "A vegetable stew with a thickened, well-seasoned broth and many vegetables."
	icon_state = "stew"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/tomatojuice = 5, /datum/reagent/consumable/nutriment/vitamin = 5)
	list_reagents = list(/datum/reagent/consumable/nutriment = 10, /datum/reagent/medicine/oculine = 5, /datum/reagent/consumable/tomatojuice = 5, /datum/reagent/consumable/nutriment/vitamin = 5)
	bitesize = 7
	volume = 100
	tastes = list("tomato" = 1, "carrot" = 1)
	foodtype = VEGETABLES

/obj/item/reagent_containers/food/snacks/soup/sweet_potato
	name = "sweet potato soup"
	desc = "A soup consisting of sweet potatoes boiled for extended periods of time with ginger and crystal sugar."
	icon_state = "sweetpotatosoup"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/nutriment/vitamin = 5)
	tastes = list("sweet potato" = 1)
	foodtype = VEGETABLES | SUGAR

/obj/item/reagent_containers/food/snacks/soup/beet/red
	name = "red beet soup"
	desc = "A simplified form of borscht soup, notably lacking the meat broth."
	icon_state = "redbeetsoup"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/nutriment/vitamin = 6)
	tastes = list("beet" = 1)
	foodtype = VEGETABLES //why is this in the game alongside actual borscht? what are they cooking here? we don't even have beetroot in the game AAARRGHHHH!!!!!

/obj/item/reagent_containers/food/snacks/soup/onion
	name = "french onion soup"
	desc = "A soup consisting of fried onions that are cooked in a meat stock, then gratineed with bread and cheese at the top."
	icon_state = "onionsoup"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 5)
	tastes = list("caramelized onions" = 1)
	foodtype = VEGETABLES

/obj/item/reagent_containers/food/snacks/soup/bisque
	name = "bisque"
	desc = "A thick, creamy soup consisting of a broth from strained shellfish."
	icon_state = "bisque"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/nutriment/vitamin = 6)
	tastes = list("creamy texture" = 1, "crab" = 4)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/soup/electron
	name = "electron soup"
	desc = "A rare example of cuisine from elzuosa, this soup takes advantage of a local mushroom's ability to briefly create plasma when subjected to an electrical current to create a sort of advanced state broth."
	icon_state = "electronsoup"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/liquidelectricity = 5)
	tastes = list("mushroom" = 1, "electrons" = 4)
	filling_color = "#CC2B52"
	foodtype = VEGETABLES | TOXIC

/obj/item/reagent_containers/food/snacks/soup/bungocurry
	name = "bungo curry"
	desc = "A form of vegetable and fruit curry, consisting of the recently mass-market produced experiment known as the bungo fruit. Roasted and curried, it's surprisingly good."
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

/obj/item/reagent_containers/food/snacks/soup/miras_dola
	name = "Miras-dola"
	desc = "Miras stewed with the juices of a cactus until it has absorbed the flavors. The aroma is very prominent."
	icon_state = "miras-dola"
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/nutriment/vitamin = 3, /datum/reagent/consumable/sugar = 1)
	bonus_reagents = list(/datum/reagent/consumable/vitfro = 2)
	tastes = list("sweet meat" = 3, "fruity mushroom" = 2)
	foodtype = MEAT | SUGAR | FRUIT

/obj/item/reagent_containers/food/snacks/soup/dotiri_la
	name = "dotiri-la"
	desc = "A soup made by boiling dote berries and dotu-fime together, before adding Tiris and allowing it to soak the flavors up."
	icon_state = "miras-dola"
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/nutriment/vitamin = 3, /datum/reagent/consumable/sugar = 1)
	tastes = list("sweet berries" = 3, "fruity meat" = 2)
	foodtype = MEAT | FRUIT
