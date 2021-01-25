/obj/effect/decal/cleanable/food/salt/Crossed(atom/movable/O)
	..()
	if(issquidperson(O))
		var/mob/living/carbon/human/H = O
		if(H.movement_type & FLYING)
			return
		H.adjustFireLoss(2, TRUE)
		H.reagents.add_reagent(/datum/reagent/consumable/sodiumchloride, 5)
		playsound(H, 'sound/weapons/sear.ogg', 50, TRUE)
		to_chat(H, "<span class='userdanger'>[src] burns you!</span>")
