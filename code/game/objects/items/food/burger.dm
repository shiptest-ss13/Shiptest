/obj/item/food/burger
	icon = 'icons/obj/food/burgerbread.dmi'
	icon_state = "hburger"
	bite_consumption = 3
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("bun" = 2, "beef patty" = 4)
	foodtypes = GRAIN | MEAT //lettuce doesn't make burger a vegetable.
	eat_time = 15 //Quick snack
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/burger/plain
	name = "burger"
	desc = "The cornerstone of every nutritious breakfast."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	foodtypes = GRAIN | MEAT

/obj/item/food/burger/corgi
	name = "corgi burger"
	desc = "You monster."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	foodtypes = GRAIN | MEAT | GORE

/obj/item/food/burger/appendix
	name = "appendix burger"
	desc = "Tastes like appendicitis."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 11,
		/datum/reagent/consumable/nutriment/vitamin = 7,
	)
	icon_state = "appendixburger"
	tastes = list("bun" = 4, "grass" = 2)
	foodtypes = GRAIN | MEAT | GORE

/obj/item/food/burger/fish
	name = "fillet -o- carp sandwich"
	desc = "Almost like a carp is yelling somewhere... Give me back that fillet -o- carp, give me that carp."
	icon_state = "fishburger"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 7,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("bun" = 4, "fish" = 4)
	foodtypes = GRAIN | MEAT

/obj/item/food/burger/tofu
	name = "tofu burger"
	desc = "What.. is that meat?"
	icon_state = "tofuburger"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("bun" = 4, "tofu" = 4)
	foodtypes = GRAIN | VEGETABLES

/obj/item/food/burger/roburger
	name = "roburger"
	desc = "The lettuce is the only organic component. Beep."
	icon_state = "roburger"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/nanomachines = 7,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("bun" = 4, "lettuce" = 2, "sludge" = 1)
	foodtypes = GRAIN | TOXIC

/obj/item/food/burger/roburgerbig
	name = "roburger"
	desc = "This massive patty looks like poison. Beep."
	icon_state = "roburger"
	max_volume = 120
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 11,
		/datum/reagent/nanomachines = 140,
		/datum/reagent/consumable/nutriment/vitamin = 15,
	)
	tastes = list("bun" = 4, "lettuce" = 2, "sludge" = 1)
	foodtypes = GRAIN | TOXIC

/obj/item/food/burger/xeno
	name = "xenoburger"
	desc = "Smells caustic. Tastes like heresy."
	icon_state = "xburger"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 9,
		/datum/reagent/consumable/nutriment/vitamin = 7,
	)
	tastes = list("bun" = 4, "acid" = 4)
	foodtypes = GRAIN | MEAT

/obj/item/food/burger/bearger
	name = "bearger"
	desc = "Best served rawr."
	icon_state = "bearger"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 7,
	)
	foodtypes = GRAIN | MEAT

/obj/item/food/burger/brain
	name = "brainburger"
	desc = "A strange looking burger. It looks almost sentient."
	icon_state = "brainburger"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 12,
		/datum/reagent/medicine/mannitol = 11,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("bun" = 4, "brains" = 2)
	foodtypes = GRAIN | MEAT | GORE

/obj/item/food/burger/bigbite
	name = "big bite burger"
	desc = "Forget the Big Mac. THIS is the future!"
	icon_state = "bigbiteburger"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 11,
		/datum/reagent/consumable/nutriment/vitamin = 7,
	)
	w_class = WEIGHT_CLASS_NORMAL
	foodtypes = GRAIN | MEAT | DAIRY

/obj/item/food/burger/jelly
	name = "jelly burger"
	desc = "Culinary delight..?"
	icon_state = "jellyburger"
	tastes = list("bun" = 4, "jelly" = 2)
	foodtypes = GRAIN | MEAT

/obj/item/food/burger/jelly/slime
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/toxin/slimejelly = 10,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	foodtypes = GRAIN | TOXIC

/obj/item/food/burger/jelly/cherry
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/cherryjelly = 10,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	foodtypes = GRAIN | FRUIT

/obj/item/food/burger/superbite
	name = "super bite burger"
	desc = "This is a mountain of a burger. FOOD!"
	icon_state = "superbiteburger"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 25,
		/datum/reagent/consumable/nutriment/protein = 42,
		/datum/reagent/consumable/nutriment/vitamin = 15,
	)
	w_class = WEIGHT_CLASS_NORMAL
	bite_consumption = 7
	max_volume = 100
	tastes = list("bun" = 4, "type two diabetes" = 10)
	foodtypes = GRAIN | MEAT | DAIRY

