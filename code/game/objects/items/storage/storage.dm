#define DO_HOLDABLE_SELF	3 SECONDS
#define DO_HOLDABLE_OTHER	5 SECONDS

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

/obj/item/storage/MouseDrop_T(mob/living/dropping, mob/living/user)
	. = ..()
	var/datum/component/storage/ST = GetComponent(/datum/component/storage)

	if(HAS_TRAIT(dropping, TRAIT_HOLDABLE))
		//Doing as much checks as possible before calling mob_to_item()
		if(!Adjacent(user) || !Adjacent(dropping))
			return
		if(dropping == user)
			//Self-Bagging procedure
			dropping.visible_message("<span class='notice'>[dropping] starts to crawl into [src]...</span>", "<span class='notice'>You start crawling into [src]...</span>")
			if(!do_after(dropping, DO_HOLDABLE_SELF, TRUE, src))
				return
		else
			//Third-party bagging procedure
			if(user.pulling != dropping)
				return
			user.visible_message("<span class='notice'>[user] starts to put [dropping] into [src]...</span>", "<span class='notice'>You start stuffing [dropping] into [src]...</span>")
			if(!do_after(user, DO_HOLDABLE_OTHER, TRUE, src) || !Adjacent(dropping))
				return
		var/obj/item/clothing/head/mob_holder/holder = dropping.mob_to_item() //At this point a mob is being held in a container item.
		if(!ST.can_be_inserted(holder, FALSE, dropping))
			holder.release(FALSE)
			return
		holder.forceMove(src)
		ST.signal_insertion_attempt(ST, holder, dropping)
		to_chat(dropping, "<span class='notice'>You have been tucked away into [src].</span>")
		return

/obj/item/storage/relay_container_resist_act(mob/living/user, obj/container)
	var/datum/component/storage/ST = GetComponent(/datum/component/storage)
	if(istype(container, /obj/item/clothing/head/mob_holder))
		var/obj/item/clothing/head/mob_holder/holder = container
		ST.remove_from_storage(holder, get_turf(src))
		src.visible_message("<span class='warning'>[user] suddenly pops out from [src]!</span>")
		holder.release(FALSE)
