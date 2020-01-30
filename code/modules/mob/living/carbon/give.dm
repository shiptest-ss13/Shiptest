/mob/living/carbon/verb/give(var/mob/living/carbon/target in oview(1))
	set category = "IC"
	set name = "Give"

	if(target.stat != CONSCIOUS | target.client == null)
		return // Fail silently. Don't want to give any hints.
	if(target.handcuffed)
		to_chat(usr, "<span class='warning'>[target.name] is handcuffed!</span>")
		return

	if(!iscarbon(target)) //something is bypassing the give arguments, no clue what, adding a sanity check JIC
		to_chat(usr, "<span class='danger'>Wait a second... \the [target] HAS NO HANDS! AHH!</span>")//cheesy messages ftw
		return
	var/obj/item/I = usr.get_active_held_item()
	if(I == null)
		to_chat(usr, "<span class='warning'>You don't have anything in your active hand to give to [target.name].</span>")
		return
	if(!I)
		return
	if(HAS_TRAIT(I, TRAIT_NODROP))
		to_chat(usr, "<span class='notice'>That's not something you can give.</span>")
		return
	if(target.can_put_in_hands(I))
		switch(alert(target,"[usr] wants to give you \a [I]?",,"Yes","No"))
			if("Yes")
				if(!I)
					return
				if(!Adjacent(usr))
					to_chat(usr, "<span class='warning'>You need to stay in reaching distance while giving an object.</span>")
					to_chat(target, "<span class='warning'>[usr.name] moved too far away.</span>")
					return
				if(I != usr.held_items[active_hand_index])
					to_chat(usr, "<span class='warning'>You need to keep the item in your active hand.</span>")
					to_chat(target, "<span class='warning'>[usr.name] seem to have given up on giving \the [I.name] to you.</span>")
					return
				if(!target.can_put_in_hands(I))
					to_chat(target, "<span class='warning'>Your hands are full.</span>")
					to_chat(usr, "<span class='warning'>Their hands are full.</span>")
					return
				usr.dropItemToGround(I)
				target.put_in_hands(I, FALSE)
				I.add_fingerprint(target)
				update_inv_hands()
				target.update_inv_hands()
				target.visible_message("<span class='notice'>[usr.name] handed \the [I.name] to [target.name].</span>")
			if("No")
				target.visible_message("<span class='warning'>[usr.name] tried to hand [I.name] to [target.name] but [target.name] didn't want it.</span>")
	else
		to_chat(usr, "<span class='warning'>[target.name]'s hands are full.</span>")
