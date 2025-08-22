/obj/item/reagent_containers/blood
	name = "blood pack"
	desc = "Contains blood used for transfusion. Must be attached to an IV drip."
	icon = 'icons/obj/bloodpack.dmi'
	icon_state = "bloodpack"
	possible_transfer_amounts = list(5,10,15,20,25,30,50,100,200)
	volume = 200
	reagent_flags = DRAWABLE
	var/datum/blood_type/blood_type = null
	var/unique_blood = null
	var/labelled = 0
	var/cut = FALSE
	fill_icon_thresholds = list(10, 20, 30, 40, 50, 60, 70, 80, 90, 100)

/obj/item/reagent_containers/blood/Initialize()
	. = ..()
	if(blood_type != null)
		reagents.add_reagent(unique_blood ? unique_blood : /datum/reagent/blood, 200, list("viruses"=null,"blood_DNA"=null,"blood_type"=get_blood_type(blood_type),"resistances"=null,"trace_chem"=null))
		update_appearance()

/obj/item/reagent_containers/blood/on_reagent_change(changetype)
	if(reagents)
		var/datum/reagent/blood/B = reagents.has_reagent(/datum/reagent/blood)
		if(B && B.data && B.data["blood_type"])
			blood_type = B.data["blood_type"]
		else
			blood_type = null
	update_name()
	update_appearance()

/obj/item/reagent_containers/blood/update_name(updates)
	. = ..()
	if(!labelled)
		if(blood_type)
			name = "[cut ? "cut " : null]blood pack[blood_type ? " - [unique_blood ? blood_type : blood_type.name]" : null]"
		else
			name = "[cut ? "cut " : null]blood pack"

/obj/item/reagent_containers/blood/random
	icon_state = "random_bloodpack"

/obj/item/reagent_containers/blood/random/Initialize()
	icon_state = "bloodpack"
	blood_type = pick("A+", "A-", "B+", "B-", "O+", "O-", "L", "E", "Coolant")
	return ..()

/obj/item/reagent_containers/blood/APlus
	blood_type = "A+"

/obj/item/reagent_containers/blood/AMinus
	blood_type = "A-"

/obj/item/reagent_containers/blood/BPlus
	blood_type = "B+"

/obj/item/reagent_containers/blood/BMinus
	blood_type = "B-"

/obj/item/reagent_containers/blood/OPlus
	blood_type = "O+"

/obj/item/reagent_containers/blood/OMinus
	blood_type = "O-"

/obj/item/reagent_containers/blood/lizard
	blood_type = "L"

/obj/item/reagent_containers/blood/elzuose
	blood_type = "E"

/obj/item/reagent_containers/blood/synthetic
	blood_type = "Coolant"

/obj/item/reagent_containers/blood/universal
	blood_type = "U"

/obj/item/reagent_containers/blood/attackby(obj/item/I, mob/user, params)
	if (istype(I, /obj/item/pen) || istype(I, /obj/item/toy/crayon))
		if(!user.is_literate())
			to_chat(user, span_notice("You scribble illegibly on the label of [src]!"))
			return
		var/t = stripped_input(user, "What would you like to label the blood pack?", name, null, 53)
		if(!user.canUseTopic(src, BE_CLOSE))
			return
		if(user.get_active_held_item() != I)
			return
		if(t)
			labelled = 1
			name = "[cut ? "cut " : null]blood pack - [t]"
		else
			labelled = 0
			update_name()

	if (!cut && I.get_sharpness() == SHARP_POINTY )
		visible_message(span_warning("[user], begins to slice to slice \the [name],"), span_notice("You begin the slice \the [name]."), vision_distance=COMBAT_MESSAGE_RANGE)
		if (do_after(user, 3 SECONDS, src))
			to_chat(user, span_notice("You cut \the [name] open."))
			cut = TRUE
			reagent_flags |= DRAINABLE
			reagents.flags = reagent_flags
			desc = "Contains blood used for transfusion. It's cut open."
			update_name()
			update_desc()
	else
		return ..()

/obj/item/reagent_containers/blood/afterattack(obj/target, mob/user, proximity)
	. = ..()
	if(cut && reagents.total_volume)
		if(user.a_intent == INTENT_HARM)
			user.visible_message(span_danger("[user] splashes the contents of [src] onto [target]!"), \
								span_notice("You splash the contents of [src] onto [target]."))
			reagents.expose(target, TOUCH)
			reagents.clear_reagents()
			playsound(src, 'sound/items/glass_splash.ogg', 50, 1)
		else if(target.is_refillable()) //Something like a glass. Player probably wants to transfer TO it.
			if(!reagents.total_volume)
				to_chat(user, span_warning("[src] is empty!"))
				return

			if(target.reagents.holder_full())
				to_chat(user, span_warning("[target] is full."))
				return

			var/trans = reagents.trans_to(target, amount_per_transfer_from_this, transfered_by = user)
			to_chat(user, span_notice("You transfer [trans] unit\s of the solution to [target]."))
			playsound(src, 'sound/items/glass_transfer.ogg', 50, 1)
		else
			attempt_pour(target, user)
