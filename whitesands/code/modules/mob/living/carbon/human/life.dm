/mob/living/carbon/human/proc/handle_fractures()
	//this whole thing is hacky and WILL NOT work right with multiple hands
	//you've been warned
	var/obj/item/bodypart/L = get_bodypart("l_arm")
	var/obj/item/bodypart/R = get_bodypart("r_arm")

	if(istype(L) && L.bone_status == BONE_FLAG_BROKEN && held_items[1] && prob(30))
		emote("scream")
		visible_message("<span class='warning'>[src] screams and lets go of [held_items[1]] in pain.</span>", "<span class='userdanger'>A horrible pain in your [parse_zone(L)] makes it impossible to hold [held_items[1]]!</span>")
		dropItemToGround(held_items[1])

	if(istype(R) && R.bone_status == BONE_FLAG_BROKEN && held_items[2] && prob(30))
		emote("scream")
		visible_message("<span class='warning'>[src] screams and lets go of [held_items[2]] in pain.</span>", "<span class='userdanger'>A horrible pain in your [parse_zone(R)] makes it impossible to hold [held_items[2]]!</span>")
		dropItemToGround(held_items[2])

