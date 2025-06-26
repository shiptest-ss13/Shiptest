/obj/item/storage/ration/miras
	name = "miras and tiris ration"
	desc = "Enjoy a combination of Miras and Tiris. This ration pack is centered along the Tiris Celima, and supported by "
	emblem_icon_state = "emblem_mt"

/obj/item/storage/ration/sososi/PopulateContents()
	var/static/items_inside = list(
		/obj/item/reagent_containers/food/snacks/ration/entree/tiris_celima = 1,
		/obj/item/reagent_containers/food/snacks/ration/side/miras_reti = 1,
		/obj/item/reagent_containers/food/snacks/ration/side/tirila = 1,
		/obj/item/reagent_containers/food/snacks/ration/snack/seed_crackers = 1,
		/obj/item/reagent_containers/food/snacks/ration/bar/wanderer = 1,
		/obj/item/reagent_containers/food/snacks/ration/condiment/tiris_cheese = 1,
		/obj/item/reagent_containers/food/drinks/ration/refa_li = 1
		)
	generate_items_inside(items_inside,src)


/obj/item/reagent_containers/food/snacks/ration/entree/tiris_celima
	name = "Tiris Celima"
	desc = "Dofitis fat is rendered from the animal and used to slow-cook this heavily salted chunk of Tiris steak. Once it's warmed up, it practically melts in the mouth."
	filling_color = "#2a7416"
	tastes = list("fatty meat" = 2, "salt" = 3, "crusty herbs" = 1)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/ration/side/miras_reti
	name = "Miras Reti"
	desc = "Whole unfertiilzed Miras eggs. The shell has already been removed, so some of them are smushed up."
	filling_color = "#f4f4f4"
	tastes = list("egg" = 4, "savory yolk" = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 4)
	foodtype = BREAKFAST | MEAT

/obj/item/reagent_containers/food/snacks/ration/side/tirila
	name = "Tirila-Li"
	desc = "An entire stick of Tirili-La, a cured meat sausage made with Refa Fruit and Tiris."
	filling_color = "#453e3b"
	tastes = list("spicy-savory meat" = 3, "bitter fruit" = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/capsaicin = 2)
	foodtype = MEAT | FRUIT

/obj/item/reagent_containers/food/snacks/ration/snack/seed_crackers
	name = "seed crackers"
	desc = "Small crackers made with seed-flour and dusted with a light coat of sugar."
	filling_color = "#7e5719"
	tastes = list("crunchy seeds" = 1)
	foodtype = GRAIN | SUGAR

/obj/item/reagent_containers/food/snacks/ration/bar/wanderer
	name = "wanderer bar"
	desc = "A bar of shredded miras meat, refa-li, and seeds, not too much unlike Tirili-La. Great for a power-up before a trip."
	filling_color = "#70829a"
	tastes = list("sweet meat" = 4, "dried out fruit flesh" = 2, "crunchy seeds" = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 4)
	foodtype = MEAT | GRAIN | FRUIT

/obj/item/reagent_containers/food/snacks/ration/condiment/tiris_cheese
	name = "tiris cheese spread pack"
	filling_color = "#cac84e"
	list_reagents = list(/datum/reagent/consumable/cheese_spread = 8)

/obj/item/reagent_containers/food/drinks/ration/refa_li
	name = "Refa-Li Juice"
	desc = "The spicy juice of a Refa-Li fruit."
	list_reagents = list(/datum/reagent/consumable/refa_li = 10, /datum/reagent/consumable/capsaicin = 5)
