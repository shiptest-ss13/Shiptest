/obj/item/reagent_containers/glass
	name = "glass"
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(5, 10, 15, 20, 25, 30, 50)
	volume = 50
	reagent_flags = OPENCONTAINER | DUNKABLE
	spillable = TRUE
	resistance_flags = ACID_PROOF


/obj/item/reagent_containers/glass/attack(mob/M, mob/user, obj/target)
	if(!istype(M))
		return

	if(!spillable)
		return

	if(!reagents || !reagents.total_volume)
		to_chat(user, span_warning("[src] is empty!"))
		return

	if(user.a_intent == INTENT_HARM)
		var/R
		M.visible_message(
			span_danger("[user] splashes the contents of [src] onto [M]!"),
			span_userdanger("[user] splashes the contents of [src] onto you!"),
		)
		if(reagents)
			for(var/datum/reagent/A in reagents.reagent_list)
				R += "[A] ([num2text(A.volume)]),"

		if(isturf(target) && reagents.reagent_list.len && thrownby)
			log_combat(thrownby, target, "splashed (thrown) [english_list(reagents.reagent_list)]")
			message_admins("[ADMIN_LOOKUPFLW(thrownby)] splashed (thrown) [english_list(reagents.reagent_list)] on [target] at [ADMIN_VERBOSEJMP(target)].")
			playsound(src, 'sound/items/glass_splash.ogg', 50, 1)

		reagents.expose(M, TOUCH)
		log_combat(user, M, "splashed", R)
		reagents.clear_reagents()
	else
		if(!canconsume(M, user))
			return

		if(M != user)
			M.visible_message(
				span_danger("[user] attempts to feed [M] something from [src]."),
				span_userdanger("[user] attempts to feed you something from [src]."),
			)
			if(!do_after(user, target = M))
				return

			if(!reagents || !reagents.total_volume)
				return // The drink might be empty after the delay, such as by spam-feeding

			M.visible_message(
				span_danger("[user] feeds [M] something from [src]."),
				span_userdanger("[user] feeds you something from [src]."),
			)
			log_combat(user, M, "fed", reagents.log_list())
		else
			to_chat(user, span_notice("You swallow a gulp of [src]."))

		addtimer(CALLBACK(reagents, TYPE_PROC_REF(/datum/reagents, trans_to), M, 5, TRUE, TRUE, FALSE, user, FALSE, INGEST), 5)
		playsound(M.loc,'sound/items/drink.ogg', rand(10,50), TRUE)

/obj/item/reagent_containers/glass/afterattack(obj/target, mob/user, proximity)
	. = ..()
	if((!proximity) || !check_allowed_items(target,target_self=1))
		return

	if(!spillable)
		return

	if(target.is_refillable()) //Something like a glass. Player probably wants to transfer TO it.
		if(!reagents.total_volume)
			to_chat(user, span_warning("[src] is empty!"))
			return

		if(target.reagents.holder_full())
			to_chat(user, span_warning("[target] is full."))
			return

		var/trans = reagents.trans_to(target, amount_per_transfer_from_this, transfered_by = user)
		to_chat(user, span_notice("You transfer [trans] unit\s of the solution to [target]."))
		playsound(src, 'sound/items/glass_transfer.ogg', 50, 1)

	else if(target.is_drainable()) //A dispenser. Transfer FROM it TO us.
		if(!target.reagents.total_volume)
			to_chat(user, span_warning("[target] is empty and can't be refilled!"))
			return

		if(reagents.holder_full())
			to_chat(user, span_warning("[src] is full."))
			return

		var/trans = target.reagents.trans_to(src, amount_per_transfer_from_this, transfered_by = user)
		to_chat(user, span_notice("You fill [src] with [trans] unit\s of the contents of [target]."))

	else if(reagents.total_volume && is_drainable())
		switch(user.a_intent)
			if(INTENT_DISARM)
				attempt_pour(target, user)
			if(INTENT_HARM)
				user.visible_message(
					span_danger("[user] splashes the contents of [src] onto [target]!"),
					span_notice("You splash the contents of [src] onto [target]."),
				)
				reagents.expose(target, TOUCH)
				reagents.clear_reagents()
				playsound(src, 'sound/items/glass_splash.ogg', 50, 1)

