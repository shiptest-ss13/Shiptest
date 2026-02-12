/datum/blackmarket_item/clothing
	category = "Clothing"

/datum/blackmarket_item/clothing/cloth
	name = "Build Your Own Jumpsuit Special"
	desc = "Ever wanted to learn how to sew? This lovely selection of cloth is perfect to get some practice with."
	item = /obj/item/stack/sheet/cotton/cloth/ten

	cost_min = 200
	cost_max = 400
	stock_max = 5
	availability_prob = 80

/datum/blackmarket_item/clothing/surplus_uniform
	name = "Surplus Combat Uniforms"
	desc = "A mass produced and non-descript surplus combat uniform. For when you need to look like another faceless thug in the crowd."
	item = /obj/item/clothing/under/rank/security/officer/military

	cost_min = 25
	cost_max = 50
	stock_min = 5
	stock_max = 10
	availability_prob = 80

/datum/blackmarket_item/clothing/camo_uniform
	name = "Camo Fatigues"
	desc = "General purpose camoflague fatigues with a polychromatic design for use in different conditions."
	item = /obj/item/clothing/under/rank/security/officer/camo

	cost_min = 25
	cost_max = 50
	stock_min = 5
	stock_max = 10
	availability_prob = 80

/datum/blackmarket_item/clothing/terragov
	name = "Vintage TerraGov Tunics"
	desc = "These were supposed to be shipped to a museum exhibition celebrating history in some distant Solarian canton. Honestly, we're doing them a favour. Clothes are meant to be worn rather than kept in some dusty box."
	item = /obj/item/clothing/under/solgov/terragov

	cost_min = 25
	cost_max = 50
	stock_min = 2
	stock_max = 5
	availability_prob = 50

/datum/blackmarket_item/clothing/gm_uniform
	name = "Gorlex Marauder Uniform"
	desc = "These here are genuine vacuum preserved ICW era Marauder uniforms. The chill of space kept em in pretty good condition on their old owners."
	item = /obj/item/clothing/under/syndicate/gorlex

	cost_min = 25
	cost_max = 50
	stock_min = 5
	stock_max = 10
	availability_prob = 50

/datum/blackmarket_item/clothing/fm_uniform
	name = "Frontiersmen Uniform"
	desc = "The Frontiersmen make these things in bulk due to the number of recruits they tend to go through. They'd reuse the old ones, but apparently wearing something someone died in is apparently \"bad\" for morale."
	item = /obj/item/clothing/under/frontiersmen

	cost_min = 25
	cost_max = 50
	stock_min = 5
	stock_max = 10
	availability_prob = 50

/datum/blackmarket_item/clothing/sack_mask
	name = "Sack Gas Mask"
	desc = "This thing is like breathing through a burlap sack. Mainly because it is one."
	item = /obj/item/clothing/mask/gas/frontiersmen

	cost_min = 10
	cost_max = 30
	stock_min = 5
	stock_max = 10
	availability_prob = 50

/datum/blackmarket_item/clothing/coalition_mask
	name = "Coalition Gas Mask"
	desc = "Ever wanted to look like a paramilitary psychopath? Now's your chance!"
	item = /obj/item/clothing/mask/gas/syndicate

	cost_min = 10
	cost_max = 30
	stock_min = 5
	stock_max = 10
	availability_prob = 50

/datum/blackmarket_item/clothing/durathread_vest
	name = "Durathread Vest"
	desc = "Don't let them tell you this stuff is \"Like asbestos\" or \"Pulled from the market for safety concerns\". It could be the difference between a robusting and a retaliation."
	item = /obj/item/clothing/suit/armor/vest/durathread

	cost_min = 200
	cost_max = 400
	stock_max = 4
	availability_prob = 50

/datum/blackmarket_item/clothing/durathread_helmet
	name = "Durathread Helmet"
	desc = "Customers ask why it's called a helmet when it's just made from armoured fabric and I always say the same thing: No refunds."
	item = /obj/item/clothing/head/helmet/durathread

	cost_min = 100
	cost_max = 200
	stock_max = 4
	availability_prob = 50

/datum/blackmarket_item/clothing/duster
	name = "Reinforced Duster"
	desc = "Vests not your style? Embrace your inner trailblazer with this armored duster!"
	item = /obj/item/clothing/suit/armor/vest/duster

	cost_min = 500
	cost_max = 1000
	stock_max = 3
	availability_prob = 50

