/******************** Requests Console ********************/
/** Originally written by errorage, updated by: Carn, needs more work though. I just added some security fixes */

GLOBAL_LIST_EMPTY(req_console_assistance)
GLOBAL_LIST_EMPTY(req_console_supplies)
GLOBAL_LIST_EMPTY(req_console_information)
GLOBAL_LIST_EMPTY(allConsoles)
GLOBAL_LIST_EMPTY(req_console_ckey_departments)


#define REQ_SCREEN_MAIN 0
#define REQ_SCREEN_REQ_ASSISTANCE 1
#define REQ_SCREEN_REQ_SUPPLIES 2
#define REQ_SCREEN_RELAY 3
#define REQ_SCREEN_WRITE 4
#define REQ_SCREEN_CHOOSE 5
#define REQ_SCREEN_SENT 6
#define REQ_SCREEN_ERR 7
#define REQ_SCREEN_VIEW_MSGS 8
#define REQ_SCREEN_AUTHENTICATE 9
#define REQ_SCREEN_ANNOUNCE 10

#define REQ_EMERGENCY_SECURITY 1
#define REQ_EMERGENCY_ENGINEERING 2
#define REQ_EMERGENCY_MEDICAL 3

/obj/machinery/requests_console
	name = "requests console"
	desc = "A console intended to send requests between different vessels and settlements in a local region."
	icon = 'icons/obj/terminals.dmi'
	icon_state = "req_comp0"
	base_icon_state = "req_comp"
	var/department = "Unknown" //The list of all departments on the station (Determined from this variable on each unit) Set this to the same thing if you want several consoles in one department
	var/list/messages = list() //List of all messages
	var/departmentType = 0 //bitflag
		// 0 = none (not listed, can only replied to)
		// assistance 	= 1
		// supplies 	= 2
		// info 		= 4
		// assistance + supplies 	= 3
		// assistance + info 		= 5
		// supplies + info 			= 6
		// assistance + supplies + info = 7
	var/newmessagepriority = REQ_NO_NEW_MESSAGE
	var/screen = REQ_SCREEN_MAIN
		// 0 = main menu,
		// 1 = req. assistance,
		// 2 = req. supplies
		// 3 = relay information
		// 4 = write msg - not used
		// 5 = choose priority - not used
		// 6 = sent successfully
		// 7 = sent unsuccessfully
		// 8 = view messages
		// 9 = authentication before sending
		// 10 = send announcement
	var/silent = FALSE // set to 1 for it not to beep all the time
	var/hackState = FALSE
	var/announcementConsole = FALSE // FALSE = This console cannot be used to send department announcements, TRUE = This console can send department announcements
	var/open = FALSE // TRUE if open
	var/announceAuth = FALSE //Will be set to 1 when you authenticate yourself for announcements
	var/msgVerified = "" //Will contain the name of the person who verified it
	var/msgStamped = "" //If a message is stamped, this will contain the stamp name
	var/message = ""
	var/to_department = "" //the department which will be receiving the message
	var/priority = REQ_NO_NEW_MESSAGE //Priority of the message being sent
	var/obj/item/radio/Radio
	var/emergency //If an emergency has been called by this device. Acts as both a cooldown and lets the responder know where it the emergency was triggered from
	var/receive_ore_updates = FALSE //If ore redemption machines will send an update when it receives new ores.
	max_integrity = 300
	armor = list("melee" = 70, "bullet" = 30, "laser" = 30, "energy" = 30, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 90, "acid" = 90)

	FASTDMM_PROP(\
		set_instance_vars(\
			pixel_x = dir & EAST ? 32 : (dir & WEST ? -32 : INSTANCE_VAR_DEFAULT),\
			pixel_y = dir & NORTH ? 32 : (dir & SOUTH ? -32 : INSTANCE_VAR_DEFAULT)\
		),\
		dir_amount = 8\
	)

/obj/machinery/requests_console/update_appearance(updates=ALL)
	. = ..()
	if(machine_stat & NOPOWER)
		set_light(0)
		return
	set_light(1.4,0.7,"#34D352")//green light

/obj/machinery/requests_console/update_icon_state()
	if(open)
		icon_state="[base_icon_state]_[hackState ? "rewired" : "open"]"
		return ..()
	if(machine_stat & NOPOWER)
		icon_state = "[base_icon_state]_off"
		return ..()

	if(emergency || (newmessagepriority == REQ_EXTREME_MESSAGE_PRIORITY))
		icon_state = "[base_icon_state]3"
		return ..()
	if(newmessagepriority == REQ_HIGH_MESSAGE_PRIORITY)
		icon_state = "[base_icon_state]2"
		return ..()
	if(newmessagepriority == REQ_NORMAL_MESSAGE_PRIORITY)
		icon_state = "[base_icon_state]1"
		return ..()
	icon_state = "[base_icon_state]0"
	return ..()

