/datum/action/changeling/transform
	name = "Transform"
	desc = "We take on the appearance and voice of one we have absorbed. Costs 5 chemicals."
	button_icon_state = "transform"
	chemical_cost = 5
	dna_cost = 0
	req_dna = 1
	req_human = 1

/datum/antagonist/changeling/proc/transform(mob/living/carbon/human/user, datum/changelingprofile/chosen_prof)
	var/datum/dna/chosen_dna = chosen_prof.dna
	user.real_name = chosen_prof.name
	user.generic_adjective = chosen_prof.generic_adjective
	user.underwear = chosen_prof.underwear
	user.underwear_color = chosen_prof.underwear_color
	user.undershirt = chosen_prof.undershirt
	user.undershirt_color = chosen_prof.undershirt_color
	user.age = chosen_prof.age
	user.socks = chosen_prof.socks
	user.socks_color = chosen_prof.socks_color

	chosen_dna.transfer_identity(user, 1)
	user.updateappearance(mutcolor_update=1)

	///Bodypart data hack. Will rewrite when I rewrite changelings soon-ish
	for(var/obj/item/bodypart/BP as anything in user.bodyparts)
		if(IS_ORGANIC_LIMB(BP))
			BP.update_limb(is_creating = TRUE)

	user.domutcheck()

	//vars hackery. not pretty, but better than the alternative.
	for(var/slot in GLOB.slots)
		if(istype(user.vars[slot], GLOB.slot2type[slot]) && !(chosen_prof.exists_list[slot])) //remove unnecessary flesh items
			qdel(user.vars[slot])
			continue

		if((user.vars[slot] && !istype(user.vars[slot], GLOB.slot2type[slot])) || !(chosen_prof.exists_list[slot]))
			continue

		if(istype(user.vars[slot], GLOB.slot2type[slot]) && slot == "wear_id") //always remove old flesh IDs, so they get properly updated
			qdel(user.vars[slot])

		var/obj/item/C
		var/equip = 0
		if(!user.vars[slot])
			var/thetype = GLOB.slot2type[slot]
			equip = 1
			C = new thetype(user)

		else if(istype(user.vars[slot], GLOB.slot2type[slot]))
			C = user.vars[slot]

		C.appearance = chosen_prof.appearance_list[slot]
		C.name = chosen_prof.name_list[slot]
		C.flags_cover = chosen_prof.flags_cover_list[slot]
		C.item_state = chosen_prof.item_state_list[slot]
		C.mob_overlay_icon = chosen_prof.mob_overlay_icon_list[slot]
		C.mob_overlay_state = chosen_prof.mob_overlay_state_list[slot] //WS EDIT - Mob Overlay State

		if(istype(C, /obj/item/changeling/id) && chosen_prof.id_icon)
			var/obj/item/changeling/id/flesh_id = C
			flesh_id.hud_icon = chosen_prof.id_icon

		if(equip)
			user.equip_to_slot_or_del(C, GLOB.slot2slot[slot])
			if(!QDELETED(C))
				ADD_TRAIT(C, TRAIT_NODROP, CHANGELING_TRAIT)

	user.regenerate_icons()
	current_profile = chosen_prof

/obj/item/clothing/glasses/changeling
	name = "flesh"
	item_flags = DROPDEL

//ATTACK HAND IGNORING PARENT RETURN VALUE
/obj/item/clothing/glasses/changeling/attack_hand(mob/user)
	if(loc == user && user.mind && user.mind.has_antag_datum(/datum/antagonist/changeling))
		to_chat(user, span_notice("You reabsorb [src] into your body."))
		qdel(src)
		return
	. = ..()

/obj/item/clothing/under/changeling
	name = "flesh"
	item_flags = DROPDEL

//ATTACK HAND IGNORING PARENT RETURN VALUE
/obj/item/clothing/under/changeling/attack_hand(mob/user)
	if(loc == user && user.mind && user.mind.has_antag_datum(/datum/antagonist/changeling))
		to_chat(user, span_notice("You reabsorb [src] into your body."))
		qdel(src)
		return
	. = ..()

/obj/item/clothing/suit/changeling
	name = "flesh"
	allowed = list(/obj/item/changeling)
	item_flags = DROPDEL

//ATTACK HAND IGNORING PARENT RETURN VALUE
/obj/item/clothing/suit/changeling/attack_hand(mob/user)
	if(loc == user && user.mind && user.mind.has_antag_datum(/datum/antagonist/changeling))
		to_chat(user, span_notice("You reabsorb [src] into your body."))
		qdel(src)
		return
	. = ..()

/obj/item/clothing/head/changeling
	name = "flesh"
	item_flags = DROPDEL

//ATTACK HAND IGNORING PARENT RETURN VALUE
/obj/item/clothing/head/changeling/attack_hand(mob/user)
	if(loc == user && user.mind && user.mind.has_antag_datum(/datum/antagonist/changeling))
		to_chat(user, span_notice("You reabsorb [src] into your body."))
		qdel(src)
		return
	. = ..()

