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
	var/harvest = /obj/item/reagent_containers/food/snacks/grown/ash_flora/shavings
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
	base_icon = "[icon_state][rand(1, num_sprites)]"
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
			to_chat(user, "<span class='notice'>[msg]</span>")
		for(var/i in 1 to rand_harvested)
			new harvest(get_turf(src))

	icon_state = "[base_icon]p"
	name = harvested_name
	desc = harvested_desc
	harvested = TRUE
	addtimer(CALLBACK(src, .proc/regrow), rand(regrowth_time_low, regrowth_time_high))
	return 1

/obj/structure/flora/ash/proc/regrow()
	icon_state = base_icon
	name = initial(name)
	desc = initial(desc)
	harvested = FALSE

/obj/structure/flora/ash/attackby(obj/item/W, mob/user, params)
	if(!harvested && needs_sharp_harvest && W.get_sharpness())
		user.visible_message("<span class='notice'>[user] starts to harvest from [src] with [W].</span>","<span class='notice'>You begin to harvest from [src] with [W].</span>")
		if(do_after(user, harvest_time, target = src))
			harvest(user)
	else
		return ..()

/obj/structure/flora/ash/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	if(!harvested && !needs_sharp_harvest)
		user.visible_message("<span class='notice'>[user] starts to harvest from [src].</span>","<span class='notice'>You begin to harvest from [src].</span>")
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
	harvest = /obj/item/reagent_containers/food/snacks/grown/ash_flora/mushroom_leaf
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
	harvest = /obj/item/reagent_containers/food/snacks/grown/ash_flora/mushroom_cap
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
	harvest = /obj/item/reagent_containers/food/snacks/grown/ash_flora/mushroom_stem
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
	harvest = /obj/item/reagent_containers/food/snacks/grown/ash_flora/cactus_fruit
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
	harvest = /obj/item/reagent_containers/food/snacks/grown/icepepper
	needs_sharp_harvest = FALSE
	harvest_amount_high = 3
	harvest_time = 15
	harvest_message_low = "You pluck a single, curved fruit."
	harvest_message_med = "You pluck a number of curved fruit."
	harvest_message_high = "You pluck quite a lot of curved fruit."
	regrowth_time_low = 2400
	regrowth_time_high = 5500

//SNACKS

/obj/item/reagent_containers/food/snacks/grown/ash_flora
	name = "mushroom shavings"
	desc = "Some shavings from a tall mushroom. With enough, might serve as a bowl."
	icon = 'icons/obj/lavaland/ash_flora.dmi'
	icon_state = "mushroom_shavings"
	w_class = WEIGHT_CLASS_TINY
	resistance_flags = FLAMMABLE
	max_integrity = 100
	seed = /obj/item/seeds/lavaland/polypore
	wine_power = 20

/obj/item/reagent_containers/food/snacks/grown/ash_flora/Initialize()
	. = ..()
	pixel_x = rand(-4, 4)
	pixel_y = rand(-4, 4)

/obj/item/reagent_containers/food/snacks/grown/ash_flora/shavings //So we can't craft bowls from everything.

/obj/item/reagent_containers/food/snacks/grown/ash_flora/mushroom_leaf
	name = "mushroom leaf"
	desc = "A leaf, from a mushroom."
	icon_state = "mushroom_leaf"
	seed = /obj/item/seeds/lavaland/porcini
	wine_power = 40

/obj/item/reagent_containers/food/snacks/grown/ash_flora/mushroom_cap
	name = "mushroom cap"
	desc = "The cap of a large mushroom."
	icon_state = "mushroom_cap"
	seed = /obj/item/seeds/lavaland/inocybe
	wine_power = 70

/obj/item/reagent_containers/food/snacks/grown/ash_flora/mushroom_stem
	name = "mushroom stem"
	desc = "A long mushroom stem. It's slightly glowing."
	icon_state = "mushroom_stem"
	seed = /obj/item/seeds/lavaland/ember
	wine_power = 60

/obj/item/reagent_containers/food/snacks/grown/ash_flora/cactus_fruit
	name = "cactus fruit"
	desc = "A cactus fruit covered in a thick, reddish skin. And some ash."
	icon_state = "cactus_fruit"
	seed = /obj/item/seeds/lavaland/cactus
	wine_power = 50

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
	species = "polypore" // silence unit test

