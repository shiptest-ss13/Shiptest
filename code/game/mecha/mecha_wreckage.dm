///////////////////////////////////
////////  Mecha wreckage   ////////
///////////////////////////////////


/obj/structure/mecha_wreckage
	name = "exosuit wreckage"
	desc = "Remains of some unfortunate mecha. Completely irreparable, but perhaps something can be salvaged."
	icon = 'icons/mecha/mecha.dmi'
	density = TRUE
	anchored = FALSE
	opacity = FALSE
	var/list/welder_salvage = list(/obj/item/stack/sheet/plasteel, /obj/item/stack/sheet/metal, /obj/item/stack/rods)
	var/salvage_num = 5
	var/list/crowbar_salvage = list()
	var/wires_removed = FALSE
	var/mob/living/silicon/ai/AI //AIs to be salvaged
	var/list/parts

/obj/structure/mecha_wreckage/Initialize(mapload, mob/living/silicon/ai/AI_pilot)
	. = ..()
	if(parts)
		for(var/i in 1 to 2)
			if(!parts.len)
				break
			if(prob(60))
				continue
			var/part = pick(parts)
			welder_salvage += part
		parts = null
	if(!AI_pilot) //Type-checking for this is already done in mecha/Destroy()
		return
	AI = AI_pilot
	AI.apply_damage(150, BURN) //Give the AI a bit of damage from the "shock" of being suddenly shut down
	INVOKE_ASYNC(AI, TYPE_PROC_REF(/mob/living/silicon, death)) //The damage is not enough to kill the AI, but to be 'corrupted files' in need of repair.
	AI.forceMove(src) //Put the dead AI inside the wreckage for recovery
	add_overlay(mutable_appearance('icons/obj/projectiles.dmi', "green_laser")) //Overlay for the recovery beacon
	AI.controlled_mech = null
	AI.remote_control = null

/obj/structure/mecha_wreckage/Destroy()
	if(AI)
		QDEL_NULL(AI)
	QDEL_LIST(crowbar_salvage)
	return ..()

/obj/structure/mecha_wreckage/examine(mob/user)
	. = ..()
	if(!AI)
		return
	. += span_notice("The AI recovery beacon is active.")

/obj/structure/mecha_wreckage/welder_act(mob/living/user, obj/item/I)
	..()
	. = TRUE
	if(salvage_num <= 0 || !length(welder_salvage))
		to_chat(user, span_notice("You don't see anything that can be cut with [I]!"))
		return
	if(!I.use_tool(src, user, 0, volume=50))
		return
	if(prob(30))
		to_chat(user, span_notice("You fail to salvage anything valuable from [src]!"))
		return
	var/type = pick(welder_salvage)
	var/N = new type(get_turf(user))
	user.visible_message(span_notice("[user] cuts [N] from [src]."), span_notice("You cut [N] from [src]."))
	if(!istype(N, /obj/item/stack))
		welder_salvage -= type
	salvage_num--

/obj/structure/mecha_wreckage/wirecutter_act(mob/living/user, obj/item/I)
	..()
	. = TRUE
	if(wires_removed)
		to_chat(user, span_notice("You don't see anything that can be cut with [I]!"))
		return
	var/N = new /obj/item/stack/cable_coil(get_turf(user), rand(1,3))
	user.visible_message(span_notice("[user] cuts [N] from [src]."), span_notice("You cut [N] from [src]."))
	wires_removed = TRUE

/obj/structure/mecha_wreckage/crowbar_act(mob/living/user, obj/item/I)
	..()
	. = TRUE
	if(crowbar_salvage.len)
		var/obj/S = pick(crowbar_salvage)
		S.forceMove(user.drop_location())
		user.visible_message(span_notice("[user] pries [S] from [src]."), span_notice("You pry [S] from [src]."))
		crowbar_salvage -= S
		return
	to_chat(user, span_notice("You don't see anything that can be cut with [I]!"))

/obj/structure/mecha_wreckage/transfer_ai(interaction, mob/user, null, obj/item/aicard/card)
	if(!..())
		return

//Proc called on the wreck by the AI card.
	if(interaction != AI_TRANS_TO_CARD) //AIs can only be transferred in one direction, from the wreck to the card.
		return
	if(!AI) //No AI in the wreck
		to_chat(user, span_warning("No AI backups found."))
		return
	cut_overlays() //Remove the recovery beacon overlay
	AI.forceMove(card) //Move the dead AI to the card.
	card.AI = AI
	if(AI.client) //AI player is still in the dead AI and is connected
		to_chat(AI, span_notice("The remains of your file system have been recovered on a mobile storage device."))
	else //Give the AI a heads-up that it is probably going to get fixed.
		AI.notify_ghost_cloning("You have been recovered from the wreckage!", source = card)
	to_chat(user, "[span_boldnotice("Backup files recovered")]: [AI.name] ([rand(1000,9999)].exe) salvaged from [name] and stored within local memory.")
	AI = null

