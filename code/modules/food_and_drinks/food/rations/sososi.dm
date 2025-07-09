/obj/item/storage/ration/sososi
	name = "sososi leaf ration"
	desc = "Feel fruity with this tecetian ration. The sweet flavor of a Sososi leaf will cut through the rest of the meal, providing a unique centerpiece to assorted cheese and fruits."
	emblem_icon_state = "emblem_sososi"

/obj/item/storage/ration/sososi/PopulateContents()
	var/static/items_inside = list(
		/obj/item/reagent_containers/food/snacks/ration/entree/sososi = 1,
		/obj/item/reagent_containers/food/snacks/ration/side/lifosa = 1,
		/obj/item/reagent_containers/food/snacks/ration/side/cactus = 1,
		/obj/item/reagent_containers/food/snacks/ration/snack/fara_li = 1,
		/obj/item/reagent_containers/food/snacks/ration/bar/dote_on = 1,
		/obj/item/reagent_containers/food/snacks/ration/condiment/powdered_dotu = 1,
		/obj/item/reagent_containers/food/drinks/ration/sososi_seta = 1
		)
	generate_items_inside(items_inside,src)


/obj/item/reagent_containers/food/snacks/ration/entree/sososi
	name = "whole Sososi Leaf"
	desc = "Thick leaves with an interior made of sweet gel. It's been vacuum-sealed to preserve the flavor, and integrity of the plant"
	filling_color = "#2a7416"
	tastes = list("fruity gel" = 4, "watery sugars" = 1, "satisfying crunch" = 2)
	foodtype = VEGETABLES | SUGAR
	cookable = FALSE

/obj/item/reagent_containers/food/snacks/ration/side/lifosa
	name = "Lifosa Tiris"
	desc = "Pearls of Tiris cheese within a salty, air cured crust. The interior of the package is somewhat oily."
	filling_color = "#cac84e"
	tastes = list("rock salts" = 1, "cheese" = 2)
	list_reagents = list(/datum/reagent/consumable/nutriment = 4)
	foodtype = DAIRY

/obj/item/reagent_containers/food/snacks/ration/side/cactus
	name = "cored cactus fruit"
	desc = "A Tecetian cactus fruit, cored out so that it can be stuffed full of other foods."
	filling_color = "#e2904d"
	list_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 1, /datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/vitfro = 1)
	tastes = list("fruity mushroom" = 1)
	foodtype = FRUIT

/obj/item/reagent_containers/food/snacks/ration/snack/fara_li
	name = "candied fara-li"
	desc = "Whole fara-li fruit, preserved in a thin, sweet syrup."
	filling_color = "#ce8c22"
	tastes = list("spice" = 1, "subtle fruitiness" = 5)
	foodtype = FRUIT | SUGAR

/obj/item/reagent_containers/food/snacks/ration/bar/dote_on
	name = "Doting..."
	desc = "A specialty fruit bar made to mimic \"Dote On It!\". The berries have been compressed down and joined with some seeds "
	filling_color = "#70829a"
	tastes = list("crunchy seeds" = 2, "sweet berries" = 4)
	list_reagents = list(/datum/reagent/consumable/nutriment = 4)
	foodtype = FRUIT | GRAIN

/obj/item/reagent_containers/food/snacks/ration/condiment/powdered_dotu
	name = "powdered dotu"
	desc = "Powdered Dotu fruit makes an excellent topping when a more neutral flavor is desired."
	filling_color = "#c3bca0"
	list_reagents = list(/datum/reagent/consumable/dotu_juice = 8)

/obj/item/reagent_containers/food/drinks/ration/sososi_seta
	name = "Sososi-Seta pouch"
	desc = "A bitter spirit made with Tecetian flora. Best used as a digestive."
	list_reagents = list(/datum/reagent/consumable/ethanol/sososeta = 15)
