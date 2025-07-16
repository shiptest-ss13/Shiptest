/obj/item/food/ration/snack
	icon_state = "ration_snack"
	food_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/sugar = 3)

/obj/item/food/ration/snack/pizza_crackers
	name = "pepperoni pizza cheese filled crackers"
	desc = "Cheese-filled crackers, flavored with marinara sauce and pepperoni."
	filling_color = "#b82121"
	tastes = list("cheese crackers" = 3, "pepperoni" = 1, "marinara flavoring" = 1)
	foodtypes = MEAT | DAIRY | GRAIN | JUNKFOOD

/obj/item/food/ration/snack/fruit_puree
	name = "apple, strawberry, and carrot fruit puree squeeze"
	desc = "A plastic pack with a straw neck, dispensing a puree of various fruits and bits of carrot."
	filling_color = "#cc3131"
	tastes = list("apple" = 1, "strawberry" = 1, "carrot" = 3)
	foodtypes = VEGETABLES | FRUIT | SUGAR

/obj/item/food/ration/snack/cinnamon_bun
	name = "cinnamon bun"
	desc = "A plastic-shrouded cinnamon bun, kept shelf stable but left dry."
	filling_color = "#b18d40"
	tastes = list("cinnamon" = 3, "dense, sweet bread" = 1)
	foodtypes = GRAIN | SUGAR

/obj/item/food/ration/snack/toaster_pastry
	name = "chocolate chip toaster pastry"
	desc = "A dry chocolate chip-flavored toaster pastry. The front-facing side has a thin layer of icing."
	filling_color = "#e2a054"
	tastes = list("chocolate" = 1, "dry pastry" = 1, "sweet" = 1)
	foodtypes = SUGAR | GRAIN | JUNKFOOD | BREAKFAST
	cookable = TRUE

/obj/item/food/ration/snack/dried_raisins
	name = "dried raisins"
	desc = "A small plastic packet containing a handful of dried raisins."
	filling_color = "#1b1146"
	tastes = list("raisins" = 1, "sweet" = 1)
	foodtypes = FRUIT | SUGAR

/obj/item/food/ration/snack/corn_kernels
	name = "toasted corn kernels, barbecue"
	desc = "Toasted corn kernels, coated in a dusting of barbecue flavor."
	filling_color = "#836b1d"
	tastes = list("corn" = 1, "barbecue" = 1, "something getting stuck between your teeth" = 1)
	foodtypes = SUGAR | VEGETABLES | JUNKFOOD

/obj/item/food/ration/snack/chocolate_pudding
	name = "chocolate pudding"
	desc = "A packet of shelf-stable chocolate pudding, with a chemical aftertaste."
	filling_color = "#3b2406"
	tastes = list("chocolate" = 2, "pudding" = 1, "chemical-y taste" = 3)
	foodtypes = SUGAR | JUNKFOOD

/obj/item/food/ration/snack/blackberry_preserves
	name = "blackberry preserves"
	desc = "Thick blackberry preserves in a sealed bag, intended to be spread across another component of the MRE."
	filling_color = "#26133b"
	tastes = list("blackberry" = 1, "sugar" = 1)
	foodtypes = FRUIT

/obj/item/food/ration/snack/candy_rings
	name = "peppermint candy rings"
	desc = "Red and white candy rings that are peppermint-flavored. They're difficult to crunch into."
	filling_color = "#ecafaf"
	tastes = list("peppermint" = 3, "sugar" = 1)
	foodtypes = SUGAR | JUNKFOOD

/obj/item/food/ration/snack/lemon_pound_cake
	name = "lemon pound cake"
	desc = "A square of lemon-flavored dense pound cake."
	filling_color = "#ffff99"
	tastes = list("lemon" = 1, "drying cake" = 1)
	foodtypes = SUGAR

/obj/item/food/ration/snack/cherry_snackers
	name = "cherry snackers"
	desc = "Preserved cherries with their seeds removed beforehand, mildly coated in with a sticky syrup."
	filling_color = "#ff0066"
	tastes = list("cherry" = 1)
	foodtypes = FRUIT

/obj/item/food/ration/snack/mint_chocolate_snack_cake
	name = "mint chocolate snack cake"
	desc = "A small chocolate snack cake square, imparted with an artificial mint flavoring."
	filling_color = "#00cc66"
	tastes = list("mint" = 1, "chocolate" = 1, "cake" = 1)
	foodtypes = SUGAR | GRAIN

/obj/item/food/ration/snack/strawberry_preserves
	name = "strawberry preserves"
	desc = "A packet of strawberry preserves intended to be used as a spread for another portion of the MRE, or eaten straight."
	filling_color = "#ff3300"
	tastes = list("strawberry" = 1)
	foodtypes = SUGAR | FRUIT

/obj/item/food/ration/snack/sour_gummy_worms
	name = "sour gummy worms"
	desc = "Lengths of colored, slightly stiff gummy strips, coated in a mildly sour powder."
	filling_color = "#ff9900"
	tastes = list("slight sourness" = 1, "stiff gummy" = 1)
	foodtypes = SUGAR

/obj/item/food/ration/snack/blue_raspberry_candies
	name = "blue raspberry candies"
	desc = "Blue raspberry-flavored candies, individually wrapped and partially reduced to smaller fragments."
	filling_color = "#3399ff"
	tastes = list("blue raspberry shards" = 1)
	foodtypes = SUGAR

