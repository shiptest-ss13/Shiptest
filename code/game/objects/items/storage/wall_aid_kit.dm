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
	STR.set_holdable(list(
		/obj/item/healthanalyzer,
		/obj/item/dnainjector,
		/obj/item/reagent_containers/dropper,
		/obj/item/reagent_containers/glass/beaker,
		/obj/item/reagent_containers/glass/bottle,
		/obj/item/reagent_containers/pill,
		/obj/item/reagent_containers/syringe,
		/obj/item/reagent_containers/medigel,
		/obj/item/lighter,
		/obj/item/storage/fancy/cigarettes,
		/obj/item/storage/pill_bottle,
		/obj/item/stack/medical,
		/obj/item/flashlight/pen,
		/obj/item/extinguisher/mini,
		/obj/item/reagent_containers/hypospray,
		/obj/item/sensor_device,
		/obj/item/radio,
		/obj/item/clothing/gloves/,
		/obj/item/lazarus_injector,
		/obj/item/bikehorn/rubberducky,
		/obj/item/clothing/mask/surgical,
		/obj/item/clothing/mask/breath,
		/obj/item/clothing/mask/breath/medical,
		/obj/item/scalpel,
		/obj/item/circular_saw,
		/obj/item/bonesetter,
		/obj/item/surgicaldrill,
		/obj/item/retractor,
		/obj/item/cautery,
		/obj/item/hemostat,
		/obj/item/geiger_counter,
		/obj/item/clothing/neck/stethoscope,
		/obj/item/stamp,
		/obj/item/clothing/glasses,
		/obj/item/wrench/medical,
		/obj/item/clothing/mask/muzzle,
		/obj/item/storage/bag/chemistry,
		/obj/item/storage/bag/bio,
		/obj/item/reagent_containers/blood,
		/obj/item/tank/internals/emergency_oxygen,
		/obj/item/gun/syringe/syndicate,
		/obj/item/implantcase,
		/obj/item/implant,
		/obj/item/implanter,
		/obj/item/pinpointer/crew,
		/obj/item/holosign_creator/medical,
		/obj/item/stack/sticky_tape,
		/obj/item/stack/medical/bone_gel,
	))
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
