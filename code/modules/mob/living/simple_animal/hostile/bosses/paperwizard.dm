//fancy effects
/obj/effect/temp_visual/paper_scatter
	name = "scattering paper"
	desc = "Pieces of paper scattering to the wind."
	layer = ABOVE_OPEN_TURF_LAYER
	icon = 'icons/effects/effects.dmi'
	icon_state = "paper_scatter"
	anchored = TRUE
	duration = 5
	randomdir = FALSE

/obj/effect/temp_visual/paperwiz_dying
	name = "craft portal"
	desc = "A wormhole sucking the wizard into the void. Neat."
	layer = ABOVE_OPEN_TURF_LAYER
	icon = 'icons/effects/effects.dmi'
	icon_state = "paperwiz_poof"
	anchored = TRUE
	duration = 18
	randomdir = FALSE

/obj/effect/temp_visual/paperwiz_dying/Initialize()
	. = ..()
	visible_message("<span class='boldannounce'>The wizard cries out in pain as a gate appears behind him, sucking him in!</span>")
	playsound(get_turf(src),'sound/magic/mandswap.ogg', 50, TRUE, TRUE)
	playsound(get_turf(src),'sound/hallucinations/wail.ogg', 50, TRUE, TRUE)

/obj/effect/temp_visual/paperwiz_dying/Destroy()
	for(var/mob/M in range(7,src))
		shake_camera(M, 7, 1)
	var/turf/T = get_turf(src)
	playsound(T,'sound/magic/summon_magic.ogg', 50, TRUE, TRUE)
	new /obj/effect/temp_visual/paper_scatter(T)
	new /obj/item/clothing/suit/wizrobe/paper(T)
	new /obj/item/clothing/head/collectable/paper(T)
	return ..()
