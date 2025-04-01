/**
 * THE GUESTBOOK DATUM // ripped straight from mojave.
 *
 * Essentially, this datum handles the people that a given human knows,
 * to handle getting the correct names on examine and saycode.
 */
/datum/guestbook
	/// Associative list of known guests, real_name = known_name
	var/list/known_names

/datum/guestbook/Destroy(force)
	known_names = null
	return ..()

/datum/guestbook/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Guestbook", "[user.real_name]'s Guestbook")
		ui.set_autoupdate(FALSE)
		ui.open()

/datum/guestbook/ui_state(mob/user)
	return GLOB.always_state

/datum/guestbook/ui_data(mob/user)
	var/list/data = list()
	var/list/names = list()
	for(var/real_name in known_names)
		var/given_name = LAZYACCESS(known_names, real_name)
		names += list(list("real_name" = real_name, "given_name" = given_name))
	data["names"] = names
	return data

/datum/guestbook/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return .
	switch(action)
		if("rename_guest")
			var/real_name = params["real_name"]
			var/new_name = params["new_name"]
			new_name = reject_bad_name(new_name, max_length = 42)
			if(!new_name)
				to_chat(usr, span_warning("That's a pretty terrible name. <i>You can do better</i>."))
				return FALSE
			if(!rename_guest(usr, null, real_name, new_name, silent = FALSE))
				return FALSE
			return TRUE
		if("delete_guest")
			var/real_name = params["real_name"]
			if(!remove_guest(usr, null, real_name, silent = FALSE))
				return FALSE
			return TRUE

/datum/guestbook/proc/try_add_guest(mob/user, mob/living/carbon/human/guest, silent = FALSE)
	if(user == guest)
		if(!silent)
			to_chat(user, span_warning("That's you! You already know yourself plenty."))
		return FALSE
	if(!visibility_checks(user, guest, silent))
		return FALSE
	var/given_name = input(user, "What name do you want to give to [guest]?", "Guestbook Name", guest.get_visible_name())
	if(!given_name)
		if(!silent)
			to_chat(user, span_warning("Nevermind."))
		return FALSE
	given_name = reject_bad_name(given_name)
	if(!given_name)
		if(!silent)
			to_chat(user, span_warning("That's a pretty terrible name."))
		return FALSE
	if(!visibility_checks(user, guest, silent))
		return FALSE
	var/face_name = guest.get_face_name("ForgetMeNot")
	if(LAZYACCESS(known_names, face_name))
		if(!rename_guest(user, guest, face_name, given_name, silent))
			return FALSE
	else
		if(!add_guest(user, guest, face_name, given_name, silent))
			return FALSE
	return TRUE

/datum/guestbook/proc/add_guest(mob/user, mob/living/carbon/guest, real_name, given_name, silent = TRUE)
	//Already exists, should be handled by rename_guest()
	var/existing_name = LAZYACCESS(known_names, real_name)
	if(existing_name)
		if(!silent)
			to_chat(user, span_warning("You already know them as \"[existing_name]\"."))
		return FALSE
	LAZYADDASSOC(known_names, real_name, given_name)
	if(!silent)
		to_chat(user, span_notice("You memorize the face of [guest] as \"[given_name]\"."))
	return TRUE

/datum/guestbook/proc/rename_guest(mob/user, mob/living/carbon/guest, real_name, given_name, silent = TRUE)
	var/old_name = LAZYACCESS(known_names, real_name)
	if(!old_name)
		return FALSE
	known_names[real_name] = given_name
	if(!silent)
		to_chat(user, span_notice("You re-memorize the face of \"[old_name]\" as \"[given_name]\"."))
	return TRUE

/datum/guestbook/proc/try_remove_guest(mob/user, mob/living/carbon/human/guest, silent = FALSE)
	if(user == guest)
		if(!silent)
			to_chat(user, span_warning("That's you! You'll never forget yourself."))
		return
	if(!visibility_checks(user, guest, silent))
		return FALSE
	var/face_name = guest.get_face_name("ForgetMeNot")
	if(!remove_guest(user, guest, face_name, silent))
		return FALSE
	return TRUE

/datum/guestbook/proc/remove_guest(mob/user, mob/living/carbon/guest, real_name, silent = TRUE)
	//Already exists, should be handled by rename_guest()
	var/existing_name = LAZYACCESS(known_names, real_name)
	if(!existing_name)
		if(!silent)
			to_chat(user, span_warning("You don't know them in the first place."))
		return FALSE
	LAZYREMOVE(known_names, real_name)
	if(!silent)
		to_chat(user, span_notice("You forget the face of \"[existing_name]\"."))
	return TRUE

/datum/guestbook/proc/get_known_name(mob/user, mob/living/carbon/guest, real_name)
	if(user == guest || isAdminObserver(user))
		return real_name
	return LAZYACCESS(known_names, real_name)

/datum/guestbook/proc/visibility_checks(mob/user, mob/living/carbon/human/guest, silent = FALSE)
	if(QDELETED(guest))
		if(!silent)
			to_chat(user, span_warning("What?"))
		return FALSE
	var/visible_name = guest.get_visible_name("")
	var/face_name = guest.get_face_name("")
	if(!visible_name || !face_name)
		if(!silent)
			to_chat(user, span_warning("You can't see their face very well!"))
		return FALSE
	if(get_dist(user, guest) > 4)
		if(!silent)
			to_chat(user, span_warning("You need to take a closer look at them!"))
		return FALSE
	return TRUE
