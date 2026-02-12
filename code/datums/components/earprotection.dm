/datum/component/wearertargeting/earprotection
	signals = list(COMSIG_CARBON_SOUNDBANG)
	mobtype = /mob/living/carbon
	proctype = PROC_REF(reducebang)
	var/protection_amount //how much soundbang intensity we're reducing

/datum/component/wearertargeting/earprotection/Initialize(_valid_slots, _protection_amount  = 1)
	. = ..()
	valid_slots = _valid_slots
	protection_amount = _protection_amount

/datum/component/wearertargeting/earprotection/proc/reducebang(datum/source, list/reflist)
	reflist[1] = reflist[1] - protection_amount