/obj/item/reagent_containers/glass/attackby(obj/item/I, mob/user, params)
	var/hotness = I.get_temperature()
	if(hotness && reagents)
		reagents.expose_temperature(hotness)
		to_chat(user, span_notice("You heat [name] with [I]!"))

	if(istype(I, /obj/item/food/egg)) //breaking eggs
		var/obj/item/food/egg/E = I
		if(reagents)
			if(reagents.total_volume >= reagents.maximum_volume)
				to_chat(user, span_notice("[src] is full."))
			else
				to_chat(user, span_notice("You break [E] in [src]."))
				E.reagents.trans_to(src, E.reagents.total_volume, transfered_by = user)
				qdel(E)
			return
	..()

/obj/item/reagent_containers/glass/beaker
	name = "beaker"
	desc = "A beaker. It can hold up to 50 units."
	icon = 'icons/obj/chemical/beakers.dmi'
	icon_state = "beaker"
	item_state = "beaker"
	custom_materials = list(/datum/material/glass=500)
	fill_icon_thresholds = list(1, 40, 60, 80, 100)
	can_have_cap = TRUE
	cap_icon_state = "beaker_cap"
	drop_sound = 'sound/items/handling/beaker_drop.ogg'
	pickup_sound =  'sound/items/handling/beaker_pickup.ogg'
	cap_on = TRUE

/obj/item/reagent_containers/glass/beaker/get_part_rating()
	return reagents.maximum_volume

/obj/item/reagent_containers/glass/beaker/large
	name = "large beaker"
	desc = "A large beaker. Can hold up to 100 units."
	icon_state = "beakerlarge"
	custom_materials = list(/datum/material/glass=2500)
	volume = 100
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(5,10,15,20,25,30,50,100)
	cap_icon_state = "beakerlarge_cap" //zedaedit: lids!!

/obj/item/reagent_containers/glass/beaker/plastic
	name = "x-large beaker"
	desc = "An extra-large beaker. Can hold up to 120 units."
	icon_state = "beakerwhite"
	fill_icon_state = "beakerlarge"
	custom_materials = list(/datum/material/glass=2500, /datum/material/plastic=3000)
	volume = 120
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(5,10,15,20,25,30,60,120)
	cap_icon_state = "beakerlarge_cap" //zedaedit: lids!!

/obj/item/reagent_containers/glass/beaker/meta
	name = "metamaterial beaker"
	desc = "A large beaker. Can hold up to 180 units."
	icon_state = "beakergold"
	custom_materials = list(/datum/material/glass=2500, /datum/material/plastic=3000, /datum/material/gold=1000, /datum/material/titanium=1000)
	volume = 180
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(5,10,15,20,25,30,60,120,180)
	fill_icon_thresholds = list(1, 25, 50, 75, 100)
	cap_icon_state = "beakergold_cap" //zedaedit: lids!!

/obj/item/reagent_containers/glass/beaker/noreact
	name = "cryostasis beaker"
	desc = "A cryostasis beaker that allows for chemical storage without \
		reactions. Can hold up to 50 units."
	icon_state = "beakernoreact"
	custom_materials = list(/datum/material/iron=3000)
	reagent_flags = NO_REACT
	volume = 50
	amount_per_transfer_from_this = 10
	cap_icon_state = "beakernoreact_cap" //zedaedit: lids!!

/obj/item/reagent_containers/glass/beaker/bluespace
	name = "bluespace beaker"
	desc = "A bluespace beaker, powered by experimental bluespace technology \
		and Element Cuban combined with the Compound Pete. Can hold up to \
		300 units."
	icon_state = "beakerbluespace"
	custom_materials = list(/datum/material/glass = 5000, /datum/material/plasma = 3000, /datum/material/diamond = 1000, /datum/material/bluespace = 1000)
	volume = 300
	material_flags = MATERIAL_NO_EFFECTS
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(5,10,15,20,25,30,50,100,300)
	cap_icon_state = "beakerbluespace_cap" //zedaedit: lids!!

/obj/item/reagent_containers/glass/beaker/cryoxadone
	list_reagents = list(/datum/reagent/medicine/cryoxadone = 30)

/obj/item/reagent_containers/glass/beaker/sulphuric
	list_reagents = list(/datum/reagent/toxin/acid = 50)

