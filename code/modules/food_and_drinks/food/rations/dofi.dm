/obj/item/storage/ration/dofidote
	name = "dofi-dote combo ration"
	desc = "Move between the threshold of sweet and savory with this ration pack. Start with a course of dofi-tami, mix it up with dote berries and dore, and coat it all with tiris-sele."
	emblem_icon_state = "emblem_dofi"

/obj/item/storage/ration/dofidote/PopulateContents()
	var/static/items_inside = list(
		/obj/item/reagent_containers/food/snacks/ration/entree/dofi_tami = 1,
		/obj/item/reagent_containers/food/snacks/ration/side/dote_berry = 1,
		/obj/item/reagent_containers/food/snacks/ration/side/dore = 1,
		/obj/item/reagent_containers/food/snacks/ration/snack/miras_parfait = 1,
		/obj/item/reagent_containers/food/snacks/ration/bar/tirila = 1,
		/obj/item/reagent_containers/food/snacks/ration/condiment/tiris_sele = 1,
		/obj/item/reagent_containers/food/snacks/ration/pack/dote_juice = 1
		)
	generate_items_inside(items_inside,src)

/obj/item/reagent_containers/food/snacks/ration/entree/dofi_tami
	name = "Dofi-Tami slices"
	desc = "Thin slices of a dehydrated fatty meat. The best way to eat it is to tear chunks off and let them melt in your mouth."
	filling_color = "#510d0d"
	tastes = list("rich meat" = 6, "savory animal fat" = 2)
	foodtype = MEAT | SUGAR
	cookable = FALSE

/obj/item/reagent_containers/food/snacks/ration/side/dote_berry
	name = "dehydrated dote berries"
	desc = "Small crunchy berries that've been victim to a dusting of seasoning. The seeds tend to cluster at the bottom of the pack."
	filling_color = "#2359a0"
	tastes = list("concentrated fruit" = 4, "spice" = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/vitamin = 1)
	foodtype = FRUIT

/obj/item/reagent_containers/food/snacks/ration/side/dore
	name = "ready-to-go Dore"
	desc = "A Tecetian pastry typically stuffed with meat and fruit. These ones have been left plain for the consumer to alter."
	filling_color = "#e2904d"
	tastes = list("seedy bread")
	foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/ration/snack/miras_parfait
	name = "Miras-Dotu parfait"
	desc = "A small vacuum-sealed pouch of Miras parfait. The lower sugar-density of the Dotu fruit has kept it from becoming sickly-sweet, and left it average."
	filling_color = "#00cc66"
	tastes = list("thick and creamy" = 6, "fruitiness" = 1)
	foodtype = SUGAR

/obj/item/reagent_containers/food/snacks/ration/bar/tirila
	name = "Tirila-La log"
	desc = "Cured Tiris meat from Teceti, packed to the brim with a savory spice."
	filling_color = "#453e3b"
	tastes = list("spicy-savory meat" = 6, "bitter fruit" = 4)
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/capsaicin = 1)
	foodtype = MEAT | FRUIT

/obj/item/reagent_containers/food/snacks/ration/condiment/tiris_sele
	name = "tiris-sele"
	desc = "An incredibly rich sauce made with the blood of a Tiris"
	filling_color = "#c3bca0"
	list_reagents = list(/datum/reagent/consumable/tiris_sele = 8)

/obj/item/reagent_containers/food/snacks/ration/pack/dote_juice
	name = "dote juice powder"
	filling_color = "#803300"
	list_reagents = list(/datum/reagent/consumable/dote_juice = 8)
