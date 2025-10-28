
//The advanced pea-green monochrome lcd of tomor- YESTARDAY, SCREW THAT, ~Affected

GLOBAL_LIST_EMPTY(PDAs)

#define PDA_SCANNER_NONE 0
#define PDA_SCANNER_MEDICAL 1
#define PDA_SCANNER_FORENSICS 2 //unused
#define PDA_SCANNER_REAGENT 3
#define PDA_SCANNER_HALOGEN 4
#define PDA_SCANNER_GAS 5
#define PDA_SPAM_DELAY 2 MINUTES

/obj/item/pda
	name = "\improper PDA"
	desc = "A portable microcomputer by Thinktronic Systems, LTD. Functionality determined by a preprogrammed ROM cartridge."
	icon = 'icons/obj/pda.dmi'
	icon_state = "pda"
	item_state = "electronic"
	lefthand_file = 'icons/mob/inhands/misc/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/devices_righthand.dmi'
	item_flags = NOBLUDGEON
	w_class = WEIGHT_CLASS_SMALL
	slot_flags = ITEM_SLOT_ID | ITEM_SLOT_BELT
	actions_types = list(/datum/action/item_action/toggle_light)
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 100)
	resistance_flags = FIRE_PROOF | ACID_PROOF
	light_system = MOVABLE_LIGHT_DIRECTIONAL
	light_range = 2.3
	light_power = 0.6
	light_color = "#FFCC66"
	light_on = FALSE

	//Main variables
	var/owner = null // String name of owner
	var/default_cartridge = 0 // Access level defined by cartridge
	var/obj/item/cartridge/cartridge = null //current cartridge
	var/mode = 0 //Controls what menu the PDA will display. 0 is hub; the rest are either built in or based on cartridge.
	var/icon_alert = "pda-r" //Icon to be overlayed for message alerts. Taken from the pda icon file.
	var/font_index = 0 //This int tells DM which font is currently selected and lets DM know when the last font has been selected so that it can cycle back to the first font when "toggle font" is pressed again.
	var/font_mode = "font-family:monospace;" //The currently selected font.
	var/background_color = "#808000" //The currently selected background color.

	#define FONT_MONO "font-family:monospace;"
	#define FONT_SHARE "font-family:\"Share Tech Mono\", monospace;letter-spacing:0px;"
	#define FONT_ORBITRON "font-family:\"Orbitron\", monospace;letter-spacing:0px; font-size:15px"
	#define FONT_VT "font-family:\"VT323\", monospace;letter-spacing:1px;"
	#define MODE_MONO 0
	#define MODE_SHARE 1
	#define MODE_ORBITRON 2
	#define MODE_VT 3

	//Secondary variables
	var/scanmode = PDA_SCANNER_NONE
	var/silent = FALSE //To beep or not to beep, that is the question
	var/toff = FALSE //If TRUE, messenger disabled
	var/tnote = null //Current Texts
	var/last_text //No text spamming
	var/last_everyone //No text for everyone spamming
	var/last_noise //Also no honk spamming that's bad too
	var/ttone = "beep" //The ringtone!
	var/note = "Congratulations, your station has chosen the Thinktronic 5230 Personal Data Assistant!" //Current note in the notepad function
	var/notehtml = ""
	var/notescanned = FALSE // True if what is in the notekeeper was from a paper.
	var/hidden = FALSE // Is the PDA hidden from the PDA list?
	var/emped = FALSE
	var/equipped = FALSE  //used here to determine if this is the first time its been picked up
	var/allow_emojis = FALSE //if the pda can send emojis and actually have them parsed as such
	var/sort_by_job = FALSE // If this is TRUE, will sort PDA list by job.

	var/obj/item/card/id/id = null //Making it possible to slot an ID card into the PDA so it can function as both.
	var/ownjob = null //related to above

	var/obj/item/paicard/pai = null	// A slot for a personal AI device

	var/datum/picture/picture //Scanned photo

	var/list/contained_item = list(/obj/item/pen, /obj/item/toy/crayon, /obj/item/lipstick, /obj/item/flashlight/pen, /obj/item/clothing/mask/cigarette)
	var/obj/item/inserted_item //Used for pen, crayon, and lipstick insertion or removal. Same as above.
	var/overlays_x_offset = 0	//x offset to use for certain overlays

	var/underline_flag = TRUE //flag for underline

/obj/item/pda/examine(mob/user)
	. = ..()
	if(!id && !inserted_item)
		return

	if(id)
		. += span_notice("Alt-click to remove the ID.") //won't name ID on examine in case it's stolen

	if(inserted_item && (!isturf(loc)))
		. += span_notice("Ctrl-click to remove [inserted_item].") //traitor pens are disguised so we're fine naming them on examine

	if((!isnull(cartridge)))
		. += span_notice("Ctrl+Shift-click to remove the cartridge.") //won't name cart on examine in case it's Detomatix

/obj/item/pda/Initialize()
	. = ..()
	GLOB.PDAs += src
	if(default_cartridge)
		cartridge = new default_cartridge(src)
	if(inserted_item)
		inserted_item = new inserted_item(src)
	else
		inserted_item =	new /obj/item/pen(src)
	update_appearance()

/obj/item/pda/equipped(mob/user, slot)
	. = ..()
	if(!equipped)
		if(user.client)
			background_color = user.client.prefs.pda_color
			switch(user.client.prefs.pda_style)
				if(MONO)
					font_index = MODE_MONO
					font_mode = FONT_MONO
				if(SHARE)
					font_index = MODE_SHARE
					font_mode = FONT_SHARE
				if(ORBITRON)
					font_index = MODE_ORBITRON
					font_mode = FONT_ORBITRON
				if(VT)
					font_index = MODE_VT
					font_mode = FONT_VT
				else
					font_index = MODE_MONO
					font_mode = FONT_MONO
			equipped = TRUE

