////////////////////////////////////////////SNACKS FROM VENDING MACHINES////////////////////////////////////////////
//in other words: junk food
//don't even bother looking for recipes for these

/obj/item/reagent_containers/food/snacks/candy
	name = "candy"
	desc = "Nougat love it or hate it."
	icon_state = "candy"
	trash = /obj/item/trash/candy
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/sugar = 3)
	junkiness = 25
	filling_color = "#D2691E"
	tastes = list("candy" = 1)
	foodtype = JUNKFOOD | SUGAR

/obj/item/reagent_containers/food/snacks/candy/bronx
	name = "South Bronx Paradise bar"
	desc = "Lose weight, guaranteed! Caramel Mocha Flavor. Something about product consumption..."
	icon_state = "bronx"
	item_state = "candy"
	trash = /obj/item/trash/candy
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/sugar = 2, /datum/reagent/yuck = 1)
	junkiness = 10
	bitesize = 10
	filling_color = "#e4d4b7"
	tastes = list("candy" = 5, "weight loss" = 4, "insect larva" = 1)
	foodtype = JUNKFOOD | RAW | GROSS
	custom_premium_price = 800
	var/revelation = FALSE

/obj/item/reagent_containers/food/snacks/candy/bronx/On_Consume(mob/living/eater)
	. = ..()
	if(ishuman(eater))
		var/mob/living/carbon/human/carl = eater
		var/datum/disease/P = new /datum/disease/parasite()
		carl.ForceContractDisease(P, FALSE, TRUE)

/obj/item/reagent_containers/food/snacks/candy/bronx/examine(mob/user)
	. = ..()
	if(revelation == FALSE)
		to_chat(user, "<span class='notice'>Geeze, you need to get to get your eyes checked. You should look again...</span>")
		desc = "Lose weight, guaranteed! Caramel Mocha Flavor! WARNING: PRODUCT NOT FIT FOR HUMAN CONSUMPTION. CONTAINS LIVE DIAMPHIDIA SPECIMENS."
		name = "South Bronx Parasite bar"
		revelation = TRUE

/obj/item/reagent_containers/food/snacks/sosjerky
	name = "\improper Scaredy's Private Reserve Beef Jerky"
	icon_state = "sosjerky"
	desc = "Beef jerky made from the finest space cows."
	trash = /obj/item/trash/sosjerky
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/sugar = 3, /datum/reagent/consumable/sodiumchloride = 2)
	junkiness = 25
	filling_color = "#8B0000"
	tastes = list("dried meat" = 1)
	foodtype = JUNKFOOD | MEAT | SUGAR

/obj/item/reagent_containers/food/snacks/sosjerky/healthy
	name = "homemade beef jerky"
	desc = "Homemade beef jerky made from the finest space cows."
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/vitamin = 1)
	junkiness = 0

/obj/item/reagent_containers/food/snacks/chips
	name = "chips"
	desc = "Commander Riker's What-The-Crisps."
	icon_state = "chips"
	trash = /obj/item/trash/chips
	bitesize = 1
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/sugar = 3, /datum/reagent/consumable/sodiumchloride = 1)
	junkiness = 20
	filling_color = "#FFD700"
	tastes = list("salt" = 1, "crisps" = 1)
	foodtype = JUNKFOOD | FRIED

/obj/item/reagent_containers/food/snacks/no_raisin
	name = "4no raisins"
	icon_state = "4no_raisins"
	desc = "Best raisins in the universe. Not sure why."
	trash = /obj/item/trash/raisins
	list_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/sugar = 4)
	junkiness = 25
	filling_color = "#8B0000"
	tastes = list("dried raisins" = 1)
	foodtype = JUNKFOOD | FRUIT | SUGAR
	custom_price = 90

/obj/item/reagent_containers/food/snacks/no_raisin/healthy
	name = "homemade raisins"
	desc = "Homemade raisins, the best in all of spess."
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/vitamin = 2)
	junkiness = 0
	foodtype = FRUIT

