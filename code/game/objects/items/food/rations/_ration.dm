/obj/item/food/ration
	name = "nutriment ration"
	desc = "standard issue ration"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	icon = 'icons/obj/food/ration.dmi'
	icon_state = "ration_side"
	food_flags = FOOD_IN_CONTAINER
	w_class = WEIGHT_CLASS_SMALL
	max_volume = 30

	var/cookable = FALSE
	var/cooked = FALSE
	//temp, remove this or just keep it i dont care but the rations need color overlays
	var/filling_color

/obj/item/food/ration/Initialize(mapload)
	. = ..()
	update_overlays()

/obj/item/food/ration/examine_more(mob/user)
	. = ..()
	var/list/tags = bitfield_to_list(foodtypes, FOOD_FLAGS_IC)
	. += span_notice("This ration pack contains the following food groups:")
	for(var/tag in tags)
		. += " - [tag]"

/obj/item/food/ration/update_overlays()
	. = ..()
	var/mutable_appearance/ration_overlay
	if(icon_exists(icon, "[icon_state]_filling"))
		ration_overlay = mutable_appearance(icon, "[icon_state]_filling")
	else if(icon_exists(icon, "[initial(icon_state)]_filling"))
		ration_overlay = mutable_appearance(icon, "[initial(icon_state)]_filling")
	else
		return
	ration_overlay.color = filling_color
	add_overlay(ration_overlay)

/obj/item/food/ration/proc/open_ration(mob/user)
	to_chat(user, span_notice("You tear open \the [src]."))
	playsound(user.loc, 'sound/effects/rip3.ogg', 50)
	reagents.flags |= OPENCONTAINER
	desc += "\nIt's been opened."
	update_overlays()

/obj/item/food/ration/attack_self(mob/user)
	if(!is_drainable())
		icon_state = "[icon_state]_open"
		open_ration(user)
	return ..()

/obj/item/food/ration/attack(mob/living/M, mob/user, def_zone)
	if(!is_drainable())
		to_chat(user, span_warning("The [src] is sealed shut!"))
		return 0
	return ..()

/obj/item/food/ration/microwave_act(obj/machinery/microwave/Heater)
	if(cookable == FALSE)
		..()
	else if(cooked == TRUE)
		..()
	else
		name = "warm [initial(name)]"
		var/cooking_efficiency = 1
		if(istype(Heater))
			cooking_efficiency = Heater.efficiency
		if(length(food_reagents))
			for(var/r_id in food_reagents)
				var/amount = food_reagents[r_id] * cooking_efficiency
				if(ispath(r_id, /datum/reagent/consumable/nutriment))
					reagents.add_reagent(r_id, amount, tastes)
				else
					reagents.add_reagent(r_id, amount)
		cooked = TRUE

/obj/item/food/ration/examine(mob/user)
	. = ..()
	if(cookable && !cooked)
		. += span_notice("It can be cooked in a <b>microwave</b> or warmed using a <b>flameless ration heater</b>.")
