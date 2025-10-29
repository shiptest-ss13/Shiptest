//This is the lowest supported version, anything below this is completely obsolete and the entire savefile will be wiped.
#define SAVEFILE_VERSION_MIN 33

//This is the current version, anything below this will attempt to update (if it's not obsolete)
//	You do not need to raise this if you are adding new values that have sane defaults.
//	Only raise this value when changing the meaning/format/name/layout of an existing value
//	where you would want the updater procs below to run
#define SAVEFILE_VERSION_MAX 42

/*
SAVEFILE UPDATING/VERSIONING - 'Simplified', or rather, more coder-friendly ~Carn
	This proc checks if the current directory of the savefile S needs updating
	It is to be used by the load_character and load_preferences procs.
	(S.cd=="/" is preferences, S.cd=="/character[integer]" is a character slot, etc)

	if the current directory's version is below SAVEFILE_VERSION_MIN it will simply wipe everything in that directory
	(if we're at root "/" then it'll just wipe the entire savefile, for instance.)

	if its version is below SAVEFILE_VERSION_MAX but above the minimum, it will load data but later call the
	respective update_preferences() or update_character() proc.
	Those procs allow coders to specify format changes so users do not lose their setups and have to redo them again.

	Failing all that, the standard sanity checks are performed. They simply check the data is suitable, reverting to
	initial() values if necessary.
*/
/datum/preferences/proc/savefile_needs_update(savefile/S)
	var/savefile_version
	READ_FILE(S["version"], savefile_version)

	if(savefile_version < SAVEFILE_VERSION_MIN)
		S.dir.Cut()
		return -2
	if(savefile_version < SAVEFILE_VERSION_MAX)
		return savefile_version
	return -1

//should these procs get fairly long
//just increase SAVEFILE_VERSION_MIN so it's not as far behind
//SAVEFILE_VERSION_MAX and then delete any obsolete if clauses
//from these procs.
//This only really meant to avoid annoying frequent players
//if your savefile is 3 months out of date, then 'tough shit'.

/datum/preferences/proc/update_preferences(current_version, savefile/S)
	if(current_version < 33)
		toggles |= SOUND_ENDOFROUND

	if(current_version < 34)
		auto_fit_viewport = TRUE

	if(current_version < 35) //makes old keybinds compatible with #52040, sets the new default
		var/newkey = FALSE
		for(var/list/key in key_bindings)
			for(var/bind in key)
				if(bind == "quick_equipbelt")
					key -= "quick_equipbelt"
					key |= "quick_equip_belt"

				if(bind == "bag_equip")
					key -= "bag_equip"
					key |= "quick_equip_bag"

				if(bind == "quick_equip_suit_storage")
					newkey = TRUE
		if(!newkey && !key_bindings["ShiftQ"])
			key_bindings["ShiftQ"] = list("quick_equip_suit_storage")

	if(current_version < 36)
		if(key_bindings["ShiftQ"] == "quick_equip_suit_storage")
			key_bindings["ShiftQ"] = list("quick_equip_suit_storage")

	if(current_version < 37)
		if(clientfps == 0)
			clientfps = -1

	if(current_version < 38)
		outline_enabled = TRUE
		outline_color = COLOR_BLUE_GRAY

	if (current_version < 40)
		LAZYADD(key_bindings["Space"], "hold_throw_mode")

	if(current_version < 42)
		//The toggles defines were moved down one bit
		if(toggles & FAST_MC_REFRESH)
			toggles |= SPLIT_ADMIN_TABS
		else
			toggles &= ~SPLIT_ADMIN_TABS

		if(toggles & SOUND_RADIO)
			toggles |= FAST_MC_REFRESH
		else
			toggles &= ~FAST_MC_REFRESH

		toggles |= SOUND_RADIO

/datum/preferences/proc/update_character(current_version, savefile/S)
	if(current_version < 39)
		var/species_id
		READ_FILE(S["species"], species_id)
		if(species_id == "teshari")
			pref_species = new /datum/species/kepori
			READ_FILE(S["feature_teshari_feathers"], features["kepori_feathers"])
			READ_FILE(S["feature_teshari_body_feathers"], features["kepori_body_feathers"])
	if(current_version < 41)
		var/species_id
		READ_FILE(S["species"], species_id)
		if(species_id == "felinid")
			pref_species = new /datum/species/human
			features["tail_human"] = "Cat"
			features["ears"] = "Cat"
	if(current_version < 42)
		var/body_size
		READ_FILE(S["body_size"], body_size)
		height_filter = body_size


/// checks through keybindings for outdated unbound keys and updates them
/datum/preferences/proc/check_keybindings()
	if(!parent)
		return
	var/list/user_binds = list()
	for (var/key in key_bindings)
		for(var/kb_name in key_bindings[key])
			user_binds[kb_name] += list(key)
	var/list/notadded = list()
	for (var/name in GLOB.keybindings_by_name)
		var/datum/keybinding/kb = GLOB.keybindings_by_name[name]
		if(length(user_binds[kb.name]))
			continue // key is unbound and or bound to something
		var/addedbind = FALSE
		if(hotkeys)
			for(var/hotkeytobind in kb.classic_keys)
				if(!length(key_bindings[hotkeytobind]))
					LAZYADD(key_bindings[hotkeytobind], kb.name)
					addedbind = TRUE
		else
			for(var/classickeytobind in kb.classic_keys)
				if(!length(key_bindings[classickeytobind]))
					LAZYADD(key_bindings[classickeytobind], kb.name)
					addedbind = TRUE
		if(!addedbind)
			notadded += kb
	if(length(notadded))
		addtimer(CALLBACK(src, PROC_REF(announce_conflict), notadded), 5 SECONDS)