/obj/item/reagent_containers/food/snacks/spacetwinkie
	name = "space twinkie"
	icon_state = "space_twinkie"
	desc = "Guaranteed to survive longer than you will."
	list_reagents = list(/datum/reagent/consumable/sugar = 4)
	junkiness = 25
	filling_color = "#FFD700"
	foodtype = JUNKFOOD | GRAIN | SUGAR
	custom_price = 30

/obj/item/reagent_containers/food/snacks/candy_trash
	name = "candy cigarette butt"
	icon = 'icons/obj/clothing/masks.dmi'
	icon_state = "candybum"
	desc = "The leftover from a smoked-out candy cigarette. Can be eaten!"
	list_reagents = list(/datum/reagent/consumable/sugar = 4, /datum/reagent/ash = 3)
	junkiness = 10 //powergame trash food by buying candy cigs in bulk and eating them when they extinguish
	filling_color = "#FFFFFF"
	foodtype = JUNKFOOD | SUGAR

/obj/item/reagent_containers/food/snacks/candy_trash/nicotine
	desc = "The leftover from a smoked-out candy cigarette. Smells like nicotine..?"
	list_reagents = list(/datum/reagent/consumable/sugar = 4, /datum/reagent/ash = 3, /datum/reagent/drug/nicotine = 1)

/obj/item/reagent_containers/food/snacks/cheesiehonkers
	name = "cheesie honkers"
	desc = "Bite sized cheesie snacks that will honk all over your mouth."
	icon_state = "cheesie_honkers"
	trash = /obj/item/trash/cheesie
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/sugar = 3)
	junkiness = 25
	filling_color = "#FFD700"
	tastes = list("cheese" = 5, "crisps" = 2)
	foodtype = JUNKFOOD | DAIRY | SUGAR
	custom_price = 45

/obj/item/reagent_containers/food/snacks/syndicake
	name = "syndi-cakes"
	icon_state = "syndi_cakes"
	desc = "An extremely moist snack cake that tastes just as good after being nuked."
	trash = /obj/item/trash/syndi_cakes
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/doctor_delight = 5)
	filling_color = "#F5F5DC"
	tastes = list("sweetness" = 3, "cake" = 1)
	foodtype = GRAIN | FRUIT | VEGETABLES

/obj/item/reagent_containers/food/snacks/energybar
	name = "High-power energy bars"
	icon_state = "energybar"
	desc = "An energy bar with a lot of punch, you probably shouldn't eat this if you're not an Ethereal."
	trash = /obj/item/trash/energybar
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/liquidelectricity = 3)
	filling_color = "#97ee63"
	tastes = list("pure electricity" = 3, "fitness" = 2)
	foodtype = TOXIC

/obj/item/reagent_containers/food/snacks/peanuts
	name = "\improper Gallery's peanuts"
	desc = "A favourite amongst the terminally angry."
	icon_state = "peanuts"
	trash = /obj/item/trash/peanuts
	list_reagents = list(/datum/reagent/consumable/nutriment = 2)
	tastes = list("peanuts" = 4, "anger" = 1)
	foodtype = JUNKFOOD | NUTS
	junkiness = 10 //less junky than other options, since peanuts are a decently healthy snack option
	w_class = WEIGHT_CLASS_SMALL
	grind_results = list(/datum/reagent/consumable/peanut_butter = 5, /datum/reagent/consumable/cooking_oil = 2)

/obj/item/reagent_containers/food/snacks/peanuts/salted
	name = "\improper Gallery's salt reserves peanuts"
	desc = "Tastes salty."
	list_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/sodiumchloride = 1)
	tastes = list("peanuts" = 3, "salt" = 1, "high blood pressure" = 1)

/obj/item/reagent_containers/food/snacks/peanuts/wasabi
	name = "\improper Gallery's raging wasabi peanuts"
	desc = "The angriest of all peanut flavours."
	list_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/capsaicin = 1)
	tastes = list("peanuts" = 3, "wasabi" = 1, "rage" = 1)

