/obj/item/reagent_containers/syringe
	name = "syringe"
	desc = "A syringe that can hold up to 15 units."
	icon = 'icons/obj/syringe.dmi'
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	icon_state = "syringe_0"
	base_icon_state = "syringe"
	amount_per_transfer_from_this = 5
	possible_transfer_amounts = list()
	volume = 15
	var/mode = SYRINGE_DRAW
	var/busy = FALSE		// needed for delayed drawing of blood
	var/proj_piercing = 0 //does it pierce through thick clothes when shot with syringe gun
	custom_materials = list(/datum/material/iron=10, /datum/material/glass=20)
	reagent_flags = TRANSPARENT
	custom_price = 150
	sharpness = SHARP_POINTY

/obj/item/reagent_containers/syringe/Initialize()
	. = ..()
	if(list_reagents) //syringe starts in inject mode if its already got something inside
		mode = SYRINGE_INJECT
		update_appearance()

/obj/item/reagent_containers/syringe/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

/obj/item/reagent_containers/syringe/on_reagent_change(changetype)
	update_appearance()

/obj/item/reagent_containers/syringe/pickup(mob/user)
	..()
	update_appearance()

/obj/item/reagent_containers/syringe/dropped(mob/user)
	..()
	update_appearance()

/obj/item/reagent_containers/syringe/attack_self(mob/user)
	mode = !mode
	update_appearance()

//ATTACK HAND IGNORING PARENT RETURN VALUE
/obj/item/reagent_containers/syringe/attack_hand()
	. = ..()
	update_appearance()

/obj/item/reagent_containers/syringe/attack_paw(mob/user)
	return attack_hand(user)

/obj/item/reagent_containers/syringe/attackby(obj/item/I, mob/user, params)
	return

/obj/item/reagent_containers/syringe/afterattack(atom/target, mob/user , proximity)
	. = ..()
	if(busy)
		return
	if(!proximity)
		return
	if(!target.reagents)
		return

	var/mob/living/L
	if(isliving(target))
		L = target
		if(!L.can_inject(user, 1))
			return

	SEND_SIGNAL(target, COMSIG_LIVING_TRY_SYRINGE, user)

	switch(mode)
		if(SYRINGE_DRAW)

			if(reagents.total_volume >= reagents.maximum_volume)
				to_chat(user, span_notice("The syringe is full."))
				return

			if(L) //living mob
				var/drawn_amount = reagents.maximum_volume - reagents.total_volume
				if(target != user)
					target.visible_message(span_danger("[user] is trying to take a blood sample from [target]!"), \
									span_userdanger("[user] is trying to take a blood sample from you!"))
					busy = TRUE
					if(!do_after(user, target = target, extra_checks=CALLBACK(L, TYPE_PROC_REF(/mob/living, can_inject), user, TRUE)))
						busy = FALSE
						return
					if(reagents.total_volume >= reagents.maximum_volume)
						return
				busy = FALSE
				if(L.transfer_blood_to(src, drawn_amount))
					user.visible_message(span_notice("[user] takes a blood sample from [L]."))
				else
					to_chat(user, span_warning("You are unable to draw any blood from [L]!"))

			else //if not mob
				if(!target.reagents.total_volume)
					to_chat(user, span_warning("[target] is empty!"))
					return

				if(!target.is_drawable(user))
					to_chat(user, span_warning("You cannot directly remove reagents from [target]!"))
					return

				var/trans = target.reagents.trans_to(src, amount_per_transfer_from_this, transfered_by = user) // transfer from, transfer to - who cares?

				to_chat(user, span_notice("You fill [src] with [trans] units of the solution. It now contains [reagents.total_volume] units."))
			if (reagents.total_volume >= reagents.maximum_volume)
				mode=!mode
				update_appearance()

		if(SYRINGE_INJECT)
			// Always log attemped injections for admins
			var/contained = reagents.log_list()
			log_combat(user, target, "attempted to inject", src, addition="which had [contained]")

			if(!reagents.total_volume)
				to_chat(user, span_warning("[src] is empty!"))
				return

			if(!L && !target.is_injectable(user)) //only checks on non-living mobs, due to how can_inject() handles
				to_chat(user, span_warning("You cannot directly fill [target]!"))
				return

			if(target.reagents.total_volume >= target.reagents.maximum_volume)
				to_chat(user, span_notice("[target] is full."))
				return

			if(L) //living mob
				if(!L.can_inject(user, TRUE))
					return
				if(L != user)
					L.visible_message(span_danger("[user] is trying to inject [L]!"), \
											span_userdanger("[user] is trying to inject you!"))
					if(!do_after(user, target = L, extra_checks=CALLBACK(L, TYPE_PROC_REF(/mob/living, can_inject), user, TRUE)))
						return
					if(!reagents.total_volume)
						return
					if(L.reagents.total_volume >= L.reagents.maximum_volume)
						return
					L.visible_message(span_danger("[user] injects [L] with the syringe!"), \
									span_userdanger("[user] injects you with the syringe!"))

				if(L != user)
					log_combat(user, L, "injected", src, addition="which had [contained]")
				else
					L.log_message("injected themselves ([contained]) with [src.name]", LOG_ATTACK, color="orange")
			reagents.trans_to(target, amount_per_transfer_from_this, transfered_by = user, method = INJECT)
			to_chat(user, span_notice("You inject [amount_per_transfer_from_this] units of the solution. The syringe now contains [reagents.total_volume] units."))
			if (reagents.total_volume <= 0 && mode==SYRINGE_INJECT)
				mode = SYRINGE_DRAW
				update_appearance()

