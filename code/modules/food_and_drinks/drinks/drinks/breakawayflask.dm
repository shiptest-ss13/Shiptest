/obj/item/reagent_containers/food/drinks/breakawayflask
	name = "breakaway flask"
	desc = "A special flask designed to stabilize trick wines and shatter violently on contact."
	icon_state = "breakawayflask"
	gulp_size = 25
	amount_per_transfer_from_this = 25
	volume = 50
	throwforce = 20
	custom_materials = list(/datum/material/glass=2500, /datum/material/plasma=500)
	max_integrity = 20
	spillable = TRUE
	resistance_flags = ACID_PROOF
	obj_flags = UNIQUE_RENAME
	drop_sound = 'sound/items/handling/drinkglass_drop.ogg'
	pickup_sound =  'sound/items/handling/drinkglass_pickup.ogg'
	custom_price = 25

/obj/item/reagent_containers/food/drinks/breakawayflask/on_reagent_change(changetype)
	cut_overlays()

	gulp_size = max(round(reagents.total_volume / 25), 25)
	var/datum/reagent/largest_reagent = reagents.get_master_reagent()
	if (reagents.reagent_list.len > 0)
		if(!renamedByPlayer)
			name = largest_reagent.glass_name
			desc = largest_reagent.glass_desc
		if(largest_reagent.breakaway_flask_icon_state)
			icon_state = largest_reagent.breakaway_flask_icon_state
		else
			var/mutable_appearance/baflask_overlay = mutable_appearance(icon, "baflaskoverlay")
			icon_state = "baflaskclear"
			baflask_overlay.color = mix_color_from_reagents(reagents.reagent_list)
			add_overlay(baflask_overlay)

	else
		icon_state = "breakawayflask"
		name = initial(src.name)
		desc = initial(src.desc)
		return

/obj/item/reagent_containers/food/drinks/breakawayflask/vintageash
	name = "Vintange Saint-Roumain Ashwine"
	desc = "Supposedly one of the first bottles of ashwine made"
	list_reagents = list(/datum/reagent/consumable/ethanol/ash_wine = 45, /datum/reagent/fuel/oil = 5)

/obj/item/reagent_containers/food/drinks/breakawayflask/vintageice
	name = "Vintange Saint-Roumain Icewine"
	desc = "Supposedly one of the first bottles of icewine made"
	list_reagents = list(/datum/reagent/consumable/ethanol/ice_wine = 45, /datum/reagent/consumable/ice = 5)

/obj/item/reagent_containers/food/drinks/breakawayflask/vintageshock
	name = "Vintange Saint-Roumain Shockwine"
	desc = "Supposedly one of the first bottles of shockwine made"
	list_reagents = list(/datum/reagent/consumable/ethanol/shock_wine = 45, /datum/reagent/uranium = 5)

/obj/item/reagent_containers/food/drinks/breakawayflask/vintagehearth
	name = "Vintange Saint-Roumain Hearthwine"
	desc = "Supposedly one of the first bottles of hearthwine made"
	list_reagents = list(/datum/reagent/consumable/ethanol/hearth_wine = 45, /datum/reagent/uranium = 5)

/obj/item/reagent_containers/food/drinks/breakawayflask/vintageforce
	name = "Vintange Saint-Roumain forcehwine"
	desc = "Supposedly one of the first bottles of forcewine made"
	list_reagents = list(/datum/reagent/consumable/ethanol/force_wine = 45, /datum/reagent/uranium = 5)
