//*******************Contains everything related to the flora on lavaland.*******************************
//This includes: The structures, their produce, their seeds and the crafting recipe for the mushroom bowl

/obj/structure/flora/ash
	gender = PLURAL
	layer = PROJECTILE_HIT_THRESHHOLD_LAYER //sporangiums up don't shoot
	icon = 'icons/obj/lavaland/ash_flora.dmi'
	icon_state = "l_mushroom"
	name = "large mushrooms"
	desc = "A number of large mushrooms, covered in a faint layer of ash and what can only be spores."
	var/harvested_name = "shortened mushrooms"
	var/harvested_desc = "Some quickly regrowing mushrooms, formerly known to be quite large."
	var/needs_sharp_harvest = TRUE
	var/harvest = /obj/item/food/grown/ash_flora/shavings
	var/harvest_amount_low = 1
	var/harvest_amount_high = 3
	var/harvest_time = 60
	var/harvest_message_low = "You pick a mushroom, but fail to collect many shavings from its cap."
	var/harvest_message_med = "You pick a mushroom, carefully collecting the shavings from its cap."
	var/harvest_message_high = "You harvest and collect shavings from several mushroom caps."
	var/harvested = FALSE
	var/base_icon
	var/regrowth_time_low = 8 MINUTES
	var/regrowth_time_high = 16 MINUTES
	var/num_sprites = 4 // WS edit - WS

/obj/structure/flora/ash/Initialize()
	. = ..()
	if(num_sprites == 1) //stops unnecessary randomization of harvestable flora icons with only one variation. Remember to set num_sprites on your flora!
		base_icon = "[icon_state]"
		icon_state = base_icon
	else
		base_icon = "[icon_state][rand(1, num_sprites)]" //randomizing icons like this prevents the icon of the structure from loading properly in mapping tools. Works fine ingame.
		icon_state = base_icon

/obj/structure/flora/ash/proc/harvest(user)
	if(harvested)
		return 0

	var/rand_harvested = rand(harvest_amount_low, harvest_amount_high)
	if(rand_harvested)
		if(user)
			var/msg = harvest_message_med
			if(rand_harvested == harvest_amount_low)
				msg = harvest_message_low
			else if(rand_harvested == harvest_amount_high)
				msg = harvest_message_high
			to_chat(user, span_notice("[msg]"))
		for(var/i in 1 to rand_harvested)
			new harvest(get_turf(src))

	icon_state = "[base_icon]p"
	name = harvested_name
	desc = harvested_desc
	harvested = TRUE
	addtimer(CALLBACK(src, PROC_REF(regrow)), rand(regrowth_time_low, regrowth_time_high))
	return 1

/obj/structure/flora/ash/proc/regrow()
	icon_state = base_icon
	name = initial(name)
	desc = initial(desc)
	harvested = FALSE

/obj/structure/flora/ash/attackby(obj/item/W, mob/user, params)
	if(!harvested && needs_sharp_harvest && W.get_sharpness())
		user.visible_message(span_notice("[user] starts to harvest from [src] with [W]."),span_notice("You begin to harvest from [src] with [W]."))
		if(do_after(user, harvest_time, target = src))
			harvest(user)
	else
		return ..()

/obj/structure/flora/ash/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	if(!harvested && !needs_sharp_harvest)
		user.visible_message(span_notice("[user] starts to harvest from [src]."),span_notice("You begin to harvest from [src]."))
		if(do_after(user, harvest_time, target = src))
			harvest(user)

/obj/structure/flora/ash/tall_shroom //exists only so that the spawning check doesn't allow these spawning near other things
	regrowth_time_low = 4200

/obj/structure/flora/ash/leaf_shroom
	icon_state = "s_mushroom"
	name = "leafy mushrooms"
	desc = "A number of mushrooms, each of which surrounds a greenish sporangium with a number of leaf-like structures."
	harvested_name = "leafless mushrooms"
	harvested_desc = "A bunch of formerly-leafed mushrooms, with their sporangiums exposed. Scandalous?"
	harvest = /obj/item/food/grown/ash_flora/mushroom_leaf
	needs_sharp_harvest = FALSE
	harvest_amount_high = 4
	harvest_time = 20
	harvest_message_low = "You pluck a single, suitable leaf."
	harvest_message_med = "You pluck a number of leaves, leaving a few unsuitable ones."
	harvest_message_high = "You pluck quite a lot of suitable leaves."
	regrowth_time_low = 2400
	regrowth_time_high = 6000