/datum/blackmarket_item/clothing/degraded_armor_set
	name = "Clearance Bin Armor Set"
	desc = "Looking to protect yourself, but on a tight budget? These previously used vest and helmets served their former owners well! (May they rest in peace.)"
	item = /obj/item/storage/backpack/duffelbag/sec

	cost_min = 100
	cost_max = 400
	stock_min = 4
	stock_max = 6
	availability_prob = 80

/datum/blackmarket_item/clothing/degraded_armor_set/spawn_item(loc)
	var/obj/item/storage/backpack/duffelbag/sec/B = ..()
	B.name = "Worn Duffelbag"
	B.desc = "It smells distinctly of iron."
	new /obj/item/clothing/head/helmet/old(B)
	new /obj/item/clothing/suit/armor/vest/old(B)
	return B

/datum/blackmarket_item/clothing/camo_set
	name = "Camo Set"
	desc = "Want to be somewhere you shouldn't? This advanced polychromatic uniform set features patterns such as woodland, urban, snowy and your grandmother's ugly couch to help you blend into any environment. Includes fatigues, helment and webbing."
	item = /obj/item/storage/backpack/duffelbag/sec

	cost_min = 500
	cost_max = 1000
	stock_min = 2
	stock_max = 8
	availability_prob = 50

/datum/blackmarket_item/clothing/camo_set/spawn_item(loc)
	var/obj/item/storage/backpack/duffelbag/sec/B = ..()
	B.name = "Worn Duffelbag"
	B.desc = "A beat up looking dufflebag."
	new /obj/item/storage/belt/military(B)
	new /obj/item/clothing/head/helmet/m10(B)
	new /obj/item/clothing/under/rank/security/officer/camo(B)
	return B

/datum/blackmarket_item/clothing/frontiersmen_armor_set
	name = "Bulletproof X-11 Armor Set"
	desc = "We got a good deal on some extra armor from a Frontiersmen Quartermaster, and we're passing those savings onto you!"
	item = /obj/item/storage/backpack/duffelbag/sec

	cost_min = 500
	cost_max = 1250
	stock_max = 3
	availability_prob = 50

/datum/blackmarket_item/clothing/frontiersmen_armor_set/spawn_item(loc)
	var/obj/item/storage/backpack/duffelbag/sec/B = ..()
	B.name = "Worn Duffelbag"
	B.desc = "A beat up looking dufflebag with some armor inside."
	new /obj/item/clothing/suit/armor/vest/bulletproof/frontier(B)
	new /obj/item/clothing/head/helmet/bulletproof/x11/frontier(B)
	return B

/datum/blackmarket_item/clothing/frontiersmen_armor_fireproof
	name = "Fireproof Armor Set"
	desc = "Get it while it's hot! This fireproofed armor and uniform set is made with a pre-Night Of Fire miracle material that renders it almost impervious to flames. The Frontiersmen swear by the stuff. It's kept each of it's previous owners safe until they passed away from illness."
	item = /obj/item/storage/backpack/duffelbag/sec

	cost_min = 1000
	cost_max = 1750
	stock_max = 3
	availability_prob = 50

/datum/blackmarket_item/clothing/frontiersmen_armor_fireproof/spawn_item(loc)
	var/obj/item/storage/backpack/duffelbag/sec/B = ..()
	B.name = "Singed Duffelbag"
	B.desc = "It smells like kerosene."
	new /obj/item/clothing/suit/armor/frontier/fireproof(B)
	new /obj/item/clothing/head/helmet/bulletproof/x11/frontier/fireproof(B)
	new /obj/item/clothing/under/frontiersmen/fireproof(B)
	new /obj/item/clothing/mask/gas/frontiersmen(B)
	return B

/datum/blackmarket_item/clothing/coalition_armor
	name = "Coalition Surplus Pack"
	desc = "A set of Coalition surplus armor from the ICW. Slightly used, but you can barely even see the bloodstains on the red."
	item = /obj/item/storage/backpack/duffelbag/syndie

	cost_min = 500
	cost_max = 800
	stock_max = 5
	availability_prob = 50

/datum/blackmarket_item/clothing/coalition_armor/spawn_item(loc)
	var/obj/item/storage/backpack/duffelbag/syndie/B = ..()
	new /obj/item/clothing/suit/armor/vest/syndie(B)
	new /obj/item/clothing/head/helmet/syndie(B)
	return B