/datum/preferences/proc/announce_conflict(list/notadded)
	to_chat(parent, "<span class='userdanger'>KEYBINDING CONFLICT!!!\n\
	There are new keybindings that have defaults bound to keys you already set, They will default to Unbound. You can bind them in Setup Character or Game Preferences\n\
	<a href='byond://?_src_=prefs;preference=tab;tab=3'>Or you can click here to go straight to the keybindings page</a></span>")
	for(var/item in notadded)
		var/datum/keybinding/conflicted = item
		to_chat(parent, "<span class='userdanger'>[conflicted.category]: [conflicted.full_name] needs updating")
		LAZYADD(key_bindings["Unbound"], conflicted.name) // set it to unbound to prevent this from opening up again in the future



/datum/preferences/proc/load_path(ckey,filename="preferences.sav")
	if(!ckey)
		return
	path = "data/player_saves/[ckey[1]]/[ckey]/[filename]"

/datum/preferences/proc/load_preferences()
	if(!path)
		return FALSE
	if(!fexists(path))
		return FALSE

	var/savefile/S = new /savefile(path)
	if(!S)
		return FALSE
	S.cd = "/"

	var/needs_update = savefile_needs_update(S)
	if(needs_update == -2)		//fatal, can't load any data
		var/bacpath = "[path].updatebac" //todo: if the savefile version is higher then the server, check the backup, and give the player a prompt to load the backup
		if (fexists(bacpath))
			fdel(bacpath) //only keep 1 version of backup
		fcopy(S, bacpath) //byond helpfully lets you use a savefile for the first arg.
		return FALSE

	//general preferences
	READ_FILE(S["asaycolor"], asaycolor)
	READ_FILE(S["brief_outfit"], brief_outfit)
	READ_FILE(S["ooccolor"], ooccolor)
	READ_FILE(S["screentip_color"], screentip_color)
	READ_FILE(S["lastchangelog"], lastchangelog)
	READ_FILE(S["UI_style"], UI_style)
	READ_FILE(S["outline_color"], outline_color)
	READ_FILE(S["outline_enabled"], outline_enabled)
	READ_FILE(S["hotkeys"], hotkeys)
	READ_FILE(S["chat_on_map"], chat_on_map)
	READ_FILE(S["max_chat_length"], max_chat_length)
	READ_FILE(S["see_chat_non_mob"] , see_chat_non_mob)
	READ_FILE(S["see_rc_emotes"] , see_rc_emotes)
	READ_FILE(S["broadcast_login_logout"] , broadcast_login_logout)

	READ_FILE(S["tgui_fancy"], tgui_fancy)
	READ_FILE(S["tgui_lock"], tgui_lock)
	READ_FILE(S["buttons_locked"], buttons_locked)
	READ_FILE(S["windowflash"], windowflashing)
	READ_FILE(S["be_special"] , be_special)


	READ_FILE(S["default_slot"], default_slot)
	READ_FILE(S["chat_toggles"], chat_toggles)
	READ_FILE(S["toggles"], toggles)
	READ_FILE(S["ghost_form"], ghost_form)
	READ_FILE(S["ghost_orbit"], ghost_orbit)
	READ_FILE(S["ghost_accs"], ghost_accs)
	READ_FILE(S["ghost_others"], ghost_others)
	READ_FILE(S["ignoring"], ignoring)
	READ_FILE(S["ghost_hud"], ghost_hud)
	READ_FILE(S["inquisitive_ghost"], inquisitive_ghost)
	READ_FILE(S["uses_glasses_colour"], uses_glasses_colour)
	READ_FILE(S["clientfps"], clientfps)
	READ_FILE(S["parallax"], parallax)
	READ_FILE(S["ambientocclusion"], ambientocclusion)
	READ_FILE(S["screentip_pref"], screentip_pref)
	READ_FILE(S["auto_fit_viewport"], auto_fit_viewport)
	READ_FILE(S["widescreenpref"], widescreenpref)
	READ_FILE(S["pixel_size"], pixel_size)
	READ_FILE(S["scaling_method"], scaling_method)
	READ_FILE(S["menuoptions"], menuoptions)
	READ_FILE(S["enable_tips"], enable_tips)
	READ_FILE(S["tip_delay"], tip_delay)
	READ_FILE(S["pda_style"], pda_style)
	READ_FILE(S["pda_color"], pda_color)
	READ_FILE(S["whois_visible"], whois_visible)
	READ_FILE(S["tgui_input"], tgui_input)
	READ_FILE(S["large_tgui_buttons"], large_tgui_buttons)
	READ_FILE(S["swapped_tgui_buttons"], swapped_tgui_buttons)

	READ_FILE(S["show_credits"], show_credits)

	//favorite outfits
	READ_FILE(S["favorite_outfits"], favorite_outfits)
	var/list/parsed_favs = list()
	for(var/typetext in favorite_outfits)
		var/datum/outfit/path = text2path(typetext)
		if(ispath(path)) //whatever typepath fails this check probably doesn't exist anymore
			parsed_favs += path
	favorite_outfits = uniqueList(parsed_favs)

	// OOC commendations
	READ_FILE(S["hearted_until"], hearted_until)
	if(hearted_until > world.realtime)
		hearted = TRUE

	// Custom hotkeys
	READ_FILE(S["key_bindings"], key_bindings)
	check_keybindings()

	//try to fix any outdated data if necessary
	if(needs_update >= 0)
		var/bacpath = "[path].updatebac" //todo: if the savefile version is higher then the server, check the backup, and give the player a prompt to load the backup
		if (fexists(bacpath))
			fdel(bacpath) //only keep 1 version of backup
		fcopy(S, bacpath) //byond helpfully lets you use a savefile for the first arg.
		update_preferences(needs_update, S)		//needs_update = savefile_version if we need an update (positive integer)



	//Sanitize
	asaycolor		= sanitize_ooccolor(sanitize_hexcolor(asaycolor, 6, TRUE, initial(asaycolor)))
	ooccolor		= sanitize_ooccolor(sanitize_hexcolor(ooccolor, 6, TRUE, initial(ooccolor)))
	screentip_color = sanitize_ooccolor(sanitize_hexcolor(screentip_color, 6, TRUE, initial(screentip_color)))
	lastchangelog	= sanitize_text(lastchangelog, initial(lastchangelog))
	UI_style		= sanitize_inlist(UI_style, GLOB.available_ui_styles, GLOB.available_ui_styles[1])
	hotkeys			= sanitize_integer(hotkeys, FALSE, TRUE, initial(hotkeys))
	chat_on_map		= sanitize_integer(chat_on_map, FALSE, TRUE, initial(chat_on_map))
	max_chat_length = sanitize_integer(max_chat_length, 1, CHAT_MESSAGE_MAX_LENGTH, initial(max_chat_length))
	see_chat_non_mob	= sanitize_integer(see_chat_non_mob, FALSE, TRUE, initial(see_chat_non_mob))
	see_rc_emotes	= sanitize_integer(see_rc_emotes, FALSE, TRUE, initial(see_rc_emotes))
	broadcast_login_logout = sanitize_integer(broadcast_login_logout, FALSE, TRUE, initial(broadcast_login_logout))
	tgui_fancy		= sanitize_integer(tgui_fancy, FALSE, TRUE, initial(tgui_fancy))
	tgui_lock		= sanitize_integer(tgui_lock, FALSE, TRUE, initial(tgui_lock))
	buttons_locked	= sanitize_integer(buttons_locked, FALSE, TRUE, initial(buttons_locked))
	windowflashing	= sanitize_integer(windowflashing, FALSE, TRUE, initial(windowflashing))
	default_slot	= sanitize_integer(default_slot, 1, max_save_slots, initial(default_slot))
	toggles			= sanitize_integer(toggles, 0, (2**24)-1, initial(toggles))
	clientfps		= sanitize_integer(clientfps, 0, 1000, 0)
	parallax		= sanitize_integer(parallax, PARALLAX_INSANE, PARALLAX_DISABLE, null)
	ambientocclusion	= sanitize_integer(ambientocclusion, FALSE, TRUE, initial(ambientocclusion))
	screentip_pref = sanitize_integer(screentip_pref, FALSE, TRUE, initial(screentip_pref))
	auto_fit_viewport	= sanitize_integer(auto_fit_viewport, FALSE, TRUE, initial(auto_fit_viewport))
	widescreenpref  = sanitize_integer(widescreenpref, FALSE, TRUE, initial(widescreenpref))
	pixel_size		= sanitize_integer(pixel_size, PIXEL_SCALING_AUTO, PIXEL_SCALING_3X, initial(pixel_size))
	scaling_method  = sanitize_text(scaling_method, initial(scaling_method))
	ghost_form		= sanitize_inlist(ghost_form, GLOB.ghost_forms, initial(ghost_form))
	ghost_orbit 	= sanitize_inlist(ghost_orbit, GLOB.ghost_orbits, initial(ghost_orbit))
	ghost_accs		= sanitize_inlist(ghost_accs, GLOB.ghost_accs_options, GHOST_ACCS_DEFAULT_OPTION)
	ghost_others	= sanitize_inlist(ghost_others, GLOB.ghost_others_options, GHOST_OTHERS_DEFAULT_OPTION)
	menuoptions		= SANITIZE_LIST(menuoptions)
	be_special		= SANITIZE_LIST(be_special)
	brief_outfit	= sanitize_inlist(brief_outfit, subtypesof(/datum/outfit), null)
	show_credits		= sanitize_integer(show_credits, 0, 1, initial(show_credits))
	pda_style		= sanitize_inlist(pda_style, GLOB.pda_styles, initial(pda_style))
	pda_color		= sanitize_hexcolor(pda_color, 6, TRUE, initial(pda_color))
	key_bindings 	= sanitize_keybindings(key_bindings)
	favorite_outfits = SANITIZE_LIST(favorite_outfits)
	equipped_gear	= sanitize_each_inlist(equipped_gear, GLOB.gear_datums)

	if(needs_update >= 0) //save the updated version
		var/old_default_slot = default_slot
		var/old_max_save_slots = max_save_slots

		for (var/slot in S.dir) //but first, update all current character slots.
			if (copytext(slot, 1, 10) != "character")
				continue
			var/slotnum = text2num(copytext(slot, 10))
			if (!slotnum)
				continue
			max_save_slots = max(max_save_slots, slotnum) //so we can still update byond member slots after they lose memeber status
			default_slot = slotnum
			if (load_character())
				save_character()
		default_slot = old_default_slot
		max_save_slots = old_max_save_slots
		save_preferences()

	return TRUE