/obj/structure/flora/ash/cap_shroom
	icon_state = "r_mushroom"
	name = "tall mushrooms"
	desc = "Several mushrooms, the larger of which have a ring of conks at the midpoint of their stems."
	harvested_name = "small mushrooms"
	harvested_desc = "Several small mushrooms near the stumps of what likely were larger mushrooms."
	harvest = /obj/item/food/grown/ash_flora/mushroom_cap
	harvest_amount_high = 4
	harvest_time = 50
	harvest_message_low = "You slice the cap off a mushroom."
	harvest_message_med = "You slice off a few conks from the larger mushrooms."
	harvest_message_high = "You slice off a number of caps and conks from these mushrooms."
	regrowth_time_low = 3000
	regrowth_time_high = 5400

/obj/structure/flora/ash/stem_shroom
	icon_state = "t_mushroom"
	name = "numerous mushrooms"
	desc = "A large number of mushrooms, some of which have long, fleshy stems. They're radiating light!"
	light_range = 1.5
	light_power = 2.1
	harvested_name = "tiny mushrooms"
	harvested_desc = "A few tiny mushrooms around larger stumps. You can already see them growing back."
	harvest = /obj/item/food/grown/ash_flora/mushroom_stem
	harvest_amount_high = 4
	harvest_time = 40
	harvest_message_low = "You pick and slice the cap off a mushroom, leaving the stem."
	harvest_message_med = "You pick and decapitate several mushrooms for their stems."
	harvest_message_high = "You acquire a number of stems from these mushrooms."
	regrowth_time_low = 3000
	regrowth_time_high = 6000

/obj/structure/flora/ash/cacti
	icon_state = "cactus"
	name = "fruiting cacti"
	desc = "Several prickly cacti, brimming with ripe fruit and covered in a thin layer of ash."
	harvested_name = "cacti"
	harvested_desc = "A bunch of prickly cacti. You can see fruits slowly growing beneath the covering of ash."
	harvest = /obj/item/food/grown/ash_flora/cactus_fruit
	needs_sharp_harvest = FALSE
	harvest_amount_high = 2
	harvest_time = 10
	harvest_message_low = "You pick a cactus fruit."
	harvest_message_med = "You pick several cactus fruit." //shouldn't show up, because you can't get more than two
	harvest_message_high = "You pick a pair of cactus fruit."
	regrowth_time_low = 4800
	regrowth_time_high = 7200

/obj/structure/flora/ash/cacti/Initialize(mapload)
	. = ..()
	// min dmg 3, max dmg 6, prob(70)
	AddComponent(/datum/component/caltrop, 3, 6, 70)

///Snow flora to exist on icebox.
/obj/structure/flora/ash/chilly
	icon_state = "chilly_pepper"
	name = "springy grassy fruit"
	desc = "A number of bright, springy blue fruiting plants. They seem to be unconcerned with the hardy, cold environment."
	harvested_name = "springy grass"
	harvested_desc = "A bunch of springy, bouncy fruiting grass, all picked. Or maybe they were never fruiting at all?"
	harvest = /obj/item/food/grown/icepepper
	needs_sharp_harvest = FALSE
	harvest_amount_high = 3
	harvest_time = 15
	harvest_message_low = "You pluck a single, curved fruit."
	harvest_message_med = "You pluck a number of curved fruit."
	harvest_message_high = "You pluck quite a lot of curved fruit."
	regrowth_time_low = 2400
	regrowth_time_high = 5500
	num_sprites = 1

/obj/structure/flora/ash/fern
	name = "cave fern"
	desc = "A species of fern with highly fibrous leaves."
	icon_state = "cavefern" //needs new sprites.
	harvested_name = "cave fern stems"
	harvested_desc = "A few cave fern stems, missing their leaves."
	harvest = /obj/item/food/grown/ash_flora/fern
	harvest_amount_high = 4
	harvest_message_low = "You clip a single, suitable leaf."
	harvest_message_med = "You clip a number of leaves, leaving a few unsuitable ones."
	harvest_message_high = "You clip quite a lot of suitable leaves."
	regrowth_time_low = 3000
	regrowth_time_high = 5400
	num_sprites = 1

