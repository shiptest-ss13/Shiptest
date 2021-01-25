////////////Syndicate Cortical Borer
/obj/item/antag_spawner/syndi_borer
	name = "syndicate brain-slug container"
	desc = "Releases a modified cortical borer to assist the user."
	icon = 'whitesands/icons/obj/chemical.dmi' //Temporary? Doesn't look like a feckin syndicate item, and is overall shit. FIX
	icon_state = "hypoviallarge-b"
	var/polling = FALSE

/obj/item/antag_spawner/syndi_borer/spawn_antag(client/C, turf/T, mob/owner)
	var/mob/living/simple_animal/borer/syndi_borer/B = new /mob/living/simple_animal/borer/syndi_borer(T)

	B.key = C.key
	if (owner)
		B.owner = owner
		B.faction = B.faction | owner.faction.Copy()

		B.mind.assigned_role = B.name
		B.mind.special_role = B.name
		SSticker.mode.traitors += B.mind
		var/datum/objective/syndi_borer/new_objective
		new_objective = new /datum/objective/syndi_borer
		new_objective.owner = B.mind
		new_objective.target = owner.mind
		new_objective.explanation_text = "You are a modified cortical borer. You obey [owner.real_name] and must assist them in completing their objectives."
		B.mind.objectives += new_objective

		to_chat(B, "<B>You are awake at last! Seek out whoever released you and aid them as best you can!</B>")
		if(new_objective)
			to_chat(B, "<B>Objective #[1]</B>: [new_objective.explanation_text]")

/obj/item/antag_spawner/syndi_borer/proc/check_usability(mob/user)
	if(used)
		to_chat(user, "<span class='warning'>[src] appears to be empty!</span>")
		return 0
	if(polling == TRUE)
		to_chat(user, "<span class='warning'>[src] is busy activating!</span>")
		return 0
	return 1

/obj/item/antag_spawner/syndi_borer/attack_self(mob/user)
	if(!(check_usability(user)))
		return
	polling = TRUE
	var/list/borer_candidates = pollCandidatesForMob("Do you want to play as a syndicate cortical borer?", ROLE_BORER, null, ROLE_BORER, 150, src)
	if(borer_candidates.len)
		polling = FALSE
		if(!(check_usability(user)))
			return
		used = 1
		var/mob/dead/observer/theghost = pick(borer_candidates)
		spawn_antag(theghost.client, get_turf(src), user)
		var/datum/effect_system/spark_spread/S = new /datum/effect_system/spark_spread
		S.set_up(4, 1, src)
		S.start()
		qdel(src)
	else
		polling = FALSE
		to_chat(user, "<span class='warning'>Unable to connect to release specimen. Please wait and try again later or use the container on your uplink to get your points refunded.</span>")
