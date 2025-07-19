//Other
/obj/item/food/watermelonslice
	name = "watermelon slice"
	desc = "A water-rich slice of watermelon. Little black seeds decorate the wedge."
	icon_state = "watermelonslice"
	food_reagents = list(
		/datum/reagent/water = 1,
		/datum/reagent/consumable/nutriment/vitamin = 0.2,
		/datum/reagent/consumable/nutriment = 1,
	)
	tastes = list("watermelon" = 1)
	foodtypes = FRUIT
	food_flags = FOOD_FINGER_FOOD
	juice_results = list(/datum/reagent/consumable/watermelonjuice = 5)
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/hugemushroomslice
	name = "huge mushroom slice"
	desc = "An immense slice of a mushroom's fruiting body. The gills on the underside have since been flattened."
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "hugemushroomslice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("mushroom" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/popcorn
	name = "popcorn"
	desc = "A bag of popped corn kernels, traditionally topped with butter and other seasonings. Typically eaten while watching something, due to its ability to last for some time as an idle finger-food."
	icon_state = "popcorn"
	trash_type = /obj/item/trash/popcorn
	food_reagents = list(/datum/reagent/consumable/nutriment = 2)
	bite_consumption = 0.1 //this snack is supposed to be eating during looooong time. And this it not dinner food! --rastaf0
	tastes = list("popcorn" = 3, "butter" = 1)
	foodtypes = JUNKFOOD
	eatverbs = list("bite", "nibble", "gnaw", "gobble", "chomp")
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/soydope
	name = "soy dope"
	desc = "Prepared soybeans, or a \"dope\", used for a variety of vegetarian recipes."
	icon_state = "soydope"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/nutriment/protein = 1,
	)
	tastes = list("soy" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/badrecipe
	name = "burned mess"
	desc = "A mass of semi-carbonized matter. The idea of eating this only makes you realize the desperation in the act."
	icon_state = "badrecipe"
	food_reagents = list(/datum/reagent/toxin/bad_food = 30)
	foodtypes = GROSS
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/badrecipe/Initialize()
	. = ..()
	RegisterSignal(src, COMSIG_ITEM_GRILLED,  PROC_REF(OnGrill))

///Prevents grilling burnt shit from well, burning.
/obj/item/food/badrecipe/proc/OnGrill()
	return COMPONENT_HANDLED_GRILLING

/obj/item/food/badrecipe/burn()
	if(QDELETED(src))
		return
	var/turf/T = get_turf(src)
	var/obj/effect/decal/cleanable/ash/A = new /obj/effect/decal/cleanable/ash(T)
	A.desc += "\nLooks like this used to be \an [name] some time ago."
	if(resistance_flags & ON_FIRE)
		SSfire_burning.processing -= src
	qdel(src)

// We override the parent procs here to prevent burned messes from cooking into burned messes.
/obj/item/food/badrecipe/make_grillable()
	return

/obj/item/food/spidereggs
	name = "spider eggs"
	desc = "A cluster of immense, translucent eggs. The spawn inside quicken to life at being disturbed..."
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "spidereggs"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/toxin = 2,
	)
	tastes = list("cobwebs" = 1)
	foodtypes = MEAT | TOXIC// | BUGS
	w_class = WEIGHT_CLASS_TINY

/obj/item/food/spiderling
	name = "spiderling"
	desc = "Seemingly a small spider, this is actually a nymph of the much larger giant arachnid."
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "spiderling"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/toxin = 4,
	)
	tastes = list("cobwebs" = 1, "guts" = 2)
	foodtypes = MEAT | TOXIC// | BUGS
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/melonfruitbowl
	name = "melon fruit bowl"
	desc = "For people who wants edible fruit bowls."
	icon_state = "melonfruitbowl"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	w_class = WEIGHT_CLASS_NORMAL
	tastes = list("melon" = 1)
	foodtypes = FRUIT
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/melonkeg
	name = "melon keg"
	desc = "A form of heavily genetically modified watermelon, which functions as a vessel for grain alcohol to ferment inside."
	icon_state = "melonkeg"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 9,
		/datum/reagent/consumable/ethanol/vodka = 15,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	max_volume = 80
	bite_consumption = 5
	tastes = list("grain alcohol" = 1, "fruit" = 1)
	foodtypes = FRUIT | ALCOHOL

/obj/item/food/honeybar
	name = "honey nut bar"
	desc = "Oats and nuts compressed together into a bar, held together with a honey glaze."
	icon_state = "honeybar"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/honey = 5,
	)
	tastes = list("oats" = 3, "nuts" = 2, "honey" = 1)
	foodtypes = GRAIN | SUGAR
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/branrequests
	name = "Bran Requests Cereal"
	desc = "A dry cereal that satiates your requests for bran. Tastes uniquely like raisins and salt."
	icon_state = "bran_requests"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/consumable/sodiumchloride = 8,
	)
	tastes = list("bran" = 4, "raisins" = 3, "salt" = 1)
	foodtypes = GRAIN | FRUIT | BREAKFAST
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/butter
	name = "stick of butter"
	desc = "A stick of delicious, golden, fatty goodness."
	icon_state = "butter"
	food_reagents = list(/datum/reagent/consumable/nutriment = 5)
	tastes = list("butter" = 1)
	foodtypes = DAIRY
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/butter/examine(mob/user)
	. = ..()
	. += span_notice("If you had a rod you could make <b>butter on a stick</b>.")

