/datum/element/rename_on_login

/datum/element/rename_on_login/Attach(mob/target)
	.=..()
	if(!ismob(target))
		return ELEMENT_INCOMPATIBLE
	if(target.client)
		rename_mob(target)
		target.RemoveElement(/datum/element/rename_on_login)
	else
		RegisterSignal(target, COMSIG_MOB_LOGIN, .proc/on_mob_login)

/datum/element/rename_on_login/proc/on_mob_login(mob/source)
	SIGNAL_HANDLER
	INVOKE_ASYNC(src, .proc/rename_mob, source)
	UnregisterSignal(source, COMSIG_MOB_LOGIN)
	source.RemoveElement(/datum/element/rename_on_login)

/datum/element/rename_on_login/proc/rename_mob(mob/target)
	var/newname = reject_bad_text(
		stripped_input(usr, "Set your name. You only get to do this once. Max 52 chars.", "Name set", "", MAX_NAME_LEN)
	)
	if(newname)
		target.name = newname
