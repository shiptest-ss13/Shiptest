//Not only meat, actually, but also snacks that are almost meat, such as fish meat or tofu

/obj/item/food/cubancarp
	name = "\improper Cuban carp"
	desc = "A sandwich consisting of heavily spiced and batter-fried fish. It's very hot!"
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "cubancarp"
	bite_consumption = 3
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/capsaicin = 1,
		/datum/reagent/consumable/nutriment/vitamin = 4
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
		/datum/reagent/consumable/nutriment/vitamin = 2
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
		/datum/reagent/toxin/mindbreaker = 2
	)

/obj/item/food/fishmeat/armorfish
	name = "cleaned armorfish"
	desc = "An armorfish with its guts and shell removed, ready for use in cooking."
	icon_state = "armorfish_fillet"
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 3)

/obj/item/food/fishmeat/donkfish
	name = "donkfillet"
	desc = "The dreaded donkfish fillet. No sane spaceman would eat this, and it does not get better when cooked."
	icon_state = "donkfillet"
	food_reagents = list(/datum/reagent/yuck = 3)

/obj/item/food/fishmeat/carp
	name = "carp fillet"
	desc = "A fillet of spess carp meat."
	food_reagents = list(
	/datum/reagent/consumable/nutriment/protein = 4,
	/datum/reagent/toxin/carpotoxin = 2,
	/datum/reagent/consumable/nutriment/vitamin = 2
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
		/datum/reagent/consumable/nutriment/vitamin = 2
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
		/datum/reagent/consumable/nutriment/vitamin = 2
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
		/datum/reagent/consumable/nutriment/vitamin = 2
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
	/datum/reagent/consumable/nutriment/vitamin = 3
	)
	tastes = list("fish" = 1, "pan seared vegtables" = 1)
	foodtypes = VEGETABLES | FRIED // | SEAFOOD //not sure why SEAFOOD's dead. oh well
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/vegetariansushiroll
	name = "vegetarian sushi roll"
	desc = "A sushi roll consisting of rice, carrots, and potatoes wrapped in seaweed. A techncial sibling to the \"california\" roll, but the origins of the name are unknown. Can be sliced into individual servings."
	icon_state = "vegan-sushi-roll"
	food_reagents = list(
	/datum/reagent/consumable/nutriment = 12,
	/datum/reagent/consumable/nutriment/vitamin = 4)
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
	/datum/reagent/consumable/nutriment/vitamin = 1
	)
	tastes = list("boiled rice" = 4, "carrots" = 2, "potato" = 2)
	foodtypes = VEGETABLES

/obj/item/food/spicyfiletsushiroll
	name = "spicy filet sushi roll"
	desc = "A makizushi roll containing spicy, raw fish wrapped with rice and other vegetables. can be sliced into individual servings."
	icon_state = "spicy-sushi-roll"
	food_reagents = list(
	/datum/reagent/consumable/nutriment = 12,
	/datum/reagent/consumable/nutriment/vitamin = 4
	)
	tastes = list("boiled rice" = 4, "fish" = 2, "spicyness" = 2)
	foodtypes = VEGETABLES | MEAT

/obj/item/food/vegetariansushiroll/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/spicyfiletsushislice, 4, 30, table_required = TRUE)

/obj/item/food/spicyfiletsushislice
	name = "spicy filet sushi slice"
	desc = "A slice of a makizushi roll containing spicy, raw fish wrapped with rice and other vegetables."
	icon_state = "spicy-sushi-slice"
	food_reagents = list(
	/datum/reagent/consumable/nutriment = 3,
	/datum/reagent/consumable/nutriment/vitamin = 1
	)
	tastes = list("boiled rice" = 4, "fish" = 2, "spicyness" = 2)
	foodtypes = VEGETABLES | MEAT

/obj/item/food/onigiri
	name = "onigiri"
	desc = "A specially-shaped rice ball shaped around a filling, wrapped in seaweed. This one seems to lack a filling entirely..."
	icon_state = "onigiri"
	food_reagents = list(
	/datum/reagent/consumable/nutriment = 3,
	/datum/reagent/consumable/nutriment/vitamin = 1
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
	/datum/reagent/toxin/carpotoxin = 8
	)
	tastes = list("raw fish" = 6, "dried seaweed" = 3)
	foodtypes = VEGETABLES | MEAT

/obj/item/food/nigiri_sushi
	name = "nigiri sushi"
	desc = "A form of sushi, consisting of a hand-shaped rice mound with a topping of choice bound to it with seaweed. This one appears to have a topping of raw fish."
	icon_state = "nigiri_sushi"
	food_reagents = list(
	/datum/reagent/consumable/nutriment = 10,
	/datum/reagent/consumable/nutriment/vitamin = 6
	)
	tastes = list("boiled rice" = 2, "fish filet" = 2, "soy sauce" = 2, "dried seaweed" = 1)
	foodtypes = VEGETABLES | MEAT

