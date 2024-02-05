
// see code/module/crafting/table.dm

////////////////////////////////////////////////SOUP////////////////////////////////////////////////

/datum/crafting_recipe/food/meatballsoup
	name = "Meatball soup"
	reqs = list(
		/datum/reagent/water = 10,
		/obj/item/reagent_containers/glass/bowl = 1,
		/obj/item/reagent_containers/food/snacks/meatball = 1,
		/obj/item/reagent_containers/food/snacks/grown/carrot = 1,
		/obj/item/reagent_containers/food/snacks/grown/potato = 1
	)
	result = /obj/item/reagent_containers/food/snacks/soup/meatball
	subcategory = CAT_SOUP

/datum/crafting_recipe/food/vegetablesoup
	name = "Vegetable soup"
	reqs = list(
		/datum/reagent/water = 10,
		/obj/item/reagent_containers/glass/bowl = 1,
		/obj/item/reagent_containers/food/snacks/grown/carrot = 1,
		/obj/item/reagent_containers/food/snacks/grown/corn = 1,
		/obj/item/reagent_containers/food/snacks/grown/eggplant = 1,
		/obj/item/reagent_containers/food/snacks/grown/potato = 1
	)
	result = /obj/item/reagent_containers/food/snacks/soup/vegetable
	subcategory = CAT_SOUP

/datum/crafting_recipe/food/nettlesoup
	name = "Nettle soup"
	reqs = list(
		/datum/reagent/water = 10,
		/obj/item/reagent_containers/glass/bowl = 1,
		/obj/item/reagent_containers/food/snacks/grown/nettle = 1,
		/obj/item/reagent_containers/food/snacks/grown/potato = 1,
		/obj/item/reagent_containers/food/snacks/boiledegg = 1
	)
	result = /obj/item/reagent_containers/food/snacks/soup/nettle
	subcategory = CAT_SOUP

/datum/crafting_recipe/food/wingfangchu
	name = "Wingfangchu"
	reqs = list(
		/obj/item/reagent_containers/glass/bowl = 1,
		/datum/reagent/consumable/soysauce = 5,
		/obj/item/reagent_containers/food/snacks/meat/cutlet/xeno = 2
	)
	result = /obj/item/reagent_containers/food/snacks/soup/wingfangchu
	subcategory = CAT_SOUP

/datum/crafting_recipe/food/wishsoup
	name = "Wish soup"
	reqs = list(
		/datum/reagent/water = 20,
		/obj/item/reagent_containers/glass/bowl = 1
	)
	result= /obj/item/reagent_containers/food/snacks/soup/wish
	subcategory = CAT_SOUP

/datum/crafting_recipe/food/hotchili
	name = "Hot chili"
	reqs = list(
		/obj/item/reagent_containers/glass/bowl = 1,
		/obj/item/reagent_containers/food/snacks/meat/cutlet = 2,
		/obj/item/reagent_containers/food/snacks/grown/chili = 1,
		/obj/item/reagent_containers/food/snacks/grown/tomato = 1
	)
	result = /obj/item/reagent_containers/food/snacks/soup/hotchili
	subcategory = CAT_SOUP

/datum/crafting_recipe/food/coldchili
	name = "Cold chili"
	reqs = list(
		/obj/item/reagent_containers/glass/bowl = 1,
		/obj/item/reagent_containers/food/snacks/meat/cutlet = 2,
		/obj/item/reagent_containers/food/snacks/grown/icepepper = 1,
		/obj/item/reagent_containers/food/snacks/grown/tomato = 1
	)
	result = /obj/item/reagent_containers/food/snacks/soup/coldchili
	subcategory = CAT_SOUP

/datum/crafting_recipe/food/clownchili
	name = "Chili con carnival"
	reqs = list(
		/obj/item/reagent_containers/glass/bowl = 1,
		/obj/item/reagent_containers/food/snacks/meat/cutlet = 2,
		/obj/item/reagent_containers/food/snacks/grown/chili = 1,
		/obj/item/reagent_containers/food/snacks/grown/tomato = 1,
		/obj/item/clothing/shoes/clown_shoes = 1
	)
	result = /obj/item/reagent_containers/food/snacks/soup/clownchili
	subcategory = CAT_SOUP

