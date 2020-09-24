/datum/mentor_click_interceptor
/datum/mentor_click_interceptor/proc/InterceptClickOn(mob/user, params, atom/target)
	return TRUE

/client/proc/mentor_follow(mob/living/M)
	if(!check_mentor())
		return

	if(isnull(M))
		return

	if(!istype(usr, /mob))
		return

	if(!holder)
		var/datum/mentors/mentor = GLOB.mentor_datums[usr.client.ckey]
		mentor.following = M
	else
		holder.following = M

	if(check_rights(R_ADMIN, 0))
		var/client/C = usr.client
		var/can_ghost = TRUE
		if(!isobserver(usr))
			can_ghost = C.admin_ghost()

		if(!can_ghost)
			return
		var/mob/dead/observer/A = C.mob
		A.ManualFollow(M)
		return

	usr.reset_perspective(M)
	usr.client.click_intercept = new /datum/mentor_click_interceptor
	usr.client.mob.notransform = TRUE
	src.verbs += /client/proc/mentor_unfollow

	to_chat(GLOB.admins, "<span class='mentor'><span class='prefix'>MENTOR:</span> <EM>[key_name(usr)]</EM> is now following <EM>[key_name(M)].</span>")
	to_chat(usr, "<span class='info'>You are now following [M]. Click the \"Stop Following\" button in the Mentor tab to stop.</span>")
	log_mentor("[key_name(usr)] began following [key_name(M)].")

/client/proc/mentor_unfollow()
	set category = "Mentor"
	set name = "Stop Following"
	set desc = "Stop following the followed."

	if(!check_mentor())
		return

	usr.reset_perspective(null)
	usr.client.click_intercept = null
	usr.client.mob.notransform = FALSE
	src.verbs -= /client/proc/mentor_unfollow

	var/following = null
	if(!holder)
		var/datum/mentors/mentor = GLOB.mentor_datums[usr.client.ckey]
		following = mentor.following
	else
		following = holder.following


	to_chat(GLOB.admins, "<span class='mentor'><span class='prefix'>MENTOR:</span> <EM>[key_name(usr)]</EM> is no longer following <EM>[key_name(following)].</span>")
	to_chat(usr, "<span class='info'>You are no longer following [following].</span>")
	log_mentor("[key_name(usr)] stopped following [key_name(following)].")

	following = null
