/datum/blackmarket_item/consumable
	category = "Consumables"

/datum/blackmarket_item/consumable/suspicious_pills
	name = "Bottle of Suspicious Pills"
	desc = "A random cocktail of luxury drugs that are sure to put a smile on your face!"
	item = /obj/item/storage/pill_bottle

	cost_min = 50
	cost_max = 300
	stock_min = 4
	stock_max = 6
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

	cost_min = 5
	cost_max = 15
	stock = INFINITY
	availability_prob = 50

/datum/blackmarket_item/consumable/cannabis
	name = "Cannabis Leaves"
	desc = "Homegrown cannabis, fresh off the garden just for your pleasure!"
	item = /obj/item/food/grown/cannabis

	cost_min = 50
	cost_max = 300
	stock_min = 4
	stock_max = 6
	availability_prob = 50

/datum/blackmarket_item/consumable/syndie_cigs
	name = "Syndicate Cigarettes"
	desc = "Who said smoking was bad for you? These Panacea laced cigarettes will have you feeling like a million bucks!"
	item = /obj/item/storage/fancy/cigarettes/cigpack_syndicate

	cost_min = 50
	cost_max = 300
	stock_min = 4
	stock_max = 6
	availability_prob = 50

/datum/blackmarket_item/consumable/trickwine
	name = "Trickwine"
	desc = "The SRM keeps the recipes for their trickwines closely guarded. The Hunters carrying those bottles? Less so."
	item = /datum/reagent/consumable/ethanol/trickwine/ash_wine

	cost_min = 300
	cost_max = 600
	stock_min = 3
	stock_max = 7
	availability_prob = 30

/datum/blackmarket_item/consumable/trickwine/spawn_item(loc)
	var/trickwine = pick(list(
		/obj/item/reagent_containers/food/drinks/breakawayflask/vintage/ashwine,
		/obj/item/reagent_containers/food/drinks/breakawayflask/vintage/icewine,
		/obj/item/reagent_containers/food/drinks/breakawayflask/vintage/shockwine,
		/obj/item/reagent_containers/food/drinks/breakawayflask/vintage/hearthwine,
		/obj/item/reagent_containers/food/drinks/breakawayflask/vintage/forcewine,
		/obj/item/reagent_containers/food/drinks/breakawayflask/vintage/prismwine
	))
	return new trickwine(loc)

/datum/blackmarket_item/consumable/stimpack
	name = "Stimpack"
	desc = "A quick inject medipen loaded with a cocktail of powerful stimulants. Side effects may include nasuea, heartburn, constipation, weight loss, increased blood pressure, kidney stones, liver damage, mood swings, mania, anemia, weight gain, total organ failure, runny nose and minor retinal irritation."
	item = /obj/item/reagent_containers/hypospray/medipen/stimpack/crisis

	stock_min = 4
	stock_max = 6
	cost_min = 250
	cost_max = 500
	availability_prob = 50

/datum/blackmarket_item/consumable/dimorlin
	name = "Dimorlin Bottle"
	desc = "Medicinal? Recreational? You can decide with this 30u bottle of dimorlin!"
	item = /obj/item/reagent_containers/glass/bottle/dimorlin

	cost_min = 50
	cost_max = 150
	stock_min = 2
	stock_max = 4
	availability_prob = 50

/datum/blackmarket_item/consumable/cyanide
	name = "Cyanide Bottle"
	desc = "Cyanide, a tried and true classic for all your poisoning needs."
	item = /obj/item/reagent_containers/glass/bottle/cyanide

	cost_min = 100
	cost_max = 200
	stock_min = 2
	stock_max = 4
	availability_prob = 30

/datum/blackmarket_item/consumable/sodium_thiopental
	name = "Sodium Thiopental Bottle"
	desc = "Sodium Thiopental, a potent and fast acting sedative for any occasion."
	item = /obj/item/reagent_containers/glass/bottle/sodium_thiopental

	cost_min = 100
	cost_max = 250
	stock_min = 2
	stock_max = 4
	availability_prob = 30

