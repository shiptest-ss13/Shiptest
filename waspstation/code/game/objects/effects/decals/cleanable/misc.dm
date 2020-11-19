/obj/effect/decal/cleanable/squid_ink
	name = "squid ink"
	desc = "A puddle of slippery squid ink."
	icon = 'icons/mob/robots.dmi'
	icon_state = "floor1"
	random_icon_states = list("floor1", "floor2", "floor3", "floor4", "floor5", "floor6", "floor7")

/obj/effect/decal/cleanable/squid_ink/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/slippery, 5SECONDS, NO_SLIP_WHEN_WALKING, CALLBACK(src, .proc/AfterSlip), 3SECONDS)

/obj/effect/decal/cleanable/squid_ink/proc/AfterSlip(mob/living/M)
	M.AddComponent(/datum/component/outline)
	M.playsound_local(get_turf(src), 'sound/effects/splat.ogg', 50, 1)
	M.visible_message("<span class='warning'>[M.name] gets covered in squid ink, leaving a hideous outline around them!</span>", "<span class='warning'>You get squid ink all over yourself, it's horrible!</span>")

