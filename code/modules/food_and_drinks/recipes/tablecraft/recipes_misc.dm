//Misc

/datum/crafting_recipe/food/loadedbakedpotato
	name = "Loaded baked potato"
	time = 40
	reqs = list(
		/obj/item/food/grown/potato = 1,
		/obj/item/food/cheese/wedge = 1
	)
	result = /obj/item/food/loaded_baked_potato
	category = CAT_MISCFOOD

/datum/crafting_recipe/food/miras_potato
	name = "Miras loaded potato"
	reqs = list(
		/obj/item/food/meat/steak/miras = 1,
		/obj/item/food/grown/potato = 1,
		/obj/item/food/cheese/wedge = 1
	)
	result = /obj/item/food/loaded_miras_potato
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/cheesyfries
	name = "Cheesy fries"
	reqs = list(
		/obj/item/food/fries = 1,
		/obj/item/food/cheese/wedge = 1
	)
	result = /obj/item/food/cheesyfries
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/beans
	name = "Beans"
	time = 40
	reqs = list(
		/datum/reagent/consumable/ketchup = 5,
		/obj/item/food/grown/soybeans = 2
	)
	result = /obj/item/food/canned/beans
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/eggplantparm
	name ="Eggplant parmigiana"
	reqs = list(
		/obj/item/food/cheese/wedge = 2,
		/obj/item/food/grown/eggplant = 1
	)
	result = /obj/item/food/eggplantparm
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/melonkeg
	name ="Melon keg"
	reqs = list(
		/datum/reagent/consumable/ethanol/vodka = 25,
		/obj/item/food/grown/holymelon = 1,
		/obj/item/reagent_containers/food/drinks/bottle/vodka = 1
	)
	parts = list(/obj/item/reagent_containers/food/drinks/bottle/vodka = 1)
	result = /obj/item/food/melonkeg
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/branrequests
	name = "Bran Requests Cereal"
	reqs = list(
		/obj/item/food/grown/wheat = 1,
		/obj/item/food/no_raisin = 1,
	)
	result = /obj/item/food/branrequests
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/ricepudding
	name = "Rice pudding"
	reqs = list(
		/datum/reagent/consumable/milk = 5,
		/datum/reagent/consumable/sugar = 5,
		/obj/item/food/boiled_rice = 1
	)
	result = /obj/item/food/salad/ricepudding
	subcategory = CAT_MISCFOOD

// /datum/crafting_recipe/food/poutine
// 	name = "Poutine"
// 	reqs = list(
// 		/obj/item/food/fries = 1,
// 		/obj/item/food/cheese/wedge = 1,
// 		/datum/reagent/consumable/gravy = 1
// 	)
// 	result = /obj/item/food/customizable/poutine
// 	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/vegetariansushiroll
	name = "Vegetarian sushi roll"
	reqs = list(
		/obj/item/food/grown/seaweed/sheet = 1,
		/obj/item/food/boiled_rice = 1,
		/obj/item/food/grown/carrot = 1,
		/obj/item/food/grown/potato = 1
	)
	result = /obj/item/food/vegetariansushiroll
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/onigiri
	name = "Onigiri"
	reqs = list(
		/obj/item/food/grown/seaweed/sheet = 1,
		/obj/item/food/boiled_rice = 1
	)
	result = /obj/item/food/onigiri
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/stuffed_refa
	name = "Stuffed refa"
	reqs = list(
		/obj/item/food/grown/refa_li = 1,
		/obj/item/food/cheese/wedge/tiris = 1
	)
	result = /obj/item/food/stuffed_refa
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/tiris_fondue
	name = "Tiris fondue"
	reqs = list(
		/obj/item/food/grown/dotu_fime = 1,
		/obj/item/food/cheese/wheel/tiris = 1
	)
	result = /obj/item/food/tiris_fondue
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/roe_tiris
	name = "reti-tiris"
	reqs = list(
		/obj/item/food/remes_roe = 1,
		/datum/reagent/consumable/tiris_sale = 5
	)
	result = /obj/item/food/roe_tiris
	subcategory = CAT_MISCFOOD
