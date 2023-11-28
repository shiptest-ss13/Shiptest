/obj/machinery/lizstretcher
	name = "lizard stretcher"
	desc = "A device designed to stretch out Sarathi. Why? That's a good question."
	icon = 'icons/obj/machines/lizard_stretcher.dmi'
	icon_state = "lizstretchoff"
	max_integrity = 200
	integrity_failure = 0.33
	armor = list("melee" = 20, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 70)
	//circuit = /obj/item/circuitboard/machine/lizstretcher
	var/active = 0

/obj/machinery/lizstretcher/examine(mob/user)
	. = ..()
	if(occupant)
		. += "<span class='notice'>There's someone inside!</span>"
	else
		. += "<span class='notice'>It's currently off.</span>"

/obj/machinery/sleeper/Initialize(mapload)
	. = ..()
	occupant_typecache = GLOB.typecache_living

/obj/machinery/lizstretcher/open_machine()
	if(occupant)
		occupant.AddElement(/datum/element/squish, 0 SECONDS, TRUE, TRUE)
		ADD_TRAIT(occupant, TRAIT_STRETCHED, "lizstretcher")
		occupant.forceMove(get_turf(src))
		occupant = null

/obj/machinery/lizstretcher/MouseDrop_T(mob/target, mob/user)
	if(HAS_TRAIT(user, TRAIT_UI_BLOCKED) || !Adjacent(user) || !user.Adjacent(target) || !user.IsAdvancedToolUser() || !islizard(target))
		return
	if(HAS_TRAIT(target, TRAIT_STRETCHED))
		to_chat(target, "<span class='warning'>You've already been stretched, and don't plan on being stretched further!</span>")
		if(user != target)
			to_chat(user, "<span class='warning'>[target] refuses to go back in there!</span>")
		return

	close_machine(target)

/obj/machinery/lizstretcher/close_machine(mob/user)
	if((isnull(user) || istype(user)) && !active)
		..(user)
		var/mob/living/mob_occupant = occupant
		if(mob_occupant && mob_occupant.stat != DEAD)
			to_chat(occupant, "<span class='notice'><b>You begin to be stretched by the stretcher!</b></span>")
		active = TRUE
		icon_state = "lizstretchon"
		if(do_after(user, 30, target = src))
			to_chat(occupant, "<span class='notice'><b>You emerge from the stretcher, much taller.</b></span>")
			open_machine()
			active = FALSE
			icon_state = "lizstretchoff"
