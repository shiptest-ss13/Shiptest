/obj/item/reagent_containers/food/drinks/mug // parent type is literally just so empty mug sprites are a thing
	name = "mug"
	desc = "A ceramic mug that incldues a handle. Handles hot drinks best."
	icon_state = "mug"
	item_state = "coffee"
	spillable = TRUE
	volume = 30

///obj/item/reagent_containers/food/drinks/rilenacup -> /obj/item/reagent_containers/food/drinks/mug/rilena, great subtype
/obj/item/reagent_containers/food/drinks/rilenacup
	name = "RILENA mug"
	desc = "A mug with RILENA: LMR protagonist Ri's face on it."
	icon_state = "rilenacup"
	volume = 30
	spillable = TRUE
