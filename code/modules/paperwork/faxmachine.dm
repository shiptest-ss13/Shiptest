GLOBAL_LIST_EMPTY(allfaxes)
GLOBAL_LIST_EMPTY(alldepartments)

/obj/machinery/photocopier/faxmachine
	name = "fax machine"
	icon = 'icons/obj/library.dmi'
	icon_state = "fax"
	insert_anim = "faxsend"
	density = FALSE
	pixel_y = 4
	///Animation played on recieving a fax
	var/print_anim = "faxreceive"
	///Fax network. Either local or CC quantum entanglement
	var/fax_network = "Local Fax Network"

	///If this can send faxes to centcom.
	var/long_range_enabled = FALSE
	req_one_access = list(ACCESS_LAWYER, ACCESS_HEADS, ACCESS_ARMORY)

	use_power = TRUE
	idle_power_usage = 30
	active_power_usage = 200

	///The person who authenticated it followed by their job
	var/authenticated = FALSE
	///Sending cooldown
	var/sendcooldown = 0
	///Time for every cooldown
	var/cooldown_time = 1800

	///The fax machine's department
	var/department = "Unknown"

	///The department we're sending to
	var/destination
	///Departments that just redirect to admins. Accessible by all long-range faxes.
	var/list/static/admin_departments = list("Central Command")
	///Departments that redirect to admins that are accessible by any emagged long-range faxes.
	var/list/static/hidden_admin_departments = list("Syndicate")

/obj/machinery/photocopier/faxmachine/Initialize()
	. = ..()
	GLOB.allfaxes += src

	if(!(("[department]" in GLOB.alldepartments) || ("[department]" in admin_departments)) && department != "Unknown")
		LAZYADD(GLOB.alldepartments, department)

/obj/machinery/photocopier/faxmachine/Destroy()
	. = ..()
	GLOB.allfaxes -= src

/obj/machinery/photocopier/faxmachine/longrange
	name = "long range fax machine"
	fax_network = "Central Command Quantum Entanglement Network"
	long_range_enabled = TRUE
	icon_state = "longfax"
	insert_anim = "longfaxsend"
	print_anim = "longfaxreceive"

/obj/machinery/photocopier/faxmachine/emag_act(mob/user)
	if(!long_range_enabled)
		to_chat(user, "<span class='warning'>You swipe the card through [src], but nothing happens. This doesn't seem to be a powerful enough fax...</span>")
		return
	if(obj_flags & EMAGGED)
		to_chat(user, "<span class='warning'>You swipe the card through [src], but nothing happens.</span>")
		return
	obj_flags |= EMAGGED
	to_chat(user, "<span class='notice'>The transmitters realign to an unknown source!</span>")

/obj/machinery/photocopier/faxmachine/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "FaxMachine")
		ui.open()

/obj/machinery/photocopier/faxmachine/ui_data(mob/user)
	var/data = ..()
	var/is_authenticated = is_authenticated(user)

	data["authenticated"] = authenticated
	data["network"] = is_authenticated ? fax_network : null
	if(obj_flags & EMAGGED)
		data["network"] = "ERR*?*%!*"
	if(paper_copy)
		data["paper"] = paper_copy.name
		data["paperinserted"] = TRUE
	else if(photo_copy)
		data["paper"] = photo_copy.name
		data["paperinserted"] = TRUE
	else if(document_copy)
		data["paper"] = document_copy.name
		data["paperinserted"] = TRUE
	else
		data["paper"] = "-----"
		data["paperinserted"] = FALSE
	data["destination"] = destination ? destination : "Not Selected"
	data["cooldown"] = sendcooldown
	if((destination in admin_departments) || (destination in hidden_admin_departments))
		data["respectcooldown"] = TRUE
	else
		data["respectcooldown"] = FALSE

	return data

