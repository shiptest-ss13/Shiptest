/obj/effect/spawner/random/food_or_drink
	name = "food or drink loot spawner"
	desc = "Nom nom nom"
	icon_state = "soup"

/obj/effect/spawner/random/food_or_drink/donkpockets
	name = "donk pocket box spawner"
	icon_state = "donkpocket"
	loot = list(
		/obj/item/storage/box/donkpockets/donkpocketspicy = 1,
		/obj/item/storage/box/donkpockets/donkpocketteriyaki = 1,
		/obj/item/storage/box/donkpockets/donkpocketpizza = 1,
		/obj/item/storage/box/donkpockets/donkpocketberry = 1,
		)

/obj/effect/spawner/random/food_or_drink/ration
	name = "ration spawner"
	icon_state = "pizzabox"
	loot = list (
		/obj/item/storage/ration/vegan_chili = 5,
		/obj/item/storage/ration/shredded_beef = 5,
		/obj/item/storage/ration/pork_spaghetti = 5,
		/obj/item/storage/ration/fried_fish = 5,
		/obj/item/storage/ration/beef_strips = 5,
		/obj/item/storage/ration/chili_macaroni = 5,
		/obj/item/storage/ration/chicken_wings_hot_sauce = 5,
		/obj/item/storage/ration/fish_stew = 5,
		/obj/item/storage/ration/lemon_pepper_chicken = 5,
		/obj/item/storage/ration/sausage_peppers_onions = 5,
		/obj/item/storage/ration/pork_dumplings_chili_sauce = 5,
		/obj/item/storage/ration/battered_fish_sticks = 5,
		/obj/item/storage/ration/assorted_salted_offal = 5,
		/obj/item/storage/ration/maple_pork_sausage_patty = 5,
		/obj/item/storage/ration/pepper_jack_beef_patty = 5,
		/obj/item/storage/ration/beef_goulash = 5,
		/obj/item/storage/ration/pepperoni_pizza_slice = 5,
		/obj/item/storage/ration/blackened_calamari = 5,
		/obj/item/storage/ration/elbow_macaroni = 5,
		/obj/item/storage/ration/cheese_pizza_slice = 5,
		/obj/item/storage/ration/sososi = 5,
		/obj/item/storage/ration/dofidote = 5,
		/obj/item/storage/ration/miras = 5,
		/obj/item/storage/ration/crayons = 1 // :)
		)

/obj/effect/spawner/random/food_or_drink/donut
	name = "random donut"
	icon_state = "donut"
	loot = list(
		/obj/item/food/donut/apple = 1,
		/obj/item/food/donut/berry = 1,
		/obj/item/food/donut/caramel = 1,
		/obj/item/food/donut/choco = 1,
		/obj/item/food/donut/matcha = 1,
		/obj/item/food/donut/meat = 1,
		/obj/item/food/donut/plain = 1,
		/obj/item/food/donut/trumpet = 1,
		/obj/item/food/donut/blumpkin = 1,
		/obj/item/food/donut/bungo = 1,
		/obj/item/food/donut/chaos = 1,
		)

/obj/effect/spawner/random/food_or_drink/donut/jelly
	name = "random jelly donut"
	loot = list(
		/obj/item/food/donut/jelly/berry = 1,
		/obj/item/food/donut/jelly/apple = 1,
		/obj/item/food/donut/jelly/blumpkin = 1,
		/obj/item/food/donut/jelly/bungo = 1,
		/obj/item/food/donut/jelly/caramel = 1,
		/obj/item/food/donut/jelly/choco = 1,
		/obj/item/food/donut/jelly/matcha = 1,
		/obj/item/food/donut/jelly/plain = 1,
		/obj/item/food/donut/jelly/trumpet = 1,
		)

/obj/effect/spawner/random/food_or_drink/donut/slimejelly
	name = "random slimejelly donut"
	loot = list(
		/obj/item/food/donut/jelly/slimejelly/apple = 1,
		/obj/item/food/donut/jelly/slimejelly/berry = 1,
		/obj/item/food/donut/jelly/slimejelly/blumpkin = 1,
		/obj/item/food/donut/jelly/slimejelly/bungo = 1,
		/obj/item/food/donut/jelly/slimejelly/caramel = 1,
		/obj/item/food/donut/jelly/slimejelly/choco = 1,
		/obj/item/food/donut/jelly/slimejelly/matcha = 1,
		/obj/item/food/donut/jelly/slimejelly/plain = 1,
		/obj/item/food/donut/jelly/slimejelly/trumpet = 1,
		)

