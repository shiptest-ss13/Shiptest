////////////////////////////////////////////SNACKS FROM VENDING MACHINES////////////////////////////////////////////
//in other words: junk food
//don't even bother looking for recipes for these

/obj/item/food/candy
	name = "candy"
	desc = "Nougat love it or hate it."
	icon_state = "candy"
	trash_type = /obj/item/trash/candy
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/sugar = 3,
	)
	junkiness = 25
	tastes = list("candy" = 1)
	foodtypes = JUNKFOOD | SUGAR
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_TINY

/obj/item/food/sosjerky
	name = "\improper Scaredy's Private Reserve Beef Jerky"
	icon_state = "sosjerky"
	desc = "Beef jerky made from the finest space cows."
	trash_type = /obj/item/trash/sosjerky
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 3,
		/datum/reagent/consumable/sugar = 2,
		/datum/reagent/consumable/sodiumchloride = 2,
	)
	junkiness = 25
	tastes = list("dried meat" = 1)
	w_class = WEIGHT_CLASS_SMALL
	foodtypes = JUNKFOOD | MEAT | SUGAR

/obj/item/food/sosjerky/healthy
	name = "homemade beef jerky"
	desc = "Homemade beef jerky made from the finest space cows."
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 1
	)
	junkiness = 0

/obj/item/food/chips
	name = "chips"
	desc = "Commander Riker's What-The-Crisps."
	icon_state = "chips"
	trash_type = /obj/item/trash/chips
	bite_consumption = 1
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/sugar = 3,
		/datum/reagent/consumable/sodiumchloride = 1,
	)
	junkiness = 20
	tastes = list("salt" = 1, "crisps" = 1)
	foodtypes = JUNKFOOD | FRIED
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/no_raisin
	name = "\improper 4no raisins"
	icon_state = "4no_raisins"
	desc = "Best raisins in the universe. Not sure why."
	trash_type = /obj/item/trash/raisins
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/sugar = 4,
	)
	junkiness = 25
	tastes = list("dried raisins" = 1)
	foodtypes = JUNKFOOD | FRUIT | SUGAR
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/no_raisin/healthy
	name = "homemade raisins"
	desc = "Homemade raisins, the best in all of spess."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 2
	)
	junkiness = 0
	foodtypes = FRUIT
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/spacetwinkie
	name = "\improper Space Twinkie"
	icon_state = "space_twinkie"
	desc = "Guaranteed to survive longer than you will."
	food_reagents = list(
		/datum/reagent/consumable/sugar = 4,
	)
	junkiness = 25
	foodtypes = JUNKFOOD | GRAIN | SUGAR
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/cheesiehonkers
	name = "\improper Cheesie Honkers"
	desc = "Bite sized cheesie snacks that will honk all over your mouth."
	icon_state = "cheesie_honkers"
	trash_type = /obj/item/trash/cheesie
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/sugar = 3,
	)
	junkiness = 25
	tastes = list("cheese" = 5, "crisps" = 2)
	foodtypes = JUNKFOOD | DAIRY | SUGAR
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/syndicake
	name = "\improper Syndi-Cakes"
	icon_state = "syndi_cakes"
	desc = "An extremely moist snack cake that tastes just as good after being nuked."
	trash_type = /obj/item/trash/syndi_cakes
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
	)
	tastes = list("sweetness" = 3, "cake" = 1)
	foodtypes = GRAIN | FRUIT | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/energybar
	name = "\improper Minute Energy bar"
	icon_state = "energybar"
	desc = "Referred to by many colorful names by the Minutemen it was issued to, this bar was produced by the Lanchester Foods Co. in order to supplement Minuteman rations in the field and improve morale. Though the initial version was infamous for being used more as a blunt weapon than anything else, nowadays it has found a place within the Minuteman and Civilian markets as a reliable source of nutrition."
	trash_type = /obj/item/trash/energybar
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/calcium = 2
	)
	tastes = list("orange chocolate" = 3, "an awful lemon filling" = 2, "something hard" = 1)
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/reti
	name = "(yum!) Reti"
	icon_state = "miras-reti"
	desc = "Preserved Miras eggs vacuum sealed inside a small tin for freshness. A label declares it as a \"Proud Product of the Northern Teceti Coalition\"."
	trash_type = /obj/item/trash/mirastin
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/eggyolk = 2,
	)
	tastes = list("egg" = 5, "a slight metallic hint" = 1)
	foodtypes = JUNKFOOD | MEAT
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/reti/homemade
	name = "miras reti"
	icon_state = "miras-reti"
	desc = "Dried miras eggs sealed inside a tin. A great snack for on the trail."
	trash_type = /obj/item/trash/mirastin
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/eggyolk = 2,
		/datum/reagent/consumable/nutriment/protein = 2,
	)
	tastes = list("egg" = 5)
	foodtypes = MEAT

/obj/item/food/lifosa
	name = "\improper Lifosa Tiris"
	icon_state = "lifosa-tiris"
	desc = "Small pearls of Tiris Cheese, sealed in a salty crust, and distributed in a sealed tin. The interior of the tin is somewhat oily."
	trash_type = /obj/item/trash/lifosa
	tastes = list("rock salts" = 2, "cheese" = 4, "savory herbs" = 1)
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 2,
	)
	foodtypes = DAIRY
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/lifosa/homemade
	name = "tiris pearls"
	icon_state = "lifosa-tiris"
	desc = "Small pearls of Tiris Cheese, sealed in a salty crust. They're fairly oily, and have a savory aroma."
	trash_type = null
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 2,
	)

/obj/item/food/dote
	name = "Dote on it!"
	icon_state = "dote"
	desc = "A quick snack native to Teceti. Dote berries are harvested, lightly seasoned, and dehydrated to make a crunchy fruit-based snack."
	trash_type = /obj/item/trash/dote
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
	)
	tastes = list("crunchy berry" = 5)
	foodtypes = JUNKFOOD | FRUIT
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/dote/homemade
	name = "dried dote"
	icon_state = "dote-natural"
	desc = "Lightly seasoned, air-dried dote berries. A quick and crunchy snack."
	trash_type = null
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("crunchy berry" = 5)
	foodtypes = FRUIT
