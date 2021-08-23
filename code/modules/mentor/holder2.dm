GLOBAL_LIST_EMPTY(mentor_datums)
GLOBAL_PROTECT(mentor_datums)

/datum/mentors
	var/client/owner = null
	var/target
	var/following = null

/datum/mentors/New(ckey)
	if(!ckey)
		del(src)
		return
	GLOB.mentor_datums[ckey] = src

/datum/mentors/proc/associate(client/C)
	if(istype(C))
		if(C.ckey != target)
			message_admins("[C] attempted to assosciate with the mentor datum of [target]!")
			return
		owner = C
		GLOB.mentors |= C
		owner.add_mentor_verbs()

/datum/mentors/proc/disassociate()
	if(owner)
		GLOB.mentors -= owner
		owner.remove_mentor_verbs()
		owner = null

/proc/check_mentor()
	if(usr && usr.client)
		var/mentor = GLOB.mentor_datums[usr.client.ckey]
		if(mentor || check_rights(R_ADMIN,0) || check_rights(R_MENTOR,0))
			return TRUE

	return FALSE

/proc/check_mentor_other(var/client/C)
	if(C)
		var/mentor = GLOB.mentor_datums[C.ckey]
		if(C.holder && C.holder.rank)
			if(C.holder.rank.rights & R_ADMIN)
				return TRUE
		else if(mentor)
			return TRUE
	return FALSE