/obj/item/food/ration/snack/peanut_cranberry_mix
	name = "peanut cranberry mix"
	desc = "A simple trailmix of salted peanuts and dried cranberries."
	filling_color = "#cc3300"
	tastes = list("peanut" = 1, "cranberry" = 1)
	foodtypes = FRUIT

/obj/item/food/ration/snack/channeler_meat_candy
	name = "channeler meat candy"
	desc = "A traditional sugary meat confection from the Antechannel League. Each piece of candied channeler is thoroughly wrapped to preserve it for longer."
	filling_color = "#9933ff"
	tastes = list("channeler meat" = 1, "candy" = 1)
	foodtypes = MEAT | SUGAR

/obj/item/food/ration/snack/chocolate_orange_snack_cake
	name = "chocolate orange snack cake"
	desc = "A small chocolate snack cake square of orange flavoring."
	filling_color = "#ff6600"
	tastes = list("chocolate" = 1, "orange" = 1, "cake" = 1)
	foodtypes = SUGAR

/obj/item/food/ration/snack/pick_me_up_energy_gum
	name = "Pick-Me-Up energy gum"
	desc = "Individually wrapped sticks of energy gum, leaving your mouth coated with sour flavorings. Not nicotine!"
	filling_color = "#00cc66"
	tastes = list("energy gum" = 1)
	foodtypes = SUGAR

/obj/item/food/ration/snack/apple_slices
	name = "apple slices"
	desc = "A packet of shrink-wrapped apple slices."
	filling_color = "#ff3300"
	tastes = list("apple" = 1)
	foodtypes = FRUIT

/obj/item/food/ration/snack/candied_pineapple_chunks
	name = "candied pineapple chunks"
	desc = "A small bag of candied pineapple chunks."
	filling_color = "#ff6600"
	tastes = list("candied pineapple" = 1)
	foodtypes = SUGAR | FRUIT

/obj/item/food/ration/snack/smoked_almonds
	name = "smoked almonds"
	desc = "A packet of smoked almonds with a slightly sticky coating of seasoning and salt crystals."
	filling_color = "#663300"
	tastes = list("smoked almonds" = 1)
	foodtypes = FRUIT

/obj/item/food/ration/snack/chocolate_chunk_oatmeal_cookie
	name = "chocolate chunk oatmeal cookie"
	desc = "A dry, shelf-stable oatmeal cookie with dark chocolate chips."
	filling_color = "#663300"
	tastes = list("chocolate" = 1, "sweet oatmeal" = 1)
	foodtypes = SUGAR | GRAIN

/obj/item/food/ration/snack/peanut_candies
	name = "peanut candies"
	desc = "A packet of sticky, candied peanuts. They tend to get everywhere."
	filling_color = "#ff9900"
	tastes = list("peanut" = 1)
	foodtypes = SUGAR | FRUIT

/obj/item/food/ration/snack/patriotic_sugar_cookies
	name = "patriotic sugar cookies"
	desc = "Sugar cookies with patriotic designs, of which are dependent on their manufacturer's country of origin."
	filling_color = "#ffcc00"
	tastes = list("sugar cookies" = 1)
	foodtypes = SUGAR

/obj/item/food/ration/snack/oatmeal_cookie
	name = "oatmeal cookie"
	desc = "A small sleeve of equally small oatmeal cookies."
	filling_color = "#663300"
	tastes = list("dry, sweet oatmeal" = 1)
	foodtypes = SUGAR | GRAIN

/obj/item/food/ration/snack/dried_cranberries
	name = "dried cranberries"
	desc = "A packet of dried cranberries."
	filling_color = "#cc3300"
	tastes = list("cranberries" = 1)
	foodtypes = FRUIT

/obj/item/food/ration/snack/dry_roasted_peanuts
	name = "dry roasted peanuts"
	desc = "A packet of dried, roasted peanuts."
	filling_color = "#663300"
	tastes = list("peanuts" = 1)
	foodtypes = FRUIT

/obj/item/food/ration/snack/jalapeno_cashews
	name = "jalapeno cashews"
	desc = "A baggie of cashews coated in a jalapeno-based seasoning."
	filling_color = "#663300"
	tastes = list("jalapeno" = 1, "cashews" = 1)
	foodtypes = FRUIT

/obj/item/food/ration/snack/miras_parfait
	name = "miras-dotu parfait"
	desc = "A small vacuum-sealed pouch of Miras parfait. The lower sugar-density of the Dotu fruit has kept it from becoming sickly-sweet, and left it average."
	filling_color = "#00cc66"
	tastes = list("thick and creamy" = 6, "fruitiness" = 1)
	foodtypes = SUGAR

/obj/item/food/ration/snack/fara_li
	name = "candied fara-li"
	desc = "Whole fara-li fruit, preserved in a thin, sweet syrup."
	filling_color = "#ce8c22"
	tastes = list("spice" = 1, "subtle fruitiness" = 5)
	foodtypes = FRUIT | SUGAR

/obj/item/food/ration/snack/seed_crackers
	name = "seed crackers"
	desc = "Small crackers made with seed-flour and dusted with a light coat of sugar."
	filling_color = "#7e5719"
	tastes = list("crunchy seeds" = 1)
	foodtypes = GRAIN | SUGAR