/obj/item/pda/proc/update_label()
	name = "PDA-[owner] ([ownjob])" //Name generalisation

/obj/item/pda/GetAccess()
	if(id)
		return id.GetAccess()
	else
		return ..()

/obj/item/pda/GetID()
	return id

/obj/item/pda/RemoveID()
	return do_remove_id()

/obj/item/pda/InsertID(obj/item/inserting_item)
	var/obj/item/card/inserting_id = inserting_item.RemoveID()
	if(!inserting_id)
		return
	insert_id(inserting_id)
	if(id == inserting_id)
		return TRUE
	return FALSE

/obj/item/pda/update_overlays()
	. = ..()
	var/mutable_appearance/overlay = new(icon)
	overlay.pixel_x = overlays_x_offset
	if(id)
		overlay.icon_state = "id_overlay"
		. += new /mutable_appearance(overlay)
	if(inserted_item)
		overlay.icon_state = "insert_overlay"
		. += new /mutable_appearance(overlay)
	if(cartridge) //WSedit: lol copy and pasted from PR #55072 on TGstation haha!!
		overlay.icon_state = "cartridge_overlay" //does this work? fuck if I know!
		. += new /mutable_appearance(overlay) //WS end
	if(light_on)
		overlay.icon_state = "light_overlay"
		. += new /mutable_appearance(overlay)
	if(pai)
		if(pai.pai)
			overlay.icon_state = "pai_overlay"
			. += new /mutable_appearance(overlay)
		else
			overlay.icon_state = "pai_off_overlay"
			. += new /mutable_appearance(overlay)

