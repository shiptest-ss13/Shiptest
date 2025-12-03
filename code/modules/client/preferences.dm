GLOBAL_LIST_EMPTY(preferences_datums)

/datum/preferences
	var/client/parent
	//doohickeys for savefiles
	var/path
	var/default_slot = 1				//Holder so it doesn't default to slot 1, rather the last one used
	var/max_save_slots = 30

	//non-preference stuff
	var/muted = 0

	//game-preferences
	var/lastchangelog = ""				//Saved changlog filesize to detect if there was a change
	var/ooccolor = "#c43b23"
	var/asaycolor = "#ff4500"			//This won't change the color for current admins, only incoming ones.
	/// If we spawn an ERT as an admin and choose to spawn as the briefing officer, we'll be given this outfit
	var/brief_outfit = /datum/outfit/job/nanotrasen/captain
	var/enable_tips = TRUE
	var/tip_delay = 500 //tip delay in milliseconds

	//Antag preferences
	var/list/be_special = list()		//Special role selection
	var/tmp/old_be_special = 0			//Bitflag version of be_special, used to update old savefiles and nothing more
										//If it's 0, that's good, if it's anything but 0, the owner of this prefs file's antag choices were,
										//autocorrected this round, not that you'd need to check that.

	var/UI_style = null
	var/outline_enabled = TRUE
	var/outline_color = COLOR_BLUE_GRAY
	var/buttons_locked = FALSE
	var/hotkeys = TRUE

	///Runechat preference. If true, certain messages will be displayed on the map, not ust on the chat area. Boolean.
	var/chat_on_map = TRUE
	///Limit preference on the size of the message. Requires chat_on_map to have effect.
	var/max_chat_length = CHAT_MESSAGE_MAX_LENGTH
	///Whether non-mob messages will be displayed, such as machine vendor announcements. Requires chat_on_map to have effect. Boolean.
	var/see_chat_non_mob = TRUE
	///Whether emotes will be displayed on runechat. Requires chat_on_map to have effect. Boolean.
	var/see_rc_emotes = TRUE

	// Custom Keybindings
	var/list/key_bindings = list()

	var/tgui_fancy = TRUE
	var/tgui_lock = FALSE
	var/windowflashing = TRUE
	var/toggles = TOGGLES_DEFAULT
	var/db_flags
	var/chat_toggles = TOGGLES_DEFAULT_CHAT
	var/ghost_form = "ghost"
	var/ghost_orbit = GHOST_ORBIT_CIRCLE
	var/ghost_accs = GHOST_ACCS_DEFAULT_OPTION
	var/ghost_others = GHOST_OTHERS_DEFAULT_OPTION
	var/ghost_hud = 1
	var/inquisitive_ghost = 1
	var/allow_midround_antag = 1
	var/pda_style = MONO
	var/pda_color = "#808000"
	var/show_credits = TRUE

	var/uses_glasses_colour = 0

	//character preferences
	var/slot_randomized					//keeps track of round-to-round randomization of the character slot, prevents overwriting
	var/real_name						//our character's name
	var/gender = MALE					//gender of character (well duh)
	var/pronouns = "He"					//pronouns of character
	var/age = 30						//age of character
	var/underwear = "Nude"				//Type of underwear
	var/underwear_color = "000"			//Greyscale color of underwear
	var/undershirt = "Nude"				//Type of undershirt
	var/undershirt_color = "000"		//Greyscale color of undershirt
	var/socks = "Nude"					//Type of socks
	var/socks_color = "000"				//Greyscale color of socks
	var/backpack = DBACKPACK			//Type of backpack
	var/jumpsuit_style = PREF_SUIT		//suit/skirt
	var/exowear = PREF_EXOWEAR			//exowear
	var/hairstyle = "Bald"				//Hair type
	var/hair_color = "000"				//Hair color
	var/facial_hairstyle = "Shaved"		//Face hair type
	var/facial_hair_color = "000"		//Facial hair color
	var/skin_tone = "caucasian1"		//Skin color
	var/eye_color = "000"				//Eye color
	var/datum/species/pref_species = new /datum/species/human()	//Mutant race
	var/species_looking_at = "human"	 //used as a helper to keep track of in the species select thingy
	var/list/features = list(
							"mcolor" = "FFF",
							"mcolor2" = "FFF",
							"grad_style" = "None",
							"grad_color" = "FFF",
							"ethcolor" = "9c3030",
							"tail_lizard" = "Smooth",
							"tail_human" = "None",
							"face_markings" = "None",
							"horns" = "None",
							"ears" = "None",
							"wings" = "None",
							"frills" = "None",
							"spines" = "None",
							"body_markings" = "None",
							"moth_wings" = "Plain",
							"moth_fluff" = "Plain",
							"moth_markings" = "None",
							"spider_legs" = "Plain",
							"spider_spinneret" = "Plain",
							"spider_mandibles" = "Plain",
							"squid_face" = "Squidward",
							"ipc_screen" = "Blue",
							"ipc_antenna" = "None",
							"ipc_tail" = "None",
							"ipc_chassis" = "Morpheus Cyberkinetics (Custom)",
							"ipc_brain" = "Posibrain",
							"kepori_feathers" = "None",
							"kepori_body_feathers" = "None",
							"kepori_head_feathers" = "None",
							"kepori_tail_feathers" = "None",
							"vox_head_quills" = "Plain",
							"vox_neck_quills" = "Plain",
							"elzu_horns" = "None",
							"elzu_tail" = "None",
							"flavor_text" = ""
						)
	var/height_filter = "Normal"
	var/list/randomise = list(
							RANDOM_UNDERWEAR = TRUE,
							RANDOM_UNDERWEAR_COLOR = TRUE,
							RANDOM_UNDERSHIRT = TRUE,
							RANDOM_UNDERSHIRT_COLOR = TRUE,
							RANDOM_SOCKS = TRUE,
							RANDOM_SOCKS_COLOR = TRUE,
							RANDOM_BACKPACK = TRUE,
							RANDOM_JUMPSUIT_STYLE = TRUE,
							RANDOM_EXOWEAR_STYLE = TRUE,
							RANDOM_HAIRSTYLE = TRUE,
							RANDOM_HAIR_COLOR = TRUE,
							RANDOM_FACIAL_HAIRSTYLE = TRUE,
							RANDOM_FACIAL_HAIR_COLOR = TRUE,
							RANDOM_SKIN_TONE = TRUE,
							RANDOM_EYE_COLOR = TRUE,
						)
	var/list/friendlyGenders = list(
							"Male" = "male",
							"Female" = "female",
							"Other" = "plural",
							"None" = "neuter"
						)
	var/list/friendlyPronouns = list(
							"He/Him" = "He",
							"She/Her" = "She",
							"They/Them" = "They",
							"It/Its" = "It"
						)
	var/list/prosthetic_limbs = list(
							BODY_ZONE_HEAD = PROSTHETIC_NORMAL,
							BODY_ZONE_CHEST = PROSTHETIC_NORMAL,
							BODY_ZONE_L_ARM = PROSTHETIC_NORMAL,
							BODY_ZONE_R_ARM = PROSTHETIC_NORMAL,
							BODY_ZONE_L_LEG = PROSTHETIC_NORMAL,
							BODY_ZONE_R_LEG = PROSTHETIC_NORMAL,
						)
	var/fbp = FALSE
	var/phobia = "spiders"
	var/list/alt_titles_preferences = list()
	var/list/custom_names = list()
	var/preferred_ai_core_display = "Blue"
	var/generic_adjective = "Unremarkable"
	//Quirk list
	var/list/all_quirks = list()

	//Job preferences 2.0 - indexed by job title , no key or value implies never
	var/list/job_preferences = list()

	/// Languages this character knows besides their native language.
	var/list/learned_languages = list()

	/// This character's native language.
	var/datum/language/native_language = /datum/language/galactic_common

	/// Associated list with language levels of understanding and their point costs.
	var/static/list/language_level_costs = list(LANGUAGE_UNKNOWN = 0, LANGUAGE_RECOGNIZED = 1, LANGUAGE_FAMILIAR = 2, LANGUAGE_FLUENT = 3)

	// 0 = character settings, 1 = game preferences
	var/current_tab = 0

	var/show_gear = TRUE
	var/show_loadout = TRUE

	var/unlock_content = FALSE
	var/custom_ooc = FALSE

	var/list/ignoring = list()

	var/clientfps = 60 //WS Edit - Client FPS Tweak

	var/parallax
	///Do we show screentips, if so, how big?
	var/screentip_pref = TRUE
	///Color of screentips at top of screen
	var/screentip_color = "#ffd391"

	var/ambientocclusion = TRUE
	///Should we automatically fit the viewport?
	var/auto_fit_viewport = TRUE
	///Should we be in the widescreen mode set by the config?
	var/widescreenpref = FALSE
	///What size should pixels be displayed as? 0 is strech to fit
	var/pixel_size = 0
	///What scaling method should we use? Distort = Nearest Neighbor
	var/scaling_method = SCALING_METHOD_DISTORT

	var/list/exp = list()
	var/list/menuoptions

	///do we use tgui input when possible
	var/tgui_input = TRUE

	/// are the tgui buttons big and stupid
	var/large_tgui_buttons = FALSE
	/// are the tgui buttons swapped for some reason
	var/swapped_tgui_buttons = FALSE

	///Gear the character has equipped
	var/list/equipped_gear = list()
	///Gear tab currently being viewed
	var/gear_tab = "General"

	var/action_buttons_screen_locs = list()
	///If we want to broadcast deadchat connect/disconnect messages
	var/broadcast_login_logout = TRUE
	///What outfit typepaths we've favorited in the SelectEquipment menu
	var/list/favorite_outfits = list()
	var/whois_visible = TRUE

	///The outfit we currently want to preview on our character
	var/datum/outfit/job/selected_outfit

	///Someone thought we were nice! We get a little heart in OOC until we join the server past the below time (we can keep it until the end of the round otherwise)
	var/hearted
	///
	var/hearted_until



/datum/preferences/New(client/C)
	parent = C

	for(var/custom_name_id in GLOB.preferences_custom_names)
		custom_names[custom_name_id] = get_default_name(custom_name_id)

	UI_style = GLOB.available_ui_styles[1]
	if(istype(C))
		if(!IsGuestKey(C.key))
			load_path(C.ckey)
			unlock_content = C.IsByondMember()
			if(unlock_content)
				max_save_slots = 50
	var/loaded_preferences_successfully = load_preferences()
	if(loaded_preferences_successfully)
		if(load_character())
			species_looking_at = pref_species.id
			return
	//we couldn't load character data so just randomize the character appearance + name
	random_character()		//let's create a random character then - rather than a fat, bald and naked man.
	key_bindings = deepCopyList(GLOB.hotkey_keybinding_list_by_key) // give them default keybinds and update their movement keys
	C?.set_macros()
	real_name = pref_species.random_name(gender,1)
	if(!loaded_preferences_successfully)
		save_preferences()
	save_character()		//let's save this new random character so it doesn't keep generating new ones.
	menuoptions = list()
	return

#define APPEARANCE_CATEGORY_COLUMN "<td valign='top' width='14%'>"
#define MAX_MUTANT_ROWS 5

