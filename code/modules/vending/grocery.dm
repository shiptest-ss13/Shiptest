/obj/machinery/vending/grocery
	name = "\improper Frontier-Fresh"
	icon_state = "grocery-vendor-indie"
	desc = "Originally a food delivery company, Frontier-Fresh has shifted to automated vendors after dramatic increases to driver casualty rates."
	product_ads = "Fresh Food!;Get it while it's Cold!;Perfectly Picked Produce!;Rations are so Last Year."
	products = list(
		/obj/item/storage/box/papersack = 30,
		/obj/item/reagent_containers/condiment/enzyme/small = 10,
		/obj/item/food/meat/slab = 12,
		/obj/item/food/meat/slab/chicken = 10,
		/obj/item/food/meat/crab = 8,
		/obj/item/food/fishmeat = 12,
		/obj/item/food/grown/apple = 15,
		/obj/item/food/grown/banana = 15,
		/obj/item/food/grown/berries = 15,
		/obj/item/food/grown/cherries = 15,
		/obj/item/food/grown/eggplant = 10,
		/obj/item/food/grown/grapes = 15,
		/obj/item/food/grown/citrus/lemon = 15,
		/obj/item/food/grown/citrus/lime = 15,
		/obj/item/food/grown/citrus/orange = 15,
		/obj/item/food/grown/pineapple = 10,
		/obj/item/food/grown/cabbage = 15,
		/obj/item/food/grown/carrot = 15,
		/obj/item/food/grown/mushroom/chanterelle = 10,
		/obj/item/food/grown/chili = 15,
		/obj/item/food/grown/corn = 15,
		/obj/item/food/grown/onion = 15,
		/obj/item/food/grown/peas = 15,
		/obj/item/food/grown/potato = 15,
		/obj/item/food/grown/sweet_potato = 15,
		/obj/item/food/grown/pumpkin = 10,
		/obj/item/food/grown/redbeet = 15,
		/obj/item/food/grown/whitebeet = 15,
		/obj/item/food/grown/rice = 20,
		/obj/item/food/grown/oat = 20,
		/obj/item/food/grown/soybeans = 15,
		/obj/item/food/grown/tomato = 15,
		/obj/item/food/grown/watermelon = 10,
		/obj/item/reagent_containers/condiment/sugar = 10,
		/obj/item/food/grown/vanillapod = 12,
		/obj/item/food/grown/cocoapod = 12,
		/obj/item/reagent_containers/condiment/milk = 10,
		/obj/item/reagent_containers/condiment/soymilk = 10)
	premium = list(
		/obj/item/food/meat/slab/miras = 10,
		/obj/item/food/meat/slab/remes = 10,
		/obj/item/food/meat/slab/tiris = 10,
		/obj/item/food/grown/dote_berries = 20,
		/obj/item/food/grown/dotu_fime = 15,
		/obj/item/food/grown/fara_li = 15,
		/obj/item/food/grown/refa_li = 15,
		/obj/item/food/grown/siti = 15,
		/obj/item/food/grown/sososi = 15,
		/obj/item/reagent_containers/condiment/tiris_milk = 8,
		/obj/item/reagent_containers/condiment/tiris_sele = 8,
		/obj/item/reagent_containers/condiment/tiris_sale = 8)
	refill_canister = /obj/item/vending_refill/grocery
	default_price = 10
	extra_price = 15

/obj/item/vending_refill/grocery
	machine_name = "Frontier-Fresh"

/obj/machinery/vending/grocery/ngr
	name = "\improper Agni Trading Post Co-Op"
	icon_state = "grocery-vendor-ngr"
	desc = "Offers the freshest produce in the sector, proudly owned and operated by Agni's workers - Choose Agni Co-Op."

/obj/machinery/vending/grocery/cybersun
	name = "\improper Mr. Grocery"
	icon_state = "grocery-vendor-cybersun"
	desc = "Safe-to-eat, locally sourced and synthesized foodstock from Cybersun Biodynamic's Lab-Cultivated Meat & Aquaponics."

/obj/machinery/vending/grocery/clip
	name = "\improper Minuteman Convenience"
	icon_state = "grocery-vendor-clip"
	desc = "A Clover-branded Automated Grocery Vendor. Has all you need to make a meal for the whole crew, in less than a minute."

/obj/machinery/vending/grocery/warra
	name = "\improper Groceries-to-Go"
	icon_state = "grocery-vendor-warra"
	desc = "An archetypal automated grocer, designed in a collaboration between Makosso-Warra and Groceries-to-Go, LLC."
