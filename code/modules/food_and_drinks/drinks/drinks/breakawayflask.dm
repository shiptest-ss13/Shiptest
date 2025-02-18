/obj/item/reagent_containers/food/drinks/breakawayflask
	name = "breakaway flask"
	desc = "A special flask designed to stabilize Illestren Bacterium and shatter violently on contact."
	icon_state = "breakawayflask"
	item_state = "breakawayflask"
	w_class = WEIGHT_CLASS_SMALL
	gulp_size = 25
	amount_per_transfer_from_this = 25
	volume = 50
	throwforce = 10
	custom_materials = list(/datum/material/glass=2500, /datum/material/plasma=500)
	max_integrity = 20
	spillable = TRUE
	resistance_flags = ACID_PROOF
	obj_flags = UNIQUE_RENAME
	drop_sound = 'sound/items/handling/drinkglass_drop.ogg'
	pickup_sound =  'sound/items/handling/drinkglass_pickup.ogg'
	custom_price = 15
	can_have_cap = TRUE
	cap_icon_state = "baflask_cap"
	cap_on = TRUE
	var/vintage = FALSE

/obj/item/reagent_containers/food/drinks/breakawayflask/on_reagent_change(changetype)
	cut_overlays()

	gulp_size = max(round(reagents.total_volume / 25), 25)
	var/datum/reagent/largest_reagent = reagents.get_master_reagent()
	if (reagents.reagent_list.len > 0)
		if(!renamedByPlayer && vintage == FALSE)
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
		name = "breakaway flask"
		desc = "A special flask designed to stabilize Illestren Bacterium and shatter violently on contact."
		return

/obj/item/reagent_containers/food/drinks/breakawayflask/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	spillable = TRUE
	. = ..()

/obj/item/reagent_containers/food/drinks/breakawayflask/vintage
	name = "Vintage Saint-Roumain Trickwine"
	desc = "Supposedly one of the first bottles made"
	vintage = TRUE

/obj/item/reagent_containers/food/drinks/breakawayflask/vintage/ashwine
	name = "Vintage Wine of Ash"
	list_reagents = list(/datum/reagent/consumable/ethanol/trickwine/ash_wine = 45, /datum/reagent/consumable/ethanol/absinthe  = 5)
	desc = "Wine of Ash was originally created using herbs native to Illestren, as a means of relaxing after a long hunt. The Saint-Roumain Militia has no prohibition on a little fun."

/obj/item/reagent_containers/food/drinks/breakawayflask/vintage/icewine
	name = "Vintage Wine Of Ice"
	list_reagents = list(/datum/reagent/consumable/ethanol/trickwine/ice_wine = 45, /datum/reagent/consumable/ethanol/sake = 5)
	desc = "Wine Of Ice, inspired by the frigid slopes of the 'Godforsaken Precipice' that forged the group's reputation as valiant survivalists, was engineered to both soothe overheated Hunters and freeze their foes in their tracks."

/obj/item/reagent_containers/food/drinks/breakawayflask/vintage/shockwine
	name = "Vintage Lightnings' Blessing"
	list_reagents = list(/datum/reagent/consumable/ethanol/trickwine/shock_wine = 45, /datum/reagent/consumable/ethanol/vodka = 5)
	desc = "Lightnings' Blessing, made to invigorate consumers and incapacitate targets, took inspiration from an incident early in the Saint-Roumain Militia's history, when a young Shadow stopped a rampaging beast by plunging an electrical cable that had been dislodged in the fighting into its side."

/obj/item/reagent_containers/food/drinks/breakawayflask/vintage/hearthwine
	name = "Vintage Hearthflame"
	list_reagents = list(/datum/reagent/consumable/ethanol/trickwine/hearth_wine = 45, /datum/reagent/consumable/ethanol/hcider = 5)
	desc = "Hearthflame is one of the most important tonics devised by the SRM – both for its potent abilities in staunching wounds or setting enemies aflame, and for its closeness to the divine fire associated with the Ashen Huntsman."