/datum/preferences/proc/save_preferences()
	if(!path)
		return FALSE
	var/savefile/S = new /savefile(path)
	if(!S)
		return FALSE
	S.cd = "/"

	WRITE_FILE(S["version"] , SAVEFILE_VERSION_MAX)		//updates (or failing that the sanity checks) will ensure data is not invalid at load. Assume up-to-date

	//general preferences
	WRITE_FILE(S["asaycolor"], asaycolor)
	WRITE_FILE(S["brief_outfit"], brief_outfit)
	WRITE_FILE(S["ooccolor"], ooccolor)
	WRITE_FILE(S["screentip_color"], screentip_color)
	WRITE_FILE(S["lastchangelog"], lastchangelog)
	WRITE_FILE(S["UI_style"], UI_style)
	WRITE_FILE(S["outline_enabled"], outline_enabled)
	WRITE_FILE(S["outline_color"], outline_color)
	WRITE_FILE(S["hotkeys"], hotkeys)
	WRITE_FILE(S["chat_on_map"], chat_on_map)
	WRITE_FILE(S["max_chat_length"], max_chat_length)
	WRITE_FILE(S["see_chat_non_mob"], see_chat_non_mob)
	WRITE_FILE(S["see_rc_emotes"], see_rc_emotes)
	WRITE_FILE(S["broadcast_login_logout"], broadcast_login_logout)
	WRITE_FILE(S["tgui_fancy"], tgui_fancy)
	WRITE_FILE(S["tgui_lock"], tgui_lock)
	WRITE_FILE(S["buttons_locked"], buttons_locked)
	WRITE_FILE(S["windowflash"], windowflashing)
	WRITE_FILE(S["be_special"], be_special)
	WRITE_FILE(S["default_slot"], default_slot)
	WRITE_FILE(S["toggles"], toggles)
	WRITE_FILE(S["chat_toggles"], chat_toggles)
	WRITE_FILE(S["ghost_form"], ghost_form)
	WRITE_FILE(S["ghost_orbit"], ghost_orbit)
	WRITE_FILE(S["ghost_accs"], ghost_accs)
	WRITE_FILE(S["ghost_others"], ghost_others)
	WRITE_FILE(S["ignoring"], ignoring)
	WRITE_FILE(S["ghost_hud"], ghost_hud)
	WRITE_FILE(S["inquisitive_ghost"], inquisitive_ghost)
	WRITE_FILE(S["uses_glasses_colour"], uses_glasses_colour)
	WRITE_FILE(S["clientfps"], clientfps)
	WRITE_FILE(S["parallax"], parallax)
	WRITE_FILE(S["ambientocclusion"], ambientocclusion)
	WRITE_FILE(S["screentip_pref"], screentip_pref)
	WRITE_FILE(S["auto_fit_viewport"], auto_fit_viewport)
	WRITE_FILE(S["widescreenpref"], widescreenpref)
	WRITE_FILE(S["pixel_size"], pixel_size)
	WRITE_FILE(S["scaling_method"], scaling_method)
	WRITE_FILE(S["menuoptions"], menuoptions)
	WRITE_FILE(S["enable_tips"], enable_tips)
	WRITE_FILE(S["tip_delay"], tip_delay)
	WRITE_FILE(S["pda_style"], pda_style)
	WRITE_FILE(S["pda_color"], pda_color)
	WRITE_FILE(S["show_credits"], show_credits)
	WRITE_FILE(S["key_bindings"], key_bindings)
	WRITE_FILE(S["favorite_outfits"], favorite_outfits)
	WRITE_FILE(S["whois_visible"], whois_visible)
	WRITE_FILE(S["hearted_until"], (hearted_until > world.realtime ? hearted_until : null))
	WRITE_FILE(S["large_tgui_buttons"], large_tgui_buttons)
	WRITE_FILE(S["swapped_tgui_buttons"], swapped_tgui_buttons)
	WRITE_FILE(S["tgui_input"], tgui_input)
	return TRUE