/obj/item/pda/MouseDrop(mob/over, src_location, over_location)
	var/mob/M = usr
	if((M == over) && usr.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		return attack_self(M)
	return ..()

/obj/item/pda/attack_self_tk(mob/user)
	to_chat(user, span_warning("The PDA's capacitive touch screen doesn't seem to respond!"))
	return

/obj/item/pda/interact(mob/user)
	if(!user.IsAdvancedToolUser())
		to_chat(user, span_warning("You don't have the dexterity to do this!"))
		return

	..()

	var/datum/asset/spritesheet/assets = get_asset_datum(/datum/asset/spritesheet/simple/pda)
	assets.send(user)

	var/datum/asset/spritesheet/emoji_s = get_asset_datum(/datum/asset/spritesheet/chat)
	emoji_s.send(user) //Already sent by chat but no harm doing this

	user.set_machine(src)

	var/dat = "" //WS Edit - PDA Redesign
	dat += assets.css_tag()
	dat += emoji_s.css_tag()

	dat += "[PDAIMG(refresh)]   <a href='byond://?src=[REF(src)];choice=Refresh'>Refresh</a>"

	if((!isnull(cartridge)) && (mode == 0))
		dat += " | [PDAIMG(eject)]   <a href='byond://?src=[REF(src)];choice=Eject'>Eject [cartridge]</a>"
	if(mode)
		dat += " | [PDAIMG(menu)]   <a href='byond://?src=[REF(src)];choice=Return'>Return</a>"

	dat += "<br>"

	if(!owner)
		dat += "Warning: No owner information entered.  Please swipe card.<br><br>"
		dat += "[PDAIMG(refresh)]   <a href='byond://?src=[REF(src)];choice=Refresh'>Retry</a>"
	else
		switch (mode)
			if(0)
				dat += "<h2>PERSONAL DATA ASSISTANT v.1.2</h2>"
				dat += "Owner: [owner], [ownjob]<br>"

				if(id)
					dat += text("ID: <A href='byond://?src=[REF(src)];choice=Authenticate'>[id ? "[id.registered_name], [id.assignment]" : "----------"]   <a href='byond://?src=[REF(src)];choice=UpdateInfo'>[id ? "Update PDA Info" : ""]</a><br><br>")

				dat += "[station_time_timestamp()]<br>"
				dat += "[sector_datestamp()]<br>"
				dat += "<br>"
				dat += "<h4>General Functions</h4>"
				dat += "<ul>"
				dat += "<li><a href='byond://?src=[REF(src)];choice=1'>[PDAIMG(notes)] Notekeeper</a></li>"
				dat += "<li><a href='byond://?src=[REF(src)];choice=2'>[PDAIMG(mail)] Messenger</a></li>"
				dat += "<li><a href='byond://?src=[REF(src)];choice=6'>[PDAIMG(skills)]Skill Tracker</a></li>"

				if(cartridge)
					if(cartridge.access)
						dat += "<h4>Job Specific Functions</h4>"
						if(cartridge.access & CART_STATUS_DISPLAY)
							dat += "<li>[PDAIMG(status)]   <a href='byond://?src=[REF(src)];choice=42'>Set Status Display</a></li>"
						if(cartridge.access & CART_ENGINE)
							dat += "<li>[PDAIMG(power)]   <a href='byond://?src=[REF(src)];choice=43'>Power Monitor</a></li>"
						if(cartridge.access & CART_MEDICAL)
							dat += "<li>[PDAIMG(medical)]   <a href='byond://?src=[REF(src)];choice=44'>Medical Records</a></li>"
						if(cartridge.access & CART_SECURITY)
							dat += "<li>[PDAIMG(cuffs)]   <a href='byond://?src=[REF(src)];choice=45'>Security Records</A></li>"
						if(cartridge.access & CART_QUARTERMASTER)
							dat += "<li>[PDAIMG(crate)]   <a href='byond://?src=[REF(src)];choice=47'>Supply Records</A></li>"

				dat += "<h4>Utilities</h4>"
				if(cartridge)
					if(cartridge.bot_access_flags)
						dat += "<li><a href='byond://?src=[REF(src)];choice=54'>[PDAIMG(medbot)]Bots Access</a></li>"
					if (cartridge.access & CART_JANITOR)
						dat += "<li><a href='byond://?src=[REF(src)];choice=49'>[PDAIMG(bucket)]Custodial Locator</a></li>"
					if (istype(cartridge.radio))
						dat += "<li><a href='byond://?src=[REF(src)];choice=40'>[PDAIMG(signaler)]Signaler System</a></li>"
					if (cartridge.access & CART_NEWSCASTER)
						dat += "<li><a href='byond://?src=[REF(src)];choice=53'>[PDAIMG(notes)]Newscaster Access </a></li>"
					if (cartridge.access & CART_REAGENT_SCANNER)
						dat += "<li><a href='byond://?src=[REF(src)];choice=Reagent Scan'>[PDAIMG(reagent)][scanmode == 3 ? "Disable" : "Enable"] Reagent Scanner</a></li>"
					if (cartridge.access & CART_ENGINE)
						dat += "<li><a href='byond://?src=[REF(src)];choice=Halogen Counter'>[PDAIMG(reagent)][scanmode == 4 ? "Disable" : "Enable"] Halogen Counter</a></li>"
					if (cartridge.access & CART_ATMOS)
						dat += "<li><a href='byond://?src=[REF(src)];choice=Gas Scan'>[PDAIMG(reagent)][scanmode == 5 ? "Disable" : "Enable"] Gas Scanner</a></li>"
					if (cartridge.access & CART_REMOTE_DOOR)
						dat += "<li><a href='byond://?src=[REF(src)];choice=Toggle Door'>[PDAIMG(rdoor)]Toggle Remote Door</a></li>"
					if (cartridge.access & CART_DRONEPHONE)
						dat += "<li><a href='byond://?src=[REF(src)];choice=Drone Phone'>[PDAIMG(dronephone)]Drone Phone</a></li>"
				dat += "<li><a href='byond://?src=[REF(src)];choice=3'>[PDAIMG(atmos)]Atmospheric Scan</a></li>"
				dat += "<li><a href='byond://?src=[REF(src)];choice=Light'>[PDAIMG(flashlight)][light_on ? "Disable" : "Enable"] Flashlight</a></li>"
				if (pai)
					if(pai.loc != src)
						pai = null
						update_appearance()
					else
						dat += "<li>[PDAIMG(status)]   <a href='byond://?src=[REF(src)];choice=pai;option=1'>pAI Device Configuration</a></li>"
						dat += "<li>[PDAIMG(status)]   <a href='byond://?src=[REF(src)];choice=pai;option=2'>Eject pAI Device</a></li>"

			if(1)
				dat += "<h4>[PDAIMG(notes)] Notekeeper V2.2</h4>"
				dat += "<a href='byond://?src=[REF(src)];choice=Edit'>Edit</a><br>"
				if(notescanned)
					dat += "(This is a scanned image, editing it may cause some text formatting to change.)<br>"
				dat += "<HR><font face=\"[PEN_FONT]\">[(!notehtml ? note : notehtml)]</font>"

			if(2)
				dat += "<h4>[PDAIMG(mail)] SpaceMessenger V3.9.6</h4>"
				dat += "[PDAIMG(bell)]   <a href='byond://?src=[REF(src)];choice=Toggle Ringer'>Ringer: [silent == 1 ? "Off" : "On"]</a><br>"
				dat += "[PDAIMG(mail)]   <a href='byond://?src=[REF(src)];choice=Toggle Messenger'>Send / Receive: [toff == 1 ? "Off" : "On"]</a><br>"
				dat += "[PDAIMG(bell)]   <a href='byond://?src=[REF(src)];choice=Ringtone'>Set Ringtone</a><br>"
				dat += "[PDAIMG(mail)]   <a href='byond://?src=[REF(src)];choice=21'>View Message Log</a><br>"

				if(cartridge)
					dat += cartridge.message_header()

				dat += "<h4>[PDAIMG(mail)]   Detected PDAs</h4>"

				dat += "<ul>"
				var/count = 0

				if(!toff)
					for (var/obj/item/pda/P in sortNames(get_viewable_pdas()))
						if(P == src)
							continue
						dat += "<li><a href='byond://?src=[REF(src)];choice=Message;target=[REF(P)]'>[P.owner] ([P.ownjob])</a>"
						if(cartridge)
							dat += cartridge.message_special(P)
						dat += "</li>"
						count++
				dat += "</ul>"
				if(count == 0)
					dat += "None detected.<br>"
				else if(cartridge && cartridge.spam_enabled)
					dat += "[PDAIMG(mail)]   <a href='byond://?src=[REF(src)];choice=MessageAll'>Send To All</a>"

			if(6)
				dat += "<h4>[PDAIMG(mail)] ExperTrak® Skill Tracker V4.26.2</h4>"
				dat += "<i>Thank you for choosing ExperTrak® brand software! ExperTrak® inc. is proud to be a Nanotrasen employee expertise and effectiveness department subsidary!</i>"
				dat += "<br><br>This software is designed to track and monitor your skill development as a Nanotrasen employee. Your job performance across different fields has been quantified and categorized below.<br>"
				var/datum/mind/targetmind = user.mind
				for (var/type in GLOB.skill_types)
					var/datum/skill/S = GetSkillRef(type)
					var/lvl_num = targetmind.get_skill_level(type)
					var/lvl_name = uppertext(targetmind.get_skill_level_name(type))
					var/exp = targetmind.get_skill_exp(type)
					var/xp_prog_to_level = targetmind.exp_needed_to_level_up(type)
					var/xp_req_to_level = 0
					if (xp_prog_to_level)//is it even possible to level up?
						xp_req_to_level = SKILL_EXP_LIST[lvl_num+1] - SKILL_EXP_LIST[lvl_num]
					dat += "<HR><b>[S.name]</b>"
					dat += "<br><i>[S.desc]</i>"
					dat += "<ul><li>EMPLOYEE SKILL LEVEL: <b>[lvl_name]</b>"
					if (exp && xp_req_to_level)
						var/progress_percent = (xp_req_to_level-xp_prog_to_level)/xp_req_to_level
						var/overall_percent = exp / SKILL_EXP_LIST[length(SKILL_EXP_LIST)]
						dat += "<br>PROGRESS TO NEXT SKILL LEVEL:"
						dat += "<br>" + num2loadingbar(progress_percent) + "([progress_percent*100])%"
						dat += "<br>OVERALL DEVELOPMENT PROGRESS:"
						dat += "<br>" + num2loadingbar(overall_percent) + "([overall_percent*100])%"
					if (lvl_num >= length(SKILL_EXP_LIST) && !(type in targetmind.skills_rewarded))
						dat += "<br><a href='byond://?src=[REF(src)];choice=SkillReward;skill=[type]'>Contact the Professional [S.title] Association</a>"
					dat += "</li></ul>"

			if(21)
				dat += "<h4>[PDAIMG(mail)]   SpaceMessenger V3.9.6</h4>"
				dat += "[PDAIMG(blank)]   <a href='byond://?src=[REF(src)];choice=Clear'> Clear Messages</a>"

				dat += "[PDAIMG(mail)]   Messages</h4>"

				dat += tnote
				dat += "<br>"

			if(41) //crew manifest
				dat += "<h4>Crew Manifest</h4>"
				dat += "<center>"
				dat += SSovermap.get_manifest_html()
				dat += "</center>"

			if(3)
				dat += "<h4>[PDAIMG(atmos)]   Atmospheric Readings</h4>"

				var/turf/T = user.loc
				if(isnull(T))
					dat += "Unable to obtain a reading.<br>"
				else
					var/datum/gas_mixture/environment = T.return_air()

					var/pressure = environment.return_pressure()
					var/total_moles = environment.total_moles()

					dat += "Air Pressure: [round(pressure,0.1)] kPa<br>"

					if (total_moles)
						for(var/id in environment.get_gases())
							var/gas_level = environment.get_moles(id)/total_moles
							if(gas_level > 0)
								dat += "[GLOB.gas_data.names[id]]: [round(gas_level*100, 0.01)]%<br>"

					dat += "Temperature: [round(environment.return_temperature()-T0C)]&deg;C<br>"
				dat += "<br>"
			else//Else it links to the cart menu proc. Although, it really uses menu hub 4--menu 4 doesn't really exist as it simply redirects to hub.
				dat += cartridge.generate_menu()

	var/datum/browser/popup = new(user, "pda_ui", "<div align='center'>Personal Data Assistant</div>", 500, 600)
	popup.set_content(dat)
	popup.open(0)

/obj/item/pda/Topic(href, href_list)
	..()
	var/mob/living/U = usr
	//Looking for master was kind of pointless since PDAs don't appear to have one.

	if(usr.canUseTopic(src, BE_CLOSE, FALSE, NO_TK) && !href_list["close"])
		add_fingerprint(U)
		U.set_machine(src)

		switch(href_list["choice"])

//BASIC FUNCTIONS===================================

			if("Refresh")//Refresh, goes to the end of the proc.
				EMPTY_BLOCK_GUARD
			if("Return")//Return
				if(mode<=9)
					mode = 0
				else
					mode = round(mode/10)
					if(mode==4 || mode == 5)//Fix for cartridges. Redirects to hub.
						mode = 0
			if("Authenticate")//Checks for ID
				id_check(U)
			if("UpdateInfo")
				ownjob = id.assignment
				if(istype(id, /obj/item/card/id/syndicate))
					owner = id.registered_name
				update_label()
			if("Eject")//Ejects the cart, only done from hub.
				if(!isnull(cartridge))
					U.put_in_hands(cartridge)
					to_chat(U, span_notice("You remove [cartridge] from [src]."))
					scanmode = 0
					cartridge.host_pda = null
					cartridge = null
					update_appearance()

//MENU FUNCTIONS===================================

			if("0")//Hub
				mode = 0
			if("1")//Notes
				mode = 1
			if("2")//Messenger
				mode = 2
			if("21")//Read messeges
				mode = 21
			if("3")//Atmos scan
				mode = 3
			if("4")//Redirects to hub
				mode = 0

//MAIN FUNCTIONS===================================

			if("Light")
				toggle_light(U)
			if("Medical Scan")
				if(scanmode == PDA_SCANNER_MEDICAL)
					scanmode = PDA_SCANNER_NONE
				else if((!isnull(cartridge)) && (cartridge.access & CART_MEDICAL))
					scanmode = PDA_SCANNER_MEDICAL
			if("Reagent Scan")
				if(scanmode == PDA_SCANNER_REAGENT)
					scanmode = PDA_SCANNER_NONE
				else if((!isnull(cartridge)) && (cartridge.access & CART_REAGENT_SCANNER))
					scanmode = PDA_SCANNER_REAGENT
			if("Halogen Counter")
				if(scanmode == PDA_SCANNER_HALOGEN)
					scanmode = PDA_SCANNER_NONE
				else if((!isnull(cartridge)) && (cartridge.access & CART_ENGINE))
					scanmode = PDA_SCANNER_HALOGEN
			if("Trombone")
				if(!(last_noise && world.time < last_noise + 20))
					playsound(loc, 'sound/misc/sadtrombone.ogg', 50, 1)
					last_noise = world.time
			if("Gas Scan")
				if(scanmode == PDA_SCANNER_GAS)
					scanmode = PDA_SCANNER_NONE
				else if((!isnull(cartridge)) && (cartridge.access & CART_ATMOS))
					scanmode = PDA_SCANNER_GAS
			if("Drone Phone")
				var/alert_s = input(U,"Alert severity level","Ping Drones",null) as null|anything in list("Low","Medium","High","Critical")
				var/area/A = get_area(U)
				if(A && alert_s && !QDELETED(U))
					var/msg = span_boldnotice("NON-DRONE PING: [U.name]: [alert_s] priority alert in [A.name]!")
					_alert_drones(msg, TRUE, U)
					to_chat(U, msg)


//NOTEKEEPER FUNCTIONS===================================

			if("Edit")
				var/n = stripped_multiline_input(U, "Please enter message", name, note)
				if(in_range(src, U) && loc == U)
					if(mode == 1 && n)
						note = n
						notehtml = parsemarkdown(n, U)
						notescanned = FALSE
				else
					U << browse(null, "window=pda")
					return

//MESSENGER FUNCTIONS===================================

			if("Toggle Messenger")
				toff = !toff
			if("Toggle Ringer")//If viewing texts then erase them, if not then toggle silent status
				silent = !silent
			if("Clear")//Clears messages
				tnote = null
			if("Ringtone")
				var/t = stripped_input(U, "Please enter new ringtone", name, ttone, 20)
				if(in_range(src, U) && loc == U && t)
					if(SEND_SIGNAL(src, COMSIG_PDA_CHANGE_RINGTONE, U, t) & COMPONENT_STOP_RINGTONE_CHANGE)
						U << browse(null, "window=pda")
						return
					else
						ttone = t
				else
					U << browse(null, "window=pda")
					return
			if("Message")
				create_message(U, locate(href_list["target"]) in GLOB.PDAs)

			if("Sorting Mode")
				sort_by_job = !sort_by_job

			if("MessageAll")
				send_to_all(U)

			if("cart")
				if(cartridge)
					cartridge.special(U, href_list)
				else
					U << browse(null, "window=pda")
					return

//SYNDICATE FUNCTIONS===================================

			if("Toggle Door")
				if(cartridge && cartridge.access & CART_REMOTE_DOOR)
					for(var/obj/machinery/door/poddoor/M in GLOB.machines)
						if(M.id == cartridge.remote_door_id)
							if(M.density)
								M.open()
							else
								M.close()

//pAI FUNCTIONS===================================
			if("pai")
				switch(href_list["option"])
					if("1")		// Configure pAI device
						pai.attack_self(U)
					if("2")		// Eject pAI device
						usr.put_in_hands(pai)
						to_chat(usr, span_notice("You remove the pAI from the [name]."))

//WS Start -- Skill Cloak Fix
//SKILL FUNCTIONS===================================

			if("SkillReward")
				var/type = text2path(href_list["skill"])
				var/datum/skill/S = GetSkillRef(type)
				var/datum/mind/mind = U.mind
				var/new_level = mind.get_skill_level(type)
				S.try_skill_reward(mind, new_level)
//WS End

//LINK FUNCTIONS===================================

			else//Cartridge menu linking
				mode = max(text2num(href_list["choice"]), 0)

	else//If not in range, can't interact or not using the pda.
		U.unset_machine()
		U << browse(null, "window=pda")
		return

//EXTRA FUNCTIONS===================================

	cut_overlay(icon_alert) //To clear message overlays.

	if(U.machine == src && href_list["skiprefresh"]!="1")//Final safety.
		attack_self(U)//It auto-closes the menu prior if the user is not in range and so on.
	else
		U.unset_machine()
		U << browse(null, "window=pda")
	return

/obj/item/pda/proc/remove_id(mob/user)
	if(issilicon(user) || !user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		return
	do_remove_id(user)


/obj/item/pda/proc/do_remove_id(mob/user)
	if(!id)
		return
	if(user)
		user.put_in_hands(id)
		to_chat(user, span_notice("You remove the ID from the [name]."))
	else
		id.forceMove(get_turf(src))

	. = id
	id = null
	updateSelfDialog()
	update_appearance()

	if(ishuman(loc))
		var/mob/living/carbon/human/H = loc
		if(H.wear_id == src)
			H.sec_hud_set_ID()


//WS Start -- Added recipient to PDA messages
/obj/item/pda/proc/msg_input(mob/living/U = usr, list/obj/item/pda/targets)
	var/title = name
	if(targets)
		if(length(targets) == 1)
			title = "[name] -> [targets[1]]"
		else if(length(targets) > 1)
			title = "[name] -> Multiple PDAs"
		else
			CRASH("msg_input(): Length of list/obj/item/pda/targets is non-positive")
	var/t = stripped_input(U, "Please enter message", title, null, MAX_MESSAGE_LEN)
	//WS End
	if(!t || toff)
		return
	if(!in_range(src, U) && loc != U)
		return
	if(emped)
		t = Gibberish(t, TRUE)
	return t

/obj/item/pda/proc/send_message(mob/living/user, list/obj/item/pda/targets, everyone)
	var/message = msg_input(user, targets)                  //WS Edit -- Added recipient to PDA messages
	if(!message || !targets.len)
		return
	if((last_text && world.time < last_text + 10) || (everyone && last_everyone && world.time < last_everyone + PDA_SPAM_DELAY))
		return
	if(prob(1))
		message += "\nSent from my PDA"
	// Send the signal
	var/list/string_targets = list()
	for (var/obj/item/pda/P in targets)
		if (P.owner && P.ownjob)  // != src is checked by the UI
			string_targets += "[P.owner] ([P.ownjob])"
	for (var/obj/machinery/computer/message_monitor/M in targets)
		// In case of "Reply" to a message from a console, this will make the
		// message be logged successfully. If the console is impersonating
		// someone by matching their name and job, the reply will reach the
		// impersonated PDA.
		string_targets += "[M.customsender] ([M.customjob])"
	if (!string_targets.len)
		return

	var/datum/signal/subspace/messaging/pda/signal = new(src, list(
		"name" = "[owner]",
		"job" = "[ownjob]",
		"message" = message,
		"targets" = string_targets,
		"emojis" = allow_emojis,
	))
	if (picture)
		signal.data["photo"] = picture
	signal.send_to_receivers()

	// If it didn't reach, note that fact
	if (!signal.data["done"])
		to_chat(user, span_notice("ERROR: Server isn't responding."))
		return

	var/target_text = signal.format_target()
	if(allow_emojis)
		message = emoji_parse(message)//already sent- this just shows the sent emoji as one to the sender in the to_chat
		signal.data["message"] = emoji_parse(signal.data["message"])

	// Log it in our logs
	tnote += "<i><b>&rarr; To [target_text]:</b></i><br>[signal.format_message()]<br>"
	// Show it to ghosts
	var/ghost_message = span_name("[owner] </span><span class='game say'>PDA Message</span> --> [span_name("[target_text]")]: <span class='message'>[signal.format_message()]")
	for(var/mob/M in GLOB.player_list)
		if(isobserver(M) && (M.client.prefs.chat_toggles & CHAT_GHOSTPDA))
			to_chat(M, "[FOLLOW_LINK(M, user)] [ghost_message]")
	// Log in the talk log
	user.log_talk(message, LOG_PDA, tag="PDA: [initial(name)] to [target_text]")
	to_chat(user, span_info("PDA message sent to [target_text]: \"[message]\""))
	// Reset the photo
	picture = null
	last_text = world.time
	if (everyone)
		last_everyone = world.time

/obj/item/pda/proc/receive_message(datum/signal/subspace/messaging/pda/signal)
	tnote += "<i><b>&larr; From <a href='byond://?src=[REF(src)];choice=Message;target=[REF(signal.source)]'>[signal.data["name"]]</a> ([signal.data["job"]]):</b></i><br>[signal.format_message()]<br>"

	if(!silent)
		playsound(loc, 'sound/machines/twobeep.ogg', 50, 1)
		audible_message("[icon2html(src, hearers(src))] *[ttone]*", null, 3)
	//Search for holder of the PDA.
	var/mob/living/L = null
	if(loc && isliving(loc))
		L = loc
	//Maybe they are a pAI!
	else
		L = get(src, /mob/living/silicon)

	if(L && (L.stat == CONSCIOUS || L.stat == SOFT_CRIT))
		var/reply = "(<a href='byond://?src=[REF(src)];choice=Message;skiprefresh=1;target=[REF(signal.source)]'>Reply</a>)"
		var/hrefstart
		var/hrefend
		if (isAI(L))
			hrefstart = "<a href='byond://?src=[REF(L)];track=[html_encode(signal.data["name"])]'>"
			hrefend = "</a>"

		if(signal.data["automated"])
			reply = "\[Automated Message\]"

		var/inbound_message = signal.format_message()
		if(signal.data["emojis"] == TRUE)//so will not parse emojis as such from pdas that don't send emojis
			inbound_message = emoji_parse(inbound_message)

		to_chat(L, span_infoplain("[icon2html(src)] <b>PDA message from [hrefstart][signal.data["name"]] ([signal.data["job"]])[hrefend], </b>[inbound_message] [reply]"))

	update_appearance()
	add_overlay(icon_alert)

/obj/item/pda/proc/send_to_all(mob/living/U)
	if (last_everyone && world.time < last_everyone + PDA_SPAM_DELAY)
		to_chat(U,span_warning("Send To All function is still on cooldown."))
		return
	send_message(U,get_viewable_pdas(), TRUE)

/obj/item/pda/proc/create_message(mob/living/U, obj/item/pda/P)
	send_message(U,list(P))

/obj/item/pda/AltClick(mob/user)
	..()

	if(id)
		remove_id(user)
	else
		remove_pen(user)

/obj/item/pda/CtrlClick(mob/user)
	..()

	if(isturf(loc)) //stops the user from dragging the PDA by ctrl-clicking it.
		return

	remove_pen(user)

/obj/item/pda/CtrlShiftClick(mob/user)
	..()
	eject_cart(user)

/obj/item/pda/verb/verb_toggle_light()
	set name = "Toggle light"
	set category = "Object"
	set src in oview(1)

	toggle_light(usr)

/obj/item/pda/verb/verb_remove_id()
	set category = "Object"
	set name = "Eject ID"
	set src in usr

	if(id)
		remove_id(usr)
	else
		to_chat(usr, span_warning("This PDA does not have an ID in it!"))

	if(usr.canUseTopic(src))
		if(id)
			remove_id()
		else
			to_chat(usr, span_warning("This PDA does not have an ID in it!"))

/obj/item/pda/verb/verb_remove_pen()
	set category = "Object"
	set name = "Remove Pen"
	set src in usr

	remove_pen(usr)

/obj/item/pda/verb/verb_eject_cart()
	set category = "Object"
	set name = "Eject Cartridge"
	set src in usr

	eject_cart(usr)

/obj/item/pda/proc/toggle_light(mob/user)
	if(issilicon(user) || !user.canUseTopic(src, BE_CLOSE))
		return
	if(light_on)
		set_light_on(FALSE)
	else if(light_range)
		set_light_on(TRUE)
	update_appearance()
	for(var/X in actions)
		var/datum/action/A = X
		A.UpdateButtonIcon()

/obj/item/pda/proc/remove_pen(mob/user)

	if(issilicon(user) || !user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK)) //TK doesn't work even with this removed but here for readability
		return

	if(inserted_item)
		user.put_in_hands(inserted_item)
		to_chat(user, span_notice("You remove [inserted_item] from [src]."))
		inserted_item = null
		update_appearance()
	else
		to_chat(user, span_warning("This PDA does not have a pen in it!"))

/obj/item/pda/proc/eject_cart(mob/user)
	if(issilicon(user) || !user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK)) //TK disabled to stop cartridge teleporting into hand
		return
	if (!isnull(cartridge))
		user.put_in_hands(cartridge)
		to_chat(user, span_notice("You eject [cartridge] from [src]."))
		scanmode = PDA_SCANNER_NONE
		cartridge.host_pda = null
		cartridge = null
		updateSelfDialog()
		update_appearance()