/obj/structure/flora/ash/fireblossom
	name = "fire blossom"
	desc = "An odd flower that grows commonly near bodies of lava. The leaves can be ground up for a substance resembling capsaicin."
	icon_state = "fireblossom"
	harvested_name = "fire blossom stems"
	harvested_desc = "A few fire blossom stems, missing their flowers."
	harvest = /obj/item/food/grown/ash_flora/fireblossom
	needs_sharp_harvest = FALSE
	harvest_amount_high = 3
	harvest_message_low = "You pluck a single, suitable flower."
	harvest_message_med = "You pluck a number of flowers, leaving a few unsuitable ones."
	harvest_message_high = "You pluck quite a lot of suitable flowers."
	regrowth_time_low = 2500
	regrowth_time_high = 4000
	num_sprites = 2

/obj/structure/flora/ash/puce
	name = "Pucestal Growth"
	desc = "A collection of puce colored crystal growths."
	icon_state = "pucetal"
	harvested_name = "Pucestal fragments"
	harvested_desc = "A few pucestal fragments, slowly regrowing."
	harvest = /obj/item/food/grown/ash_flora/puce
	harvest_amount_high = 6
	harvest_message_low = "You work a crystal free."
	harvest_message_med = "You cut a number of crystals free, leaving a few small ones."
	harvest_message_high = "You cut free quite a lot of crystals."
	regrowth_time_low = 10 MINUTES
	regrowth_time_high = 20 MINUTES
	num_sprites = 1

/obj/item/food/grown/ash_flora
	name = "mushroom shavings"
	desc = "Some shavings from a tall mushroom. With enough, might serve as a bowl."
	icon = 'icons/obj/lavaland/ash_flora.dmi'
	icon_state = "l_mushroom"
	w_class = WEIGHT_CLASS_TINY
	resistance_flags = FLAMMABLE
	max_integrity = 100
	seed = /obj/item/seeds/lavaland/polypore
	wine_power = 20

/obj/item/food/grown/ash_flora/Initialize()
	. = ..()
	pixel_x = rand(-4, 4)
	pixel_y = rand(-4, 4)

/obj/item/food/grown/ash_flora/shavings //So we can't craft bowls from everything.

/obj/item/food/grown/ash_flora/mushroom_leaf
	name = "mushroom leaf"
	desc = "A leaf, from a mushroom."
	icon_state = "s_mushroom"
	seed = /obj/item/seeds/lavaland/porcini
	wine_power = 40

/obj/item/food/grown/ash_flora/mushroom_cap
	name = "mushroom cap"
	desc = "The cap of a large mushroom."
	icon_state = "r_mushroom"
	seed = /obj/item/seeds/lavaland/inocybe
	wine_power = 70

/obj/item/food/grown/ash_flora/mushroom_stem
	name = "mushroom stem"
	desc = "A long mushroom stem. It's slightly glowing."
	icon_state = "t_mushroom"
	seed = /obj/item/seeds/lavaland/ember
	wine_power = 60

/obj/item/food/grown/ash_flora/cactus_fruit
	name = "cactus fruit"
	desc = "A cactus fruit covered in a thick, reddish skin. And some ash."
	icon_state = "cactus"
	seed = /obj/item/seeds/lavaland/cactus
	wine_power = 50

/obj/item/food/grown/ash_flora/fern
	name = "fern leaf"
	desc = "A leaf from a cave fern."
	icon_state = "fern"
	seed = /obj/item/seeds/lavaland/fern
	wine_power = 10

/obj/item/food/grown/ash_flora/fireblossom
	name = "fire blossom"
	desc = "A flower from a fire blossom."
	icon_state = "fireblossom"
	slot_flags = ITEM_SLOT_HEAD
	seed = /obj/item/seeds/lavaland/fireblossom
	wine_power = 40

/obj/item/food/grown/ash_flora/puce
	name = "Pucestal Crystal"
	desc = "A crystal from a pucestal growth."
	icon_state = "puce"
	seed = /obj/item/seeds/lavaland/puce
	wine_power = 1
	foodtypes = TOXIC | GROSS //yum

//SEEDS

/obj/item/seeds/lavaland
	name = "lavaland seeds"
	desc = "You should never see this."
	lifespan = 50
	endurance = 25
	maturation = 7
	production = 4
	yield = 4
	potency = 15
	growthstages = 3
	rarity = 20
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.1)
	resistance_flags = FIRE_PROOF
	species = "polypore" //silence unit test

