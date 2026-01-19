//Not only meat, actually, but also snacks that are almost meat, such as fish meat or tofu

/obj/item/food/cubancarp
	name = "carp sandwich"
	desc = "A sandwich consisting of heavily spiced and batter-fried fish. It's very hot!"
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "cubancarp"
	bite_consumption = 3
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/capsaicin = 1,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("fish" = 4, "batter" = 1, "hot peppers" = 1)
	foodtypes = MEAT | FRIED
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/fishmeat
	name = "fish fillet"
	desc = "A fillet of fresh fish."
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "fishfillet"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	bite_consumption = 6
	tastes = list("fish" = 1)
	foodtypes = MEAT
	eatverbs = list("bite", "chew", "gnaw", "swallow", "chomp")
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/fishmeat/moonfish
	name = "moonfish fillet"
	desc = "A fillet of moonfish."
	icon_state = "moonfish_fillet"

/obj/item/food/fishmeat/gunner_jellyfish
	name = "filleted gunner jellyfish"
	desc = "A gunner jellyfish with the stingers removed. Mildly hallucinogenic."
	icon_state = "jellyfish_fillet"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/toxin/mindbreaker = 2,
	)

/obj/item/food/fishmeat/armorfish
	name = "cleaned armorfish"
	desc = "An armorfish with its guts and shell removed, ready for use in cooking."
	icon_state = "armorfish_fillet"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 3,
	)

/obj/item/food/fishmeat/donkfish
	name = "donkfillet"
	desc = "The dreaded donkfish fillet. No sane spaceman would eat this, and it does not get better when cooked."
	icon_state = "donkfillet"
	food_reagents = list(
		/datum/reagent/yuck = 3,
	)

/obj/item/food/fishmeat/carp
	name = "carp fillet"
	desc = "A fillet of spess carp meat."
	food_reagents = list(
	/datum/reagent/consumable/nutriment/protein = 4,
	/datum/reagent/toxin/carpotoxin = 2,
	/datum/reagent/consumable/nutriment/vitamin = 2,
	)

/obj/item/food/fishmeat/carp/imitation
	name = "imitation carp fillet"
	desc = "Almost just like the real thing, kinda."

/obj/item/food/fishmeat/carp
	name = "carp fillet"
	desc = "A fillet of spess carp meat."
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/toxin/carpotoxin = 2,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)

/obj/item/food/fishmeat/carp/imitation
	name = "imitation carp fillet"
	desc = "Almost just like the real thing, kinda."

/obj/item/food/fishfingers
	name = "fish fingers"
	desc = "A rectangular serving of fish, battered and fried."
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "fishfingers"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	bite_consumption = 1
	tastes = list("fish" = 1, "breadcrumbs" = 1)
	foodtypes = MEAT | FRIED
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/fishandchips
	name = "fish and chips"
	desc = "Battered, fried fish alongside a side of potato fries."
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "fishandchips"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("fish" = 1, "chips" = 1)
	foodtypes = MEAT | VEGETABLES | FRIED

/obj/item/food/fishfry
	name = "fish fry"
	desc = "A plate full of pan-fried fish and vegetables. A side of fries would be nice."
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "fish_fry"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("fish" = 1, "pan seared vegtables" = 1)
	foodtypes = VEGETABLES | FRIED | SEAFOOD
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/vegetariansushiroll
	name = "vegetarian sushi roll"
	desc = "A sushi roll consisting of rice, carrots, and potatoes wrapped in seaweed. A techncial sibling to the \"california\" roll, but the origins of the name are unknown. Can be sliced into individual servings."
	icon_state = "vegan-sushi-roll"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 12,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("boiled rice" = 4, "carrots" = 2, "potato" = 2)
	foodtypes = VEGETABLES

/obj/item/food/vegetariansushiroll/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/vegetariansushislice, 4, 30, table_required = TRUE)