/obj/machinery/requests_console/Initialize()
	. = ..()
	name = "\improper [department] requests console"
	GLOB.allConsoles += src

	if(departmentType)

		if((departmentType & REQ_DEP_TYPE_ASSISTANCE) && !(department in GLOB.req_console_assistance))
			GLOB.req_console_assistance += department

		if((departmentType & REQ_DEP_TYPE_SUPPLIES) && !(department in GLOB.req_console_supplies))
			GLOB.req_console_supplies += department

		if((departmentType & REQ_DEP_TYPE_INFORMATION) && !(department in GLOB.req_console_information))
			GLOB.req_console_information += department

	GLOB.req_console_ckey_departments[ckey(department)] = department

	Radio = new /obj/item/radio(src)
	Radio.listening = 0

/obj/machinery/requests_console/Destroy()
	QDEL_NULL(Radio)
	GLOB.allConsoles -= src
	return ..()

/obj/machinery/requests_console/ui_interact(mob/user)
	. = ..()
	var/dat = ""
	if(!open)
		switch(screen)
			if(REQ_SCREEN_MAIN)
				announceAuth = FALSE
				if (newmessagepriority == REQ_NORMAL_MESSAGE_PRIORITY)
					dat += "<div class='notice'>There are new messages</div><BR>"
				else if (newmessagepriority == REQ_HIGH_MESSAGE_PRIORITY)
					dat += "<div class='notice'>There are new <b>PRIORITY</b> messages</div><BR>"
				else if (newmessagepriority == REQ_EXTREME_MESSAGE_PRIORITY)
					dat += "<div class='notice'>There are new <b>EXTREME PRIORITY</b> messages</div><BR>"
				dat += "<A href='byond://?src=[REF(src)];setScreen=[REQ_SCREEN_VIEW_MSGS]'>View Messages</A><BR><BR>"

				dat += "<A href='byond://?src=[REF(src)];setScreen=[REQ_SCREEN_REQ_ASSISTANCE]'>Request Assistance</A><BR>"
				dat += "<A href='byond://?src=[REF(src)];setScreen=[REQ_SCREEN_REQ_SUPPLIES]'>Request Supplies</A><BR>"
				dat += "<A href='byond://?src=[REF(src)];setScreen=[REQ_SCREEN_RELAY]'>Relay Anonymous Information</A><BR><BR>"

				if(!emergency)
					dat += "<A href='byond://?src=[REF(src)];emergency=[REQ_EMERGENCY_SECURITY]'>Emergency: Security</A><BR>"
					dat += "<A href='byond://?src=[REF(src)];emergency=[REQ_EMERGENCY_ENGINEERING]'>Emergency: Engineering</A><BR>"
					dat += "<A href='byond://?src=[REF(src)];emergency=[REQ_EMERGENCY_MEDICAL]'>Emergency: Medical</A><BR><BR>"
				else
					dat += "<B><font color='red'>[emergency] has been dispatched to this location.</font></B><BR><BR>"

				if(announcementConsole)
					dat += "<A href='byond://?src=[REF(src)];setScreen=[REQ_SCREEN_ANNOUNCE]'>Send Station-wide Announcement</A><BR><BR>"
				if (silent)
					dat += "Speaker <A href='byond://?src=[REF(src)];setSilent=0'>OFF</A>"
				else
					dat += "Speaker <A href='byond://?src=[REF(src)];setSilent=1'>ON</A>"
			if(REQ_SCREEN_REQ_ASSISTANCE)
				dat += "Which department do you need assistance from?<BR><BR>"
				dat += departments_table(GLOB.req_console_assistance)

			if(REQ_SCREEN_REQ_SUPPLIES)
				dat += "Which department do you need supplies from?<BR><BR>"
				dat += departments_table(GLOB.req_console_supplies)

			if(REQ_SCREEN_RELAY)
				dat += "Which department would you like to send information to?<BR><BR>"
				dat += departments_table(GLOB.req_console_information)

			if(REQ_SCREEN_SENT)
				dat += "[span_good("Message sent.")]<BR><BR>"
				dat += "<A href='byond://?src=[REF(src)];setScreen=[REQ_SCREEN_MAIN]'><< Back</A><BR>"

			if(REQ_SCREEN_ERR)
				dat += "[span_bad("An error occurred.")]<BR><BR>"
				dat += "<A href='byond://?src=[REF(src)];setScreen=[REQ_SCREEN_MAIN]'><< Back</A><BR>"

			if(REQ_SCREEN_VIEW_MSGS)
				for (var/obj/machinery/requests_console/Console in GLOB.allConsoles)
					if (Console.department == department)
						Console.newmessagepriority = REQ_NO_NEW_MESSAGE
						Console.update_appearance()

				newmessagepriority = REQ_NO_NEW_MESSAGE
				update_appearance()
				var/messageComposite = ""
				for(var/msg in messages) // This puts more recent messages at the *top*, where they belong.
					messageComposite = "<div class='block'>[msg]</div>" + messageComposite
				dat += messageComposite
				dat += "<BR><A href='byond://?src=[REF(src)];setScreen=[REQ_SCREEN_MAIN]'><< Back to Main Menu</A><BR>"

			if(REQ_SCREEN_AUTHENTICATE)
				dat += "<B>Message Authentication</B><BR><BR>"
				dat += "<b>Message for [to_department]: </b>[message]<BR><BR>"
				dat += "<div class='notice'>You may authenticate your message now by scanning your ID or your stamp</div><BR>"
				dat += "<b>Validated by:</b> [msgVerified ? msgVerified : "<i>Not Validated</i>"]<br>"
				dat += "<b>Stamped by:</b> [msgStamped ? msgStamped : "<i>Not Stamped</i>"]<br><br>"
				dat += "<A href='byond://?src=[REF(src)];send=[TRUE]'>Send Message</A><BR>"
				dat += "<BR><A href='byond://?src=[REF(src)];setScreen=[REQ_SCREEN_MAIN]'><< Discard Message</A><BR>"

			if(REQ_SCREEN_ANNOUNCE)
				dat += "<h3>Station-wide Announcement</h3>"
				if(announceAuth)
					dat += "<div class='notice'>Authentication accepted</div><BR>"
				else
					dat += "<div class='notice'>Swipe your card to authenticate yourself</div><BR>"
				dat += "<b>Message: </b>[message ? message : "<i>No Message</i>"]<BR>"
				dat += "<A href='byond://?src=[REF(src)];writeAnnouncement=1'>[message ? "Edit" : "Write"] Message</A><BR><BR>"
				if ((announceAuth || isAdminGhostAI(user)) && message)
					dat += "<A href='byond://?src=[REF(src)];sendAnnouncement=1'>Announce Message</A><BR>"
				else
					dat += "[span_linkoff("Announce Message")]<BR>"
				dat += "<BR><A href='byond://?src=[REF(src)];setScreen=[REQ_SCREEN_MAIN]'><< Back</A><BR>"

		if(!dat)
			CRASH("No UI for src. Screen var is: [screen]")
		var/datum/browser/popup = new(user, "req_console", "[department] Requests Console", 450, 440)
		popup.set_content(dat)
		popup.open()
	return

