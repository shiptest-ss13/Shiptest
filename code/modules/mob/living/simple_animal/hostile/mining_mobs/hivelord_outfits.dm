/datum/outfit/generic/pre_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	uniform = pickweight(list(
		/obj/item/clothing/under/utility = 1,
		/obj/item/clothing/under/utility/skirt = 1,
		/obj/item/clothing/under/color/black = 1,
		/obj/item/clothing/under/color/white = 1,
		/obj/item/clothing/under/color/random = 1,
		/obj/item/clothing/under/shorts/black = 1,
		/obj/item/clothing/under/shorts/grey = 1,
		/obj/item/clothing/under/shorts/blue = 1,
		/obj/item/clothing/under/shorts/green = 1,
		/obj/item/clothing/under/pants/jeans = 1,
		/obj/item/clothing/under/pants/khaki = 1,
		/obj/item/clothing/under/pants/tan = 1,
		/obj/item/clothing/under/pants/white = 1,
		/obj/item/clothing/under/pants/red = 1,
		/obj/item/clothing/under/pants/track = 1,
		/obj/item/clothing/under/pants/blackjeans = 1,
		/obj/item/clothing/under/pants/black = 1,
		/obj/item/clothing/under/pants/camo = 1,
		/obj/item/clothing/under/suit/white = 1,
		/obj/item/clothing/under/suit/tan = 1,
		/obj/item/clothing/under/suit/black_really = 1,
		/obj/item/clothing/under/suit/navy = 1,
		/obj/item/clothing/under/suit/burgundy = 1,
		/obj/item/clothing/under/suit/charcoal = 1,
		/obj/item/clothing/under/rank/civilian/lawyer/galaxy = 1,
		/obj/item/clothing/under/suit/black/skirt = 1,
		/obj/item/clothing/under/suit/black = 1,
		/obj/item/clothing/under/dress/sailor = 1,
		/obj/item/clothing/under/dress/striped = 1,
		/obj/item/clothing/under/dress/skirt/blue = 1,
		/obj/item/clothing/under/syndicate/tacticool = 1,
		)
	)
	suit = pickweight(list(
		/obj/item/clothing/suit/hooded/wintercoat = 1,
		/obj/item/clothing/suit/jacket = 1,
		/obj/item/clothing/suit/jacket/leather = 1,
		/obj/item/clothing/suit/jacket/leather/overcoat = 1,
		/obj/item/clothing/suit/jacket/leather/duster = 1,
		/obj/item/clothing/suit/jacket/miljacket = 1,
		/obj/item/clothing/suit/jacket/puffer = 1,
		/obj/item/clothing/suit/gothcoat = 1,
		/obj/item/clothing/suit/toggle/industrial = 1,
		/obj/item/clothing/suit/toggle/hazard = 1,
		/obj/item/clothing/suit/poncho/green = 1,
		/obj/item/clothing/suit/apron/overalls = 1,
		/obj/item/clothing/suit/ianshirt = 1
		)
	)
	shoes = pickweight(list(
		/obj/item/clothing/shoes/laceup = 1,
		/obj/item/clothing/shoes/sandal = 1,
		/obj/item/clothing/shoes/winterboots = 1,
		/obj/item/clothing/shoes/jackboots = 1,
		/obj/item/clothing/shoes/workboots/mining = 1,
		/obj/item/clothing/shoes/workboots = 1,
		/obj/item/clothing/shoes/sneakers/black = 1,
		/obj/item/clothing/shoes/sneakers/brown = 1,
		/obj/item/clothing/shoes/sneakers/white = 1
		)
	)
	if(prob(50))
		head = pickweight(list(
			/obj/item/clothing/head/hardhat = 1,
			/obj/item/clothing/head/hardhat/orange = 1,
			/obj/item/clothing/head/hardhat/dblue = 1,
			/obj/item/clothing/head/beret = 1,
			/obj/item/clothing/head/beret/grey = 1,
			/obj/item/clothing/head/beret/ce = 1,
			/obj/item/clothing/head/flatcap = 1,
			/obj/item/clothing/head/beanie = 1,
			/obj/item/clothing/head/foilhat = 1,
			/obj/item/clothing/head/cowboy = 1,
			/obj/item/clothing/head/pirate = 1,
			/obj/item/clothing/head/trapper = 1
			)
		)
	if(prob(50))
		glasses = pickweight(list(
			/obj/item/clothing/glasses/regular = 1,
			/obj/item/clothing/glasses/regular/circle = 1,
			/obj/item/clothing/glasses/regular/jamjar = 1,
			/obj/item/clothing/glasses/eyepatch = 1,
			/obj/item/clothing/glasses/cheapsuns = 1,
			/obj/item/clothing/glasses/regular/hipster = 1,
			/obj/item/clothing/glasses/cold = 1,
			/obj/item/clothing/glasses/heat = 1,
			/obj/item/clothing/glasses/orange = 1,
			/obj/item/clothing/glasses/red = 1
			)
		)
	if(prob(50))
		gloves = pickweight(list(
			/obj/item/clothing/gloves/color/black = 1,
			/obj/item/clothing/gloves/fingerless = 1,
			/obj/item/clothing/gloves/color/white = 1,
			)
		)
	if(prob(50))
		neck = pickweight(list(
			/obj/item/clothing/neck/scarf/red = 1,
			/obj/item/clothing/neck/scarf/green = 1,
			/obj/item/clothing/neck/scarf/darkblue = 1,
			/obj/item/clothing/neck/shemagh = 1,
			/obj/item/clothing/neck/stripedredscarf = 1,
			/obj/item/clothing/neck/stripedgreenscarf = 1,
			/obj/item/clothing/neck/stripedbluescarf = 1
			)
		)
	if(prob(50))
		mask = pickweight(list(
			/obj/item/clothing/mask/balaclava = 1,
			/obj/item/clothing/mask/bandana/red = 1,
			/obj/item/clothing/mask/gas = 1,
			/obj/item/clothing/mask/breath = 1,
			)
		)
	back = pickweight(list(
		/obj/item/storage/backpack = 1,
		/obj/item/storage/backpack/satchel = 1,
		/obj/item/storage/backpack/duffelbag = 1,
		/obj/item/storage/backpack/messenger = 1,
		/obj/item/storage/backpack/satchel/leather = 1
		)
	)
	backpack_contents += pickweight(list(
		/obj/item/dice/d20,
		/obj/item/lipstick/black,
		/obj/item/lipstick,
		/obj/item/clothing/mask/balaclava,
		/obj/item/clothing/mask/vape,
		/obj/item/clothing/mask/vape/cigar,
		/obj/item/clothing/mask/bandana/red,
		/obj/item/storage/book/bible,
		/obj/item/reagent_containers/food/drinks/flask,
		/obj/item/reagent_containers/food/drinks/britcup,
		/obj/item/lighter/greyscale,
		/obj/item/lighter,
		/obj/item/toy/cards/deck,
		/obj/item/toy/eightball,
		/obj/item/storage/wallet,
		/obj/item/paicard,
		/obj/item/modular_computer/tablet/preset/cheap,
		/obj/item/modular_computer/laptop/preset/civilian,
		/obj/item/pen,
		/obj/item/pen/fourcolor,
		/obj/item/paper_bin,
		/obj/item/cane,
		/obj/item/radio,
		/obj/item/toy/plush/lizardplushie,
		/obj/item/toy/plush/snakeplushie,
		/obj/item/toy/plush/moth,
		/obj/item/toy/plush/hornet,
		/obj/item/toy/plush/hornet/gay,
		/obj/item/toy/plush/knight,
		/obj/item/toy/plush/among,
		/obj/item/dyespray,
		/obj/item/table_bell/brass,
		/obj/item/flashlight,
		/obj/item/crowbar/red,
		)
	)

