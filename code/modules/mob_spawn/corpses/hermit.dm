// Hermits' corpses and their outfits

/obj/effect/mob_spawn/human/corpse/damaged/whitesands
	outfit = /datum/outfit/hermit

// the species hermits are, as list(species path = weight). hermit mobs share it, so they're the same species as the corpse they leave
GLOBAL_LIST_INIT(hermit_species_weights, list(
	/datum/species/human = 50,
	/datum/species/lizard = 20,
	/datum/species/elzuose = 10,
	/datum/species/moth = 10,
	/datum/species/spider = 10,
))

// this shit sucks man

/obj/effect/mob_spawn/human/corpse/damaged/whitesands/Initialize(mapload, species) //everything here should equal out to 100 for the sake of my sanity.
	mob_species = species || pick_weight(GLOB.hermit_species_weights)

	outfit = pick_weight(list(
			/datum/outfit/hermit = 24,
			/datum/outfit/hermit/brown = 24,
			/datum/outfit/hermit/green = 24,
			/datum/outfit/hermit/yellow = 24,
			/datum/outfit/hermit/jermit = 4,
			)
	)
	//gloves are a tossup
	gloves = pick_weight(list(
			/obj/item/clothing/gloves/color/black = 60,
			/obj/item/clothing/gloves/explorer = 30,
			/obj/item/clothing/gloves/explorer/old = 10
			)
		)

	belt = pick_weight(list(
			/obj/item/storage/belt/mining = 30,
			/obj/item/storage/belt/bandolier = 30,
			/obj/item/storage/belt/military = 5,
			/obj/item/storage/belt/fannypack = 15,
			/obj/item/storage/belt/mining/alt = 15,
			/obj/item/storage/belt/mining/primitive = 5
			)
		)

	//bags are semi-random.
	back = pick_weight(list(
			/obj/item/storage/backpack = 20,
			/obj/item/storage/backpack/explorer = 20,
			/obj/item/storage/backpack/satchel = 20,
			/obj/item/storage/backpack/satchel/explorer = 20,
			/obj/item/storage/backpack/messenger = 20
			)
		)

	//as are bag contents
	backpack_contents = list()
	if(prob(70))
		backpack_contents += pick_weight(list( //these could stand to be expanded, right now they're just mildly modified miner ones, and I don't know how to plus that up.
			/obj/item/soap = 10,
			/obj/item/stack/marker_beacon/ten = 15,
			/obj/item/mining_scanner = 5,
			/obj/item/extinguisher/mini = 10,
			/obj/item/melee/knife/combat = 5,
			/obj/item/flashlight/seclite = 10,
			/obj/item/stack/sheet/sinew = 10,
			/obj/item/stack/sheet/bone = 5,
			/obj/item/stack/sheet/animalhide/goliath_hide = 10,
			/obj/item/stack/sheet/bone = 8,
			/obj/item/reagent_containers/food/drinks/waterbottle = 10,
			/obj/item/reagent_containers/food/drinks/waterbottle/empty = 2,
			)
		)
	if(prob(70))
		backpack_contents += pick_weight(list(
			/obj/item/stack/sheet/animalhide/goliath_hide = 20,
			/obj/item/stack/marker_beacon/ten = 10,
			/obj/item/mining_scanner = 20,
			/obj/item/extinguisher/mini = 10,
			/obj/item/melee/knife/survival = 10,
			/obj/item/flashlight/seclite = 10,
			/obj/item/stack/sheet/sinew = 10,
			/obj/item/stack/sheet/bone = 10
			)
		)
	if(prob(70))
		backpack_contents += pick_weight(list(
			/obj/item/stack/sheet/animalhide/goliath_hide = 5,
			/obj/item/stack/marker_beacon/ten = 5,
			/obj/item/mining_scanner = 5,
			/obj/item/extinguisher/mini = 10,
			/obj/item/melee/knife/survival = 12,
			/obj/item/flashlight/seclite = 10,
			/obj/item/stack/sheet/sinew = 5,
			/obj/item/stack/sheet/bone = 5,
			/obj/item/melee/knife/combat = 3,
			/obj/item/storage/ration/shredded_beef = 30
			)
		)
	if (prob(15)) //mayhaps a medkit
		backpack_contents += pick_weight(list(
			/obj/item/storage/firstaid/regular = 50,
			/obj/item/storage/firstaid/brute = 15,
			/obj/item/storage/firstaid/medical = 15,
			/obj/item/storage/firstaid/fire = 10,
			/obj/item/storage/firstaid/advanced = 5,
			/obj/item/storage/firstaid/ancient = 5
			)
		)
	if(prob(30)) //some pens maybe?
		backpack_contents += /obj/item/reagent_containers/hypospray/medipen/survival
	if(prob(5))
		backpack_contents += /obj/item/reagent_containers/hypospray/medipen/combat_drug

	//masks
	mask = pick_weight(list(
		/obj/item/clothing/mask/gas = 40,
		/obj/item/clothing/mask/gas/explorer = 20,
		/obj/item/clothing/mask/gas/syndicate = 20,
		)
	)

	//the eyes are the window into the soul.
	if(prob(70))
		glasses = pick_weight(list(
			/obj/item/clothing/glasses/heat = 20,
			/obj/item/clothing/glasses/cold = 20,
			/obj/item/clothing/glasses/meson = 40,
			/obj/item/clothing/glasses = 20
			)
		)

	//and of course, ears.
	if(prob(1)) //oh my god they can't hear the sandstorm coming they've got airpods in
		ears = /obj/item/instrument/piano_synth/headphones/spacepods
	else
		ears = pick_weight(list(
			/obj/item/radio/headset = 50,
			/obj/item/radio/headset/alt = 50
			)
		)
	. = ..(mapload, species)