//trying to insert or remove an id
/obj/item/pda/proc/id_check(mob/user, obj/item/card/id/I)
	if(!I)
		if(id && (src in user.contents))
			remove_id(user)
			return TRUE
		else
			var/obj/item/card/id/C = user.get_active_held_item()
			if(istype(C))
				I = C

	if(I?.registered_name)
		if(!user.transferItemToLoc(I, src))
			return FALSE
		insert_id(I, user)
		update_appearance()
	return TRUE


/obj/item/pda/proc/insert_id(obj/item/card/id/inserting_id, mob/user)
	var/obj/old_id = id
	id = inserting_id
	if(ishuman(loc))
		var/mob/living/carbon/human/human_wearer = loc
		if(human_wearer.wear_id == src)
			human_wearer.sec_hud_set_ID()
	if(old_id)
		if(user)
			user.put_in_hands(old_id)
		else
			old_id.forceMove(get_turf(src))


// access to status display signals
/obj/item/pda/attackby(obj/item/C, mob/user, params)
	if(istype(C, /obj/item/cartridge))
		if(!user.transferItemToLoc(C, src))
			return
		eject_cart(user)
		cartridge = C
		cartridge.host_pda = src
		to_chat(user, span_notice("You insert [cartridge] into [src]."))
		updateSelfDialog()
		update_appearance()

	else if(istype(C, /obj/item/card/id))
		var/obj/item/card/id/idcard = C
		if(!idcard.registered_name)
			to_chat(user, span_warning("\The [src] rejects the ID!"))
			return
		if(!owner)
			owner = idcard.registered_name
			ownjob = idcard.assignment
			update_label()
			to_chat(user, span_notice("Card scanned."))
		else
			if(!id_check(user, idcard))
				return
			to_chat(user, span_notice("You put the ID into \the [src]'s slot."))
			updateSelfDialog()//Update self dialog on success.

			return	//Return in case of failed check or when successful.
		updateSelfDialog()//For the non-input related code.
	else if(istype(C, /obj/item/paicard) && !pai)
		if(!user.transferItemToLoc(C, src))
			return
		pai = C
		to_chat(user, span_notice("You slot \the [C] into [src]."))
		update_appearance()
		updateUsrDialog()
	else if(is_type_in_list(C, contained_item)) //Checks if there is a pen
		if(inserted_item)
			to_chat(user, span_warning("There is already \a [inserted_item] in \the [src]!"))
		else
			if(!user.transferItemToLoc(C, src))
				return
			to_chat(user, span_notice("You slide \the [C] into \the [src]."))
			inserted_item = C
			update_appearance()
	else if(istype(C, /obj/item/photo))
		var/obj/item/photo/P = C
		picture = P.picture
		to_chat(user, span_notice("You scan \the [C]."))
	else
		return ..()