/obj/effect/spawner/random/food_or_drink/three_course_meal
	name = "three course meal spawner"
	spawn_loot_count = 3
	spawn_loot_double = FALSE
	var/soups = list(
			/obj/item/food/soup/beet,
			/obj/item/food/soup/sweetpotato,
			/obj/item/food/soup/stew,
			/obj/item/food/soup/hotchili,
			/obj/item/food/soup/nettle,
			/obj/item/food/soup/meatball,
			)
	var/salads = list(
			/obj/item/food/salad/herbsalad,
			/obj/item/food/salad/validsalad,
			/obj/item/food/salad/fruit,
			/obj/item/food/salad/jungle,
			/obj/item/food/salad/aesirsalad,
			)
	var/mains = list(
			/obj/item/food/bearsteak,
			/obj/item/food/enchiladas,
			/obj/item/food/stewedsoymeat,
			/obj/item/food/burger/bigbite,
			/obj/item/food/burger/superbite,
			/obj/item/food/burger/fivealarm,
			)

/obj/effect/spawner/random/food_or_drink/three_course_meal/Initialize(mapload)
	loot = list(pick(soups) = 1,pick(salads) = 1,pick(mains) = 1)
	. = ..()

/obj/effect/spawner/random/food_or_drink/garden
	name = "lush garden seeder"
	spawn_loot_count = 3
	loot = list(
			/obj/item/food/grown/ambrosia/deus = 1,
			/obj/item/food/grown/berries/death/stealth = 2,
			/obj/item/food/grown/citrus/orange_3d = 1,
			/obj/item/food/grown/trumpet = 1,
			/obj/item/food/grown/bungofruit = 1,
			/obj/item/seeds/random = 1,
			/obj/item/grown/log/bamboo = 2,
			/obj/item/food/grown/ambrosia/vulgaris = 2,
			/obj/item/food/grown/berries/poison/stealth = 5,
			/obj/item/food/grown/citrus/lemon = 2,
			/obj/item/food/grown/citrus/lime = 2,
			/obj/item/food/grown/vanillapod = 2,
			/obj/item/food/grown/moonflower = 2,
			/obj/item/food/grown/cocoapod = 2,
			/obj/item/food/grown/pineapple = 2,
			/obj/item/food/grown/poppy/lily = 2,
			/obj/item/food/grown/poppy/geranium = 2,
			/obj/item/food/grown/sugarcane = 2,
			/obj/item/food/grown/tea = 2,
			/obj/item/food/grown/tobacco = 2,
			/obj/item/food/grown/watermelon = 4,
			/obj/item/grown/sunflower = 4,
			/obj/item/food/grown/banana = 4,
			/obj/item/food/grown/apple = 4,
			/obj/item/food/grown/berries = 5,
			/obj/item/food/grown/cherries = 4,
			/obj/item/food/grown/citrus/orange = 4,
			/obj/item/food/grown/garlic = 4,
			/obj/item/food/grown/grapes = 4,
			/obj/item/food/grown/grass = 5,
			/obj/item/food/grown/pumpkin = 4,
			/obj/item/food/grown/rainbow_flower = 4,
			/obj/item/food/grown/wheat = 4,
			/obj/item/food/grown/parsnip = 4,
			/obj/item/food/grown/peas = 4,
			/obj/item/food/grown/rice = 4,
			/obj/item/food/grown/soybeans = 4,
			/obj/item/food/grown/tomato = 4,
			/obj/item/food/grown/cabbage = 4,
			/obj/item/food/grown/onion = 4,
			/obj/item/food/grown/carrot = 4,
			/obj/item/food/grown/dotu_fime = 4,
			/obj/item/food/grown/siti = 4,
			/obj/item/food/grown/sososi = 4,
			)

/obj/effect/spawner/random/food_or_drink/garden/arid
	name = "arid garden seeder"
	loot = list(
		/obj/item/food/grown/ghost_chili = 1,
		/obj/item/food/grown/nettle = 1,
		/obj/item/grown/cotton/durathread = 1,
		/obj/item/seeds/random = 1,
		/obj/item/food/grown/redbeet = 1,
		/obj/item/food/grown/aloe = 2,
		/obj/item/grown/cotton = 2,
		/obj/item/food/grown/mushroom/angel = 2,
		/obj/item/food/grown/chili = 2,
		/obj/item/food/grown/whitebeet = 5,
		/obj/item/food/grown/dotu_fime = 4,
		/obj/item/food/grown/siti = 4,
		/obj/item/food/grown/refa_li = 2,
		/obj/item/food/grown/dote_berries = 8,
		/obj/item/food/grown/sososi = 4,
		/obj/item/food/grown/fara_li = 3,
		/obj/item/food/grown/potato = 4,
		/obj/item/food/grown/sweet_potato = 4,
		/obj/item/food/grown/mushroom/chanterelle = 4,
		/obj/item/food/grown/mushroom/plumphelmet = 4,
		/obj/item/food/grown/corn = 4,
		)

