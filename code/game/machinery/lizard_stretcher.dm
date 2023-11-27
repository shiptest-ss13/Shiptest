/obj/machinery/lizstretcher
	name = "lizard stretcher"
	desc = "A device designed to stretch out Sarathi. Why? That's a good question."
	icon = 'icons/obj/machines/lizard_stretcher.dmi'
	icon_state = "lizstretchoff"
	layer = BELOW_OBJ_LAYER
	max_integrity = 200
	integrity_failure = 0.33
	armor = list("melee" = 20, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 70)
	//circuit = /obj/item/circuitboard/machine/lizstretcher
	var/active = 0

//obj/machinery/lizstretcher/examine(mob/user)

/obj/machinery/sleeper/Initialize(mapload)
	. = ..()
	occupant_typecache = GLOB.typecache_living

/obj/machinery/lizstretcher/open_machine()
	if(occupant)
		occupant.forceMove(get_turf(src))
		if(isliving(occupant))
			var/mob/living/carbon/C = occupant
			C.AddElement(/datum/element/squish, 0 SECONDS, TRUE, TRUE, TRUE)
		occupant = null

/obj/machinery/lizstretcher/MouseDrop_T(mob/target, mob/user)
	if(HAS_TRAIT(user, TRAIT_UI_BLOCKED) || !Adjacent(user) || !user.Adjacent(target) || !user.IsAdvancedToolUser() || !islizard(target))
		return

	close_machine(target)

/obj/machinery/lizstretcher/close_machine(mob/user)
	if((isnull(user) || istype(user)) && !active)
		..(user)
		var/mob/living/mob_occupant = occupant
		if(mob_occupant && mob_occupant.stat != DEAD)
			to_chat(occupant, "<span class='notice'><b>You begin to be stretched by the stretcher!</b></span>")

	if(do_after(user, 10, target = src))
		to_chat(occupant, "<span class='notice'><b>You emerge from the stretcher, much taller.</b></span>")
		open_machine()