/datum/crafting_recipe/food/tomatosoup
	name = "Tomato soup"
	reqs = list(
		/datum/reagent/water = 10,
		/obj/item/reagent_containers/glass/bowl = 1,
		/obj/item/reagent_containers/food/snacks/grown/tomato = 2
	)
	result = /obj/item/reagent_containers/food/snacks/soup/tomato
	subcategory = CAT_SOUP

/datum/crafting_recipe/food/eyeballsoup
	name = "Eyeball soup"
	reqs = list(
		/datum/reagent/water = 10,
		/obj/item/reagent_containers/glass/bowl = 1,
		/obj/item/reagent_containers/food/snacks/grown/tomato = 2,
		/obj/item/organ/eyes = 1
	)
	result = /obj/item/reagent_containers/food/snacks/soup/tomato/eyeball
	subcategory = CAT_SOUP


/datum/crafting_recipe/food/milosoup
	name = "Milo soup"
	reqs = list(
		/datum/reagent/water = 10,
		/obj/item/reagent_containers/glass/bowl = 1,
		/obj/item/reagent_containers/food/snacks/soydope = 2,
		/obj/item/reagent_containers/food/snacks/tofu = 2
	)
	result = /obj/item/reagent_containers/food/snacks/soup/milo
	subcategory = CAT_SOUP

/datum/crafting_recipe/food/bloodsoup
	name = "Blood soup"
	reqs = list(
		/datum/reagent/blood = 10,
		/obj/item/reagent_containers/glass/bowl = 1,
		/obj/item/reagent_containers/food/snacks/grown/tomato/blood = 2
	)
	result = /obj/item/reagent_containers/food/snacks/soup/blood
	subcategory = CAT_SOUP

/datum/crafting_recipe/food/slimesoup
	name = "Slime soup"
	reqs = list(
			/datum/reagent/water = 10,
			/datum/reagent/toxin/slimejelly = 5,
			/obj/item/reagent_containers/glass/bowl = 1
	)
	result = /obj/item/reagent_containers/food/snacks/soup/slime
	subcategory = CAT_SOUP

/datum/crafting_recipe/food/clownstears
	name = "Clowns tears"
	reqs = list(
		/datum/reagent/water = 10,
		/obj/item/reagent_containers/glass/bowl = 1,
		/obj/item/reagent_containers/food/snacks/grown/banana = 1,
		/obj/item/stack/ore/bananium = 1
	)
	result = /obj/item/reagent_containers/food/snacks/soup/clownstears
	subcategory = CAT_SOUP

/datum/crafting_recipe/food/mysterysoup
	name = "Mystery soup"
	reqs = list(
		/datum/reagent/water = 10,
		/obj/item/reagent_containers/glass/bowl = 1,
		/obj/item/reagent_containers/food/snacks/badrecipe = 1,
		/obj/item/reagent_containers/food/snacks/tofu = 1,
		/obj/item/reagent_containers/food/snacks/boiledegg = 1,
		/obj/item/reagent_containers/food/snacks/cheesewedge = 1,
	)
	result = /obj/item/reagent_containers/food/snacks/soup/mystery
	subcategory = CAT_SOUP

/datum/crafting_recipe/food/mushroomsoup
	name = "Mushroom soup"
	reqs = list(
		/datum/reagent/consumable/milk = 5,
		/datum/reagent/water = 5,
		/obj/item/reagent_containers/glass/bowl = 1,
		/obj/item/reagent_containers/food/snacks/grown/mushroom/chanterelle = 1
	)
	result = /obj/item/reagent_containers/food/snacks/soup/mushroom
	subcategory = CAT_SOUP

