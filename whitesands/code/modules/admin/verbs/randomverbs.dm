/datum/admins/proc/gift(mob/living/carbon/human/target as mob, object as text)
	set name = "Gift"
	set category = "Fun"
	set desc = "Give a mob an item directly."
	if(!check_rights(R_ADMIN) || !check_rights(R_FUN))
		return

	var/obj/item/chosen = pick_closest_path(object, make_types_fancy(subtypesof(/obj/item)))
	if(!chosen || QDELETED(target))
		return

	if(!ishuman(target))
		to_chat(usr, "This can only be used on instances of type /mob/living/carbon/human.", confidential = TRUE)
		return
	var/mob/living/carbon/human/H = target
	if(H.recieve_gift(chosen))
		log_admin("[key_name(H)] got their [initial(chosen.name)], spawned by [key_name(usr)].")
		message_admins("[key_name(H)] got their [initial(chosen.name)], spawned by [key_name_admin(usr)].")
	else
		log_admin("[key_name(H)] has their hands full, so they did not receive their [initial(chosen.name)], spawned by [key_name(usr)].")
		message_admins("[key_name(H)] has their hands full, so they did not receive their [initial(chosen.name)], spawned by [key_name_admin(usr)].")

/mob/living/carbon/human/proc/recieve_gift(obj/item/present, prompted = TRUE)
	var/obj/item/I = new present(src)
	if(put_in_hands(I))
		update_inv_hands()
		if(prompted)
			to_chat(src, "<span class='adminnotice'>Your prayers have been answered!! You received the <b>best [I.name]!</b></span>", confidential = TRUE)
			SEND_SOUND(src, sound('sound/effects/pray_chaplain.ogg'))
		return TRUE
	else
		qdel(I)
		return FALSE