/obj/structure/mecha_wreckage/gygax
	name = "\improper 501p wreckage"
	icon_state = "gygax-broken"
	parts = list(
				/obj/item/mecha_parts/part/gygax_torso,
				/obj/item/mecha_parts/chassis/gygax,
				/obj/item/mecha_parts/part/gygax_head,
				/obj/item/mecha_parts/part/gygax_left_arm,
				/obj/item/mecha_parts/part/gygax_right_arm,
				/obj/item/mecha_parts/part/gygax_left_leg,
				/obj/item/mecha_parts/part/gygax_right_leg
				)

/obj/structure/mecha_wreckage/gygax/dark
	name = "\improper 515 EX wreckage"
	icon_state = "darkgygax-broken"

/obj/structure/mecha_wreckage/marauder
	name = "\improper Marauder wreckage"
	icon_state = "marauder-broken"

/obj/structure/mecha_wreckage/touro
	name = "\improper Touro wreckage"
	icon_state = "touro-broken"

/obj/structure/mecha_wreckage/seraph
	name = "\improper Seraph wreckage"
	icon_state = "seraph-broken"

/obj/structure/mecha_wreckage/reticence
	name = "\improper Reticence wreckage"
	icon_state = "reticence-broken"
	color = "#87878715"
	desc = "..."

/obj/structure/mecha_wreckage/ripley
	name = "\improper Ripley wreckage"
	icon_state = "ripley-broken"
	parts = list(/obj/item/mecha_parts/part/ripley_torso,
				/obj/item/mecha_parts/chassis/ripley,
				/obj/item/mecha_parts/part/ripley_left_arm,
				/obj/item/mecha_parts/part/ripley_right_arm,
				/obj/item/mecha_parts/part/ripley_left_leg,
				/obj/item/mecha_parts/part/ripley_right_leg)

/obj/structure/mecha_wreckage/ripley/clip
	name = "\improper Rogue wreckage"
	icon_state = "clipripley-broken"


/obj/structure/mecha_wreckage/ripley/mkii
	name = "\improper Ripley MK-II wreckage"
	icon_state = "ripleymkii-broken"

/obj/structure/mecha_wreckage/ripley/firefighter
	name = "\improper Firefighter wreckage"
	icon_state = "firefighter-broken"
	parts = list(/obj/item/mecha_parts/part/ripley_torso,
				/obj/item/mecha_parts/part/ripley_left_arm,
				/obj/item/mecha_parts/chassis/ripley,
				/obj/item/mecha_parts/part/ripley_right_arm,
				/obj/item/mecha_parts/part/ripley_left_leg,
				/obj/item/mecha_parts/part/ripley_right_leg,
				/obj/item/clothing/suit/fire)

/obj/structure/mecha_wreckage/ripley/deathripley
	name = "\improper Death-Ripley wreckage"
	icon_state = "deathripley-broken"
	parts = null

/obj/structure/mecha_wreckage/durand
	name = "\improper Durand wreckage"
	icon_state = "durand-broken"
	parts = list(
			/obj/item/mecha_parts/part/durand_torso,
			/obj/item/mecha_parts/chassis/durand,
			/obj/item/mecha_parts/part/durand_head,
			/obj/item/mecha_parts/part/durand_left_arm,
			/obj/item/mecha_parts/part/durand_right_arm,
			/obj/item/mecha_parts/part/durand_left_leg,
			/obj/item/mecha_parts/part/durand_right_leg)

/obj/structure/mecha_wreckage/durand/clip
	name = "\improper Paladin wreckage"
	icon_state = "clipdurand-broken"

/obj/structure/mecha_wreckage/phazon
	name = "\improper Phazon wreckage"
	icon_state = "phazon-broken"


/obj/structure/mecha_wreckage/odysseus
	name = "\improper 202r wreckage"
	icon_state = "odysseus-broken"
	parts = list(
			/obj/item/mecha_parts/part/odysseus_torso,
			/obj/item/mecha_parts/chassis/odysseus,
			/obj/item/mecha_parts/part/odysseus_head,
			/obj/item/mecha_parts/part/odysseus_left_arm,
			/obj/item/mecha_parts/part/odysseus_right_arm,
			/obj/item/mecha_parts/part/odysseus_left_leg,
			/obj/item/mecha_parts/part/odysseus_right_leg)

/obj/structure/mecha_wreckage/tank/Initialize()
	. = ..()
	message_admins("A tank was destroyed and has exploded at [ADMIN_VERBOSEJMP(src)].") //logging
	explosion(src, 0, 2, 4, 4, TRUE, flame_range = 5)
	return INITIALIZE_HINT_QDEL