/obj/item/food/vegetariansushislice
	name = "vegetarian sushi slice"
	desc = "A slice of sushi consisting of rice, carrots, and potatoes."
	icon_state = "vegan-sushi-slice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("boiled rice" = 4, "carrots" = 2, "potato" = 2)
	foodtypes = VEGETABLES

/obj/item/food/spicyfiletsushiroll
	name = "spicy filet sushi roll"
	desc = "A makizushi roll containing spicy, raw fish wrapped with rice and other vegetables. can be sliced into individual servings."
	icon_state = "spicy-sushi-roll"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 12,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("boiled rice" = 4, "fish" = 2, "spicyness" = 2)
	foodtypes = VEGETABLES | MEAT

/obj/item/food/spicyfiletsushiroll/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/spicyfiletsushislice, 4, 30, table_required = TRUE)

/obj/item/food/spicyfiletsushislice
	name = "spicy filet sushi slice"
	desc = "A slice of a makizushi roll containing spicy, raw fish wrapped with rice and other vegetables."
	icon_state = "spicy-sushi-slice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("boiled rice" = 4, "fish" = 2, "spicyness" = 2)
	foodtypes = VEGETABLES | MEAT

/obj/item/food/onigiri
	name = "onigiri"
	desc = "A specially-shaped rice ball shaped around a filling, wrapped in seaweed. This one seems to lack a filling entirely..."
	icon_state = "onigiri"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("rice" = 1, "dried seaweed" = 1)
	foodtypes = VEGETABLES

/obj/item/food/temakiroll
	name = "Zohil temaki roll"
	desc = "A form of temaki roll originating from Zohil, which consists of a whole, specially prepared fish that is wrapped in seaweed."
	icon_state = "fi-shi"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 18,
		/datum/reagent/consumable/nutriment/vitamin = 8,
		/datum/reagent/toxin/carpotoxin = 8,
	)
	tastes = list("raw fish" = 6, "dried seaweed" = 3)
	foodtypes = VEGETABLES | MEAT

/obj/item/food/nigiri_sushi
	name = "nigiri sushi"
	desc = "A form of sushi, consisting of a hand-shaped rice mound with a topping of choice bound to it with seaweed. This one appears to have a topping of raw fish."
	icon_state = "nigiri_sushi"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("boiled rice" = 2, "fish filet" = 2, "soy sauce" = 2, "dried seaweed" = 1)
	foodtypes = VEGETABLES | MEAT

////////////////////////////////////////////MEATS AND ALIKE////////////////////////////////////////////

/obj/item/food/tofu
	name = "tofu"
	desc = "A culinary cornerstone of soy milk bean curds. Comes in many consistencies."
	icon_state = "tofu"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 2,
	)
	tastes = list("tofu" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/tofu/prison
	name = "soggy tofu"
	desc = "Tofu, while made of curds of soybean milk, isn't supposed to end up this way..."
	tastes = list("sour, rotten water" = 1)
	foodtypes = GROSS

/obj/item/food/cornedbeef
	name = "corned beef and cabbage"
	desc = "A meal consisting of cured beef boiled alongside a serving of cabbage. Fairly simple, but still filling."
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "cornedbeef"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("meat" = 1, "cabbage" = 1)
	foodtypes = MEAT | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/bearsteak
	name = "Filet migrawr"
	desc = "A sauteed cut of \"ursus aurora\", or a space bear. With enough heat, it neutralizes the naturally produced morphine within it."
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "bearsteak"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 9,
		/datum/reagent/consumable/ethanol/manly_dorf = 5,
	)
	tastes = list("meat" = 1, "salmon" = 1)
	foodtypes = MEAT | ALCOHOL
	w_class = WEIGHT_CLASS_SMALL

//Raw stuff
/obj/item/food/raw_meatball
	name = "raw meatball"
	desc = "A raw sphere of ground meat."
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "raw_meatball"
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 2)
	tastes = list("meat" = 1)
	foodtypes = MEAT | RAW
	w_class = WEIGHT_CLASS_SMALL

	var/meatball_type = /obj/item/food/meatball
	var/patty_type = /obj/item/food/raw_patty