/obj/item/reagent_containers/syringe/update_icon_state()
	var/rounded_vol = get_rounded_vol()
	icon_state = "[base_icon_state]_[rounded_vol]"
	item_state = "[base_icon_state]_[rounded_vol]"
	return ..()

/obj/item/reagent_containers/syringe/update_overlays()
	. = ..()
	if(reagents && reagents.total_volume)
		var/mutable_appearance/filling_overlay = mutable_appearance('icons/obj/reagentfillings.dmi', "syringe[get_rounded_vol()]")
		filling_overlay.color = mix_color_from_reagents(reagents.reagent_list)
		. += filling_overlay
	if(ismob(loc))
		var/injoverlay
		switch(mode)
			if (SYRINGE_DRAW)
				injoverlay = "draw"
			if (SYRINGE_INJECT)
				injoverlay = "inject"
		. += injoverlay

///Used by update_appearance() and update_overlays()
/obj/item/reagent_containers/syringe/proc/get_rounded_vol()
	if(!reagents?.total_volume)
		return 0
	return clamp(round((reagents.total_volume / volume * 15), 5), 1, 15)

/obj/item/reagent_containers/syringe/epinephrine
	name = "syringe (epinephrine)"
	desc = "Contains epinephrine - used to stabilize patients."
	list_reagents = list(/datum/reagent/medicine/epinephrine = 15)

/obj/item/reagent_containers/syringe/charcoal
	name = "syringe (charcoal)"
	desc = "Contains charcoal."
	list_reagents = list(/datum/reagent/medicine/charcoal = 15)

/obj/item/reagent_containers/syringe/antiviral
	name = "syringe (spaceacillin)"
	desc = "Contains antiviral agents."
	list_reagents = list(/datum/reagent/medicine/spaceacillin = 15)

/obj/item/reagent_containers/syringe/bioterror
	name = "bioterror syringe"
	desc = "Contains several paralyzing reagents."
	list_reagents = list(/datum/reagent/consumable/ethanol/neurotoxin = 5, /datum/reagent/toxin/mutetoxin = 5, /datum/reagent/toxin/sodium_thiopental = 5)

/obj/item/reagent_containers/syringe/calomel
	name = "syringe (calomel)"
	desc = "Contains calomel."
	list_reagents = list(/datum/reagent/medicine/calomel = 15)

/obj/item/reagent_containers/syringe/plasma
	name = "syringe (plasma)"
	desc = "Contains plasma."
	list_reagents = list(/datum/reagent/toxin/plasma = 15)

