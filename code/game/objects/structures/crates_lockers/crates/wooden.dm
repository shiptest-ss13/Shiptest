/obj/structure/closet/crate/wooden
	name = "wooden crate"
	desc = "Works just as well as a metal one."
	material_drop = /obj/item/stack/sheet/mineral/wood
	material_drop_amount = 6
	icon_state = "wooden"
	open_sound = 'sound/machines/wooden_closet_open.ogg'
	close_sound = 'sound/machines/wooden_closet_close.ogg'
	open_sound_volume = 25
	close_sound_volume = 50

/obj/structure/closet/crate/wooden/toy
	name = "toy box"
	desc = "It has the words \"Clown + Mime\" written underneath of it with marker."

/obj/structure/closet/crate/wooden/toy/PopulateContents()
	. = ..()
	new	/obj/item/megaphone/clown(src)
	new	/obj/item/reagent_containers/food/drinks/soda_cans/canned_laughter(src)
	new /obj/item/pneumatic_cannon/pie(src)
	new /obj/item/reagent_containers/food/snacks/pie/cream(src)
	new /obj/item/storage/crayons(src)

/obj/structure/closet/crate/wooden/sealed
	name = "sealed wooden crate"
	desc= "crowbar it"

/obj/structure/closet/crate/wooden/sealed/attack_hand(mob/user)
	add_fingerprint(user)
	if(manifest)
		tear_manifest(user)
	else
		to_chat(user, "<span class='warning'>You need a crowbar to pry this open!</span>")

/obj/structure/closet/crate/wooden/sealed/attackby(obj/item/W, mob/user, params)
	if(W.tool_behaviour == TOOL_CROWBAR)
		if(manifest)
			tear_manifest(user)

		user.visible_message(
			"<span class='notice'>[user] pries \the [src] open.</span>", \
			"<span class='notice'>You pry open \the [src].</span>", \
			"<span class='hear'>You hear splitting wood.</span>")
		playsound(src.loc, 'sound/weapons/slashmiss.ogg', 75, TRUE)

		var/turf/T = get_turf(src)
		for(var/i in 1 to material_drop_amount)
			new material_drop(src)
		for(var/atom/movable/AM in contents)
			AM.forceMove(T)

		qdel(src)

	else
		if(user.a_intent == INTENT_HARM)	//Only return  ..() if intent is harm, otherwise return 0 or just end it.
			return ..()						//Stops it from opening and turning invisible when items are used on it.

		else
			to_chat(user, "<span class='warning'>You need a crowbar to pry this open!</span>")
			return FALSE //Just stop. Do nothing. Don't turn into an invisible sprite. Don't open like a locker.
					//The large crate has no non-attack interactions other than the crowbar, anyway.
