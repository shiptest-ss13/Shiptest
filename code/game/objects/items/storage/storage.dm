/obj/item/storage
	name = "storage"
	icon = 'icons/obj/storage.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	var/rummage_if_nodrop = TRUE
	var/component_type = /datum/component/storage/concrete

/obj/item/storage/get_dumping_location(obj/item/storage/source,mob/user)
	return src

/obj/item/storage/Initialize()
	. = ..()
	PopulateContents()

/obj/item/storage/ComponentInitialize()
	AddComponent(component_type)

/obj/item/storage/AllowDrop()
	return FALSE

/obj/item/storage/contents_explosion(severity, target)
	for(var/atom/A in contents)
		switch(severity)
			if(EXPLODE_DEVASTATE)
				SSexplosions.highobj += A
			if(EXPLODE_HEAVY)
				SSexplosions.medobj += A
			if(EXPLODE_LIGHT)
				SSexplosions.lowobj += A

/obj/item/storage/canStrip(mob/who)
	. = ..()
	if(!. && rummage_if_nodrop)
		return TRUE

/obj/item/storage/doStrip(mob/who)
	if(HAS_TRAIT(src, TRAIT_NODROP) && rummage_if_nodrop)
		var/datum/component/storage/CP = GetComponent(/datum/component/storage)
		CP.do_quick_empty()
		return TRUE
	return ..()

/obj/item/storage/contents_explosion(severity, target)
//Cyberboss says: "USE THIS TO FILL IT, NOT INITIALIZE OR NEW"

/obj/item/storage/proc/PopulateContents()

/obj/item/storage/proc/emptyStorage()
	var/datum/component/storage/ST = GetComponent(/datum/component/storage)
	ST.do_quick_empty()

/obj/item/storage/on_object_saved(var/depth = 0)
	if(depth >= 10)
		return ""
	var/dat = ""
	for(var/obj/item in contents)
		var/metadata = generate_tgm_metadata(item)
		dat += "[dat ? ",\n" : ""][item.type][metadata]"
		//Save the contents of things inside the things inside us, EG saving the contents of bags inside lockers
		var/custom_data = item.on_object_saved(depth++)
		dat += "[custom_data ? ",\n[custom_data]" : ""]"
	return dat

/obj/item/storage/MouseDrop_T(mob/living/M, mob/living/user)
	. = ..()
	if(HAS_TRAIT(M, TRAIT_HOLDABLE))
		var/obj/item/clothing/head/mob_holder/holder = M.mob_to_item()
		var/datum/component/storage/ST = GetComponent(/datum/component/storage)
		if(!ST.can_be_inserted(holder, FALSE, M) || !Adjacent(M))
			holder.release(FALSE)
			return
		M.visible_message("<span class='notice'>[M] starts to crawl into [src]...</span>", "<span class='notice'>You start crawling into [src]...</span>")
		if(!do_after(M, 30, TRUE, src))
			holder.release()
			return
		holder.forceMove(src)
		ST.signal_insertion_attempt(ST, holder, M)
		to_chat(M, "<span class='notice'>You have tucked yourself away into [src].</span>")

/obj/item/storage/relay_container_resist_act(mob/living/user, obj/O)
	var/datum/component/storage/ST = GetComponent(/datum/component/storage)
	if(istype(O, /obj/item/clothing/head/mob_holder))
		var/obj/item/clothing/head/mob_holder/holder = O
		ST.remove_from_storage(holder, get_turf(src))
		src.visible_message("<span class='warning'>[user] suddenly pops out from [src]!</span>")
		holder.release(FALSE)