/datum/blackmarket_item/consumable/amanitin
	name = "Amanitin Bottle"
	desc = "A slow acting, but nearly undetectable poison. For the dignified assassin."
	item = /obj/item/reagent_containers/glass/bottle/amanitin

	cost_min = 150
	cost_max = 250
	stock_max = 2
	stock_max = 4
	availability_prob = 30

/datum/blackmarket_item/consumable/xeno_corpse
	name = "Xenomorph Corpse"
	desc = "The Frontier's most dangerous game, delivered right to your plate! May constitute a violation of your local BARD laws and regulations."
	item = /mob/living/simple_animal/hostile/alien

	cost_min = 6000
	cost_max = 10000
	stock = 1
	availability_prob = 10
	spawn_weighting = FALSE

/datum/blackmarket_item/consumable/xeno_corpse/spawn_item(loc)
	var/mob/living/simple_animal/hostile/alien/corpse = ..()
	if(prob(95))
		corpse.stat = DEAD
		corpse.density = FALSE
	return new corpse(loc)

/datum/blackmarket_item/consumable/berries
	name = "Berries"
	desc = "Some fresh berries we found growing in the corner of our hangar. We're not 100% sure what species these are."
	item = /obj/item/food/grown/berries

	cost_min = 25
	cost_max = 100
	stock_min = 10
	stock_max = 20
	availability_prob = 40

/datum/blackmarket_item/consumable/berries/spawn_item(loc)
	var/berries = pick(list(
				/obj/item/food/grown/berries,
				/obj/item/food/grown/berries/poison/stealth,
				/obj/item/food/grown/berries/death/stealth,
				))
	return new berries(loc)

/datum/blackmarket_item/consumable/ration
	name = "Ration Pack"
	desc = "PGF military surplus rations. What's in them? Who knows. Surprise is the spice of life after all."
	item = /obj/effect/spawner/random/food_or_drink/ration

	cost_min = 40
	cost_max = 100
	availability_prob = 80
	stock = INFINITY

/datum/blackmarket_item/consumable/vimukti
	name = "Can of Vimukti"
	desc = "This product was quietly discontinued after multiple health related incidents. But you aren't a coward, are you?"
	item = /obj/item/reagent_containers/food/drinks/soda_cans/vimukti

	cost_min = 10
	cost_max = 50
	stock_min = 10
	stock_max = 20
	availability_prob = 50

/datum/blackmarket_item/consumable/sutures
	name = "Sutures"
	desc = "A bundle of sutures for stitching up your latest bullet wound."
	item = /obj/item/stack/medical/suture

	cost_min = 25
	cost_max = 150
	stock_min = 4
	stock_max = 6
	availability_prob = 40

/datum/blackmarket_item/consumable/regen_mesh
	name = "Regenerative Mesh"
	desc = "A smoothing pack of regenerative mesh for your burns."
	item = /obj/item/stack/medical/mesh

	cost_min = 25
	cost_max = 150
	stock_min = 4
	stock_max = 6
	availability_prob = 40

/datum/blackmarket_item/consumable/bruise_pack
	name = "Bruise Packs"
	desc = "A bundle of old bruise packs, for you guessed it, bruises. Any rumors of these containing hazardous chemicals are just that. Rumors."
	item = /obj/item/stack/medical/bruise_pack

	cost_min = 50
	cost_max = 175
	stock_min = 4
	stock_max = 6
	availability_prob = 30

/datum/blackmarket_item/consumable/ointment
	name = "Burn Ointment"
	desc = "A tube of burn ointment. It's past the expiry date, but those are only suggestions."
	item = /obj/item/stack/medical/ointment

	cost_min = 50
	cost_max = 175
	stock_min = 4
	stock_max = 6
	availability_prob = 30

/datum/blackmarket_item/consumable/goliath
	name = "A Live Goliath"
	desc = "We reappropiated an outpost freighter a week back, and the entire thing was packed with goliaths for whatever reason. Point is, we're sick and tired of eating them, so we're selling what's left so we can buy some actual take out."
	item = /mob/living/simple_animal/hostile/asteroid/goliath/beast

	cost_min = 750
	cost_max = 2000
	stock_max = 4
	availability_prob = 15
	spawn_weighting = FALSE

