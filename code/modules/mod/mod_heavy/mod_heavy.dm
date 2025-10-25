/obj/power_armor
	name = "power armor"
	desc = "tell a coder if you see this"

	density = TRUE
	move_force = MOVE_FORCE_VERY_STRONG
	move_resist = MOVE_FORCE_EXTREMELY_STRONG

	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
























//Let's get into the power armor (or not)
/obj/item/clothing/suit/space/hardsuit/power_armor/AltClick(mob/living/carbon/human/user)
	if(!istype(user))
		return FALSE
	else
		if(user.wear_suit == src)
			to_chat(user, "You begin exiting the [src].")
			if(do_after(user, 1 SECONDS, user, IGNORE_INCAPACITATED) && !density && (get_dist(user, src) <= 1))
				GetOutside(user)
				return TRUE
			return FALSE

	if(!CheckEquippedClothing(user) || get_dist(user, src) > 1 || linked_to)
		return FALSE

	to_chat(user, "You begin entering the [src].")
	if(do_after(user, 1 SECONDS, user) && CheckEquippedClothing(user) && density)
		GetInside(user)
		return TRUE
	return FALSE

//A proc that checks if the user is already wearing clothing that obstructs the equipping of the power armor
/obj/item/clothing/suit/space/hardsuit/power_armor/proc/CheckEquippedClothing(mob/living/carbon/human/user)
	// No helmets, suit slot, backpacks, belts, or ear slot.
	if(helmet && user.head && (user.head != helmet) || user.wear_suit && (user.wear_suit != src) || user.back || user.belt || user.ears)
		to_chat(user, span_warning("You're unable to climb into the [src] due to already having a helmet, backpack, belt, ear accessories or outer suit equipped!"))
		return FALSE
	return TRUE

//Let's actually get into the power armor
/obj/item/clothing/suit/space/hardsuit/power_armor/proc/GetInside(mob/living/carbon/human/user)
	if(!istype(user))
		return

	//Nothing can possibly go wrong
	user.dna.species.no_equip += ITEM_SLOT_BACK
	user.dna.species.no_equip += ITEM_SLOT_BELT

	density = FALSE
	anchored = FALSE
	user.visible_message(
		span_warning("[user] enters the [src]!"),
	)
	user.forceMove(get_turf(src))
	user.equip_to_slot_if_possible(src, ITEM_SLOT_OCLOTHING)

	if(helmettype)
		ToggleHelmet()
		var/obj/item/clothing/head/helmet/space/hardsuit/power_armor/helmet2 = helmet
		if(helmet2?.radio)
			user.equip_to_slot(helmet2.radio, ITEM_SLOT_EARS)
			for(var/X in helmet2.radio.actions)
				var/datum/action/A = X
				A.Grant(user)

//Nevermind let's get out
/obj/item/clothing/suit/space/hardsuit/power_armor/proc/GetOutside(mob/living/carbon/human/user)
	user.visible_message(span_warning("[user] exits the [src]."))
	playsound(src.loc, 'sound/mecha/mechmove03.ogg', 50, TRUE)
	user.dropItemToGround(src, force = TRUE)
	density = TRUE
	anchored = TRUE
	//Nothing can possibly go wrong
	user.dna.species.no_equip -= ITEM_SLOT_BACK
	user.dna.species.no_equip -= ITEM_SLOT_BELT

	var/obj/item/clothing/head/helmet/space/hardsuit/power_armor/helmet2 = helmet
	if(helmet2?.radio)
		user.transferItemToLoc(helmet2.radio, helmet)
		for(var/X in helmet2.radio.actions)
			var/datum/action/A = X
			A.Remove(user)