/datum/blackmarket_item/clothing/gezena_armor
	name = "Gezenan Composite Armor Set"
	desc = "A genuine set of composite body armor used by the PGF Marine Corps. We even tossed in one of their little mask thingies. If a military guy in a cape comes by, play dumb."
	item =  /obj/item/storage/backpack/duffelbag/sec

	cost_min = 750
	cost_max = 1750
	stock_max = 3
	availability_prob = 20

/datum/blackmarket_item/clothing/gezena_armor/spawn_item(loc)
	var/obj/item/storage/backpack/duffelbag/sec/B = ..()
	B.name = "Armor Set Box"
	B.desc = "A beat up looking duffel with a frayed embroided nametag."
	new /obj/item/clothing/suit/armor/gezena/marine(B)
	new /obj/item/clothing/head/helmet/gezena(B)
	new /obj/item/clothing/mask/breath/pgfmask(B)
	new /obj/item/clothing/glasses/sunglasses/pgf(B)
	return B

/datum/blackmarket_item/clothing/full_spacesuit_set
	name = "\improper Nanotrasen Branded Spacesuit Set"
	desc = "A few boxes of \"Old Style\" space suits fell off the back of a space truck."
	item = /obj/item/storage/backpack/duffelbag

	cost_min = 250
	cost_max = 750
	stock_max = 3
	availability_prob = 70

/datum/blackmarket_item/clothing/full_spacesuit_set/spawn_item(loc)
	var/obj/item/storage/backpack/duffelbag/B = ..()
	B.name = "Spacesuit Duffelbag"
	B.desc = "It has a NT logo on it."
	new /obj/item/clothing/suit/space(B)
	new /obj/item/clothing/head/helmet/space(B)
	return B

/datum/blackmarket_item/clothing/syndie_spacesuit_set
	name = "\improper Coalition Branded Spacesuit Box"
	desc = "An armored syndicate softsuit, popular among the ACLF operatives who were too broke to get an actual hardsuit."
	item = /obj/item/storage/backpack/duffelbag/syndie

	cost_min = 750
	cost_max = 2500
	stock_max = 3
	availability_prob = 50

/datum/blackmarket_item/clothing/syndie_spacesuit_set/spawn_item(loc)
	var/obj/item/storage/backpack/duffelbag/syndie/B = ..()
	B.name = "Spacesuit Duffelbag"
	B.desc = "It has a Coalition logo stamped on the front."
	var/suit_color = pick(list("white_red", "blue", "beige", "worn", "worn_surplus", "yellow", "surplus"))

	switch(suit_color)
		if("white_red")
			new /obj/item/clothing/head/helmet/space/syndicate/white_red(B)
			new /obj/item/clothing/suit/space/syndicate/white_red(B)
		if("beige")
			new /obj/item/clothing/head/helmet/space/syndicate/ngr(B)
			new /obj/item/clothing/suit/space/syndicate/ngr(B)
		if("worn")
			new /obj/item/clothing/head/helmet/space/syndicate/ramzi(B)
			new /obj/item/clothing/suit/space/syndicate/ramzi(B)
		if("worn_surplus")
			new /obj/item/clothing/head/helmet/space/syndicate/ramzi/surplus(B)
			new /obj/item/clothing/suit/space/syndicate/ramzi/surplus(B)
		if("yellow")
			new /obj/item/clothing/head/helmet/space/syndicate/engie(B)
			new /obj/item/clothing/suit/space/syndicate/engie(B)
		if("surplus")
			new /obj/item/clothing/head/helmet/space/syndicate/surplus(B)
			new /obj/item/clothing/suit/space/syndicate/surplus(B)

	return B

/datum/blackmarket_item/clothing/chameleon_hat
	name = "Chameleon Hat"
	desc = "This all in one hat is always in style with it's adaptive color changing weave!."
	item = /obj/item/clothing/head/chameleon

	cost_min = 100
	cost_max = 200
	stock_max = 2
	availability_prob = 70

/datum/blackmarket_item/clothing/cham_kit
	name = "Chameleon Kit"
	desc = "Not sure what to wear? This adaptive set of clothing can change to suit whatever you desire! Quality tested."
	item = /obj/item/storage/box/syndie_kit/chameleon

	cost_min = 1000
	cost_max = 2500
	stock_max = 2
	availability_prob = 10
	spawn_weighting = FALSE