/obj/item/seeds/lavaland/cactus
	name = "pack of fruiting cactus seeds"
	desc = "These seeds grow into fruiting cacti."
	icon_state = "seed-cactus"
	species = "cactus"
	plantname = "Fruiting Cactus"
	product = /obj/item/food/grown/ash_flora/cactus_fruit
	genes = list(/datum/plant_gene/trait/fire_resistance)
	growing_icon = 'icons/obj/hydroponics/growing_fruits.dmi'
	growthstages = 2
	reagents_add = list(/datum/reagent/consumable/nutriment/vitamin = 0.04, /datum/reagent/consumable/nutriment = 0.04, /datum/reagent/consumable/vitfro = 0.1)
	research = PLANT_RESEARCH_TIER_1

/obj/item/seeds/lavaland/polypore
	name = "pack of polypore mycelium"
	desc = "This mycelium grows into bracket mushrooms, also known as polypores. Woody and firm, shaft miners often use them for makeshift crafts."
	icon_state = "mycelium-polypore"
	species = "polypore"
	plantname = "Polypore Mushrooms"
	product = /obj/item/food/grown/ash_flora/shavings
	genes = list(/datum/plant_gene/trait/plant_type/fungal_metabolism, /datum/plant_gene/trait/fire_resistance)
	growing_icon = 'icons/obj/hydroponics/growing_mushrooms.dmi'
	reagents_add = list(/datum/reagent/consumable/ethanol = 0.04, /datum/reagent/stabilizing_agent = 0.06, /datum/reagent/toxin/minttoxin = 0.015)
	research = PLANT_RESEARCH_TIER_1

/obj/item/seeds/lavaland/porcini
	name = "pack of porcini mycelium"
	desc = "This mycelium grows into Boletus edulus, also known as porcini. Native to the late Earth, but discovered on Lavaland. Has culinary, medicinal and relaxant effects."
	icon_state = "mycelium-porcini"
	species = "porcini"
	plantname = "Porcini Mushrooms"
	product = /obj/item/food/grown/ash_flora/mushroom_leaf
	genes = list(/datum/plant_gene/trait/plant_type/fungal_metabolism, /datum/plant_gene/trait/fire_resistance)
	growing_icon = 'icons/obj/hydroponics/growing_mushrooms.dmi'
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.05, /datum/reagent/consumable/vitfro = 0.04, /datum/reagent/drug/nicotine = 0.04, /datum/reagent/consumable/sugar = 0.03)
	research = PLANT_RESEARCH_TIER_1

/obj/item/seeds/lavaland/inocybe
	name = "pack of inocybe mycelium"
	desc = "This mycelium grows into an inocybe mushroom, a species of Lavaland origin with hallucinatory and toxic effects."
	icon_state = "mycelium-inocybe"
	species = "inocybe"
	plantname = "Inocybe Mushrooms"
	product = /obj/item/food/grown/ash_flora/mushroom_cap
	genes = list(/datum/plant_gene/trait/plant_type/fungal_metabolism, /datum/plant_gene/trait/fire_resistance)
	growing_icon = 'icons/obj/hydroponics/growing_mushrooms.dmi'
	reagents_add = list(/datum/reagent/toxin/mindbreaker = 0.04, /datum/reagent/consumable/entpoly = 0.1, /datum/reagent/drug/mushroomhallucinogen = 0.05)
	research = PLANT_RESEARCH_TIER_1

/obj/item/seeds/lavaland/ember
	name = "pack of embershroom mycelium"
	desc = "This mycelium grows into embershrooms, a species of bioluminescent mushrooms native to Lavaland."
	icon_state = "mycelium-ember"
	species = "ember"
	plantname = "Embershroom Mushrooms"
	product = /obj/item/food/grown/ash_flora/mushroom_stem
	genes = list(/datum/plant_gene/trait/plant_type/fungal_metabolism, /datum/plant_gene/trait/glow, /datum/plant_gene/trait/fire_resistance)
	growing_icon = 'icons/obj/hydroponics/growing_mushrooms.dmi'
	reagents_add = list(/datum/reagent/consumable/tinlux = 0.04, /datum/reagent/consumable/nutriment/vitamin = 0.02, /datum/reagent/drug/space_drugs = 0.02)
	research = PLANT_RESEARCH_TIER_1

/obj/item/seeds/lavaland/fern
	name = "pack of cave fern seeds"
	desc = "These seeds grow into cave ferns."
	plantname = "Cave Fern"
	icon_state = "seed_fern"
	species = "fern"
	growthstages = 2
	product = /obj/item/food/grown/ash_flora/fern
	genes = list(/datum/plant_gene/trait/fire_resistance, /datum/plant_gene/trait/plant_type/weed_hardy)
	reagents_add = list(/datum/reagent/ash_fibers = 0.1)
	research = PLANT_RESEARCH_TIER_1

