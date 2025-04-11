/datum/crafting_recipe/food/candiedapple
	name = "Candied apple"
	reqs = list(
		/datum/reagent/consumable/caramel = 5,
		/obj/item/reagent_containers/food/snacks/grown/apple = 1
	)
	result = /obj/item/reagent_containers/food/snacks/candiedapple
	subcategory = CAT_CANDIED

/datum/crafting_recipe/food/spiderlollipop
	name = "Spider Lollipop"
	reqs = list(/obj/item/stack/rods = 1,
		/datum/reagent/consumable/sugar = 5,
		/datum/reagent/water = 5,
		/obj/item/reagent_containers/food/snacks/spiderling = 1
	)
	result = /obj/item/reagent_containers/food/snacks/spiderlollipop
	subcategory = CAT_CANDIED

/datum/crafting_recipe/food/chococoin
	name = "Choco coin"
	reqs = list(
		/obj/item/coin = 1,
		/obj/item/reagent_containers/food/snacks/chocolatebar = 1,
	)
	result = /obj/item/reagent_containers/food/snacks/chococoin
	subcategory = CAT_CANDIED

/datum/crafting_recipe/food/fudgedice
	name = "Fudge dice"
	reqs = list(
		/obj/item/dice = 1,
		/obj/item/reagent_containers/food/snacks/chocolatebar = 1,
	)
	result = /obj/item/reagent_containers/food/snacks/fudgedice
	subcategory = CAT_CANDIED

/datum/crafting_recipe/food/chocoorange
	name = "Choco orange"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/grown/citrus/orange = 1,
		/obj/item/reagent_containers/food/snacks/chocolatebar = 1,
	)
	result = /obj/item/reagent_containers/food/snacks/chocoorange
	subcategory = CAT_CANDIED