/datum/crafting_recipe/food/beetsoup
	name = "Beet soup"
	reqs = list(
		/datum/reagent/water = 10,
		/obj/item/reagent_containers/glass/bowl = 1,
		/obj/item/reagent_containers/food/snacks/grown/whitebeet = 1,
		/obj/item/reagent_containers/food/snacks/grown/cabbage = 1,
	)
	result = /obj/item/reagent_containers/food/snacks/soup/beet
	subcategory = CAT_SOUP

/datum/crafting_recipe/food/stew
	name = "Stew"
	reqs = list(
		/datum/reagent/water = 10,
		/obj/item/reagent_containers/glass/bowl = 1,
		/obj/item/reagent_containers/food/snacks/grown/tomato = 1,
		/obj/item/reagent_containers/food/snacks/meat/cutlet = 3,
		/obj/item/reagent_containers/food/snacks/grown/potato = 1,
		/obj/item/reagent_containers/food/snacks/grown/carrot = 1,
		/obj/item/reagent_containers/food/snacks/grown/eggplant = 1,
		/obj/item/reagent_containers/food/snacks/grown/mushroom = 1
	)
	result = /obj/item/reagent_containers/food/snacks/soup/stew
	subcategory = CAT_SOUP

/datum/crafting_recipe/food/spacylibertyduff
	name = "Spacy liberty duff"
	reqs = list(
		/datum/reagent/consumable/ethanol/vodka = 5,
		/obj/item/reagent_containers/glass/bowl = 1,
		/obj/item/reagent_containers/food/snacks/grown/mushroom/libertycap = 3
	)
	result = /obj/item/reagent_containers/food/snacks/soup/spacylibertyduff
	subcategory = CAT_SOUP

/datum/crafting_recipe/food/amanitajelly
	name = "Amanita jelly"
	reqs = list(
		/datum/reagent/consumable/ethanol/vodka = 5,
		/obj/item/reagent_containers/glass/bowl = 1,
		/obj/item/reagent_containers/food/snacks/grown/mushroom/amanita = 3
	)
	result = /obj/item/reagent_containers/food/snacks/soup/amanitajelly
	subcategory = CAT_SOUP

/datum/crafting_recipe/food/sweetpotatosoup
	name = "Sweet potato soup"
	reqs = list(
		/datum/reagent/water = 10,
		/datum/reagent/consumable/sugar = 5,
		/obj/item/reagent_containers/glass/bowl = 1,
		/obj/item/reagent_containers/food/snacks/grown/potato/sweet = 2
	)
	result = /obj/item/reagent_containers/food/snacks/soup/sweetpotato
	subcategory = CAT_SOUP

/datum/crafting_recipe/food/redbeetsoup
	name = "Red beet soup"
	reqs = list(
		/datum/reagent/water = 10,
		/obj/item/reagent_containers/glass/bowl = 1,
		/obj/item/reagent_containers/food/snacks/grown/redbeet = 1,
		/obj/item/reagent_containers/food/snacks/grown/cabbage = 1
	)
	result = /obj/item/reagent_containers/food/snacks/soup/beet/red
	subcategory = CAT_SOUP

/datum/crafting_recipe/food/onionsoup
	name = "French onion soup"
	reqs = list(
		/datum/reagent/water = 10,
		/obj/item/reagent_containers/glass/bowl = 1,
		/obj/item/reagent_containers/food/snacks/grown/onion = 1,
		/obj/item/reagent_containers/food/snacks/cheesewedge = 1,
	)
	result = /obj/item/reagent_containers/food/snacks/soup/onion
	subcategory = CAT_SOUP

/datum/crafting_recipe/food/bisque
	name = "Bisque"
	reqs = list(
		/datum/reagent/water = 10,
		/obj/item/reagent_containers/glass/bowl = 1,
		/obj/item/reagent_containers/food/snacks/meat/crab = 1,
		/obj/item/reagent_containers/food/snacks/salad/boiledrice = 1
	)
	result = /obj/item/reagent_containers/food/snacks/soup/bisque
	subcategory = CAT_SOUP

