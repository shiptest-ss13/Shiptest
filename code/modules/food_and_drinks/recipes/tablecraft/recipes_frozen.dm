/////////////////
//Misc. Frozen.//
/////////////////

/datum/crafting_recipe/food/icecreamsandwich
	name = "Icecream sandwich"
	reqs = list(
		/datum/reagent/consumable/cream = 5,
		/datum/reagent/consumable/ice = 5,
		/obj/item/food/icecream = 1
	)
	result = /obj/item/food/icecreamsandwich
	subcategory = CAT_ICE

/datum/crafting_recipe/food/strawberryicecreamsandwich
	name = "Strawberry ice cream sandwich"
	reqs = list(
		/datum/reagent/consumable/cream = 5,
		/datum/reagent/consumable/ice = 5,
		/obj/item/food/grown/berries = 2,
	)
	result = /obj/item/food/strawberryicecreamsandwich
	subcategory = CAT_ICE

/datum/crafting_recipe/food/spacefreezy
	name ="Space freezy"
	reqs = list(
		/datum/reagent/consumable/bluecherryjelly = 5,
		/datum/reagent/consumable/comet_trail = 15,
		/obj/item/food/icecream = 1
	)
	result = /obj/item/food/spacefreezy
	subcategory = CAT_ICE

/datum/crafting_recipe/food/sundae
	name ="Sundae"
	reqs = list(
		/datum/reagent/consumable/cream = 5,
		/obj/item/food/grown/cherries = 1,
		/obj/item/food/grown/banana = 1,
		/obj/item/food/icecream = 1
	)
	result = /obj/item/food/sundae
	subcategory = CAT_ICE

/datum/crafting_recipe/food/cornuto
	name = "Cornuto"
	reqs = list(
		/obj/item/food/pastrybase = 1,
		/obj/item/food/chocolatebar = 1,
		/datum/reagent/consumable/cream = 4,
		/datum/reagent/consumable/ice = 2,
		/datum/reagent/consumable/sugar = 4
	)
	result = /obj/item/food/cornuto
	subcategory = CAT_ICE

/datum/crafting_recipe/food/miras_parfait
	name = "Miras Parfait"
	reqs = list(
		/obj/item/food/mirasegg = 1,
		/obj/item/food/grown/ash_flora/cactus_fruit = 1,
		/datum/reagent/consumable/cream = 4,
		/datum/reagent/consumable/sugar = 4
	)
	result = /obj/item/food/miras_parfait
	subcategory = CAT_ICE


//////////////////////////SNOW CONES///////////////////////

/datum/crafting_recipe/food/flavorless_sc
	name = "Flavorless snowcone"
	reqs = list(
		/obj/item/reagent_containers/food/drinks/sillycup = 1,
		/datum/reagent/consumable/ice = 15
	)
	result = /obj/item/food/snowcones
	subcategory = CAT_ICE

/datum/crafting_recipe/food/pineapple_sc
	name = "Pineapple snowcone"
	reqs = list(
		/obj/item/reagent_containers/food/drinks/sillycup = 1,
		/datum/reagent/consumable/ice = 15,
		/datum/reagent/consumable/pineapplejuice = 5
	)
	result = /obj/item/food/snowcones/pineapple
	subcategory = CAT_ICE

/datum/crafting_recipe/food/lime_sc
	name = "Lime snowcone"
	reqs = list(
		/obj/item/reagent_containers/food/drinks/sillycup = 1,
		/datum/reagent/consumable/ice = 15,
		/datum/reagent/consumable/limejuice = 5
	)
	result = /obj/item/food/snowcones/lime
	subcategory = CAT_ICE

/datum/crafting_recipe/food/lemon_sc
	name = "Lemon snowcone"
	reqs = list(
		/obj/item/reagent_containers/food/drinks/sillycup = 1,
		/datum/reagent/consumable/ice = 15,
		/datum/reagent/consumable/lemonjuice = 5
	)
	result = /obj/item/food/snowcones/lemon
	subcategory = CAT_ICE

/datum/crafting_recipe/food/apple_sc
	name = "Apple snowcone"
	reqs = list(
		/obj/item/reagent_containers/food/drinks/sillycup = 1,
		/datum/reagent/consumable/ice = 15,
		/datum/reagent/consumable/applejuice = 5
	)
	result = /obj/item/food/snowcones/apple
	subcategory = CAT_ICE

/datum/crafting_recipe/food/grape_sc
	name = "Grape snowcone"
	reqs = list(
		/obj/item/reagent_containers/food/drinks/sillycup = 1,
		/datum/reagent/consumable/ice = 15,
		/datum/reagent/consumable/grapejuice = 5
	)
	result = /obj/item/food/snowcones/grape
	subcategory = CAT_ICE

/datum/crafting_recipe/food/orange_sc
	name = "Orange snowcone"
	reqs = list(
		/obj/item/reagent_containers/food/drinks/sillycup = 1,
		/datum/reagent/consumable/ice = 15,
		/datum/reagent/consumable/orangejuice = 5
	)
	result = /obj/item/food/snowcones/orange
	subcategory = CAT_ICE

/datum/crafting_recipe/food/blue_sc
	name = "Bluecherry snowcone"
	reqs = list(
		/obj/item/reagent_containers/food/drinks/sillycup = 1,
		/datum/reagent/consumable/ice = 15,
		/datum/reagent/consumable/bluecherryjelly= 5
	)
	result = /obj/item/food/snowcones/blue
	subcategory = CAT_ICE

