/obj/item/clothing/head/wig/suicide_act(mob/living/user)
	if (ishumanbasic(user) ||  isfelinid(user) || isvampire(user))		// (Semi)non degenerates
		user.visible_message("<span class='suicide'>[user] strangles [user.p_their()] neck with \the [src]! It looks like [user.p_theyre()] trying to commit suicide!</span>")
		return OXYLOSS
	if (iszombie(user))		// No oxy damage
		user.visible_message("<span class='suicide'>[user] strangles [user.p_their()] neck with \the [src], but nothing happens!</span>")
		return SHAME
	if (isdullahan(user))		// You tried
		user.visible_message("<span class='suicide'>[user] tries to strangle [user.p_their()] neck with \the [src], but they don't have a neck! It looks like [user.p_theyre()] an idiot! </span>")
		return SHAME
	else				// Anyone left shouldn't have hair at all, and therefore vanishes in a blinding flash of light, leaving their items behind
		user.visible_message("<span class='suicide'>[user] is stitching \the [src] to [user.p_their()] head! It looks like [user.p_theyre()] trying to have hair!</span>")
		for(var/obj/item/W in user)
			user.dropItemToGround(W)
		var/turf/T = get_turf(src)
		for(var/mob/living/carbon/C in viewers(T, null))
			C.flash_act()
		new /obj/effect/dummy/lighting_obj (get_turf(src), LIGHT_COLOR_HOLY_MAGIC, 10, 4, 4)
		playsound(src, 'sound/magic/blind.ogg', 100, TRUE)
		qdel(user)
		return MANUAL_SUICIDE
