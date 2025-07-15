//Misc

/datum/crafting_recipe/food/loadedbakedpotato
	name = "Loaded baked potato"
	time = 40
	reqs = list(
		/obj/item/food/grown/potato = 1,
		/obj/item/reagent_containers/food/snacks/cheesewedge = 1
	)
	result = /obj/item/reagent_containers/food/snacks/loadedbakedpotato
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/miras_potato
	name = "Miras loaded potato"
	reqs = list(
		/obj/item/food/meat/steak/miras = 1,
		/obj/item/food/grown/potato = 1,
		/obj/item/reagent_containers/food/snacks/cheesewedge = 1
	)
	result = /obj/item/food/miras_potato
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/cheesyfries
	name = "Cheesy fries"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/fries = 1,
		/obj/item/reagent_containers/food/snacks/cheesewedge = 1
	)
	result = /obj/item/reagent_containers/food/snacks/cheesyfries
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/beans
	name = "Beans"
	time = 40
	reqs = list(/datum/reagent/consumable/ketchup = 5,
		/obj/item/food/grown/soybeans = 2
	)
	result = /obj/item/reagent_containers/food/snacks/canned/beans
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/eggplantparm
	name ="Eggplant parmigiana"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/cheesewedge = 2,
		/obj/item/food/grown/eggplant = 1
	)
	result = /obj/item/reagent_containers/food/snacks/eggplantparm
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/melonfruitbowl
	name ="Melon fruit bowl"
	reqs = list(
		/obj/item/food/grown/watermelon = 1,
		/obj/item/food/grown/apple = 1,
		/obj/item/food/grown/citrus/orange = 1,
		/obj/item/food/grown/citrus/lemon = 1,
		/obj/item/food/grown/banana = 1,
		/obj/item/food/grown/ambrosia = 1
	)
	result = /obj/item/reagent_containers/food/snacks/melonfruitbowl
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/melonkeg
	name ="Melon keg"
	reqs = list(
		/datum/reagent/consumable/ethanol/vodka = 25,
		/obj/item/food/grown/holymelon = 1,
		/obj/item/reagent_containers/food/drinks/bottle/vodka = 1
	)
	parts = list(/obj/item/reagent_containers/food/drinks/bottle/vodka = 1)
	result = /obj/item/reagent_containers/food/snacks/melonkeg
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/branrequests
	name = "Bran Requests Cereal"
	reqs = list(
		/obj/item/food/grown/wheat = 1,
		/obj/item/reagent_containers/food/snacks/no_raisin = 1,
	)
	result = /obj/item/reagent_containers/food/snacks/branrequests
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/ricepudding
	name = "Rice pudding"
	reqs = list(
		/datum/reagent/consumable/milk = 5,
		/datum/reagent/consumable/sugar = 5,
		/obj/item/reagent_containers/food/snacks/salad/boiledrice = 1
	)
	result = /obj/item/reagent_containers/food/snacks/salad/ricepudding
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/poutine
	name = "Poutine"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/fries = 1,
		/obj/item/reagent_containers/food/snacks/cheesewedge = 1,
		/datum/reagent/consumable/gravy = 1
	)
	result = /obj/item/reagent_containers/food/snacks/customizable/poutine
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/vegetariansushiroll
	name = "Vegetarian sushi roll"
	reqs = list(
		/obj/item/food/grown/seaweed/sheet = 1,
		/obj/item/reagent_containers/food/snacks/salad/boiledrice = 1,
		/obj/item/food/grown/carrot = 1,
		/obj/item/food/grown/potato = 1
	)
	result = /obj/item/food/vegetariansushiroll
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/onigiri
	name = "Onigiri"
	reqs = list(
		/obj/item/food/grown/seaweed/sheet = 1,
		/obj/item/reagent_containers/food/snacks/salad/boiledrice = 1
	)
	result = /obj/item/food/onigiri
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/stuffed_refa
	name = "Stuffed refa"
	reqs = list(
		/obj/item/food/grown/refa_li = 1,
		/obj/item/food/tiris_cheese_slice = 1
	)
	result = /obj/item/food/stuffed_refa
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/tiris_fondue
	name = "Tiris fondue"
	reqs = list(
		/obj/item/food/grown/dotu_fime = 1,
		/obj/item/reagent_containers/food/snacks/store/tiris_cheese_wheel = 1
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