/*
/obj/item/food/fishtaco
	name = "fish taco"
	desc = "A taco with fish, cheese, and cabbage."
	icon_state = "fishtaco"
	food_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/nutriment/protein = 3, /datum/reagent/consumable/nutriment/vitamin = 2)
	tastes = list("taco" = 4, "fish" = 2, "cheese" = 2, "cabbage" = 1)
	foodtypes = SEAFOOD | DAIRY | GRAIN | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
*/

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
		/datum/reagent/consumable/nutriment/vitamin = 4
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
		/datum/reagent/consumable/ethanol/manly_dorf = 5
	)
	tastes = list("meat" = 1, "salmon" = 1)
	foodtypes = MEAT | ALCOHOL
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/meatball
	name = "meatball"
	desc = "Ground meat shaped into small balls, popularly eaten in sandwiches and alongside pasta."
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "meatball"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/nutriment = 3,
	)
	tastes = list("meat" = 1)
	foodtypes = MEAT
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/sausage
	name = "sausage"
	desc = "A serving of sausage, created by grinding meat and storing it in lengths of sausage casing."
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "sausage"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 2
	)
	tastes = list("meat" = 1)
	foodtypes = MEAT | BREAKFAST
	food_flags = FOOD_FINGER_FOOD
	eatverbs = list("bite", "chew", "nibble", "deep throat", "gobble", "chomp")
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
		/datum/reagent/consumable/nutriment/protein = 1
	)
	tastes = list("meat" = 1, "smoke" = 1)
	foodtypes = MEAT
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/rawkhinkali
	name = "raw khinkali"
	desc = "One of the many Solarian dumplings. This one is in the shape of a twisted knob, filled with meat, vegetables, and garlic. This one needs to be boiled."
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "khinkali"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/nutriment/protein = 1,
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/consumable/garlic = 1
	)
	tastes = list("meat" = 1, "onions" = 1, "garlic" = 1)
	foodtypes = MEAT | RAW
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/khinkali
	name = "khinkali"
	desc = "One of the many Solarian dumplings. This one is in the shape of a twisted knob, filled with meat, vegetables, and garlic."
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "khinkali"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/nutriment/protein = 1,
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/consumable/garlic = 1
	)
	bite_consumption = 3
	tastes = list("meat" = 1, "onions" = 1, "garlic" = 1)
	foodtypes = MEAT
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/stewedsoymeat
	name = "stewed soy meat"
	desc = "Heavily stewed firm tofu, meant to emulate braised beef."
	icon_state = "stewedsoymeat"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2
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
		/datum/reagent/toxin = 2
	)
	tastes = list("venom-laden meat" = 1)
	foodtypes = MEAT | TOXIC
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/boiledspiderleg
	name = "boiled spider leg"
	desc = "A monstrously-sized leg from an immense spider, now rendered palatable after being boiled and steamed. The venom has neutralized into an intense spice, and the meat is not disimilar to crab." //Its cooked and not GORE, so it shouldnt imply that its gross to eat
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "spiderlegcooked"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/capsaicin = 4,
		/datum/reagent/consumable/nutriment/vitamin = 2
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
		/datum/reagent/consumable/nutriment/vitamin = 3
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
		/datum/reagent/consumable/nutriment/vitamin = 4
	)
	tastes = list("fish" = 1, "hot peppers" = 1)
	foodtypes = MEAT
	w_class = WEIGHT_CLASS_TINY

/obj/item/food/nugget
	name = "chicken nugget"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/nutriment/vitamin = 1
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
		/datum/reagent/consumable/nutriment/vitamin = 2
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
		/datum/reagent/consumable/bbqsauce = 10
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
		/datum/reagent/consumable/banana = 2
	)
	tastes = list("meat" = 5, "poor decisions" = 3, "discomfort" = 1)
	w_class = WEIGHT_CLASS_SMALL

//Kebabs and Skewers

/obj/item/food/kebab
	trash_type = /obj/item/stack/rods
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "kebab"
	w_class = WEIGHT_CLASS_NORMAL
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 14
	)
	tastes = list("meat" = 3, "metal" = 1)
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/kebab/monkey
	name = "meat-kebab"
	desc = "Chunks of meat that have been cooked and served on a skewer."
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 16,
		/datum/reagent/consumable/nutriment/vitamin = 2
	)
	tastes = list("meat" = 3, "metal" = 1)
	foodtypes = MEAT

/obj/item/food/kebab/tofu
	name = "tofu-kebab"
	desc = "Chunks of firm, seasoned tofu that have been cooked and served on a skewer."
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 15)
	tastes = list("tofu" = 3, "metal" = 1)
	foodtypes = VEGETABLES

/obj/item/food/kebab/tail
	name = "lizard-tail kebab"
	desc = "Severed lizard tail on a stick."
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 30,
		/datum/reagent/consumable/nutriment/vitamin = 4
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
		/datum/reagent/consumable/nutriment/vitamin = 2
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
		/datum/reagent/iron = 2
	)

/obj/item/food/kebab/fiesta
	name = "fiesta skewer"
	icon_state = "fiestaskewer"
	tastes = list("tex-mex" = 3, "cumin" = 2)
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 12,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/capsaicin = 3
	)
