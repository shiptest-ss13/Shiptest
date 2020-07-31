/obj/effect/decal/cleanable/squid_ink
	name = "squid ink"
	desc = "A puddle of slippery squid ink."
	icon = 'icons/mob/robots.dmi'
	icon_state = "floor1"
	random_icon_states = list("floor1", "floor2", "floor3", "floor4", "floor5", "floor6", "floor7")

/obj/effect/decal/cleanable/squid_ink/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/slippery, 5SECONDS, NO_SLIP_WHEN_WALKING, CALLBACK(src, .proc/AfterSlip), 3SECONDS)

/obj/effect/decal/cleanable/squid_ink/proc/AfterSlip(mob/living/carbon/human/M)
	if(istype(M))
		for(var/obj/item/clothing/C in list(M.wear_suit, M.w_uniform, M.shoes))
			C.add_atom_colour("#32324e", WASHABLE_COLOUR_PRIORITY)
			M.playsound_local(get_turf(src), 'sound/effects/splat.ogg', 50, 1)
		M.visible_message("<span class='warning'>[M.name] gets covered in squid ink!</span>", "<span class='warning'>You get squid ink all over yourself!</span>")