/obj/item/pda/attack(mob/living/carbon/C, mob/living/user)
	if(istype(C))
		switch(scanmode)

			if(PDA_SCANNER_MEDICAL)
				C.visible_message(span_notice("[user] analyzes [C]'s vitals."))
				healthscan(user, C, 1)
				add_fingerprint(user)

			if(PDA_SCANNER_HALOGEN)
				C.visible_message(span_notice("[user] analyzes [C]'s radiation levels."))

				user.show_message(span_notice("Analyzing Results for [C]:"))
				if(C.radiation)
					user.show_message("\green Radiation Level: \black [C.radiation]")
				else
					user.show_message(span_notice("No radiation detected."))

/obj/item/pda/afterattack(atom/A as mob|obj|turf|area, mob/user, proximity)
	. = ..()
	if(!proximity)
		return
	switch(scanmode)
		if(PDA_SCANNER_REAGENT)
			if(!isnull(A.reagents))
				if(A.reagents.reagent_list.len > 0)
					var/reagents_length = A.reagents.reagent_list.len
					to_chat(user, span_notice("[reagents_length] chemical agent[reagents_length > 1 ? "s" : ""] found."))
					for (var/re in A.reagents.reagent_list)
						to_chat(user, span_notice("\t [re]"))
				else
					to_chat(user, span_notice("No active chemical agents found in [A]."))
			else
				to_chat(user, span_notice("No significant chemical agents found in [A]."))

		if(5)
			if(istype(A, /obj/item/tank))
				var/obj/item/tank/T = A
				atmosanalyzer_scan(T.air_contents, user, T)
			else if(istype(A, /obj/machinery/portable_atmospherics))
				var/obj/machinery/portable_atmospherics/PA = A
				atmosanalyzer_scan(PA.air_contents, user, PA)
			else if(istype(A, /obj/machinery/atmospherics/pipe))
				var/obj/machinery/atmospherics/pipe/P = A
				atmosanalyzer_scan(P.parent.air, user, P)
			else if(istype(A, /obj/machinery/power/rad_collector))
				var/obj/machinery/power/rad_collector/RC = A
				if(RC.loaded_tank)
					atmosanalyzer_scan(RC.loaded_tank.air_contents, user, RC)

	if(!scanmode && istype(A, /obj/item/paper) && owner)
		var/obj/item/paper/PP = A
		if(!PP.get_total_length())
			to_chat(user, span_warning("Unable to scan! Paper is blank."))
			return
		notehtml = PP.get_raw_text()
		note = replacetext(notehtml, "<BR>", "\[br\]")
		note = replacetext(note, "<li>", "\[*\]")
		note = replacetext(note, "<ul>", "\[list\]")
		note = replacetext(note, "</ul>", "\[/list\]")
		note = html_encode(note)
		notescanned = TRUE
		to_chat(user, span_notice("Paper scanned. Saved to PDA's notekeeper.") )


