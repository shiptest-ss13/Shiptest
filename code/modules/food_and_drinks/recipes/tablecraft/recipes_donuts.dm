/////////////////////////////////DONUTS\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

/datum/crafting_recipe/food/donut
	time = 15
	name = "Donut"
	reqs = list(
		/datum/reagent/consumable/sugar = 1,
		/obj/item/reagent_containers/food/snacks/pastrybase = 1
	)
	result = /obj/item/reagent_containers/food/snacks/donut/plain
	subcategory = CAT_DONUT


/datum/crafting_recipe/food/donut/chaos
	name = "Chaos donut"
	reqs = list(
		/datum/reagent/consumable/frostoil = 5,
		/datum/reagent/consumable/capsaicin = 5,
		/obj/item/reagent_containers/food/snacks/pastrybase = 1
	)
	result = /obj/item/reagent_containers/food/snacks/donut/chaos

/datum/crafting_recipe/food/donut/meat
	time = 15
	name = "Meat donut"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/meat/rawcutlet = 1,
		/obj/item/reagent_containers/food/snacks/pastrybase = 1
	)
	result = /obj/item/reagent_containers/food/snacks/donut/meat

/datum/crafting_recipe/food/donut/jelly
	name = "Jelly donut"
	reqs = list(
		/datum/reagent/consumable/berryjuice = 5,
		/obj/item/reagent_containers/food/snacks/pastrybase = 1
	)
	result = /obj/item/reagent_containers/food/snacks/donut/jelly/plain

/datum/crafting_recipe/food/donut/slimejelly
	name = "Slime jelly donut"
	reqs = list(
		/datum/reagent/toxin/slimejelly = 5,
		/obj/item/reagent_containers/food/snacks/pastrybase = 1
	)
	result = /obj/item/reagent_containers/food/snacks/donut/jelly/slimejelly/plain


/datum/crafting_recipe/food/donut/berry
	name = "Berry Donut"
	reqs = list(
		/datum/reagent/consumable/berryjuice = 3,
		/obj/item/reagent_containers/food/snacks/donut/plain = 1
	)
	result = /obj/item/reagent_containers/food/snacks/donut/berry

/datum/crafting_recipe/food/donut/trumpet
	name = "Spaceman's Donut"
	reqs = list(
		/datum/reagent/medicine/polypyr = 3,
		/obj/item/reagent_containers/food/snacks/donut/plain = 1
	)

	result = /obj/item/reagent_containers/food/snacks/donut/trumpet

/datum/crafting_recipe/food/donut/apple
	name = "Apple Donut"
	reqs = list(
		/datum/reagent/consumable/applejuice = 3,
		/obj/item/reagent_containers/food/snacks/donut/plain = 1
	)
	result = /obj/item/reagent_containers/food/snacks/donut/apple

/datum/crafting_recipe/food/donut/caramel
	name = "Caramel Donut"
	reqs = list(
		/datum/reagent/consumable/caramel = 3,
		/obj/item/reagent_containers/food/snacks/donut/plain = 1
	)
	result = /obj/item/reagent_containers/food/snacks/donut/caramel

/datum/crafting_recipe/food/donut/choco
	name = "Chocolate Donut"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/chocolatebar = 1,
		/obj/item/reagent_containers/food/snacks/donut/plain = 1
	)
	result = /obj/item/reagent_containers/food/snacks/donut/choco

/datum/crafting_recipe/food/donut/blumpkin
	name = "Blumpkin Donut"
	reqs = list(
		/datum/reagent/consumable/blumpkinjuice = 3,
		/obj/item/reagent_containers/food/snacks/donut/plain = 1
	)
	result = /obj/item/reagent_containers/food/snacks/donut/blumpkin

/datum/crafting_recipe/food/donut/bungo
	name = "Bungo Donut"
	reqs = list(
		/datum/reagent/consumable/bungojuice = 3,
		/obj/item/reagent_containers/food/snacks/donut/plain = 1
	)
	result = /obj/item/reagent_containers/food/snacks/donut/bungo

/datum/crafting_recipe/food/donut/matcha
	name = "Matcha Donut"
	reqs = list(
		/datum/reagent/toxin/teapowder = 3,
		/obj/item/reagent_containers/food/snacks/donut/plain = 1
	)
	result = /obj/item/reagent_containers/food/snacks/donut/matcha

////////////////////////////////////////////////////JELLY DONUTS///////////////////////////////////////////////////////

/datum/crafting_recipe/food/donut/jelly/berry
	name = "Berry Jelly Donut"
	reqs = list(
		/datum/reagent/consumable/berryjuice = 3,
		/obj/item/reagent_containers/food/snacks/donut/jelly/plain = 1
	)
	result = /obj/item/reagent_containers/food/snacks/donut/jelly/berry

/datum/crafting_recipe/food/donut/jelly/trumpet
	name = "Spaceman's Jelly Donut"
	reqs = list(
		/datum/reagent/medicine/polypyr = 3,
		/obj/item/reagent_containers/food/snacks/donut/jelly/plain = 1
	)

	result = /obj/item/reagent_containers/food/snacks/donut/jelly/trumpet

