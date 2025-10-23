/obj/item/food/donkpocket/random
	name = "\improper Random Donk-pocket"
	icon_state = "donkpocket"
	desc = "The food of choice for the seasoned coder (if you see this, contact DonkCo. as soon as possible)."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
	)

/obj/item/food/donkpocket/random/Initialize()
	. = ..()
	var/list/donkblock = list(
		/obj/item/food/donkpocket/warm,
		/obj/item/food/donkpocket/warm/spicy,
		/obj/item/food/donkpocket/warm/teriyaki,
		/obj/item/food/donkpocket/warm/pizza,
		/obj/item/food/donkpocket/warm/berry,
	)

	var donk_type = pick(subtypesof(/obj/item/food/donkpocket) - donkblock)
	new donk_type(loc)
	return INITIALIZE_HINT_QDEL

/obj/item/food/donkpocket
	name = "donk-pocket"
	icon_state = "donkpocket"
	microwaved_type = /obj/item/food/donkpocket/warm
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 2,
	)
	tastes = list("meat" = 2, "dough" = 2, "laziness" = 1)
	foodtypes = GRAIN
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL

//donk pockets cook quick... try not to burn them using an unoptimal tool
/obj/item/food/donkpocket/make_bakeable()
	AddComponent(/datum/component/bakeable, microwaved_type, rand(25 SECONDS, 30 SECONDS), TRUE, TRUE)

/obj/item/food/donkpocket/warm
	name = "warm donk-pocket"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/medicine/panacea/effluvial = 6,
	)
	tastes = list("meat" = 2, "dough" = 2, "laziness" = 1)
	foodtypes = GRAIN
	microwaved_type = /obj/item/food/badrecipe

///Override for fast-burning food
/obj/item/food/donkpocket/warm/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/badrecipe, rand(10 SECONDS, 15 SECONDS), FALSE)

/obj/item/food/dankpocket
	name = "dank-pocket"
	icon_state = "dankpocket"
	food_reagents = list(
		/datum/reagent/toxin/lipolicide = 3,
		/datum/reagent/drug/space_drugs = 3,
		/datum/reagent/consumable/nutriment = 4,
	)
	tastes = list("meat" = 2, "dough" = 2)
	foodtypes = GRAIN | VEGETABLES

/obj/item/food/donkpocket/spicy
	name = "spicy-pocket"
	icon_state = "donkpocketspicy"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/capsaicin = 2,
	)
	tastes = list("meat" = 2, "dough" = 2, "spice" = 1)
	foodtypes = GRAIN
	microwaved_type = /obj/item/food/donkpocket/warm/spicy

/obj/item/food/donkpocket/warm/spicy
	name = "warm spicy-pocket"
	icon_state = "donkpocketspicy"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/medicine/panacea/effluvial = 2,
		/datum/reagent/consumable/capsaicin = 5,
	)
	tastes = list("meat" = 2, "dough" = 2, "weird spices" = 2)
	foodtypes = GRAIN

/obj/item/food/donkpocket/teriyaki
	name = "teriyaki-pocket"
	icon_state = "donkpocketteriyaki"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/soysauce = 2,
	)
	tastes = list("meat" = 2, "dough" = 2, "soy sauce" = 2)
	foodtypes = GRAIN
	microwaved_type = /obj/item/food/donkpocket/warm/teriyaki

/obj/item/food/donkpocket/warm/teriyaki
	name = "warm teriyaki-pocket"
	icon_state = "donkpocketteriyaki"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 3,
		/datum/reagent/medicine/panacea/effluvial = 2,
		/datum/reagent/consumable/soysauce = 2,
	)
	tastes = list("meat" = 2, "dough" = 2, "soy sauce" = 2)
	foodtypes = GRAIN

/obj/item/food/donkpocket/pizza
	name = "pizza-pocket"
	icon_state = "donkpocketpizza"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/tomatojuice = 2,
	)
	tastes = list("meat" = 2, "dough" = 2, "cheese"= 2)
	foodtypes = GRAIN
	microwaved_type = /obj/item/food/donkpocket/warm/pizza

/obj/item/food/donkpocket/warm/pizza
	name = "pizza-pocket"
	icon_state = "donkpocketpizza"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/medicine/panacea/effluvial = 2,
		/datum/reagent/consumable/tomatojuice = 2,
	)
	tastes = list("meat" = 2, "dough" = 2, "melty cheese"= 2)
	foodtypes = GRAIN

/obj/item/food/donkpocket/berry
	name = "berry-pocket"
	icon_state = "donkpocketberry"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/berryjuice = 3,
	)
	tastes = list("dough" = 2, "jam" = 2)
	foodtypes = GRAIN
	microwaved_type = /obj/item/food/donkpocket/warm/berry

/obj/item/food/donkpocket/warm/berry
	name = "warm berry-pocket"
	icon_state = "donkpocketberry"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/medicine/panacea/effluvial = 2,
		/datum/reagent/consumable/berryjuice = 3
	)
	tastes = list("dough" = 2, "warm jam" = 2)
	foodtypes = GRAIN