/datum/crafting_recipe/food/red_sc
	name = "Cherry snowcone"
	reqs = list(
		/obj/item/reagent_containers/food/drinks/sillycup = 1,
		/datum/reagent/consumable/ice = 15,
		/datum/reagent/consumable/cherryjelly= 5
	)
	result = /obj/item/food/snowcones/red
	subcategory = CAT_ICE

/datum/crafting_recipe/food/berry_sc
	name = "Berry snowcone"
	reqs = list(
		/obj/item/reagent_containers/food/drinks/sillycup = 1,
		/datum/reagent/consumable/ice = 15,
		/datum/reagent/consumable/berryjuice = 5
	)
	result = /obj/item/food/snowcones/berry
	subcategory = CAT_ICE

/datum/crafting_recipe/food/fruitsalad_sc
	name = "Fruit Salad snowcone"
	reqs = list(
		/obj/item/reagent_containers/food/drinks/sillycup = 1,
		/datum/reagent/water  = 5,
		/datum/reagent/consumable/ice = 15,
		/datum/reagent/consumable/orangejuice = 5,
		/datum/reagent/consumable/limejuice = 5,
		/datum/reagent/consumable/lemonjuice = 5
	)
	result = /obj/item/food/snowcones/fruitsalad
	subcategory = CAT_ICE

/datum/crafting_recipe/food/soda_sc
	name = "Master Cola snowcone"
	reqs = list(
		/obj/item/reagent_containers/food/drinks/sillycup = 1,
		/datum/reagent/consumable/ice = 15,
		/datum/reagent/consumable/space_cola = 5
	)
	result = /obj/item/food/snowcones/soda
	subcategory = CAT_ICE

/datum/crafting_recipe/food/spacemountainwind_sc
	name = "Comet Trail snowcone"
	reqs = list(
		/obj/item/reagent_containers/food/drinks/sillycup = 1,
		/datum/reagent/consumable/ice = 15,
		/datum/reagent/consumable/comet_trail = 5
	)
	result = /obj/item/food/snowcones/comettrail
	subcategory = CAT_ICE

/datum/crafting_recipe/food/pacfuel_sc
	name = "Pacfuel snowcone"
	reqs = list(
		/obj/item/reagent_containers/food/drinks/sillycup = 1,
		/datum/reagent/consumable/ice = 15,
		/datum/reagent/consumable/pacfuel = 15
	)
	result = /obj/item/food/snowcones/pacfuel
	subcategory = CAT_ICE

/datum/crafting_recipe/food/honey_sc
	name = "Honey snowcone"
	reqs = list(
		/obj/item/reagent_containers/food/drinks/sillycup = 1,
		/datum/reagent/consumable/ice = 15,
		/datum/reagent/consumable/honey = 5
	)
	result = /obj/item/food/snowcones/honey
	subcategory = CAT_ICE

/datum/crafting_recipe/food/rainbow_sc
	name = "Rainbow snowcone"
	reqs = list(
		/obj/item/reagent_containers/food/drinks/sillycup = 1,
		/datum/reagent/consumable/ice = 15,
		/datum/reagent/colorful_reagent = 1 //Harder to make
	)
	result = /obj/item/food/snowcones/rainbow
	subcategory = CAT_ICE

//////////////////////////POPSICLES///////////////////////

// This section includes any frozen treat served on a stick.
////////////////////////////////////////////////////////////

/datum/crafting_recipe/food/orange_popsicle
	name = "Orange popsicle"
	reqs = list(
		/obj/item/popsicle_stick = 1,
		/datum/reagent/consumable/orangejuice = 4,
		/datum/reagent/consumable/ice = 2,
		/datum/reagent/consumable/cream = 2,
		/datum/reagent/consumable/vanilla = 2,
		/datum/reagent/consumable/sugar = 2
	)
	result = /obj/item/food/popsicle/creamsicle_orange
	subcategory = CAT_ICE

/datum/crafting_recipe/food/berry_popsicle
	name = "Berry popsicle"
	reqs = list(
		/obj/item/popsicle_stick = 1,
		/datum/reagent/consumable/berryjuice = 4,
		/datum/reagent/consumable/ice = 2,
		/datum/reagent/consumable/cream = 2,
		/datum/reagent/consumable/vanilla = 2,
		/datum/reagent/consumable/sugar = 2
	)
	result = /obj/item/food/popsicle/creamsicle_berry
	subcategory = CAT_ICE

/datum/crafting_recipe/food/jumbo
	name = "Jumbo icecream"
	reqs = list(
		/obj/item/popsicle_stick = 1,
		/obj/item/food/chocolatebar = 1,
		/datum/reagent/consumable/ice = 2,
		/datum/reagent/consumable/cream = 2,
		/datum/reagent/consumable/vanilla = 3,
		/datum/reagent/consumable/sugar = 2
	)
	result = /obj/item/food/popsicle/jumbo
	subcategory = CAT_ICE

/datum/crafting_recipe/food/licorice
	name = "Licorice icecream"
	reqs = list(
		/obj/item/popsicle_stick = 1,
		/datum/reagent/consumable/blumpkinjuice = 4, //natural source of ammonium chloride
		/datum/reagent/consumable/sodiumchloride = 2,
		/datum/reagent/consumable/ice = 2,
		/datum/reagent/consumable/cream = 2,
		/datum/reagent/consumable/vanilla = 2,
		/datum/reagent/consumable/sugar = 2
	)
	result = /obj/item/food/popsicle/licorice
	subcategory = CAT_ICE