/obj/item/seeds/lavaland/fern/Initialize(mapload,nogenes)
	. = ..()
	if(!nogenes)
		unset_mutability(/datum/plant_gene/reagent, PLANT_GENE_EXTRACTABLE)

/obj/item/seeds/lavaland/fireblossom
	name = "pack of fire blossom seeds"
	desc = "These seeds grow into fire blossoms."
	plantname = "Fire Blossom"
	icon_state = "seed_fireblossom"
	species = "fireblossom"
	growthstages = 3
	product = /obj/item/food/grown/ash_flora/fireblossom
	genes = list(/datum/plant_gene/trait/fire_resistance, /datum/plant_gene/trait/glow/yellow)
	reagents_add = list(/datum/reagent/consumable/pyre_elementum = 0.09, /datum/reagent/carbon = 0.05, /datum/reagent/consumable/nutriment = 0.03)
	research = PLANT_RESEARCH_TIER_2

/obj/item/seeds/lavaland/puce
	name = "puce cluster"
	desc = "These crystals can be grown into larger crystals."
	plantname = "Pucestal Growth"
	icon_state = "cluster_puce"
	species = "puce"
	growthstages = 3
	product = /obj/item/food/grown/ash_flora/puce
	genes = list(/datum/plant_gene/trait/plant_type/crystal)
	reagents_add = list(/datum/reagent/medicine/puce_essence = 0.1)
	research = PLANT_RESEARCH_TIER_3

/obj/item/seeds/lavaland/puce/Initialize(mapload,nogenes)
	. = ..()
	if(!nogenes)
		unset_mutability(/datum/plant_gene/reagent, PLANT_GENE_REMOVABLE)
		unset_mutability(/datum/plant_gene/trait/plant_type/crystal, PLANT_GENE_REMOVABLE)

		unset_mutability(/datum/plant_gene/reagent, PLANT_GENE_EXTRACTABLE)
		unset_mutability(/datum/plant_gene/trait/plant_type/crystal, PLANT_GENE_EXTRACTABLE)

/obj/item/seeds/lavaland/puce/attackby(obj/item/item, mob/user, params)
	. = ..()
	//anyone intending to add more garnishes using this method should componentize this
	if(!istype(item, /obj/item/melee/knife))
		return
	playsound(src, 'sound/effects/glassbr1.ogg', 50, TRUE, -1)
	to_chat(user, span_notice("You start breaking [src] up into shards..."))
	if(!do_after(user, 1 SECONDS, src))
		return
	var/obj/item/result = new /obj/item/garnish/puce(drop_location())
	var/give_to_user = user.is_holding(src)
	qdel(src)
	if(give_to_user)
		user.put_in_hands(result)
	to_chat(user, span_notice("You finish breaking [src]"))

/obj/item/reagent_containers/glass/bowl/mushroom_bowl
	name = "mushroom bowl"
	desc = "A bowl made out of mushrooms. Not food, though it might have contained some at some point."
	icon = 'icons/obj/lavaland/ash_flora.dmi'
	icon_state = "mushroom_bowl"
	fill_icon = 'icons/obj/lavaland/ash_flora.dmi'

/obj/structure/flora/ash/proc/consume(user)
	if(harvested)
		return 0

	icon_state = "[base_icon]p"
	name = harvested_name
	desc = harvested_desc
	harvested = TRUE
	addtimer(CALLBACK(src, PROC_REF(regrow)), rand(regrowth_time_low, regrowth_time_high))
	return 1

/obj/structure/flora/ash/glowshroom
	name = "glowshroom colony"
	desc = "A small, hardy patch of radiovoric glowshrooms, busying themselves in their attempts to decontaminate the soil."
	icon_state = "glowshroom"
	harvested_name = "glowshroom colony"
	harvested_desc = "A small, hardy patch of radiovoric glowshrooms. Someone seems to have come by and picked all the larger ones."
	harvest = /obj/item/food/grown/mushroom/glowshroom
	harvest_amount_high = 6
	harvest_amount_low = 1
	harvest_message_low = "You only find a single intact stalk, discarding a number of stunted or rotted shrooms."
	harvest_message_med = "You collect a bundle of glowing fungi."
	harvest_message_high = "You manage to find several proudly-glowing shrooms of impressive size."
	regrowth_time_low = 10 MINUTES
	regrowth_time_high = 20 MINUTES
	num_sprites = 1
	light_power = 0.5
	light_range = 3
	light_color = "#11fa25"

