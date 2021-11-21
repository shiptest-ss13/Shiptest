#define ASH_WALKER_SPAWN_THRESHOLD 2
//The ash walker den consumes corpses or unconscious mobs to create ash walker eggs. For more info on those, check ghost_role_spawners.dm
/obj/structure/lavaland/ash_walker
	name = "necropolis tendril nest"
	desc = "A vile tendril of corruption. It's surrounded by a nest of rapidly growing eggs..."
	icon = 'icons/mob/nest.dmi'
	icon_state = "ash_walker_nest"

	move_resist=1000 // can be pulled if you displace it from the lava pool and have 1000 pull force, can be pushed if you have 1000 push force, takes damage if you somehow have more
	anchored = TRUE
	density = TRUE

	resistance_flags = FIRE_PROOF | LAVA_PROOF
	max_integrity = 200


	var/faction = list("ashwalker")
	var/meat_counter = 6
	var/datum/team/ashwalkers/ashies
	var/last_act = 0
	var/init_zlevel = 0		//This is my home, I refuse to settle anywhere else.

/obj/structure/lavaland/ash_walker/Initialize()
	.=..()
	init_zlevel = src.z
	ashies = new /datum/team/ashwalkers()
	var/datum/objective/protect_object/objective = new
	objective.set_target(src)
	ashies.objectives += objective
	START_PROCESSING(SSprocessing, src)

/obj/structure/lavaland/ash_walker/deconstruct(disassembled)
	new /obj/item/assembly/signaler/anomaly (get_step(loc, pick(GLOB.alldirs)))
	new	/obj/effect/collapse(loc)
	return ..()

/obj/structure/lavaland/ash_walker/process()
	consume()
	spawn_mob()

/obj/structure/lavaland/ash_walker/proc/consume()
	for(var/mob/living/H in view(src, 1)) //Only for corpse right next to/on same tile
		if(H.stat)
			for(var/obj/item/W in H)
				if(!H.dropItemToGround(W))
					qdel(W)
			if(issilicon(H)) //no advantage to sacrificing borgs...
				H.gib()
				visible_message("<span class='notice'>Serrated tendrils eagerly pull [H] apart, but find nothing of interest.</span>")
				return

			if(H.mind?.has_antag_datum(/datum/antagonist/ashwalker) && (H.key || H.get_ghost(FALSE, TRUE))) //special interactions for dead lava lizards with ghosts attached
				visible_message("<span class='warning'>Serrated tendrils carefully pull [H] to [src], absorbing the body and creating it anew.</span>")
				var/datum/mind/deadmind
				if(H.key)
					deadmind = H
				else
					deadmind = H.get_ghost(FALSE, TRUE)
				to_chat(deadmind, "Your body has been returned to the nest. You are being remade anew, and will awaken shortly. </br><b>Your memories will remain intact in your new body, as your soul is being salvaged</b>")
				SEND_SOUND(deadmind, sound('sound/magic/enter_blood.ogg',volume=100))
				addtimer(CALLBACK(src, .proc/remake_walker, H.mind, H.real_name), 20 SECONDS)
				new /obj/effect/gibspawner/generic(get_turf(H))
				qdel(H)
				return

			if(ismegafauna(H))
				meat_counter += 20
			else
				meat_counter++
			visible_message("<span class='warning'>Serrated tendrils eagerly pull [H] to [src], tearing the body apart as its blood seeps over the eggs.</span>")
			playsound(get_turf(src),'sound/magic/demon_consume.ogg', 100, TRUE)
			H.gib()
			obj_integrity = min(obj_integrity + max_integrity*0.05,max_integrity)//restores 5% hp of tendril
			for(var/mob/living/L in view(src, 5))
				if(L.mind?.has_antag_datum(/datum/antagonist/ashwalker))
					SEND_SIGNAL(L, COMSIG_ADD_MOOD_EVENT, "oogabooga", /datum/mood_event/sacrifice_good)
				else
					SEND_SIGNAL(L, COMSIG_ADD_MOOD_EVENT, "oogabooga", /datum/mood_event/sacrifice_bad)

/obj/structure/lavaland/ash_walker/proc/remake_walker(var/datum/mind/oldmind, var/oldname)
	var/mob/living/carbon/human/M = new /mob/living/carbon/human(get_step(loc, pick(GLOB.alldirs)))
	M.set_species(/datum/species/lizard/ashwalker/kobold) //WS Edit - Kobold
	M.real_name = oldname
	M.underwear = "Nude"
	M.update_body()
	oldmind.transfer_to(M)
	M.mind.grab_ghost()
	to_chat(M, "<b>You have been pulled back from beyond the grave, with a new body and renewed purpose. Glory to the Necropolis!</b>")
	playsound(get_turf(M),'sound/magic/exit_blood.ogg', 100, TRUE)

/obj/structure/lavaland/ash_walker/proc/spawn_mob()
	if(meat_counter >= ASH_WALKER_SPAWN_THRESHOLD)
		new /obj/effect/mob_spawn/human/ash_walker(get_step(loc, pick(GLOB.alldirs)), ashies)
		visible_message("<span class='danger'>One of the eggs swells to an unnatural size and tumbles free. It's ready to hatch!</span>")
		meat_counter -= ASH_WALKER_SPAWN_THRESHOLD

/obj/structure/lavaland/ash_walker/attackby(obj/item/I, mob/living/user, params)	//WS Edit - Movable Tendril
	if(user.mind.assigned_role == "Ash Walker")
		to_chat(user, "<span class='warning'>You would never think of harming the great Tendril of the Necropolis!</span>")
		return
	if(user.a_intent != INTENT_HELP)
		return ..()

	if(I.sharpness == IS_SHARP_ACCURATE)
		if(last_act + 50 > world.time)	//prevents message spam
			return
		last_act = world.time
		if(anchored)	//Getting here effectively just toggles the anchored bool, with some added flavor.
			user.visible_message("<span class='warning'>[user] starts to cut the [src]'s roots free!</span>", \
				"<span class='warning'>You start cutting the [src]'s roots from the ground...</span>", \
				"<span class='hear'>You hear grotesque cutting.</span>")
			if(I.use_tool(src, user, 50, volume=100))
				playsound(loc,'sound/effects/tendril_destroyed.ogg', 200, FALSE, 50, TRUE, TRUE)
				user.visible_message("<span class='danger'>The [src] writhes and screams as it's cut from the ground before finally settling down.</span>", \
					"<span class='danger'>You cut the [src]'s from the ground, causing it to scream and writhe!</span>", \
					"<span class='warning'>The ground shakes violently beneath you!</span>")
				anchored = FALSE
			return
		else
			if(src.z != init_zlevel)
				user.show_message("<span class='warning'>The [src] refuses to settle down in this area! You can't secure it!</span>")
				return
			user.visible_message("<span class='notice'>[user] starts to plant the [src]'s roots into the ground!</span>", \
				"<span class='notice'>You start threading the [src]'s roots back into the ground...</span>", \
				"<span class='hear'>You hear grotesque cutting.</span>")
			if(I.use_tool(src, user, 50, volume=100))
				user.visible_message("<span class='notice'>The [src] seems to settle down as [user] finishest securing it firmly to the ashy plains.</span>", \
					"<span class='notice'>You finish planting the [src]! It seems to calm down...</span>", \
					"<span class='notice'>The ground seems to settle a bit...</span>")
				anchored = TRUE
			return

	return ..()

#undef ASH_WALKER_SPAWN_THRESHOLD