/obj/item/seeds/lavaland/cactus
	name = "pack of fruiting cactus seeds"
	desc = "These seeds grow into fruiting cacti."
	icon_state = "seed-cactus"
	species = "cactus"
	plantname = "Fruiting Cactus"
	product = /obj/item/reagent_containers/food/snacks/grown/ash_flora/cactus_fruit
	genes = list(/datum/plant_gene/trait/fire_resistance)
	growing_icon = 'icons/obj/hydroponics/growing_fruits.dmi'
	growthstages = 2
	reagents_add = list(/datum/reagent/consumable/nutriment/vitamin = 0.04, /datum/reagent/consumable/nutriment = 0.04, /datum/reagent/consumable/vitfro = 0.08)

/obj/item/seeds/lavaland/polypore
	name = "pack of polypore mycelium"
	desc = "This mycelium grows into bracket mushrooms, also known as polypores. Woody and firm, shaft miners often use them for makeshift crafts."
	icon_state = "mycelium-polypore"
	species = "polypore"
	plantname = "Polypore Mushrooms"
	product = /obj/item/reagent_containers/food/snacks/grown/ash_flora/shavings
	genes = list(/datum/plant_gene/trait/plant_type/fungal_metabolism, /datum/plant_gene/trait/fire_resistance)
	growing_icon = 'icons/obj/hydroponics/growing_mushrooms.dmi'
	reagents_add = list(/datum/reagent/consumable/sugar = 0.06, /datum/reagent/consumable/ethanol = 0.04, /datum/reagent/stabilizing_agent = 0.06, /datum/reagent/toxin/minttoxin = 0.02)

/obj/item/seeds/lavaland/porcini
	name = "pack of porcini mycelium"
	desc = "This mycelium grows into Boletus edulus, also known as porcini. Native to the late Earth, but discovered on Lavaland. Has culinary, medicinal and relaxant effects."
	icon_state = "mycelium-porcini"
	species = "porcini"
	plantname = "Porcini Mushrooms"
	product = /obj/item/reagent_containers/food/snacks/grown/ash_flora/mushroom_leaf
	genes = list(/datum/plant_gene/trait/plant_type/fungal_metabolism, /datum/plant_gene/trait/fire_resistance)
	growing_icon = 'icons/obj/hydroponics/growing_mushrooms.dmi'
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.06, /datum/reagent/consumable/vitfro = 0.04, /datum/reagent/drug/nicotine = 0.04)


/obj/item/seeds/lavaland/inocybe
	name = "pack of inocybe mycelium"
	desc = "This mycelium grows into an inocybe mushroom, a species of Lavaland origin with hallucinatory and toxic effects."
	icon_state = "mycelium-inocybe"
	species = "inocybe"
	plantname = "Inocybe Mushrooms"
	product = /obj/item/reagent_containers/food/snacks/grown/ash_flora/mushroom_cap
	genes = list(/datum/plant_gene/trait/plant_type/fungal_metabolism, /datum/plant_gene/trait/fire_resistance)
	growing_icon = 'icons/obj/hydroponics/growing_mushrooms.dmi'
	reagents_add = list(/datum/reagent/toxin/mindbreaker = 0.04, /datum/reagent/consumable/entpoly = 0.08, /datum/reagent/drug/mushroomhallucinogen = 0.04)

/obj/item/seeds/lavaland/ember
	name = "pack of embershroom mycelium"
	desc = "This mycelium grows into embershrooms, a species of bioluminescent mushrooms native to Lavaland."
	icon_state = "mycelium-ember"
	species = "ember"
	plantname = "Embershroom Mushrooms"
	product = /obj/item/reagent_containers/food/snacks/grown/ash_flora/mushroom_stem
	genes = list(/datum/plant_gene/trait/plant_type/fungal_metabolism, /datum/plant_gene/trait/glow, /datum/plant_gene/trait/fire_resistance)
	growing_icon = 'icons/obj/hydroponics/growing_mushrooms.dmi'
	reagents_add = list(/datum/reagent/consumable/tinlux = 0.04, /datum/reagent/consumable/nutriment/vitamin = 0.02, /datum/reagent/drug/space_drugs = 0.02)

//CRAFTING