/datum/outfit/generic

/datum/outfit/generric/miner/pre_equip(mob/living/carbon/human/H, visualsOnly)
	. = ..()
	if(prob(2))
		mob_species = /datum/species/plasmaman
		uniform = /obj/item/clothing/under/plasmaman
		head = /obj/item/clothing/head/helmet/space/plasmaman
		belt = /obj/item/tank/internals/plasmaman/belt
	else
		uniform = /obj/item/clothing/under/rank/cargo/miner/lavaland
		if (prob(4))
			belt = pickweight(list(
				/obj/item/storage/belt/mining = 2,
				/obj/item/storage/belt/mining/alt = 2
				)
			)
		else if(prob(10))
			belt = pickweight(list(
				/obj/item/pickaxe = 8,
				/obj/item/pickaxe/mini = 4,
				/obj/item/pickaxe/silver = 2,
				/obj/item/pickaxe/diamond = 1,
				/obj/item/gun/energy/kinetic_accelerator = 1
				)
			)
		else
			belt = /obj/item/tank/internals/emergency_oxygen/engi
	if(mob_species != /datum/species/lizard)
		shoes = /obj/item/clothing/shoes/workboots/mining
	gloves = /obj/item/clothing/gloves/color/black
	mask = /obj/item/clothing/mask/gas/explorer
	if(prob(45))
		glasses = /obj/item/clothing/glasses/meson
	if(prob(20))
		suit = pickweight(list(
			/obj/item/clothing/suit/hooded/explorer = 18,
			/obj/item/clothing/suit/hooded/cloak/goliath = 2
			)
		)
	if(prob(30))
		r_pocket = pickweight(list(
			/obj/item/stack/marker_beacon = 20,
			/obj/item/spacecash/bundle/mediumrand = 7,
			/obj/item/reagent_containers/hypospray/medipen/survival = 2,
			/obj/item/borg/upgrade/modkit/damage = 1
			)
		)
	if(prob(10))
		l_pocket = pickweight(list(
			/obj/item/spacecash/bundle/mediumrand = 7,
			/obj/item/reagent_containers/hypospray/medipen/survival = 2,
			/obj/item/borg/upgrade/modkit/cooldown = 1
			)
		)
	if(prob(95))
		back = /obj/item/storage/backpack/explorer
		backpack_contents = list(/obj/item/radio)
		if(prob(70))
			backpack_contents += pickweight(list(
				/obj/item/borg/upgrade/modkit/damage = 1,
				/obj/item/borg/upgrade/modkit/trigger_guard = 1,
				/obj/item/soap/nanotrasen = 1,
				/obj/item/wormhole_jaunter = 1,
				/obj/item/fulton_core = 1,
				/obj/item/extraction_pack = 2,
				/obj/item/stack/sheet/animalhide/goliath_hide = 3,
				/obj/item/hivelordstabilizer = 2,
				/obj/item/stack/marker_beacon/ten = 2,
				/obj/item/mining_scanner = 2,
				/obj/item/extinguisher/mini = 2,
				/obj/item/kitchen/knife/combat/survival = 3,
				/obj/item/flashlight/seclite=3,
				/obj/item/stack/sheet/sinew = 3,
				/obj/item/stack/sheet/bone = 3
				)
			)
		if(prob(70))
			backpack_contents += pickweight(list(
				/obj/item/borg/upgrade/modkit/damage = 1,
				/obj/item/borg/upgrade/modkit/trigger_guard = 1,
				/obj/item/soap/nanotrasen = 1,
				/obj/item/wormhole_jaunter = 1,
				/obj/item/fulton_core = 1,
				/obj/item/extraction_pack = 2,
				/obj/item/stack/sheet/animalhide/goliath_hide = 3,
				/obj/item/hivelordstabilizer = 2,
				/obj/item/stack/marker_beacon/ten = 2,
				/obj/item/mining_scanner = 2,
				/obj/item/extinguisher/mini = 2,
				/obj/item/kitchen/knife/combat/survival = 3,
				/obj/item/flashlight/seclite = 3,
				/obj/item/stack/sheet/sinew = 3,
				/obj/item/stack/sheet/bone = 3
				)
			)
		if(prob(70))
			backpack_contents += pickweight(list(
				/obj/item/borg/upgrade/modkit/damage = 1,
				/obj/item/borg/upgrade/modkit/trigger_guard = 1,
				/obj/item/soap/nanotrasen = 1,
				/obj/item/wormhole_jaunter = 1,
				/obj/item/fulton_core = 1,
				/obj/item/extraction_pack = 2,
				/obj/item/stack/sheet/animalhide/goliath_hide = 3,
				/obj/item/hivelordstabilizer = 2,
				/obj/item/stack/marker_beacon/ten = 2,
				/obj/item/mining_scanner = 2,
				/obj/item/extinguisher/mini = 2,
				/obj/item/kitchen/knife/combat/survival = 3,
				/obj/item/flashlight/seclite = 3,
				/obj/item/stack/sheet/sinew = 3,
				/obj/item/stack/sheet/bone = 3
				)
			)
		if(prob(30))
			backpack_contents += list(
				/obj/item/reagent_containers/hypospray/medipen/survival = pickweight(list(
					1 = 3,
					2 = 2,
					3 = 1
					)
				)
			)
	else
		back = /obj/item/kinetic_crusher
		backpack_contents = list()

/datum/outfit/generic/miner