/obj/machinery/photocopier/faxmachine/ui_act(action, params)
	. = ..()
	if (.)
		return

	var/is_authenticated = is_authenticated(usr)
	switch(action)
		if("send")
			if((paper_copy || photo_copy || document_copy) && is_authenticated)
				if((destination in admin_departments) || (destination in hidden_admin_departments))
					send_admin_fax(usr, destination)
				else
					sendfax(destination,usr)

				if(sendcooldown)
					addtimer(CALLBACK(src, .proc/handle_cooldown, action, params), sendcooldown)

		if("paper")
			if(paper_copy)
				remove_photocopy(paper_copy, usr)
				paper_copy = null
			else if(photo_copy)
				remove_photocopy(photo_copy, usr)
				photo_copy = null
			else if(document_copy)
				remove_photocopy(document_copy, usr)
				document_copy = null
			else
				to_chat(usr, "<span class='notice'>There's nothing in the tray.</span>")
		if("dept")
			if(is_authenticated)
				var/lastdestination = destination
				var/list/combineddepartments = GLOB.alldepartments.Copy()
				if(long_range_enabled)
					combineddepartments += admin_departments.Copy()

				if(obj_flags & EMAGGED)
					combineddepartments += hidden_admin_departments.Copy()

				destination = input(usr, "To which department?", "Choose a department", "") as null|anything in combineddepartments
				if(!destination)
					destination = lastdestination
		if("auth")
			if(!is_authenticated)
				if(check_access(usr.get_idcard(FALSE)))
					var/obj/item/card/id/I = usr.get_idcard(FALSE)
					authenticated = "[I.registered_name] ([I.assignment])"
			else if(is_authenticated)
				authenticated = null
		if("rename")
			if(paper_copy || photo_copy)
				var/obj/to_rename = paper_copy ? paper_copy : photo_copy
				var/n_name = sanitize(copytext(input(usr, "What would you like to label the fax?", "Fax Labelling", to_rename.name)  as text, 1, MAX_MESSAGE_LEN))
				if(usr.stat == 0)
					to_rename.name = "[(n_name ? text("[n_name]") : to_rename.name)]"

/obj/machinery/photocopier/faxmachine/proc/handle_cooldown(action, params)
	sendcooldown = 0

/obj/machinery/photocopier/faxmachine/proc/is_authenticated(mob/user)
	if(authenticated)
		return TRUE
	else if(isAdminGhostAI(user))
		return TRUE
	return FALSE

/obj/machinery/photocopier/faxmachine/proc/sendfax(destination, mob/sender)
	if(machine_stat & (BROKEN|NOPOWER))
		return
	if(!length(paper_copy?.info)) //doesn't get called if there's no paper inserted
		visible_message("<span class='notice'>[src] beeps, \"The supplied paper is blank. Aborting.\"</span>")
		return FALSE

	use_power(200)

	var/success = FALSE
	var/obj/to_send = paper_copy ? paper_copy : photo_copy ? photo_copy : document_copy
	for(var/thing in GLOB.allfaxes)
		var/obj/machinery/photocopier/faxmachine/F = thing
		if(F.department == destination)
			success = F.receivefax(to_send)
	if(success != FALSE && department != destination)
		var/datum/fax/F = new /datum/fax()
		F.name = to_send.name
		F.from_department = department
		F.to_department = destination
		F.origin = src
		F.message = to_send
		F.sent_by = sender
		F.sent_at = world.time
		visible_message("<span class='notice'>[src] beeps, \"Message transmitted successfully.\"</span>")

	else if(destination == department)
		visible_message("<span class='notice'>[src] beeps, \"Error transmitting message. [src] cannot send faxes to itself.\"</span>")
	else if(destination == "Not Selected")
		visible_message("<span class='notice'>[src] beeps, \"Error transmitting message. Select a destination.\"</span>")
	else if(destination == "Unknown")
		visible_message("<span class='notice'>[src] beeps, \"Error transmitting message. Cannot transmit to Unknown.\"</span>")
	else
		visible_message("<span class='notice'>[src] beeps, \"Error transmitting message.\"</span>")

