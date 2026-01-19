/obj/item/reagent_containers/medigel
	name = "medical gel"
	desc = "A medical gel applicator bottle, designed for precision application, with an unscrewable cap."
	icon = 'icons/obj/chemical/medicine.dmi'
	icon_state = "medigel"
	item_state = "spraycan"
	lefthand_file = 'icons/mob/inhands/equipment/hydroponics_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/hydroponics_righthand.dmi'
	item_flags = NOBLUDGEON
	obj_flags = UNIQUE_RENAME
	reagent_flags = OPENCONTAINER
	slot_flags = ITEM_SLOT_BELT
	throwforce = 0
	w_class = WEIGHT_CLASS_SMALL
	throw_speed = 3
	throw_range = 7
	amount_per_transfer_from_this = 10
	volume = 60
	custom_materials = list(/datum/material/plastic=200, /datum/material/iron=400)
	var/can_fill_from_container = TRUE
	var/apply_type = PATCH
	var/apply_method = "spray" //the thick gel is sprayed and then dries into patch like film.
	var/self_delay = 30
	var/squirt_mode = 0
	var/squirt_amount = 5
	custom_price = 350
	unique_reskin = list(
		"Blue" = "medigel_blue",
		"Cyan" = "medigel_cyan",
		"Green" = "medigel_green",
		"Red" = "medigel_red",
		"Orange" = "medigel_orange",
		"Purple" = "medigel_purple"
	)

/obj/item/reagent_containers/medigel/attack_self(mob/user)
	squirt_mode = !squirt_mode
	if(squirt_mode)
		amount_per_transfer_from_this = squirt_amount
	else
		amount_per_transfer_from_this = initial(amount_per_transfer_from_this)
	to_chat(user, span_notice("You will now apply the medigel's contents in [squirt_mode ? "short bursts":"extended sprays"]. You'll now use [amount_per_transfer_from_this] units per use."))

/obj/item/reagent_containers/medigel/attack(mob/M, mob/user, def_zone)
	if(!reagents || !reagents.total_volume)
		to_chat(user, span_warning("[src] is empty!"))
		return

	if(M == user)
		M.visible_message(span_notice("[user] attempts to [apply_method] [src] on [user.p_them()]self."))
		if(self_delay)
			if(!do_after(user, self_delay, M))
				return
			if(!reagents || !reagents.total_volume)
				return
		to_chat(M, span_notice("You [apply_method] yourself with [src]."))

	else
		log_combat(user, M, "attempted to apply", src, reagents.log_list())
		M.visible_message(span_danger("[user] attempts to [apply_method] [src] on [M]."), \
							span_userdanger("[user] attempts to [apply_method] [src] on you."))
		if(!do_after(user, target = M))
			return
		if(!reagents || !reagents.total_volume)
			return
		M.visible_message(span_danger("[user] [apply_method]s [M] down with [src]."), \
							span_userdanger("[user] [apply_method]s you down with [src]."))

	if(!reagents || !reagents.total_volume)
		return

	else
		log_combat(user, M, "applied", src, reagents.log_list())
		playsound(src, 'sound/effects/spray.ogg', 30, TRUE, -6)
		reagents.trans_to(M, amount_per_transfer_from_this, transfered_by = user, methods = apply_type)
	return

/obj/item/reagent_containers/medigel/hadrakine
	name = "medical gel (hadrakine powder)"
	desc = "A medical gel applicator bottle, designed for precision application, with an unscrewable cap. This one contains hadrakine powder, for treating cuts and bruises."
	icon_state = "brutegel"
	list_reagents = list(/datum/reagent/medicine/hadrakine = 60)

/obj/item/reagent_containers/medigel/quardexane
	name = "medical gel (quardexane)"
	desc = "A medical gel applicator bottle, designed for precision application, with an unscrewable cap. This one contains quardexane, useful for treating burns."
	icon_state = "burngel"
	list_reagents = list(/datum/reagent/medicine/quardexane = 60)

/obj/item/reagent_containers/medigel/synthflesh
	name = "medical gel (synthflesh)"
	desc = "A medical gel applicator bottle, designed for precision application, with an unscrewable cap. This one contains synthflesh, an apex brute and burn healing agent."
	icon_state = "synthgel"
	list_reagents = list(/datum/reagent/medicine/synthflesh = 60)
	custom_price = 80

/obj/item/reagent_containers/medigel/sterilizine
	name = "sterilizer gel"
	desc = "gel bottle loaded with non-toxic sterilizer. Useful in preparation for surgery."
	icon_state = "medigel_blue"
	current_skin = "Blue"
	list_reagents = list(/datum/reagent/space_cleaner/sterilizine = 60)
	custom_price = 175
