/datum/ship_application
	/// The ship this application is linked to.
	var/datum/overmap/ship/controlled/parent_ship
	/// The applicant's new player mob. We keep track of it to send them an update message if they haven't joined a ship yet.
	var/mob/dead/new_player/app_mob
	/// The character name of the applicant at the time they applied. Isn't involved in the application logic,
	/// but it's nice to have, in case the ship owner recognizes the name but not the key.
	var/app_name
	/// The applicant's key. Comparisons are done using ckeys to ensure consistence, but we store the key so
	/// that the application message is formatted more nicely. If the application is made by a stealthmin,
	/// it's their fakekey instead.
	var/app_key
	/// The extra message sent by the applicant.
	var/app_msg
	/// The application's status -- whether or not it has been accepted, rejected, or hasn't been answered yet.
	var/status = SHIP_APPLICATION_PENDING

/datum/ship_application/New(datum/overmap/ship/controlled/parent, mob/dead/new_player/applicant, msg)
	parent_ship = parent
	app_mob = applicant
	app_name = app_mob.client?.prefs.real_name
	// If the admin is in stealth mode, we use their fakekey.
	app_key = app_mob.client?.holder?.fakekey ? app_mob.client.holder.fakekey : applicant.key
	app_msg = msg
	RegisterSignal(app_mob, COMSIG_PARENT_QDELETING, .proc/applicant_deleting)

	LAZYSET(parent_ship.applications, ckey(app_key), src)
	if(parent_ship.owner_mob == null || parent_ship.owner_mind == null)
		return

	// don't need to use check_blinking, because it DAMN well better be blinking now that we exist
	parent_ship.owner_act.set_blinking(TRUE)

	SEND_SOUND(parent_ship.owner_mob, sound('sound/misc/server-ready.ogg', volume=50))
	var/message = \
		"<span class='looc'>[app_key] (as [app_name]) applied to your ship: [app_msg]\n" + \
		"<a href=?src=[REF(src)];application_accept=1>(ACCEPT)</a> / <a href=?src=[REF(src)];application_deny=1>(DENY)</a></span>"
	to_chat(parent_ship.owner_mob, message, MESSAGE_TYPE_INFO)

/datum/ship_application/Destroy()
	LAZYREMOVE(parent_ship.applications, ckey(app_key))
	if(app_mob)
		SEND_SOUND(app_mob, sound('sound/misc/server-ready.ogg', volume=50))
		to_chat(app_mob, "<span class='warning'>Your application to [parent_ship] has been deleted.</span>", MESSAGE_TYPE_INFO)
	app_mob = null
	parent_ship = null
	. = ..()

/datum/ship_application/Topic(href, href_list)
	. = ..()
	if(href_list["application_accept"])
		application_status_change(SHIP_APPLICATION_ACCEPTED)
	else if(href_list["application_deny"])
		application_status_change(SHIP_APPLICATION_DENIED)

/datum/ship_application/proc/application_status_change(new_status)
	// no alternating accept / deny spam
	if(status != SHIP_APPLICATION_PENDING)
		return
	status = new_status
	to_chat(usr, "<span class='notice'>Application [status].</span>", MESSAGE_TYPE_INFO)

	if(parent_ship.owner_act)
		parent_ship.owner_act.check_blinking()

	if(!app_mob)
		return
	SEND_SOUND(app_mob, sound('sound/misc/server-ready.ogg', volume=50))
	switch(status)
		if(SHIP_APPLICATION_ACCEPTED)
			to_chat(app_mob, "<span class='notice'>Your application to [parent_ship] was accepted!</span>", MESSAGE_TYPE_INFO)
		if(SHIP_APPLICATION_DENIED)
			to_chat(app_mob, "<span class='warning'>Your application to [parent_ship] was denied!</span>", MESSAGE_TYPE_INFO)

/datum/ship_application/proc/applicant_deleting()
	SIGNAL_HANDLER
	UnregisterSignal(app_mob, COMSIG_PARENT_QDELETING)
	app_mob = null
