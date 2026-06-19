/datum/job/ert
	name = "Emergency Response Team Member"
	auto_deadmin_role_flags = DEADMIN_POSITION_SECURITY
	minimal_player_age = 7
	wiki_page = "Space_Law" //WS Edit - Wikilinks/Warning

	outfit = /datum/outfit/job/independent/ert

	access = list()
	minimal_access = list()
	var/region_access

/datum/job/ert/get_access()
	var/list/accesses
	accesses += get_all_centcom_access()
	accesses += get_region_accesses(REGION_ACCESS_COMMAND)
	if(region_access)
		accesses += get_region_accesses(accesses)
	return accesses

/datum/job/ert/commander
	name = "Emergency Response Team Commander"
	region_access = REGION_ACCESS_ALL

/datum/job/ert/sec
	name = "Emergency Response Team Security Specialist"
	region_access = REGION_ACCESS_SEC

/datum/job/ert/med
	name = "Emergency Response Team Medical Specialist"
	region_access = REGION_ACCESS_MED

/datum/job/ert/engi
	name = "Emergency Response Team Engineering Specialist"
	region_access = REGION_ACCESS_ENGI

