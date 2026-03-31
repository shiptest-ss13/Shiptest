/obj/item/food/shoalpocket/random
	name = "\improper Random Shoalwich"
	icon_state = "shoalpocket"
	desc = "If you see this, you should contact a coder."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
	)

/obj/item/food/shoalpocket/random/Initialize()
	. = ..()
	var/list/shoalblock = list(
		/obj/item/food/shoalpocket/warm,
		/obj/item/food/shoalpocket/warm/spicy,
		/obj/item/food/shoalpocket/warm/teriyaki,
		/obj/item/food/shoalpocket/warm/pizza,
		/obj/item/food/shoalpocket/warm/berry,
	)

	var shoalpocket_type = pick(subtypesof(/obj/item/food/shoalpocket) - shoalblock)
	new shoalpocket_type(loc)
	return INITIALIZE_HINT_QDEL

/obj/item/food/shoalpocket
	name = "Shoalwich"
	icon_state = "shoalpocket"
	desc = "A single Shoalwich. It might taste better if you warm it up."
	microwaved_type = /obj/item/food/shoalpocket/warm
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 2,
	)
	tastes = list("meat" = 2, "artificial sweetener" = 2, "processed chemicals" = 1)
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL

//shoal pockets cook quick... try not to burn them using an unoptimal tool
/obj/item/food/shoalpocket/make_bakeable()
	AddComponent(/datum/component/bakeable, microwaved_type, rand(25 SECONDS, 30 SECONDS), TRUE, TRUE)

/obj/item/food/shoalpocket/warm
	name = "warm Shoalwich"
	icon_state = "shoalpocket"
	desc = "A single Shoalwich. Careful, it's hot."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/medicine/panacea/effluvial = 6,
	)
	tastes = list("meat" = 2, "artificial sweetener" = 2, "processed chemicals" = 1)
	microwaved_type = /obj/item/food/badrecipe

///Override for fast-burning food
/obj/item/food/shoalpocket/warm/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/badrecipe, rand(10 SECONDS, 15 SECONDS), FALSE)

/obj/item/food/shoalpocket/spicy
	name = "spicy-pocket"
	icon_state = "shoalpocketspicy"
	desc = "A single Shoalwich, with an alarming amount of added spice. It might taste better if you warm it up."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/capsaicin = 2,
	)
	tastes = list("hot spices" = 3, "meat" = 2, "processed chemicals" = 1)
	microwaved_type = /obj/item/food/shoalpocket/warm/spicy

/obj/item/food/shoalpocket/warm/spicy
	name = "warm spicy-pocket"
	icon_state = "shoalpocketspicy"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/medicine/panacea/effluvial = 2,
		/datum/reagent/consumable/capsaicin = 5,
	)
	tastes = list("hot spices" = 3, "meat" = 2, "processed chemicals" = 1)

/obj/item/food/shoalpocket/teriyaki
	name = "teriyaki-pocket"
	icon_state = "shoalpocketteriyaki"
	desc = "A single teriyaki-themed Shoalwich. It might taste better if you warm it up."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/soysauce = 2,
	)
	tastes = list("meat" = 2, "processed chemicals" = 2, "soy sauce" = 2)
	microwaved_type = /obj/item/food/shoalpocket/warm/teriyaki

/obj/item/food/shoalpocket/warm/teriyaki
	name = "warm teriyaki-pocket"
	icon_state = "shoalpocketteriyaki"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 3,
		/datum/reagent/medicine/panacea/effluvial = 2,
		/datum/reagent/consumable/soysauce = 2,
	)
	tastes = list("meat" = 2, "processed chemicals" = 2, "soy sauce" = 2)

/obj/item/food/shoalpocket/pizza
	name = "pizza-pocket"
	icon_state = "shoalpocketpizza"
	desc = "A single Shoalwich imitating a pizza. It might taste better if you warm it up."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/tomatojuice = 2,
	)
	tastes = list("meat" = 2, "a dough-like texture" = 2, "cheese"= 2)
	microwaved_type = /obj/item/food/shoalpocket/warm/pizza

/obj/item/food/shoalpocket/warm/pizza
	name = "pizza-pocket"
	icon_state = "shoalpocketpizza"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/medicine/panacea/effluvial = 2,
		/datum/reagent/consumable/tomatojuice = 2,
	)
	tastes = list("meat" = 2, "a dough-like texture" = 2, "melty cheese"= 2)

/obj/item/food/shoalpocket/berry
	name = "berry-pocket"
	icon_state = "shoalpocketberry"
	desc = "A berry-flavored Shoalwich. It might taste better if you warm it up."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/berryjuice = 3,
	)
	tastes = list("a dough-like texture" = 2, "jam" = 2)
	microwaved_type = /obj/item/food/shoalpocket/warm/berry

/obj/item/food/shoalpocket/warm/berry
	name = "warm berry-pocket"
	icon_state = "shoalpocketberry"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/medicine/panacea/effluvial = 2,
		/datum/reagent/consumable/berryjuice = 3
	)
	tastes = list("a dough-like texture" = 2, "warm jam" = 2)