/obj/machinery/requests_console/proc/departments_table(list/req_consoles)
	var/dat = ""
	dat += "<table width='100%'>"
	for(var/req_dpt in req_consoles)
		if (req_dpt != department)
			dat += "<tr>"
			dat += "<td width='55%'>[req_dpt]</td>"
			dat += "<td width='45%'><A href='byond://?src=[REF(src)];write=[ckey(req_dpt)];priority=[REQ_NORMAL_MESSAGE_PRIORITY]'>Normal</A> <A href='byond://?src=[REF(src)];write=[ckey(req_dpt)];priority=[REQ_HIGH_MESSAGE_PRIORITY]'>High</A>"
			if(hackState)
				dat += "<A href='byond://?src=[REF(src)];write=[ckey(req_dpt)];priority=[REQ_EXTREME_MESSAGE_PRIORITY]'>EXTREME</A>"
			dat += "</td>"
			dat += "</tr>"
	dat += "</table>"
	dat += "<BR><A href='byond://?src=[REF(src)];setScreen=[REQ_SCREEN_MAIN]'><< Back</A><BR>"
	return dat

/obj/machinery/requests_console/Topic(href, href_list)
	if(..())
		return
	usr.set_machine(src)
	add_fingerprint(usr)

	if(href_list["write"])
		to_department = ckey(reject_bad_text(href_list["write"])) //write contains the string of the receiving department's name

		var/new_message = (to_department in GLOB.req_console_ckey_departments) && stripped_input(usr, "Write your message:", "Awaiting Input", "", MAX_MESSAGE_LEN)
		if(new_message)
			to_department = GLOB.req_console_ckey_departments[to_department]
			message = new_message
			screen = REQ_SCREEN_AUTHENTICATE
			priority = clamp(text2num(href_list["priority"]), REQ_NORMAL_MESSAGE_PRIORITY, REQ_EXTREME_MESSAGE_PRIORITY)

	if(href_list["writeAnnouncement"])
		var/new_message = reject_bad_text(stripped_input(usr, "Write your message:", "Awaiting Input", "", MAX_MESSAGE_LEN))
		if(new_message)
			message = new_message
			priority = clamp(text2num(href_list["priority"]) || REQ_NORMAL_MESSAGE_PRIORITY, REQ_NORMAL_MESSAGE_PRIORITY, REQ_EXTREME_MESSAGE_PRIORITY)
		else
			message = ""
			announceAuth = FALSE
			screen = REQ_SCREEN_MAIN

	if(href_list["sendAnnouncement"])
		if(!announcementConsole)
			return
		if(isliving(usr))
			var/mob/living/L = usr
			message = L.treat_message(message)
		minor_announce(message, "[department] Announcement:", from = usr, zlevel = usr.virtual_z())
		GLOB.news_network.SubmitArticle(message, department, "Station Announcements", null)
		usr.log_talk(message, LOG_SAY, tag="station announcement from [src]")
		message_admins("[ADMIN_LOOKUPFLW(usr)] has made a station announcement from [src] at [AREACOORD(usr)].")
		deadchat_broadcast(" made a station announcement from [span_name("[get_area_name(usr, TRUE)]")].", span_name("[usr.real_name]"), usr, message_type=DEADCHAT_ANNOUNCEMENT)
		announceAuth = FALSE
		message = ""
		screen = REQ_SCREEN_MAIN

	if(href_list["emergency"])
		if(!emergency)
			var/radio_freq
			switch(text2num(href_list["emergency"]))
				if(REQ_EMERGENCY_SECURITY) //Security
					emergency = "Security"
				if(REQ_EMERGENCY_ENGINEERING) //Engineering
					emergency = "Engineering"
				if(REQ_EMERGENCY_MEDICAL) //Medical
					emergency = "Medical"
			if(radio_freq)
				Radio.set_frequency(radio_freq)
				Radio.talk_into(src,"[emergency] emergency in [department]!!",radio_freq)
				update_appearance()
				addtimer(CALLBACK(src, PROC_REF(clear_emergency)), 5 MINUTES)

	if(href_list["send"] && message && to_department && priority)

		var/radio_freq = FREQ_EMERGENCY

		var/datum/signal/subspace/messaging/rc/signal = new(src, list(
			"sender" = department,
			"rec_dpt" = to_department,
			"send_dpt" = department,
			"message" = message,
			"verified" = msgVerified,
			"stamped" = msgStamped,
			"priority" = priority,
			"notify_freq" = radio_freq
		))
		signal.send_to_receivers()

		screen = signal.data["done"] ? REQ_SCREEN_SENT : REQ_SCREEN_ERR

	//Handle screen switching
	if(href_list["setScreen"])
		var/set_screen = clamp(text2num(href_list["setScreen"]) || 0, REQ_SCREEN_MAIN, REQ_SCREEN_ANNOUNCE)
		switch(set_screen)
			if(REQ_SCREEN_MAIN)
				to_department = ""
				msgVerified = ""
				msgStamped = ""
				message = ""
				priority = -1
			if(REQ_SCREEN_ANNOUNCE)
				if(!announcementConsole)
					return
		screen = set_screen

	//Handle silencing the console
	if(href_list["setSilent"])
		silent = text2num(href_list["setSilent"]) ? TRUE : FALSE

	updateUsrDialog()