/obj/item/clothing/shoes/changeling
	name = "flesh"
	item_flags = DROPDEL

//ATTACK HAND IGNORING PARENT RETURN VALUE
/obj/item/clothing/shoes/changeling/attack_hand(mob/user)
	if(loc == user && user.mind && user.mind.has_antag_datum(/datum/antagonist/changeling))
		to_chat(user, span_notice("You reabsorb [src] into your body."))
		qdel(src)
		return
	. = ..()

/obj/item/clothing/gloves/changeling
	name = "flesh"
	item_flags = DROPDEL

//ATTACK HAND IGNORING PARENT RETURN VALUE
/obj/item/clothing/gloves/changeling/attack_hand(mob/user)
	if(loc == user && user.mind && user.mind.has_antag_datum(/datum/antagonist/changeling))
		to_chat(user, span_notice("You reabsorb [src] into your body."))
		qdel(src)
		return
	. = ..()

/obj/item/clothing/mask/changeling
	name = "flesh"
	item_flags = DROPDEL

//ATTACK HAND IGNORING PARENT RETURN VALUE
/obj/item/clothing/mask/changeling/attack_hand(mob/user)
	if(loc == user && user.mind && user.mind.has_antag_datum(/datum/antagonist/changeling))
		to_chat(user, span_notice("You reabsorb [src] into your body."))
		qdel(src)
		return
	. = ..()

/obj/item/changeling
	name = "flesh"
	slot_flags = ALL
	allowed = list(/obj/item/changeling)
	item_flags = DROPDEL

//ATTACK HAND IGNORING PARENT RETURN VALUE
/obj/item/changeling/attack_hand(mob/user)
	if(loc == user && user.mind && user.mind.has_antag_datum(/datum/antagonist/changeling))
		to_chat(user, span_notice("You reabsorb [src] into your body."))
		qdel(src)
		return
	. = ..()

/obj/item/changeling/id
	slot_flags = ITEM_SLOT_ID
	/// Cached flat icon of the ID
	var/icon/cached_flat_icon
	/// HUD job icon of the ID
	var/hud_icon

/obj/item/changeling/id/equipped(mob/user, slot, initial)
	. = ..()
	if(hud_icon)
		var/image/holder = user.hud_list[ID_HUD]
		var/icon/I = icon(user.icon, user.icon_state, user.dir)
		holder.pixel_y = I.Height() - world.icon_size
		holder.icon_state = hud_icon

/**
 * Returns cached flat icon of the ID, creates one if there is not one already cached
 */
/obj/item/changeling/id/proc/get_cached_flat_icon()
	if(!cached_flat_icon)
		cached_flat_icon = getFlatIcon(src)
	return cached_flat_icon

/obj/item/changeling/id/get_examine_string(mob/user, thats = FALSE)
	return "[icon2html(get_cached_flat_icon(), user)] [thats? "That's ":""][get_examine_name(user)]" //displays all overlays in chat

//Change our DNA to that of somebody we've absorbed.
/datum/action/changeling/transform/sting_action(mob/living/carbon/human/user)
	var/datum/antagonist/changeling/changeling = user.mind.has_antag_datum(/datum/antagonist/changeling)
	var/datum/changelingprofile/chosen_prof = changeling.select_dna()

	if(!chosen_prof)
		return
	..()
	changeling.transform(user, chosen_prof)
	return TRUE

/**
 * Gives a changeling a list of all possible dnas in their profiles to choose from and returns profile containing their chosen dna
 */
/datum/antagonist/changeling/proc/select_dna()
	var/mob/living/carbon/user = owner.current
	if(!istype(user))
		return

	var/list/disguises = list("Drop Flesh Disguise" = image(icon = 'icons/hud/radial.dmi', icon_state = "radial_drop"))
	for(var/datum/changelingprofile/current_profile in stored_profiles)
		var/datum/icon_snapshot/snap = current_profile.profile_snapshot
		var/image/disguise_image = image(icon = snap.icon, icon_state = snap.icon_state)
		disguise_image.overlays = snap.overlays
		disguises[current_profile.name] = disguise_image

	var/chosen_name = show_radial_menu(user, user, disguises, custom_check = CALLBACK(src, .proc/check_menu, user), radius = 40, require_near = TRUE, tooltips = TRUE)
	if(!chosen_name)
		return

	if(chosen_name == "Drop Flesh Disguise")
		for(var/slot in GLOB.slots)
			if(istype(user.vars[slot], GLOB.slot2type[slot]))
				qdel(user.vars[slot])
		return
	var/datum/changelingprofile/prof = get_dna(chosen_name)
	return prof


/**
 * Checks if we are allowed to interact with a radial menu
 *
 * Arguments:
 * * user The carbon mob interacting with the menu
 */
/datum/antagonist/changeling/proc/check_menu(mob/living/carbon/user)
	if(!istype(user))
		return FALSE
	var/datum/antagonist/changeling/changeling_datum = user.mind.has_antag_datum(/datum/antagonist/changeling)
	if(!changeling_datum)
		return FALSE
	return TRUE