/obj/item/pda/proc/explode() //This needs tuning.
	var/turf/T = get_turf(src)

	if(ismob(loc))
		var/mob/M = loc
		M.show_message(span_userdanger("Your [src] explodes!"), MSG_VISUAL, span_warning("You hear a loud *pop*!"), MSG_AUDIBLE)
	else
		visible_message(span_danger("[src] explodes!"), span_warning("You hear a loud *pop*!"))

	if(T)
		T.hotspot_expose(700,125)
		if(istype(cartridge, /obj/item/cartridge/virus/syndicate))
			explosion(T, -1, 1, 3, 4)
		else
			explosion(T, -1, -1, 2, 3)
	qdel(src)
	return

/obj/item/pda/Destroy()
	GLOB.PDAs -= src
	if(istype(id))
		QDEL_NULL(id)
	if(istype(cartridge))
		QDEL_NULL(cartridge)
	if(istype(pai))
		QDEL_NULL(pai)
	if(istype(inserted_item))
		QDEL_NULL(inserted_item)
	return ..()

//AI verb and proc for sending PDA messages.

/obj/item/pda/ai/verb/cmd_toggle_pda_receiver()
	set category = "AI Commands"
	set name = "PDA - Toggle Sender/Receiver"

	if(usr.stat == DEAD)
		return //won't work if dead
	var/mob/living/silicon/S = usr
	if(istype(S) && !isnull(S.aiPDA))
		S.aiPDA.toff = !S.aiPDA.toff
		to_chat(usr, span_notice("PDA sender/receiver toggled [(S.aiPDA.toff ? "Off" : "On")]!"))
	else
		to_chat(usr, "You do not have a PDA. You should make an issue report about this.")