/datum/crafting_recipe/mushroom_bowl
	name = "Mushroom Bowl"
	result = /obj/item/reagent_containers/glass/bowl/mushroom_bowl
	reqs = list(/obj/item/reagent_containers/food/snacks/grown/ash_flora/shavings = 5)
	time = 30
	category = CAT_PRIMAL

/obj/item/reagent_containers/food/snacks/customizable/salad/ashsalad
	desc = "Very ashy."
	trash = /obj/item/reagent_containers/glass/bowl/mushroom_bowl
	icon = 'icons/obj/lavaland/ash_flora.dmi'
	icon_state = "mushroom_bowl"

/obj/item/reagent_containers/food/snacks/customizable/soup/ashsoup
	desc = "A bowl with ash and... stuff in it."
	trash = /obj/item/reagent_containers/glass/bowl/mushroom_bowl
	icon = 'icons/obj/lavaland/ash_flora.dmi'
	icon_state = "mushroom_soup"

/obj/item/reagent_containers/glass/bowl/mushroom_bowl
	name = "mushroom bowl"
	desc = "A bowl made out of mushrooms. Not food, though it might have contained some at some point."
	icon = 'icons/obj/lavaland/ash_flora.dmi'
	icon_state = "mushroom_bowl"

/obj/item/reagent_containers/glass/bowl/mushroom_bowl/update_overlays()
	. = ..()
	if(reagents && reagents.total_volume)
		var/mutable_appearance/filling = mutable_appearance('icons/obj/lavaland/ash_flora.dmi', "fullbowl")
		filling.color = mix_color_from_reagents(reagents.reagent_list)
		. += filling

/obj/item/reagent_containers/glass/bowl/mushroom_bowl/update_icon_state()
	if(!reagents || !reagents.total_volume)
		icon_state = "mushroom_bowl"

/obj/item/reagent_containers/glass/bowl/mushroom_bowl/attackby(obj/item/I,mob/user, params)
	if(istype(I, /obj/item/reagent_containers/food/snacks))
		var/obj/item/reagent_containers/food/snacks/S = I
		if(I.w_class > WEIGHT_CLASS_SMALL)
			to_chat(user, "<span class='warning'>The ingredient is too big for [src]!</span>")
		else if(contents.len >= 20)
			to_chat(user, "<span class='warning'>You can't add more ingredients to [src]!</span>")
		else
			if(reagents.has_reagent(/datum/reagent/water, 10)) //are we starting a soup or a salad?
				var/obj/item/reagent_containers/food/snacks/customizable/A = new/obj/item/reagent_containers/food/snacks/customizable/soup/ashsoup(get_turf(src))
				A.initialize_custom_food(src, S, user)
			else
				var/obj/item/reagent_containers/food/snacks/customizable/A = new/obj/item/reagent_containers/food/snacks/customizable/salad/ashsalad(get_turf(src))
				A.initialize_custom_food(src, S, user)
	else
		. = ..()

/obj/structure/flora/ash/gaia
	icon_state = "genesis"
	name = "Gaia Tree"
	desc = "The primordial origin shrub. It's covered in small, glowing nodules. It looks like there's one or two ready for harvest..."
	harvested_name = "Gaia Tree"
	harvested_desc = "The primordial origin shrub. It's covered in small, glowing nodules. It looks like any big ones have already been harvested."
	harvest = /obj/item/reagent_containers/food/snacks/grown/shell/genesis
	harvest_amount_high = 2
	harvest_time = 15
	harvest_message_low = "You pick a single seed from the tree."
	harvest_message_med = "You pick a single seed from the tree."
	harvest_message_high = "You manage to find two seeds worth picking!"
	regrowth_time_low = 30 MINUTES//just go to another planet
	regrowth_time_high = 45 MINUTES
	needs_sharp_harvest = FALSE
	num_sprites = 1

/obj/structure/flora/ash/corpse
	icon_state = "corpse_flower"
	name = "Corpse Flower"
	desc = "A large, foul smelling flower."
	name = "Corpse Flower Stub"
	harvested_desc = "A large, foul smelling flower- or at least, it was. Now it's little more then a tiny sprig, breaking out from the soil."
	harvest = /obj/item/seeds/starthistle/corpse_flower
	harvest_amount_high = 3
	harvest_time = 40
	harvest_message_low = "You cut away the main flower body, harvesting a single seed."
	harvest_message_med = "You cut away the main flower body, harvesting two seeds in the process."
	harvest_message_high = "You cut away the main flower body, harvesting a bounty of several seeds."
	regrowth_time_low = 45 MINUTES//arguably overly harsh, but corpse flowers irl take years to grow
	regrowth_time_high = 60 MINUTES
	num_sprites = 1