/obj/machinery/requests_console/say_mod(input, datum/language/message_language, list/message_mods = list())
	if(spantext_char(input, "!", -3))
		return "blares"
	else
		. = ..()

/obj/machinery/requests_console/proc/clear_emergency()
	emergency = null
	update_appearance()

//from message_server.dm: Console.createmessage(data["sender"], data["send_dpt"], data["message"], data["verified"], data["stamped"], data["priority"], data["notify_freq"])
/obj/machinery/requests_console/proc/createmessage(source, source_department, message, msgVerified, msgStamped, priority, radio_freq)
	var/linkedsender

	var/sending = "[message]<br>"
	if(msgVerified)
		sending = "[sending][msgVerified]<br>"
	if(msgStamped)
		sending = "[sending][msgStamped]<br>"

	linkedsender = source_department ? "<a href='byond://?src=[REF(src)];write=[ckey(source_department)]'>[source_department]</a>" : (source || "unknown")

	var/authentic = (msgVerified || msgStamped) && " (Authenticated)"
	var/alert = "Message from [source][authentic]"
	var/silenced = silent
	var/header = "<b>From:</b> [linkedsender] Received: [station_time_timestamp()]<BR>"

	switch(priority)
		if(REQ_NORMAL_MESSAGE_PRIORITY)
			if(newmessagepriority < REQ_NORMAL_MESSAGE_PRIORITY)
				newmessagepriority = REQ_NORMAL_MESSAGE_PRIORITY
				update_appearance()

		if(REQ_HIGH_MESSAGE_PRIORITY)
			header = "[span_bad("High Priority")]<BR>[header]"
			alert = "PRIORITY Alert from [source][authentic]"
			if(newmessagepriority < REQ_HIGH_MESSAGE_PRIORITY)
				newmessagepriority = REQ_HIGH_MESSAGE_PRIORITY
				update_appearance()

		if(REQ_EXTREME_MESSAGE_PRIORITY)
			header = "[span_bad("!!!Extreme Priority!!!")]<BR>[header]"
			alert = "EXTREME PRIORITY Alert from [source][authentic]"
			silenced = FALSE
			if(newmessagepriority < REQ_EXTREME_MESSAGE_PRIORITY)
				newmessagepriority = REQ_EXTREME_MESSAGE_PRIORITY
				update_appearance()

	messages += "[header][sending]"

	if(!silenced)
		playsound(src, 'sound/machines/twobeep_high.ogg', 50, TRUE)
		say(alert)

	if(radio_freq)
		Radio.set_frequency(radio_freq)
		Radio.talk_into(src, "[alert]: <i>[message]</i>", radio_freq)