/obj/item/reagent_containers/syringe/lethal
	name = "lethal injection syringe"
	desc = "A syringe used for lethal injections. It can hold up to 50 units."
	amount_per_transfer_from_this = 50
	volume = 50

/obj/item/reagent_containers/syringe/lethal/choral
	list_reagents = list(/datum/reagent/toxin/chloralhydrate = 50)

/obj/item/reagent_containers/syringe/lethal/execution
	list_reagents = list(/datum/reagent/toxin/plasma = 15, /datum/reagent/toxin/formaldehyde = 15, /datum/reagent/toxin/cyanide = 10, /datum/reagent/toxin/acid/fluacid = 10)

/obj/item/reagent_containers/syringe/mulligan
	name = "Mulligan"
	desc = "A syringe used to completely change the users identity."
	amount_per_transfer_from_this = 1
	volume = 1
	list_reagents = list(/datum/reagent/mulligan = 1)

/obj/item/reagent_containers/syringe/bluespace
	name = "bluespace syringe"
	desc = "An advanced syringe that can hold 60 units of chemicals."
	icon_state = "bluespace_0"
	base_icon_state = "bluespace"
	amount_per_transfer_from_this = 20
	volume = 60

/obj/item/reagent_containers/syringe/piercing
	name = "piercing syringe"
	desc = "A diamond-tipped syringe that pierces armor when launched at high velocity. It can hold up to 10 units."
	icon_state = "piercing_0"
	base_icon_state = "piercing"
	volume = 10
	proj_piercing = 1

/obj/item/reagent_containers/syringe/dexalin
	name = "syringe (dexalin)"
	desc = "Contains dexalin."
	list_reagents = list(/datum/reagent/medicine/dexalin = 15)

/obj/item/reagent_containers/syringe/ysiltane
	name = "syringe (ysiltane)"
	desc = "Contains ysiltane, used to treat severe burns."
	list_reagents = list(/datum/reagent/medicine/ysiltane = 15)

/obj/item/reagent_containers/syringe/silfrine
	name = "syringe (silfrine)"
	desc = "Contains salicylic acid, used to treat severe brute damage."
	list_reagents = list(/datum/reagent/medicine/silfrine = 15)

/obj/item/reagent_containers/syringe/penacid
	name = "syringe (pentetic acid)"
	desc = "Contains pentetic acid, used to reduce high levels of radiation and heal severe toxins."
	list_reagents = list(/datum/reagent/medicine/pen_acid = 15)

/obj/item/reagent_containers/syringe/contraband
	name = "unlabeled syringe"
	desc = "A syringe containing some sort of unknown chemical cocktail."

/obj/item/reagent_containers/syringe/contraband/space_drugs
	list_reagents = list(/datum/reagent/drug/space_drugs = 15)

/obj/item/reagent_containers/syringe/contraband/crank
	list_reagents = list(/datum/reagent/drug/crank = 15)

/obj/item/reagent_containers/syringe/contraband/methamphetamine
	list_reagents = list(/datum/reagent/drug/methamphetamine = 15)

/obj/item/reagent_containers/syringe/contraband/mammoth
	list_reagents = list(/datum/reagent/drug/mammoth = 15)

/obj/item/reagent_containers/syringe/contraband/morphine
	list_reagents = list(/datum/reagent/medicine/morphine = 15)

/obj/item/reagent_containers/syringe/pancrazine
	name = "syringe (pancrazine)"
	desc = "Contains pancrazine, used to treat toxins and purge chemicals. The tag on the syringe states 'Heat before injection'."
	list_reagents = list(/datum/reagent/medicine/pancrazine = 15)

/obj/item/reagent_containers/syringe/charcoal
	name = "syringe (charcoal)"
	desc = "Contains charcoal."
	list_reagents = list(/datum/reagent/medicine/charcoal = 15)

/obj/item/reagent_containers/syringe/stasis
	name = "syringe (stasis)"
	desc = "Contains 3 shots of Stasis, for usage in medical emergencies."
	list_reagents = list(/datum/reagent/medicine/stasis = 15)
	custom_price = 100