/obj/item/reagent_containers/glass/beaker/slime
	list_reagents = list(/datum/reagent/toxin/slimejelly = 50)

/obj/item/reagent_containers/glass/beaker/large/hadrakine
	name = "hadrakine reserve tank"
	list_reagents = list(/datum/reagent/medicine/hadrakine = 50)

/obj/item/reagent_containers/glass/beaker/large/quardexane
	name = "quardexane reserve tank"
	list_reagents = list(/datum/reagent/medicine/quardexane = 50)

/obj/item/reagent_containers/glass/beaker/large/charcoal
	name = "charcoal reserve tank"
	list_reagents = list(/datum/reagent/medicine/charcoal = 50)

/obj/item/reagent_containers/glass/beaker/large/epinephrine
	name = "epinephrine reserve tank"
	list_reagents = list(/datum/reagent/medicine/epinephrine = 50)

/obj/item/reagent_containers/glass/beaker/large/fuel
	list_reagents = list(/datum/reagent/fuel = 100)

/obj/item/reagent_containers/glass/beaker/large/napalm
	list_reagents = list(/datum/reagent/napalm = 100)
	cap_on = FALSE

/obj/item/reagent_containers/glass/beaker/synthflesh
	list_reagents = list(/datum/reagent/medicine/synthflesh = 50)

/obj/item/reagent_containers/glass/bucket
	name = "bucket"
	desc = "It's a bucket."
	icon = 'icons/obj/janitor.dmi'
	icon_state = "bucket"
	item_state = "bucket"
	lefthand_file = 'icons/mob/inhands/equipment/custodial_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/custodial_righthand.dmi'
	custom_materials = list(/datum/material/iron=200)
	w_class = WEIGHT_CLASS_NORMAL
	amount_per_transfer_from_this = 20
	possible_transfer_amounts = list(5,10,15,20,25,30,50,70)
	volume = 70
	flags_inv = HIDEHAIR
	slot_flags = ITEM_SLOT_HEAD
	resistance_flags = NONE
	armor = list("melee" = 10, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 75, "acid" = 50) //Weak melee protection, because you can wear it on your head
	slot_equipment_priority = list( \
		ITEM_SLOT_BACK, ITEM_SLOT_ID,\
		ITEM_SLOT_ICLOTHING, ITEM_SLOT_OCLOTHING,\
		ITEM_SLOT_MASK, ITEM_SLOT_HEAD, ITEM_SLOT_NECK,\
		ITEM_SLOT_FEET, ITEM_SLOT_GLOVES,\
		ITEM_SLOT_EARS, ITEM_SLOT_EYES,\
		ITEM_SLOT_BELT, ITEM_SLOT_SUITSTORE,\
		ITEM_SLOT_LPOCKET, ITEM_SLOT_RPOCKET,\
		ITEM_SLOT_DEX_STORAGE
	)

/obj/item/reagent_containers/glass/bucket/wooden
	name = "wooden bucket"
	icon_state = "woodbucket"
	item_state = "woodbucket"
	custom_materials = list(/datum/material/wood = MINERAL_MATERIAL_AMOUNT * 2)
	armor = list("melee" = 10, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 50)
	resistance_flags = FLAMMABLE

/obj/item/reagent_containers/glass/bucket/attackby(obj/O, mob/user, params)
	if(istype(O, /obj/item/mop))
		if(reagents.total_volume < 1)
			to_chat(user, span_warning("[src] is out of water!"))
		else
			reagents.trans_to(O, 5, transfered_by = user)
			to_chat(user, span_notice("You wet [O] in [src]."))
			playsound(loc, 'sound/effects/slosh.ogg', 25, TRUE)
	else if(isprox(O)) //This works with wooden buckets for now. Somewhat unintended, but maybe someone will add sprites for it soon(TM)
		to_chat(user, span_notice("You add [O] to [src]."))
		qdel(O)
		qdel(src)
		user.put_in_hands(new /obj/item/bot_assembly/cleanbot)
	else
		..()

/obj/item/reagent_containers/glass/bucket/equipped(mob/user, slot)
	..()
	if (slot == ITEM_SLOT_HEAD)
		if(reagents.total_volume)
			to_chat(user, span_userdanger("[src]'s contents spill all over you!"))
			reagents.expose(user, TOUCH)
			reagents.clear_reagents()
		reagents.flags = NONE