/obj/structure/flora/ash/jupiter
	icon_state = "jupiter"
	name = "Bed of Jupiter Cups"
	desc = "A collection of Jupiter Cups, which use primitive electrochemical reactions to generate energy from the small flies that meet their end inside."
	name = "Bed of Jupiter Cups"
	harvested_desc = "A collection of fungal stubs, poking out of the soil. A lone, young cap sits banefully, having survived your harvest."
	harvest = /obj/item/reagent_containers/food/snacks/grown/mushroom/jupitercup
	harvest_amount_high = 6
	harvest_time = 40
	harvest_message_low = "You root through the jups, but many of them have rotted away. You can only find one intact, mature cup."
	harvest_message_med = "You root through the jupiter cups, harvesting several mature cups and discarding the rest."
	harvest_message_high = "You root through the jupiter cups, finding a large bushel of intact, mature buds."
	regrowth_time_low = 15 MINUTES
	regrowth_time_high = 20 MINUTES
	num_sprites = 1

/obj/structure/flora/ash/aloe
	icon_state = "aloe"
	name = "Aloe Vera"
	desc = "A fleshy desert shrub, capable of going long periods of time without water."
	name = "Aloe Vera"
	harvested_desc = "The sorry remains of a throughly-harvested aloe plant. It'll probably grow back, eventually."
	harvest = /obj/item/reagent_containers/food/snacks/grown/aloe
	harvest_amount_high = 7
	harvest_time = 40
	harvest_message_low = "You cut away several leaves, but only manage to find one that hasn't rotted through."
	harvest_message_med = "You cut away several leaves, finding a few intact ones and discarding the rest."
	harvest_message_high = "You cut away the aloe's leaves, finding that most if not all are intact and perfect for harvest."
	regrowth_time_low = 10 MINUTES
	regrowth_time_high = 15 MINUTES
	num_sprites = 1

/obj/structure/flora/ash/banana
	icon_state = "banana"
	name = "Banana Tree"
	desc = "A small tree that grows near the jungle floor. It produces large, nutritious fruits that are a favorite of primates everywhere."
	name = "Banana Tree"//resisting the urge to put "bana-no tree"
	harvested_desc = "A small tree which grows near the jungle floor. It appears that any bushels of banana have already been harvested."
	harvest = /obj/item/reagent_containers/food/snacks/grown/banana
	harvest_amount_high = 18
	harvest_time = 50
	harvest_message_low = "You cut away the bushel, but find only a few bananas worth taking."
	harvest_message_med = "You cut away the bushel, finding several intact bananas and a number of rotted nanners."
	harvest_message_high = "You cut away the bushel, finding a veritable bounty of nannerous delight."
	regrowth_time_low = 20 MINUTES
	regrowth_time_high = 30 MINUTES
	num_sprites = 1

/obj/structure/flora/ash/wittel
	icon_state = "wittel"
	name = "Wittel's Reed"
	desc = "A silicate-based reedlike plant that thrives off the rare chemical wittelite. It cannot be seeded or grown aside, but provides a reliable source of the otherwise rare chemical."
	name = "Wittel's Reed"
	harvested_desc = "The remnants of a bundle of Wittel's Reed, cut nearly down to the ground by some greedy chemist. It'll come back eventually."
	harvest = /obj/item/reagent_containers/food/snacks/wittel
	harvest_amount_high = 9
	harvest_time = 50
	harvest_message_low = "You slice off a bundle of reeds, finding that only one is pure enough to be properly harvested."
	harvest_message_med = "You slice off a bundle of reeds, finding several pure enough to harvest and discarding a few low concentration ones."
	harvest_message_high = "You slice away a bundle of witterite, finding that many of the reeds within are able to be salvaged."
	regrowth_time_low = 45 MINUTES//witterite has to absorb tiny amounts of local witterite concentration to grow
	regrowth_time_high = 60 MINUTES
	num_sprites = 1
