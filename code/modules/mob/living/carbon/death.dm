/mob/living/carbon/death(gibbed)
	if(stat == DEAD)
		return

	silent = FALSE
	losebreath = 0

	if(!gibbed)
		INVOKE_ASYNC(src, PROC_REF(emote), "deathgasp")
	end_metabolization(src)

	. = ..()

	for(var/T in get_traumas())
		var/datum/brain_trauma/BT = T
		BT.on_death()

	if(SSticker.mode)
		SSticker.mode.check_win() //Calls the rounds wincheck, mainly for wizard, malf, and changeling now

/mob/living/carbon/proc/inflate_gib() // Plays an animation that makes mobs appear to inflate before finally gibbing
	addtimer(CALLBACK(src, PROC_REF(gib), null, null, TRUE, TRUE), 25)
	var/matrix/M = matrix()
	M.Scale(1.8, 1.2)
	animate(src, time = 40, transform = M, easing = SINE_EASING)

/mob/living/carbon/gib(no_brain, no_organs, no_bodyparts, safe_gib = FALSE)
	if(safe_gib) // If you want to keep all the mob's items and not have them deleted
		for(var/obj/item/W in src)
			dropItemToGround(W)
			if(prob(50))
				step(W, pick(GLOB.alldirs))
	var/atom/Tsec = drop_location()
	var/amount_of_streams_to_spawn = rand(2,4)
	for(var/i in 1 to amount_of_streams_to_spawn)
		spray_blood(pick(GLOB.alldirs), rand(1,6))
	for(var/mob/M in src)
		M.forceMove(Tsec)
		visible_message(span_danger("[M] bursts out of [src]!"))
	. = ..()

/mob/living/carbon/spill_organs(no_brain, no_organs, no_bodyparts)
	var/atom/Tsec = drop_location()
	if(!no_bodyparts)
		if(no_organs)//so the organs don't get transfered inside the bodyparts we'll drop.
			for(var/X in internal_organs)
				if(no_brain || !istype(X, /obj/item/organ/brain))
					qdel(X)
		else //we're going to drop all bodyparts except chest, so the only organs that needs spilling are those inside it.
			for(var/X in internal_organs)
				var/obj/item/organ/O = X
				if(no_brain && istype(O, /obj/item/organ/brain))
					qdel(O) //so the brain isn't transfered to the head when the head drops.
					continue
				var/org_zone = check_zone(O.zone) //both groin and chest organs.
				if(org_zone == BODY_ZONE_CHEST)
					O.Remove(src)
					O.forceMove(Tsec)
					O.throw_at(get_edge_target_turf(src,pick(GLOB.alldirs)),rand(1,3),5)
	else
		for(var/X in internal_organs)
			var/obj/item/organ/I = X
			if(no_brain && istype(I, /obj/item/organ/brain))
				qdel(I)
				continue
			if(no_organs && !istype(I, /obj/item/organ/brain))
				qdel(I)
				continue
			I.Remove(src)
			I.forceMove(Tsec)
			I.throw_at(get_edge_target_turf(src,pick(GLOB.alldirs)),rand(1,3),5)


/mob/living/carbon/spread_bodyparts()
	var/obj/item/bodypart/limb
	for(var/zone in bodyparts)
		limb = bodyparts[zone]
		if(!limb)
			continue
		limb.drop_limb()
		limb.throw_at(get_edge_target_turf(src,pick(GLOB.alldirs)),rand(1,3),5)
