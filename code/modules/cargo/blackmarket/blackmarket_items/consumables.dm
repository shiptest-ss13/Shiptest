/datum/blackmarket_item/consumable
	category = "Consumables"

/datum/blackmarket_item/consumable/donk_pocket_box
	name = "Box of Donk Pockets"
	desc = "A well packaged box containing the favourite snack of every spacefarer."
	item = /obj/effect/spawner/random/food_or_drink/donkpockets

	stock_min = 2
	stock_max = 5
	price_min = 325
	price_max = 400
	availability_prob = 80

/datum/blackmarket_item/consumable/suspicious_pills
	name = "Bottle of Suspicious Pills"
	desc = "A random cocktail of luxury drugs that are sure to put a smile on your face!"
	item = /obj/item/storage/pill_bottle

	stock_min = 4
	stock_max = 6
	price_min = 50
	price_max = 300
	availability_prob = 50

/datum/blackmarket_item/consumable/suspicious_pills/spawn_item(loc)
	var/pillbottle = pick(list(/obj/item/storage/pill_bottle/zoom,
				/obj/item/storage/pill_bottle/happy,
				/obj/item/storage/pill_bottle/lsd,
				/obj/item/storage/pill_bottle/aranesp,
				/obj/item/storage/pill_bottle/stimulant))
	return new pillbottle(loc)

/datum/blackmarket_item/consumable/floor_pill
	name = "Strange Pill"
	desc = "The Russian Roulette of the Maintenance Tunnels."
	item = /obj/item/reagent_containers/pill/floorpill

	stock_min = 5
	stock_max = 35
	price_min = 10
	price_max = 60
	availability_prob = 50

/datum/blackmarket_item/consumable/cannabis
	name = "Cannabis Leaves"
	desc = "Homegrown cannabis, fresh off the garden just for your pleasure!"
	item = /obj/item/reagent_containers/food/snacks/grown/cannabis

	stock_min = 4
	stock_max = 6
	price_min = 50
	price_max = 300
	availability_prob = 50

/datum/blackmarket_item/consumable/syndie_cigs
	name = "Syndicate Cigarettes"
	desc = "Who said smoking was bad for you? These omnizine laced cigarettes will have you feeling like a million bucks!"
	item = /obj/item/storage/fancy/cigarettes/cigpack_syndicate

	stock_min = 4
	stock_max = 6
	price_min = 50
	price_max = 300
	availability_prob = 50

/datum/blackmarket_item/consumable/trickwine
	name = "Trickwine"
	desc = "The SRM keeps the recipes for their trickwines a closely guarded secret. The Hunters carrying those bottles? Less so."
	item = /datum/reagent/consumable/ethanol/trickwine/ash_wine

	price_min = 200
	price_max = 600
	stock_min = 3
	stock_max = 7
	availability_prob = 40

/datum/blackmarket_item/consumable/trickwine/spawn_item(loc)
	var/trickwine = pick(list(/obj/item/reagent_containers/food/drinks/breakawayflask/vintage/ashwine,
						/obj/item/reagent_containers/food/drinks/breakawayflask/vintage/icewine,
						/obj/item/reagent_containers/food/drinks/breakawayflask/vintage/shockwine,
						/obj/item/reagent_containers/food/drinks/breakawayflask/vintage/hearthwine,))
	return new trickwine(loc)

/datum/blackmarket_item/consumable/stimpack
	name = "Stimpack"
	desc = "A quick inject medipen loaded with a cocktail of powerful stimulants. Side effects may include nasuea, heartburn, constipation, weight loss, increased blood pressure, kidney stones, liver damage, mood swings, mania, anemia, weight gain, total organ failure, runny nose and minor retinal irritation."
	item = /obj/item/reagent_containers/hypospray/medipen/stimpack/traitor

	stock_min = 4
	stock_max = 6
	price_min = 250
	price_max = 500
	availability_prob = 50

/datum/blackmarket_item/consumable/morphine
	name = "Morphine Bottle"
	desc = "Medicinal? Recreational? You can decide with this 30u bottle of morphine!"
	item = /obj/item/reagent_containers/glass/bottle/morphine

	price_min = 50
	price_max = 150
	stock_min = 2
	stock_max = 4
	availability_prob = 50

/datum/blackmarket_item/consumable/cyanide
	name = "Cyanide Bottle"
	desc = "Cyanide, a tried and true classic for all your poisoning needs."
	item = /obj/item/reagent_containers/glass/bottle/cyanide

	price_min = 200
	price_max = 400
	stock_min = 2
	stock_max = 4
	availability_prob = 30

/datum/blackmarket_item/consumable/sodium_thiopental
	name = "Sodium Thiopental Bottle"
	desc = "Sodium Thiopental, a potent and fast acting sedative for any occasion."
	item = /obj/item/reagent_containers/glass/bottle/sodium_thiopental

	price_min = 250
	price_max = 600
	stock_min = 2
	stock_max = 4
	availability_prob = 30

/datum/blackmarket_item/consumable/amanitin
	name = "Amanitin Bottle"
	desc = "A slow acting, but nearly undetectable poison. For the dignified assassin."
	item = /obj/item/reagent_containers/glass/bottle/amanitin

	price_min = 300
	price_max =  600
	stock_max = 2
	stock_max = 4
	availability_prob = 30

