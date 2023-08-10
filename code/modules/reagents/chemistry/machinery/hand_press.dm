/obj/machinery/hand_press
	name = "\improper Pill Press"
	desc = "A press operated by hand to produce pills in a variety of forms."
	icon = 'icons/obj/kitchen.dmi'
	icon_state = "juicer1"
	pass_flags = PASSTABLE
	layer = BELOW_OBJ_LAYER
	resistance_flags = FIRE_PROOF | ACID_PROOF


	var/obj/item/reagent_containers/beaker = null
	var/obj/item/storage/pill_bottle/bottle = null
	var/chosenPillStyle = 1
	var/list/pillStyles = null
	var/min_volume = 5
	var/max_volume = 50
	var/current_volume = 10

/obj/machinery/hand_press/Initialize()
	. = ..()
	beaker = new /obj/item/reagent_containers/glass/beaker/large(src)

/obj/machinery/hand_press/attackby(obj/item/I, mob/living/user, params)
	if(default_unfasten_wrench(user, I))
		return
	//shamelessly yoinked from reagentgrinder.dm
	if (istype(I, /obj/item/reagent_containers) && !(I.item_flags & ABSTRACT) && I.is_open_container())
		var/obj/item/reagent_containers/B = I
		. = TRUE //no afterattack
		if(!user.transferItemToLoc(B, src))
			return
		replace_beaker(user, B)
		to_chat(user, "<span class='notice'>You add [B] to [src].</span>")
		update_icon()
		return TRUE //no afterattack
	//combine with a shameless yoink from chem_master.dm
	else if(istype(I, /obj/item/storage/pill_bottle))
		if(bottle)
			to_chat(user, "<span class='warning'>A pill bottle is already loaded into [src]!</span>")
			return
		if(!user.transferItemToLoc(I, src))
			return
		bottle = I
		to_chat(user, "<span class='notice'>You add [I] into the dispenser slot.</span>")

/obj/machinery/hand_press/proc/replace_beaker(mob/living/user, obj/item/reagent_containers/new_beaker)
	if(!user || !can_interact(user))
		return FALSE
	if(beaker)
		if(Adjacent(src, user) && !issiliconoradminghost(user))
			user.put_in_hands(beaker)
		else
			beaker.forceMove(get_turf(src))
		beaker = null
	if(new_beaker)
		beaker = new_beaker
	update_icon()
	return TRUE
