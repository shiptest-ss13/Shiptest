/datum/ship_application
	/// The ship this application is linked to.
	var/datum/overmap/ship/controlled/parent_ship
	/// The applicant's new player mob. Kept so we can cancel the fill-out if they leave the lobby mid-write.
	var/mob/dead/new_player/app_mob
	/// String of the applicant's actual ckey. We'll use this later to reference the client, so we can
	/// send the notification regardless of mob status. Not using app_key because that can be faked.
	var/app_ckey
	/// Whether to expose the user's key to the application recipient. Even if this is false, we still store apps using the key.
	var/show_key = FALSE
	/// The character name of the applicant at the time they applied. Isn't involved in the application logic,
	/// but it's nice to have, in case the ship owner recognizes the name but not the key.
	var/app_name
	/// The applicant's key. Comparisons are done using ckeys to ensure consistence, but we store the key so
	/// that if we send it in the application message it's in a format that might be more familiar to the recipient.
	var/app_key
	/// Name of the role the applicant picked when they applied. Display only, they still pick their role
	/// freely after being accepted, but this is informative for the cap still
	var/app_job
	/// The extra message sent by the applicant.
	var/app_msg
	/// The application's status -- whether or not it has been accepted, rejected, or hasn't been answered yet.
	var/status = SHIP_APPLICATION_UNFINISHED

/datum/ship_application/New(mob/dead/new_player/applicant, datum/overmap/ship/controlled/parent, datum/job/applied_job)
	// If the admin is in stealth mode, we use their fakekey.
	app_mob = applicant
	app_name = app_mob.client?.prefs.real_name
	app_key = app_mob.client?.holder?.fakekey ? app_mob.client.holder.fakekey : applicant.key
	app_ckey = applicant.ckey
	parent_ship = parent
	app_job = applied_job?.name

	// these are registered so we can cancel the application fill-out if the ship
	// gets deleted before the application is finalized, or the character spawns in.
	// your currently-open tgui windows don't get removed if you spawn into a body
	RegisterSignal(app_mob, COMSIG_QDELETING, PROC_REF(applicant_deleting))
	RegisterSignal(parent_ship, COMSIG_QDELETING, PROC_REF(important_deleting_during_apply))

/datum/ship_application/Destroy()
	SStgui.close_uis(src)
	if(status != SHIP_APPLICATION_UNFINISHED && status != SHIP_APPLICATION_CANCELLED)
		LAZYREMOVE(parent_ship.applications, ckey(app_key))
		var/client/app_client = get_applicant_client()
		if(app_client && applicant_can_act(app_client))
			SEND_SOUND(app_client, sound('sound/misc/server-ready.ogg', volume=50))
			to_chat(app_client, span_warning("Your application to [parent_ship] has been deleted."), MESSAGE_TYPE_INFO)
	app_mob = null
	parent_ship = null
	. = ..()

/datum/ship_application/proc/get_user_response()
	ui_interact(app_mob)
	// wait for the user to either write the application or cancel
	while(status == SHIP_APPLICATION_UNFINISHED)
		stoplag(1)

	if(status == SHIP_APPLICATION_CANCELLED)
		qdel(src)
		return FALSE

	// we are now ready to finalize
	// unregister the ship qdel signal -- we add ourselves to the ship's applications, and it qdels us
	// when it deletes, so we don't need to worry about that anymore. we keep the applicant deletion signal
	UnregisterSignal(parent_ship, COMSIG_QDELETING)
	LAZYSET(parent_ship.applications, ckey(app_key), src)

	if(parent_ship.owner_mob != null)
		// don't need to use check_blinking, because it DAMN well better be blinking now that we exist
		parent_ship.owner_act.set_blinking(TRUE)
		SEND_SOUND(parent_ship.owner_mob, sound('sound/misc/server-ready.ogg', volume=50))
		var/message = \
			"<span class='looc'>[app_name] [show_key ? "([app_key]) " : null]applied to your ship: [app_msg]\n" + \
			"<a href=?src=[REF(src)];application_accept=1>(ACCEPT)</a> / <a href=?src=[REF(src)];application_deny=1>(DENY)</a></span>"
		to_chat(parent_ship.owner_mob, message, MESSAGE_TYPE_INFO)
	return TRUE

