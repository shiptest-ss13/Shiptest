/obj/item/reagent_containers/food/drinks/mug // parent type is literally just so empty mug sprites are a thing
	name = "mug"
	desc = "A ceramic mug that incldues a handle. Handles hot drinks best."
	icon = 'icons/obj/drinks/cup.dmi'
	fill_icon_thresholds = list(30, 50, 70, 90)
	icon_state = "mug"
	item_state = "coffee"
	spillable = TRUE
	volume = 30

///obj/item/reagent_containers/food/drinks/rilenacup -> /obj/item/reagent_containers/food/drinks/mug/rilena, great subtype
/obj/item/reagent_containers/food/drinks/rilenacup
	name = "RILENA mug"
	desc = "A mug with RILENA: LMR protagonist Ri's face on it."
	icon_state = "rilenacup"
	icon = 'icons/obj/drinks/cup.dmi'
	volume = 30
	spillable = TRUE
///obj/item/reagent_containers/food/drinks/beaglemug -> /obj/item/reagent_containers/food/drinks/mug/beagle FUCK this pathing

/obj/item/reagent_containers/food/drinks/beaglemug
	name = "beagle mug"
	desc = "A beloved edifice of a Dog, now as a mug!"
	icon = 'icons/obj/drinks/cup.dmi'
	icon_state = "beaglemug"
	amount_per_transfer_from_this = 10
	volume = 30
	custom_materials = list(/datum/material/glass=500)
	max_integrity = 20
	spillable = TRUE
	resistance_flags = ACID_PROOF
	obj_flags = UNIQUE_RENAME
	drop_sound = 'sound/items/handling/drinkglass_drop.ogg'
	pickup_sound =  'sound/items/handling/drinkglass_pickup.ogg'
	custom_price = 15

/obj/item/reagent_containers/food/drinks/beaglemug/on_reagent_change(changetype)
	cut_overlays()
	if(reagents.reagent_list.len)
		var/mutable_appearance/reagent_overlay = mutable_appearance(icon, "beaglemug_overlay")
		icon_state = "beaglemug"
		reagent_overlay.color = mix_color_from_reagents(reagents.reagent_list)
		add_overlay(reagent_overlay)
	else
		icon_state = "beaglemug"
		renamedByPlayer = FALSE