/datum/crafting_recipe/food/bungocurry
	name = "Bungo Curry"
	reqs = list(
		/datum/reagent/water = 5,
		/datum/reagent/consumable/cream = 5,
		/obj/item/reagent_containers/glass/bowl = 1,
		/obj/item/reagent_containers/food/snacks/grown/chili = 1,
		/obj/item/reagent_containers/food/snacks/grown/bungofruit = 1
	)
	result = /obj/item/reagent_containers/food/snacks/soup/bungocurry
	subcategory = CAT_SOUP

/datum/crafting_recipe/food/electron
	name = "Electron Soup"
	reqs = list(
		/datum/reagent/water = 10,
		/datum/reagent/consumable/sodiumchloride = 5,
		/obj/item/reagent_containers/glass/bowl = 1,
		/obj/item/reagent_containers/food/snacks/grown/mushroom/jupitercup = 1
	)
	result = /obj/item/reagent_containers/food/snacks/soup/electron
	subcategory = CAT_SOUP

/datum/crafting_recipe/food/peasoup
	name = "Pea soup"
	reqs = list(
		/datum/reagent/water = 10,
		/obj/item/reagent_containers/food/snacks/grown/peas = 2,
		/obj/item/reagent_containers/food/snacks/grown/parsnip = 1,
		/obj/item/reagent_containers/food/snacks/grown/carrot = 1
	)
	result = /obj/item/reagent_containers/food/snacks/soup/peasoup
	subcategory = CAT_SOUP

/datum/crafting_recipe/food/moth_cotton_soup
	name = "Flöfrölenmæsch (Cottonball soup)"
	reqs = list(
		/obj/item/grown/cotton = 1,
		/obj/item/reagent_containers/food/snacks/grown/onion = 1,
		/obj/item/reagent_containers/food/snacks/grown/carrot = 1,
		/obj/item/reagent_containers/food/snacks/grown/eggplant = 1,
		/obj/item/reagent_containers/food/snacks/oven_baked_corn = 1,
		/datum/reagent/water = 10,
		/obj/item/reagent_containers/glass/bowl = 1
	)
	result = /obj/item/reagent_containers/food/snacks/soup/moth_cotton_soup
	subcategory = CAT_SOUP

/datum/crafting_recipe/food/moth_cheese_soup
	name = "Ælosterrmæsch (Cheese soup)"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/cheesewedge = 2,
		/obj/item/reagent_containers/food/snacks/butter = 1,
		/obj/item/reagent_containers/food/snacks/grown/potato/sweet = 1,
		/datum/reagent/consumable/flour = 5,
		/datum/reagent/consumable/milk = 5,
		/obj/item/reagent_containers/glass/bowl = 1
	)
	result = /obj/item/reagent_containers/food/snacks/soup/moth_cheese_soup
	subcategory = CAT_SOUP

/datum/crafting_recipe/food/moth_seed_soup
	name = "Misklmæsch (Seed soup)"
	reqs = list(
		/obj/item/seeds/sunflower = 1,
		/obj/item/seeds/poppy/lily = 1,
		/obj/item/seeds/ambrosia = 1,
		/datum/reagent/water = 10,
		/datum/reagent/consumable/vinegar = 5,
		/obj/item/reagent_containers/glass/bowl = 1
	)
	result = /obj/item/reagent_containers/food/snacks/soup/moth_seed_soup
	subcategory = CAT_SOUP

/datum/crafting_recipe/food/moth_bean_stew
	name = "Prickeldröndolhaskl (Spicy bean stew)"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/canned/beans = 1,
		/obj/item/reagent_containers/food/snacks/grown/cabbage = 1,
		/obj/item/reagent_containers/food/snacks/grown/tomato = 1,
		/obj/item/reagent_containers/food/snacks/grown/onion = 1,
		/obj/item/reagent_containers/food/snacks/grown/chili = 1,
		/obj/item/reagent_containers/food/snacks/oven_baked_corn = 1,
		/datum/reagent/water = 5,
		/obj/item/reagent_containers/glass/bowl = 1
	)
	result = /obj/item/reagent_containers/food/snacks/soup/moth_bean_stew
	subcategory = CAT_SOUP