//Gardens//
//these guys spawn a variety of seeds at random, slightly weighted. Intended as a stopgap until we can add more custom flora.
/obj/structure/flora/ash/garden
	name = "lush garden"
	gender = NEUTER
	desc = "In the soil and shade, something softly grows."
	icon_state = "garden"
	harvested_name = "lush garden"
	harvested_desc = "In the soil and shade, something softly grew. It seems some industrious scavenger already passed by."
	harvest = /obj/effect/spawner/random/food_or_drink/garden
	harvest_amount_high = 1
	harvest_amount_low = 1
	harvest_message_low = "You discover something nestled away in the growing bough."
	harvest_message_med = "You discover something nestled away in the growing bough."
	harvest_message_high = "You discover something nestled away in the growing bough."
	regrowth_time_low = 55 MINUTES
	regrowth_time_high = 60 MINUTES//good luck farming this
	num_sprites = 1
	light_power = 0.5
	light_range = 1
	needs_sharp_harvest = FALSE
	///Used for garden scan missions
	var/mission_scanned = FALSE

/obj/structure/flora/ash/garden/arid
	name = "rock garden"
	desc = "Beneath a bluff of soft silicate, a sheltered grove slumbers."
	icon_state = "gardenarid"
	harvested_name = "rock garden"
	harvested_desc = "Beneath a bluff of soft silicate, a sheltered grove slumbered. Some desert wanderer seems to have picked it clean."
	harvest = /obj/effect/spawner/random/food_or_drink/garden/arid
	harvest_amount_high = 1
	harvest_amount_low = 1
	harvest_message_low = "You brush sand away from a verdant prize, nestled in the leaves."
	harvest_message_med = "You brush sand away from a verdant prize, nestled in the leaves."
	harvest_message_high = "You brush sand away from a verdant prize, nestled in the leaves."

/obj/structure/flora/ash/garden/frigid
	name = "chilly garden"
	desc = "A delicate layer of frost covers hardy brush."
	icon_state = "gardencold"
	harvested_name = "chilly garden"
	harvested_desc = "A delicate layer of frost covers hardy brush. Someone came with the blizzard, and left with any prize this might contain."
	harvest = /obj/effect/spawner/random/food_or_drink/garden/cold
	harvest_amount_high = 1
	harvest_amount_low = 1
	harvest_message_low = "You unearth a snow-covered treat."
	harvest_message_med = "You unearth a snow-covered treat."
	harvest_message_high = "You unearth a snow-covered treat."

/obj/structure/flora/ash/garden/waste
	name = "sickly garden"
	desc = "Polluted water wells up from the cracked earth, feeding a patch of something curious."
	icon_state = "gardensick"
	harvested_name = "sickly garden"
	harvested_desc = "Polluted water wells up from the cracked earth, where it once fed a patch of something curious. Now only wilted leaves remain."
	harvest = /obj/effect/spawner/random/food_or_drink/garden/sick
	harvest_amount_high = 1
	harvest_amount_low = 1
	harvest_message_low = "You pry something odd from the poisoned soil."
	harvest_message_med = "You pry something odd from the poisoned soil."
	harvest_message_high = "You pry something odd from the poisoned soil."

/obj/structure/flora/ash/garden/seaweed //yea, i code :)
	name = "seaweed patch"
	gender = NEUTER
	desc = "A patch of seaweed, floating on the surface of the water"
	icon_state = "seaweed"
	harvested_name = "seaweed patch"
	harvested_desc = "A patch of seaweed, floating on the surface of the water. It seems someone has already searched through this"
	harvest = /obj/effect/spawner/random/food_or_drink/garden/seaweed
	harvest_amount_high = 1
	harvest_amount_low = 1
	harvest_message_low = "You discover some edible weeds within the patch."
	harvest_message_med = "You discover some edible weeds within the patch."
	harvest_message_high = "You discover some edible weeds within the patch."

/obj/item/food/grown/berries/poison/stealth //careful eating from random jungle bushes
	seed = /obj/item/seeds/berry/poison
	name = "bunch of berries"
	desc = "Nutritious?"
	icon_state = "berrypile"

/obj/item/food/grown/berries/death/stealth //I warned you!
	seed = /obj/item/seeds/berry/death
	name = "bunch of berries"
	desc = "Nutritious?"
	icon_state = "berrypile"
