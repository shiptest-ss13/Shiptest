/datum/job/ai
	name = "AI"
	auto_deadmin_role_flags = DEADMIN_POSITION_SILICON
	minimal_player_age = 30
	display_order = JOB_DISPLAY_ORDER_AI
	var/do_special_check = TRUE
	wiki_page = "AI" //WS Edit - Wikilinks/Warning

/datum/job/ai/equip(mob/living/carbon/human/character, visualsOnly, announce, datum/outfit/outfit_override, client/preference_source = null)
	. = ..()
	if(visualsOnly)
		return

	// If the character isn't robotic, just turn them directly into an AI mob.
	// If it is, insert a remote controller and link to an AI mob.
	if(!(character.mob_biotypes & MOB_ROBOTIC))
		return character.AIize(TRUE, TRUE, preference_source)

	var/obj/item/organ/brain/remote_control/controller = new()
	controller.brainmob.stored_dna = character.dna.copy_dna()
	controller.brainmob.real_name = character.real_name
	controller.brainmob.name = character.real_name

	var/mob/living/carbon/human/old_body = character
	var/mob/living/silicon/ai/new_ai = character.AIize(TRUE, FALSE, preference_source)
	controller.set_linked_ai(new_ai)
	controller.Insert(old_body, TRUE, FALSE)
	return new_ai

/datum/job/ai/after_spawn(mob/H, mob/M)
	. = ..()
	var/mob/living/silicon/ai/AI = H
	AI.apply_pref_name("ai", M.client)			//If this runtimes oh well jobcode is fucked. //what is this no energy attitude man
	AI.set_core_display_icon(null, M.client)

	//we may have been created after our borg
	if(SSticker.current_state == GAME_STATE_SETTING_UP)
		for(var/mob/living/silicon/robot/R in GLOB.silicon_mobs)
			if(!R.connected_ai)
				R.TryConnectToAI()

/datum/job/ai/override_latejoin_spawn()
	return TRUE

/datum/job/ai/special_check_latejoin(datum/overmap/ship/controlled/ship, client/C)
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
