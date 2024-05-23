/datum/blackmarket_item/consumable
	category = "Consumables"

/datum/blackmarket_item/consumable/donk_pocket_box
	name = "Box of Donk Pockets"
	desc = "A well packaged box containing the favourite snack of every spacefarer."
	item = /obj/effect/spawner/lootdrop/donkpockets

	stock_min = 2
	stock_max = 5
	price_min = 325
	price_max = 400
	availability_prob = 80

/datum/blackmarket_item/consumable/suspicious_pills
	name = "Bottle of Suspicious Pills"
	desc = "A random cocktail of luxury drugs that are sure to put a smile on your face!"
	item = /obj/item/storage/pill_bottle

	stock_min = 2
	stock_max = 3
	price_min = 200
	price_max = 500
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
						/obj/item/reagent_containers/food/drinks/breakawayflask/vintage/hearthwine,
						/obj/item/reagent_containers/food/drinks/breakawayflask/vintage/forcewine,
						/obj/item/reagent_containers/food/drinks/breakawayflask/vintage/prismwine))
	return new trickwine(loc)


/datum/blackmarket_item/consumable/pumpup
	name = "Maintenance Pump-Up"
	desc = "Resist any Baton stun with this handy instant tetanus free injector!."
	item = /obj/item/reagent_containers/hypospray/medipen/pumpup

	stock_max = 3
	price_min = 50
	price_max = 150
	availability_prob = 90

/datum/blackmarket_item/consumable/morphine
	name = "Morphine Bottle"
	desc = "Medicinal? Recreational? You can decide with this 30u bottle of morphine!"
	item = /obj/item/reagent_containers/glass/bottle/morphine

	price_min = 50
	price_max = 150
	stock_max = 4
	availability_prob = 50

/datum/blackmarket_item/consumable/cyanide
	name = "Cyanide Bottle"
	desc = "Cyanide, a tried and true classic for all your poisoning needs."
	item = /obj/item/reagent_containers/glass/bottle/cyanide

	price_min = 300
	price_max = 600
	stock_max = 3
	availability_prob = 30

/datum/blackmarket_item/consumable/sodium_thiopental
	name = "Sodium Thiopental Bottle"
	desc = "Sodium Thiopental, a potent and fast acting sedative for any occasion."
	item = /obj/item/reagent_containers/glass/bottle/sodium_thiopental

	price_min = 300
	price_max = 600
	stock_max = 3
	availability_prob = 30

/datum/blackmarket_item/consumable/amanitin
	name = "Amanitin bottle"
	desc = "A slow acting, but nearly undetectable poison. For the dignified assassin."
	item = /obj/item/reagent_containers/glass/bottle/amanitin

	price_min = 300
	price_max =  600
	stock_max = 3
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

/datum/blackmarket_item/consumable/xeno_meat
	name = "Xenomorph steak"
	desc = "The Frontier's most dangerous game, delivered right to your plate! May constitute a violation of your local BARD laws and regulations."
	item = /obj/item/reagent_containers/food/snacks/meat/slab/xeno

	price_min = 300
	price_max = 500
	stock_max = 5
	availability_prob = 20

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
	item = /obj/effect/spawner/lootdrop/ration

	price_min = 150
	price_max = 400
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

	price_min = 200
	price_max = 450
	stock_min = 2
	stock_max = 5
	availability_prob = 40

/datum/blackmarket_item/consumable/regen_mesh
	name = "Regenerative Mesh"
	desc = "A smoothing pack of regenerative mesh for your burns."
	item = /obj/item/stack/medical/mesh

	price_min = 200
	price_max = 450
	stock_min = 2
	stock_max = 5
	availability_prob = 40

/datum/blackmarket_item/consumable/bruise_pack
	name = "Bruise Packs"
	desc = "A bundle of old bruise packs, for you guessed it, bruises. Any rumors of these containing hazardous chemicals are just that. Rumors."
	item = /obj/item/stack/medical/bruise_pack

	price_min = 300
	price_max = 500
	stock_min = 2
	stock_max = 5
	availability_prob = 30

/datum/blackmarket_item/consumable/ointment
	name = "Burn ointment"
	desc = "A tube of burn ointment. It's past the expiry date, but those are only suggestions."
	item = /obj/item/stack/medical/ointment

	price_min = 300
	price_max = 500
	stock_min = 2
	stock_max = 5
	availability_prob = 30
