/obj/item/food/ration/bar
	icon_state = "ration_bar"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/sugar = 2,
	)

/obj/item/food/ration/bar/energy_bar
	name = "quik-energy bar, apple-cinnamon"
	desc = "A thick, grainy energy bar, flavored with nigh-unbearably artificial apple and cinnamon flavorings."
	filling_color = "#ee3e1f"
	tastes = list("artificial apple" = 1, "cloying cinnamon" = 1)
	foodtypes = FRUIT | GRAIN

/obj/item/food/ration/bar/tropical_energy_bar
	name = "tropical energy bar"
	desc = "A sugar and caffeine-laced jelly bar with tropical fruit flavorings. It offers a good bit of chew."
	filling_color = "#ff9900"
	tastes = list("tropical" = 1, "energy bar" = 1)
	foodtypes = SUGAR | FRUIT

/obj/item/food/ration/bar/rationers_guild_chocolate_bar
	name = "\improper Rationer's Guild chocolate bar"
	desc = "A shelf-stable chocolate bar made by the Rationer's Guild, often considered the supreme bar option out of all the MRE options."
	filling_color = "#663300"
	tastes = list("chocolate" = 1)
	foodtypes = SUGAR

/obj/item/food/ration/bar/quik_energy_bar_chocolate
	name = "quik-energy bar chocolate"
	desc = "A thick, grainy energy bar, flavored with nigh-unbearably artificial chocolate flavoring."
	filling_color = "#663300"
	tastes = list("artificial chocolate" = 1)
	foodtypes = SUGAR

/obj/item/food/ration/bar/tirila
	name = "tirila-la log"
	desc = "Cured Tiris meat from Teceti, packed to the brim with a savory spice."
	filling_color = "#453e3b"
	tastes = list("spicy-savory meat" = 6, "bitter fruit" = 4)
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/capsaicin = 1,
	)
	foodtypes = MEAT | FRUIT

/obj/item/food/ration/bar/dote_on
	name = "\improper Doting..."
	desc = "A specialty fruit bar made to mimic \"Dote On It!\". The berries have been compressed down and joined with some seeds "
	filling_color = "#70829a"
	tastes = list("crunchy seeds" = 2, "sweet berries" = 4)
	foodtypes = FRUIT | GRAIN

/obj/item/food/ration/bar/wanderer
	name = "wanderer bar"
	desc = "A bar of shredded miras meat, refa-li, and seeds, not too much unlike Tirili-La. Great for a power-up before a trip."
	filling_color = "#70829a"
	tastes = list("sweet meat" = 4, "dried out fruit flesh" = 2, "crunchy seeds" = 1)
	foodtypes = MEAT | GRAIN | FRUIT
