/obj/item/reagent_containers/glass/blood
	name = "blood pack"
	desc = "Contains blood used for transfusion. Must be attached to an IV drip. You could slice it open with something sharp"
	icon = 'icons/obj/bloodpack.dmi'
	icon_state = "bloodpack"
	volume = 200
	var/datum/blood_type/blood_type = null
	var/unique_blood = null
	var/labelled = 0
	var/sliced = FALSE
	fill_icon_thresholds = list(10, 20, 30, 40, 50, 60, 70, 80, 90, 100)
	spillable = FALSE

/obj/item/reagent_containers/glass/blood/Initialize()
	. = ..()
	if(blood_type != null)
		reagents.add_reagent(unique_blood ? unique_blood : /datum/reagent/blood, 200, list("viruses"=null,"blood_DNA"=null,"blood_type"=get_blood_type(blood_type),"resistances"=null,"trace_chem"=null))
		update_icon()

/obj/item/reagent_containers/glass/blood/on_reagent_change(changetype)
	if(reagents)
		var/datum/reagent/blood/B = reagents.has_reagent(/datum/reagent/blood)
		if(B && B.data && B.data["blood_type"])
			blood_type = B.data["blood_type"]
		else
			blood_type = null
	update_pack_name()
	update_icon()

/obj/item/reagent_containers/glass/blood/proc/update_pack_name()
	if(!labelled)
		if(blood_type)
			name = "blood pack[blood_type ? " ([unique_blood ? blood_type : blood_type.name])" : null]"
		else
			name = "blood pack"
		if(sliced)
			name = "sliced "+name

/obj/item/reagent_containers/glass/blood/random
	icon_state = "random_bloodpack"

/obj/item/reagent_containers/glass/blood/random/Initialize()
	icon_state = "bloodpack"
	blood_type = pick("A+", "A-", "B+", "B-", "O+", "O-", "L", "S")
	return ..()

/obj/item/reagent_containers/glass/blood/APlus
	blood_type = "A+"

/obj/item/reagent_containers/glass/blood/AMinus
	blood_type = "A-"

/obj/item/reagent_containers/glass/blood/BPlus
	blood_type = "B+"

/obj/item/reagent_containers/glass/blood/BMinus
	blood_type = "B-"

/obj/item/reagent_containers/glass/blood/OPlus
	blood_type = "O+"

/obj/item/reagent_containers/glass/blood/OMinus
	blood_type = "O-"

/obj/item/reagent_containers/glass/blood/lizard
	blood_type = "L"

/obj/item/reagent_containers/glass/blood/elzuose
	blood_type = "E"

/obj/item/reagent_containers/glass/blood/synthetic
	blood_type = "Coolant"

/obj/item/reagent_containers/glass/blood/squid
	blood_type = "S"

/obj/item/reagent_containers/glass/blood/universal
	blood_type = "U"

/obj/item/reagent_containers/glass/blood/attackby(obj/item/I, mob/user, params)
	if (istype(I, /obj/item/pen) || istype(I, /obj/item/toy/crayon))
		if(!user.is_literate())
			to_chat(user, "<span class='notice'>You scribble illegibly on the label of [src]!</span>")
			return
		var/t = stripped_input(user, "What would you like to label the blood pack?", name, null, 53)
		if(!user.canUseTopic(src, BE_CLOSE))
			return
		if(user.get_active_held_item() != I)
			return
		if(t)
			labelled = 1
			name = "blood pack ([t])"
		else
			labelled = 0
			update_pack_name()
	else if (I.get_sharpness() && !sliced)
		slice(user, I)
	else
		return ..()

/obj/item/reagent_containers/glass/blood/proc/slice(mob/user, obj/item/tool)
	sliced = TRUE
	spillable = TRUE
	user.visible_message(self_message="<span class='notice'>You slice \the [src] open with \a [tool].</span>",  message="<span class='notice'>[user] slice \the [src] open with \a [tool].</span>")
	desc = "Contains blood used for transfusion. It's sliced open."
	name = "sliced "+name

/obj/item/reagent_containers/glass/blood/is_injectable()
	if(sliced)
		return FALSE
	..()

/obj/item/reagent_containers/glass/blood/is_refillable()
	if(sliced)
		return FALSE
	..()