/obj/item/food/raw_meatball/make_grillable()
	AddComponent(/datum/component/grillable, meatball_type, rand(30 SECONDS, 40 SECONDS), TRUE)

/obj/item/food/raw_meatball/make_processable()
	AddElement(/datum/element/processable, TOOL_ROLLINGPIN, patty_type, 1, 20)

/obj/item/food/raw_meatball/xeno
	name = "raw xeno meatball"
	meatball_type = /obj/item/food/meatball/xeno
	patty_type = /obj/item/food/raw_patty/xeno

/obj/item/food/raw_meatball/bear
	name = "raw bear meatball"
	meatball_type = /obj/item/food/meatball/bear
	patty_type = /obj/item/food/raw_patty/bear

/obj/item/food/raw_meatball/chicken
	name = "raw chicken meatball"
	meatball_type = /obj/item/food/meatball/chicken
	patty_type = /obj/item/food/raw_patty/chicken

/obj/item/food/meatball
	name = "meatball"
	desc = "Ground meat shaped into small balls, popularly eaten in sandwiches and alongside pasta."
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "meatball"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 2,
	)
	tastes = list("meat" = 1)
	foodtypes = MEAT
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/meatball/xeno
	name = "xenomorph meatball"
	tastes = list("meat" = 1, "acid" = 1)

/obj/item/food/meatball/bear
	name = "bear meatball"
	tastes = list("meat" = 1, "salmon" = 1)

/obj/item/food/meatball/chicken
	name = "chicken meatball"
	tastes = list("chicken" = 1)
	icon_state = "chicken_meatball"

/obj/item/food/raw_patty
	name = "raw patty"
	desc = "A raw patty of minced meat."
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "raw_patty"
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 2)
	tastes = list("meat" = 1)
	foodtypes = MEAT | RAW
	w_class = WEIGHT_CLASS_SMALL
	var/patty_type = /obj/item/food/patty/plain

/obj/item/food/raw_patty/make_grillable()
	AddComponent(/datum/component/grillable, patty_type, rand(30 SECONDS, 40 SECONDS), TRUE)

/obj/item/food/raw_patty/bear
	name = "raw bear patty"
	tastes = list("meat" = 1, "salmon" = 1)
	patty_type = /obj/item/food/patty/bear

/obj/item/food/raw_patty/xeno
	name = "raw xenomorph patty"
	tastes = list("meat" = 1, "acid" = 1)
	patty_type = /obj/item/food/patty/xeno

/obj/item/food/raw_patty/chicken
	name = "raw chicken patty"
	tastes = list("chicken" = 1)
	patty_type = /obj/item/food/patty/chicken

/obj/item/food/patty
	name = "patty"
	desc = "A cooked patty of minced meat."
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "patty"
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 2)
	tastes = list("meat" = 1)
	foodtypes = MEAT
	w_class = WEIGHT_CLASS_SMALL

///Exists purely for the crafting recipe (because itll take subtypes)
/obj/item/food/patty/plain

/obj/item/food/patty/xeno
	name = "xenomorph patty"
	tastes = list("meat" = 1, "acid" = 1)

/obj/item/food/patty/bear
	name = "bear patty"
	tastes = list("meat" = 1, "salmon" = 1)

/obj/item/food/patty/chicken
	name = "chicken patty"
	tastes = list("chicken" = 1)
	icon_state = "chicken_patty"

/obj/item/food/raw_sausage
	name = "raw sausage"
	desc = "A chunk of raw meat in a sausage casing."
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "raw_sausage"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("meat" = 1)
	foodtypes = MEAT | RAW
	eatverbs = list("bite","chew","nibble","deep throat","gobble","chomp")
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/raw_sausage/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/sausage, rand(60 SECONDS, 75 SECONDS), TRUE)

