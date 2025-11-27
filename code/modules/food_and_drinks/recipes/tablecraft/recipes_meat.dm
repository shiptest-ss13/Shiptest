/datum/crafting_recipe/food/kebab
	name = "Kebab"
	reqs = list(
		/obj/item/stack/rods = 1,
		/obj/item/food/meat/steak = 2
	)
	result = /obj/item/food/kebab/monkey
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/tofukebab
	name = "Tofu kebab"
	reqs = list(
		/obj/item/stack/rods = 1,
		/obj/item/food/tofu = 2
	)
	result = /obj/item/food/kebab/tofu
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/fiestaskewer
	name = "Fiesta Skewer"
	reqs = list(
		/obj/item/stack/rods = 1,
		/obj/item/food/grown/chili = 1,
		/obj/item/food/meat/cutlet = 1,
		/obj/item/food/grown/corn = 1,
		/obj/item/food/grown/tomato = 1
	)
	result = /obj/item/food/kebab/fiesta
	subcategory = CAT_MEAT

//Fish

/datum/crafting_recipe/food/cubancarp
	name = "Cuban carp"
	reqs = list(
		/datum/reagent/consumable/flour = 5,
		/obj/item/food/grown/chili = 1,
		/obj/item/food/fishmeat/carp = 1
	)
	result = /obj/item/food/cubancarp
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/fishandchips
	name = "Fish and chips"
	reqs = list(
		/obj/item/food/fries = 1,
		/obj/item/food/fishmeat = 1
	)
	result = /obj/item/food/fishandchips
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/fishfingers
	name = "Fish fingers"
	reqs = list(
		/datum/reagent/consumable/flour = 5,
		/obj/item/food/bun = 1,
		/obj/item/food/fishmeat = 1
	)
	result = /obj/item/food/fishfingers
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/sashimi
	name = "Sashimi"
	reqs = list(
		/datum/reagent/consumable/soysauce = 5,
		/obj/item/food/spidereggs = 1,
		/obj/item/food/fishmeat = 1
	)
	result = /obj/item/food/sashimi
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/spicyfiletsushiroll
	name = "Spicy sushi roll"
	reqs = list(
		/obj/item/food/grown/seaweed/sheet = 1,
		/obj/item/food/boiled_rice = 1,
		/obj/item/food/fishmeat = 1,
		/obj/item/food/grown/chili = 1,
		/obj/item/food/grown/onion = 1
	)
	result = /obj/item/food/spicyfiletsushiroll
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/temakiroll
	name = "Zohil temaki roll"
	reqs = list(
		/obj/item/food/grown/seaweed/sheet = 8,
		/obj/item/food/fishmeat = 4
	)
	result = /obj/item/food/temakiroll
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/nigiri_sushi
	name = "Nigiri sushi"
	reqs = list(
		/obj/item/food/grown/seaweed/sheet = 1,
		/obj/item/food/boiled_rice = 1,
		/obj/item/food/fishmeat = 1,
		/datum/reagent/consumable/soysauce = 2
	)
	result = /obj/item/food/nigiri_sushi
	subcategory = CAT_MEAT

//Spider eggs

/datum/crafting_recipe/food/spidereggsham
	name = "Spider eggs ham"
	reqs = list(
		/datum/reagent/consumable/sodiumchloride = 1,
		/obj/item/food/spidereggs = 1,
		/obj/item/food/meat/cutlet/spider = 2
	)
	result = /obj/item/food/spidereggsham
	subcategory = CAT_MEAT

//Misc