/datum/crafting_recipe/food/moth_oat_stew
	name = "Häfmisklhaskl (Oat stew)"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/grown/oat = 1,
		/obj/item/reagent_containers/food/snacks/grown/potato/sweet = 1,
		/obj/item/reagent_containers/food/snacks/grown/parsnip = 1,
		/obj/item/reagent_containers/food/snacks/grown/carrot = 1,
		/datum/reagent/water = 5,
		/obj/item/reagent_containers/glass/bowl = 1
	)
	result = /obj/item/reagent_containers/food/snacks/soup/moth_oat_stew
	subcategory = CAT_SOUP

/datum/crafting_recipe/food/moth_fire_soup
	name = "Tömpröttkrakklmæsch (Heartburn soup)"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/grown/ghost_chili = 1,
		/obj/item/reagent_containers/food/snacks/tofu = 1,
		/datum/reagent/consumable/yoghurt = 10,
		/datum/reagent/consumable/vinegar = 2,
		/obj/item/reagent_containers/glass/bowl = 1
	)
	result = /obj/item/reagent_containers/food/snacks/soup/moth_fire_soup
	subcategory = CAT_SOUP

/datum/crafting_recipe/food/rice_porridge
	name = "Rice porridge"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/salad/ricebowl = 1,
		/datum/reagent/water = 10,
		/datum/reagent/consumable/sodiumchloride = 2
	)
	result = /obj/item/reagent_containers/food/snacks/soup/rice_porridge
	subcategory = CAT_SOUP

/datum/crafting_recipe/food/hua_mulan_congee
	name = "Hua Mulan congee"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/soup/rice_porridge = 1,
		/obj/item/reagent_containers/food/snacks/meat/bacon = 1,
		/obj/item/reagent_containers/food/snacks/friedegg = 2
	)
	result = /obj/item/reagent_containers/food/snacks/soup/hua_mulan_congee
	subcategory = CAT_SOUP

/datum/crafting_recipe/food/toechtauese_rice_porridge
	name = "Töchtaüse rice porridge"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/soup/rice_porridge = 1,
		/obj/item/reagent_containers/food/snacks/grown/chili = 1,
		/datum/reagent/consumable/toechtauese_syrup = 5
	)
	result = /obj/item/reagent_containers/food/snacks/soup/toechtauese_rice_porridge
	subcategory = CAT_SOUP

/datum/crafting_recipe/food/cornmeal_porridge
	name = "Cornmeal porridge"
	reqs = list(
		/datum/reagent/consumable/cornmeal = 10,
		/datum/reagent/water = 10,
		/obj/item/reagent_containers/glass/bowl = 1
	)
	result = /obj/item/reagent_containers/food/snacks/soup/cornmeal_porridge
	subcategory = CAT_SOUP

/datum/crafting_recipe/food/cheesy_porridge
	name = "Cheesy porridge"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/soup/cornmeal_porridge = 1,
		/datum/reagent/consumable/milk = 5,
		/obj/item/reagent_containers/food/snacks/firm_cheese = 1,
		/obj/item/reagent_containers/food/snacks/curd_cheese = 1,
		/obj/item/reagent_containers/food/snacks/butter = 1
	)
	result = /obj/item/reagent_containers/food/snacks/soup/cheesy_porridge
	subcategory = CAT_SOUP

/datum/crafting_recipe/food/fried_eggplant_polenta
	name = "Fried eggplant and polenta"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/soup/cheesy_porridge = 1,
		/obj/item/reagent_containers/food/snacks/grown/eggplant = 1,
		/obj/item/reagent_containers/food/snacks/breadslice = 2,
		/obj/item/reagent_containers/food/snacks/tomato_sauce = 1,
		/obj/item/reagent_containers/food/snacks/mozzarella = 1
	)
	result = /obj/item/reagent_containers/food/snacks/soup/fried_eggplant_polenta
	subcategory = CAT_SOUP