/datum/blackmarket_item/consumable/gumballs
	name = "Gumball"
	desc = "Looking for a sweet treat? These gumballs are sure to satisfy."
	item = /obj/item/reagent_containers/food/snacks/gumball

	price_min = 10
	price_max = 20
	stock_min = 10
	stock_max = 20
	availability_prob = 80

/datum/blackmarket_item/consumable/xeno_corpse
	name = "Xenomorph Corpse"
	desc = "The Frontier's most dangerous game, delivered right to your plate! May constitute a violation of your local BARD laws and regulations."
	item = /mob/living/simple_animal/hostile/alien

	price_min = 6000
	price_max = 10000
	stock = 1
	availability_prob = 10
	spawn_weighting = FALSE

/datum/blackmarket_item/consumable/xeno_corpse/spawn_item(loc)
	var/mob/living/simple_animal/hostile/alien = ..()
	alien.stat = DEAD
	return new alien(loc)

/datum/blackmarket_item/consumable/berries
	name = "Berries"
	desc = "Some fresh berries we found growing in the corner of our hangar. We're not 100% sure what species these are."
	item = /obj/item/reagent_containers/food/snacks/grown/berries

	price_min = 25
	price_max = 100
	stock_min = 10
	stock_max = 20
	availability_prob = 40

/datum/blackmarket_item/consumable/berries/spawn_item(loc)
	var/berries = pick(list(/obj/item/reagent_containers/food/snacks/grown/berries,
				/obj/item/reagent_containers/food/snacks/grown/berries/poison/stealth,
				/obj/item/reagent_containers/food/snacks/grown/berries/death/stealth))
	return new berries(loc)

/datum/blackmarket_item/consumable/ration
	name = "Ration Pack"
	desc = "PGF military surplus rations. What's in them? Who knows. Surprise is the spice of life after all."
	item = /obj/effect/spawner/random/food_or_drink/ration

	price_min = 150
	price_max = 300
	availability_prob = 80
	unlimited =  TRUE

/datum/blackmarket_item/consumable/vimukti
	name = "Can of Vimukti"
	desc = "This product was quietly discontinued after multiple health related incidents. But you aren't a coward, are you?"
	item = /obj/item/reagent_containers/food/drinks/soda_cans/vimukti

	price_min = 10
	price_max = 50
	stock_min = 10
	stock_max = 20
	availability_prob = 50

/datum/blackmarket_item/consumable/sutures
	name = "Sutures"
	desc = "A bundle of sutures for stitching up your latest bullet wound."
	item = /obj/item/stack/medical/suture

	price_min = 25
	price_max = 150
	stock_min = 4
	stock_max = 6
	availability_prob = 40

/datum/blackmarket_item/consumable/regen_mesh
	name = "Regenerative Mesh"
	desc = "A smoothing pack of regenerative mesh for your burns."
	item = /obj/item/stack/medical/mesh

	price_min = 25
	price_max = 150
	stock_min = 4
	stock_max = 6
	availability_prob = 40

/datum/blackmarket_item/consumable/bruise_pack
	name = "Bruise Packs"
	desc = "A bundle of old bruise packs, for you guessed it, bruises. Any rumors of these containing hazardous chemicals are just that. Rumors."
	item = /obj/item/stack/medical/bruise_pack

	price_min = 50
	price_max = 175
	stock_min = 4
	stock_max = 6
	availability_prob = 30

/datum/blackmarket_item/consumable/ointment
	name = "Burn Ointment"
	desc = "A tube of burn ointment. It's past the expiry date, but those are only suggestions."
	item = /obj/item/stack/medical/ointment

	price_min = 50
	price_max = 175
	stock_min = 4
	stock_max = 6
	availability_prob = 30

/datum/blackmarket_item/consumable/goliath
	name = "A Live Goliath"
	desc = "We reappropiated an outpost freighter a week back, and the entire thing was packed with goliaths for whatever reason. Point is, we're sick and tired of eating them, so we're selling what's left so we can buy some actual take out."
	item = /mob/living/simple_animal/hostile/asteroid/goliath/beast

	price_min = 750
	price_max = 2000
	stock_max = 4
	availability_prob = 15
	spawn_weighting = FALSE

/datum/blackmarket_item/consumable/color_salve
	name = "Color Salve"
	desc = "A cosmetic salve used for changing the hue of Elzouse. Now with 20% less harmful chemical dyes!"
	item = /obj/item/colorsalve

	price_min = 100
	price_max = 200
	stock_min = 4
	stock_max = 10
	availability_prob = 80

/datum/blackmarket_item/consumable/secret_sauce
	name = "Family Sauce Recipe"
	desc = "This used to belong to a good friend of mine before the authorities did em in. Best goddamn sauce I've ever tasted, but I could never get it right myself. Maybe you can do it justice."
	item = /obj/item/paper/secretrecipe

	price_min = 1000
	price_max = 2000
	stock = 1
	availability_prob = 5
	spawn_weighting = FALSE

