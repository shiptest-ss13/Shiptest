

/obj/item/reagent_containers/food/drinks/drinkingglass
	name = "drinking glass"
	desc = "Your standard drinking glass."
	icon_state = "glass_empty"
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
			var/mutable_appearance/reagent_overlay = mutable_appearance(icon, "glassoverlay")
			icon_state = "glass_empty"
			reagent_overlay.color = mix_color_from_reagents(reagents.reagent_list)
			add_overlay(reagent_overlay)
	else
		icon_state = "glass_empty"
		renamedByPlayer = FALSE //so new drinks can rename the glass

/obj/item/reagent_containers/food/drinks/beaglemug
	name = "beagle mug"
	desc = "A beloved edifice of a Dog, now as a mug!"
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
	gulp_size = 15
	amount_per_transfer_from_this = 15
	possible_transfer_amounts = list()
	volume = 15
	custom_materials = list(/datum/material/glass=100)
	custom_price = 1
	var/filled_desc = "The challenge is not taking as many as you can, but guessing what it is before you pass out."

/obj/item/reagent_containers/food/drinks/drinkingglass/shotglass/on_reagent_change(changetype)
	cut_overlays()

	gulp_size = max(round(reagents.total_volume / 15), 15)

	if (reagents.reagent_list.len > 0)
		var/datum/reagent/largest_reagent = reagents.get_master_reagent()
		name = "filled [initial(src.name)]"
		desc = filled_desc

		if(largest_reagent.shot_glass_icon_state)
			icon_state = largest_reagent.shot_glass_icon_state
		else
			icon_state = "shotglassclear"
			var/mutable_appearance/shot_overlay = mutable_appearance(icon, "shotglassoverlay")
			shot_overlay.color = mix_color_from_reagents(reagents.reagent_list)
			add_overlay(shot_overlay)


	else
		icon_state = "shotglass"
		name = initial(src.name)
		desc = initial(src.desc)
		return

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

/obj/item/reagent_containers/food/drinks/drinkingglass/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/reagent_containers/food/snacks/egg)) //breaking eggs
		var/obj/item/reagent_containers/food/snacks/egg/E = I
		if(reagents)
			if(reagents.total_volume >= reagents.maximum_volume)
				to_chat(user, "<span class='notice'>[src] is full.</span>")
			else
				to_chat(user, "<span class='notice'>You break [E] in [src].</span>")
				reagents.add_reagent(/datum/reagent/consumable/eggyolk, 5)
				qdel(E)
			return
	else
		..()

/obj/item/reagent_containers/food/drinks/drinkingglass/attack(mob/target, mob/user)
	if(user.a_intent == INTENT_HARM && ismob(target) && target.reagents && reagents.total_volume)
		target.visible_message("<span class='danger'>[user] splashes the contents of [src] onto [target]!</span>", \
						"<span class='userdanger'>[user] splashes the contents of [src] onto you!</span>")
		log_combat(user, target, "splashed", src)
		reagents.expose(target, TOUCH)
		reagents.clear_reagents()
		return
	..()