/datum/crafting_recipe/food/red_porridge
	name = "Eltsløsk ül a priktæolk (Red Porridge and Yoghurt)"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/grown/redbeet = 1,
		/datum/reagent/consumable/vanilla = 5,
		/datum/reagent/consumable/yoghurt = 10,
		/datum/reagent/consumable/sugar = 5
	)
	result = /obj/item/reagent_containers/food/snacks/soup/red_porridge
	subcategory = CAT_SOUP

/datum/crafting_recipe/food/atrakor_dumplings
	name = "Atrakor dumpling soup"
	reqs = list(
		/datum/reagent/water = 10,
		/obj/item/reagent_containers/glass/bowl = 1,
		/obj/item/reagent_containers/food/snacks/meat/rawcutlet = 2,
		/obj/item/reagent_containers/food/snacks/grown/onion = 1,
		/obj/item/reagent_containers/food/snacks/lizard_dumplings = 1,
		/datum/reagent/consumable/soysauce = 5
	)
	result = /obj/item/reagent_containers/food/snacks/soup/atrakor_dumplings
	subcategory = CAT_SOUP

/datum/crafting_recipe/food/meatball_noodles
	name = "Meatball noodle soup"
	reqs = list(
		/datum/reagent/water = 10,
		/obj/item/reagent_containers/glass/bowl = 1,
		/obj/item/reagent_containers/food/snacks/meat/rawcutlet = 2,
		/obj/item/reagent_containers/food/snacks/grown/onion = 1,
		/obj/item/reagent_containers/food/snacks/spaghetti/nizaya = 1,
		/obj/item/reagent_containers/food/snacks/meatball = 2,
		/obj/item/reagent_containers/food/snacks/grown/korta_nut = 1
	)
	result = /obj/item/reagent_containers/food/snacks/soup/meatball_noodles
	subcategory = CAT_SOUP

/datum/crafting_recipe/food/black_broth
	name = "Kalixcian black broth"
	reqs = list(
		/obj/item/reagent_containers/glass/bowl = 1,
		/obj/item/reagent_containers/food/snacks/kalixcian_sausage = 1,
		/obj/item/reagent_containers/food/snacks/grown/onion = 1,
		/datum/reagent/consumable/vinegar = 5,
		/datum/reagent/blood = 5,
		/datum/reagent/consumable/ice = 2
	)
	result = /obj/item/reagent_containers/food/snacks/soup/black_broth
	subcategory = CAT_SOUP

/datum/crafting_recipe/food/jellyfish_stew
	name = "Jellyfish stew"
	reqs = list(
		/obj/item/reagent_containers/glass/bowl = 1,
		/obj/item/reagent_containers/food/snacks/canned/jellyfish = 1,
		/obj/item/reagent_containers/food/snacks/grown/soybeans = 1,
		/obj/item/reagent_containers/food/snacks/grown/redbeet = 1,
		/obj/item/reagent_containers/food/snacks/grown/potato = 1
	)
	result = /obj/item/reagent_containers/food/snacks/soup/jellyfish
	subcategory = CAT_SOUP

/datum/crafting_recipe/food/rootbread_soup
	name = "Rootbread soup"
	reqs = list(
		/obj/item/reagent_containers/glass/bowl = 1,
		/obj/item/reagent_containers/food/snacks/breadslice/root = 2,
		/obj/item/reagent_containers/food/snacks/grown/garlic = 1,
		/obj/item/reagent_containers/food/snacks/grown/chili = 1,
		/obj/item/reagent_containers/food/snacks/egg = 1
	)
	result = /obj/item/reagent_containers/food/snacks/soup/rootbread_soup
	subcategory = CAT_SOUP