/datum/preferences/proc/load_character(slot)
	if(!path)
		return FALSE
	if(!fexists(path))
		return FALSE
	var/savefile/S = new /savefile(path)
	if(!S)
		return FALSE
	S.cd = "/"
	if(!slot)
		slot = default_slot
	slot = sanitize_integer(slot, 1, max_save_slots, initial(default_slot))
	if(slot != default_slot)
		default_slot = slot
		WRITE_FILE(S["default_slot"] , slot)

	S.cd = "/character[slot]"
	var/needs_update = savefile_needs_update(S)
	if(needs_update == -2)		//fatal, can't load any data
		return FALSE

	//Species
	var/species_id
	READ_FILE(S["species"], species_id)
	if(species_id)
		var/newtype = GLOB.species_list[species_id]
		if(newtype)
			pref_species = new newtype

	//Character
	READ_FILE(S["real_name"], real_name)
	READ_FILE(S["gender"], gender)
	READ_FILE(S["age"], age)
	READ_FILE(S["hair_color"], hair_color)
	READ_FILE(S["facial_hair_color"], facial_hair_color)
	READ_FILE(S["eye_color"], eye_color)
	READ_FILE(S["skin_tone"], skin_tone)
	READ_FILE(S["hairstyle_name"], hairstyle)
	READ_FILE(S["facial_style_name"], facial_hairstyle)
	READ_FILE(S["feature_grad_style"], features["grad_style"])
	READ_FILE(S["feature_grad_color"], features["grad_color"])
	READ_FILE(S["underwear"], underwear)
	READ_FILE(S["underwear_color"], underwear_color)
	READ_FILE(S["undershirt"], undershirt)
	READ_FILE(S["undershirt_color"], undershirt_color)
	READ_FILE(S["socks"], socks)
	READ_FILE(S["socks_color"], socks_color)
	READ_FILE(S["backpack"], backpack)
	READ_FILE(S["jumpsuit_style"], jumpsuit_style)
	READ_FILE(S["phobia"], phobia)
	READ_FILE(S["generic_adjective"], generic_adjective)
	READ_FILE(S["randomise"],  randomise)
	READ_FILE(S["height_filter"], height_filter)
	READ_FILE(S["prosthetic_limbs"], prosthetic_limbs)
	prosthetic_limbs ||= list(BODY_ZONE_HEAD = PROSTHETIC_NORMAL, BODY_ZONE_CHEST = PROSTHETIC_NORMAL, BODY_ZONE_L_ARM = PROSTHETIC_NORMAL, BODY_ZONE_R_ARM = PROSTHETIC_NORMAL, BODY_ZONE_L_LEG = PROSTHETIC_NORMAL, BODY_ZONE_R_LEG = PROSTHETIC_NORMAL)
	for(var/zone in list(BODY_ZONE_HEAD, BODY_ZONE_CHEST, BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG))
		if(!prosthetic_limbs[zone])
			prosthetic_limbs[zone] = PROSTHETIC_NORMAL // necessary to prevent old savefiles from breaking the interface
	READ_FILE(S["learned_languages"], learned_languages)
	if(!learned_languages?.len) init_learned_languages()
	READ_FILE(S["native_language"], native_language)
	native_language ||= /datum/language/galactic_common
	READ_FILE(S["feature_mcolor"], features["mcolor"])
	READ_FILE(S["feature_mcolor2"], features["mcolor2"])
	READ_FILE(S["feature_ethcolor"], features["ethcolor"])
	READ_FILE(S["feature_lizard_tail"], features["tail_lizard"])
	READ_FILE(S["feature_lizard_face_markings"], features["face_markings"])
	READ_FILE(S["feature_lizard_horns"], features["horns"])
	READ_FILE(S["feature_lizard_frills"], features["frills"])
	READ_FILE(S["feature_lizard_spines"], features["spines"])
	READ_FILE(S["feature_lizard_body_markings"], features["body_markings"])
	READ_FILE(S["feature_moth_wings"], features["moth_wings"])
	READ_FILE(S["feature_moth_markings"], features["moth_markings"])

	READ_FILE(S["jumpsuit_style"], jumpsuit_style)
	READ_FILE(S["exowear"], exowear)
	READ_FILE(S["feature_moth_fluff"], features["moth_fluff"])
	READ_FILE(S["feature_spider_legs"], features["spider_legs"])
	READ_FILE(S["feature_spider_spinneret"], features["spider_spinneret"])
	READ_FILE(S["feature_spider_mandibles"], features["spider_mandibles"])
	READ_FILE(S["feature_squid_face"], features["squid_face"])
	READ_FILE(S["feature_ipc_screen"], features["ipc_screen"])
	READ_FILE(S["feature_ipc_antenna"], features["ipc_antenna"])
	READ_FILE(S["feature_ipc_tail"], features["ipc_tail"])
	READ_FILE(S["feature_ipc_chassis"], features["ipc_chassis"])
	READ_FILE(S["feature_ipc_brain"], features["ipc_brain"])
	READ_FILE(S["feature_kepori_feathers"], features["kepori_feathers"])
	READ_FILE(S["feature_kepori_body_feathers"], features["kepori_body_feathers"])
	READ_FILE(S["feature_kepori_head_feathers"], features["kepori_head_feathers"])
	READ_FILE(S["feature_kepori_tail_feathers"], features["kepori_tail_feathers"])
	READ_FILE(S["feature_vox_head_quills"], features["vox_head_quills"])
	READ_FILE(S["feature_vox_neck_quills"], features["vox_neck_quills"])
	READ_FILE(S["feature_elzu_horns"], features["elzu_horns"])
	READ_FILE(S["feature_tail_elzu"], features["tail_elzu"])

	READ_FILE(S["equipped_gear"], equipped_gear)
	if(config) //This should *probably* always be there, but just in case.
		if(length(equipped_gear) > CONFIG_GET(number/max_loadout_items))
			to_chat(parent, span_userdanger("Loadout maximum items exceeded in loaded slot, Your loadout has been cleared! You had [length(equipped_gear)]/[CONFIG_GET(number/max_loadout_items)] equipped items!"))
			equipped_gear = list()
			WRITE_FILE(S["equipped_gear"], equipped_gear)

	for(var/gear in equipped_gear)
		if(!(gear in GLOB.gear_datums))
			to_chat(parent, span_warning("Removing nonvalid loadout item [gear] from loadout"))
			equipped_gear -= gear //be GONE
			WRITE_FILE(S["equipped_gear"], equipped_gear)

	READ_FILE(S["feature_human_tail"], features["tail_human"])
	READ_FILE(S["feature_human_ears"], features["ears"])

	READ_FILE(S["fbp"], fbp)

	//Custom names
	for(var/custom_name_id in GLOB.preferences_custom_names)
		var/savefile_slot_name = custom_name_id + "_name" //TODO remove this
		READ_FILE(S[savefile_slot_name], custom_names[custom_name_id])

	READ_FILE(S["preferred_ai_core_display"], preferred_ai_core_display)

	//Preview outfit selection
	READ_FILE(S["selected_outfit"], selected_outfit)

	//Quirks
	READ_FILE(S["all_quirks"], all_quirks)
	var/list/removed_quirks = list()
	for(var/quirk_name in all_quirks.Copy())
		if(!(quirk_name in SSquirks.quirks))
			all_quirks.Remove(quirk_name)
			removed_quirks.Add(quirk_name)
	if(removed_quirks.len)
		to_chat(parent, "Some of your previously selected quirks have been removed: [english_list(removed_quirks)].")

	//Flavor Text
	S["feature_flavor_text"]		>> features["flavor_text"]

	//try to fix any outdated data if necessary
	//preference updating will handle saving the updated data for us.
	if(needs_update >= 0)
		update_character(needs_update, S)		//needs_update == savefile_version if we need an update (positive integer)

	//Sanitize
	real_name = reject_bad_name(real_name)
	gender = sanitize_gender(gender)
	if(!real_name)
		real_name = random_unique_name(gender)

	for(var/custom_name_id in GLOB.preferences_custom_names)
		custom_names[custom_name_id] = reject_bad_name(custom_names[custom_name_id])
		if(!custom_names[custom_name_id])
			custom_names[custom_name_id] = get_default_name(custom_name_id)

	if(!features["mcolor"] || text2num(features["mcolor"], 16) == 0)
		features["mcolor"] = random_color()

	if(!features["ethcolor"] || text2num(features["ethcolor"], 16) == 0)
		features["ethcolor"] = GLOB.color_list_ethereal[pick(GLOB.color_list_ethereal)]

	randomise = SANITIZE_LIST(randomise)

	if(gender == MALE)
		hairstyle								= sanitize_inlist(hairstyle, GLOB.hairstyles_male_list)
		facial_hairstyle						= sanitize_inlist(facial_hairstyle, GLOB.facial_hairstyles_male_list)
	else if(gender == FEMALE)
		hairstyle								= sanitize_inlist(hairstyle, GLOB.hairstyles_female_list)
		facial_hairstyle						= sanitize_inlist(facial_hairstyle, GLOB.facial_hairstyles_female_list)
	else
		hairstyle								= sanitize_inlist(hairstyle, GLOB.hairstyles_list)
		facial_hairstyle						= sanitize_inlist(facial_hairstyle, GLOB.facial_hairstyles_list)
		underwear								= sanitize_inlist(underwear, GLOB.underwear_list)
		undershirt 								= sanitize_inlist(undershirt, GLOB.undershirt_list)

	socks				= sanitize_inlist(socks, GLOB.socks_list)
	age					= sanitize_integer(age, pref_species.species_age_min, pref_species.species_age_max, initial(age))
	hair_color			= sanitize_hexcolor(hair_color)
	facial_hair_color	= sanitize_hexcolor(facial_hair_color)
	underwear_color		= sanitize_hexcolor(underwear_color)
	eye_color			= sanitize_hexcolor(eye_color)
	skin_tone			= sanitize_inlist(skin_tone, GLOB.skin_tones)
	backpack			= sanitize_inlist(backpack, GLOB.backpacklist, initial(backpack))
	jumpsuit_style		= sanitize_inlist(jumpsuit_style, GLOB.jumpsuitlist, initial(jumpsuit_style))
	exowear				= sanitize_inlist(exowear, GLOB.exowearlist, initial(exowear))
	fbp					= sanitize_integer(fbp, FALSE, TRUE, FALSE)
	height_filter		= sanitize_inlist(height_filter, GLOB.height_filters, "Normal")
	features["grad_style"]				= sanitize_inlist(features["grad_style"], GLOB.hair_gradients_list)
	features["grad_color"]				= sanitize_hexcolor(features["grad_color"])
	features["mcolor"]					= sanitize_hexcolor(features["mcolor"])
	features["mcolor2"]					= sanitize_hexcolor(features["mcolor2"])
	features["ethcolor"]				= copytext_char(features["ethcolor"], 1, 7)
	features["tail_lizard"]				= sanitize_inlist(features["tail_lizard"], GLOB.tails_list_lizard)
	features["tail_human"]				= sanitize_inlist(features["tail_human"], GLOB.tails_list_human, "None")
	features["face_markings"]			= sanitize_inlist(features["face_markings"], GLOB.face_markings_list)
	features["horns"]					= sanitize_inlist(features["horns"], GLOB.horns_list)
	features["ears"]					= sanitize_inlist(features["ears"], GLOB.ears_list, "None")
	features["frills"]					= sanitize_inlist(features["frills"], GLOB.frills_list)
	features["spines"]					= sanitize_inlist(features["spines"], GLOB.spines_list)
	features["body_markings"]			= sanitize_inlist(features["body_markings"], GLOB.body_markings_list)
	features["moth_wings"]				= sanitize_inlist(features["moth_wings"], GLOB.moth_wings_list, "Plain")
	features["moth_fluff"]				= sanitize_inlist(features["moth_fluff"], GLOB.moth_fluff_list, "Plain")
	features["spider_legs"] 			= sanitize_inlist(features["spider_legs"], GLOB.spider_legs_list, "Plain")
	features["spider_spinneret"] 		= sanitize_inlist(features["spider_spinneret"], GLOB.spider_spinneret_list, "Plain")
	features["moth_markings"]			= sanitize_inlist(features["moth_markings"], GLOB.moth_markings_list, "None")
	features["squid_face"]				= sanitize_inlist(features["squid_face"], GLOB.squid_face_list, "Squidward")
	features["ipc_screen"]				= sanitize_inlist(features["ipc_screen"], GLOB.ipc_screens_list)
	features["ipc_antenna"]				= sanitize_inlist(features["ipc_antenna"], GLOB.ipc_antennas_list)
	features["ipc_tail"]				= sanitize_inlist(features["ipc_tail"], GLOB.ipc_tail_list)
	features["ipc_chassis"]				= sanitize_inlist(features["ipc_chassis"], GLOB.ipc_chassis_list)
	features["ipc_brain"]				= sanitize_inlist(features["ipc_brain"], GLOB.ipc_brain_list)
	features["kepori_feathers"]			= sanitize_inlist(features["kepori_feathers"], GLOB.kepori_feathers_list, "Plain")
	features["kepori_body_feathers"]	= sanitize_inlist(features["kepori_body_feathers"], GLOB.kepori_body_feathers_list, "None")
	features["kepori_head_feathers"]	= sanitize_inlist(features["kepori_head_feathers"], GLOB.kepori_head_feathers_list, "None")
	features["kepori_tail_feathers"]	= sanitize_inlist(features["kepori_tail_feathers"], GLOB.kepori_tail_feathers_list, "None")
	features["vox_head_quills"]			= sanitize_inlist(features["vox_head_quills"], GLOB.vox_head_quills_list, "None")
	features["vox_neck_quills"]			= sanitize_inlist(features["vox_neck_quills"], GLOB.vox_neck_quills_list, "None")
	features["elzu_horns"]				= sanitize_inlist(features["elzu_horns"], GLOB.elzu_horns_list)
	features["tail_elzu"]				= sanitize_inlist(features["tail_elzu"], GLOB.tails_list_elzu)
	features["flavor_text"]				= sanitize_text(features["flavor_text"], initial(features["flavor_text"]))

	all_quirks = SANITIZE_LIST(all_quirks)