/datum/preferences/proc/ShowChoices(mob/user)
	show_loadout = (current_tab != 1) ? show_loadout : FALSE
	show_gear = (current_tab != 1)
	if(!user || !user.client)
		return
	if(slot_randomized)
		load_character(default_slot) // Reloads the character slot. Prevents random features from overwriting the slot if saved.
		slot_randomized = FALSE
	update_preview_icon(show_gear, show_loadout)
	var/list/dat = list("<center>")

	dat += "<a href='byond://?_src_=prefs;preference=tab;tab=0' [current_tab == 0 ? "class='linkOn'" : ""]>Character Setup</a>"
	dat += "<a href='byond://?_src_=prefs;preference=tab;tab=1' [current_tab == 1 ? "class='linkOn'" : ""]>Character Appearance</a>"
	dat += "<a href='byond://?_src_=prefs;preference=tab;tab=2' [current_tab == 2 ? "class='linkOn'" : ""]>Gear</a>"
	dat += "<a href='byond://?_src_=prefs;preference=tab;tab=3' [current_tab == 3 ? "class='linkOn'" : ""]>Game Preferences</a>"
	dat += "<a href='byond://?_src_=prefs;preference=tab;tab=4' [current_tab == 4 ? "class='linkOn'" : ""]>OOC Preferences</a>"
	dat += "<a href='byond://?_src_=prefs;preference=tab;tab=5' [current_tab == 5 ? "class='linkOn'" : ""]>Custom Keybindings</a>"

	if(!path)
		dat += "<div class='notice'>Please create an account to save your preferences</div>"

	dat += "</center>"
	dat += "<HR>"

	switch(current_tab)
		if (0) // Character Setup
			if(path)
				var/savefile/S = new /savefile(path)
				if(S)
					dat += "<center>"
					var/name
					var/unspaced_slots = 0
					for(var/i=1, i<=max_save_slots, i++)
						unspaced_slots++
						if(unspaced_slots > 4)
							dat += "<br>"
							unspaced_slots = 0
						S.cd = "/character[i]"
						S["real_name"] >> name
						if(!name)
							name = "Character[i]"
						dat += "<a style='white-space:nowrap;' href='byond://?_src_=prefs;preference=changeslot;num=[i];' [i == default_slot ? "class='linkOn'" : ""]>[name]</a> "
					dat += "</center>"

			dat += "<center><h2>Outfit Preview Settings</h2>"
			dat += "<a href='byond://?_src_=prefs;preference=job'>Set Preview Job Gear</a><br></center>"
			if(CONFIG_GET(flag/roundstart_traits))
				dat += "<center><h2>Quirk Setup</h2>"
				dat += "<a href='byond://?_src_=prefs;preference=trait;task=menu'>Configure Quirks</a><br></center>"
				dat += "<center><b>Current Quirks:</b> [all_quirks.len ? all_quirks.Join(", ") : "None"]</center>"
			dat += "<h2>Identity</h2>"
			dat += "<table width='100%'><tr><td width='24%' valign='top'>"
			if(is_banned_from(user.ckey, "Appearance"))
				dat += "<b>You are banned from using custom names and appearances. You can continue to adjust your characters, but you will be randomised once you join the game.</b><br>"
			dat += "<a href='byond://?_src_=prefs;preference=name;task=random'>Random Name</A> "
			dat += "<a href='byond://?_src_=prefs;preference=toggle_random;random_type=[RANDOM_NAME]'>Always Random Name: [(randomise[RANDOM_NAME]) ? "Yes" : "No"]</a>"
			dat += "<a href='byond://?_src_=prefs;preference=toggle_random;random_type=[RANDOM_NAME_ANTAG]'>When Antagonist: [(randomise[RANDOM_NAME_ANTAG]) ? "Yes" : "No"]</a>"
			dat += "<br><b>Name:</b> "
			dat += "<a href='byond://?_src_=prefs;preference=name;task=input'>[real_name]</a><BR>"

			if(!(AGENDER in pref_species.species_traits))
				var/dispGender
				if(gender == MALE)
					dispGender = "Male"
				else if(gender == FEMALE)
					dispGender = "Female"
				else if(gender == NEUTER)
					dispGender = "None"
				else
					dispGender = "Other"
				dat += "<b>Gender:</b> <a href='byond://?_src_=prefs;preference=gender'>[dispGender]</a>"
				if(randomise[RANDOM_BODY] || randomise[RANDOM_BODY_ANTAG]) //doesn't work unless random body
					dat += "<a href='byond://?_src_=prefs;preference=toggle_random;random_type=[RANDOM_GENDER]'>Always Random Gender: [(randomise[RANDOM_GENDER]) ? "Yes" : "No"]</A>"
					dat += "<a href='byond://?_src_=prefs;preference=toggle_random;random_type=[RANDOM_GENDER_ANTAG]'>When Antagonist: [(randomise[RANDOM_GENDER_ANTAG]) ? "Yes" : "No"]</A>"
			var/dispPronouns
			if(pronouns == "He")
				dispPronouns = "He/Him"
			else if(pronouns == "She")
				dispPronouns = "She/Her"
			else if(pronouns == "It")
				dispPronouns = "It/Its"
			else
				dispPronouns = "They/Them"
			dat += "<br><b>Pronouns:</b> <a href='byond://?_src_=prefs;preference=pronouns'>[dispPronouns]</a>"
			dat += "<br><b>Age:</b> <a href='byond://?_src_=prefs;preference=age;task=input'>[age]</a>"
			if(randomise[RANDOM_BODY] || randomise[RANDOM_BODY_ANTAG]) //doesn't work unless random body
				dat += "<a href='byond://?_src_=prefs;preference=toggle_random;random_type=[RANDOM_AGE]'>Always Random Age: [(randomise[RANDOM_AGE]) ? "Yes" : "No"]</A>"
				dat += "<a href='byond://?_src_=prefs;preference=toggle_random;random_type=[RANDOM_AGE_ANTAG]'>When Antagonist: [(randomise[RANDOM_AGE_ANTAG]) ? "Yes" : "No"]</A>"

			dat += "<br><a href='byond://?_src_=prefs;preference=flavor_text;task=input'><b>Set Flavor Text</b></a>"
			if(length(features["flavor_text"]) <= 40)
				if(!length(features["flavor_text"]))
					dat += "\[...\]"
				else
					dat += "[features["flavor_text"]]"
			else
				dat += "[copytext_char(features["flavor_text"], 1, 37)]...<BR>"

			dat += "<br><br><b>Special Names:</b><BR>"
			var/old_group
			for(var/custom_name_id in GLOB.preferences_custom_names)
				var/namedata = GLOB.preferences_custom_names[custom_name_id]
				if(!old_group)
					old_group = namedata["group"]
				else if(old_group != namedata["group"])
					old_group = namedata["group"]
					dat += "<br>"
				dat += "<a href ='?_src_=prefs;preference=[custom_name_id];task=input'><b>[namedata["pref_name"]]:</b> [custom_names[custom_name_id]]</a> "
			dat += "<br><br>"

			dat += "<b>Custom Job Preferences:</b><BR>"
			dat += "<a href='byond://?_src_=prefs;preference=ai_core_icon;task=input'><b>Preferred AI Core Display:</b> [preferred_ai_core_display]</a><br>"

			dat += "<td><h2>Languages</h2><table>"
			dat += "<tr><td><b>[get_language_point_balance()]</b> points left.</td></tr>"
			dat += "<tr><td><a href='byond://?_src_=prefs;preference=native_language;task=input'><b>Native Language: </b>[initial(native_language.name)]</a></td></tr>"
			if(!learned_languages?.len)
				init_learned_languages()
			for(var/datum/language/lang_type as anything in learned_languages)
				if(lang_type == native_language)
					continue
				dat += "<tr><td><b>[initial(lang_type.name)]: </b></td>"
				dat += "<td><a href='byond://?_src_=prefs;preference=learned_language;task=input;language=[REF(GLOB.language_datum_instances[lang_type])]'>[learned_languages[lang_type]]</a></td></tr>"
			dat += "<tr><td><a href='byond://?_src_=prefs;preference=reset_languages;task=input'>Reset Languages</a></td></tr></table></td>"

			dat += "</tr></table>"

			dat += "<h2>Clothing</h2>"

			dat += "<b>Backpack:</b><BR><a href ='?_src_=prefs;preference=bag;task=input'>[backpack]</a>"

			dat += "<br><b>Jumpsuit Style:</b><BR><a href ='?_src_=prefs;preference=suit;task=input'>[jumpsuit_style]</a>"

			dat += "<br><b>Outerwear Style:</b><BR><a href ='?_src_=prefs;preference=exo;task=input'>[exowear]</a>"

		if(1) //Character Appearance
			if(path)
				var/savefile/S = new /savefile(path)
				if(S)
					dat += "<center>"
					var/name
					var/unspaced_slots = 0
					for(var/i=1, i<=max_save_slots, i++)
						unspaced_slots++
						if(unspaced_slots > 4)
							dat += "<br>"
							unspaced_slots = 0
						S.cd = "/character[i]"
						S["real_name"] >> name
						if(!name)
							name = "Character[i]"
						dat += "<a style='white-space:nowrap;' href='byond://?_src_=prefs;preference=changeslot;num=[i];' [i == default_slot ? "class='linkOn'" : ""]>[name]</a> "
					dat += "</center>"

			dat += "<h2>Body</h2>"
			dat += "<a href='byond://?_src_=prefs;preference=all;task=random'>Random Body</A> "
			dat += "<a href='byond://?_src_=prefs;preference=toggle_random;random_type=[RANDOM_BODY]'>Always Random Body: [(randomise[RANDOM_BODY]) ? "Yes" : "No"]</A>"
			dat += "<a href='byond://?_src_=prefs;preference=toggle_random;random_type=[RANDOM_BODY_ANTAG]'>When Antagonist: [(randomise[RANDOM_BODY_ANTAG]) ? "Yes" : "No"]</A><br>"

			dat += "<table width='100%'><tr><td width='24%' valign='top'>"

			dat += "<b>Species:</b><BR><a href='byond://?_src_=prefs;preference=species;task=input'>[pref_species.name]</a><BR>"
			dat += "<a href='byond://?_src_=prefs;preference=species;task=random'>Random Species</A> "
			dat += "<a href='byond://?_src_=prefs;preference=toggle_random;random_type=[RANDOM_SPECIES]'>Always Random Species: [(randomise[RANDOM_SPECIES]) ? "Yes" : "No"]</A><br>"

			if(!(NO_UNDERWEAR in pref_species.species_traits))
				dat += "<b>Underwear:</b><br><a href ='?_src_=prefs;preference=underwear;task=input'>[underwear]</a>"
				dat += "<a href='byond://?_src_=prefs;preference=toggle_random;random_type=[RANDOM_UNDERWEAR]'>[(randomise[RANDOM_UNDERWEAR]) ? "Lock" : "Unlock"]</A><br>"

				dat += "<b>Underwear Color:</b><br><span style='border: 1px solid #161616; background-color: #[underwear_color];'>&nbsp;&nbsp;&nbsp;</span> <a href='byond://?_src_=prefs;preference=underwear_color;task=input'>Change</a>"
				dat += "<a href='byond://?_src_=prefs;preference=toggle_random;random_type=[RANDOM_UNDERWEAR_COLOR]'>[(randomise[RANDOM_UNDERWEAR_COLOR]) ? "Lock" : "Unlock"]</A><br>"

				dat += "<b>Undershirt:</b><br><a href ='?_src_=prefs;preference=undershirt;task=input'>[undershirt]</a>"
				dat += "<a href='byond://?_src_=prefs;preference=toggle_random;random_type=[RANDOM_UNDERSHIRT]'>[(randomise[RANDOM_UNDERSHIRT]) ? "Lock" : "Unlock"]</A><br>"

				dat += "<b>Undershirt Color:</b><br><span style='border: 1px solid #161616; background-color: #[undershirt_color];'>&nbsp;&nbsp;&nbsp;</span> <a href='byond://?_src_=prefs;preference=undershirt_color;task=input'>Change</a>"
				dat += "<a href='byond://?_src_=prefs;preference=toggle_random;random_type=[RANDOM_UNDERSHIRT_COLOR]'>[(randomise[RANDOM_UNDERSHIRT_COLOR]) ? "Lock" : "Unlock"]</A><br>"

				dat += "<b>Socks:</b><br><a href ='?_src_=prefs;preference=socks;task=input'>[socks]</a>"
				dat += "<a href='byond://?_src_=prefs;preference=toggle_random;random_type=[RANDOM_SOCKS]'>[(randomise[RANDOM_SOCKS]) ? "Lock" : "Unlock"]</A><br>"

				dat += "<b>Socks Color:</b><br><span style='border: 1px solid #161616; background-color: #[socks_color];'>&nbsp;&nbsp;&nbsp;</span> <a href='byond://?_src_=prefs;preference=socks_color;task=input'>Change</a>"
				dat += "<a href='byond://?_src_=prefs;preference=toggle_random;random_type=[RANDOM_SOCKS_COLOR]'>[(randomise[RANDOM_SOCKS_COLOR]) ? "Lock" : "Unlock"]</A></td>"

			dat += APPEARANCE_CATEGORY_COLUMN

			if(pref_species.use_skintones)

				dat += "<h3>Skin Tone</h3>"

				dat += "<a href='byond://?_src_=prefs;preference=s_tone;task=input'>[skin_tone]</a>"
				dat += "<a href='byond://?_src_=prefs;preference=toggle_random;random_type=[RANDOM_SKIN_TONE]'>[(randomise[RANDOM_SKIN_TONE]) ? "Lock" : "Unlock"]</A>"
				dat += "<br>"

			//Height filters
			if(pref_species.use_height)

				dat += "<h3>Height</h3>"

				dat += "<a href='?_src_=prefs;preference=height_filter;task=input'>[height_filter]</a><BR>"

			// Everyone gets mutant colors now.
			dat += "<h3>Mutant Colors</h3>"

			dat += "<span style='border: 1px solid #161616; background-color: #[features["mcolor"]];'>&nbsp;&nbsp;&nbsp;</span> <a href='byond://?_src_=prefs;preference=mutant_color;task=input'>Change</a><BR>"
			dat += "<span style='border: 1px solid #161616; background-color: #[features["mcolor2"]];'>&nbsp;&nbsp;&nbsp;</span> <a href='byond://?_src_=prefs;preference=mutant_color_2;task=input'>Change</a><BR>"

			if(istype(pref_species, /datum/species/elzuose)) //not the best thing to do tbf but I dont know whats better.

				dat += "<h3>Elzuosa Color</h3>"

				dat += "<span style='border: 1px solid #161616; background-color: #[features["ethcolor"]];'>&nbsp;&nbsp;&nbsp;</span> <a href='byond://?_src_=prefs;preference=color_ethereal;task=input'>Change</a><BR>"

			var/obj/item/bodypart/head/spec_head = pref_species.species_limbs[BODY_ZONE_HEAD]
			if(initial(spec_head.draw_eyes) && initial(spec_head.greyscale_eyes))

				dat += "<h3>Eye Color</h3>"
				dat += "<span style='border: 1px solid #161616; background-color: #[eye_color];'>&nbsp;&nbsp;&nbsp;</span> <a href='byond://?_src_=prefs;preference=eyes;task=input'>Change</a>"
				dat += "<a href='byond://?_src_=prefs;preference=toggle_random;random_type=[RANDOM_EYE_COLOR]'>[(randomise[RANDOM_EYE_COLOR]) ? "Lock" : "Unlock"]</A>"

				dat += "<br></td>"

			dat += "</td>"

			if(HAIR in pref_species.species_traits)

				dat += APPEARANCE_CATEGORY_COLUMN

				dat += "<h3>Hairstyle</h3>"

				dat += "<a href='byond://?_src_=prefs;preference=hairstyle;task=input'>[hairstyle]</a>"
				dat += "<a href='byond://?_src_=prefs;preference=previous_hairstyle;task=input'>&lt;</a> <a href='byond://?_src_=prefs;preference=next_hairstyle;task=input'>&gt;</a>"
				dat += "<a href='byond://?_src_=prefs;preference=toggle_random;random_type=[RANDOM_HAIRSTYLE]'>[(randomise[RANDOM_HAIRSTYLE]) ? "Lock" : "Unlock"]</A>"

				dat += "<br><span style='border:1px solid #161616; background-color: #[hair_color];'>&nbsp;&nbsp;&nbsp;</span> <a href='byond://?_src_=prefs;preference=hair;task=input'>Change</a>"
				dat += "<a href='byond://?_src_=prefs;preference=toggle_random;random_type=[RANDOM_HAIR_COLOR]'>[(randomise[RANDOM_HAIR_COLOR]) ? "Lock" : "Unlock"]</A>"

				dat += "<h3>Hair Gradient</h3>"

				dat += "<a href='byond://?_src_=prefs;preference=hair_gradient_style;task=input'>[features["grad_style"]]</a>"

				dat += "<a href='byond://?_src_=prefs;preference=previous_hair_gradient_style;task=input'>&lt;</a> <a href='byond://?_src_=prefs;preference=next_hair_gradient_style;task=input'>&gt;</a><BR>"

				dat += "<span style='border:1px solid #161616; background-color: #[features["grad_color"]];'>&nbsp;&nbsp;&nbsp;</span> <a href='byond://?_src_=prefs;preference=hair_gradient;task=input'>Change</a>"

			if(FACEHAIR in pref_species.species_traits)

				dat += "<BR><h3>Facial Hairstyle</h3>"

				dat += "<a href='byond://?_src_=prefs;preference=facial_hairstyle;task=input'>[facial_hairstyle]</a>"
				dat += "<a href='byond://?_src_=prefs;preference=previous_facehairstyle;task=input'>&lt;</a> <a href='byond://?_src_=prefs;preference=next_facehairstyle;task=input'>&gt;</a>"
				dat += "<a href='byond://?_src_=prefs;preference=toggle_random;random_type=[RANDOM_FACIAL_HAIRSTYLE]'>[(randomise[RANDOM_FACIAL_HAIRSTYLE]) ? "Lock" : "Unlock"]</A>"

				dat += "<br><span style='border: 1px solid #161616; background-color: #[facial_hair_color];'>&nbsp;&nbsp;&nbsp;</span> <a href='byond://?_src_=prefs;preference=facial;task=input'>Change</a>"
				dat += "<a href='byond://?_src_=prefs;preference=toggle_random;random_type=[RANDOM_FACIAL_HAIR_COLOR]'>[(randomise[RANDOM_FACIAL_HAIR_COLOR]) ? "Lock" : "Unlock"]</A>"
				dat += "<br></td>"

			//Mutant stuff
			var/mutant_category = 0

			if("tail_lizard" in pref_species.default_features)
				if(!mutant_category)
					dat += APPEARANCE_CATEGORY_COLUMN

				dat += "<h3>Tail</h3>"

				dat += "<a href='byond://?_src_=prefs;preference=tail_lizard;task=input'>[features["tail_lizard"]]</a><BR>"

				mutant_category++
				if(mutant_category >= MAX_MUTANT_ROWS)
					dat += "</td>"
					mutant_category = 0

			if("face_markings" in pref_species.default_features)
				if(!mutant_category)
					dat += APPEARANCE_CATEGORY_COLUMN

				dat += "<h3>Face Marking</h3>"

				dat += "<a href='byond://?_src_=prefs;preference=face_markings;task=input'>[features["face_markings"]]</a><BR>"

				mutant_category++
				if(mutant_category >= MAX_MUTANT_ROWS)
					dat += "</td>"
					mutant_category = 0

			if("horns" in pref_species.default_features)
				if(!mutant_category)
					dat += APPEARANCE_CATEGORY_COLUMN

				dat += "<h3>Horns</h3>"

				dat += "<a href='byond://?_src_=prefs;preference=horns;task=input'>[features["horns"]]</a><BR>"
				dat += "<span style='border:1px solid #161616; background-color: #[hair_color];'>&nbsp;&nbsp;&nbsp;</span> <a href='byond://?_src_=prefs;preference=hair;task=input'>Change</a><BR>"
				dat += "<a href='byond://?_src_=prefs;preference=toggle_random;random_type=[RANDOM_HAIR_COLOR]'>[(randomise[RANDOM_HAIR_COLOR]) ? "Lock" : "Unlock"]</A><BR>"

				mutant_category++
				if(mutant_category >= MAX_MUTANT_ROWS)
					dat += "</td>"
					mutant_category = 0

			if("frills" in pref_species.default_features)
				if(!mutant_category)
					dat += APPEARANCE_CATEGORY_COLUMN

				dat += "<h3>Frills</h3>"

				dat += "<a href='byond://?_src_=prefs;preference=frills;task=input'>[features["frills"]]</a><BR>"

				mutant_category++
				if(mutant_category >= MAX_MUTANT_ROWS)
					dat += "</td>"
					mutant_category = 0

			if("spines" in pref_species.default_features)
				if(!mutant_category)
					dat += APPEARANCE_CATEGORY_COLUMN

				dat += "<h3>Spines</h3>"

				dat += "<a href='byond://?_src_=prefs;preference=spines;task=input'>[features["spines"]]</a><BR>"

				mutant_category++
				if(mutant_category >= MAX_MUTANT_ROWS)
					dat += "</td>"
					mutant_category = 0

			if("body_markings" in pref_species.default_features)
				if(!mutant_category)
					dat += APPEARANCE_CATEGORY_COLUMN

				dat += "<h3>Body Markings</h3>"

				dat += "<a href='byond://?_src_=prefs;preference=body_markings;task=input'>[features["body_markings"]]</a><BR>"

				mutant_category++
				if(mutant_category >= MAX_MUTANT_ROWS)
					dat += "</td>"
					mutant_category = 0

			if("moth_wings" in pref_species.default_features)
				if(!mutant_category)
					dat += APPEARANCE_CATEGORY_COLUMN

				dat += "<h3>Moth wings</h3>"

				dat += "<a href='byond://?_src_=prefs;preference=moth_wings;task=input'>[features["moth_wings"]]</a><BR>"

				mutant_category++
				if(mutant_category >= MAX_MUTANT_ROWS)
					dat += "</td>"
					mutant_category = 0

			if("moth_fluff" in pref_species.default_features)
				if(!mutant_category)
					dat += APPEARANCE_CATEGORY_COLUMN

				dat += "<h3>Moth fluff</h3>"

				dat += "<a href='byond://?_src_=prefs;preference=moth_fluff;task=input'>[features["moth_fluff"]]</a><BR>"

				mutant_category++
				if(mutant_category >= MAX_MUTANT_ROWS)
					dat += "</td>"
					mutant_category = 0

			if("moth_markings" in pref_species.default_features)
				if(!mutant_category)
					dat += APPEARANCE_CATEGORY_COLUMN

				dat += "<h3>Moth markings</h3>"

				dat += "<a href='byond://?_src_=prefs;preference=moth_markings;task=input'>[features["moth_markings"]]</a><BR>"

				mutant_category++
				if(mutant_category >= MAX_MUTANT_ROWS)
					dat += "</td>"
					mutant_category = 0

			if("spider_legs" in pref_species.default_features)
				if(!mutant_category)
					dat += APPEARANCE_CATEGORY_COLUMN
				dat += "<h3>Extra Legs</h3>"

				dat += "<a href='byond://?_src_=prefs;preference=spider_legs;task=input'>[features["spider_legs"]]</a><BR>"

				mutant_category++
				if(mutant_category >= MAX_MUTANT_ROWS)
					dat += "</td>"
					mutant_category = 0

			if("spider_spinneret" in pref_species.default_features)
				if(!mutant_category)
					dat += APPEARANCE_CATEGORY_COLUMN
				dat += "<h3>Spinneret</h3>"

				dat += "<a href='byond://?_src_=prefs;preference=spider_spinneret;task=input'>[features["spider_spinneret"]]</a><BR>"

				mutant_category++
				if(mutant_category >= MAX_MUTANT_ROWS)
					dat += "</td>"
					mutant_category = 0

			if("squid_face" in pref_species.default_features)
				if(!mutant_category)
					dat += APPEARANCE_CATEGORY_COLUMN

				dat += "<h3>Face Type</h3>"

				dat += "<a href='byond://?_src_=prefs;preference=squid_face;task=input'>[features["squid_face"]]</a><BR>"

				mutant_category++
				if(mutant_category >= MAX_MUTANT_ROWS)
					dat += "</td>"
					mutant_category = 0

			if("ipc_screen" in pref_species.default_features)
				if(!mutant_category)
					dat += APPEARANCE_CATEGORY_COLUMN

				dat += "<h3>Screen Style</h3>"

				dat += "<a href='byond://?_src_=prefs;preference=ipc_screen;task=input'>[features["ipc_screen"]]</a><BR>"

				dat += "<span style='border: 1px solid #161616; background-color: #[eye_color];'>&nbsp;&nbsp;&nbsp;</span> <a href='byond://?_src_=prefs;preference=eyes;task=input'>Change</a><BR>"

				mutant_category++
				if(mutant_category >= MAX_MUTANT_ROWS)
					dat += "</td>"
					mutant_category = 0

			if("ipc_antenna" in pref_species.default_features)
				if(!mutant_category)
					dat += APPEARANCE_CATEGORY_COLUMN

				dat += "<h3>Antenna Style</h3>"

				dat += "<a href='byond://?_src_=prefs;preference=ipc_antenna;task=input'>[features["ipc_antenna"]]</a><BR>"

				dat += "<span style='border:1px solid #161616; background-color: #[facial_hair_color];'>&nbsp;&nbsp;&nbsp;</span> <a href='byond://?_src_=prefs;preference=facial;task=input'>Change</a><BR>"

				mutant_category++
				if(mutant_category >= MAX_MUTANT_ROWS)
					dat += "</td>"
					mutant_category = 0

			if("ipc_tail" in pref_species.default_features)
				if(!mutant_category)
					dat += APPEARANCE_CATEGORY_COLUMN

				dat += "<h3>Tail Style</h3>"

				dat += "<a href='byond://?_src_=prefs;preference=ipc_tail;task=input'>[features["ipc_tail"]]</a><BR>"

				mutant_category++
				if(mutant_category >= MAX_MUTANT_ROWS)
					dat += "</td>"
					mutant_category = 0

			if("ipc_chassis" in pref_species.default_features)
				if(!mutant_category)
					dat += APPEARANCE_CATEGORY_COLUMN

				dat += "<h3>Chassis Style</h3>"

				dat += "<a href='byond://?_src_=prefs;preference=ipc_chassis;task=input'>[features["ipc_chassis"]]</a><BR>"

				mutant_category++
				if(mutant_category >= MAX_MUTANT_ROWS)
					dat += "</td>"
					mutant_category = 0

			if("ipc_brain" in pref_species.default_features)
				if(!mutant_category)
					dat += APPEARANCE_CATEGORY_COLUMN

				dat += "<h3>Brain Type</h3>"
				dat += "<a href='byond://?_src_=prefs;preference=ipc_brain;task=input'>[features["ipc_brain"]]</a><BR>"

				mutant_category++
				if(mutant_category >= MAX_MUTANT_ROWS)
					dat += "</td>"
					mutant_category = 0

			if("kepori_feathers" in pref_species.default_features)
				if(!mutant_category)
					dat += APPEARANCE_CATEGORY_COLUMN

				dat += "<h3>Plumage</h3>"
				dat += "<a href='byond://?_src_=prefs;preference=kepori_feathers;task=input'>[features["kepori_feathers"]]</a><BR>"
				dat += "<span style='border:1px solid #161616; background-color: #[hair_color];'>&nbsp;&nbsp;&nbsp;</span> <a href='byond://?_src_=prefs;preference=hair;task=input'>Change</a><BR>"
				dat += "<a href='byond://?_src_=prefs;preference=toggle_random;random_type=[RANDOM_HAIR_COLOR]'>[(randomise[RANDOM_HAIR_COLOR]) ? "Lock" : "Unlock"]</A><BR>"

				mutant_category++
				if(mutant_category >= MAX_MUTANT_ROWS)
					dat += "</td>"
					mutant_category = 0

			if("kepori_head_feathers" in pref_species.default_features)
				if(!mutant_category)
					dat += APPEARANCE_CATEGORY_COLUMN

				dat += "<h3>Head Feathers</h3>"
				dat += "<a href='byond://?_src_=prefs;preference=kepori_head_feathers;task=input'>[features["kepori_head_feathers"]]</a><BR>"
				dat += "<span style='border:1px solid #161616; background-color: #[features["mcolor2"]];'>&nbsp;&nbsp;&nbsp;</span> <a href='byond://?_src_=prefs;preference=mutant_color_2;task=input'>Change</a><BR>"

				mutant_category++
				if(mutant_category >= MAX_MUTANT_ROWS)
					dat += "</td>"
					mutant_category = 0

			if("kepori_body_feathers" in pref_species.default_features)
				if(!mutant_category)
					dat += APPEARANCE_CATEGORY_COLUMN

				dat += "<h3>Body Feathers</h3>"
				dat += "<a href='byond://?_src_=prefs;preference=kepori_body_feathers;task=input'>[features["kepori_body_feathers"]]</a><BR>"
				dat += "<span style='border:1px solid #161616; background-color: #[features["mcolor2"]];'>&nbsp;&nbsp;&nbsp;</span> <a href='byond://?_src_=prefs;preference=mutant_color_2;task=input'>Change</a><BR>"

				mutant_category++
				if(mutant_category >= MAX_MUTANT_ROWS)
					dat += "</td>"
					mutant_category = 0

			if("kepori_tail_feathers" in pref_species.default_features)
				if(!mutant_category)
					dat += APPEARANCE_CATEGORY_COLUMN

				dat += "<h3>Tail Feathers</h3>"
				dat += "<a href='byond://?_src_=prefs;preference=kepori_tail_feathers;task=input'>[features["kepori_tail_feathers"]]</a><BR>"
				dat += "<span style='border:1px solid #161616; background-color: #[features["mcolor2"]];'>&nbsp;&nbsp;&nbsp;</span> <a href='byond://?_src_=prefs;preference=mutant_color_2;task=input'>Change</a><BR>"

				mutant_category++
				if(mutant_category >= MAX_MUTANT_ROWS)
					dat += "</td>"
					mutant_category = 0

			if("vox_head_quills" in pref_species.default_features)
				if(!mutant_category)
					dat += APPEARANCE_CATEGORY_COLUMN

				dat += "<h3>Vox Head Quills</h3>"
				dat += "<a href='byond://?_src_=prefs;preference=vox_head_quills;task=input'>[features["vox_head_quills"]]</a><BR>"
				//dat += "<span style='border:1px solid #161616; background-color: #[hair_color];'>&nbsp;&nbsp;&nbsp;</span> <a href='byond://?_src_=prefs;preference=hair;task=input'>Change</a><BR>"
				//dat += "<a href='byond://?_src_=prefs;preference=toggle_random;random_type=[RANDOM_HAIR_COLOR]'>[(randomise[RANDOM_HAIR_COLOR]) ? "Lock" : "Unlock"]</A><BR>"

				mutant_category++
				if(mutant_category >= MAX_MUTANT_ROWS)
					dat += "</td>"
					mutant_category = 0

			if("vox_neck_quills" in pref_species.default_features)
				if(!mutant_category)
					dat += APPEARANCE_CATEGORY_COLUMN

				dat += "<h3>Vox Neck Quills</h3>"
				dat += "<a href='byond://?_src_=prefs;preference=vox_neck_quills;task=input'>[features["vox_neck_quills"]]</a><BR>"
				//dat += "<span style='border:1px solid #161616; background-color: #[facial_hair_color];'>&nbsp;&nbsp;&nbsp;</span> <a href='byond://?_src_=prefs;preference=facial;task=input'>Change</a><BR>"
				//dat += "<a href='byond://?_src_=prefs;preference=toggle_random;random_type=[RANDOM_FACIAL_HAIR_COLOR]'>[(randomise[RANDOM_FACIAL_HAIR_COLOR]) ? "Lock" : "Unlock"]</A><BR>"

				mutant_category++
				if(mutant_category >= MAX_MUTANT_ROWS)
					dat += "</td>"
					mutant_category = 0

			if("tail_human" in pref_species.default_features)
				if(!mutant_category)
					dat += APPEARANCE_CATEGORY_COLUMN

				dat += "<h3>Tail</h3>"

				dat += "<a href='byond://?_src_=prefs;preference=tail_human;task=input'>[features["tail_human"]]</a><BR>"

				mutant_category++
				if(mutant_category >= MAX_MUTANT_ROWS)
					dat += "</td>"
					mutant_category = 0

			if("ears" in pref_species.default_features)
				if(!mutant_category)
					dat += APPEARANCE_CATEGORY_COLUMN

				dat += "<h3>Mutant Ears</h3>"

				dat += "<a href='byond://?_src_=prefs;preference=ears;task=input'>[features["ears"]]</a><BR>"

				mutant_category++
				if(mutant_category >= MAX_MUTANT_ROWS)
					dat += "</td>"
					mutant_category = 0

			if("elzu_horns" in pref_species.default_features)
				if(!mutant_category)
					dat += APPEARANCE_CATEGORY_COLUMN

				dat += "<h3>Horns</h3>"

				dat += "<a href='byond://?_src_=prefs;preference=elzu_horns;task=input'>[features["elzu_horns"]]</a><BR>"

				mutant_category++
				if(mutant_category >= MAX_MUTANT_ROWS)
					dat += "</td>"
					mutant_category = 0

			if("tail_elzu" in pref_species.default_features)
				if(!mutant_category)
					dat += APPEARANCE_CATEGORY_COLUMN

				dat += "<h3>Tail</h3>"

				dat += "<a href='byond://?_src_=prefs;preference=tail_elzu;task=input'>[features["tail_elzu"]]</a><BR>"

				mutant_category++
				if(mutant_category >= MAX_MUTANT_ROWS)
					dat += "</td>"
					mutant_category = 0

			//Adds a thing to select which phobia because I can't be assed to put that in the quirks window
			if("Phobia" in all_quirks)
				if(!mutant_category)
					dat += APPEARANCE_CATEGORY_COLUMN
				dat += "<h3>Phobia</h3>"

				dat += "<a href='byond://?_src_=prefs;preference=phobia;task=input'>[phobia]</a><BR>"

				mutant_category++
				if(mutant_category >= MAX_MUTANT_ROWS)
					dat += "</td>"
					mutant_category = 0

			// begin generic adjective
			if(!mutant_category)
				dat += APPEARANCE_CATEGORY_COLUMN

			dat += "<h3>Character Adjective</h3>"

			dat += "<a href='byond://?_src_=prefs;preference=generic_adjective;task=input'>[generic_adjective]</a><BR>"

			mutant_category++
			if(mutant_category >= MAX_MUTANT_ROWS)
				dat += "</td>"
				mutant_category = 0
			// end generic adjective

			if(("wings" in pref_species.default_features) && GLOB.r_wings_list.len >1)
				if(!mutant_category)
					dat += APPEARANCE_CATEGORY_COLUMN

				dat += "<h3>Wings</h3>"

				dat += "<a href='byond://?_src_=prefs;preference=wings;task=input'>[features["wings"]]</a><BR>"

				mutant_category++
				if(mutant_category >= MAX_MUTANT_ROWS)
					dat += "</td>"
					mutant_category = 0

			if(mutant_category)
				dat += "</td>"
				mutant_category = 0
			dat += "</tr></table>"

			var/metal_skin = fbp || pref_species.inherent_biotypes & MOB_ROBOTIC
			dat += metal_skin ? "<h3>Chassis Customization</h3>" : "<h3>Prosthetic Limbs</h3>"
			dat += "<a href='byond://?_src_=prefs;preference=fbp'>Full Body Prosthesis: [fbp ? "Yes" : "No"]</a><br>"

			dat += "<a href='byond://?_src_=prefs;preference=toggle_random;random_type=[RANDOM_PROSTHETIC]'>Random Prosthetic: [(randomise[RANDOM_PROSTHETIC]) ? "Yes" : "No"]</a><br>"

			dat += "<table>"
			for(var/index in prosthetic_limbs)
				if(!metal_skin && (index == BODY_ZONE_CHEST || index == BODY_ZONE_HEAD))
					continue
				var/bodypart_name = parse_zone(index)
				dat += "<tr><td><b>[bodypart_name]:</b></td>"
				dat += "<td><a href='byond://?_src_=prefs;preference=limbs;customize_limb=[index]'>[prosthetic_limbs[index]]</a></td></tr>"
			dat += "</table><br>"

		if(2) //Loadout
			if(path)
				var/savefile/S = new /savefile(path)
				if(S)
					dat += "<center>"
					var/name
					var/unspaced_slots = 0
					for(var/i=1, i<=max_save_slots, i++)
						unspaced_slots++
						if(unspaced_slots > 4)
							dat += "<br>"
							unspaced_slots = 0
						S.cd = "/character[i]"
						S["real_name"] >> name
						if(!name)
							name = "Character[i]"
						dat += "<a style='white-space:nowrap;' href='byond://?_src_=prefs;preference=changeslot;num=[i];' [i == default_slot ? "class='linkOn'" : ""]>[name]</a> "
					dat += "</center>"
					dat += "<HR>"
			var/list/type_blacklist = list()
			if(equipped_gear && length(equipped_gear))
				for(var/i = 1, i <= length(equipped_gear), i++)
					var/datum/gear/G = GLOB.gear_datums[equipped_gear[i]]
					if(G)
						if(G.subtype_path in type_blacklist)
							continue
						type_blacklist += G.subtype_path
					else
						equipped_gear.Cut(i,i+1)

			dat += "<table align='center' width='100%'>"
			dat += "<tr><td colspan=4><center><b>Current loadout usage: [length(equipped_gear)]/[CONFIG_GET(number/max_loadout_items)]</b> \[<a href='byond://?_src_=prefs;preference=gear;clear_loadout=1'>Clear Loadout</a>\] | \[<a href='byond://?_src_=prefs;preference=gear;toggle_loadout=1'>Toggle Loadout</a>\]</center></td></tr>"
			dat += "<tr><td colspan=4><center><b>"

			var/firstcat = 1
			for(var/category in GLOB.loadout_categories)
				if(firstcat)
					firstcat = 0
				else
					dat += " |"
				if(category == gear_tab)
					dat += " [span_linkoff("[category]")] "
				else
					dat += " <a href='byond://?_src_=prefs;preference=gear;select_category=[category]'>[category]</a> "
			dat += "</b></center></td></tr>"

			var/datum/loadout_category/LC = GLOB.loadout_categories[gear_tab]
			dat += "<tr><td colspan=3><hr></td></tr>"
			dat += "<tr><td colspan=3><b><center>[LC.category]</center></b></td></tr>"
			dat += "<tr><td colspan=3><hr></td></tr>"

			dat += "<tr><td colspan=3><hr></td></tr>"
			dat += "<tr><td><b>Name</b></td>"
			dat += "<td><b>Restricted Jobs</b></td>"
			dat += "<td><b>Description</b></td>"
			dat += "<tr><td colspan=3><hr></td></tr>"
			for(var/gear_name in LC.gear)
				var/datum/gear/G = LC.gear[gear_name]
				dat += "<tr style='vertical-align:top;'><td width=20%><a style='white-space:normal;' [(G.display_name in equipped_gear) ? "class='linkOn' " : ""]href='byond://?_src_=prefs;preference=gear;toggle_gear=[G.display_name]'>[G.display_name]</a></td><td>"
				if(G.allowed_roles)
					dat += "<font size=2>"
					var/list/allowedroles = list()
					for(var/role in G.allowed_roles)
						allowedroles += role
					dat += english_list(allowedroles, null, ", ")
					dat += "</font>"
				dat += "</td><td><font size=2><i>[G.description]</i></font></td></tr>"
			dat += "</table>"

		if (3) // Game Preferences
			dat += "<table><tr><td width='340px' height='300px' valign='top'>"
			dat += "<h2>General Settings</h2>"
			dat += "<b>UI Style:</b> <a href='byond://?_src_=prefs;task=input;preference=ui'>[UI_style]</a><br>"
			dat += "<b>tgui Window Mode:</b> <a href='byond://?_src_=prefs;preference=tgui_fancy'>[(tgui_fancy) ? "Fancy (default)" : "Compatible (slower)"]</a><br>"
			dat += "<b>tgui Window Placement:</b> <a href='byond://?_src_=prefs;preference=tgui_lock'>[(tgui_lock) ? "Primary monitor" : "Free (default)"]</a><br>"
			dat += "<b>Show Runechat Chat Bubbles:</b> <a href='byond://?_src_=prefs;preference=chat_on_map'>[chat_on_map ? "Enabled" : "Disabled"]</a><br>"
			dat += "<b>Runechat message char limit:</b> <a href='byond://?_src_=prefs;preference=max_chat_length;task=input'>[max_chat_length]</a><br>"
			dat += "<b>See Runechat for non-mobs:</b> <a href='byond://?_src_=prefs;preference=see_chat_non_mob'>[see_chat_non_mob ? "Enabled" : "Disabled"]</a><br>"
			dat += "<b>See Runechat emotes:</b> <a href='byond://?_src_=prefs;preference=see_rc_emotes'>[see_rc_emotes ? "Enabled" : "Disabled"]</a><br>"
			dat += "<br>"
			dat += "<b>Outline:</b> <a href='byond://?_src_=prefs;preference=outline_enabled'>[outline_enabled ? "Enabled" : "Disabled"]</a><br>"
			dat += "<b>Outline Color:</b> <span style='border:1px solid #161616; background-color: [outline_color];'>&nbsp;&nbsp;&nbsp;</span> <a href='byond://?_src_=prefs;preference=outline_color'>Change</a><BR>"
			dat += "<br>"
			dat += "<b>Action Buttons:</b> <a href='byond://?_src_=prefs;preference=action_buttons'>[(buttons_locked) ? "Locked In Place" : "Unlocked"]</a><br>"
			dat += "<b>Hotkey mode:</b> <a href='byond://?_src_=prefs;preference=hotkeys'>[(hotkeys) ? "Hotkeys" : "Default"]</a><br>"
			dat += "<br>"
			dat += "<b>PDA Color:</b> <span style='border:1px solid #161616; background-color: [pda_color];'>&nbsp;&nbsp;&nbsp;</span> <a href='byond://?_src_=prefs;preference=pda_color;task=input'>Change</a><BR>"
			dat += "<b>PDA Style:</b> <a href='byond://?_src_=prefs;task=input;preference=pda_style'>[pda_style]</a><br>"
			dat += "<br>"
			dat += "<b>Ghost Ears:</b> <a href='byond://?_src_=prefs;preference=ghost_ears'>[(chat_toggles & CHAT_GHOSTEARS) ? "All Speech" : "Nearest Creatures"]</a><br>"
			dat += "<b>Ghost Radio:</b> <a href='byond://?_src_=prefs;preference=ghost_radio'>[(chat_toggles & CHAT_GHOSTRADIO) ? "All Messages":"No Messages"]</a><br>"
			dat += "<b>Ghost Sight:</b> <a href='byond://?_src_=prefs;preference=ghost_sight'>[(chat_toggles & CHAT_GHOSTSIGHT) ? "All Emotes" : "Nearest Creatures"]</a><br>"
			dat += "<b>Ghost Whispers:</b> <a href='byond://?_src_=prefs;preference=ghost_whispers'>[(chat_toggles & CHAT_GHOSTWHISPER) ? "All Speech" : "Nearest Creatures"]</a><br>"
			dat += "<b>Ghost PDA:</b> <a href='byond://?_src_=prefs;preference=ghost_pda'>[(chat_toggles & CHAT_GHOSTPDA) ? "All Messages" : "Nearest Creatures"]</a><br>"
			dat += "<b>Ghost Law Changes:</b> <a href='byond://?_src_=prefs;preference=ghost_laws'>[(chat_toggles & CHAT_GHOSTLAWS) ? "All Law Changes" : "No Law Changes"]</a><br>"

			if(unlock_content)
				dat += "<b>Ghost Form:</b> <a href='byond://?_src_=prefs;task=input;preference=ghostform'>[ghost_form]</a><br>"
				dat += "<B>Ghost Orbit: </B> <a href='byond://?_src_=prefs;task=input;preference=ghostorbit'>[ghost_orbit]</a><br>"

			var/button_name = "If you see this something went wrong."
			switch(ghost_accs)
				if(GHOST_ACCS_FULL)
					button_name = GHOST_ACCS_FULL_NAME
				if(GHOST_ACCS_DIR)
					button_name = GHOST_ACCS_DIR_NAME
				if(GHOST_ACCS_NONE)
					button_name = GHOST_ACCS_NONE_NAME

			dat += "<b>Ghost Accessories:</b> <a href='byond://?_src_=prefs;task=input;preference=ghostaccs'>[button_name]</a><br>"

			switch(ghost_others)
				if(GHOST_OTHERS_THEIR_SETTING)
					button_name = GHOST_OTHERS_THEIR_SETTING_NAME
				if(GHOST_OTHERS_DEFAULT_SPRITE)
					button_name = GHOST_OTHERS_DEFAULT_SPRITE_NAME
				if(GHOST_OTHERS_SIMPLE)
					button_name = GHOST_OTHERS_SIMPLE_NAME

			dat += "<b>Ghosts of Others:</b> <a href='byond://?_src_=prefs;task=input;preference=ghostothers'>[button_name]</a><br>"
			dat += "<br>"

			dat += "<b>Broadcast Login/Logout:</b> <a href='byond://?_src_=prefs;preference=broadcast_login_logout'>[broadcast_login_logout ? "Broadcast" : "Silent"]</a><br>"
			dat += "<b>See Login/Logout Messages:</b> <a href='byond://?_src_=prefs;preference=hear_login_logout'>[(chat_toggles & CHAT_LOGIN_LOGOUT) ? "Allowed" : "Muted"]</a><br>"
			dat += "<br>"

			dat += "<b>Income Updates:</b> <a href='byond://?_src_=prefs;preference=income_pings'>[(chat_toggles & CHAT_BANKCARD) ? "Allowed" : "Muted"]</a><br>"
			dat += "<br>"

			dat += "<b>FPS:</b> <a href='byond://?_src_=prefs;preference=clientfps;task=input'>[clientfps]</a><br>"

			dat += "<b>Parallax (Fancy Space):</b> <a href='byond://?_src_=prefs;preference=parallaxdown' oncontextmenu='window.location.href=\"?_src_=prefs;preference=parallaxup\";return false;'>"
			switch (parallax)
				if (PARALLAX_LOW)
					dat += "Low"
				if (PARALLAX_MED)
					dat += "Medium"
				if (PARALLAX_INSANE)
					dat += "Insane"
				if (PARALLAX_DISABLE)
					dat += "Disabled"
				else
					dat += "High"
			dat += "</a><br>"

			dat += "<b>Set screentip mode:</b> <a href='byond://?_src_=prefs;preference=screentipmode'>[screentip_pref ? "Enabled" : "Disabled"]</a><br>"
			dat += "<b>Screentip color:</b><span style='border: 1px solid #161616; background-color: [screentip_color];'>&nbsp;&nbsp;&nbsp;</span> <a href='byond://?_src_=prefs;preference=screentipcolor'>Change</a><BR>"


			dat += "<b>Ambient Occlusion:</b> <a href='byond://?_src_=prefs;preference=ambientocclusion'>[ambientocclusion ? "Enabled" : "Disabled"]</a><br>"
			dat += "<b>Fit Viewport:</b> <a href='byond://?_src_=prefs;preference=auto_fit_viewport'>[auto_fit_viewport ? "Auto" : "Manual"]</a><br>"
			if (CONFIG_GET(string/default_view) != CONFIG_GET(string/default_view_square))
				dat += "<b>Widescreen:</b> <a href='byond://?_src_=prefs;preference=widescreenpref'>[widescreenpref ? "Enabled ([CONFIG_GET(string/default_view)])" : "Disabled ([CONFIG_GET(string/default_view_square)])"]</a><br>"

			button_name = pixel_size
			dat += "<b>Pixel Scaling:</b> <a href='byond://?_src_=prefs;preference=pixel_size'>[(button_name) ? "Pixel Perfect [button_name]x" : "Stretch to fit"]</a><br>"

			switch(scaling_method)
				if(SCALING_METHOD_DISTORT)
					button_name = "Nearest Neighbor"
				if(SCALING_METHOD_NORMAL)
					button_name = "Point Sampling"
				if(SCALING_METHOD_BLUR)
					button_name = "Bilinear"

			dat += "<b>Scaling Method:</b> <a href='byond://?_src_=prefs;preference=scaling_method'>[button_name]</a><br>"

			dat += "</td><td width='300px' height='300px' valign='top'>"

			dat += "<h2>Special Role Settings</h2>"

			if(is_banned_from(user.ckey, ROLE_SYNDICATE))
				dat += "<font color=red><b>You are banned from antagonist roles.</b></font><br>"
				src.be_special = list()


			for (var/i in GLOB.special_roles)
				if(is_banned_from(user.ckey, i))
					dat += "<b>Be [capitalize(i)]:</b> <a href='byond://?_src_=prefs;bancheck=[i]'>BANNED</a><br>"
				else
					var/days_remaining = null
					if(ispath(GLOB.special_roles[i]) && CONFIG_GET(flag/use_age_restriction_for_jobs)) //If it's a game mode antag, check if the player meets the minimum age
						var/mode_path = GLOB.special_roles[i]
						var/datum/game_mode/temp_mode = new mode_path
						days_remaining = temp_mode.get_remaining_days(user.client)

					if(days_remaining)
						dat += "<b>Be [capitalize(i)]:</b> <font color=red> \[IN [days_remaining] DAYS]</font><br>"
					else
						dat += "<b>Be [capitalize(i)]:</b> <a href='byond://?_src_=prefs;preference=be_special;be_special_type=[i]'>[(i in be_special) ? "Enabled" : "Disabled"]</a><br>"
			dat += "<br>"
			dat += "<b>Midround Antagonist:</b> <a href='byond://?_src_=prefs;preference=allow_midround_antag'>[(toggles & MIDROUND_ANTAG) ? "Enabled" : "Disabled"]</a><br>"
			dat += "</td></tr></table>"
		if(4) //OOC Preferences
			dat += "<table><tr><td width='340px' height='300px' valign='top'>"
			dat += "<h2>OOC Settings</h2>"
			dat += "<b>Window Flashing:</b> <a href='byond://?_src_=prefs;preference=winflash'>[(windowflashing) ? "Enabled":"Disabled"]</a><br>"
			dat += "<br>"
			dat += "<b>Play Admin MIDIs:</b> <a href='byond://?_src_=prefs;preference=hear_midis'>[(toggles & SOUND_MIDI) ? "Enabled":"Disabled"]</a><br>"
			dat += "<b>Play Lobby Music:</b> <a href='byond://?_src_=prefs;preference=lobby_music'>[(toggles & SOUND_LOBBY) ? "Enabled":"Disabled"]</a><br>"
			dat += "<b>Play End of Round Sounds:</b> <a href='byond://?_src_=prefs;preference=endofround_sounds'>[(toggles & SOUND_ENDOFROUND) ? "Enabled":"Disabled"]</a><br>"
			dat += "<b>See Pull Requests:</b> <a href='byond://?_src_=prefs;preference=pull_requests'>[(chat_toggles & CHAT_PULLR) ? "Enabled":"Disabled"]</a><br>"
			dat += "<b>TGUI Large Buttons:</b> <a href='byond://?_src_=prefs;preference=large_tgui_buttons'>[(large_tgui_buttons) ? "Enabled":"Disabled"]</a><br>"
			dat += "<b>Swap TGUI Buttons:</b> <a href='byond://?_src_=prefs;preference=swapped_tgui_buttons'>[(swapped_tgui_buttons) ? "Enabled":"Disabled"]</a><br>"
			dat += "<b>TGUI input toggles:</b> <a href='byond://?_src_=prefs;preference=tgui_input'>[(tgui_input) ? "Enabled":"Disabled"]</a><br>"
			dat += "<br>"


			if(user.client)
				if(unlock_content)
					dat += "<b>BYOND Membership Publicity:</b> <a href='byond://?_src_=prefs;preference=publicity'>[(toggles & MEMBER_PUBLIC) ? "Public" : "Hidden"]</a><br>"

				if(unlock_content || check_rights_for(user.client, R_ADMIN) || custom_ooc)
					dat += "<b>OOC Color:</b> <span style='border: 1px solid #161616; background-color: [ooccolor ? ooccolor : GLOB.normal_ooc_colour];'>&nbsp;&nbsp;&nbsp;</span> <a href='byond://?_src_=prefs;preference=ooccolor;task=input'>Change</a><br>"

				if(hearted_until)
					dat += "<a href='byond://?_src_=prefs;preference=clear_heart'>Clear OOC Commend Heart</a><br>"

			dat += "</td>"

			if(user.client.holder)
				dat +="<td width='300px' height='300px' valign='top'>"

				dat += "<h2>Admin Settings</h2>"

				dat += "<b>Adminhelp Sounds:</b> <a href='byond://?_src_=prefs;preference=hear_adminhelps'>[(toggles & SOUND_ADMINHELP)?"Enabled":"Disabled"]</a><br>"
				dat += "<b>Prayer Sounds:</b> <a href = '?_src_=prefs;preference=hear_prayers'>[(toggles & SOUND_PRAYERS)?"Enabled":"Disabled"]</a><br>"
				dat += "<b>Announce Login:</b> <a href='byond://?_src_=prefs;preference=announce_login'>[(toggles & ANNOUNCE_LOGIN)?"Enabled":"Disabled"]</a><br>"
				dat += "<br>"
				dat += "<b>Combo HUD Lighting:</b> <a href = '?_src_=prefs;preference=combohud_lighting'>[(toggles & COMBOHUD_LIGHTING)?"Full-bright":"No Change"]</a><br>"
				dat += "<br>"
				dat += "<b>Hide Dead Chat:</b> <a href = '?_src_=prefs;preference=toggle_dead_chat'>[(chat_toggles & CHAT_DEAD)?"Shown":"Hidden"]</a><br>"
				dat += "<b>Hide Radio Messages:</b> <a href = '?_src_=prefs;preference=toggle_radio_chatter'>[(chat_toggles & CHAT_RADIO)?"Shown":"Hidden"]</a><br>"
				dat += "<b>Hide Prayers:</b> <a href = '?_src_=prefs;preference=toggle_prayers'>[(chat_toggles & CHAT_PRAYER)?"Shown":"Hidden"]</a><br>"
				dat += "<b>Split Admin Tabs:</b> <a href = '?_src_=prefs;preference=toggle_split_admin_tabs'>[(toggles & SPLIT_ADMIN_TABS)?"Enabled":"Disabled"]</a><br>"
				dat += "<b>Fast MC Refresh:</b> <a href = '?_src_=prefs;preference=toggle_fast_mc_refresh'>[(toggles & FAST_MC_REFRESH)?"Enabled":"Disabled"]</a><br>"
				dat += "<b>Briefing Officer Outfit:</b> <a href = '?_src_=prefs;preference=briefoutfit;task=input'>[brief_outfit]</a><br>"
				if(CONFIG_GET(flag/allow_admin_asaycolor))
					dat += "<br>"
					dat += "<b>ASAY Color:</b> <span style='border: 1px solid #161616; background-color: [asaycolor ? asaycolor : "#FF4500"];'>&nbsp;&nbsp;&nbsp;</span> <a href='byond://?_src_=prefs;preference=asaycolor;task=input'>Change</a><br>"

				//deadmin
				dat += "<h2>Deadmin While Playing</h2>"
				var/timegate = CONFIG_GET(number/auto_deadmin_timegate)
				if(timegate)
					dat += "<b>Noted roles will automatically deadmin during the first [FLOOR(timegate / 600, 1)] minutes of the round, and will defer to individual preferences after.</b><br>"

				if(CONFIG_GET(flag/auto_deadmin_players) && !timegate)
					dat += "<b>Always Deadmin:</b> FORCED</a><br>"
				else
					dat += "<b>Always Deadmin:</b> [timegate ? "(Time Locked) " : ""]<a href = '?_src_=prefs;preference=toggle_deadmin_always'>[(toggles & DEADMIN_ALWAYS)?"Enabled":"Disabled"]</a><br>"
					if(!(toggles & DEADMIN_ALWAYS))
						dat += "<br>"
						if(!CONFIG_GET(flag/auto_deadmin_antagonists) || (CONFIG_GET(flag/auto_deadmin_antagonists) && !timegate))
							dat += "<b>As Antag:</b> [timegate ? "(Time Locked) " : ""]<a href = '?_src_=prefs;preference=toggle_deadmin_antag'>[(toggles & DEADMIN_ANTAGONIST)?"Deadmin":"Keep Admin"]</a><br>"
						else
							dat += "<b>As Antag:</b> FORCED<br>"

						if(!CONFIG_GET(flag/auto_deadmin_heads) || (CONFIG_GET(flag/auto_deadmin_heads) && !timegate))
							dat += "<b>As Command:</b> [timegate ? "(Time Locked) " : ""]<a href = '?_src_=prefs;preference=toggle_deadmin_head'>[(toggles & DEADMIN_POSITION_HEAD)?"Deadmin":"Keep Admin"]</a><br>"
						else
							dat += "<b>As Command:</b> FORCED<br>"

						if(!CONFIG_GET(flag/auto_deadmin_security) || (CONFIG_GET(flag/auto_deadmin_security) && !timegate))
							dat += "<b>As Security:</b> [timegate ? "(Time Locked) " : ""]<a href = '?_src_=prefs;preference=toggle_deadmin_security'>[(toggles & DEADMIN_POSITION_SECURITY)?"Deadmin":"Keep Admin"]</a><br>"
						else
							dat += "<b>As Security:</b> FORCED<br>"

						if(!CONFIG_GET(flag/auto_deadmin_silicons) || (CONFIG_GET(flag/auto_deadmin_silicons) && !timegate))
							dat += "<b>As Silicon:</b> [timegate ? "(Time Locked) " : ""]<a href = '?_src_=prefs;preference=toggle_deadmin_silicon'>[(toggles & DEADMIN_POSITION_SILICON)?"Deadmin":"Keep Admin"]</a><br>"
						else
							dat += "<b>As Silicon:</b> FORCED<br>"

				dat += "</td>"
			dat += "</tr></table>"
		if(5) // Custom keybindings
			// Create an inverted list of keybindings -> key
			var/list/user_binds = list()
			for (var/key in key_bindings)
				for(var/kb_name in key_bindings[key])
					user_binds[kb_name] += list(key)

			var/list/kb_categories = list()
			// Group keybinds by category
			for (var/name in GLOB.keybindings_by_name)
				var/datum/keybinding/kb = GLOB.keybindings_by_name[name]
				kb_categories[kb.category] += list(kb)

			dat += "<style>label { display: inline-block; width: 200px; }</style><body>"

			for (var/category in kb_categories)
				dat += "<h3>[category]</h3>"
				for (var/i in kb_categories[category])
					var/datum/keybinding/kb = i
					if(!length(user_binds[kb.name]) || user_binds[kb.name][1] == "Unbound")
						dat += "<label>[kb.full_name]</label> <a href ='?_src_=prefs;preference=keybindings_capture;keybinding=[kb.name];old_key=["Unbound"]'>Unbound</a>"
						var/list/default_keys = hotkeys ? kb.hotkey_keys : kb.classic_keys
						if(LAZYLEN(default_keys))
							dat += "| Default: [default_keys.Join(", ")]"
						dat += "<br>"
					else
						var/bound_key = user_binds[kb.name][1]
						dat += "<label>[kb.full_name]</label> <a href ='?_src_=prefs;preference=keybindings_capture;keybinding=[kb.name];old_key=[bound_key]'>[bound_key]</a>"
						for(var/bound_key_index in 2 to length(user_binds[kb.name]))
							bound_key = user_binds[kb.name][bound_key_index]
							dat += " | <a href ='?_src_=prefs;preference=keybindings_capture;keybinding=[kb.name];old_key=[bound_key]'>[bound_key]</a>"
						if(length(user_binds[kb.name]) < MAX_KEYS_PER_KEYBIND)
							dat += "| <a href ='?_src_=prefs;preference=keybindings_capture;keybinding=[kb.name]'>Add Secondary</a>"
						var/list/default_keys = hotkeys ? kb.classic_keys : kb.hotkey_keys
						if(LAZYLEN(default_keys))
							dat += "| Default: [default_keys.Join(", ")]"
						dat += "<br>"

			dat += "<br><br>"
			dat += "<a href ='?_src_=prefs;preference=keybindings_reset'>\[Reset to default\]</a>"
			dat += "</body>"
	dat += "<hr><center>"

	if(!IsGuestKey(user.key))
		dat += "<a href='byond://?_src_=prefs;preference=load'>Undo</a> "
		dat += "<a href='byond://?_src_=prefs;preference=save'>Save Setup</a> "

	dat += "<a href='byond://?_src_=prefs;preference=reset_all'>Reset Setup</a>"
	dat += "</center>"

	winshow(user, "preferences_window", TRUE)
	var/datum/browser/popup = new(user, "preferences_browser", "<div align='center'>Character Setup</div>", 640, 825)
	popup.set_content(dat.Join())
	popup.open(FALSE)
	onclose(user, "preferences_window", src)