/obj/item/food/sausage
	name = "sausage"
	desc = "A serving of sausage, created by grinding meat and storing it in lengths of sausage casing."
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "sausage"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("meat" = 1)
	foodtypes = MEAT | BREAKFAST
	food_flags = FOOD_FINGER_FOOD
	eatverbs = list("bite", "chew", "nibble", "gobble", "chomp")
	w_class = WEIGHT_CLASS_SMALL
	var/roasted = FALSE

/obj/item/food/sausage/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/salami, 6, 3 SECONDS, table_required = TRUE,/*  screentip_verb = "Slice"*/)

/obj/item/food/salami
	name = "salami"
	desc = "A slice of cured, fermented meat."
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "salami"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 1,
	)
	tastes = list("meat" = 1, "smoke" = 1)
	foodtypes = MEAT
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/sausage/tiris_dote
	name = "tiris dotesu"
	desc = "A sweet sausage made with the fats of a Tiris and sweet dote berries."
	icon_state = "tiris-sausage"
	//filling_color = "#CD5C5C"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/nutriment/protein = 1,
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/consumable/dote_juice = 1,
	)
	tastes = list("sweet berries" = 1, "fatty meat" = 1)
	foodtypes = MEAT

/obj/item/food/sausage/tiris_refa //we having jalapeno brats tonight
	name = "tiris refasu"
	desc = "A spicy sausage made with the fats of a Tiris and ground up refa-li fruit."
	icon_state = "tiris-sausage"
	//filling_color = "#CD5C5C"
	tastes = list("pungent spice" = 1, "fatty meat" = 1)
	foodtypes = MEAT

/obj/item/food/sausage/tirila_li
	name = "Tirila-Li"
	desc = "Cured logs of Tiris spiced with refa-li, rock salts, and dotu. A favorite at casual gatherings, where it typically serves as an appetizer."
	icon_state = "tirila-li"
	//filling_color = "#CD5C5C"
	tastes = list("sweet berries" = 2, "fatty meat" = 3, "rock salts" = 1)
	foodtypes = MEAT

/obj/item/food/sausage/tirila_li/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/rila_li, 6, 3 SECONDS, table_required = TRUE)

/obj/item/food/rila_li
	name = "rila li slice"
	desc = "A slice of cured tiris."
	icon_state = "salami"
	//filling_color = "#CD4122"
	food_reagents = list(/datum/reagent/consumable/nutriment = 1)
	tastes = list("sweet berries" = 1, "fatty meat" = 1, "rock salts" = 1)
	food_flags = FOOD_FINGER_FOOD
	foodtypes = MEAT

/obj/item/food/rawkhinkali
	name = "raw khinkali"
	desc = "One of the many Solarian dumplings. This one is in the shape of a twisted knob, filled with meat, vegetables, and garlic. This one needs to be boiled."
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "khinkali"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/nutriment/protein = 1,
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/consumable/garlic = 1,
	)
	tastes = list("meat" = 1, "onions" = 1, "garlic" = 1)
	foodtypes = MEAT | RAW
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/rawkhinkali/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/khinkali, rand(50 SECONDS, 60 SECONDS), TRUE)

/obj/item/food/khinkali
	name = "khinkali"
	desc = "One of the many Solarian dumplings. This one is in the shape of a twisted knob, filled with meat, vegetables, and garlic."
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "khinkali"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/nutriment/protein = 1,
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/consumable/garlic = 1,
	)
	bite_consumption = 3
	tastes = list("meat" = 1, "onions" = 1, "garlic" = 1)
	foodtypes = MEAT
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/dofi_dore
	name = "dofi-dore"
	desc = "Minced Dofitis meat is packed into a small, seedy pastry and baked. The pastries tend to stay shelf stable for several days, but are best eaten warm."
	icon_state = "dofi-dore"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	bite_consumption = 3
	//filling_color = "#F0F0F0"
	tastes = list("seed flour" = 3, "hearty meat" = 6, "rich fat" = 1)
	food_flags = FOOD_FINGER_FOOD
	foodtypes = MEAT | GRAIN

