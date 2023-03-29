/obj/item/slimecross/mutative
	name = "mutative extract"
	desc = "It's softly pulsing with mutagenic energy."
	effect = "mutative"
	icon_state = "mutative"

/obj/item/slimecross/mutative/Initialize()
	. = ..()
	create_reagents(10, INJECTABLE | DRAWABLE)

/obj/item/slimecross/mutative/attack_self(mob/user)
	if(!reagents.has_reagent(/datum/reagent/toxin/plasma,10))
		to_chat(user, "<span class='warning'>This extract needs to be full of plasma to activate!</span>")
		return
	reagents.remove_reagent(/datum/reagent/toxin/plasma,10)
	to_chat(user, "<span class='notice'>You squeeze the extract, and it absorbs the plasma!</span>")
	playsound(src, 'sound/effects/bubbles.ogg', 50, TRUE)
	playsound(src, 'sound/magic/fireball.ogg', 50, TRUE)
	do_effect(user)

/obj/item/slimecross/mutative/proc/do_effect(mob/user) //If, for whatever reason, you don't want to delete the extract, don't do ..()
	qdel(src)
	return

/obj/item/slimecross/mutative/rainbow
	colour = "rainbow"
	effect_desc = "Hardens into a shard of slimy crystal. Prick yourself with it to bring forth a Slime Guardian."

/obj/item/slimecross/mutative/rainbow/do_effect(mob/user)
	user.visible_message("<span class='notice'>[src] collapses in a chromatic flash, transforming into jagged crystal!</span>")
	new /obj/item/guardiancreator/slime(get_turf(user))
	..()