/datum/blackmarket_item/clothing/ablative_coat
	name = "Ablative Trenchcoat"
	desc = "An fullbody ablative trenchcoat and hood designed to massively disperse the impact of laser weaponry. Will not protect against bullets, knives, or mean words about your choice of outfit."
	item = /obj/item/clothing/suit/hooded/ablative

	cost_min = 1000
	cost_max = 2500
	stock_max = 3
	availability_prob = 40

/datum/blackmarket_item/clothing/combatmedic_suit
	name = "Combat Medic Hardsuit"
	desc = "A discarded combat medic hardsuit, found in the ruins of a carpet bombed xeno hive. Definitely used, but as sturdy as an anchor."
	item = /obj/item/clothing/suit/space/hardsuit/combatmedic

	cost_min = 1000
	cost_max = 2500
	stock_max = 3
	availability_prob = 30

/datum/blackmarket_item/clothing/ramzi_suit
	name = "Rusted Red Hardsuit"
	desc = "A vintage ICW Era Gorlex Maruader hardsuit. The previous owner said we could have it when we pried it off their cold dead hands. Dry cleaning not included."
	item = /obj/item/clothing/suit/space/hardsuit/syndi/ramzi

	cost_min = 1500
	cost_max = 2500
	stock_max = 3
	availability_prob = 30

/datum/blackmarket_item/clothing/frontiersmen_hardsuit
	name = "Frontiersmen Hardsuit"
	desc = "An old but durable hardsuit typically used by the Frontiersmen. We accept no liability if you're shot by CLIP while wearing this."
	item = /obj/item/clothing/suit/space/hardsuit/security/independent/frontier

	cost_min = 1000
	cost_max = 2000
	stock_max = 3
	availability_prob = 40

/datum/blackmarket_item/clothing/old_blood_red
	name = "Damaged Blood-Red Hardsuit"
	desc = "Don't even know where we got this thing, but it is so damaged beyond repair I just gotta get rid of it. We'll give it to ya cheap, isn't even EVA-worthy."
	item = /obj/item/clothing/suit/space/hardsuit/syndi/old

	cost_min = 800
	cost_max = 1500
	stock_max = 1
	availability_prob = 40

/datum/blackmarket_item/clothing/stealth_hardsuit
	name = "INF-95 Tactical Hardsuit"
	desc = "My friend recently died, bummer right? Well not actually, because I went through his garage and looted tons'a shit! Turns out, he's had this ANTIQUE ICW HARDSUIT sitting about! I dont even know jack about it, but it weighs like nothing and has night vision to boot."
	item = /obj/item/clothing/suit/space/hardsuit/stealth

	cost_min = 4000
	cost_max = 5500
	stock_max = 1
	availability_prob = 20

/datum/blackmarket_item/clothing/thermal_eyepatch
	name = "Thermal Eyepatch"
	desc = "A thermal eyepatch, capable of tracking the heat signatures of living beings through solid objects."
	item = /obj/item/clothing/glasses/thermal/eyepatch

	cost_min = 2500
	cost_max = 3500
	stock = 1
	availability_prob = 15
	spawn_weighting = FALSE

/datum/blackmarket_item/clothing/jumpboots
	name = "Jump Boots"
	desc = "Jump ahead of the competition with these specialized mining boots!"
	item = /obj/item/clothing/shoes/bhop

	cost_min = 100
	cost_max = 1000
	stock = 3
	availability_prob = 30

/datum/blackmarket_item/clothing/rocket_gloves
	name = "Rocket Gloves"
	desc = "The pinacle of tackling technology, no one will be able to resist a tackle from these rocket propelled gloves. Make sure not to miss though, we don't sell wheelchairs."
	item = /obj/item/clothing/gloves/tackler/rocket

	cost_min = 500
	cost_max = 2000
	stock_max = 3
	availability_prob = 30
	spawn_weighting = FALSE

/datum/blackmarket_item/clothing/krav_gloves
	name = "Krav Maga Gloves"
	desc = "Go for the throat! These special gloves will let you perform advanced Krav Maga techniques like a pro without any of the usual hurdles like \"talent\", \"training\", or \"hard work\"."
	item = /obj/item/clothing/gloves/krav_maga/sec

	cost_min = 1000
	cost_max = 2000
	stock = 1
	availability_prob = 15
	spawn_weighting = FALSE