/obj/machinery/requests_console/attackby(obj/item/O, mob/user, params)
	if(O.tool_behaviour == TOOL_CROWBAR)
		if(open)
			to_chat(user, span_notice("You close the maintenance panel."))
			open = FALSE
		else
			to_chat(user, span_notice("You open the maintenance panel."))
			open = TRUE
		update_appearance()
		return
	if(O.tool_behaviour == TOOL_SCREWDRIVER)
		if(open)
			hackState = !hackState
			if(hackState)
				to_chat(user, span_notice("You modify the wiring."))
			else
				to_chat(user, span_notice("You reset the wiring."))
			update_appearance()
		else
			to_chat(user, span_warning("You must open the maintenance panel first!"))
		return

	var/obj/item/card/id/ID = O.GetID()
	if(ID)
		if(screen == REQ_SCREEN_AUTHENTICATE)
			msgVerified = "<font color='green'><b>Verified by [ID.registered_name] ([ID.assignment])</b></font>"
			updateUsrDialog()
		if(screen == REQ_SCREEN_ANNOUNCE)
			if (ACCESS_RC_ANNOUNCE in ID.access)
				announceAuth = TRUE
			else
				announceAuth = FALSE
				to_chat(user, span_warning("You are not authorized to send announcements!"))
			updateUsrDialog()
		return
	if (istype(O, /obj/item/stamp))
		if(screen == REQ_SCREEN_AUTHENTICATE)
			var/obj/item/stamp/T = O
			msgStamped = span_boldnotice("Stamped with the [T.name]")
			updateUsrDialog()
		return
	return ..()

#undef REQ_EMERGENCY_SECURITY
#undef REQ_EMERGENCY_ENGINEERING
#undef REQ_EMERGENCY_MEDICAL

#undef REQ_SCREEN_MAIN
#undef REQ_SCREEN_REQ_ASSISTANCE
#undef REQ_SCREEN_REQ_SUPPLIES
#undef REQ_SCREEN_RELAY
#undef REQ_SCREEN_WRITE
#undef REQ_SCREEN_CHOOSE
#undef REQ_SCREEN_SENT
#undef REQ_SCREEN_ERR
#undef REQ_SCREEN_VIEW_MSGS
#undef REQ_SCREEN_AUTHENTICATE
#undef REQ_SCREEN_ANNOUNCE