/obj/item/food/timera
	name = "Timera-Fa"
	desc = "Tiris meat ground down, dried, and mixed with berries and fruits. The result is a long-lasting survival food."
	icon_state = "timera-fa"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/protein = 4,
	)
	bite_consumption = 2
	//filling_color = "#F0F0F0"
	tastes = list("crunchy berry bits" = 4, "dried meat" = 2,)
	foodtypes = MEAT | FRUIT

/obj/item/food/tiris_apple
	name = "tiris and apples"
	desc = "Tiris served with small slices of apple. An excellent appetizer for humans searching for an introduction to Tecetian food culture."
	icon_state = "tiris-apple"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/consumable/applejuice = 2,
	)
	bite_consumption = 3
	//filling_color = "#F0F0F0"
	tastes = list("crisp apple" = 4, "fatty meat" = 2)
	foodtypes = MEAT | FRUIT

/obj/item/food/dofi_tami
	name = "dofi-tami"
	desc = "Dofitis, when thinly sliced and dehydrated, becomes a charmingly savoury experience. Lower quality cuts of the meat are often turned into dofi-tami and sold off as a snack."
	icon_state = "dofi-tami"
	//filling_color = "#CD4122"
	food_flags = FOOD_FINGER_FOOD
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 1,
	)
	bite_consumption = 3
	tastes = list("hearty meat" = 4, "desert air" = 1, "rich fats" = 2)
	foodtypes = MEAT

/obj/item/food/stewedsoymeat
	name = "stewed soy meat"
	desc = "Heavily stewed firm tofu, meant to emulate braised beef."
	icon_state = "stewedsoymeat"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("soy" = 1, "vegetables" = 1)
	eatverbs = list("slurp", "sip", "inhale", "drink")
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/spiderleg
	name = "spider leg"
	desc = "A monstrously-sized leg of a giant arachnid. Their bizarre anatomy reveals smaller venom sacs stored in their muscle tissue - each twitch threatens you with its payload."
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "spiderleg"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 3,
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/toxin = 2,
	)
	tastes = list("venom-laden meat" = 1)
	foodtypes = MEAT | TOXIC
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/spiderleg/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/boiledspiderleg, rand(50 SECONDS, 60 SECONDS), TRUE, TRUE)

/obj/item/food/boiledspiderleg
	name = "boiled spider leg"
	desc = "A monstrously-sized leg from an immense spider, now rendered palatable after being boiled and steamed. The venom has neutralized into an intense spice, and the meat is not disimilar to crab." //Its cooked and not GORE, so it shouldnt imply that its gross to eat
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "spiderlegcooked"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/capsaicin = 4,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("hot peppers" = 1, "cobwebs" = 1)
	foodtypes = MEAT
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/spidereggsham
	name = "green eggs and ham"
	desc = "Food color-dyed fried eggs and ham. Would you eat them on Zohil? Would you eat them to have your fill? Would you eat it with a kepori? Would you eat it with just you and me?"
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "spidereggsham"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	bite_consumption = 4
	tastes = list("meat" = 1, "the colour green" = 1)
	foodtypes = MEAT | BREAKFAST
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/sashimi
	name = "carp sashimi"
	desc = "Carefully prepared, thinly cut space carp sashimi. Thanks to the preparation, the carpotoxin has denatured into an intensely pungent spice."
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "sashimi"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 10,
		/datum/reagent/consumable/capsaicin = 9,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("fish" = 1, "hot peppers" = 1)
	foodtypes = MEAT
	w_class = WEIGHT_CLASS_TINY

/obj/item/food/nugget
	name = "chicken nugget"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	icon = 'icons/obj/food/meat.dmi'
	tastes = list("\"chicken\"" = 1)
	foodtypes = MEAT
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_TINY

