/datum/job/ai
	name = "AI"
	auto_deadmin_role_flags = DEADMIN_POSITION_SILICON
	total_positions = 1
	spawn_positions = 1
	minimal_player_age = 30
	display_order = JOB_DISPLAY_ORDER_AI
	var/do_special_check = TRUE
	wiki_page = "AI" //WS Edit - Wikilinks/Warning

/datum/job/ai/equip(mob/living/carbon/human/H, visualsOnly, announce, datum/outfit/outfit_override, client/preference_source = null)
	if(visualsOnly)
		CRASH("dynamic preview is unsupported")
	. = H.AIize(TRUE, preference_source)

/datum/job/ai/after_spawn(mob/H, mob/M)
	. = ..()
	var/mob/living/silicon/ai/AI = H
	if(SSticker.anonymousnames)
		AI.fully_replace_character_name(AI.real_name, anonymous_ai_name(is_ai = TRUE))
	else
		AI.apply_pref_name("ai", M.client)			//If this runtimes oh well jobcode is fucked. //what is this no energy attitude man
	AI.set_core_display_icon(null, M.client)

	//we may have been created after our borg
	if(SSticker.current_state == GAME_STATE_SETTING_UP)
		for(var/mob/living/silicon/robot/R in GLOB.silicon_mobs)
			if(!R.connected_ai)
				R.TryConnectToAI()

/datum/job/ai/override_latejoin_spawn()
	return TRUE

/datum/job/ai/special_check_latejoin(client/C)
	if(!do_special_check)
		return TRUE
	for(var/i in GLOB.latejoin_ai_cores)
		var/obj/structure/AIcore/latejoin_inactive/LAI = i
		if(istype(LAI))
			if(LAI.is_available())
				return TRUE
	return FALSE
