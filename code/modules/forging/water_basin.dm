/obj/structure/water_basin
	name = "water basin"
	desc = "A basin full of water, ready to quench the hot metal."
	icon = 'icons/obj/forge_structures.dmi'
	icon_state = "water_basin"
	anchored = TRUE
	density = TRUE

/obj/structure/water_basin/attack_hand(mob/living/user, list/modifiers)
	. = ..()

/obj/structure/water_basin/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/forging/tongs))
		var/obj/item/forging/incomplete/search_incomplete = locate(/obj/item/forging/incomplete) in I.contents
		if(search_incomplete?.times_hit < search_incomplete.average_hits)
			to_chat(user, "<span class='warning'>You cool down the metal but it wasn't ready yet!</span>")
			COOLDOWN_RESET(search_incomplete, heating_remainder)
			playsound(src, 'sound/misc/hot_hiss.ogg', 50, TRUE)
			return
		if(search_incomplete?.times_hit >= search_incomplete.average_hits)
			to_chat(user, "<span class='notice'>You cool down the metal. It is ready.</span>")
			user.mind.adjust_experience(/datum/skill/smithing, 4) //using the water basin on a ready item gives decent experience.
			playsound(src, 'sound/misc/hot_hiss.ogg', 50, TRUE)
			var/obj/item/forging/complete/spawn_item = search_incomplete.spawn_item
			new spawn_item(get_turf(src))
			qdel(search_incomplete)
			I.icon_state = "tong_empty"
		return

	if(I.tool_behaviour == TOOL_WRENCH)
		for(var/i in 1 to 5)
			new /obj/item/stack/sheet/mineral/wood(get_turf(src))
		I.play_tool_sound(src, 50)
		qdel(src)
		return

	return ..()
