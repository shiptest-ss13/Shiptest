/obj/structure/anvil
	name = "anvil"
	desc = "An object with the intent to hammer metal against. One of the most important parts for forging an item."
	icon = 'icons/obj/forge_structures.dmi'
	icon_state = "anvil_empty"

	anchored = TRUE
	density = TRUE

/obj/structure/anvil/Initialize()
	. = ..()

/obj/structure/anvil/attackby(obj/item/I, mob/living/user, params)
	var/obj/item/forging/incomplete/search_incomplete_src = locate(/obj/item/forging/incomplete) in contents
	if(istype(I, /obj/item/forging/hammer) && search_incomplete_src)
		playsound(src, 'sound/misc/forge.ogg', 50, TRUE)
		if(COOLDOWN_FINISHED(search_incomplete_src, heating_remainder))
			to_chat(user, "<span class='warning'>You mess up, the metal was too cool!</span>")
			search_incomplete_src.times_hit -= 3
			return TRUE
		if(COOLDOWN_FINISHED(search_incomplete_src, striking_cooldown))
			var/skill_modifier = user.mind.get_skill_modifier(/datum/skill/smithing, SKILL_SPEED_MODIFIER) * search_incomplete_src.average_wait
			COOLDOWN_START(search_incomplete_src, striking_cooldown, skill_modifier)
			search_incomplete_src.times_hit++
			to_chat(user, "<span class='notice'>good hit!</span>") //ReplaceWithBalloonAlertLater
			user.mind.adjust_experience(/datum/skill/smithing, 1) //A good hit gives minimal experience
			if(search_incomplete_src?.times_hit >= search_incomplete_src.average_hits)
				to_chat(user, "<span class='notice'>The metal is sounding ready.</span>")
			return TRUE
		search_incomplete_src.times_hit -= 3
		to_chat(user, "<span class='notice'>bad hit!</span>") //ReplaceWithBalloonAlertLater
		if(search_incomplete_src?.times_hit <= -(search_incomplete_src.average_hits))
			to_chat(user, "<span class='warning'>The hits were too inconsistent-- the metal breaks!</span>")
			icon_state = "anvil_empty"
			qdel(search_incomplete_src)
		return TRUE

	if(istype(I, /obj/item/forging/tongs))
		var/obj/item/forging/forge_item = I
		if(forge_item.in_use)
			to_chat(user, "<span class='warning'>You cannot do multiple things at the same time!</span>")
			return
		var/obj/item/forging/incomplete/search_incomplete_item = locate(/obj/item/forging/incomplete) in I.contents
		if(search_incomplete_src && !search_incomplete_item)
			search_incomplete_src.forceMove(I)
			icon_state = "anvil_empty"
			I.icon_state = "tong_full"
			return TRUE
		if(!search_incomplete_src && search_incomplete_item)
			search_incomplete_item.forceMove(src)
			icon_state = "anvil_full"
			I.icon_state = "tong_empty"
		return TRUE

	if(I.tool_behaviour == TOOL_WRENCH)
		new /obj/item/stack/sheet/metal/ten(get_turf(src))
		qdel(src)
		return

	return ..()