/obj/item/food/butter/attackby(obj/item/item, mob/user, params)
	if(istype(item, /obj/item/stack/rods))
		var/obj/item/stack/rods/rods = item
		if(!rods.use(1))//borgs can still fail this if they have no metal
			to_chat(user, span_warning("You do not have enough metal to put [src] on a stick!"))
			return ..()
		to_chat(user, span_notice("You stick the rod into the stick of butter."))
		var/obj/item/food/butter/on_a_stick/new_item = new(usr.loc)
		var/replace = (user.get_inactive_held_item() == rods)
		if(!rods && replace)
			user.put_in_hands(new_item)
		qdel(src)
		return TRUE
	..()

/obj/item/food/butter/on_a_stick //there's something so special about putting it on a stick.
	name = "butter on a stick"
	desc = "delicious, golden, fatty goodness on a stick."
	icon_state = "butteronastick"
	trash_type = /obj/item/stack/rods
	food_flags = FOOD_FINGER_FOOD

/obj/item/food/onionrings
	name = "onion rings"
	desc = "Onion slices coated in batter."
	icon_state = "onionrings"
	food_reagents = list(/datum/reagent/consumable/nutriment = 3)
	gender = PLURAL
	tastes = list("batter" = 3, "onion" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/pineappleslice
	name = "pineapple slice"
	desc = "A sliced piece of juicy pineapple."
	icon_state = "pineapple_slice"
	juice_results = list(/datum/reagent/consumable/pineapplejuice = 3)
	tastes = list("pineapple" = 1)
	foodtypes = FRUIT | PINEAPPLE
	w_class = WEIGHT_CLASS_TINY

/obj/item/food/crab_rangoon
	name = "Crab Rangoon"
	desc = "A form of fried dumpling, consisting of crab meat and cream cheese in a wonton wrapper."
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "crabrangoon"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/nutriment/protein = 7,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	w_class = WEIGHT_CLASS_SMALL
	tastes = list("cream cheese" = 4, "crab" = 3, "crispiness" = 2)
	foodtypes = MEAT | DAIRY | GRAIN

/obj/item/food/cornchips
	name = "boritos corn chips"
	desc = "Triangular corn chips. They do seem a bit bland but would probably go well with some kind of dipping sauce."
	icon_state = "boritos"
	trash_type = /obj/item/trash/boritos
	bite_consumption = 2
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/cooking_oil = 2,
		/datum/reagent/consumable/sodiumchloride = 3
	)
	junkiness = 20
	tastes = list("fried corn" = 1)
	foodtypes = JUNKFOOD | FRIED

//todo: sort these into correct files
/obj/item/food/stuffed_refa
	name = "Stuffed Refa"
	desc = "Tiris cheese is removed from its crust and added to the fruits of a Refa-Li plant before being baked"
	icon_state = "stuff-refa"
	bite_consumption = 2
	food_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/nutriment/vitamin = 1)
	//filling_color = "#ECA735"
	tastes = list("hint of spice" = 1, "subtle fruitiness" = 1, "rich cheese" = 2)
	foodtypes = FRUIT | DAIRY

/obj/item/food/tiris_fondue
	name = "Fondue Tiris-Dotu"
	desc = "Fusion cuisine originating from travelling Solarians. This fondue is made of Tiris Cheese, and filled with small cubes of Dotu-Fime fruit. The flavor profile is reputed to be incredibly rich, especially with crackers."
	icon_state = "tiris-fondue"
	bite_consumption = 1
	food_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/nutriment/vitamin = 2, /datum/reagent/consumable/dotu_juice = 2)
	//filling_color = "#ECA735"
	tastes = list("hint of spice" = 1, "subtle fruitiness" = 1, "rich cheese" = 2)
	foodtypes = FRUIT | DAIRY

/obj/item/food/remes_roe
	name = "remes roe"
	desc = "The roe of a Remes is a topping that rose to prominence due to its serving during talks with Zohilese diplomats. The slight <i>pop</i> of the eggs was hailed as incredibly satisfying."
	icon_state = "remes-roe"
	bite_consumption = 1
	food_reagents = list(/datum/reagent/consumable/nutriment = 4)
	//filling_color = "#ECA735"
	tastes = list("condensed salt" = 1, "satisfying pop" = 2)
	foodtypes = MEAT

/obj/item/food/fara_reti
	name = "fara-reti"
	desc = "The flesh of a fara-li fruit, once all the seeds have been removed, is quite mellow. Adding Remes roe into the flesh creates an experience filled with salty pops."
	icon_state = "stuff-refa"
	food_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/nutriment/vitamin = 2,)
	//filling_color = "#ECA735"
	tastes = list("condensed salt" = 1, "satisfying pop" = 1, "mellow fruitflesh" = 3)
	foodtypes = MEAT | FRUIT

/obj/item/food/roe_tiris
	name = "reti-tiris"
	desc = "Remes roe and Tiris plasma mixed together into a thick drink. Acquired taste is the nicest that can be said of it."
	icon_state = "sludge"
	food_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/nutriment/vitamin = 2,)
	//filling_color = "#ECA735"
	tastes = list("blood and salt" = 3, "umami" = 1, "subdued pops" = 1)
	foodtypes = MEAT | GROSS | GORE

/obj/item/food/mirasegg
	name = "miras eggs"
	desc = "The eggs of a Miras Lizard are typically extracted from their nest. The individual eggs are small and unfertilized, unless the Miras has mated recently."
	icon_state = "miras-egg"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/eggyolk = 2,
	)
	tastes = list("egg" = 1, "hints of spice" = 1)
	foodtypes = MEAT | RAW
