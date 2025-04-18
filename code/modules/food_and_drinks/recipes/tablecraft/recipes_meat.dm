// see code/module/crafting/table.dm

////////////////////////////////////////////////KEBABS////////////////////////////////////////////////

/datum/crafting_recipe/food/humankebab
	name = "Human kebab"
	reqs = list(
		/obj/item/stack/rods = 1,
		/obj/item/reagent_containers/food/snacks/meat/steak/plain/human = 2
	)
	result = /obj/item/reagent_containers/food/snacks/kebab/human
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/kebab
	name = "Kebab"
	reqs = list(
		/obj/item/stack/rods = 1,
		/obj/item/reagent_containers/food/snacks/meat/steak = 2
	)
	result = /obj/item/reagent_containers/food/snacks/kebab/monkey
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/tofukebab
	name = "Tofu kebab"
	reqs = list(
		/obj/item/stack/rods = 1,
		/obj/item/reagent_containers/food/snacks/tofu = 2
	)
	result = /obj/item/reagent_containers/food/snacks/kebab/tofu
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/fiestaskewer
	name = "Fiesta Skewer"
	reqs = list(
		/obj/item/stack/rods = 1,
		/obj/item/reagent_containers/food/snacks/grown/chili = 1,
		/obj/item/reagent_containers/food/snacks/meat/cutlet = 1,
		/obj/item/reagent_containers/food/snacks/grown/corn = 1,
		/obj/item/reagent_containers/food/snacks/grown/tomato = 1
	)
	result = /obj/item/reagent_containers/food/snacks/kebab/fiesta
	subcategory = CAT_MEAT

////////////////////////////////////////////////FISH////////////////////////////////////////////////

/datum/crafting_recipe/food/cubancarp
	name = "Cuban carp"
	reqs = list(
		/datum/reagent/consumable/flour = 5,
		/obj/item/reagent_containers/food/snacks/grown/chili = 1,
		/obj/item/reagent_containers/food/snacks/fishmeat/carp = 1
	)
	result = /obj/item/reagent_containers/food/snacks/cubancarp
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/fishandchips
	name = "Fish and chips"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/fries = 1,
		/obj/item/reagent_containers/food/snacks/fishmeat = 1
	)
	result = /obj/item/reagent_containers/food/snacks/fishandchips
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/fishfingers
	name = "Fish fingers"
	reqs = list(
		/datum/reagent/consumable/flour = 5,
		/obj/item/reagent_containers/food/snacks/bun = 1,
		/obj/item/reagent_containers/food/snacks/fishmeat = 1
	)
	result = /obj/item/reagent_containers/food/snacks/fishfingers
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/sashimi
	name = "Sashimi"
	reqs = list(
		/datum/reagent/consumable/soysauce = 5,
		/obj/item/reagent_containers/food/snacks/spidereggs = 1,
		/obj/item/reagent_containers/food/snacks/fishmeat = 1
	)
	result = /obj/item/reagent_containers/food/snacks/sashimi
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/spicyfiletsushiroll
	name = "Spicy sushi roll"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/grown/seaweed/sheet = 1,
		/obj/item/reagent_containers/food/snacks/salad/boiledrice = 1,
		/obj/item/reagent_containers/food/snacks/fishmeat = 1,
		/obj/item/reagent_containers/food/snacks/grown/chili = 1,
		/obj/item/reagent_containers/food/snacks/grown/onion = 1
	)
	result = /obj/item/reagent_containers/food/snacks/spicyfiletsushiroll
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/fishi
	name = "Fi-shi roll"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/grown/seaweed/sheet = 8,
		/obj/item/reagent_containers/food/snacks/fishmeat/carp = 4
	)
	result = /obj/item/reagent_containers/food/snacks/fishi
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/nigiri_sushi
	name = "Nigiri sushi"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/grown/seaweed/sheet = 1,
		/obj/item/reagent_containers/food/snacks/salad/boiledrice = 1,
		/obj/item/reagent_containers/food/snacks/fishmeat = 1,
		/datum/reagent/consumable/soysauce = 2
	)
	result = /obj/item/reagent_containers/food/snacks/nigiri_sushi
	subcategory = CAT_MEAT

////////////////////////////////////////////////MR SPIDER////////////////////////////////////////////////

/datum/crafting_recipe/food/spidereggsham
	name = "Spider eggs ham"
	reqs = list(
		/datum/reagent/consumable/sodiumchloride = 1,
		/obj/item/reagent_containers/food/snacks/spidereggs = 1,
		/obj/item/reagent_containers/food/snacks/meat/cutlet/spider = 2
	)
	result = /obj/item/reagent_containers/food/snacks/spidereggsham
	subcategory = CAT_MEAT