/obj/effect/spawner/random/food_or_drink/garden/cold
	name = "frigid garden seeder"
	loot = list(
		/obj/item/food/grown/bluecherries = 1,
		/obj/item/food/grown/galaxythistle = 1,
		/obj/item/food/grown/berries/death/stealth = 1,
		/obj/item/seeds/random = 1,
		/obj/item/food/grown/poppy = 2,
		/obj/item/food/grown/tomato/blue = 2,
		/obj/item/food/grown/berries/poison/stealth = 2,
		/obj/item/food/grown/berries = 4,
		/obj/item/food/grown/mushroom/chanterelle = 4,
		/obj/item/food/grown/oat = 4,
		/obj/item/food/grown/grapes/green = 4,
		/obj/item/food/grown/grass = 4,
		/obj/item/food/grown/harebell = 5,
		/obj/item/seeds/starthistle = 5,
		)

/obj/effect/spawner/random/food_or_drink/garden/sick
	name = "sickly garden seeder"
	loot = list(
		/obj/item/food/grown/cannabis/rainbow = 1,
		/obj/item/food/grown/cannabis/death = 1,
		/obj/item/seeds/replicapod = 1,
		/obj/item/food/grown/mushroom/angel = 1,
		/obj/item/food/grown/mushroom/libertycap = 2,
		/obj/item/seeds/tower/steel = 2,
		/obj/item/food/grown/cannabis = 2,
		/obj/item/seeds/random = 2,
		/obj/item/food/grown/mushroom/jupitercup = 2,
		/obj/item/food/grown/cherrybulbs = 4,
		/obj/item/food/grown/mushroom/amanita = 4,
		/obj/item/food/grown/mushroom/libertycap = 4,
		/obj/item/food/grown/mushroom/reishi = 4,
		/obj/item/food/grown/berries/glow = 4,
		)

/obj/effect/spawner/random/food_or_drink/garden/seaweed
	name = "seaweed patch seeder"
	loot = list(
		/obj/item/food/grown/seaweed,
		)

/obj/effect/spawner/random/food_or_drink/seed
	name = "GO FORTH AND CULTIVATE"
	icon_state = "seed"
	loot = list(
		/obj/item/seeds/aloe,
		/obj/item/seeds/ambrosia,
		/obj/item/seeds/apple,
		/obj/item/seeds/cotton,
		/obj/item/seeds/banana,
		/obj/item/seeds/berry,
		/obj/item/seeds/cabbage,
		/obj/item/seeds/carrot,
		/obj/item/seeds/cherry,
		/obj/item/seeds/chanter,
		/obj/item/seeds/chili,
		/obj/item/seeds/cocoapod,
		/obj/item/seeds/coffee,
		/obj/item/seeds/corn,
		/obj/item/seeds/eggplant,
		/obj/item/seeds/garlic,
		/obj/item/seeds/grape,
		/obj/item/seeds/grass,
		/obj/item/seeds/lemon,
		/obj/item/seeds/lime,
		/obj/item/seeds/onion,
		/obj/item/seeds/orange,
		/obj/item/seeds/peas,
		/obj/item/seeds/pineapple,
		/obj/item/seeds/potato,
		/obj/item/seeds/poppy,
		/obj/item/seeds/pumpkin,
		/obj/item/seeds/wheat/rice,
		/obj/item/seeds/soya,
		/obj/item/seeds/sugarcane,
		/obj/item/seeds/sunflower,
		/obj/item/seeds/tea,
		/obj/item/seeds/tobacco,
		/obj/item/seeds/tomato,
		/obj/item/seeds/tower,
		/obj/item/seeds/watermelon,
		/obj/item/seeds/wheat,
		/obj/item/seeds/whitebeet,
		/obj/item/seeds/amanita,
		/obj/item/seeds/glowshroom,
		/obj/item/seeds/liberty,
		/obj/item/seeds/nettle,
		/obj/item/seeds/plump,
		/obj/item/seeds/reishi,
		/obj/item/seeds/cannabis,
		/obj/item/seeds/starthistle,
		/obj/item/seeds/berry/glow,
		/obj/item/seeds/sunflower/moonflower,
		)

/obj/effect/spawner/random/food_or_drink/soda_can
	name = "soda can spawner"
	icon_state = "can"
	loot_type_path = /obj/item/reagent_containers/food/drinks/soda_cans