/obj/item/food/burger/fivealarm
	name = "five alarm burger"
	desc = "HOT! HOT!"
	icon_state = "fivealarmburger"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 7,
		/datum/reagent/consumable/capsaicin = 5,
		/datum/reagent/consumable/condensedcapsaicin = 5,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	foodtypes = GRAIN | MEAT

/obj/item/food/burger/rat
	name = "rat burger"
	desc = "Pretty much what you'd expect..."
	icon_state = "ratburger"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 7,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	foodtypes = GRAIN | MEAT | GORE

/obj/item/food/burger/baseball
	name = "home run baseball burger"
	desc = "It's still warm. The steam coming off of it looks like baseball."
	icon_state = "baseball"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	foodtypes = GRAIN | GROSS

/obj/item/food/burger/baconburger
	name = "bacon burger"
	desc = "The perfect combination of all things American."
	icon_state = "baconburger"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 11,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("bacon" = 4, "bun" = 2)
	foodtypes = GRAIN | MEAT

/obj/item/food/burger/empoweredburger
	name = "empowered burger"
	desc = "It's shockingly good, if you live off of electricity that is."
	icon_state = "empoweredburger"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/consumable/liquidelectricity = 5,
	)
	tastes = list("bun" = 2, "pure electricity" = 4)
	foodtypes = GRAIN | TOXIC

/obj/item/food/burger/crab
	name = "crab burger"
	desc = "A delicious patty of the crabby kind, slapped in between a bun."
	icon_state = "crabburger"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 7,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("bun" = 2, "crab meat" = 4)
	foodtypes = GRAIN | MEAT

/obj/item/food/burger/soylent
	name = "soylent burger"
	desc = "An eco-friendly burger made using upcycled low value biomass."
	icon_state = "soylentburger"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 9,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("bun" = 2, "assistant" = 4)
	foodtypes = GRAIN | MEAT | DAIRY

/obj/item/food/burger/rib
	name = "mcrib"
	desc = "An elusive rib shaped burger with limited availablity across the galaxy. Not as good as you remember it."
	icon_state = "mcrib"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 7,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/bbqsauce = 1
	)
	tastes = list("bun" = 2, "pork patty" = 4)
	foodtypes = GRAIN | MEAT

/obj/item/food/burger/mcguffin
	name = "mcguffin"
	desc = "A cheap and greasy imitation of an eggs benedict."
	icon_state = "mcguffin"
	tastes = list("muffin" = 2, "bacon" = 3)
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/eggyolk = 3,
		/datum/reagent/consumable/nutriment/protein = 7,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	foodtypes = GRAIN | MEAT | BREAKFAST

/obj/item/food/burger/chicken
	name = "chicken sandwich" //Apparently the proud people of Americlapstan object to this thing being called a burger. Apparently McDonald's just calls it a burger in Europe as to not scare and confuse us.
	desc = "The so-called classic poultry bread cage. Considering how processed this is, the taste holds up pretty well."
	icon_state = "chickenburger"
	tastes = list("bun" = 2, "chicken" = 4)
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/mayonnaise = 3,
		/datum/reagent/consumable/nutriment/protein = 7,
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/consumable/cooking_oil = 2,
	)
	foodtypes = GRAIN | MEAT | FRIED

/obj/item/food/burger/cheese
	name = "cheese burger"
	desc = "This noble burger stands proudly clad in golden cheese."
	icon_state = "cheeseburger"
	tastes = list("bun" = 2, "beef patty" = 4, "cheese" = 3)
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 7,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	foodtypes = GRAIN | MEAT | DAIRY

/obj/item/food/burger/cheese/Initialize(mapload)
	. = ..()
	if(prob(33))
		icon_state = "cheeseburgeralt"

/obj/item/food/burger/tiris
	name = "tiris burger"
	desc = "A traditional human burger made with Tecetian Tiris, topped with Tiris Cheese, and with a leaf of siti between the bread for an added crunch. Some prefer to forgo the bread for more Siti."
	icon_state = "tiris-burger"
	tastes = list("bun" = 2, "fatty meat" = 4, "rich cheese" = 3, "crisp vegetable leaf" = 1)
	foodtypes = GRAIN | MEAT | DAIRY | VEGETABLES

// empty burger you can customize
/obj/item/food/burger/empty
	name = "burger"
	desc = "A burger of sorts."
	icon_state = "custburg"
	tastes = list("bun")
	foodtypes = GRAIN