////////////////////////////////////////////////MISC RECIPE's////////////////////////////////////////////////

/datum/crafting_recipe/food/cornedbeef
	name = "Corned beef"
	reqs = list(
		/datum/reagent/consumable/sodiumchloride = 5,
		/obj/item/reagent_containers/food/snacks/meat/steak = 1,
		/obj/item/reagent_containers/food/snacks/grown/cabbage = 2
	)
	result = /obj/item/reagent_containers/food/snacks/cornedbeef
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/bearsteak
	name = "Filet migrawr"
	reqs = list(
		/datum/reagent/consumable/ethanol/manly_dorf = 5,
		/obj/item/reagent_containers/food/snacks/meat/steak/bear = 1,
	)
	tools = list(/obj/item/lighter)
	result = /obj/item/reagent_containers/food/snacks/bearsteak
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/enchiladas
	name = "Enchiladas"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/meat/cutlet = 2,
		/obj/item/reagent_containers/food/snacks/grown/chili = 2,
		/obj/item/reagent_containers/food/snacks/tortilla = 2
	)
	result = /obj/item/reagent_containers/food/snacks/enchiladas
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/stewedsoymeat
	name = "Stewed soymeat"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/soydope = 2,
		/obj/item/reagent_containers/food/snacks/grown/carrot = 1,
		/obj/item/reagent_containers/food/snacks/grown/tomato = 1
	)
	result = /obj/item/reagent_containers/food/snacks/stewedsoymeat
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/sausage
	name = "Sausage"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/meatball = 1,
		/obj/item/reagent_containers/food/snacks/meat/cutlet = 2
	)
	result = /obj/item/reagent_containers/food/snacks/sausage
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/tiris_dote
	name = "Tiris dotesu"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/grown/dote_berries = 1,
		/obj/item/reagent_containers/food/snacks/meat/rawcutlet/tiris = 2
	)
	result = /obj/item/reagent_containers/food/snacks/sausage/tiris_dote
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/tiris_refa
	name = "Tiris refasu"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/grown/refa_li = 1,
		/obj/item/reagent_containers/food/snacks/meat/rawcutlet/tiris = 2
	)
	result = /obj/item/reagent_containers/food/snacks/sausage/tiris_refa
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/tirila_li
	name = "Tirila-li"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/grown/refa_li = 1,
		/obj/item/reagent_containers/food/snacks/grown/dotu_fime = 1,
		/datum/reagent/consumable/sodiumchloride = 1,
		/obj/item/reagent_containers/food/snacks/meat/rawcutlet/tiris = 2
	)
	result = /obj/item/reagent_containers/food/snacks/sausage/tirila_li
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/nugget
	name = "Chicken nugget"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/meat/cutlet = 1
	)
	result = /obj/item/reagent_containers/food/snacks/nugget
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/rawkhinkali
	name = "Raw Khinkali"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/doughslice = 1,
		/obj/item/reagent_containers/food/snacks/grown/garlic = 1,
		/obj/item/reagent_containers/food/snacks/meatball = 1
	)
	result =  /obj/item/reagent_containers/food/snacks/rawkhinkali
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/dofi_dore
	name = "Dofi-dore"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/doughslice = 1,
		/obj/item/reagent_containers/food/snacks/meat/slab/dofitis = 1,
	)
	result =  /obj/item/reagent_containers/food/snacks/dofi_dore
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/timera
	name = "Timera-fa"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/grown/dotu_fime = 1,
		/obj/item/reagent_containers/food/snacks/grown/dote_berries = 1,
		/obj/item/reagent_containers/food/snacks/meat/steak/tiris = 1,
	)
	result = /obj/item/reagent_containers/food/snacks/timera
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/tiris_apple
	name = "Tiris and apples"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/grown/apple = 1,
		/obj/item/reagent_containers/food/snacks/meat/steak/tiris = 1,
	)
	result = /obj/item/reagent_containers/food/snacks/tiris_apple
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/dofi_tami
	name = "Dofi-tami"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/meat/slab/dofitis = 2,
	)
	result = /obj/item/reagent_containers/food/snacks/dofi_tami
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/pigblanket
	name = "Pig in a Blanket"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/bun = 1,
		/obj/item/reagent_containers/food/snacks/butter = 1,
		/obj/item/reagent_containers/food/snacks/meat/cutlet = 1
	)
	result = /obj/item/reagent_containers/food/snacks/pigblanket
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/miras_sososi
	name = "Miras sososi"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/meat/steak/miras = 1,
		/obj/item/reagent_containers/food/snacks/grown/sososi = 1,
		/datum/reagent/consumable/tiris_sele = 1
	)
	result = /obj/item/reagent_containers/food/snacks/miras_sososi
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/miras_sososi
	name = "Siti-Miras"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/meat/steak/miras = 1,
		/obj/item/reagent_containers/food/snacks/grown/siti = 1,
		/obj/item/reagent_containers/food/snacks/grown/dote_berries = 1
	)
	result = /obj/item/reagent_containers/food/snacks/siti_miras
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/miras_dola
	name = "Miras-dola"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/meat/slab/miras = 1,
		/obj/item/reagent_containers/food/snacks/grown/ash_flora/cactus_fruit = 1
	)
	result = /obj/item/reagent_containers/food/snacks/miras_dola
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/miras_li
	name = "Miras-li"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/meat/slab/miras = 1,
		/obj/item/reagent_containers/food/snacks/grown/refa_li = 1
	)
	result = /obj/item/reagent_containers/food/snacks/miras_li
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/wine_remes
	name = "Wine remes"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/meat/slab/remes = 1,
		/datum/reagent/consumable/ethanol/wine = 10
	)
	result = /obj/item/reagent_containers/food/snacks/wine_remes
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/remes_li
	name = "Remes-li"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/meat/slab/remes = 1,
		/obj/item/reagent_containers/food/snacks/grown/refa_li = 1
	)
	result = /obj/item/reagent_containers/food/snacks/wine_remes
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/dofi_tese
	name = "dofi-tese"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/meat/steak/dofitis = 1,
		/obj/item/reagent_containers/food/snacks/grown/refa_li = 1
	)
	result = /obj/item/reagent_containers/food/snacks/dofi_tese
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/sososi_dofi
	name = "sososi dofi"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/meat/steak/dofitis = 1,
		/obj/item/reagent_containers/food/snacks/grown/sososi = 1
	)
	result = /obj/item/reagent_containers/food/snacks/sososi_dofi
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/sososi_dofi
	name = "dofi-nari"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/meat/steak/dofitis = 1,
		/obj/item/reagent_containers/food/snacks/grown/siti = 1,
		/obj/item/reagent_containers/food/snacks/grown/dotu_fime = 1
	)
	result = /obj/item/reagent_containers/food/snacks/dofi_nari
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/ratkebab
	name = "Rat Kebab"
	reqs = list(
		/obj/item/stack/rods = 1,
		/obj/item/food/deadmouse = 1
	)
	result = /obj/item/reagent_containers/food/snacks/kebab/rat
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/miras_kebab
	name = "Miras Kebab"
	reqs = list(
		/obj/item/stack/rods = 1,
		/obj/item/reagent_containers/food/snacks/meat/slab/miras = 1
	)
	result = /obj/item/reagent_containers/food/snacks/kebab/miras
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/fafe_skewer
	name = "Faferiri skewer"
	reqs = list(
		/obj/item/stack/rods = 1,
		/obj/item/reagent_containers/food/snacks/meat/slab/remes = 1,
		/obj/item/reagent_containers/food/snacks/grown/refa_li = 1,
		/obj/item/reagent_containers/food/snacks/grown/sososi = 1
	)
	result = /obj/item/reagent_containers/food/snacks/kebab/fafe_skewer
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/doubleratkebab
	name = "Double Rat Kebab"
	reqs = list(
		/obj/item/stack/rods = 1,
		/obj/item/food/deadmouse = 2
	)
	result = /obj/item/reagent_containers/food/snacks/kebab/rat/double
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/ricepork
	name = "Rice and Pork"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/salad/boiledrice = 1,
		/obj/item/reagent_containers/food/snacks/meat/cutlet = 2
	)
	result = /obj/item/reagent_containers/food/snacks/salad/ricepork
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/ribs
	name = "BBQ Ribs"
	reqs = list(
		/datum/reagent/consumable/bbqsauce = 5,
		/obj/item/reagent_containers/food/snacks/meat/steak/plain = 2,
		/obj/item/stack/rods = 2
	)
	result = /obj/item/reagent_containers/food/snacks/bbqribs
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/gumbo
	name = "Black eyed gumbo"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/salad/boiledrice = 1,
		/obj/item/reagent_containers/food/snacks/grown/peas = 1,
		/obj/item/reagent_containers/food/snacks/grown/chili = 1,
		/obj/item/reagent_containers/food/snacks/meat/cutlet = 1
	)
	result = /obj/item/reagent_containers/food/snacks/salad/gumbo
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/fishfry
	name = "Fish fry"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/grown/corn = 1,
		/obj/item/reagent_containers/food/snacks/grown/peas =1,
		/obj/item/reagent_containers/food/snacks/fishmeat = 1
	)
	result = /obj/item/reagent_containers/food/snacks/fishfry
	subcategory = CAT_MEAT
