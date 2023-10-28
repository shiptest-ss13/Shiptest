/obj/machinery/drill
	name = "big-ass ore drill"
	desc = "It's like those drills you put in your hand but, like, way bigger."
	icon = 'icons/obj/machines/drill.dmi'
	icon_state = "deep_core_drill"
	max_integrity = 250
	integrity_failure = 0.25
	density = TRUE
	anchored = FALSE
	use_power = NO_POWER_USE
	layer = ABOVE_ALL_MOB_LAYER
	armor = list("melee" = 50, "bullet" = 30, "laser" = 30, "energy" = 30, "bomb" = 30, "bio" = 0, "rad" = 0, "fire" = 90, "acid" = 90)

	var/active = FALSE
	var/obj/structure/vein/mining
	var/datum/looping_sound/drill/soundloop

/obj/machinery/drill/Initialize()
	. = ..()
	soundloop = new(list(src), active)

/obj/machinery/drill/process()
	if(machine_stat & BROKEN || (active && !mining))
		active = FALSE
		update_overlays()
		update_icon_state()
		return

/obj/machinery/drill/Destroy()
	QDEL_NULL(soundloop)
	return ..()

/obj/machinery/drill/attackby(obj/item/tool, mob/living/user, params)
	var/obj/structure/vein/vein = locate(/obj/structure/vein) in src.loc
	if(tool.tool_behaviour == TOOL_WRENCH)
		if(!vein && !anchored)
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
			update_icon_state()
			return
		if(do_after(user, 30, target = src))
			to_chat(user, "<span class='notice'>You unsecure the [src] from the ore vein.</span>")
			playsound(src, 'sound/items/deconstruct.ogg', 50, TRUE)
			anchored = FALSE
			mining = null
			update_icon_state()
			return
	return ..()

/obj/machinery/drill/interact(mob/user, special_state)
	. = ..()
	if(!mining)
		to_chat(user, "<span class='notice'>[src] isn't sercured over an ore vein!</span>")
		return
	if(!active)
		playsound(src, 'sound/machines/click.ogg', 100, TRUE)
		user.visible_message( \
					"[user] activates [src].", \
					"<span class='notice'>You hit the ignition button to activate [src].</span>", \
					"<span class='hear'>You hear a drill churn to life.</span>")
		start_mining()
		active = TRUE
		soundloop.start()
		mining.begin_spawning()
		update_icon_state()
		update_overlays()
		return
	else
		to_chat(user, "<span class='notice'>[src] is currently busy, wait till it's done!</span>")
		return

/obj/machinery/drill/update_icon_state()
	if(anchored)
		if(machine_stat == BROKEN)
			icon_state = "deep_core_drill-deployed_broken"
			return ..()
		if(active)
			icon_state = "deep_core_drill-active"
			return ..()
		else
			icon_state = "deep_core_drill-idle"
			return ..()
	else
		if(machine_stat == BROKEN)
			icon_state = "deep_core_drill-broken"
			return ..()
		icon_state = "deep_core_drill"
		return ..()

/obj/machinery/drill/update_overlays()
	. = ..()
	SSvis_overlays.remove_vis_overlay(src, managed_vis_overlays)
	//Cool beam of light ignores shadows.
	if(active && anchored)
		set_light(3, 1, "99FFFF")
		SSvis_overlays.add_vis_overlay(src, icon, "mining_beam-particles", layer, plane, dir)
		SSvis_overlays.add_vis_overlay(src, icon, "mining_beam-particles", layer, EMISSIVE_PLANE, dir)
	else
		set_light(0)

/obj/machinery/drill/proc/start_mining()
	var/eta
	if(mining.mining_charges >= 1)
		eta = mining.mining_charges * 300
		addtimer(CALLBACK(src, .proc/mine), 300)
		say("Estimated time until vein depletion: [time2text(eta,"mm:ss")].")
	else
		say("Vein depleted.")
		active = FALSE
		soundloop.stop()
		mining.deconstruct()
		mining = null
		update_icon_state()
		update_overlays()

/obj/machinery/drill/proc/mine()
	if(mining.mining_charges)
		mining.mining_charges -= 1
		mining.drop_ore()
		start_mining()
	else if(!mining.mining_charges)
		say("Error: Vein Depleted")
		active = FALSE
		update_icon_state()
		update_overlays()