/datum/ship_application/proc/get_applicant_client()
	return GLOB.directory[app_ckey]

/// Only notify if they're in lobby or observing.
/// Assumes otherwise that they've already spawned in and shouldn't be notified anymore
/datum/ship_application/proc/applicant_can_act(client/app_client)
	return isnewplayer(app_client.mob) || isobserver(app_client.mob)

/datum/ship_application/proc/applicant_deleting()
	SIGNAL_HANDLER
	if(status == SHIP_APPLICATION_UNFINISHED)
		return important_deleting_during_apply()
	UnregisterSignal(app_mob, COMSIG_QDELETING)
	app_mob = null

// we should get deleted soon, which clears up the references, since this can only fire if
// the applicant is in the midst of writing their application
/datum/ship_application/proc/important_deleting_during_apply()
	SIGNAL_HANDLER
	UnregisterSignal(parent_ship, COMSIG_QDELETING)
	UnregisterSignal(app_mob, COMSIG_QDELETING)
	status = SHIP_APPLICATION_CANCELLED

/datum/ship_application/ui_interact(mob/user, datum/tgui/ui)
	// ui only shows up when the application is being filled out
	if(status != SHIP_APPLICATION_UNFINISHED)
		return
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Application", "Application")
		ui.open()

/datum/ship_application/ui_close(mob/user)
	if(status == SHIP_APPLICATION_UNFINISHED)
		status = SHIP_APPLICATION_CANCELLED

/datum/ship_application/ui_state(mob/user)
	return GLOB.always_state

/datum/ship_application/ui_data(mob/user)
	. = list()
	.["ship_name"] = parent_ship.name
	.["player_name"] = app_name

/datum/ship_application/ui_act(action, list/params, datum/tgui/ui)
	. = ..()
	if(. || status != SHIP_APPLICATION_UNFINISHED)
		return

	switch(action)
		if("submit")
			status = SHIP_APPLICATION_PENDING
			show_key = !!params["ckey"]
			app_msg = copytext(sanitize(params["text"]), 1, 1024)
			SStgui.close_uis(src)
			return TRUE

		if("cancel")
			status = SHIP_APPLICATION_CANCELLED
			SStgui.close_uis(src)
			return TRUE

// Topic() for when the ship owner clicks on approve/deny in their chat window
/datum/ship_application/Topic(href, href_list)
	. = ..()
	if(usr != parent_ship.owner_mob)
		return

	if(href_list["application_accept"])
		application_status_change(SHIP_APPLICATION_ACCEPTED)
	else if(href_list["application_deny"])
		application_status_change(SHIP_APPLICATION_DENIED)

/datum/ship_application/proc/application_status_change(new_status)
	// no alternating accept / deny spam
	if(status != SHIP_APPLICATION_PENDING)
		return
	status = new_status
	to_chat(usr, span_notice("Application [status]."), MESSAGE_TYPE_INFO)

	if(parent_ship.owner_act)
		parent_ship.owner_act.check_blinking()

	var/client/app_client = get_applicant_client()
	if(!app_client || !applicant_can_act(app_client))
		return

	switch(status)
		if(SHIP_APPLICATION_ACCEPTED)
			// they may have gone off to observe while waiting, in which case they need to come back to join
			var/lobby_hint = isnewplayer(app_client.mob) ? null : " Return to the lobby to join."
			to_chat(app_client, span_notice("Your application to [parent_ship] was accepted![lobby_hint]"), MESSAGE_TYPE_INFO)
			SEND_SOUND(app_client, sound('sound/misc/server-ready.ogg', volume=50))
		if(SHIP_APPLICATION_DENIED)
			to_chat(app_client, span_warning("Your application to [parent_ship] was denied!"), MESSAGE_TYPE_INFO)
			SEND_SOUND(app_client, sound('sound/machines/buzz-sigh.ogg', volume=50))