#undef APPEARANCE_CATEGORY_COLUMN
#undef MAX_MUTANT_ROWS

/datum/preferences/proc/CaptureKeybinding(mob/user, datum/keybinding/kb, old_key)
	var/HTML = {"
	<div id='focus' style="outline: 0;" tabindex=0>Keybinding: [kb.full_name]<br>[kb.description]<br><br><b>Press any key to change<br>Press ESC to clear</b></div>
	<script>
	var deedDone = false;
	document.onkeyup = function(e) {
		if(deedDone){ return; }
		var alt = e.altKey ? 1 : 0;
		var ctrl = e.ctrlKey ? 1 : 0;
		var shift = e.shiftKey ? 1 : 0;
		var numpad = (95 < e.keyCode && e.keyCode < 112) ? 1 : 0;
		var escPressed = e.keyCode == 27 ? 1 : 0;
		var url = 'byond://?_src_=prefs;preference=keybindings_set;keybinding=[kb.name];old_key=[old_key];clear_key='+escPressed+';key='+e.key+';alt='+alt+';ctrl='+ctrl+';shift='+shift+';numpad='+numpad+';key_code='+e.keyCode;
		window.location=url;
		deedDone = true;
	}
	document.getElementById('focus').focus();
	</script>
	"}
	winshow(user, "capturekeypress", TRUE)
	var/datum/browser/popup = new(user, "capturekeypress", "<div align='center'>Keybindings</div>", 350, 300)
	popup.set_content(HTML)
	popup.open(FALSE)
	onclose(user, "capturekeypress", src)

/datum/preferences/proc/SetChoices(mob/user)
	if(!SSmapping)
		return

	var/ship_selection = tgui_input_list(user, "Please select which ship to preview outfits for.", "Outfit selection", (list("None") + SSmapping.ship_purchase_list))
	if(ship_selection == "None")
		selected_outfit = new /datum/outfit //The base type outfit is nude

	var/datum/map_template/shuttle/ship = SSmapping.ship_purchase_list[ship_selection]
	if(!ship)
		return

	var/datum/job/preview_job = tgui_input_list(user, "Please select which job to preview outfits for on the [ship.name].", "Outfit selection", ship.job_slots)
	if(!preview_job?.outfit)
		return

	selected_outfit = new preview_job.outfit

/datum/preferences/proc/ShowSpeciesChoices(mob/user)
	var/list/dat = list()
	dat += "<div><table style='width:100%'><tr><th>"
	dat += "<div style='overflow-y:auto;height=180px;width=75px'>"
	for(var/speciesid in GLOB.roundstart_races)
		var/speciespath = GLOB.species_list[speciesid]
		if(!speciespath)
			continue
		var/datum/species/S = new speciespath()
		if(species_looking_at == speciesid)
			dat += "<b>[S.name]</b><BR><BR>"
		else
			dat += "<a href='byond://?_src_=prefs;preference=species;task=lookatspecies;newspecies=[speciesid]'>[S.name]</a><BR><BR>"
		QDEL_NULL(S)

	dat += "</div></th><th><div style='overflow-y:auto;height=180px;width=420px'>"
	var/sppath = GLOB.species_list[species_looking_at]
	var/datum/species/S = new sppath()

	dat += "<center><font size=3 style='font-weight:bold'>[S.name]</font><BR><BR>[S.loreblurb]</center></div></th><th>"
	if(pref_species.id == species_looking_at)
		dat += "Set Species "
	else
		dat += "<a href='byond://?_src_=prefs;preference=species;task=setspecies;newspecies=[species_looking_at]'>Set Species</a> "
	dat += "<a href='byond://?_src_=prefs;preference=species;task=close'>Done</a><BR>"
	user << browse(null, "window=preferences")
	var/datum/browser/popup = new(user, "mob_species", "<div align='center'>Species Pick</div>", 700, 350)
	popup.set_window_options("can_close=0")
	popup.set_content(dat.Join())
	popup.open(FALSE)
	QDEL_NULL(S)

/datum/preferences/proc/SetQuirks(mob/user)
	if(!SSquirks)
		to_chat(user, span_danger("The quirk subsystem is still initializing! Try again in a minute."))
		return

	var/list/dat = list()
	if(!SSquirks.quirks.len)
		dat += "The quirk subsystem hasn't finished initializing, please hold..."
		dat += "<center><a href='byond://?_src_=prefs;preference=trait;task=close'>Done</a></center><br>"
	else
		var/list/quirk_conflicts = check_quirk_compatibility(user)
		dat += "<center><b>Choose quirk setup</b></center><br>"
		dat += "<div align='center'>Left-click to add or remove quirks. You need negative quirks to have positive ones.<br>\
		Quirks are applied at roundstart and cannot normally be removed.</div>"
		dat += "<center><a href='byond://?_src_=prefs;preference=trait;task=close'>Done</a></center>"
		dat += "<hr>"
		dat += "<center><b>Current quirks:</b> [all_quirks.len ? all_quirks.Join(", ") : "None"]</center>"
		dat += "<center>[GetPositiveQuirkCount()] / [MAX_QUIRKS] max positive quirks<br>\
		<b>Quirk balance remaining:</b> [GetQuirkBalance()]</center><br>"
		for(var/quirk_index in SSquirks.quirks)
			var/datum/quirk/quirk_datum = SSquirks.quirks[quirk_index]
			var/has_quirk
			var/quirk_cost = initial(quirk_datum.value)
			for(var/quirk_owned in all_quirks)
				if(quirk_owned == initial(quirk_datum.name))
					has_quirk = TRUE
			if(has_quirk)
				quirk_cost *= -1 //invert it.
			if(quirk_cost > 0)
				quirk_cost = "+[quirk_cost]"
			var/font_color = "#AAAAFF"
			if(initial(quirk_datum.value) != 0)
				font_color = initial(quirk_datum.value) > 0 ? "#AAFFAA" : "#FFAAAA"
			if(quirk_conflicts[initial(quirk_datum.name)])
				if(!has_quirk)
					dat += "<font color='[font_color]'>[initial(quirk_datum.name)]</font> - [initial(quirk_datum.desc)] \
					<font color='red'><b>LOCKED: [quirk_conflicts[initial(quirk_datum.name)]]</b></font><br>"
				else
					alert(user, "Something went wrong, you had somehow had a conflicting quirk that didn't get cleared during conflict checks, please open an issue or otherwise notify coders of such.")
					all_quirks = list()
					user << browse(null, "window=mob_occupation")
					ShowChoices(user)
					save_preferences()
			else
				if(has_quirk)
					dat += "<a href='byond://?_src_=prefs;preference=trait;task=update;trait=[initial(quirk_datum.name)]'>[has_quirk ? "Remove" : "Take"] ([quirk_cost] pts.)</a> \
					<b><font color='[font_color]'>[initial(quirk_datum.name)]</font></b> - [initial(quirk_datum.desc)]<br>"
				else
					dat += "<a href='byond://?_src_=prefs;preference=trait;task=update;trait=[initial(quirk_datum.name)]'>[has_quirk ? "Remove" : "Take"] ([quirk_cost] pts.)</a> \
					<font color='[font_color]'>[initial(quirk_datum.name)]</font> - [initial(quirk_datum.desc)]<br>"
		dat += "<br><center><a href='byond://?_src_=prefs;preference=trait;task=reset'>Reset Quirks</a></center>"

	var/datum/browser/popup = new(user, "mob_trait", "<div align='center'>Quirk Preferences</div>", 900, 650) //no reason not to reuse the occupation window, as it's cleaner that way
	popup.set_window_options("can_close=0")
	popup.set_content(dat.Join())
	popup.open(FALSE)

/**
 * Proc called to track what quirks conflict with someone's preferences, returns a list with all quirks that conflict.
 *
 * Not to be used to actually handle conflicts, see handle_conflicts() for that, which is called once for each possible type of conflict if needed.
**/
/datum/preferences/proc/check_quirk_compatibility(mob/user)
	var/list/quirk_conflicts = list()
	var/list/handled_conflicts = list()
	for(var/quirk_name in SSquirks.quirks)
		var/datum/quirk/quirk_type = SSquirks.quirks[quirk_name]
		if(initial(quirk_type.mood_quirk) && CONFIG_GET(flag/disable_human_mood))
			quirk_conflicts[quirk_name] = "Mood and mood quirks are disabled."
			if(!handled_conflicts["mood"])
				handle_quirk_conflict("mood", null, user)
				handled_conflicts["mood"] = TRUE
		if((quirk_name in SSquirks.species_blacklist) && (pref_species.id in SSquirks.species_blacklist[quirk_name]))
			quirk_conflicts[quirk_name] = "Quirk unavailable to species."
			if(!handled_conflicts["species"])
				handle_quirk_conflict("species", pref_species, user)
				handled_conflicts["species"] = TRUE
		for(var/blacklist in SSquirks.quirk_blacklist)
			for(var/quirk_blacklisted in all_quirks)
				if((quirk_blacklisted in blacklist) && !quirk_conflicts[quirk_name] && (quirk_name in blacklist) && !(quirk_name == quirk_blacklisted))
					quirk_conflicts[quirk_name] = "Quirk is mutually exclusive with [quirk_blacklisted]."
					if(!handled_conflicts["blacklist"])
						handle_quirk_conflict("blacklist", null, user)
						handled_conflicts["blacklist"] = TRUE
	return quirk_conflicts
/**
 * Proc called when there is a need to handle quirk conflicts.
 *
 * This evaluates what quirks conflict and removes them.
 * Arguments:
 * * change_type - Currently can only be, "blacklist", "species" or "mood", defines what kind of conflict it should look for.
 * * additional_argument - Supplies the species datum and can supply something else if this proc gets expanded.
**/
/datum/preferences/proc/handle_quirk_conflict(change_type, additional_argument, mob/user)
	var/list/all_quirks_new = list()
	all_quirks_new += all_quirks
	var/balance
	var/datum/species/target_species
	if(change_type == "species")
		if(additional_argument)
			target_species = additional_argument
		else
			return
	for(var/quirk_name in all_quirks)
		var/datum/quirk/quirk_type = SSquirks.quirks[quirk_name]
		balance -= initial(quirk_type.value)
		switch(change_type)
			if("species")
				if((quirk_name in SSquirks.species_blacklist) && (target_species.id in SSquirks.species_blacklist[quirk_name]))
					all_quirks_new -= quirk_name
					balance += initial(quirk_type.value)
			if("mood")
				if(initial(quirk_type.mood_quirk))
					all_quirks_new -= quirk_name
					balance += initial(quirk_type.value)
			if("blacklist")
				for(var/blacklist in SSquirks.quirk_blacklist)
					for(var/quirk_blacklisted in all_quirks_new)
						if((quirk_blacklisted in blacklist) && (quirk_name in blacklist) && !(quirk_name == quirk_blacklisted))
							all_quirks_new -= quirk_name
							balance += initial(quirk_type.value)
	if(balance < 0)
		var/list/positive_quirks = list()
		for(var/quirk_owned in all_quirks_new)
			var/datum/quirk/quirk_owned_datum = SSquirks.quirks[quirk_owned]
			var/quirk_value = initial(quirk_owned_datum.value)
			if(quirk_value > 0)
				positive_quirks |= quirk_owned_datum
		positive_quirks = sortList(positive_quirks, /proc/cmp_quirk_value_dsc)
		var/counter = 1
		while(balance < 0)
			var/datum/quirk/positive_quirk = positive_quirks[counter]
			if(balance >= initial(positive_quirk.value) || (balance < initial(positive_quirk.value) && counter == length(positive_quirks)))
				all_quirks_new -= initial(positive_quirk.name)
				balance += initial(positive_quirk.value)
				positive_quirks -= positive_quirk
				counter = counter == 1 ? 1 : counter - 1
			else
				counter++
			if((length(positive_quirks) < 1) && (balance < 0))
				stack_trace("Client [user?.client?.ckey] has a negative balance without positive quirks.")
				all_quirks_new = list()
				alert(user, "Something went very wrong with your quirks, they have been reset.")
	if(change_type == "blacklist" || ((target_species.id == pref_species.id) && change_type == "species") || (change_type = "mood" && CONFIG_GET(flag/disable_human_mood)))
		all_quirks = all_quirks_new
		save_character()
	if(all_quirks_new != all_quirks)
		to_chat(user, span_danger("Your quirks have been altered."))
		return all_quirks_new

/datum/preferences/proc/GetQuirkBalance()
	var/bal = 0
	for(var/V in all_quirks)
		var/datum/quirk/T = SSquirks.quirks[V]
		bal -= initial(T.value)
	return bal

/datum/preferences/proc/GetPositiveQuirkCount()
	. = 0
	for(var/q in all_quirks)
		if(SSquirks.quirk_points[q] > 0)
			.++

/datum/preferences/proc/init_learned_languages()
	learned_languages = list()
	for(var/datum/language/lang_type as anything in subtypesof(/datum/language))
		if(initial(lang_type.flags) & ROUNDSTART_LANGUAGE)
			learned_languages[lang_type] = LANGUAGE_UNKNOWN

/datum/preferences/proc/get_language_point_balance()
	var/points_balance = MAX_LANGUAGE_POINTS
	for(var/datum/language/lang_type as anything in learned_languages)
		if(lang_type == native_language)
			continue // this should happen but just in case
		points_balance -= language_level_costs[learned_languages[lang_type]]
	if("Trilingual" in all_quirks)
		points_balance += 2
	if("Monolingual" in all_quirks)
		points_balance -= 2
	return points_balance

/datum/preferences/Topic(href, href_list, hsrc)			//yeah, gotta do this I guess..
	. = ..()
	if(href_list["close"])
		var/client/C = usr.client
		if(C)
			C.clear_character_previews()

/datum/preferences/proc/process_link(mob/user, list/href_list)
	if(href_list["bancheck"])
		var/list/ban_details = is_banned_from_with_details(user.ckey, user.client.address, user.client.computer_id, href_list["bancheck"])
		var/admin = FALSE
		if(GLOB.admin_datums[user.ckey] || GLOB.deadmins[user.ckey])
			admin = TRUE
		for(var/i in ban_details)
			if(admin && !text2num(i["applies_to_admins"]))
				continue
			ban_details = i
			break //we only want to get the most recent ban's details
		if(ban_details && ban_details.len)
			var/expires = "This is a permanent ban."
			if(ban_details["expiration_time"])
				expires = " The ban is for [DisplayTimeText(text2num(ban_details["duration"]) MINUTES)] and expires on [ban_details["expiration_time"]] (server time)."
			to_chat(user, span_danger("You, or another user of this computer or connection ([ban_details["key"]]) is banned from playing [href_list["bancheck"]].<br>The ban reason is: [ban_details["reason"]]<br>This ban (BanID #[ban_details["id"]]) was applied by [ban_details["admin_key"]] on [ban_details["bantime"]] during round ID [ban_details["round_id"]].<br>[expires]"))
			return
	if(href_list["preference"] == "job")
		SetChoices(user)
		ShowChoices(user)
		return TRUE

	if(href_list["preference"] == "species")
		switch(href_list["task"])
			if("random")
				random_species()
				ShowChoices(user)
				return TRUE
			if("close")
				user << browse(null, "window=mob_species")
				ShowChoices(user)
				return TRUE
			if("setspecies")
				var/sid = href_list["newspecies"]
				var/newtype = GLOB.species_list[sid]
				pref_species = new newtype()
				//Now that we changed our species, we must verify that the mutant colour is still allowed.
				var/temp_hsv = RGBtoHSV(features["mcolor"])
				if(text2num(features["mcolor"], 16) == 0  || (!(MUTCOLORS_PARTSONLY in pref_species.species_traits) && ReadHSV(temp_hsv)[3] < ReadHSV("#191919")[3]))
					features["mcolor"] = pref_species.default_color
				user << browse(null, "window=speciespick")
				ShowChoices(user)
				age = rand(pref_species.species_age_min, pref_species.species_age_max)
				handle_quirk_conflict("species", pref_species)
				return TRUE
			if("lookatspecies")
				species_looking_at = href_list["newspecies"]

		ShowSpeciesChoices(user)
		return TRUE

	if(href_list["preference"] == "trait")
		switch(href_list["task"])
			if("close")
				user << browse(null, "window=mob_trait")
				ShowChoices(user)
			if("update")
				var/quirk = href_list["trait"]
				if(!SSquirks.quirks[quirk])
					return
				var/value = SSquirks.quirk_points[quirk]
				var/balance = GetQuirkBalance()
				if(quirk in all_quirks)
					if(balance + value < 0)
						to_chat(user, span_warning("Refunding this would cause you to go below your balance!"))
						return
					all_quirks -= quirk
				else
					var/is_positive_quirk = SSquirks.quirk_points[quirk] > 0
					if(is_positive_quirk && GetPositiveQuirkCount() >= MAX_QUIRKS)
						to_chat(user, span_warning("You can't have more than [MAX_QUIRKS] positive quirks!"))
						return
					if(balance - value < 0)
						to_chat(user, span_warning("You don't have enough balance to gain this quirk!"))
						return
					all_quirks += quirk
				SetQuirks(user)
			if("reset")
				all_quirks = list()
				SetQuirks(user)
			else
				SetQuirks(user)
		return TRUE

	if(href_list["preference"] == "gear")
		if(href_list["toggle_gear"])
			var/datum/gear/TG = GLOB.gear_datums[href_list["toggle_gear"]]
			if(TG.display_name in equipped_gear)
				equipped_gear -= TG.display_name
			else
				if(length(equipped_gear) >= CONFIG_GET(number/max_loadout_items))
					alert(user, "You can't have more than [CONFIG_GET(number/max_loadout_items)] items in your loadout!")
					return
				var/list/type_blacklist = list()
				var/list/slot_blacklist = list()
				for(var/gear_name in equipped_gear)
					var/datum/gear/G = GLOB.gear_datums[gear_name]
					if(istype(G))
						if(G.subtype_path in type_blacklist)
							continue
						type_blacklist += G.subtype_path
				if(!(TG.subtype_path in type_blacklist) || !(TG.slot in slot_blacklist))
					equipped_gear += TG.display_name
				else
					alert(user, "Can't equip [TG.display_name]. It conflicts with an already-equipped item.")
			save_preferences()

		else if(href_list["select_category"])
			gear_tab = href_list["select_category"]
		else if(href_list["clear_loadout"])
			equipped_gear.Cut()
		else if(href_list["toggle_loadout"])
			show_loadout = !show_loadout

		ShowChoices(user)
		return

	switch(href_list["task"])
		if("random")
			switch(href_list["preference"])
				if("name")
					real_name = pref_species.random_name(gender,1)
				if("age")
					age = rand(pref_species.species_age_min, pref_species.species_age_max)
				if("hair")
					hair_color = random_color_natural()
				if("hairstyle")
					hairstyle = random_hairstyle(gender)
				if("facial")
					facial_hair_color = random_color_natural()
				if("facial_hairstyle")
					facial_hairstyle = random_facial_hairstyle(gender)
				if("underwear")
					underwear = random_underwear(gender)
				if("underwear_color")
					underwear_color = random_color()
				if("undershirt")
					undershirt = random_undershirt(gender)
				if("undershirt_color")
					undershirt_color = random_short_color()
				if("socks")
					socks = random_socks()
				if("socks_color")
					socks_color = random_short_color()
				if("eyes")
					eye_color = random_eye_color()
				if("s_tone")
					skin_tone = random_skin_tone()
				if("bag")
					backpack = pick(GLOB.backpacklist)
				if("suit")
					jumpsuit_style = pick(GLOB.jumpsuitlist)
				if("exo")
					exowear = pick(GLOB.exowearlist)
				if("all")
					random_character(gender)


		if("input")

			if(href_list["preference"] in GLOB.preferences_custom_names)
				ask_for_custom_name(user,href_list["preference"])


			switch(href_list["preference"])
				if("ghostform")
					if(unlock_content)
						var/new_form = input(user, "Thanks for supporting BYOND - Choose your ghostly form:","Thanks for supporting BYOND",null) as null|anything in GLOB.ghost_forms
						if(new_form)
							ghost_form = new_form
				if("ghostorbit")
					if(unlock_content)
						var/new_orbit = input(user, "Thanks for supporting BYOND - Choose your ghostly orbit:","Thanks for supporting BYOND", null) as null|anything in GLOB.ghost_orbits
						if(new_orbit)
							ghost_orbit = new_orbit

				if("ghostaccs")
					var/new_ghost_accs = alert("Do you want your ghost to show full accessories where possible, hide accessories but still use the directional sprites where possible, or also ignore the directions and stick to the default sprites?",,GHOST_ACCS_FULL_NAME, GHOST_ACCS_DIR_NAME, GHOST_ACCS_NONE_NAME)
					switch(new_ghost_accs)
						if(GHOST_ACCS_FULL_NAME)
							ghost_accs = GHOST_ACCS_FULL
						if(GHOST_ACCS_DIR_NAME)
							ghost_accs = GHOST_ACCS_DIR
						if(GHOST_ACCS_NONE_NAME)
							ghost_accs = GHOST_ACCS_NONE

				if("ghostothers")
					var/new_ghost_others = alert("Do you want the ghosts of others to show up as their own setting, as their default sprites or always as the default white ghost?",,GHOST_OTHERS_THEIR_SETTING_NAME, GHOST_OTHERS_DEFAULT_SPRITE_NAME, GHOST_OTHERS_SIMPLE_NAME)
					switch(new_ghost_others)
						if(GHOST_OTHERS_THEIR_SETTING_NAME)
							ghost_others = GHOST_OTHERS_THEIR_SETTING
						if(GHOST_OTHERS_DEFAULT_SPRITE_NAME)
							ghost_others = GHOST_OTHERS_DEFAULT_SPRITE
						if(GHOST_OTHERS_SIMPLE_NAME)
							ghost_others = GHOST_OTHERS_SIMPLE

				if("name")
					var/new_name =  reject_bad_name( input(user, "Choose your character's name:", "Character Preference")  as text|null)
					if(new_name)
						real_name = new_name
					else
						to_chat(user, "<font color='red'>Invalid name. Your name should be at least 2 and at most [MAX_NAME_LEN] characters long. It may only contain the characters A-Z, a-z, 0-9, and the following punctuation: ' - . ~ | @ : # $ % & * +</font>")

				if("age")
					var/new_age = input(user, "Choose your character's age:\n([pref_species.species_age_min]-[pref_species.species_age_max])", "Character Preference") as num|null
					if(new_age)
						age = clamp(round(text2num(new_age)), pref_species.species_age_min, pref_species.species_age_max)

				if("flavor_text")
					var/msg = tgui_input_text(usr, "A snippet of text shown when others examine you, describing what you may look like. This can also be used for OOC notes.", "Flavor Text", html_decode(features["flavor_text"]), MAX_FLAVOR_LEN, TRUE)
					if(msg) //WS edit - "Cancel" does not clear flavor text
						features["flavor_text"] = msg

				if("hair")
					var/new_hair = input(user, "Choose your character's hair colour:", "Character Preference","#"+hair_color) as color|null
					if(new_hair)
						hair_color = sanitize_hexcolor(new_hair)

				if("hairstyle")
					var/new_hairstyle
					if(gender == MALE)
						new_hairstyle = input(user, "Choose your character's hairstyle:", "Character Preference")  as null|anything in GLOB.hairstyles_male_list
					else if(gender == FEMALE)
						new_hairstyle = input(user, "Choose your character's hairstyle:", "Character Preference")  as null|anything in GLOB.hairstyles_female_list
					else
						new_hairstyle = input(user, "Choose your character's hairstyle:", "Character Preference")  as null|anything in GLOB.hairstyles_list
					if(new_hairstyle)
						hairstyle = new_hairstyle

				if("next_hairstyle")
					if (gender == MALE)
						hairstyle = next_list_item(hairstyle, GLOB.hairstyles_male_list)
					else if(gender == FEMALE)
						hairstyle = next_list_item(hairstyle, GLOB.hairstyles_female_list)
					else
						hairstyle = next_list_item(hairstyle, GLOB.hairstyles_list)

				if("previous_hairstyle")
					if (gender == MALE)
						hairstyle = previous_list_item(hairstyle, GLOB.hairstyles_male_list)
					else if(gender == FEMALE)
						hairstyle = previous_list_item(hairstyle, GLOB.hairstyles_female_list)
					else
						hairstyle = previous_list_item(hairstyle, GLOB.hairstyles_list)

				if("facial")
					var/new_facial = input(user, "Choose your character's facial-hair colour:", "Character Preference","#"+facial_hair_color) as color|null
					if(new_facial)
						facial_hair_color = sanitize_hexcolor(new_facial)

				if("facial_hairstyle")
					var/new_facial_hairstyle
					if(gender == MALE)
						new_facial_hairstyle = input(user, "Choose your character's facial-hairstyle:", "Character Preference")  as null|anything in GLOB.facial_hairstyles_male_list
					else if(gender == FEMALE)
						new_facial_hairstyle = input(user, "Choose your character's facial-hairstyle:", "Character Preference")  as null|anything in GLOB.facial_hairstyles_female_list
					else
						new_facial_hairstyle = input(user, "Choose your character's facial-hairstyle:", "Character Preference")  as null|anything in GLOB.facial_hairstyles_list
					if(new_facial_hairstyle)
						facial_hairstyle = new_facial_hairstyle

				if("next_facehairstyle")
					if (gender == MALE)
						facial_hairstyle = next_list_item(facial_hairstyle, GLOB.facial_hairstyles_male_list)
					else if(gender == FEMALE)
						facial_hairstyle = next_list_item(facial_hairstyle, GLOB.facial_hairstyles_female_list)
					else
						facial_hairstyle = next_list_item(facial_hairstyle, GLOB.facial_hairstyles_list)

				if("previous_facehairstyle")
					if (gender == MALE)
						facial_hairstyle = previous_list_item(facial_hairstyle, GLOB.facial_hairstyles_male_list)
					else if (gender == FEMALE)
						facial_hairstyle = previous_list_item(facial_hairstyle, GLOB.facial_hairstyles_female_list)
					else
						facial_hairstyle = previous_list_item(facial_hairstyle, GLOB.facial_hairstyles_list)

				if("hair_gradient")
					var/new_hair_gradient_color = input(user, "Choose your character's hair gradient colour:", "Character Preference","#"+features["grad_color"]) as color|null
					if(new_hair_gradient_color)
						features["grad_color"] = sanitize_hexcolor(new_hair_gradient_color)

				if("hair_gradient_style")
					var/new_gradient_style
					new_gradient_style = input(user, "Choose your character's hair gradient style:", "Character Preference")  as null|anything in GLOB.hair_gradients_list
					if(new_gradient_style)
						features["grad_style"] = new_gradient_style

				if("next_hair_gradient_style")
					features["grad_style"] = next_list_item(features["grad_style"], GLOB.hair_gradients_list)

				if("previous_hair_gradient_style")
					features["grad_style"] = previous_list_item(features["grad_style"], GLOB.hair_gradients_list)

				if("underwear")
					var/new_underwear
					new_underwear = input(user, "Choose your character's underwear:", "Character Preference")  as null|anything in GLOB.underwear_list
					if(new_underwear)
						underwear = new_underwear

				if("underwear_color")
					var/new_underwear_color = input(user, "Choose your character's underwear color:", "Character Preference","#"+underwear_color) as color|null
					if(new_underwear_color)
						underwear_color = sanitize_hexcolor(new_underwear_color)

				if("undershirt")
					var/new_undershirt
					new_undershirt = input(user, "Choose your character's undershirt:", "Character Preference") as null|anything in GLOB.undershirt_list
					if(new_undershirt)
						undershirt = new_undershirt

				if("undershirt_color")
					var/new_undershirt_color = input(user, "Choose your character's underwear color:", "Character Preference","#"+undershirt_color) as color|null
					if(new_undershirt_color)
						undershirt_color = sanitize_hexcolor(new_undershirt_color)

				if("socks")
					var/new_socks
					new_socks = input(user, "Choose your character's socks:", "Character Preference") as null|anything in GLOB.socks_list
					if(new_socks)
						socks = new_socks

				if("socks_color")
					var/new_socks_color = input(user, "Choose your character's underwear color:", "Character Preference","#"+socks_color) as color|null
					if(new_socks_color)
						socks_color = sanitize_hexcolor(new_socks_color)

				if("eyes")
					var/new_eyes = input(user, "Choose your character's eye colour:", "Character Preference","#"+eye_color) as color|null
					if(new_eyes)
						eye_color = sanitize_hexcolor(new_eyes)

				if("height_filter")
					var/list/height_filters_available = list()
					height_filters_available ^= GLOB.height_filters
					var/new_height = input(user, "Choose your character's height:", "Character Preference") as null|anything in height_filters_available
					if(new_height)
						height_filter = new_height


				if("mutant_color")
					var/new_mutantcolor = input(user, "Choose your character's primary alien/mutant color:", "Character Preference","#" + features["mcolor"]) as color|null
					if(new_mutantcolor)
						var/temp_hsv = RGBtoHSV(new_mutantcolor)
						if(new_mutantcolor == "#000000")
							features["mcolor"] = pref_species.default_color
						else if((MUTCOLORS_PARTSONLY in pref_species.species_traits) || ReadHSV(temp_hsv)[3] >= ReadHSV("#191919")[3]) // mutantcolors must be bright, but only if they affect the skin
							features["mcolor"] = sanitize_hexcolor(new_mutantcolor)
						else
							to_chat(user, span_danger("Invalid color. Your color is not bright enough."))

				if("mutant_color_2")
					var/new_mutantcolor = input(user, "Choose your character's secondary alien/mutant color:", "Character Preference","#" + features["mcolor2"]) as color|null
					if(new_mutantcolor)
						var/temp_hsv = RGBtoHSV(new_mutantcolor)
						if(new_mutantcolor == "#000000")
							features["mcolor2"] = pref_species.default_color
						else if((MUTCOLORS_PARTSONLY in pref_species.species_traits) || ReadHSV(temp_hsv)[3] >= ReadHSV("#191919")[3]) // mutantcolors must be bright, but only if they affect the skin
							features["mcolor2"] = sanitize_hexcolor(new_mutantcolor)
						else
							to_chat(user, span_danger("Invalid color. Your color is not bright enough."))

				if("color_ethereal")
					var/new_etherealcolor = input(user, "Choose your elzuose color:", "Character Preference","#"+features["ethcolor"]) as color|null
					if(new_etherealcolor)
						var/temp_hsv = RGBtoHSV(new_etherealcolor)
						if(ReadHSV(temp_hsv)[3] >= ReadHSV("#505050")[3]) // elzu colors should be bright
							features["ethcolor"] = sanitize_hexcolor(new_etherealcolor)
						else
							to_chat(user, span_danger("Invalid color. Your color is not bright enough."))


				if("tail_lizard")
					var/new_tail
					new_tail = input(user, "Choose your character's tail:", "Character Preference") as null|anything in GLOB.tails_list_lizard
					if(new_tail)
						features["tail_lizard"] = new_tail

				if("tail_human")
					var/new_tail
					new_tail = input(user, "Choose your character's tail:", "Character Preference") as null|anything in GLOB.tails_list_human
					if(new_tail)
						features["tail_human"] = new_tail

				if("face_markings")
					var/new_face_markings
					new_face_markings = input(user, "Choose your character's face markings:", "Character Preference") as null|anything in GLOB.face_markings_list
					if(new_face_markings)
						features["face_markings"] = new_face_markings

				if("horns")
					var/new_horns
					new_horns = input(user, "Choose your character's horns:", "Character Preference") as null|anything in GLOB.horns_list
					if(new_horns)
						features["horns"] = new_horns

				if("ears")
					var/new_ears
					new_ears = input(user, "Choose your character's mutant ears:", "Character Preference") as null|anything in GLOB.ears_list
					if(new_ears)
						features["ears"] = new_ears

				if("wings")
					var/new_wings
					new_wings = input(user, "Choose your character's wings:", "Character Preference") as null|anything in GLOB.r_wings_list
					if(new_wings)
						features["wings"] = new_wings

				if("frills")
					var/new_frills
					new_frills = input(user, "Choose your character's frills:", "Character Preference") as null|anything in GLOB.frills_list
					if(new_frills)
						features["frills"] = new_frills

				if("spines")
					var/new_spines
					new_spines = input(user, "Choose your character's spines:", "Character Preference") as null|anything in GLOB.spines_list
					if(new_spines)
						features["spines"] = new_spines

				if("body_markings")
					var/new_body_markings
					new_body_markings = input(user, "Choose your character's body markings:", "Character Preference") as null|anything in GLOB.body_markings_list
					if(new_body_markings)
						features["body_markings"] = new_body_markings

				if("moth_wings")
					var/new_moth_wings
					new_moth_wings = input(user, "Choose your character's wings:", "Character Preference") as null|anything in GLOB.moth_wings_list
					if(new_moth_wings)
						features["moth_wings"] = new_moth_wings

				if("moth_fluff")
					var/new_moth_fluff
					new_moth_fluff = input(user, "Choose your character's fluff:", "Character Preference") as null|anything in GLOB.moth_fluff_list
					if(new_moth_fluff)
						features["moth_fluff"] = new_moth_fluff

				if("moth_markings")
					var/new_moth_markings
					new_moth_markings = input(user, "Choose your character's markings:", "Character Preference") as null|anything in GLOB.moth_markings_list
					if(new_moth_markings)
						features["moth_markings"] = new_moth_markings

				if("spider_legs")
					var/new_spider_legs
					new_spider_legs = input(user, "Choose your character's variant of spider legs:", "Character Preference") as null|anything in GLOB.spider_legs_list
					if(new_spider_legs)
						features["spider_legs"] = new_spider_legs

				if("spider_spinneret")
					var/new_spider_spinneret
					new_spider_spinneret = input(user, "Choose your character's spinneret markings:", "Character Preference") as null|anything in GLOB.spider_spinneret_list
					if(new_spider_spinneret)
						features["spider_spinneret"] = new_spider_spinneret

				if("ipc_screen")
					var/new_ipc_screen

					new_ipc_screen = input(user, "Choose your character's screen:", "Character Preference") as null|anything in GLOB.ipc_screens_list

					if(new_ipc_screen)
						features["ipc_screen"] = new_ipc_screen

				if("ipc_antenna")
					var/new_ipc_antenna

					new_ipc_antenna = input(user, "Choose your character's antenna:", "Character Preference") as null|anything in GLOB.ipc_antennas_list

					if(new_ipc_antenna)
						features["ipc_antenna"] = new_ipc_antenna

				if("ipc_tail")
					var/new_ipc_tail

					new_ipc_tail = input(user, "Choose your character's tail:", "Character Preference") as null|anything in GLOB.ipc_tail_list

					if(new_ipc_tail)
						features["ipc_tail"] = new_ipc_tail

				if("ipc_chassis")
					var/new_ipc_chassis

					new_ipc_chassis = input(user, "Choose your character's chassis:", "Character Preference") as null|anything in GLOB.ipc_chassis_list

					if(new_ipc_chassis)
						features["ipc_chassis"] = new_ipc_chassis

				if("ipc_brain")
					var/new_ipc_brain
					new_ipc_brain = input(user, "Choose your character's brain type:", "Character Preference") as null|anything in GLOB.ipc_brain_list
					if(new_ipc_brain)
						features["ipc_brain"] = new_ipc_brain

				if("kepori_feathers")
					var/new_kepori_feathers
					new_kepori_feathers = input(user, "Choose your character's plumage type:", "Character Preference") as null|anything in GLOB.kepori_feathers_list
					if (new_kepori_feathers)
						features["kepori_feathers"] = new_kepori_feathers

				if("kepori_head_feathers")
					var/new_kepori_feathers
					new_kepori_feathers = input(user, "Choose your character's head feathers:", "Character Preference") as null|anything in GLOB.kepori_head_feathers_list
					if (new_kepori_feathers)
						features["kepori_head_feathers"] = new_kepori_feathers

				if("kepori_body_feathers")
					var/new_kepori_feathers
					new_kepori_feathers = input(user, "Choose your character's body feathers:", "Character Preference") as null|anything in GLOB.kepori_body_feathers_list
					if (new_kepori_feathers)
						features["kepori_body_feathers"] = new_kepori_feathers

				if("kepori_tail_feathers")
					var/new_kepori_feathers
					new_kepori_feathers = input(user, "Choose your character's tail feathers:", "Character Preference") as null|anything in GLOB.kepori_tail_feathers_list
					if (new_kepori_feathers)
						features["kepori_tail_feathers"] = new_kepori_feathers

				if("vox_head_quills")
					var/new_vox_head_quills
					new_vox_head_quills = input(user, "Choose your character's face type:", "Character Preference") as null|anything in GLOB.vox_head_quills_list
					if (new_vox_head_quills)
						features["vox_head_quills"] = new_vox_head_quills

				if("vox_neck_quills")
					var/new_vox_neck_quills
					new_vox_neck_quills = input(user, "Choose your character's face type:", "Character Preference") as null|anything in GLOB.vox_neck_quills_list
					if (new_vox_neck_quills)
						features["vox_neck_quills"] = new_vox_neck_quills

				if("elzu_horns")
					var/new_elzu_horns
					new_elzu_horns = input(user, "Choose your character's horns:", "Character Preference") as null|anything in GLOB.elzu_horns_list
					if(new_elzu_horns)
						features["elzu_horns"] = new_elzu_horns

				if("tail_elzu")
					var/new_tail
					new_tail = input(user, "Choose your character's tail:", "Character Preference") as null|anything in GLOB.tails_list_elzu
					if(new_tail)
						features["tail_elzu"] = new_tail

				if("s_tone")
					var/new_s_tone = input(user, "Choose your character's skin-tone:", "Character Preference")  as null|anything in GLOB.skin_tones
					if(new_s_tone)
						skin_tone = new_s_tone

				if("ooccolor")
					var/new_ooccolor = input(user, "Choose your OOC colour:", "Game Preference",ooccolor) as color|null
					if(new_ooccolor)
						ooccolor = new_ooccolor

				if("asaycolor")
					var/new_asaycolor = input(user, "Choose your ASAY color:", "Game Preference",asaycolor) as color|null
					if(new_asaycolor)
						asaycolor = new_asaycolor

				if("briefoutfit")
					var/list/valid_paths = list()
					for(var/datum/outfit/outfit_path as anything in subtypesof(/datum/outfit))
						valid_paths[initial(outfit_path.name)] = outfit_path
					var/new_outfit = input(user, "Choose your briefing officer outfit:", "Game Preference") as null|anything in valid_paths
					new_outfit = valid_paths[new_outfit]
					if(new_outfit)
						brief_outfit = new_outfit

				if("bag")
					var/new_backpack = input(user, "Choose your character's style of bag:", "Character Preference")  as null|anything in GLOB.backpacklist
					if(new_backpack)
						backpack = new_backpack

				if("suit")
					var/new_suit = input(user, "Choose your character's style of uniform:", "Character Preference")  as null|anything in GLOB.jumpsuitlist
					if(new_suit)
						jumpsuit_style = new_suit

				if("exo")
					var/new_exo = input(user, "Choose your character's style of outerwear:", "Character Preference")  as null|anything in GLOB.exowearlist
					if(new_exo)
						exowear = new_exo

				if("ai_core_icon")
					var/ai_core_icon = input(user, "Choose your preferred AI core display screen:", "AI Core Display Screen Selection") as null|anything in GLOB.ai_core_display_screens
					if(ai_core_icon)
						preferred_ai_core_display = ai_core_icon

				if("native_language")
					var/list/language_list = list()
					for(var/datum/language/lang_type as anything in learned_languages)
						language_list[initial(lang_type.name)] = lang_type
					var/datum/language/new_lang = language_list[tgui_input_list(user, "Select a native language:", "Native Language", language_list)]
					if(ispath(new_lang, /datum/language) && (initial(new_lang.flags) & ROUNDSTART_LANGUAGE)) // double-check to prevent exploits to gain codespeak or something as a native language
						native_language = new_lang
						learned_languages[new_lang] = LANGUAGE_UNKNOWN

				if("learned_language")
					var/datum/language/selected_lang = locate(href_list["language"])
					if(selected_lang.type == native_language) // wuh oh
						CRASH("[usr] attempted to change level of understanding for [selected_lang] despite it being their native language!")
					if(selected_lang && (selected_lang.flags & ROUNDSTART_LANGUAGE)) // no using html exploits to learn codespeak
						var/understanding = tgui_input_list(user, "Select level of understanding:", "Learn Language", language_level_costs)
						if(!understanding)
							return
						if(!(understanding in language_level_costs))
							CRASH("[usr] attempted to set level of understanding for [selected_lang.type] to \"[understanding]\"")
						var/old_value = learned_languages[selected_lang.type]
						learned_languages[selected_lang.type] = understanding
						if(get_language_point_balance() < 0 && understanding != LANGUAGE_UNKNOWN) // in case something breaks REAL bad, you can still disable languages to fix it
							learned_languages[selected_lang.type] = old_value
							to_chat(usr, span_warning("You don't have enough language points!"))

				if("reset_languages")
					init_learned_languages()

				if ("clientfps")
					var/desiredfps = input(user, "Choose your desired fps. (0 = default, 60 FPS))", "Character Preference", clientfps)  as null|num //WS Edit - Client FPS Tweak -
					if (!isnull(desiredfps))
						clientfps = desiredfps
						parent.fps = desiredfps
				if("ui")
					var/pickedui = input(user, "Choose your UI style.", "Character Preference", UI_style)  as null|anything in sortList(GLOB.available_ui_styles)
					if(pickedui)
						UI_style = pickedui
						if (parent && parent.mob && parent.mob.hud_used)
							parent.mob.hud_used.update_ui_style(ui_style2icon(UI_style))
				if("pda_style")
					var/pickedPDAStyle = input(user, "Choose your PDA style.", "Character Preference", pda_style)  as null|anything in GLOB.pda_styles
					if(pickedPDAStyle)
						pda_style = pickedPDAStyle
				if("pda_color")
					var/pickedPDAColor = input(user, "Choose your PDA Interface color.", "Character Preference", pda_color) as color|null
					if(pickedPDAColor)
						pda_color = pickedPDAColor

				if("phobia")
					var/phobiaType = input(user, "What is your character scared of?", "Quirk Preference", phobia) as null|anything in SStraumas.phobia_types
					if(phobiaType)
						phobia = phobiaType

				if("generic_adjective")
					var/selectAdj
					if(istype(pref_species, /datum/species/ipc))
						selectAdj = input(user, "In one word, how would you describe your character's appereance?", "Character Preference", generic_adjective) as null|anything in GLOB.ipc_preference_adjectives
					else
						selectAdj = input(user, "In one word, how would you describe your character's appereance?", "Character Preference", generic_adjective) as null|anything in GLOB.organic_preference_adjectives
					if(selectAdj)
						generic_adjective = selectAdj

				if ("max_chat_length")
					var/desiredlength = input(user, "Choose the max character length of shown Runechat messages. Valid range is 1 to [CHAT_MESSAGE_MAX_LENGTH] (default: [initial(max_chat_length)]))", "Character Preference", max_chat_length)  as null|num
					if (!isnull(desiredlength))
						max_chat_length = clamp(desiredlength, 1, CHAT_MESSAGE_MAX_LENGTH)

		else
			switch(href_list["preference"])
				if("showgear")
					show_gear = !show_gear
				if("publicity")
					if(unlock_content)
						toggles ^= MEMBER_PUBLIC
				if("gender")
					var/pickedGender = input(user, "Choose your gender.", "Character Preference", gender) as null|anything in friendlyGenders
					if(pickedGender && friendlyGenders[pickedGender] != gender)
						gender = friendlyGenders[pickedGender]
						underwear = random_underwear(gender)
						undershirt = random_undershirt(gender)
						socks = random_socks()
						facial_hairstyle = random_facial_hairstyle(gender)
						hairstyle = random_hairstyle(gender)
				if("pronouns")
					var/pickedPronouns = input(user, "Choose your pronouns.", "Character Preference", pronouns) as null|anything in friendlyPronouns
					if(pickedPronouns)
						pronouns = friendlyPronouns[pickedPronouns]
				if("fbp")
					fbp = !fbp

				if("limbs")
					if(href_list["customize_limb"])
						var/limb = href_list["customize_limb"]
						var/list/limb_options = list(PROSTHETIC_NORMAL, PROSTHETIC_ROBOTIC)
						if(limb != BODY_ZONE_CHEST && limb != BODY_ZONE_HEAD)
							limb_options.Add(PROSTHETIC_AMPUTATED) // starting without a head or chest causes instant death, must be disallowed

						var/obj/item/bodypart/part_candidate
						var/datum/sprite_accessory/body/limb_style
						for(var/body in GLOB.alternative_body_list)
							limb_style = GLOB.alternative_body_list[body]
							part_candidate = limb_style.replacement_bodyparts[limb]
							if(isnull(part_candidate))
								continue
							if(length(limb_style.allowed_species))
								if(!(pref_species.type in limb_style.allowed_species))
									continue
							if(!(pref_species.bodytype & initial(part_candidate.bodytype))) // don't allow vox and kepori to select limbs that aren't compatible
								continue
							limb_options.Add(body)

						var/status = input(user, "You are modifying your [parse_zone(limb)], what should it be changed to?", "Character Preference", prosthetic_limbs[limb]) in limb_options
						if(status)
							prosthetic_limbs[limb] = status

				if("hotkeys")
					hotkeys = !hotkeys
					if(hotkeys)
						winset(user, null, "map.focus=true input.background-color=[COLOR_INPUT_DISABLED] mainwindow.macro=default")
					else
						winset(user, null, "input.focus=true input.background-color=[COLOR_INPUT_ENABLED] mainwindow.macro=old_default")

				if("keybindings_capture")
					var/datum/keybinding/kb = GLOB.keybindings_by_name[href_list["keybinding"]]
					var/old_key = href_list["old_key"]
					CaptureKeybinding(user, kb, old_key)
					return

				if("keybindings_set")
					var/kb_name = href_list["keybinding"]
					if(!kb_name)
						user << browse(null, "window=capturekeypress")
						ShowChoices(user)
						return

					var/clear_key = text2num(href_list["clear_key"])
					var/old_key = href_list["old_key"]
					if(clear_key)
						if(key_bindings[old_key])
							key_bindings[old_key] -= kb_name
							LAZYADD(key_bindings["Unbound"], kb_name)
							if(!length(key_bindings[old_key]))
								key_bindings -= old_key
						user << browse(null, "window=capturekeypress")
						user.client.set_macros()
						save_preferences()
						ShowChoices(user)
						return

					var/new_key = uppertext(href_list["key"])
					var/AltMod = text2num(href_list["alt"]) ? "Alt" : ""
					var/CtrlMod = text2num(href_list["ctrl"]) ? "Ctrl" : ""
					var/ShiftMod = text2num(href_list["shift"]) ? "Shift" : ""
					var/numpad = text2num(href_list["numpad"]) ? "Numpad" : ""
					// var/key_code = text2num(href_list["key_code"])

					if(GLOB._kbMap[new_key])
						new_key = GLOB._kbMap[new_key]

					var/full_key
					switch(new_key)
						if("Alt")
							full_key = "[new_key][CtrlMod][ShiftMod]"
						if("Ctrl")
							full_key = "[AltMod][new_key][ShiftMod]"
						if("Shift")
							full_key = "[AltMod][CtrlMod][new_key]"
						else
							full_key = "[AltMod][CtrlMod][ShiftMod][numpad][new_key]"
					if(kb_name in key_bindings[full_key]) //We pressed the same key combination that was already bound here, so let's remove to re-add and re-sort.
						key_bindings[full_key] -= kb_name
					if(key_bindings[old_key])
						key_bindings[old_key] -= kb_name
						if(!length(key_bindings[old_key]))
							key_bindings -= old_key
					key_bindings[full_key] += list(kb_name)
					key_bindings[full_key] = sortList(key_bindings[full_key])

					user << browse(null, "window=capturekeypress")
					user.client.set_macros()
					save_preferences()

				if("keybindings_reset")
					var/choice = tgui_alert(user, "Would you prefer 'hotkey' or 'classic' defaults?", "Setup keybindings", list("Hotkey", "Classic", "Cancel"))
					if(choice == "Cancel")
						ShowChoices(user)
						return
					hotkeys = (choice == "Hotkey")
					key_bindings = (hotkeys) ? deepCopyList(GLOB.hotkey_keybinding_list_by_key) : deepCopyList(GLOB.classic_keybinding_list_by_key)
					user.client.set_macros()

				if("chat_on_map")
					chat_on_map = !chat_on_map
				if("see_chat_non_mob")
					see_chat_non_mob = !see_chat_non_mob
				if("see_rc_emotes")
					see_rc_emotes = !see_rc_emotes

				if("action_buttons")
					buttons_locked = !buttons_locked
				if("tgui_fancy")
					tgui_fancy = !tgui_fancy
				if("outline_enabled")
					outline_enabled = !outline_enabled
				if("outline_color")
					var/pickedOutlineColor = input(user, "Choose your outline color.", "General Preference", outline_color) as color|null
					if(pickedOutlineColor)
						outline_color = pickedOutlineColor
				if("tgui_lock")
					tgui_lock = !tgui_lock
				if("winflash")
					windowflashing = !windowflashing

				//here lies the badmins
				if("hear_adminhelps")
					user.client.toggleadminhelpsound()
				if("hear_prayers")
					user.client.toggle_prayer_sound()
				if("announce_login")
					user.client.toggleannouncelogin()
				if("combohud_lighting")
					toggles ^= COMBOHUD_LIGHTING
				if("toggle_dead_chat")
					user.client.deadchat()
				if("toggle_radio_chatter")
					user.client.toggle_hear_radio()
				if("toggle_split_admin_tabs")
					toggles ^= SPLIT_ADMIN_TABS
				if("toggle_fast_mc_refresh")
					toggles ^= FAST_MC_REFRESH
				if("toggle_prayers")
					user.client.toggleprayers()
				if("toggle_deadmin_always")
					toggles ^= DEADMIN_ALWAYS
				if("toggle_deadmin_antag")
					toggles ^= DEADMIN_ANTAGONIST
				if("toggle_deadmin_head")
					toggles ^= DEADMIN_POSITION_HEAD
				if("toggle_deadmin_security")
					toggles ^= DEADMIN_POSITION_SECURITY
				if("toggle_deadmin_silicon")
					toggles ^= DEADMIN_POSITION_SILICON

				if("be_special")
					var/be_special_type = href_list["be_special_type"]
					if(be_special_type in be_special)
						be_special -= be_special_type
					else
						be_special += be_special_type

				if("toggle_random")
					var/random_type = href_list["random_type"]
					if(randomise[random_type])
						randomise -= random_type
					else
						randomise[random_type] = TRUE

				if("hear_midis")
					toggles ^= SOUND_MIDI

				if("lobby_music")
					toggles ^= SOUND_LOBBY
					if((toggles & SOUND_LOBBY) && user.client && isnewplayer(user))
						user.client.playtitlemusic()
					else
						user.stop_sound_channel(CHANNEL_LOBBYMUSIC)

				if("endofround_sounds")
					toggles ^= SOUND_ENDOFROUND

				if("ghost_ears")
					chat_toggles ^= CHAT_GHOSTEARS

				if("ghost_sight")
					chat_toggles ^= CHAT_GHOSTSIGHT

				if("ghost_whispers")
					chat_toggles ^= CHAT_GHOSTWHISPER

				if("ghost_radio")
					chat_toggles ^= CHAT_GHOSTRADIO

				if("ghost_pda")
					chat_toggles ^= CHAT_GHOSTPDA

				if("ghost_laws")
					chat_toggles ^= CHAT_GHOSTLAWS

				if("hear_login_logout")
					chat_toggles ^= CHAT_LOGIN_LOGOUT

				if("broadcast_login_logout")
					broadcast_login_logout = !broadcast_login_logout

				if("income_pings")
					chat_toggles ^= CHAT_BANKCARD

				if("pull_requests")
					chat_toggles ^= CHAT_PULLR

				if("large_tgui_buttons")
					large_tgui_buttons = !large_tgui_buttons

				if("swapped_tgui_buttons")
					swapped_tgui_buttons = !swapped_tgui_buttons

				if("tgui_input")
					tgui_input = !tgui_input

				if("allow_midround_antag")
					toggles ^= MIDROUND_ANTAG

				if("parallaxup")
					parallax = WRAP(parallax + 1, PARALLAX_INSANE, PARALLAX_DISABLE + 1)
					if (parent && parent.mob && parent.mob.hud_used)
						parent.mob.hud_used.update_parallax_pref(parent.mob)

				if("parallaxdown")
					parallax = WRAP(parallax - 1, PARALLAX_INSANE, PARALLAX_DISABLE + 1)
					if (parent && parent.mob && parent.mob.hud_used)
						parent.mob.hud_used.update_parallax_pref(parent.mob)

				if("screentipmode")
					screentip_pref = !screentip_pref

				if("screentipcolor")
					var/new_screentipcolor = input(user, "Choose your screentip color:", "Character Preference", screentip_color) as color|null
					if(new_screentipcolor)
						screentip_color = sanitize_ooccolor(new_screentipcolor)

				if("ambientocclusion")
					ambientocclusion = !ambientocclusion
					if(parent && parent.screen && parent.screen.len)
						for(var/atom/movable/screen/plane_master/game_world/game_world_plane_master in parent?.screen)
							game_world_plane_master.backdrop(parent.mob)

				if("auto_fit_viewport")
					auto_fit_viewport = !auto_fit_viewport
					if(auto_fit_viewport && parent)
						parent.fit_viewport()

				if("widescreenpref")
					widescreenpref = !widescreenpref
					user.client.view_size.setDefault(getScreenSize(widescreenpref))

				if("pixel_size")
					switch(pixel_size)
						if(PIXEL_SCALING_AUTO)
							pixel_size = PIXEL_SCALING_1X
						if(PIXEL_SCALING_1X)
							pixel_size = PIXEL_SCALING_1_2X
						if(PIXEL_SCALING_1_2X)
							pixel_size = PIXEL_SCALING_2X
						if(PIXEL_SCALING_2X)
							pixel_size = PIXEL_SCALING_3X
						if(PIXEL_SCALING_3X)
							pixel_size = PIXEL_SCALING_AUTO
					user.client.view_size.apply() //Let's winset() it so it actually works

				if("scaling_method")
					switch(scaling_method)
						if(SCALING_METHOD_NORMAL)
							scaling_method = SCALING_METHOD_DISTORT
						if(SCALING_METHOD_DISTORT)
							scaling_method = SCALING_METHOD_BLUR
						if(SCALING_METHOD_BLUR)
							scaling_method = SCALING_METHOD_NORMAL
					user.client.view_size.setZoomMode()

				if("save")
					save_preferences()
					save_character()

				if("load")
					load_preferences()
					load_character()

				if("changeslot")
					if(!load_character(text2num(href_list["num"])))
						random_character()
						real_name = random_unique_name(gender)
						save_character()

				if("tab")
					if (href_list["tab"])
						current_tab = text2num(href_list["tab"])
						if(current_tab == 2)
							show_loadout = TRUE

				if("clear_heart")
					hearted = FALSE
					hearted_until = null
					to_chat(user, span_notice("OOC Commendation Heart disabled"))
					save_preferences()


	ShowChoices(user)
	return 1

/datum/preferences/proc/copy_to(mob/living/carbon/human/character, icon_updates = 1, roundstart_checks = TRUE, character_setup = FALSE, antagonist = FALSE, loadout = FALSE)

	if(randomise[RANDOM_SPECIES] && !character_setup)
		random_species()

	if((randomise[RANDOM_BODY] || randomise[RANDOM_BODY_ANTAG] && antagonist) && !character_setup)
		slot_randomized = TRUE
		random_character(gender, antagonist)

	if((randomise[RANDOM_NAME] || randomise[RANDOM_NAME_ANTAG] && antagonist) && !character_setup)
		slot_randomized = TRUE
		real_name = pref_species.random_name(gender)

	if(randomise[RANDOM_PROSTHETIC] && !character_setup)
		prosthetic_limbs = random_prosthetic()

	if(roundstart_checks)
		if(CONFIG_GET(flag/humans_need_surnames) && (pref_species.id == SPECIES_HUMAN))
			var/firstspace = findtext(real_name, " ")
			var/name_length = length(real_name)
			if(!firstspace)	//we need a surname
				real_name += " [pick(GLOB.last_names)]"
			else if(firstspace == name_length)
				real_name += "[pick(GLOB.last_names)]"

	character.real_name = real_name
	character.name = character.real_name

	character.gender = gender
	character.pronouns = pronouns
	character.age = clamp(age, pref_species.species_age_min, pref_species.species_age_max)
	character.eye_color = eye_color
	var/obj/item/organ/eyes/organ_eyes = character.getorgan(/obj/item/organ/eyes)
	if(organ_eyes)
		if(!initial(organ_eyes.eye_color))
			organ_eyes.eye_color = eye_color
		organ_eyes.old_eye_color = eye_color
	character.skin_tone = skin_tone
	character.underwear = underwear
	character.underwear_color = underwear_color
	character.undershirt = undershirt
	character.undershirt_color = undershirt_color
	character.socks = socks
	character.socks_color = socks_color

	character.backpack = backpack

	character.jumpsuit_style = jumpsuit_style

	character.exowear = exowear

	character.fbp = fbp

	character.flavor_text = features["flavor_text"] //Let's update their flavor_text at least initially

	if(loadout) //I have been told not to do this because it's too taxing on performance, but hey, I did it anyways! //I hate you old me //don't be mean
		for(var/gear in equipped_gear)
			var/datum/gear/G = GLOB.gear_datums[gear]
			if(G?.slot)
				if(!character.equip_to_slot_or_del(G.spawn_item(character, character), G.slot))
					continue

	var/datum/species/chosen_species
	chosen_species = pref_species.type
	if(roundstart_checks && !(pref_species.id in GLOB.roundstart_races) && !(pref_species.id in (CONFIG_GET(keyed_list/roundstart_no_hard_check))))
		chosen_species = /datum/species/human
		pref_species = new /datum/species/human
		save_character()

	//prosthetics work for vox and kepori and update just fine for everyone
	character.dna.features = features.Copy()
	character.set_species(chosen_species, icon_update = FALSE, pref_load = TRUE, robotic = fbp)

	for(var/pros_limb in prosthetic_limbs)
		var/obj/item/bodypart/old_part = character.get_bodypart(pros_limb)
		if(old_part)
			icon_updates = TRUE
		switch(prosthetic_limbs[pros_limb])
			if(PROSTHETIC_NORMAL)
				if(old_part)
					old_part.drop_limb(TRUE)
					qdel(old_part)
				character.regenerate_limb(pros_limb, robotic = fbp)
			if(PROSTHETIC_AMPUTATED)
				if(old_part)
					old_part.drop_limb(TRUE)
					qdel(old_part)
				if(pros_limb == BODY_ZONE_CHEST || pros_limb == BODY_ZONE_HEAD)
					stack_trace("[parent] somehow had their [parse_zone(pros_limb)] set to [PROSTHETIC_AMPUTATED]!")
					prosthetic_limbs[pros_limb] = PROSTHETIC_NORMAL
					character.regenerate_limb(pros_limb, robotic = fbp)
			if(PROSTHETIC_ROBOTIC)
				if(old_part)
					old_part.drop_limb(TRUE)
					qdel(old_part)
				character.regenerate_limb(pros_limb, robotic = TRUE)
			else
				var/datum/sprite_accessory/body/limb_style = GLOB.alternative_body_list[prosthetic_limbs[pros_limb]]
				var/obj/item/bodypart/new_part = limb_style.replacement_bodyparts[pros_limb]
				new_part = new new_part()
				if(old_part)
					old_part.drop_limb(TRUE)
					qdel(old_part)
				if(!(new_part.bodytype & pref_species.bodytype))
					stack_trace("[parent] had [limb_style.name] selected, which isn't compatible with [pref_species.name]!")
					prosthetic_limbs[pros_limb] = PROSTHETIC_NORMAL
					character.regenerate_limb(pros_limb, robotic = fbp)
					continue
				if(new_part.should_draw_greyscale) // species that don't use mutant colors normally should still be able to color prosthetics that do
					new_part.draw_color = features["mcolor"]
				if(new_part.overlay_icon_state)
					new_part.species_secondary_color = features["mcolor2"]
				new_part.replace_limb(character, TRUE)
				new_part.update_limb(is_creating = TRUE)

	//Because of how set_species replaces all bodyparts with new ones, hair needs to be set AFTER species.
	character.dna.real_name = character.real_name
	character.generic_adjective = generic_adjective
	character.hair_color = hair_color
	character.facial_hair_color = facial_hair_color
	character.grad_color = features["grad_color"]

	character.hairstyle = hairstyle
	character.facial_hairstyle = facial_hairstyle
	character.grad_style = features["grad_style"]

	if("tail_lizard" in pref_species.default_features)
		character.dna.species.mutant_bodyparts |= "tail_lizard"

	if(icon_updates)
		character.update_body()
		character.update_hair()
		character.update_body_parts(TRUE)
	character.set_mob_height(GLOB.height_filters[height_filter])

	if(!character_setup && get_language_point_balance() < 0)
		init_learned_languages() // no exploits allowed
	character.grant_language(native_language)
	character.get_language_holder().selected_language = native_language
	for(var/datum/language/lang_type as anything in learned_languages)
		if(lang_type == native_language)
			continue
		switch(learned_languages[lang_type])
			if(LANGUAGE_FLUENT)
				character.grant_language(lang_type)
			if(LANGUAGE_FAMILIAR)
				character.grant_language(lang_type, SPOKEN_LANGUAGE)
				character.remove_language(lang_type, UNDERSTOOD_LANGUAGE)
				character.grant_partial_language(lang_type, 80)
			if(LANGUAGE_RECOGNIZED)
				character.remove_language(lang_type)
				character.grant_partial_language(lang_type, 40)
			if(LANGUAGE_UNKNOWN)
				character.remove_language(lang_type)

/datum/preferences/proc/get_default_name(name_id)
	switch(name_id)
		if("ai")
			return pick(GLOB.ai_names)
		if("cyborg")
			return DEFAULT_CYBORG_NAME
	return random_unique_name()

/datum/preferences/proc/ask_for_custom_name(mob/user,name_id)
	var/namedata = GLOB.preferences_custom_names[name_id]
	if(!namedata)
		return

	var/raw_name = input(user, "Choose your character's [namedata["qdesc"]]:","Character Preference") as text|null
	if(!raw_name)
		if(namedata["allow_null"])
			custom_names[name_id] = get_default_name(name_id)
		else
			return
	else
		var/sanitized_name = reject_bad_name(raw_name)
		if(!sanitized_name)
			to_chat(user, "<font color='red'>Invalid name. Your name should be at least 2 and at most [MAX_NAME_LEN] characters long. It may only contain the characters A-Z, a-z, 0-9, and the following punctuation: ' - . ~ | @ : # $ % & * +</font>")
			return
		else
			custom_names[name_id] = sanitized_name