/obj/item/reagent_containers/glass/bucket/dropped(mob/user)
	. = ..()
	reagents.flags = initial(reagent_flags)

/obj/item/reagent_containers/glass/bucket/equip_to_best_slot(mob/M)
	if(reagents.total_volume) //If there is water in a bucket, don't quick equip it to the head
		var/index = slot_equipment_priority.Find(ITEM_SLOT_HEAD)
		slot_equipment_priority.Remove(ITEM_SLOT_HEAD)
		. = ..()
		slot_equipment_priority.Insert(index, ITEM_SLOT_HEAD)
		return
	return ..()

/obj/item/reagent_containers/glass/filter
	name = "seperatory funnel"
	desc = "A crude tool created by welding several beakers together. It would probably be useful for seperating reagents."
	icon_state = "beakerfilter"
	item_state = "beaker"
	volume = 100
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(5, 10, 15, 20, 25, 30, 50, 100)
	fill_icon_thresholds = list(1, 40, 60, 80, 100)
	can_have_cap = TRUE
	cap_icon_state = "beakerfilter_cap"
	cap_on = TRUE

/obj/item/reagent_containers/glass/filter/afterattack(obj/target, mob/user, proximity) //overrides the standard version of this, only difference is that it only transfers one chem at a time
	if((!proximity) || !check_allowed_items(target,target_self=1))
		return

	if(!spillable)
		return

	if(target.is_refillable()) //Something like a glass. Player probably wants to transfer TO it.
		if(!reagents.total_volume)
			to_chat(user, span_warning("[src] is empty!"))
			return

		if(target.reagents.holder_full())
			to_chat(user, span_warning("[target] is full."))
			return
		to_chat(user, "<span class='notice'>You begin to drain something from [src].")
		if(do_after(user, 2.5 SECONDS, target = src))
			var/trans = reagents.trans_id_to(target, reagents.get_master_reagent_id(), amount_per_transfer_from_this,)
			to_chat(user, span_notice("You filter off [trans] unit\s of the solution into [target]."))

	else if(target.is_drainable()) //A dispenser. Transfer FROM it TO us.
		if(!target.reagents.total_volume)
			to_chat(user, span_warning("[target] is empty and can't be refilled!"))
			return

		if(reagents.holder_full())
			to_chat(user, span_warning("[src] is full."))
			return

		var/trans = target.reagents.trans_to(src, amount_per_transfer_from_this, transfered_by = user)
		to_chat(user, span_notice("You fill [src] with [trans] unit\s of the contents of [target]."))

	else if(reagents.total_volume)
		switch(user.a_intent)
			if(INTENT_HELP)
				attempt_pour(target, user)
			if(INTENT_HARM)
				user.visible_message(span_danger("[user] splashes the contents of [src] onto [target]!"), \
									span_notice("You splash the contents of [src] onto [target]."))
				reagents.expose(target, TOUCH)
				reagents.clear_reagents()
				playsound(src, 'sound/items/glass_splash.ogg', 50, 1)

/obj/item/reagent_containers/glass/filter/attempt_pour(atom/target, mob/user)
	if(ismob(target) || !reagents.total_volume || !check_allowed_items(target, target_self = FALSE))
		return

	target.visible_message(span_notice("[user] attempts to pour [src] onto [target]."))
	if(!do_after(user, 2.5 SECONDS, target=target))
		return
	// reagents may have been emptied
	if(!is_drainable() || !reagents.total_volume)
		return

	var/datum/reagent/poured_reagent = reagents.get_master_reagent()
	var/amount = min(poured_reagent.volume, amount_per_transfer_from_this)

	playsound(src, 'sound/items/glass_splash.ogg', 50, 1)
	target.visible_message(span_notice("[user] pours [src] onto [target]."))

	log_combat(user, target, "poured [amount]u of [poured_reagent.name]", "in [AREACOORD(target)]")
	log_game("[key_name(user)] poured [amount]u of [poured_reagent.name] on [target] in [AREACOORD(target)].")

	// don't use trans_to, because we're not ADDING it to the object, we're just... pouring it.
	reagents.expose_single(poured_reagent, target, TOUCH, amount/poured_reagent.volume)
	reagents.remove_reagent(poured_reagent.type, amount)
