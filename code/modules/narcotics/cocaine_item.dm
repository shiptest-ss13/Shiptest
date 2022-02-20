/obj/item/reagent_containers/cocaine
	name = "cocaine"
	desc = "Ooooh, that smell... Can't you smell that smell?"
	icon = 'icons/obj/narcotics.dmi'
	icon_state = "cocaine"
	volume = 5
	possible_transfer_amounts = list()
	list_reagents = list(/datum/reagent/drug/cocaine = 5)

/obj/item/reagent_containers/cocaine/attack(mob/target, mob/user)
	if(target == user)
		user.visible_message("<span class='notice'>[user] starts snorting the [src].</span>")
		if(do_after(user, 30))
			to_chat(user, "<span class='notice'>You finish snorting the [src].</span>")
			if(reagents.total_volume)
				reagents.trans_to(target, reagents.total_volume, method = INGEST)
			qdel(src)

/obj/item/reagent_containers/cocainebrick
	name = "cocaine brick"
	desc = "A brick of cocaine."
	icon = 'icons/obj/narcotics.dmi'
	icon_state = "cocainebrick"
	volume = 25
	possible_transfer_amounts = list()
	list_reagents = list(/datum/reagent/drug/cocaine = 25)


/obj/item/reagent_containers/cocainebrick/attack_self(mob/user)
	user.visible_message("<span class='notice'>[user] starts breaking up the [src].</span>")
	if(do_after(user,10))
		to_chat(user, "<span class='notice'>You finish breaking up the [src].</span>")
		for(var/i = 1 to 5)
			new /obj/item/reagent_containers/cocaine(user.loc)
		qdel(src)

//crafting recipe
/datum/crafting_recipe/cocainebrick
	name = "Cocaine brick"
	result = /obj/item/reagent_containers/cocainebrick
	reqs = list(/obj/item/reagent_containers/cocaine = 5)
	parts = list(/obj/item/reagent_containers/cocaine = 5)
	time = 20
	category = CAT_DRUGS

//cargo export shit
/datum/export/cocaine
	cost = 200
	unit_name = "cocaine"
	export_types = list(/obj/item/reagent_containers/cocaine)
	include_subtypes = FALSE

/datum/export/cocainebrick
	cost = 1000
	unit_name = "cocaine brick"
	export_types = list(/obj/item/reagent_containers/cocainebrick)
	include_subtypes = FALSE