/obj/item/food/nugget/Initialize(mapload)
	. = ..()
	var/shape = pick("lump", "star", "lizard", "corgi")
	desc = "A 'chicken' nugget vaguely shaped like a [shape]."
	icon_state = "nugget_[shape]"

/obj/item/food/pigblanket
	name = "pig in a blanket"
	desc = "A small sausage wrapped in a buttery breadroll."
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "pigblanket"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("meat" = 1, "butter" = 1)
	foodtypes = MEAT | DAIRY | GRAIN
	w_class = WEIGHT_CLASS_TINY

/obj/item/food/bbqribs
	name = "bbq ribs"
	desc = "A rack of ribs slathered in a healthy coating of BBQ sauce before being braised."
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "ribs"
	w_class = WEIGHT_CLASS_NORMAL
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 10,
		/datum/reagent/consumable/nutriment/vitamin = 3,
		/datum/reagent/consumable/bbqsauce = 10,
	)
	tastes = list("meat" = 3, "smokey sauce" = 1)
	foodtypes = MEAT | SUGAR

/obj/item/food/meatclown
	name = "meat clown"
	desc = "A cylindrical slice of bologna, rendered into the expression of a clown. Its cheerful, meaty smile weakens you."
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "meatclown"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/consumable/banana = 2,
	)
	tastes = list("meat" = 5, "poor decisions" = 3, "discomfort" = 1)
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/miras_sososi
	name = "Miras Sososi"
	desc = "A cut of Miras, stretched out over a Sososi leaf and drizzled in Tiris-Sele."
	icon_state = "miras-sososi"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/nutriment/protein = 3,
		/datum/reagent/consumable/sugar = 1,
		/datum/reagent/consumable/tiris_sele = 1,
	)
	bite_consumption = 3
	tastes = list("sweet meat" = 6, "gentle umami" = 1, "gel" = 4, "satisfying crunch" = 2)
	foodtypes = MEAT | SUGAR | VEGETABLES

/obj/item/food/siti_miras
	name = "Siti-Miras"
	desc = "A cut of Miras cooked with a small bed of Siti and a dusting of dried Dote."
	icon_state = "siti-miras"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/sugar = 1,
	)
	bite_consumption = 3
	tastes = list("sweet meat" = 6, "dried berries" = 2, "satisfying crunch" = 4)
	foodtypes = MEAT | SUGAR | FRUIT

/obj/item/food/miras_li
	name = "Miras-Li"
	desc = "Miras cooked with slivers of seeded Refa-Li. It looks sweet and tastes spicy."
	icon_state = "miras-li"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/consumable/sugar = 1,
		/datum/reagent/consumable/vitfro = 2,
	)
	tastes = list("sweet meat" = 8, "pungent heat" = 4, "fruitness" = 1)
	foodtypes = MEAT | SUGAR | FRUIT

/obj/item/food/wine_remes
	name = "wine remes"
	desc = "The absorbent nature of a Remes snail was eagerly exploited by interstellar chefs, leading to the creation of this wine-soaked meat. Eating enough is said to leave a mild buzz."
	icon_state = "wine-remes"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/consumable/ethanol/wine = 10,
	)
	bite_consumption = 3
	tastes = list("earthiness" = 1, "wine-soaked flesh" = 4)
	foodtypes = MEAT | ALCOHOL

/obj/item/food/remes_li
	name = "remes-li"
	desc = "Remes soaked in Refa-Li juice. An extremely spicy experience for the daring."
	icon_state = "remes-li"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/consumable/refa_li = 10,
	)
	tastes = list("earthiness" = 2, "spice-soaked flesh" = 4, "burning sensation" = 1)
	foodtypes = MEAT | FRUIT

