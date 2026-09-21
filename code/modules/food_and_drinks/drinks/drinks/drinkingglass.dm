

/obj/item/reagent_containers/food/drinks/drinkingglass
	name = "drinking glass"
	desc = "Your standard drinking glass."
	lefthand_file = 'icons/obj/drinks/drinks_lefthand.dmi'
	righthand_file = 'icons/obj/drinks/drinks_righthand.dmi'
	//world_file = 'icons/obj/drinks/drinks_world.dmi'
	icon_state = "glass"
	item_state = "glass"
	fill_icon_thresholds = list(1, 20, 50, 70, 90)
	amount_per_transfer_from_this = 10
	volume = 50
	custom_materials = list(/datum/material/glass=500)
	max_integrity = 20
	spillable = TRUE
	resistance_flags = ACID_PROOF
	obj_flags = UNIQUE_RENAME
	drop_sound = 'sound/items/handling/drinkglass_drop.ogg'
	pickup_sound =  'sound/items/handling/drinkglass_pickup.ogg'
	custom_price = 2

/obj/item/reagent_containers/food/drinks/drinkingglass/on_reagent_change(changetype)
	cut_overlays()
	if(reagents.reagent_list.len)
		var/datum/reagent/R = reagents.get_master_reagent()
		if(!renamedByPlayer)
			name = R.glass_name
			desc = R.glass_desc
		if(R.glass_icon_state)
			icon_state = R.glass_icon_state
		else
			icon_state = src::icon_state
			update_appearance()
	else
		name = src::name
		desc = src::desc
		icon_state = src::icon_state
		renamedByPlayer = FALSE //so new drinks can rename the glass

//Shot glasses!//
//  This lets us add shots in here instead of lumping them in with drinks because >logic  //
//  The format for shots is the exact same as iconstates for the drinking glass, except you use a shot glass instead.  //
//  If it's a new drink, remember to add it to Chemistry-Reagents.dm  and Chemistry-Recipes.dm as well.  //
//  You can only mix the ported-over drinks in shot glasses for now (they'll mix in a shaker, but the sprite won't change for glasses). //
//  This is on a case-by-case basis, and you can even make a separate sprite for shot glasses if you want. //

/obj/item/reagent_containers/food/drinks/drinkingglass/shotglass
	name = "shot glass"
	desc = "A shot glass - the universal symbol for bad decisions."
	icon_state = "shotglass"
	item_state = "shotglass"
	gulp_size = 15
	amount_per_transfer_from_this = 15
	fill_icon_thresholds = list(1, 30, 60, 90)
	possible_transfer_amounts = list()
	volume = 15
	custom_materials = list(/datum/material/glass=100)
	custom_price = 1
	var/filled_desc = "The challenge is not taking as many as you can, but guessing what it is before you pass out."

/obj/item/reagent_containers/food/drinks/drinkingglass/shotglass/on_reagent_change(changetype)
	cut_overlays()
	if(reagents.reagent_list.len)
		var/datum/reagent/R = reagents.get_master_reagent()
		if(!renamedByPlayer)
			desc = R.glass_desc
		if(R.shot_glass_icon_state)
			icon_state = R.shot_glass_icon_state
		else
			icon_state = src::icon_state
			update_appearance()
	else
		desc = src::desc
		icon_state = src::icon_state
		renamedByPlayer = FALSE //so new drinks can rename the glass


/obj/item/reagent_containers/food/drinks/drinkingglass/shotglass/commemorative
	name = "commemorative shot glass"
	desc = "A shot glass - the universal symbol for bad decisions. There's a mushroom cloud engraved on the bottom, and the words \"AAA-200\" written around the rim."
	filled_desc = "The challenge is not taking as many as you can, but guessing what it is before you pass out. The words \"AAA-200\" are written around the rim."
	list_reagents = list(/datum/reagent/consumable/ethanol/vodka = 12, /datum/reagent/uranium = 2, /datum/reagent/uranium/radium = 1)

/obj/item/reagent_containers/food/drinks/drinkingglass/shotglass/commemorative/examine(mob/user)
	. = ..()
	if(ishumanbasic(user))
		. += "You feel like this might be in poor taste."

/obj/item/reagent_containers/food/drinks/drinkingglass/filled/Initialize()
	. = ..()
	on_reagent_change(ADD_REAGENT)

/obj/item/reagent_containers/food/drinks/drinkingglass/filled/soda
	name = "Soda Water"
	list_reagents = list(/datum/reagent/consumable/sodawater = 50)

/obj/item/reagent_containers/food/drinks/drinkingglass/filled/cola
	name = "Space Cola"
	list_reagents = list(/datum/reagent/consumable/space_cola = 50)

/obj/item/reagent_containers/food/drinks/drinkingglass/filled/bridge_bunny
	name = "Bridge Bunny"
	list_reagents = list(/datum/reagent/consumable/ethanol/bridge_bunny = 50)

/obj/item/reagent_containers/food/drinks/drinkingglass/filled/gorlex_surprise
	name = "Gorlex Surprise"
	list_reagents = list(/datum/reagent/consumable/ethanol/syndicatebomb = 50)

/obj/item/reagent_containers/food/drinks/drinkingglass/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/food/egg)) //breaking eggs
		var/obj/item/food/egg/E = I
		if(reagents)
			if(reagents.total_volume >= reagents.maximum_volume)
				to_chat(user, span_notice("[src] is full."))
			else
				to_chat(user, span_notice("You break [E] in [src]."))
				reagents.add_reagent(/datum/reagent/consumable/eggyolk, 5)
				qdel(E)
			return
	else
		..()

/obj/item/reagent_containers/food/drinks/drinkingglass/attack(mob/target, mob/user)
	if(user.a_intent == INTENT_HARM && ismob(target) && target.reagents && reagents.total_volume)
		target.visible_message(span_danger("[user] splashes the contents of [src] onto [target]!"), \
						span_userdanger("[user] splashes the contents of [src] onto you!"))
		log_combat(user, target, "splashed", src)
		reagents.expose(target, TOUCH)
		reagents.clear_reagents()
		return
	..()