/datum/outfit/hermit
	name = "Whitesands Survivor"
	uniform = /obj/item/clothing/under/color/random
	back = /obj/item/storage/backpack
	shoes = /obj/item/clothing/shoes/workboots/mining
	suit = /obj/item/clothing/suit/hooded/survivor
	r_pocket = /obj/item/tank/internals/emergency_oxygen/engi
	gloves = /obj/item/clothing/gloves/color/black
	head = /obj/item/clothing/head/hooded/survivor_hood

/datum/outfit/hermit/post_equip(mob/living/carbon/human/H, visualsOnly)
	. = ..()
	if(visualsOnly)
		return
	H.faction |= list(FACTION_ANTAG_HERMITS)

/datum/outfit/hermit/brown
	name = "Whitesands Survivor Brown"
	suit = /obj/item/clothing/suit/hooded/survivor/brown
	head = /obj/item/clothing/head/hooded/survivor_hood/brown

/datum/outfit/hermit/yellow
	name = "Whitesands Survivor Yellow"
	suit = /obj/item/clothing/suit/hooded/survivor/yellow
	head = /obj/item/clothing/head/hooded/survivor_hood/yellow

/datum/outfit/hermit/green
	name = "Whitesands Survivor Green"
	suit = /obj/item/clothing/suit/hooded/survivor/green
	head = /obj/item/clothing/head/hooded/survivor_hood/green

/datum/outfit/hermit/jermit
	name = "Whitesands Survivor Jermit"
	suit = /obj/item/clothing/suit/hooded/survivor/jermit
	head = /obj/item/clothing/head/hooded/survivor_hood/jermit

/datum/outfit/mayor
	name = "The Mayor"

	uniform = /obj/item/clothing/under/syndicate
	suit = /obj/item/clothing/suit/space/hardsuit/syndi/old
	head = /obj/item/clothing/head/helmet/space/hardsuit/syndi/old
	mask = /obj/item/clothing/mask/breath/facemask
	glasses = /obj/item/clothing/glasses/safety
	belt = /obj/item/storage/belt/security/military/frontiersmen
	shoes = /obj/item/clothing/shoes/combat
	gloves =  /obj/item/clothing/gloves/combat
	r_pocket = /obj/item/tank/internals/emergency_oxygen/engi
	back = /obj/item/storage/backpack
	ears = /obj/item/radio/headset/alt

/obj/effect/mob_spawn/human/corpse/damaged/mayor
	name = "The Mayor"
	outfit = /datum/outfit/mayor

/datum/outfit/swampboss
	name = "Hermit Warlord"
	uniform = /obj/item/clothing/under/pants/camo
	shoes = /obj/item/clothing/shoes/workboots/mining
	suit = /obj/item/clothing/suit/armor/roumain/plate/medium
	r_pocket = /obj/item/tank/internals/emergency_oxygen/engi
	belt = /obj/item/storage/belt/security/military/frontiersmen
	gloves = /obj/item/clothing/gloves/fingerless
	head = /obj/item/clothing/head/boonie/brown
	mask = /obj/item/clothing/mask/gas/explorer

/obj/effect/mob_spawn/human/corpse/damaged/swampboss
	name = "Hermit Warlord"
	outfit = /datum/outfit/swampboss

/datum/outfit/bodyguard
	name = "The Bouncer"

	uniform = /obj/item/clothing/under/color/random
	back = /obj/item/storage/backpack
	shoes = /obj/item/clothing/shoes/combat
	suit = /obj/item/clothing/suit/hooded/survivor
	r_pocket = /obj/item/tank/internals/emergency_oxygen/engi
	gloves = /obj/item/clothing/gloves/color/black
	head = /obj/item/clothing/head/helmet/m10/warra
	belt = /obj/item/storage/belt/security/military/frontiersmen
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses
	mask = /obj/item/clothing/mask/gas/sechailer

/obj/effect/mob_spawn/human/corpse/damaged/bodyguard
	name = "The Bouncer"
	mob_gender = MALE
	outfit = /datum/outfit/bodyguard

/datum/outfit/engineer
	name = "The Engineer"

	uniform = /obj/item/clothing/under/warra/engineering
	back = /obj/item/storage/backpack/duffelbag/engineering
	shoes = /obj/item/clothing/shoes/workboots
	suit = /obj/item/clothing/suit/warra/vest
	r_pocket = /obj/item/tank/internals/emergency_oxygen/engi
	gloves = /obj/item/clothing/gloves/insulated
	head = /obj/item/clothing/head/hardhat/warra
	belt = /obj/item/storage/belt/utility/full/engi
	mask = /obj/item/clothing/mask/breath

/obj/effect/mob_spawn/human/corpse/damaged/engineer
	name = "The Engineer"
	outfit = /datum/outfit/engineer
