
/obj/item/clothing/gloves
	var/transfer_blood = 0


/obj/item/reagent_containers/glass/rag
	name = "damp rag"
	desc = "For cleaning up messes, you suppose."
	w_class = WEIGHT_CLASS_TINY
	icon = 'icons/obj/toy.dmi'
	icon_state = "rag"
	item_flags = NOBLUDGEON
	reagent_flags = OPENCONTAINER
	amount_per_transfer_from_this = 5
	possible_transfer_amounts = list()
	volume = 5
	spillable = FALSE

/obj/item/reagent_containers/glass/rag/afterattack(atom/target as obj|turf|area, mob/user,proximity)
	. = ..()
	if(!proximity)
		return
	if(iscarbon(target) && target.reagents && reagents.total_volume)
		var/mob/living/carbon/C = target
		var/reagentlist = pretty_string_from_reagent_list(reagents)
		var/log_object = "containing [reagentlist]"
		if(user.a_intent == INTENT_HARM && !C.is_mouth_covered())
			reagents.trans_to(C, reagents.total_volume, transfered_by = user, methods = INGEST)
			C.visible_message(span_danger("[user] smothers \the [C] with \the [src]!"), span_userdanger("[user] smothers you with \the [src]!"), span_hear("You hear some struggling and muffled cries of surprise."))
			log_combat(user, C, "smothered", src, log_object)
		else
			reagents.expose(C, TOUCH)
			reagents.clear_reagents()
			C.visible_message(span_notice("[user] touches \the [C] with \the [src]."))
			log_combat(user, C, "touched", src, log_object)

	else if(istype(target) && (src in user))
		target.add_overlay(GLOB.cleaning_bubbles)
		playsound(src, 'sound/misc/slip.ogg', 15, TRUE, -8)
		user.visible_message(span_notice("[user] starts to wipe down [target] with [src]!"), span_notice("You start to wipe down [target] with [src]..."))
		if(do_after(user,30, target = target))
			user.visible_message(span_notice("[user] finishes wiping off [target]!"), span_notice("You finish wiping off [target]."))
			target.wash(CLEAN_SCRUB)
		target.cut_overlay(GLOB.cleaning_bubbles)