/obj/item/pda/ai/verb/cmd_toggle_pda_silent()
	set category = "AI Commands"
	set name = "PDA - Toggle Ringer"

	if(usr.stat == DEAD)
		return //won't work if dead
	var/mob/living/silicon/S = usr
	if(istype(S) && !isnull(S.aiPDA))
		//0
		S.aiPDA.silent = !S.aiPDA.silent
		to_chat(usr, span_notice("PDA ringer toggled [(S.aiPDA.silent ? "Off" : "On")]!"))
	else
		to_chat(usr, "You do not have a PDA. You should make an issue report about this.")

/mob/living/silicon/proc/cmd_send_pdamesg(mob/user)
	var/list/plist = list()
	var/list/namecounts = list()

	if(aiPDA.toff)
		to_chat(user, span_alert("Turn on your receiver in order to send messages."))
		return

	for (var/obj/item/pda/P in get_viewable_pdas())
		if(P == src)
			continue
		else if(P == src.aiPDA)
			continue

		plist[avoid_assoc_duplicate_keys(P.owner, namecounts)] = P

	var/c = input(user, "Please select a PDA") as null|anything in sortList(plist)

	if(!c)
		return

	var/selected = plist[c]

	if(aicamera.stored.len)
		var/add_photo = input(user,"Do you want to attach a photo?","Photo","No") as null|anything in list("Yes","No")
		if(add_photo=="Yes")
			var/datum/picture/Pic = aicamera.selectpicture(user)
			aiPDA.picture = Pic

	if(incapacitated())
		return

	aiPDA.create_message(src, selected)

