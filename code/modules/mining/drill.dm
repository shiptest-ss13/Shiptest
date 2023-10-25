/obj/structure/vein
	name = "ore vein"
	icon = 'icons/obj/lavaland/terrain.dmi'
	icon_state = "geyser"
	anchored = TRUE

	var/drilled = FALSE
	var/ore_amount = 20
	var/ore_type = /obj/item/stack/ore/iron

/obj/machinery/drill
	name = "big-ass ore drill"
	desc = "It's like those drills you put in your hand but, like, way bigger."
	icon = 'icons/obj/machines/drill.dmi'
	icon_state = "deep_core_drill"
	density = TRUE
	anchored = FALSE

	var/active = FALSE
	var/obj/structure/vein/mining
	var/datum/looping_sound/drill/soundloop

/obj/machinery/drill/Initialize()
	. = ..()
	soundloop = new(list(src), active)

/obj/machinery/drill/Destroy()
	QDEL_NULL(soundloop)
	return ..()

/obj/machinery/drill/attackby(obj/item/tool, mob/living/user, params)
	var/obj/structure/vein/vein = locate(/obj/structure/vein) in src.loc
	if(tool.tool_behaviour == TOOL_WRENCH)
		if(!vein)
			to_chat(user, "<span class='notice'>[src] must be on top of an ore vein.</span>")
			return
		if(active)
			to_chat(user, "<span class='notice'>[src] can't be unsecured while it's running!</span>")
			return
		playsound(src, 'sound/items/ratchet.ogg', 50, TRUE)
		if(!anchored && do_after(user, 30, target = src))
			to_chat(user, "<span class='notice'>You secure the [src] to the ore vein.</span>")
			playsound(src, 'sound/items/deconstruct.ogg', 50, TRUE)
			mining = vein
			anchored = TRUE
			return
		if(do_after(user, 30, target = src))
			to_chat(user, "<span class='notice'>You unsecure the [src] from the ore vein.</span>")
			playsound(src, 'sound/items/deconstruct.ogg', 50, TRUE)
			anchored = FALSE
			mining = null
			return
	return ..()

/obj/machinery/drill/interact(mob/user, special_state)
	. = ..()
	if(!mining)
		to_chat(user, "<span class='notice'>[src] isn't sercured in place yet!</span>")
		return
	if(!active)
		addtimer(CALLBACK(src, .proc/mine), 100)
		playsound(src, 'sound/machines/click.ogg', 100, TRUE)
		user.visible_message( \
					"[user] activates [src].", \
					"<span class='notice'>You hit the ignition button to activate [src].</span>", \
					"<span class='hear'>You hear a drill churn to life.</span>")
		active = TRUE
		soundloop.start()
		return
	else
		to_chat(user, "<span class='notice'>[src] is currently busy, wait till it's done!</span>")
		return

/obj/machinery/drill/proc/mine()
	new mining.ore_type(loc, mining.ore_amount)
	active = FALSE
	soundloop.stop()