/obj/item/food/dofi_tese
	name = "Dofi-tese"
	desc = "A rich cut of Dofitis meat with a drizzle of a Tiris blood sauce"
	icon_state = "dofi-tese"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/consumable/tiris_sele = 4,
	)
	tastes = list("blossoming umami" = 1, "hearty grilled meat" = 6, "creamy fats" = 2)
	foodtypes = MEAT

/obj/item/food/sososi_dofi
	name = "sososi dofi"
	desc = "A prime cut of Dofitis served atop a seared Sososi leaf. The gel of the leaf tends to soak up the blood of the meat."
	icon_state = "sososi-dofi"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("bloody gel" = 2, "hearty grilled meat" = 6, "creamy fats" = 1, "crisp leafy crunch" = 4)
	foodtypes = MEAT | VEGETABLES

/obj/item/food/dofi_nari
	name = "dofi-nari"
	desc = "Ground down dofitis mixed together with herbs and spices, and then seared in a pan. Sometimes shaped into shapes to entertain guests. "
	icon_state = "dofi-nari"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("spiced meat" = 5, "hearty fats" = 2, "spice" = 1)
	foodtypes = MEAT | VEGETABLES

//Kebabs and Skewers

/obj/item/food/kebab
	trash_type = /obj/item/stack/rods
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "kebab"
	w_class = WEIGHT_CLASS_NORMAL
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 14,
	)
	tastes = list("meat" = 3, "metal" = 1)
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/kebab/monkey
	name = "meat-kebab"
	desc = "Chunks of meat that have been cooked and served on a skewer."
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 16,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("meat" = 3, "metal" = 1)
	foodtypes = MEAT

/obj/item/food/kebab/tofu
	name = "tofu-kebab"
	desc = "Chunks of firm, seasoned tofu that have been cooked and served on a skewer."
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 15,
	)
	tastes = list("tofu" = 3, "metal" = 1)
	foodtypes = VEGETABLES

/obj/item/food/kebab/tail
	name = "lizard-tail kebab"
	desc = "Severed lizard tail on a stick."
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 30,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("meat" = 8, "metal" = 4, "scales" = 1)
	foodtypes = MEAT

/obj/item/food/kebab/rat
	name = "rat-kebab"
	desc = "A body of a rat that has been cooked and served on a skewer. Not for the faint of heart."
	icon_state = "ratkebab"
	w_class = WEIGHT_CLASS_NORMAL
	trash_type = null
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 10,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("rat meat" = 1, "metal" = 1)
	foodtypes = MEAT | GORE

/obj/item/food/kebab/rat/double
	name = "double rat-kebab"
	icon_state = "doubleratkebab"
	tastes = list("rat meat" = 2, "metal" = 1)
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 20,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/iron = 2,
	)

/obj/item/food/kebab/fiesta
	name = "fiesta skewer"
	icon_state = "fiestaskewer"
	tastes = list("tex-mex" = 3, "cumin" = 2)
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 12,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/capsaicin = 3,
	)

/obj/item/food/kebab/miras
	name = "miras-kebab"
	desc = "An entire Miras, slightly cleaned up and roasted on a stick."
	icon_state = "roast-miras"
	w_class = WEIGHT_CLASS_NORMAL
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/sugar = 2,
	)
	tastes = list("seared meat" = 6, "sweetness" = 1)
	foodtypes = MEAT | SUGAR | GORE

/obj/item/food/kebab/fafe_skewer
	name = "faferiri skewer"
	desc = "Remes meat separates out Tiris, Sososi, and Refa-li on a skewer. The flavors mix together as the juices flow, creating a gooey mess with a hint of spice."
	icon_state = "dumb-fucking-kebab"
	w_class = WEIGHT_CLASS_NORMAL
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/consumable/refa_li = 2,
	)
	tastes = list("spicy fruit" = 3, "sweetness" = 1, "satisfying crunch" = 2, "earthiness" = 2, "savory goo" = 4)
	foodtypes = MEAT | FRUIT | VEGETABLES