/datum/crafting_recipe/food/donut/jelly/apple
	name = "Apple Jelly Donut"
	reqs = list(
		/datum/reagent/consumable/applejuice = 3,
		/obj/item/reagent_containers/food/snacks/donut/jelly/plain = 1
	)
	result = /obj/item/reagent_containers/food/snacks/donut/jelly/apple

/datum/crafting_recipe/food/donut/jelly/caramel
	name = "Caramel Jelly Donut"
	reqs = list(
		/datum/reagent/consumable/caramel = 3,
		/obj/item/reagent_containers/food/snacks/donut/jelly/plain = 1
	)
	result = /obj/item/reagent_containers/food/snacks/donut/jelly/caramel

/datum/crafting_recipe/food/donut/jelly/choco
	name = "Chocolate Jelly Donut"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/chocolatebar = 1,
		/obj/item/reagent_containers/food/snacks/donut/jelly/plain = 1
	)
	result = /obj/item/reagent_containers/food/snacks/donut/jelly/choco

/datum/crafting_recipe/food/donut/jelly/blumpkin
	name = "Blumpkin Jelly Donut"
	reqs = list(
		/datum/reagent/consumable/blumpkinjuice = 3,
		/obj/item/reagent_containers/food/snacks/donut/jelly/plain = 1
	)
	result = /obj/item/reagent_containers/food/snacks/donut/jelly/blumpkin

/datum/crafting_recipe/food/donut/jelly/bungo
	name = "Bungo Jelly Donut"
	reqs = list(
		/datum/reagent/consumable/bungojuice = 3,
		/obj/item/reagent_containers/food/snacks/donut/jelly/plain = 1
	)
	result = /obj/item/reagent_containers/food/snacks/donut/jelly/bungo

/datum/crafting_recipe/food/donut/jelly/matcha
	name = "Matcha Jelly Donut"
	reqs = list(
		/datum/reagent/toxin/teapowder = 3,
		/obj/item/reagent_containers/food/snacks/donut/jelly/plain = 1
	)
	result = /obj/item/reagent_containers/food/snacks/donut/jelly/matcha

////////////////////////////////////////////////////SLIME  DONUTS///////////////////////////////////////////////////////

/datum/crafting_recipe/food/donut/slimejelly/berry
	name = "Berry Slime Donut"
	reqs = list(
		/datum/reagent/consumable/berryjuice = 3,
		/obj/item/reagent_containers/food/snacks/donut/jelly/slimejelly/plain = 1
	)
	result = /obj/item/reagent_containers/food/snacks/donut/jelly/slimejelly/berry

/datum/crafting_recipe/food/donut/slimejelly/trumpet
	name = "Spaceman's Slime Donut"
	reqs = list(
		/datum/reagent/medicine/polypyr = 3,
		/obj/item/reagent_containers/food/snacks/donut/jelly/slimejelly/plain = 1
	)

	result = /obj/item/reagent_containers/food/snacks/donut/jelly/slimejelly/trumpet

/datum/crafting_recipe/food/donut/slimejelly/apple
	name = "Apple Slime Donut"
	reqs = list(
		/datum/reagent/consumable/applejuice = 3,
		/obj/item/reagent_containers/food/snacks/donut/jelly/slimejelly/plain = 1
	)
	result = /obj/item/reagent_containers/food/snacks/donut/jelly/slimejelly/apple

/datum/crafting_recipe/food/donut/slimejelly/caramel
	name = "Caramel Slime Donut"
	reqs = list(
		/datum/reagent/consumable/caramel = 3,
		/obj/item/reagent_containers/food/snacks/donut/jelly/slimejelly/plain = 1
	)
	result = /obj/item/reagent_containers/food/snacks/donut/jelly/slimejelly/caramel

/datum/crafting_recipe/food/donut/slimejelly/choco
	name = "Chocolate Slime Donut"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/chocolatebar = 1,
		/obj/item/reagent_containers/food/snacks/donut/jelly/slimejelly/plain = 1
	)
	result = /obj/item/reagent_containers/food/snacks/donut/jelly/slimejelly/choco

/datum/crafting_recipe/food/donut/slimejelly/blumpkin
	name = "Blumpkin Slime Donut"
	reqs = list(
		/datum/reagent/consumable/blumpkinjuice = 3,
		/obj/item/reagent_containers/food/snacks/donut/jelly/slimejelly/plain = 1
	)
	result = /obj/item/reagent_containers/food/snacks/donut/jelly/slimejelly/blumpkin

/datum/crafting_recipe/food/donut/slimejelly/bungo
	name = "Bungo Slime Donut"
	reqs = list(
		/datum/reagent/consumable/bungojuice = 3,
		/obj/item/reagent_containers/food/snacks/donut/jelly/slimejelly/plain = 1
	)
	result = /obj/item/reagent_containers/food/snacks/donut/jelly/slimejelly/bungo

/datum/crafting_recipe/food/donut/slimejelly/matcha
	name = "Matcha Slime Donut"
	reqs = list(
		/datum/reagent/toxin/teapowder = 3,
		/obj/item/reagent_containers/food/snacks/donut/jelly/slimejelly/plain = 1
	)
	result = /obj/item/reagent_containers/food/snacks/donut/jelly/slimejelly/matcha