/obj/item/reagent_containers/food/snacks/peanuts/honey_roasted
	name = "\improper Gallery's delete sweet peanuts"
	desc = "Oddly bitter for a sweet treat."
	list_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/sugar = 1)
	tastes = list("peanuts" = 3, "honey" = 1, "bitterness" = 1)

/obj/item/reagent_containers/food/snacks/peanuts/barbecue
	name = "\improper Gallery's IDEDBBQ peanuts"
	desc = "Where there's smoke, there's not necessarily fire- sometimes it's just BBQ sauce."
	list_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/bbqsauce = 1)
	tastes = list("peanuts" = 3, "bbq sauce" = 1, "arguments" = 1)

/obj/item/reagent_containers/food/snacks/peanuts/random
	name = "\improper Gallery's every-flavour peanuts"
	desc = "What flavour will you get?"
	icon_state = "peanuts"

/obj/item/reagent_containers/food/snacks/peanuts/random/Initialize()
	// Generate a sample p
	var/peanut_type = pick(subtypesof(/obj/item/reagent_containers/food/snacks/peanuts) - /obj/item/reagent_containers/food/snacks/peanuts/random)
	var/obj/item/reagent_containers/food/snacks/sample = new peanut_type(loc)

	name = sample.name
	desc = sample.desc
	list_reagents = sample.list_reagents
	tastes = sample.tastes

	qdel(sample)

	. = ..()

/obj/item/reagent_containers/food/snacks/cnds
	name = "\improper C&Ds"
	desc = "Legally, we cannot say that these won't melt in your hands."
	icon_state = "cnds"
	trash = /obj/item/trash/cnds
	list_reagents = list(/datum/reagent/consumable/sugar = 3, /datum/reagent/consumable/coco = 1)
	tastes = list("chocolate candy" = 3)
	junkiness = 25
	foodtype = JUNKFOOD
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/cnds/caramel
	name = "caramel C&Ds"
	desc = "Stuffed with sugary sweet caramel, making them a diabetic's worst nightmare."
	list_reagents = list(/datum/reagent/consumable/sugar = 2, /datum/reagent/consumable/coco = 1, /datum/reagent/consumable/caramel = 1)
	tastes = list("chocolate candy" = 2, "caramel" = 1)

/obj/item/reagent_containers/food/snacks/cnds/pretzel
	name = "pretzel C&Ds"
	desc = "Eine köstliche Begleitung zu Ihrem Lieblingsbier."
	list_reagents = list(/datum/reagent/consumable/sugar = 2, /datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/coco = 1)
	tastes = list("chocolate candy" = 2, "pretzel" = 1)
	foodtype = JUNKFOOD | GRAIN

/obj/item/reagent_containers/food/snacks/cnds/peanut_butter
	name = "peanut butter C&Ds"
	desc = "Beloved by small children and aliens alike."
	list_reagents = list(/datum/reagent/consumable/sugar = 2, /datum/reagent/consumable/coco = 1, /datum/reagent/consumable/peanut_butter = 1)
	tastes = list("chocolate candy" = 2, "peanut butter" = 1)

/obj/item/reagent_containers/food/snacks/cnds/banana_honk
	name = "banana honk C&Ds"
	desc = "The official candy of clowns everywhere. Honk honk!"
	list_reagents = list(/datum/reagent/consumable/sugar = 2, /datum/reagent/consumable/coco = 1, /datum/reagent/consumable/banana = 1)
	tastes = list("chocolate candy" = 2, "banana" = 1)

/obj/item/reagent_containers/food/snacks/cnds/random
	name = "mystery filled C&Ds"
	desc = "Filled with one of four delicious flavours!"

/obj/item/reagent_containers/food/snacks/cnds/random/Initialize()
	var/random_flavour = pick(subtypesof(/obj/item/reagent_containers/food/snacks/cnds) - /obj/item/reagent_containers/food/snacks/cnds/random)

	var/obj/item/reagent_containers/food/snacks/sample = new random_flavour(loc)

	name = sample.name
	desc = sample.desc
	list_reagents = sample.list_reagents
	tastes = sample.tastes

	qdel(sample)

	. = ..()
