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
		hat = pickweight(list(
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
			/obj/item/clothing/gloves/color/white = 1,
			/obj/item/clothing/gloves/color/evening = 1,
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
	back = pickweight(list(
		/obj/item/storage/backpack = 1,
		/obj/item/storage/backpack/satchel = 1,
		/obj/item/storage/backpack/duffelbag = 1,
		/obj/item/storage/backpack/messenger = 1,
		/obj/item/storage/backpack/satchel/leather = 1
		)
	)

/datum/outfit/generic
	name "Generic"