/obj/machinery/photocopier/faxmachine/proc/receivefax(obj/item/incoming)
	if(machine_stat & (BROKEN|NOPOWER))
		return FALSE

	if(department == "Unknown" || department == destination)
		return FALSE	//You can't send faxes to "Unknown" or yourself

	addtimer(CALLBACK(src, .proc/handle_copying, incoming), 10)

/obj/machinery/photocopier/faxmachine/do_copy_loop(datum/callback/copy_cb, mob/user, obj/item/tocopy)
	..()
	handle_animation()

//Prevents copypasta for evil faxes
/obj/machinery/photocopier/faxmachine/proc/handle_animation()
	flick(print_anim, src)
	playsound(loc, 'sound/machines/printer.ogg', 50, 1)

/obj/machinery/photocopier/faxmachine/proc/handle_copying(obj/item/incoming)
	use_power(active_power_usage)
	if(istype(incoming, /obj/item/paper))
		if(istype(incoming, /obj/item/paper/contract/employment))
			do_copy_loop(CALLBACK(src, .proc/make_devil_paper_copy, incoming), usr, TRUE)
			return TRUE
		do_copy_loop(CALLBACK(src, .proc/make_paper_copy, incoming), usr, TRUE)
	else if(istype(incoming, /obj/item/photo))
		do_copy_loop(CALLBACK(src, .proc/make_photo_copy, incoming), usr, TRUE)
	else if(istype(incoming, /obj/item/documents))
		do_copy_loop(CALLBACK(src, .proc/make_document_copy, incoming), usr, TRUE)
	else
		return FALSE

	return TRUE

/obj/machinery/photocopier/faxmachine/proc/send_admin_fax(mob/sender, destination)
	if(machine_stat & (BROKEN|NOPOWER))
		return
	if(sendcooldown)
		return

	use_power(200)

	var/obj/item/to_send
	if(paper_copy)
		to_send = make_paper_copy()
	else if(photo_copy)
		to_send = make_photo_copy()
	else if(document_copy)
		to_send = make_document_copy()

	to_send.moveToNullspace()

	var/datum/fax/admin/A = new /datum/fax/admin()
	A.name = to_send.name
	A.from_department = department
	A.to_department = destination
	A.origin = src
	A.message = to_send
	A.sent_by = sender
	A.sent_at = world.time

	//message badmins that a fax has arrived
	switch(destination)
		if("Central Command")
			send_to_admins(sender, "CENTCOM FAX", destination, to_send, "#006100")
		if("Syndicate")
			send_to_admins(sender, "SYNDICATE FAX", destination, to_send, "#DC143C")
	sendcooldown = cooldown_time
	visible_message("<span class='notice'>[src] beeps, \"Message transmitted successfully.\"</span>")


/obj/machinery/photocopier/faxmachine/proc/send_to_admins(mob/sender, faxname, faxtype, obj/item/sent, font_colour="#9A04D1")
	var/msg = "<span class='boldnotice'><font color='[font_colour]'>[faxname]: </font> [ADMIN_LOOKUP(sender)] | REPLY: [ADMIN_CENTCOM_REPLY(sender)] [ADMIN_FAX(sender, src, faxtype, sent)] [ADMIN_SM(sender)] | REJECT: (<A HREF='?_src_=holder;[HrefToken(TRUE)];FaxReplyTemplate=[REF(sender)];originfax=[REF(src)]'>TEMPLATE</A>) [ADMIN_SMITE(sender)]</span>: Receiving '[sent.name]' via secure connection... <a href='?_src_=holder;[HrefToken(TRUE)];AdminFaxView=[REF(sent)]'>view message</a>"
	if(istype(sent, /obj/item/paper))
		var/obj/item/paper/paper = sent
		SSredbot.send_discord_message("admin", "New [faxname]  ([paper.name]) Sent by [sender]: [strip_booktext(paper.info, 30)]")
	else
		SSredbot.send_discord_message("admin", "New [faxname] ([sent.name]) Sent by [sender].")
	message_admins(msg)