//Make sure all quirks are compatible
	check_quirk_compatibility()

	return TRUE

/datum/preferences/proc/save_character()
	if(!path)
		return FALSE
	var/savefile/S = new /savefile(path)
	if(!S)
		return FALSE
	S.cd = "/character[default_slot]"

	WRITE_FILE(S["version"]						, SAVEFILE_VERSION_MAX)	//load_character will sanitize any bad data, so assume up-to-date.)

	//Character
	WRITE_FILE(S["real_name"]					, real_name)
	WRITE_FILE(S["gender"]						, gender)
	WRITE_FILE(S["age"]							, age)
	WRITE_FILE(S["hair_color"]					, hair_color)
	WRITE_FILE(S["facial_hair_color"]			, facial_hair_color)
	WRITE_FILE(S["feature_grad_color"]			, features["grad_color"])
	WRITE_FILE(S["eye_color"]					, eye_color)
	WRITE_FILE(S["skin_tone"]					, skin_tone)
	WRITE_FILE(S["hairstyle_name"]				, hairstyle)
	WRITE_FILE(S["facial_style_name"]			, facial_hairstyle)
	WRITE_FILE(S["feature_grad_style"]			, features["grad_style"])
	WRITE_FILE(S["underwear"]					, underwear)
	WRITE_FILE(S["underwear_color"]				, underwear_color)
	WRITE_FILE(S["undershirt"]					, undershirt)
	WRITE_FILE(S["undershirt_color"]			, undershirt_color)
	WRITE_FILE(S["socks"]						, socks)
	WRITE_FILE(S["socks_color"]					, socks_color)
	WRITE_FILE(S["backpack"]					, backpack)
	WRITE_FILE(S["randomise"]					, randomise)
	WRITE_FILE(S["species"]						, pref_species.id)
	WRITE_FILE(S["phobia"]						, phobia)
	WRITE_FILE(S["generic_adjective"]			, generic_adjective)
	WRITE_FILE(S["height_filter"]				, height_filter)
	WRITE_FILE(S["prosthetic_limbs"]			, prosthetic_limbs)
	WRITE_FILE(S["learned_languages"]			, learned_languages)
	WRITE_FILE(S["native_language"]				, native_language)
	WRITE_FILE(S["feature_mcolor"]				, features["mcolor"])
	WRITE_FILE(S["feature_mcolor2"]				, features["mcolor2"])
	WRITE_FILE(S["feature_ethcolor"]			, features["ethcolor"])
	WRITE_FILE(S["feature_lizard_tail"]			, features["tail_lizard"])
	WRITE_FILE(S["feature_human_tail"]			, features["tail_human"])
	WRITE_FILE(S["feature_lizard_face_markings"], features["face_markings"])
	WRITE_FILE(S["feature_lizard_horns"]		, features["horns"])
	WRITE_FILE(S["feature_human_ears"]			, features["ears"])
	WRITE_FILE(S["feature_lizard_frills"]		, features["frills"])
	WRITE_FILE(S["feature_lizard_spines"]		, features["spines"])
	WRITE_FILE(S["feature_lizard_body_markings"], features["body_markings"])
	WRITE_FILE(S["feature_moth_wings"]			, features["moth_wings"])
	WRITE_FILE(S["feature_moth_markings"]		, features["moth_markings"])
	WRITE_FILE(S["jumpsuit_style"]				, jumpsuit_style)
	WRITE_FILE(S["exowear"]						, exowear)
	WRITE_FILE(S["equipped_gear"]				, equipped_gear)
	WRITE_FILE(S["feature_moth_fluff"]			, features["moth_fluff"])
	WRITE_FILE(S["feature_spider_legs"]			, features["spider_legs"])
	WRITE_FILE(S["feature_spider_spinneret"]	, features["spider_spinneret"])
	WRITE_FILE(S["feature_spider_mandibles"]	, features["spider_mandibles"])
	WRITE_FILE(S["feature_squid_face"]			, features["squid_face"])
	WRITE_FILE(S["feature_ipc_screen"]			, features["ipc_screen"])
	WRITE_FILE(S["feature_ipc_antenna"]			, features["ipc_antenna"])
	WRITE_FILE(S["feature_ipc_tail"] 			, features["ipc_tail"])
	WRITE_FILE(S["feature_ipc_chassis"]			, features["ipc_chassis"])
	WRITE_FILE(S["feature_ipc_brain"]			, features["ipc_brain"])
	WRITE_FILE(S["feature_kepori_feathers"]		, features["kepori_feathers"])
	WRITE_FILE(S["feature_kepori_body_feathers"], features["kepori_body_feathers"])
	WRITE_FILE(S["feature_kepori_head_feathers"], features["feature_kepori_head_feathers"])
	WRITE_FILE(S["feature_kepori_tail_feathers"], features["kepori_tail_feathers"])
	WRITE_FILE(S["feature_vox_head_quills"]		, features["vox_head_quills"])
	WRITE_FILE(S["feature_vox_neck_quills"]		, features["vox_neck_quills"])
	WRITE_FILE(S["feature_elzu_horns"]			, features["elzu_horns"])
	WRITE_FILE(S["feature_tail_elzu"]			, features["tail_elzu"])
	WRITE_FILE(S["fbp"]							, fbp)

	//Flavor text
	WRITE_FILE(S["feature_flavor_text"]			, features["flavor_text"])
	//Custom names
	for(var/custom_name_id in GLOB.preferences_custom_names)
		var/savefile_slot_name = custom_name_id + "_name" //TODO remove this
		WRITE_FILE(S[savefile_slot_name]		,custom_names[custom_name_id])
	//AI cores
	WRITE_FILE(S["preferred_ai_core_display"]	, preferred_ai_core_display)
	//Preview outfit selection
	WRITE_FILE(S["selected_outfit"]				, selected_outfit)
	//Quirks
	WRITE_FILE(S["all_quirks"]					, all_quirks)

	return TRUE


/proc/sanitize_keybindings(value)
	var/list/base_bindings = sanitize_islist(value,list())
	for(var/key in base_bindings)
		base_bindings[key] = base_bindings[key] & GLOB.keybindings_by_name
		if(!length(base_bindings[key]))
			base_bindings -= key
	return base_bindings

#undef SAVEFILE_VERSION_MAX
#undef SAVEFILE_VERSION_MIN

#ifdef TESTING
//DEBUG
//Some crude tools for testing savefiles
//path is the savefile path
/client/verb/savefile_export(path as text)
	var/savefile/S = new /savefile(path)
	S.ExportText("/",file("[path].txt"))
//path is the savefile path
/client/verb/savefile_import(path as text)
	var/savefile/S = new /savefile(path)
	S.ImportText("/",file("[path].txt"))

#endif
