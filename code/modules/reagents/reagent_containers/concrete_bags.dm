/* In a better world, the logic for transfering reagents out of containers wouldn't be in /glass */

/obj/item/reagent_containers/glass/concrete_bag
	name = "\improper concrete mix bag"
	desc = "A bag of concrete mixture from the F.O.O.D corportation. Just add water!"
	w_class = WEIGHT_CLASS_HUGE //25+ kg
	throw_range = 1

	amount_per_transfer_from_this = 25
	possible_transfer_amounts = list(25,50,75,100)
	list_reagents = list(/datum/reagent/concrete_mix = 200)
	reagent_flags = OPENCONTAINER
	volume = 200

	icon = 'icons/obj/chemical/concrete.dmi'
	icon_state = "concrete_bag"
	item_state = "concrete_bag"
	lefthand_file = 'icons/mob/inhands/misc/concrete_bag_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/concrete_bag_righthand.dmi'
	fill_icon_thresholds = null

	var/opened = FALSE
	var/opened_icon_state = "concrete_bag_open"

	drop_sound = 'sound/items/handling/cloth_drop.ogg'
	pickup_sound =  'sound/items/handling/cloth_pickup.ogg'

/obj/item/reagent_containers/glass/concrete_bag/examine(mob/user)
	. = ..()
	if(!opened)
		. += span_notice("[src] is unopened")
	else
		. += span_notice("[src] has been opened")

/obj/item/reagent_containers/glass/concrete_bag/AltClick(mob/user)
	if(!can_interact(user))
		return
	if(!opened)
		if(do_after(user, 3 SECONDS))
			visible_message(span_notice("[user] tears the top of [src] off!"), span_notice("You tear the top off [src]!"))
			playsound(src, 'sound/items/poster_ripped.ogg', 50, 1)
			new /obj/effect/decal/cleanable/generic(get_turf(src))
			icon_state = opened_icon_state
			spillable = TRUE
			opened = TRUE
			return
		return
	return

/obj/item/reagent_containers/glass/concrete_bag/attack_self(mob/user)
	if(!opened)
		return
	..()

/obj/item/reagent_containers/glass/concrete_bag/attack(mob/user)
	if(!opened)
		return
	..()