/mob/living/silicon/proc/cmd_show_message_log(mob/user)
	if(incapacitated())
		return
	if(!isnull(aiPDA))
		var/HTML = "<html><head><meta http-equiv='Content-Type' content='text/html; charset=UTF-8'><title>AI PDA Message Log</title></head><body>[aiPDA.tnote]</body></html>"
		user << browse(HTML, "window=log;size=400x444;border=1;can_resize=1;can_close=1;can_minimize=0")
	else
		to_chat(user, span_warning("You do not have a PDA! You should make an issue report about this."))

// Pass along the pulse to atoms in contents, largely added so pAIs are vulnerable to EMP
/obj/item/pda/emp_act(severity)
	. = ..()
	if (!(. & EMP_PROTECT_CONTENTS))
		for(var/atom/movable/AM as anything in src)
			AM.emp_act(severity)
	if (!(. & EMP_PROTECT_SELF))
		emped++
		addtimer(CALLBACK(src, PROC_REF(emp_end)), 200 * severity)

/obj/item/pda/proc/emp_end()
	emped--

/proc/get_viewable_pdas(sort_by_job = FALSE)
	. = list()
	// Returns a list of PDAs which can be viewed from another PDA/message monitor.,
	var/sortmode
	if(sort_by_job)
		sortmode = /proc/cmp_pdajob_asc
	else
		sortmode = /proc/cmp_pdaname_asc

	for(var/obj/item/pda/P in sortList(GLOB.PDAs, sortmode))
		if(!P.owner || P.toff || P.hidden)
			continue
		. += P

/obj/item/pda/proc/pda_no_detonate()
	return COMPONENT_PDA_NO_DETONATE

#undef PDA_SCANNER_NONE
#undef PDA_SCANNER_MEDICAL
#undef PDA_SCANNER_FORENSICS
#undef PDA_SCANNER_REAGENT
#undef PDA_SCANNER_HALOGEN
#undef PDA_SCANNER_GAS
#undef PDA_SPAM_DELAY
