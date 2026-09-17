/obj/item/storage/wall_firstaid
	name = "first-aid kit"
	icon = 'icons/obj/storage/wallmounts.dmi'
	icon_state = "wall_aid_kit"
	desc = "A wall mounted first aid kit. For incident response on the spot."
	force = 8
	w_class = WEIGHT_CLASS_GIGANTIC
	anchored = TRUE
	density = FALSE

/obj/item/storage/wall_firstaid/examine(mob/user)
	. = ..()
	. += span_notice("You could remove this with a wrench...")

/obj/item/storage/wall_firstaid/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_w_class = WEIGHT_CLASS_NORMAL //holds the same equipment as a medibelt
	STR.max_items = 8
	STR.max_combined_w_class = 24
	STR.use_sound = 'sound/items/storage/briefcase.ogg'

/obj/item/storage/wall_firstaid/PopulateContents()
	var/static/items_inside = list(
		/obj/item/stack/medical/gauze = 1,
		/obj/item/stack/medical/suture = 2,
		/obj/item/stack/medical/mesh = 2,
		/obj/item/reagent_containers/hypospray/medipen = 1,
		/obj/item/healthanalyzer = 1,
	)
	generate_items_inside(items_inside,src)

/obj/item/storage/wall_firstaid/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	return attack_self(user)

/obj/item/storage/wall_firstaid/wrench_act(mob/living/user, obj/item/I, list/modifiers)
	. = ..()
	if(user.a_intent == INTENT_HARM)
		to_chat(user, span_notice("You start removing [src] from the wall.."))
		I.play_tool_sound(src)
		if(do_after(user, 5 SECONDS, src))
			var/obj/item/storage/firstaid/new_kit = new /obj/item/storage/firstaid(loc)
			for(var/obj/thingie in contents)
				thingie.forceMove(new_kit)
			qdel(src)

MAPPING_DIRECTIONAL_HELPERS(/obj/item/storage/wall_firstaid, 27)