/datum/crafting_recipe/food/cornedbeef
	name = "Corned beef"
	reqs = list(
		/datum/reagent/consumable/sodiumchloride = 5,
		/obj/item/food/meat/steak = 1,
		/obj/item/food/grown/cabbage = 2
	)
	result = /obj/item/food/cornedbeef
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/bearsteak
	name = "Filet migrawr"
	reqs = list(
		/datum/reagent/consumable/ethanol/manly_dorf = 5,
		/obj/item/food/meat/steak/bear = 1,
	)
	tools = list(/obj/item/lighter)
	result = /obj/item/food/bearsteak
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/enchiladas
	name = "Enchiladas"
	reqs = list(
		/obj/item/food/meat/cutlet = 2,
		/obj/item/food/grown/chili = 2,
		/obj/item/food/tortilla = 2
	)
	result = /obj/item/food/enchiladas
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/stewedsoymeat
	name = "Stewed soymeat"
	reqs = list(
		/obj/item/food/soydope = 2,
		/obj/item/food/grown/carrot = 1,
		/obj/item/food/grown/tomato = 1
	)
	result = /obj/item/food/stewedsoymeat
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/sausage
	name = "Sausage"
	reqs = list(
		/obj/item/food/raw_meatball  = 1,
		/obj/item/food/meat/rawcutlet = 2
	)
	result = /obj/item/food/raw_sausage
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/tiris_dote
	name = "Tiris dotesu"
	reqs = list(
		/obj/item/food/grown/dote_berries = 1,
		/obj/item/food/meat/rawcutlet/tiris = 2
	)
	result = /obj/item/food/sausage/tiris_dote //convert to raw - sprites
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/tiris_refa
	name = "Tiris refasu"
	reqs = list(
		/obj/item/food/grown/refa_li = 1,
		/obj/item/food/meat/rawcutlet/tiris = 2
	)
	result = /obj/item/food/sausage/tiris_refa //convert to raw - sprites
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/tirila_li
	name = "Tirila-li"
	reqs = list(
		/obj/item/food/grown/refa_li = 1,
		/obj/item/food/grown/dotu_fime = 1,
		/datum/reagent/consumable/sodiumchloride = 1,
		/obj/item/food/meat/rawcutlet/tiris = 2
	)
	result = /obj/item/food/sausage/tirila_li
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/nugget
	name = "Chicken nugget"
	reqs = list(
		/obj/item/food/meat/cutlet = 1
	)
	result = /obj/item/food/nugget
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/rawkhinkali
	name = "Raw Khinkali"
	reqs = list(
		/obj/item/food/doughslice = 1,
		/obj/item/food/grown/garlic = 1,
		/obj/item/food/meatball = 1
	)
	result =  /obj/item/food/rawkhinkali
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/dofi_dore
	name = "Dofi-dore"
	reqs = list(
		/obj/item/food/doughslice = 1,
		/obj/item/food/meat/slab/dofitis = 1,
	)
	result =  /obj/item/food/dofi_dore
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/timera
	name = "Timera-fa"
	reqs = list(
		/obj/item/food/grown/dotu_fime = 1,
		/obj/item/food/grown/dote_berries = 1,
		/obj/item/food/meat/steak/tiris = 1,
	)
	result = /obj/item/food/timera
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/tiris_apple
	name = "Tiris and apples"
	reqs = list(
		/obj/item/food/grown/apple = 1,
		/obj/item/food/meat/steak/tiris = 1,
	)
	result = /obj/item/food/tiris_apple
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/dofi_tami
	name = "Dofi-tami"
	reqs = list(
		/obj/item/food/meat/slab/dofitis = 2,
	)
	result = /obj/item/food/dofi_tami
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/pigblanket
	name = "Pig in a Blanket"
	reqs = list(
		/obj/item/food/bun = 1,
		/obj/item/food/butter = 1,
		/obj/item/food/meat/cutlet = 1
	)
	result = /obj/item/food/pigblanket
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/miras_sososi
	name = "Miras sososi"
	reqs = list(
		/obj/item/food/meat/steak/miras = 1,
		/obj/item/food/grown/sososi = 1,
		/datum/reagent/consumable/tiris_sele = 1
	)
	result = /obj/item/food/miras_sososi
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/miras_sososi
	name = "Siti-Miras"
	reqs = list(
		/obj/item/food/meat/steak/miras = 1,
		/obj/item/food/grown/siti = 1,
		/obj/item/food/grown/dote_berries = 1
	)
	result = /obj/item/food/siti_miras
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/miras_li
	name = "Miras-li"
	reqs = list(
		/obj/item/food/meat/slab/miras = 1,
		/obj/item/food/grown/refa_li = 1
	)
	result = /obj/item/food/miras_li
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/wine_remes
	name = "Wine remes"
	reqs = list(
		/obj/item/food/meat/slab/remes = 1,
		/datum/reagent/consumable/ethanol/wine = 10
	)
	result = /obj/item/food/wine_remes
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/remes_li
	name = "Remes-li"
	reqs = list(
		/obj/item/food/meat/slab/remes = 1,
		/obj/item/food/grown/refa_li = 1
	)
	result = /obj/item/food/remes_li
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/dofi_tese
	name = "dofi-tese"
	reqs = list(
		/obj/item/food/meat/steak/dofitis = 1,
		/obj/item/food/grown/refa_li = 1
	)
	result = /obj/item/food/dofi_tese
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/sososi_dofi
	name = "sososi dofi"
	reqs = list(
		/obj/item/food/meat/steak/dofitis = 1,
		/obj/item/food/grown/sososi = 1
	)
	result = /obj/item/food/sososi_dofi
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/sososi_dofi
	name = "dofi-nari"
	reqs = list(
		/obj/item/food/meat/steak/dofitis = 1,
		/obj/item/food/grown/siti = 1,
		/obj/item/food/grown/dotu_fime = 1
	)
	result = /obj/item/food/dofi_nari
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/ratkebab
	name = "Rat Kebab"
	reqs = list(
		/obj/item/stack/rods = 1,
		/obj/item/food/deadmouse = 1
	)
	result = /obj/item/food/kebab/rat
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/miras_kebab
	name = "Miras Kebab"
	reqs = list(
		/obj/item/stack/rods = 1,
		/obj/item/food/meat/slab/miras = 1
	)
	result = /obj/item/food/kebab/miras
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/fafe_skewer
	name = "Faferiri skewer"
	reqs = list(
		/obj/item/stack/rods = 1,
		/obj/item/food/meat/slab/remes = 1,
		/obj/item/food/grown/refa_li = 1,
		/obj/item/food/grown/sososi = 1
	)
	result = /obj/item/food/kebab/fafe_skewer
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/doubleratkebab
	name = "Double Rat Kebab"
	reqs = list(
		/obj/item/stack/rods = 1,
		/obj/item/food/deadmouse = 2
	)
	result = /obj/item/food/kebab/rat/double
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/ricepork
	name = "Rice and Pork"
	reqs = list(
		/obj/item/food/boiled_rice = 1,
		/obj/item/food/meat/cutlet = 2
	)
	result = /obj/item/food/salad/ricepork
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/ribs
	name = "BBQ Ribs"
	reqs = list(
		/datum/reagent/consumable/bbqsauce = 5,
		/obj/item/food/meat/steak/plain = 2,
		/obj/item/stack/rods = 2
	)
	result = /obj/item/food/bbqribs
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/gumbo
	name = "Gumbo"
	reqs = list(
		/obj/item/food/boiled_rice = 1,
		/obj/item/food/grown/peas = 1,
		/obj/item/food/grown/chili = 1,
		/obj/item/food/meat/cutlet = 1
	)
	result = /obj/item/food/soup/gumbo
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/fishfry
	name = "Fish fry"
	reqs = list(
		/obj/item/food/grown/corn = 1,
		/obj/item/food/grown/peas = 1,
		/obj/item/food/fishmeat = 1
	)
	result = /obj/item/food/fishfry
	subcategory = CAT_MEAT

/datum/crafting_recipe/food/crab_rangoon
	name = "Crab Rangoon"
	reqs = list(
		/obj/item/food/doughslice = 1,
		/datum/reagent/consumable/cream = 5,
		/obj/item/food/cheese/wedge = 1,
		/obj/item/food/meat/rawcrab = 1
	)
	result = /obj/item/food/crab_rangoon
	subcategory = CAT_MEAT
