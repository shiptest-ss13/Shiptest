/datum/component/heirloom
	var/datum/mind/owner
	var/family_name

/datum/component/heirloom/Initialize(new_owner, new_family_name)
	if(!isitem(parent))
		return COMPONENT_INCOMPATIBLE

	owner = new_owner
	family_name = new_family_name

	RegisterSignal(parent, COMSIG_PARENT_EXAMINE, .proc/examine)

/datum/component/heirloom/proc/examine(datum/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	if(user.mind == owner)
		examine_list += "<span class='notice'>It is precious and beloved. Keep it safe!</span>"
	else
		examine_list += "<span class='danger'>You can tell [owner] really cares about this!</span>"