/datum/blackmarket_item/consumable/color_salve
	name = "Color Salve"
	desc = "A cosmetic salve used for changing the hue of Elzouse. Now with 20% less harmful chemical dyes!"
	item = /obj/item/colorsalve

	cost_min = 100
	cost_max = 200
	stock_min = 4
	stock_max = 10
	availability_prob = 80

/datum/blackmarket_item/consumable/secret_sauce
	name = "Family Sauce Recipe"
	desc = "This used to belong to a good friend of mine before the authorities did em in. Best goddamn sauce I've ever tasted, but I could never get it right myself. Maybe you can do it justice."
	item = /obj/item/paper/secretrecipe

	cost_min = 1000
	cost_max = 2000
	stock = 1
	availability_prob = 5
	spawn_weighting = FALSE

/datum/blackmarket_item/consumable/shoalmix
	name = "Combat Cocktail"
	desc = "Last freighter we hit was a whole medical freighter. Had a bunch of crates with a beak spraypainted on. We knacked it and found these cocktail injectors inside."
	item = /obj/item/reagent_containers/hypospray/medipen/combat_drug
	cost_min = 400
	cost_max = 1200
	stock_max = 8
	availability_prob = 25
	spawn_weighting = FALSE

/datum/blackmarket_item/consumable/mammoth
	name = "Mammoth Injector"
	desc = "Found a bunch of kickass injectors hiding under the corpse of a Cliquer. Don't ask bout how they became a corpse Iunno. Doesn't matter. These things boost your strength and keep you going way too damn long..."
	item = /obj/item/reagent_containers/hypospray/medipen/mammoth
	cost_min = 500
	cost_max = 1000
	stock_max = 6
	availability_prob = 40
	spawn_weighting = FALSE

/datum/blackmarket_item/consumable/rabbit
	name = "Rabbit Injector"
	desc = "We were bummin around towards CLIP space the other day, and saw this. Ahem. Business opportunity with a bun. Words came to words and after some serious business planning, I'm the distributer for this line for this line of designer injectors. Supposed to make you like a rabbit or somethin."
	item = /obj/item/reagent_containers/hypospray/medipen/rabbit
	cost_min = 600
	cost_max = 800
	stock_max = 6
	availability_prob = 30
	spawn_weighting = FALSE

/datum/blackmarket_item/consumable/nesah
	name = "Nesah Injector"
	desc = "Other day some dude with black hair called us up and started talkin about some grand plan. Grand plan to sell merch, we assume, because he offloaded way too fuckin many of these injectors. Our chems guy said it's just a healing injector, so go fuckin wild. "
	item = /obj/item/reagent_containers/hypospray/medipen/netzach
	cost_min = 500
	cost_max = 1000
	stock_max = 12
	availability_prob = 50
	spawn_weighting = FALSE

/datum/blackmarket_item/consumable/finobranc
	name = "Finobranc Tablets"
	desc = "So get this, I know a Solarian Tgirl over the intranet, and we're chatting, and she sends me these things to try. I figure, hell yeah, try them, and got 5 days work done in one day. Now I'm sellin them. Miracle product I tell ya"
	item = /obj/item/storage/pill_bottle/finobranc
	cost_min = 600
	cost_max = 1000
	stock_max = 4
	availability_prob = 40
	spawn_weighting = FALSE

/datum/blackmarket_item/consumable/shoalmix
	name = "Shoaljuice Vial"
	desc = "Our guy in back has been working on whipping up some pretty mean syrums. Says that this one is a blend he learned from a Vox. Says that it'll get the heart going on anyone."
	item = /obj/item/reagent_containers/glass/bottle/vial/small/preloaded/combat_drug
	cost_min = 1000
	cost_max = 2000
	stock_max = 3
	availability_prob = 10
	spawn_weighting = FALSE

/datum/blackmarket_item/consumable/horse_pills
	name = "Strider patches"
	desc = "Fun lil story, yeah? We were screwin off in a backcounty race, watchin some horse girls run it out. One of em popped some patches beforehand. Managed to easily outrun the rest. We managed to find em and get in with the supplier. Supposed to help ya move fast. Keep your muscles workin when they might burst."
	item = /obj/item/storage/pill_bottle/strider
	cost_min = 700
	cost_max = 1500
	stock_max = 6
	availability_prob = 40
	spawn_weighting = FALSE
