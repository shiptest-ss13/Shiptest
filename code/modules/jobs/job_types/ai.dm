/datum/job/ai
	name = "AI"
	auto_deadmin_role_flags = DEADMIN_POSITION_SILICON
	minimal_player_age = 30
	display_order = JOB_DISPLAY_ORDER_AI
	var/do_special_check = TRUE
	wiki_page = "AI" //WS Edit - Wikilinks/Warning

/datum/job/ai/after_spawn(mob/living/character, mob/joining_mob, datum/overmap/ship/controlled/ship, client/user_client)
	. = ..()

	var/obj/item/organ/brain/remote_control/controller = new()
	var/mob/living/silicon/ai/new_ai = character.AIize(TRUE, FALSE, user_client)

	if(!(character.mob_biotypes & MOB_ROBOTIC))
		character.set_species(/datum/species/ipc)
		character.apply_pref_name(new_ai, user_client) //If this runtimes oh well jobcode is fucked. //what is this no energy attitude man

	var/obj/item/organ/brain/old_brain = character.getorganslot(ORGAN_SLOT_BRAIN)
	if(old_brain)
		qdel(old_brain)

	controller.set_linked_ai(new_ai)
	controller.Insert(character, TRUE, FALSE, TRUE)
	controller.deploy_to_frame(character, new_ai)

	if(character.mind)
		to_chat(character, span_notice("NOTICE: Successfully linked core to remote frame [character.real_name]."))
	else
		to_chat(new_ai, span_userdanger("ERROR: Failed to link with remote frame [character.real_name]!"))
		stack_trace("[type] failed to deploy AI [new_ai] to remote frame [character.real_name]!")

	new_ai.add_ship_access(ship)
	new_ai.set_core_display_icon(null, user_client)

	//we may have been created after our borg
	if(SSticker.current_state == GAME_STATE_SETTING_UP)
		for(var/mob/living/silicon/robot/robot in GLOB.silicon_mobs)
			if(robot.connected_ai)
				continue
			if(!ship.shuttle_port.is_in_shuttle_bounds(robot))
				continue
			robot.TryConnectToAI(new_ai)

/datum/job/ai/special_check_latejoin(datum/overmap/ship/controlled/ship, client/user_client)
	if(!do_special_check)
		return TRUE
	for(var/obj/structure/AIcore/latejoin_inactive/LAI in GLOB.latejoin_ai_cores)
		if(!LAI.is_available())
			continue
		if(!ship.shuttle_port.is_in_shuttle_bounds(LAI))
			continue
		return TRUE
	return FALSE

/datum/outfit/job/ai
	name = "AI"
	jobtype = /datum/job/ai
	r_pocket = /obj/item/radio
	belt = /obj/item/pda

/datum/outfit/job/ai/nanotrasen
	name = "Nanotrasen - AI"
	faction = FACTION_PLAYER_NANOTRASEN
	faction_icon = "bg_nanotrasen"
